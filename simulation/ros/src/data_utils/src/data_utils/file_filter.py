import os
import sys
from fnmatch import fnmatchcase
import pandas as pd


def get_folder_list(
        root_folder, whitelist_patterns=["*"], blacklist_patterns=[],
        whitelist_extra_rules=[], blacklist_extra_rules=[]):
    """
        Returns a list of folder under root_folder which match whitelist and blacklist rules.

        :param str root_folder: The full path to retrieve folders
        :param list whitelist_patterns: Optional.
            A list of str.
            Folders in return list should match at least one of the patterns in whitelist_patterns.
            Matching "*" if whitelist_patterns is not assigned.
        :param list blacklist_patterns: Optional.
            A list of str.
            Folders in return list should match none of the patterns in blacklist_patterns.
            Won't match if blacklist_patterns is not assigned.
        :param list whitelist_extra_rules: Optional.
            A list of function.
            Folders in return list should match none of the patterns in whitelist_extra_rules.
            Won't match if whitelist_extra_rules is not assigned.
        :param list blacklist_extra_rules: Optional.
            A list of function.
            Folders in return list should match none of the patterns in blacklist_extra_rules.
            Won't match if blacklist_extra_rules is not assigned.

        :rtype: list of str
        :return: A list of str that comply to whitelist and blacklist rules.
    """
    matched_folders = []
    all_folders = os.listdir(root_folder)
    all_folders.sort()
    for folder in all_folders:
        match_whitelist_patterns = any(fnmatchcase(
            folder, pattern) for pattern in whitelist_patterns)
        match_blacklist_patterns = any(fnmatchcase(
            folder, pattern) for pattern in blacklist_patterns)
        match_whitelist_rules = any(rule(folder)
                                    for rule in whitelist_extra_rules)
        match_blacklist_rules = any(rule(folder)
                                    for rule in blacklist_extra_rules)

        match_whitelist = match_whitelist_patterns or match_whitelist_rules
        match_blacklist = match_blacklist_patterns or match_blacklist_rules

        if match_whitelist and not match_blacklist:
            matched_folders.append(folder)

    return all_folders, matched_folders


def get_dataframe(root_folder, whitelist_patterns=["*"], blacklist_patterns=[],
                  whitelist_extra_rules=[], blacklist_extra_rules=[]):
    all_folders, matched = get_folder_list(
        root_folder, whitelist_patterns, blacklist_patterns, whitelist_extra_rules, blacklist_extra_rules)

    all_folders_str = str(all_folders)
    for m in matched:
        all_folders_str = all_folders_str.replace(
            m, "\033[1;33m{}\033[0m".format(m)
        )

    data_df = pd.DataFrame()
    dfs = []
    if len(matched):
        for i, folder in enumerate(matched):
            folderpath = "{}/{}/".format(root_folder, folder)
            data_result_csv = folderpath + "result.csv"
            if not os.path.exists(data_result_csv):
                continue
            df = pd.read_csv(data_result_csv)
            df["folderpath"] = folderpath
            dfs.append(df)

        data_df = pd.concat(dfs, ignore_index=True)
        data_df.reset_index()

    return data_df


if __name__ == '__main__':
    folder_list = get_folder_list(
        "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records",
        whitelist_patterns=["0912*"],
        blacklist_patterns=["*0943*"],
        whitelist_extra_rules=[lambda x: x.startswith("0908")],
        blacklist_extra_rules=[]
    )
    print(folder_list)
