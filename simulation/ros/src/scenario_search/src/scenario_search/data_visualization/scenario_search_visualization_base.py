import os
import json
import numpy as np
import csv
import copy
import pandas as pd
from scipy import stats
from data_utils import file_filter as ff
# from scenario_search.data_visualization.utils import remove_outliers
# from utils import remove_ego_at_fault


class ScenarioSearchVisualizationBase(object):
    def __init__(self, visualization_method):
        print(
            "\n===== Start running scenario search result visualization: {} =====\n"
            "".format(visualization_method)
        )
        self.headers = None
        self.data_x, self.data_y = None, None
        self.data_df = pd.DataFrame()

    def plot(self):
        raise NotImplementedError()

    def _print_info(self, data_x, data_y, indent=1):
        print("{}Shape of Data X (features): {}".format(
            "\t" * indent, data_x.shape))
        print("{}Shape of Data Y (labels)  : {}".format(
            "\t" * indent, data_y.shape))
        print(
            "{}X Min-Max: ({}, {})".format(
                "\t" * indent, np.min(data_x, axis=0), np.max(data_x, axis=0)
            )
        )
        print(
            "{}Y Min-Max: ({}, {})\n\n".format(
                "\t" * indent, np.min(data_y, axis=0), np.max(data_y, axis=0)
            )
        )

    def _print_df_info(self, feature_headers, label_headers, indent=1):
        print(
            "{}Shape of Data X (features): {}".format(
                "\t" * indent, self.data_df[feature_headers].shape
            )
        )
        print(
            "{}Shape of self.data_df Y (labels)  : {}".format(
                "\t" * indent, self.data_df[label_headers].shape
            )
        )
        print(self.data_df.describe())

    def pandas_load(
        self,
        data_root,
        whitelist_patterns,
        blacklist_patterns,
        whitelist_extra_rules,
        blacklist_extra_rules,
        chosen_features_verbose,
        chosen_labels_verbose,
        down_sample_rate=1,
    ):
        # Start Loading
        print("")
        self.data_df = pd.DataFrame()

        all_folders, matched = ff.get_folder_list(
            data_root,
            whitelist_patterns,
            blacklist_patterns,
            whitelist_extra_rules,
            blacklist_extra_rules,
        )

        all_folders_str = str(all_folders)
        for m in matched:
            all_folders_str = all_folders_str.replace(
                m, "\033[1;33m{}\033[0m".format(m)
            )
        print("Chosen folders: {}\n".format(all_folders_str))

        dfs = []
        if len(matched):
            for i, folder in enumerate(matched):
                data_result_csv = "{}/{}/result.csv".format(data_root, folder)
                if not os.path.exists(data_result_csv):
                    continue
                print("Reading {}".format(data_result_csv))
                df = pd.read_csv(data_result_csv)
                dfs.append(df)

            self.data_df = pd.concat(dfs, ignore_index=True)
            self.data_df.dropna(subset=chosen_features_verbose +
                                chosen_labels_verbose, inplace=True)
            self.data_df.drop_duplicates(inplace=True)

            print("\n===== All data loaded. =====\n\nOverview:")
            print(
                "\n\tFeatures: {}\n\tlabels: {}\n".format(
                    chosen_features_verbose, chosen_labels_verbose
                )
            )
            self._print_df_info(chosen_features_verbose, chosen_labels_verbose)
            self.data_x = self.data_df[chosen_features_verbose].to_numpy()
            self.data_y = self.data_df[chosen_labels_verbose].to_numpy()
            self.headers = self.data_df.columns

            return self.data_df

    def load(
        self,
        data_root,
        whitelist_patterns,
        blacklist_patterns,
        whitelist_extra_rules,
        blacklist_extra_rules,
        chosen_features_verbose,
        chosen_labels_verbose,
        down_sample_rate=1,
        data_x_modifier=lambda x: x,
        data_y_modifier=lambda x: x,
    ):
        # Start Loading
        print("")

        self.headers = None
        self.data_x, self.data_y = None, None

        all_folders, matched = ff.get_folder_list(
            data_root,
            whitelist_patterns,
            blacklist_patterns,
            whitelist_extra_rules,
            blacklist_extra_rules,
        )

        all_folders_str = str(all_folders)
        for m in matched:
            all_folders_str = all_folders_str.replace(
                m, "\033[1;33m{}\033[0m".format(m)
            )
        print("Chosen folders: {}\n".format(all_folders_str))

        if len(matched):
            for i, folder in enumerate(matched):
                data_result_csv = "{}/{}/result.csv".format(data_root, folder)
                print("Reading {}".format(data_result_csv))
                try:
                    with open(data_result_csv) as csvfile:
                        rows = csv.reader(csvfile, delimiter=",")
                        current_headers = next(rows)
                except IOError as e:
                    print("\t{}: skip.".format(e))
                    continue

                values = np.loadtxt(
                    data_result_csv, dtype=np.float, delimiter=",")

                # DownSample
                values = np.delete(
                    values,
                    [v for v in range(1, len(values)) if v %
                     down_sample_rate != 0],
                    axis=0,
                )

                # Remove unlisted headers and labels
                indices_to_delete = []
                for j, header in enumerate(current_headers):
                    if (
                        header not in chosen_features_verbose
                        and header not in chosen_labels_verbose
                    ):
                        indices_to_delete.append(j)
                values = np.delete(values, indices_to_delete, 1)
                current_headers = np.delete(
                    current_headers, indices_to_delete, 0)

                # Select the headers to be visualizad
                indices_of_x = []
                features_verbose = []
                verbose_to_index = {}
                for j, header in enumerate(current_headers):
                    verbose_to_index[header] = j
                for header in chosen_features_verbose:
                    assert header in verbose_to_index.keys()
                    indices_of_x.append(verbose_to_index[header])
                    features_verbose.append(header)

                # Select the labels to be visualizad
                indices_of_y = []
                labels_verbose = []
                verbose_to_index = {}
                for j, header in enumerate(current_headers):
                    verbose_to_index[header] = j
                for header in chosen_labels_verbose:
                    assert header in verbose_to_index.keys()
                    indices_of_y.append(verbose_to_index[header])
                    labels_verbose.append(header)

                modified_x = data_x_modifier(values[:, indices_of_x])
                modified_y = data_y_modifier(values[:, indices_of_y])
                if self.headers is None:
                    self.headers = current_headers
                    self.data_x = modified_x
                    self.data_y = modified_y
                else:
                    self.data_x = np.concatenate([self.data_x, modified_x])
                    self.data_y = np.concatenate([self.data_y, modified_y])

                self._print_info(modified_x, modified_y)

            self.data_x = data_x_modifier(self.data_x)
            self.data_y = data_y_modifier(self.data_y)

            print("\n===== All data loaded. =====\n\nOverview:")
            print(
                "\n\tFeatures: {}\n\tlabels: {}\n".format(
                    features_verbose, labels_verbose
                )
            )
            self._print_info(self.data_x, self.data_y)
            return self.data_x.shape, self.data_y.shape

        return None, None
