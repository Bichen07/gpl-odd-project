import os, glob, ffmpeg, argparse, re, time, datetime, json
import numpy as np

"""
Tested Version - 
    ffmpeg version 4.3.1-static
    ffmpeg-python version 0.2.0

The script is a tool to convert videos with 2 functionality
* Adjust speed - FfmpegHelper.run_video_speed_adjust_and_interpolate()
* Crop video to remove title bar and leave left-hand-side video. - Ffmpeg.run_video_crop()
"""

def main():
    root_folder = "/home/zack/Videos"
    logo_file = None # "/home/zack/Pictures/itri_CEL_A.png"
    helper = FfmpegHelper(root_folder, logo_file)
    helper.main()

class FfmpegHelper():

    def __init__(self, root_folder, logo_file=None):
        print("\n\033[1;101m=== FFMPEG Helper ===\033[0m\n")
        print("\033[1;94mRoot Folder: {}\033[0m\n".format(root_folder))
        self.root_folder = root_folder
        self.logo = logo_file
        self.params = {
            "Notation": "This setting will be saved in a json file generated automatically",
            "crf": 19,
            "minterpolate":{
                "fps": 60,
                "mi_mode": "blend",
            }
        }
        self.supported_functions = {   
            "Documentation": {
                "line1": "Use regex to find videos with matching file name with include or exclude.",
                "line2": "Currently, include and exclude cannot be set at the same time for the reason that",
                "line3": "I don\'t have a satisfying way to determine which should do first at the time."
            },
            "Speed Correction": {
                "Notation":{    
                    "line1": "The suffix AxBC means that the video was recorded in realtime factor A.BCx.",
                    "line2": "The script will process the name to get the value and adjust video speed accordingly."
                },
                "include": "shuinan[0-9]{2}.*-[0-9]*x[0-9]*\\.mp4",
                #"include": "shuinan[0-9]{2}-2x17\\.mp4",
                "exclude": None,
                "function": self.run_video_speed_adjust_and_interpolate
            },
            "Crop and Get Left Side": {
                #"include": "shuinan[0-9]{2}-((success)|(fail))[0-9]{2}-((good)|(vissim)|(peaceful)|(peace))(-[0-9]{0,2}x[0-9]{0,2})?\\.mp4",
                "include": "shuinan[0-9]{2}-((success)|(fail))[0-9]{2}f?(-((good)|(vissim)|(peaceful)|(peace)))?(-[0-9]{0,2}x[0-9]{0,2})?\\.mp4",
                "exclude": None,
                "function": self.run_video_crop
            },
            "Crop and Get Left Side with Speed Correction": {
                "include": "shuinan[0-9]{2}-((success)|(fail))[0-9]{2}f?(-((good)|(vissim)|(peaceful)|(peace)))?(-[0-9]{0,2}x[0-9]{0,2})?\\.mp4",
                #"include": "shuinan[0-9]{2}-((success)|(fail))[0-9]{2}-((good)|(vissim)|(peaceful)|(peace))\\.mp4",
                "exclude": None,
                "function": lambda : self.run_video_crop(speed_adjust=True)
            },
            "Crop VISSIM and Speed Correction": {
                "include": "vissim-shuinan[0-9]{2}-((success)|(fail))[0-9]{2}f?(-((good)|(vissim)|(peaceful)|(peace)))?(-[0-9]{0,2}x[0-9]{0,2})?\\.mp4",
                #"include": "shuinan[0-9]{2}-((success)|(fail))[0-9]{2}-((good)|(vissim)|(peaceful)|(peace))\\.mp4",
                "exclude": None,
                "function": lambda : self.run_video_crop(speed_adjust=True, crop_start=[150, 130], crop_size=[1700, 720])
            }
        }
        self.supported_list = [ x for x in np.sort(list(self.supported_functions.keys()))[::-1] if x!="Documentation"]

    def main(self):

        self.___list_options(
            title="Choose a function.", 
            options=self.supported_list, default=1)
        chosen_function = self.___selection(self.supported_list, default=1)
        print("\n>> Chosen Function: {} <<\n".format(chosen_function))
        chosen_function = self.supported_functions[chosen_function]
        include, exclude, function = chosen_function["include"], chosen_function["exclude"], chosen_function["function"]
        self._get_directory()
        self.walking_through(include, exclude, create_folder=True)
        function()


    def walking_through(self, include=None, exclude=None, create_folder=True):
        if not self.target_directory: return
        print("\nWalking through {}\n".format(self.target_directory))
        self.file_full_path = []
        self.file_list = []
        for sub_dir in os.walk(self.target_directory):
            if "output" in sub_dir[0].lower(): continue
            if "done" in sub_dir[0].lower(): continue
            if "release" in sub_dir[0].lower(): continue
            if "speed corrected" in sub_dir[0].lower(): continue
            if "speed corrected raw" in sub_dir[0].lower(): continue
            for file in np.sort(glob.glob(os.path.join(sub_dir[0], "*.mp4")))[::-1]:
                file_name = file.split('/')[-1]
                take = False
                if include is not None:
                    if type(include) == str:
                        take = re.fullmatch(include, file_name)
                    else:
                        take = include(file_name)
                elif exclude is not None:
                    if type(exclude) == str:
                        take = not re.match(exclude, file_name)
                    else:
                        take = not exclude(file_name)
                if take:
                    self.file_full_path.append(file)
                    self.file_list.append(file_name)
                else:
                    print("Illegal filename {}.".format(file_name))

        print("\nFull File List:")
        for files in self.file_full_path:
            print("\t{}".format(files))

        if create_folder:
            self._create_folder()

    def run_video_crop(self, speed_adjust=False, crop_start=None, crop_size=None):
        if not self.target_directory: return
        for i, (full_path, file) in enumerate(zip(self.file_full_path, self.file_list)):
            file_notation = file.split("-")[2].split(".")[0]
            output_name = '-'.join(file.split(".")[0].split("-")[:3]) + ".mp4"
            stream, _ = self.append_logo(full_path)
            if crop_start is not None and crop_size is not None:
                stream, _ = self.crop_specific(stream, crop_start, crop_size)
            else:
                stream, _ = self.crop_left(stream)
            print_str = ">> {} >> {} << {}".format(file_notation, output_name, file)
            if speed_adjust:
                stream, times = self.speed_adjust(stream, file)
                stream, _ = self.minterpolate(stream, **self.params["minterpolate"])
                print_str = ">> {} >> {:4.2f}x >> {} << {}".format(file_notation, times, output_name, file)
            self.run(stream=stream, output=output_name,
                print_str=print_str,
                current=i+1, total=len(self.file_list))

    def run_video_speed_adjust_and_interpolate(self):
        if not self.target_directory: return
        for i, (full_path, file) in enumerate(zip(self.file_full_path, self.file_list)):
            output_name = "-".join(file.split('-')[:-1]) + "-output.mp4"
            stream, _ = self.append_logo(full_path)
            stream, times = self.speed_adjust(stream, file)
            stream, _ = self.minterpolate(stream, **self.params["minterpolate"])
            self.run(stream=stream, output=output_name,
                print_str=">> {:4.2f}x >> {} << {}".format(times, output_name, file),
                current=i+1, total=len(self.file_list))

    """
    # Unify run script core part.
    def run_wrapper(self, core_procedure):
        if not self.target_directory: return
        for i, (full_path, file) in enumerate(zip(self.file_full_path, self.file_list)):
            core_procedure(file, full_path, i)
   """
    
    def append_logo(self, file_full_path):
        stream = ffmpeg.input(file_full_path)
        if self.logo:
            stream = ffmpeg.filter([self.main, self.logo], 'overlay', 10, 10)
        return stream, None

    def crop_specific(self, stream, crop_start, crop_size):
        try:
            stream = stream.filter("crop", *crop_size, *crop_start)
        except Exception as e:
            print("{} {}".format("[crop_specific]", str(e)))
        return stream, None

    def crop_left(self, stream):
        stream, _ = self.crop_specific([0, 25], ["in_w/2", 1055])
        return stream, None

    def speed_adjust(self, stream, file):
        try:
            times_first = float(re.search(".*-(.+)x(.*)\\.mp4", file).group(1))
            times_second = re.search(".*-(.+)x(.*)\\.mp4", file).group(2)
            times_second = 0 if times_second == "" else float(times_second)
            while times_second > 1:
                times_second *= 0.1
            times = times_first + times_second
            stream = stream.filter("setpts", "{}*PTS".format(times))
            return stream, times
        except Exception as e:
            print("{} {}".format("[speed_adjust]", str(e)))
        return stream, 1

    def minterpolate(self, stream, **kwargs):
        try:
            stream = stream.filter("minterpolate", **kwargs)
        except Exception as e:
            print("{} {}".format("[minterpolate]", str(e)))
        return stream, None

    def run(self, stream, output, print_str, current, total):
        try:
            t_starts = time.time()
            actual_time = datetime.datetime.fromtimestamp(t_starts).strftime("%H:%M:%S")
            print("[{}] | {}".format(actual_time, print_str))
            stream = stream.output("{}{}".format(self.save_folder, output), crf=self.params["crf"])
            stream.global_args('-loglevel', 'error').run()
            t_ends = time.time()
            t_span = t_ends - t_starts
            m, s = divmod(t_span, 60)
            h, m = divmod(m, 60)
            print("           | -- Time Span: {:02d}:{:02d}:{:05.2f}".format(int(h), int(m), s))
        except Exception as e:
            print("{} {}".format("[run]", str(e)))

    def _create_folder(self):
        target_name = self.target_directory.split("/")[-1]
        created_folder = "{}/{}_output".format(self.target_directory, target_name)
        if os.path.isdir(created_folder):
            idx = 2
            new_name = "{}_{}".format(created_folder, idx)
            while os.path.isdir(new_name):
                new_name = "{}_{}".format(created_folder, idx)
                idx += 1
            created_folder = new_name
        created_folder += '/'
        print("\nCreate Output Folder: {}\n".format(created_folder))
        os.mkdir(created_folder)
        self.save_folder = created_folder
        with open(created_folder + "params.json", 'w') as f:
            json.dump(self.params, f)
    
    def _get_directory(self):
        dir_list = [x for x in os.listdir(self.root_folder) if os.path.isdir(self.root_folder+"/"+x)]
        dir_list.sort()
        target_directory = self.__get_answer(
            title="Chose a folder to walk through.",
            options=dir_list, default="End.")
        if target_directory == -1:
            self.target_directory = None
            return
        self.target_directory = "{}/{}".format(self.root_folder, target_directory)
        print("Target Directory: {}".format(self.target_directory))

    def __get_answer(self, title, options, default=None):
        self.___list_options(title, options, default) 
        return self.___selection(options, bool(default))

    def ___list_options(self, title, options, default):
        print(title+'\n')
        if type(default) is str:
            print("\033[1;35m   0] {}\033[0m".format(default))
            default_selection = 0
        elif default:
            default_selection = int(default)
        else:
            default_selection = 1

        for i, op in enumerate(options):
            if i + 1 == default_selection:
                print("\033[1;35m   {}] {}\033[0m".format(i+1, op))
            else:
                print("   {}. {}".format(i+1, op))
        print()
    
    def ___selection(self, options, default):
        try:
            ans = int(input("==> ")) - 1
            print()
            return oprions[default-1] if ans == 0 else options[ans]
        except Exception as e:
            return options[default-1]


if __name__ == "__main__":
    helper = main()
