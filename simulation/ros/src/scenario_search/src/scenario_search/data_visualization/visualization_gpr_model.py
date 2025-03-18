import os
import json
import numpy as np
import csv
import copy
import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib.colors import Normalize
from matplotlib.ticker import FormatStrFormatter

from scenario_search_visualization_base import ScenarioSearchVisualizationBase

DATA_FILTER = {
    "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records",
    "whitelist_patterns": ["*"],  # see data_utils/file_filter for more.
    "blacklist_patterns": [],
    "whitelist_extra_rules": [],
    "blacklist_extra_rules": []
}

CHOSEN_FEATURES_VERBOSE = [
    "dx0", "vx0"
]
CHOSEN_LABELS_VERBOSE = ["result_ttc_x_min"]
# CHOSEN_LABELS_VERBOSE = ["result_collide"]
DOWN_SAMPLE_RATE = 1


class Visualization3DScatterPlot(ScenarioSearchVisualizationBase):
    def __init__(self):
        self.method = "3D scatter plot"
        super(Visualization3DScatterPlot, self).__init__(self.method)
        self.pandas_load(
            DATA_FILTER["root_folder"],
            DATA_FILTER["whitelist_patterns"],
            DATA_FILTER["blacklist_patterns"],
            DATA_FILTER["whitelist_extra_rules"],
            DATA_FILTER["blacklist_extra_rules"],
            CHOSEN_FEATURES_VERBOSE, CHOSEN_LABELS_VERBOSE, DOWN_SAMPLE_RATE)

    def plot(self):
        self.data_df = self.data_df[self.data_df["result_ttc_x_min"] < 3]
        data_x = self.data_df[CHOSEN_FEATURES_VERBOSE]
        data_y = self.data_df[CHOSEN_LABELS_VERBOSE]

        norm = Normalize(vmin=data_y.min(), vmax=data_y.max())
        colors = norm(data_y.to_numpy().flatten())

        data_x = data_x.to_numpy()
        fig, ax = plt.subplots()

        sc = ax.scatter(data_x[:, 0], data_x[:, 1], c=colors,
                        cmap="viridis", s=10, alpha=0.5)

        # Add a colorbar to indicate the color scale
        cbar = plt.colorbar(sc, label=CHOSEN_LABELS_VERBOSE[0])
        # Customize colorbar ticks and labels to show original values
        # Customize the number of ticks as needed
        original_ticks = np.linspace(data_y.min(), data_y.max(), num=5)
        cbar.set_ticks(norm(original_ticks))
        original_ticks = np.around(original_ticks, decimals=4)
        cbar.set_ticklabels(original_ticks)

        # Add labels and a title
        ax.set_xlabel(CHOSEN_FEATURES_VERBOSE[0])
        ax.set_ylabel(CHOSEN_FEATURES_VERBOSE[1])
        ax.set_title('Scatter Plot with Normalized Colors')

        plt.plot()

        plt.show()


if __name__ == '__main__':
    v3dsp = Visualization3DScatterPlot()
    v3dsp.plot()
