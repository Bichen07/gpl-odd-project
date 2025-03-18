import os
import json
import numpy as np
import pandas as pd
import csv
import copy
import matplotlib as mpl
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.colors import Normalize

from scenario_search_visualization_base import ScenarioSearchVisualizationBase

DATA_FILTER = {
    # "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records",
    # "whitelist_patterns": ["*"],
    # "blacklist_patterns": ["*sub*"],
    "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records/sub_random_1022_0836",
    "whitelist_patterns": ["*"],
    "blacklist_patterns": [],
    "whitelist_extra_rules": [],
    "blacklist_extra_rules": [],
}

CHOSEN_FEATURES_VERBOSE = ["x1", "x2", "x3"]
# CHOSEN_LABELS_VERBOSE = ["result_ttc_2d_ward_min"]
CHOSEN_LABELS_VERBOSE = ["collision"]
# CHOSEN_LABELS_VERBOSE = ["collision"]
DOWN_SAMPLE_RATE = 1


class Visualization3DScatterPlot(ScenarioSearchVisualizationBase):
    def __init__(self):
        self.method = "3D scatter plot"
        super(Visualization3DScatterPlot, self).__init__(self.method)
        # self.config_check()
        # self.pandas_load(
        #     DATA_FILTER["root_folder"],
        #     DATA_FILTER["whitelist_patterns"],
        #     DATA_FILTER["blacklist_patterns"],
        #     DATA_FILTER["whitelist_extra_rules"],
        #     DATA_FILTER["blacklist_extra_rules"],
        #     CHOSEN_FEATURES_VERBOSE,
        #     CHOSEN_LABELS_VERBOSE,
        #     DOWN_SAMPLE_RATE,
        # )

        trials = pd.read_csv(
            "/project/mmsl_simulation/src/scenario_search/data/odd_search/hct_logistic/search_attempts/hct_6/search_attempt_0311_144749/trials.csv"
        )
        completed_trials = trials[trials["trial_status"] == "COMPLETED"]
        self.data_df = completed_trials
        print(self.data_df.tail())
        print(self.data_df[CHOSEN_FEATURES_VERBOSE].tail())

    def config_check(self):
        assert (
            len(CHOSEN_FEATURES_VERBOSE) >= 3
        ), "len(CHOSEN_FEATURES_VERBOSE < 3 " "is not supported for {} yet.".format(
            self.method
        )
        assert (
            len(CHOSEN_LABELS_VERBOSE) == 1
        ), "len(CHOSEN_LABELS_VERBOSE) != 1 " "is not supported for {} yet.".format(
            self.method
        )
        print("config check: all pass")

    def plot(self):
        data_x = self.data_df[CHOSEN_FEATURES_VERBOSE].to_numpy()
        data_y = self.data_df[CHOSEN_LABELS_VERBOSE]

        cm = plt.get_cmap()
        fig = plt.figure()
        ax = fig.add_subplot(111, projection="3d")
        norm = Normalize(vmin=data_y.min(), vmax=data_y.max())
        colors = norm(np.abs(1 - data_y.to_numpy().flatten()))
        scatter = ax.scatter(
            data_x[:, 0],
            data_x[:, 1],
            data_x[:, 2],
            c=colors,
            s=20,
            picker=True,
            cmap="RdYlGn",
        )
        ax.set_xlabel(CHOSEN_FEATURES_VERBOSE[0])
        ax.set_ylabel(CHOSEN_FEATURES_VERBOSE[1])
        ax.set_zlabel(CHOSEN_FEATURES_VERBOSE[2])
        # sm = plt.cm.ScalarMappable(
        #     norm=plt.Normalize(
        #         vmin=np.min(data_y, axis=0)[0], vmax=np.max(data_y, axis=0)[0]
        #     ),
        #     cmap="RdYlGn",
        # )
        # sm.set_array([])
        # plot_color = ax.pcolor(color_map)
        # fig.colorbar(sm)

        # Add labels and a title
        ax.set_xlabel(CHOSEN_FEATURES_VERBOSE[0])
        ax.set_ylabel(CHOSEN_FEATURES_VERBOSE[1])
        ax.set_title(CHOSEN_LABELS_VERBOSE[0])

        def onpick3(event):
            ind = event.ind
            print("onpick3 scatter:", ind)
            if len(ind) > 0:
                print(self.data_df.iloc[ind[0], :])

        fig.canvas.mpl_connect("pick_event", onpick3)

        plt.show()


if __name__ == "__main__":
    v3dsp = Visualization3DScatterPlot()
    v3dsp.plot()
