import matplotlib
matplotlib.use('Agg')

from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import Matern
from scenario_search_visualization_base import ScenarioSearchVisualizationBase
from matplotlib.ticker import FormatStrFormatter
from matplotlib.colors import Normalize
import matplotlib.pyplot as plt
import matplotlib as mpl
import copy
import csv
import numpy as np
import json
import os


DATA_FILTER = {
    "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records",
    # "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records/sub_hct_14_gp_1126_1331",
    # "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records/sub_latin_1126_0827",
    "whitelist_patterns": ["*"],
    "blacklist_patterns": ["*sub*", "*.zip"],
    # "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records/sub_random_1022_0836",
    # "whitelist_patterns": ["*"],
    # "blacklist_patterns": [],
    "whitelist_extra_rules": [],
    "blacklist_extra_rules": []
}

CHOSEN_FEATURES_VERBOSE = [
    "dx0_m", "dy0_m"
    # "dx0_m", "vy_mps"
    # "ve0_kph", "vo0_kph"
    # "dx0_m", "dy0_m", "ve0_kph", "vo0_kph", "vy_mps"
    # "dy0", "vy0"
]
# CHOSEN_LABELS_VERBOSE = ["result_ttc_2d_ward_min"]
# CHOSEN_LABELS_VERBOSE = ["result_collide"]
CHOSEN_LABELS_VERBOSE = ["result_ttc_first_order_min"]
# CHOSEN_LABELS_VERBOSE = ["result_ttc_first_order_at_fault_min"]
# CHOSEN_LABELS_VERBOSE = ["result_ttc_first_order_looming_min"]
# CHOSEN_LABELS_VERBOSE = ["result_ttc_second_order_min"]
DOWN_SAMPLE_RATE = 1


class Visualization2DScatterPlot(ScenarioSearchVisualizationBase):
    def __init__(self):
        self.method = "2D scatter plot"
        super(Visualization2DScatterPlot, self).__init__(self.method)
        self.pandas_load(
            DATA_FILTER["root_folder"],
            DATA_FILTER["whitelist_patterns"],
            DATA_FILTER["blacklist_patterns"],
            DATA_FILTER["whitelist_extra_rules"],
            DATA_FILTER["blacklist_extra_rules"],
            CHOSEN_FEATURES_VERBOSE, CHOSEN_LABELS_VERBOSE, DOWN_SAMPLE_RATE)
        # new_value = 999
        # self.data_df = self.data_df.replace([np.inf], new_value)
        # print(self.data_df.head())
        # self.data_df = self.data_df[self.data_df[CHOSEN_LABELS_VERBOSE[0]] > -9.8]
        # self.data_df = self.data_df[self.data_df[CHOSEN_LABELS_VERBOSE[0]] < 5]

    def plot(self):
        self.data_df = self.data_df[self.data_df[CHOSEN_LABELS_VERBOSE[0]] < 7]
        # self.data_df = self.data_df[(self.data_df[CHOSEN_LABELS_VERBOSE[0]] < 2) & (self.data_df[CHOSEN_LABELS_VERBOSE[0]] > 1)]
        print(self.data_df.shape)
        # self.data_df = self.data_df[self.data_df["result_ttc_y_min"] < 3]
        # self.data_df = self.data_df[(self.data_df["vy0"] > 5.0) & (
        #     self.data_df["vy0"] < 7) & (self.data_df["dy0"] > -7) & (self.data_df["dy0"] < -5)]
        data_x = self.data_df[CHOSEN_FEATURES_VERBOSE]
        data_y = self.data_df[CHOSEN_LABELS_VERBOSE]

        norm = Normalize(vmin=data_y.min(), vmax=data_y.max())
        colors = norm(data_y.to_numpy().flatten())
        # colors = 1 - colors

        data_x = data_x.to_numpy()

        fig, ax = plt.subplots()

        # sc = ax.scatter(data_x[:, 0], data_x[:, 1], c=colors,
        #                 cmap="viridis", s=50, alpha=0.5, picker=True)
        sc = ax.scatter(data_x[:, 0], data_x[:, 1], c=colors,
                        cmap="RdYlGn", s=50, alpha=0.5, picker=True)

        # Add a colorbar to indicate the color scale
        cbar = plt.colorbar(sc, label=CHOSEN_LABELS_VERBOSE[0])
        # Customize colorbar ticks and labels to show original values
        # Customize the number of ticks as needed
        original_ticks = np.linspace(data_y.min(), data_y.max(), num=5).ravel()
        cbar.set_ticks(norm(original_ticks))
        original_ticks = np.around(original_ticks, decimals=4)
        cbar.set_ticklabels(original_ticks)

        # Add labels and a title
        ax.set_xlabel(CHOSEN_FEATURES_VERBOSE[0])
        ax.set_ylabel(CHOSEN_FEATURES_VERBOSE[1])
        ax.set_title('Longitudinal - Simulation Result')

        def onpick3(event):
            ind = event.ind
            print('onpick3 scatter:', ind)
            if len(ind) > 0:
                print(self.data_df.iloc[ind[0], :])

        fig.canvas.mpl_connect('pick_event', onpick3)

        # plt.show()
        plt.savefig("/home/user/Downloads/plot.png")


if __name__ == '__main__':
    v3dsp = Visualization2DScatterPlot()
    v3dsp.plot()
