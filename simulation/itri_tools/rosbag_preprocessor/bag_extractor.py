import rosbag
import os
import time
import datetime
import json
import traceback
import sys
import shutil
import argparse

from target_topics import TARGET_TOPICS


"""
{
	"merge_result": {
		"merged_new_path_of_origin_bag_path_11": {
			"bags": [origin_bag_path_11, origin_bag_path_12, ...],
			"merge_check": True,
			"first_stamp": first_stamp1,
			"last_stamp": last_stamp1
		},
		"merged_new_path_of_origin_bag_name_21": {
			"bags": [origin_bag_path_21, origin_bag_path_22, ...],
			"merge_check": True,
			"first_stamp": first_stamp2,
			"last_stamp": last_stamp2
		},
		"merged_new_path_of_origin_bag_path_31": {
			"bags": [origin_bag_path_21],
			"first_stamp": first_stamp3,
			"last_stamp": last_stamp3
		}
	},
	"bag_info": {
		"origin_bag_path1": {
			"new_path": new_path1,
			"first_stamp": first_stamp1
			"last_stamp": last_stamp1,
			"processed": true
		},
		"origin_bag_path2": {
			"new_path": new_path2,
			"first_stamp": first_stamp1,
			"last_stamp": last_stamp2,
			"processed": true
		}
	}
}
"""

def parse_args():
	parser = argparse.ArgumentParser()
	parser.add_argument("-f", "--from-folder"  , type=str, default="downloaded_bags", help="Assign a folder that contains downloaded bags.")
	parser.add_argument("-t", "--to-folder"    , type=str, default="processed_bags" , help="Assign a folder to save processed bags.")
	parser.add_argument("-r", "--record_json"  , type=str, default="bag_process_record.json" , help="Assign a file to record process progress.")
	parser.add_argument("-p", "--pick-up-only" , action="store_true", help="Only pick up unexpectedly terminated results.")
	args = parser.parse_args()
	return args

class BagExtractor:
	def __init__(self, args):
		self._args = args
		assert os.path.isdir(self._args.from_folder)
		self._process_folder = self._args.to_folder

		self._bag_process_record = None
		self._load_bag_process_record()


	def run_from_folder(self):
		if not os.path.isdir(self._args.to_folder):
			os.mkdir(self._args.to_folder)

		name_list = []
		for dir_path, dir_names, file_names in os.walk(self._args.from_folder):
			for filename in file_names:
				file_path = os.path.join(dir_path, filename)
				if file_path in self._bag_process_record["bag_info"].keys():
					if self._bag_process_record["bag_info"][file_path]["processed"]:
						print(f"{filename} already exists in {self._args.to_folder}. pass.")
						continue
					else:
						print(f"{filename} seems to be terminated unexpectedly during last extraction.")
				if filename.endswith(".bag"):
					name_list.append(file_path)

		name_list.sort()
		for file_path in name_list:
			bag_name = file_path.split("/")[-1]
			new_path = self._args.to_folder + "/" + bag_name
			self.process_bag(file_path, new_path)


	def pick_up_last_unexpectedly_ended_merge_or_extract_bags(self):
		"""
		Function to pick up the last record.

		NOTE:
			If an extraction was terminated unexpectedly previously,
				this function will check the record json file and make things right.
		"""
		self._load_bag_process_record()

		bag_path_key_to_remove = []
		for bag_path, bag_info in self._bag_process_record["bag_info"].items():
			if not bag_info["processed"]:
				new_path = bag_info["new_path"]
				try:
					os.remove(new_path)
					print(f"[BagExtractor PickUp] Remove extracted bag {new_path} which was stopped unexpectedly during extraction before.")
				except FileNotFoundError:
					print(f"[BagExtractor PickUp] Extracted bag {new_path} not founded. Skip remove.")
				bag_path_key_to_remove.append(bag_path)

		for bag_path_key in bag_path_key_to_remove:
			new_path = self._bag_process_record["bag_info"][bag_path_key]["new_path"]
			if new_path in self._bag_process_record["merge_result"].keys():
				if len(self._bag_process_record["merge_result"][new_path]["bags"]) == 1:
					del self._bag_process_record["merge_result"][new_path]
					del self._bag_process_record["bag_info"][bag_path_key]
				else:
					assert new_path in self._bag_process_record["merge_result"].keys()
					merge_info = self._bag_process_record["merge_result"][new_path]
					assert merge_info["merge_check"] is False
					assert os.path.isfile(new_path + ".tmp"), ""\
						f"[BagExtractor PickUp] Can't find merge_bag tmp file {new_path}.tmp. Pick up failed."
					print(f"[BagExtractor PickUp] Rename {new_path}.tmp to {new_path} which was stopped unexpectedly before.")
					os.rename(new_path + ".tmp", new_path)
					last_merged = self._bag_process_record["merge_result"][new_path]["bags"].pop()
					self._bag_process_record["merge_result"][new_path]["merge_check"] = True
					del self._bag_process_record["bag_info"][last_merged]
		self._update_bag_process_record()


	def process_bag(self, bag_path, new_path):
		"""
		Function to process a single bag located at bag_path.

		NOTE:
			The new_path is a temporary name,
				if the bag is to be merged,
				it will take the merged bag as new_path rether than this on passed in.
			The frequently called _update_bag_process_record() is to make sure that
				the record file keeps the latest progress
		"""

		try:
			self._load_bag_process_record()
			is_merge_case = False
			pure_bag_name = f"{bag_path.split('/')[-1]}"
			bag = rosbag.Bag(bag_path, mode="r")

			date_time = datetime.datetime.now().strftime("%Y/%m/%d, %H:%M:%S")
			print(f"[BagExtractor] [{date_time}] Extracting from bag {bag_path}")

			start_time = bag.get_start_time()
			end_time = bag.get_end_time()
			self._bag_process_record["bag_info"][bag_path] = {
				"new_path": None,
				"first_stamp": start_time,
				"last_stamp": end_time,
				"processed": False
			}
			self._update_bag_process_record()

			# Check for bag continuation, if another bag has close end_time, assume they were from same run.
			candidate_origin_path, candidate_info = self._check_continuation(bag_path, start_time)
			if candidate_origin_path:
				is_merge_case = True
				new_path = candidate_info["new_path"]
				candidate_bag_name = f"{new_path}"
				print(f"[BagExtractor]    >> Merging into {candidate_bag_name}")

				# Make a copy in case the process are terminated unexpectedly
				shutil.copyfile(candidate_info["new_path"], candidate_info["new_path"] + ".tmp")

				bag_to_write = rosbag.Bag(candidate_info["new_path"], "a")
				self._bag_process_record["bag_info"][bag_path]["new_path"] = new_path
				self._bag_process_record["merge_result"][new_path]["bags"].append(bag_path)
				self._bag_process_record["merge_result"][new_path]["merge_check"] = False
			else:
				self._bag_process_record["merge_result"][new_path] = {
					"bags": [bag_path],
					"first_stamp": start_time
				}
				self._bag_process_record["bag_info"][bag_path]["new_path"] = new_path
				bag_to_write = rosbag.Bag(new_path, mode="w")
			self._update_bag_process_record()

			# Main part that deal with tpoic extraction.
			for topic, msg, t in bag.read_messages(topics=TARGET_TOPICS):
				bag_to_write.write(topic, msg, t)

			if is_merge_case:
				self._load_bag_process_record()
				os.remove(candidate_info["new_path"] + ".tmp")
				self._bag_process_record["merge_result"][new_path]["merge_check"] = True

			# Modify the state after all processes are done. This makes sure that the record keeps the latest state of progress.
			self._bag_process_record["merge_result"][new_path]["last_stamp"] = end_time
			self._bag_process_record["bag_info"][bag_path]["processed"] = True
			self._update_bag_process_record()

			os.remove(bag_path)

		except rosbag.bag.ROSBagUnindexedException as e:
			if bag_path not in self._bag_process_record["unindexed"]:
				self._bag_process_record["unindexed"].append(bag_path)
				self._update_bag_process_record()
			print(f"\033[1;31m[BagExtractor] Unindexed bag {bag_path}. Pass\033[0m")

		except rosbag.bag.ROSBagException as e:
			if bag_path not in self._bag_process_record["other_exception"]:
				self._bag_process_record["other_exception"].append(bag_path)
				self._update_bag_process_record()
			print(f"\033[1;31m[BagExtractor] {e}. Pass\033[0m")

		except Exception as err:
			err_type = err.__class__.__name__
			info = err.args[0]
			detains = traceback.format_exc()
			n1, n2, n3 = sys.exc_info()
			lastCallStack =  traceback.extract_tb(n3)[-1]
			fn = lastCallStack [0]
			lineNum = lastCallStack[1]
			funcName = lastCallStack[2]
			errMesg = f"FileName: {fn}, lineNum: {lineNum}, Fun: {funcName}, reason: {info}, trace:\n {traceback.format_exc()}"
			print(f"\033[1;31m[BagExtractor] {errMesg}\033[0m")
		finally:
			try:
				bag.close()
			except Exception as e:
				pass
			try:
				bag_to_write.close()
			except Exception as e:
				pass


	def _check_continuation(self, bag_path, check_first_timestamp):
		"""
		TODO: Add in front.
		"""
		bag_name = bag_path.split("/")[-1]
		for candidate_original_path, candidate_info in self._bag_process_record["bag_info"].items():
			candidate_bag_name = candidate_original_path.split("/")[-1]
			if bag_name == candidate_bag_name: continue
			candidate_timestamp = candidate_info["last_stamp"]
			if check_first_timestamp - candidate_timestamp < 1.0 and check_first_timestamp > candidate_timestamp:
				candidate_new_path = candidate_info["new_path"]
				return candidate_original_path, candidate_info
		return None, None


	def _update_bag_process_record(self):
		with open(self._args.record_json, "w") as f:
			json.dump(self._bag_process_record, f, indent=4)


	def _load_bag_process_record(self):
		if os.path.isfile(self._args.record_json):
			with open(self._args.record_json, "r") as f:
				self._bag_process_record = json.load(f)
		else:
			self._bag_process_record = {
				"merge_result": {},
				"bag_info": {},
				"unindexed": [],
				"other_exception": []
			}
			self._update_bag_process_record()


if __name__ == '__main__':
	args = parse_args()
	be = BagExtractor(args)
	be.pick_up_last_unexpectedly_ended_merge_or_extract_bags()
	be.run_from_folder()