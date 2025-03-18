from __future__ import print_function
from copy import deepcopy
from typing import Optional
import os
import json
import rospy
from scenario_classification.msg \
    import ClassificationObject, ClassificationObjectArray
from sync.common.utils import get_scenario_ids, get_scenario_metadata
from sync.common.constants import DATA_ROOT
from tag_trees.utils import get_configs, SCENARIO_CATEGORIES_PATH, \
    get_tag_trees_outcome, tag_trees_integer_to_outcome

class Matcher():
    def __init__(self, loading_matched_samples=True, data_root=DATA_ROOT):
        # type: (Matcher, bool, str) -> None
        self._classification_objects_subscriber = rospy.Subscriber(
            "classification_objects", ClassificationObjectArray,
            self._classification_objects_callback)
        self._scenario_ids = get_scenario_ids()
        self._configs = get_configs(print_config=False)
        self._tracked = {}      # type: dict[str|int, ClassificationObject]
        self.scenario_categories = []   # type: list[dict]
        with open(SCENARIO_CATEGORIES_PATH, 'r') as json_file:
            self.scenario_categories = json.load(json_file)
        self.matched_category_indices = {}
        self.loaded_matched_samples = {
            "headers": [],
            "category_data": [[] for i in range(len(self.scenario_categories))]
        }
        if loading_matched_samples:
            self._load_scenario_categories_samples(data_root)

    def _load_scenario_categories_samples(self, data_root):
        record_times = [record_time for record_time in os.listdir(data_root)
                        if "itri" in record_time]
        record_times.sort()
        print("[Matcher] loading data from "
              "scenario_search_records folder...")
        data_info = {
            scenario_id: {
                "sample_counts": 0,
                "valued_sample_counts": 0,
                "collision_sample_counts": 0,
            } for scenario_id in self._scenario_ids
        }
        matched_data_info = [{
            "name": category['name'],
            "sample_counts": 0,
            "valued_sample_counts": 0,
            "collision_sample_counts": 0
        } for category in self.scenario_categories]
        for record_time in record_times:
            folder_path = os.path.join(data_root, record_time)
            result_csv_path = os.path.join(folder_path, "result.csv")
            samples_csv_path = os.path.join(folder_path, "samples.csv")
            if not os.path.exists(samples_csv_path) \
                    or not os.path.exists(result_csv_path):
                continue
            scenario_config_path = os.path.join(
                folder_path, "complete_configs/single_scenario_config0.json")
            metadata_json_path = os.path.join(
                folder_path, "metadata.json")
            scenario_metadata = {}  # type: dict[str, str]
            if os.path.exists(metadata_json_path):
                with open(metadata_json_path, 'r') as f:
                    scenario_metadata = json.load(f)
            elif os.path.exists(scenario_config_path):
                scenario_metadata = get_scenario_metadata(result_csv_path,
                                                          scenario_config_path, self._scenario_ids)
            else:
                continue
            scenario_id = scenario_metadata['scenario_id']
            with open(samples_csv_path, 'r') as csvfile:
                headers = []
                lines = [line.rstrip() for line in csvfile]
                line_number = 0
                visited_lines = [set() for index in range(len(
                    self.scenario_categories))]
                while line_number < len(lines):
                    row = lines[line_number].split(',')
                    if line_number == 0:
                        headers = row
                    else:
                        ego_tag_trees, actor_tag_trees = \
                            self._get_tag_trees_from_sample(row, headers)
                        matches = self._match(ego_tag_trees, actor_tag_trees)
                        data_info[scenario_id]['sample_counts'] += 1
                        value = float(row[headers.index('value_evaluation')])
                        if value == -1.0:
                            data_info[scenario_id][
                                'collision_sample_counts'] += 1
                        if value != 0.0:
                            data_info[scenario_id]['valued_sample_counts'] += 1
                        for index in matches:
                            if line_number in visited_lines[index]:
                                continue
                            visited_lines[index].add(line_number)
                            self.loaded_matched_samples['category_data'][
                                index].append(row)
                            matched_data_info[index]['sample_counts'] += 1
                            if value == -1.0:
                                matched_data_info[index][
                                    'collision_sample_counts'] += 1
                            if value != 0.0:
                                matched_data_info[index][
                                    'valued_sample_counts'] += 1
                            matched_next = True
                            next_line_number = line_number + 1
                            while matched_next \
                                    and next_line_number < len(lines):
                                next_row = lines[next_line_number].split(',')
                                ego_tag_trees, actor_tag_trees = \
                                    self._get_tag_trees_from_sample(next_row,
                                                                    headers)
                                next_matches = self._match(ego_tag_trees,
                                                           actor_tag_trees, without_initial_state=True)
                                if index in next_matches:
                                    visited_lines[index].add(next_line_number)
                                    self.loaded_matched_samples[
                                        'category_data'][index].append(next_row)
                                    next_line_number += 1
                                    value = float(next_row[
                                        headers.index('value_evaluation')])
                                    if value == -1.0:
                                        matched_data_info[index][
                                            'collision_sample_counts'] += 1
                                    if value != 0.0:
                                        matched_data_info[index][
                                            'valued_sample_counts'] += 1
                                else:
                                    matched_next = False
                    line_number += 1
        print("[Matcher] data info: ")
        for scenario_id, info in data_info.items():
            print("[Matcher]\tsimulator:")
            print("[Matcher]\t\tscenario_id: {}".format(scenario_id))
            print("[Matcher]\t\tsample_counts: {}".format(
                info['sample_counts']))
            print("[Matcher]\t\tcollision_sample_counts: {}".format(
                info['collision_sample_counts']))
            print("[Matcher]\t\tvalued_sample_counts: {}".format(
                info['valued_sample_counts']))
        for index, info in enumerate(matched_data_info):
            print("[Matcher]\tscenario category:")
            print("[Matcher]\t\tname: {} ".format(info['name']))
            print("[Matcher]\t\tsample_counts: {}".format(
                info['sample_counts']))
            print("[Matcher]\t\tcollision_sample_counts: {}".format(
                info['collision_sample_counts']))
            print("[Matcher]\t\tvalued_sample_counts: {}".format(
                info['valued_sample_counts']))

    def _get_tag_trees_from_sample(self, row, headers):
        ego_tag_trees_value = row[
            headers.index("ego_tag_trees")]
        if ego_tag_trees_value != "nan":
            ego_tag_trees_value = int(ego_tag_trees_value)
        else:
            ego_tag_trees_value = 0
        ego_tag_trees = tag_trees_integer_to_outcome(
            ego_tag_trees_value)
        actor_tag_trees_value = row[headers.index(
            "agent_tag_trees")]
        if actor_tag_trees_value != "nan":
            actor_tag_trees_value = int(actor_tag_trees_value)
        else:
            actor_tag_trees_value = 0
        actor_tag_trees = tag_trees_integer_to_outcome(
            actor_tag_trees_value)
        return ego_tag_trees, actor_tag_trees

    def _match_all_tracked(self):
        updated_matched = {}
        ego_tag_trees = tag_trees_integer_to_outcome(0)
        if "ego" in self._tracked:
            ego_tag_trees = get_tag_trees_outcome(
                self._tracked['ego'].tag_trees)
        for key, c_obj in self._tracked.items():
            if key == "ego":
                continue
            actor_tag_trees = get_tag_trees_outcome(
                self._tracked[key].tag_trees)
            match = self._match(ego_tag_trees, actor_tag_trees, key)
            if len(match) > 0:
                updated_matched[key] = match
        self.matched_category_indices = updated_matched

    def _match(
        self,                           # type: Matcher
        ego_tag_trees,                  # type: dict
        actor_tag_trees,                # type: dict
        actor_id=None,                  # type: Optional[str|int]
        without_initial_state=False     # type: bool
    ):
        # type: (...) -> list[int]
        matches = []
        for index, scenario_category in enumerate(self.scenario_categories):
            target_checked = {target: False
                              for target in scenario_category['tag_trees']}
            for target, target_trees in scenario_category["tag_trees"].items():
                if target == "ego":
                    target_checked["ego"] = self._match_an_obj(
                        target_trees, ego_tag_trees, "ego", index,
                        without_initial_state)
                elif target == "actor":
                    target_checked["actor"] = self._match_an_obj(
                        target_trees, actor_tag_trees, actor_id, index,
                        without_initial_state)
            if not False in target_checked.values():
                matches.append(index)
        return matches

    def _match_an_obj(
        self,
        target_tag_trees,
        obj_tag_trees,
        obj_id,
        category_index,
        without_initial_state
    ):
        matched = self.matched_category_indices
        for tag_name, value in target_tag_trees.items():
            if "initial_state" in tag_name:
                if without_initial_state:
                    continue
                if obj_id != None and obj_id in matched \
                        and category_index in matched[obj_id]:
                    continue
            tags = []
            if isinstance(value, list):
                tags = value
            else:
                tags.append(value)
            tag_matched = False
            for tag in tags:
                splits = tag.split(':')
                if "initial_state" in tag_name or len(splits) > 1:
                    tag_matched = tag == obj_tag_trees[tag_name]
                else:
                    target_primary = splits[0]
                    obj_primary = obj_tag_trees[tag_name].split(':')[0]
                    tag_matched = target_primary == obj_primary
                if tag_matched:
                    break
            if not tag_matched:
                return False
        return True

    def _classification_objects_callback(self, msg):
        # type: (Matcher, ClassificationObjectArray) -> None
        if msg.objects and len(msg.objects) > 0:
            detected_ids = set()
            for c_obj in msg.objects:
                is_ego = c_obj.label == "ego"
                key = "ego" if is_ego else c_obj.id
                detected_ids.add(key)
                self._tracked[key] = c_obj
            delete_keys = set(self._tracked.keys()) - detected_ids
            for key in delete_keys:
                del self._tracked[key]
            self._match_all_tracked()


if __name__ == "__main__":
    Matcher()
