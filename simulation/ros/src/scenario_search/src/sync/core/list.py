import os
import json

from common.constants import DATA_ROOT
from common import utils

scenario_ids = utils.get_scenario_ids()


def get_line_count(file):
    with open(file, 'r') as f:
        row_count = sum(1 for row in f)
    return row_count


def add_metadata(folder_path: str) -> None:
    result_csv_path = os.path.join(folder_path, "result.csv")
    scenario_config_path = os.path.join(
        folder_path, "complete_configs/single_scenario_config0.json")
    metadata_path = os.path.join(folder_path, "metadata.json")
    if os.path.exists(result_csv_path) and os.path.exists(scenario_config_path):
        metadata = utils.get_scenario_metadata(
            result_csv_path,
            scenario_config_path,
            scenario_ids)
    else:
        metadata = dict()
    with open(metadata_path, 'w') as f:
        json.dump(metadata, f)


def add_stats(folder_path: str) -> None:
    result_csv_path = os.path.join(folder_path, "result.csv")
    sample_csv_path = os.path.join(folder_path, "samples.csv")
    metadata_path = os.path.join(folder_path, "metadata.json")
    with open(metadata_path, 'r') as f:
        metadata = json.load(f)
        if not "scenario_count" in metadata:
            metadata["scenario_count"] = 0
            if os.path.exists(result_csv_path):
                scenario_count = get_line_count(result_csv_path) - 1
                metadata["scenario_count"] = scenario_count
        if not "observation_count" in metadata:
            metadata["observation_count"] = 0
            if os.path.exists(sample_csv_path):
                observation_count = get_line_count(sample_csv_path) - 1
                metadata["observation_count"] = observation_count
    with open(metadata_path, 'w') as f:
        json.dump(metadata, f)


def list_data_summary(filters: dict) -> dict:
    summary = dict(
        scenario_files=[],
        observation_files=[])
    for folder in os.listdir(DATA_ROOT):
        folder_path = os.path.join(DATA_ROOT, folder)
        metadata_path = os.path.join(folder_path, "metadata.json")
        try:
            if not os.path.exists(metadata_path):
                add_metadata(folder_path)
            add_stats(folder_path)
            with open(metadata_path, 'r') as f:
                metadata = json.load(f)
                if any([metadata.get(k) != v for k, v in filters.items()]):
                    continue
                summary["scenario_files"].append(
                    (folder, metadata["scenario_count"]))
                summary["observation_files"].append(
                    (folder, metadata["observation_count"]))
        except Exception as err:
            print("\tSkip folder: {} because error: {}".format(folder, err))
    
    return summary
