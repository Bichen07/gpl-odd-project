import json
import os
from typing import List, Tuple

from core.aws_s3 import s3_client
from common.constants import BUCKET_NAME, DATA_ROOT


class PullModule():
    def __init__(self, filters) -> None:
        self.paginator = s3_client.get_paginator('list_objects_v2')
        root_folder = self.paginator.paginate(
            Bucket=BUCKET_NAME, Delimiter='/')
        self.top_level_folders = [
            obj['Prefix'] for obj in root_folder.search('CommonPrefixes')]
        self.filters = filters

    def pulling(self) -> Tuple[List[Tuple[str, str]], int]:
        unpulled_folders = []
        for folder in self.top_level_folders:
            try:
                # Skip existing folder
                folder_path = os.path.join(DATA_ROOT, folder)
                if os.path.exists(folder_path):
                    continue
                # Filter
                obj_name = "{}result.csv".format(folder)
                obj_meta = s3_client.head_object(
                    Bucket=BUCKET_NAME,
                    Key=obj_name)
                if any([obj_meta['Metadata'].get(k) != v
                        for k, v in self.filters.items()]):
                    continue
                unpulled_folders.append(folder)
            except Exception as err:
                print("Skip folder: {} because error occurred when filtering: {}"
                      .format(folder, err))

        fail = []
        pulled_count = 0
        for i, folder_name in enumerate(unpulled_folders):
            print("Downloading {} ({}/{})..."
                  .format(folder_name, i+1, len(unpulled_folders)))
            pages = self.paginator.paginate(
                Bucket=BUCKET_NAME, Prefix=folder_name)
            for page in pages:
                for obj in page['Contents']:
                    try:
                        obj_name = obj['Key']
                        file_path = os.path.join(DATA_ROOT, obj_name)
                        os.makedirs(os.path.dirname(file_path), exist_ok=True)
                        s3_client.download_file(
                            BUCKET_NAME,
                            obj_name,
                            file_path)

                        if 'result.csv' in obj_name:
                            obj_meta = s3_client.head_object(
                                Bucket=BUCKET_NAME,
                                Key=obj_name)
                            metadata_path = os.path.join(
                                os.path.dirname(file_path), 'metadata.json')
                            with open(metadata_path, 'w') as f:
                                json.dump(obj_meta['Metadata'], f)

                        pulled_count += 1
                    except Exception as err:
                        fail.append((obj_name, err))

        return fail, pulled_count
