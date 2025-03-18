import os
from datetime import datetime
from typing import List, Tuple

from common import utils
from common.constants import DATA_ROOT, BUCKET_NAME
from core.aws_s3 import s3_client


SHARING_FILES = ["result.csv", "samples.csv"]


class PushModule():
    def __init__(self) -> None:
        self.last_push_timestamp = utils.get_last_timestamp()
        self.scenario_ids = utils.get_scenario_ids()
        self.unpushed_folders = \
            utils.get_folders_after_timestamp(self.last_push_timestamp)
        print("\tlast_push_timestamp =", self.last_push_timestamp)
        print("\tscenario_ids =", self.scenario_ids)
        print("\tunpushed_folders =", self.unpushed_folders)

    def pushing(self) -> Tuple[List[Tuple[str, str]], int]:
        fail = []
        pushed_count = 0

        for i, folder in enumerate(self.unpushed_folders):
            print("Processing {} ({}/{})..."
                  .format(folder, i+1, len(self.unpushed_folders)))
            folder_path = os.path.join(DATA_ROOT, folder)

            if os.path.exists(os.path.join(folder_path, "metadata.json")):
                print("\tskip pulled folder")
                continue

            result_csv_path = os.path.join(folder_path, "result.csv")
            scenario_config_path = os.path.join(
                folder_path, "complete_configs/single_scenario_config0.json")
            file_to_extra_args = {
                "result.csv": {
                    "Metadata": utils.get_scenario_metadata(
                        result_csv_path,
                        scenario_config_path,
                        self.scenario_ids)
                }
            }

            for root, _, files in os.walk(folder_path):
                for file in files:
                    try:
                        if file not in SHARING_FILES:
                            continue
                        file_path = os.path.join(root, file)
                        obj_name = file_path.replace(
                            "{}/".format(DATA_ROOT), "")
                        s3_client.upload_file(
                            file_path,
                            BUCKET_NAME,
                            obj_name,
                            ExtraArgs=file_to_extra_args.get(file, None))
                        pushed_count += 1
                    except Exception as err:
                        print("\tskip {}: {}.".format(file, err))
                        fail.append((file_path, err))

        now = datetime.now()
        new_push_ts = now.strftime("%m%d_%H%M%S")
        utils.update_last_timestamp(new_push_ts=new_push_ts)
        return fail, pushed_count
