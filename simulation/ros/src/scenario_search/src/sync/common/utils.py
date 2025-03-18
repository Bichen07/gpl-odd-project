import csv
import json
import os

from .constants import \
    DATA_ROOT, ODD_SEARCH_CONFIG_PATH, SYNC_CONFIG_PATH


def initialize_config():
    """
    :returns: dict
    """
    initial_value = dict(last_push_timestamp="0101_000000")
    with open(SYNC_CONFIG_PATH, 'w') as f:
        json.dump(initial_value, f)
    return initial_value


def get_last_timestamp():
    """
    :returns: str
    """
    if not os.path.exists(SYNC_CONFIG_PATH):
        config = initialize_config()
        last_push_timestamp = config['last_push_timestamp']
        return last_push_timestamp
    try:
        with open(SYNC_CONFIG_PATH, 'r') as f:
            config = json.load(f)
            last_push_timestamp = config['last_push_timestamp']
    except Exception as err:
        print("initialize sync config because of error in get_last_timestamp:", err)
        config = initialize_config()
        last_push_timestamp = config['last_push_timestamp']
        
    return last_push_timestamp


def update_last_timestamp(new_push_ts):
    """
    :type new_push_ts: str
    """
    with open(SYNC_CONFIG_PATH, 'r') as f:
        config = json.load(f)
        last_push_timestamp = config['last_push_timestamp']
    new_value = dict(last_push_timestamp=new_push_ts or last_push_timestamp)
    with open(SYNC_CONFIG_PATH, 'w') as f:
        json.dump(new_value, f)


def get_folders_after_timestamp(timestamp):
    """
    :type timestamp: str
    :returns: List[str] list of folders sorted in lexicographical order
    """
    all_folders = [f for f in os.listdir(DATA_ROOT) if f > timestamp]
    all_folders.sort()
    return all_folders


def get_scenario_ids():
    """
    :returns: List[str]
    """
    with open(ODD_SEARCH_CONFIG_PATH) as f:
        config = json.load(f)
        scenario_ids = config.keys()
    return scenario_ids


def get_scenario_metadata(
        result_csv_path,        # type: str
        scenario_config_path,   # type: str
        scenario_ids            # type: list[str]
        ):
    """
    return a dictionary like {
        "scenario_id": str,
        "scenario_description: str,
        "sdc_version": str,
        "result_headers": str,
    }
    """
    metadata = dict()
    with open(result_csv_path) as f:
        rows = csv.reader(f, delimiter=',')
        current_headers = next(rows)
        metadata["result_headers"] = ','.join(current_headers)
    with open(scenario_config_path) as f:
        config = json.load(f)
        scenario_id = [_id for _id in scenario_ids if _id in config]
        if len(scenario_id) != 1:
            raise "cannot identify scenario_id used in this folder"
        metadata["scenario_id"] = scenario_id[0]
        metadata["scenario_desription"] = config[scenario_id[0]]
        metadata["sdc_version"] = config.get("sdc_version", "")
    return metadata
