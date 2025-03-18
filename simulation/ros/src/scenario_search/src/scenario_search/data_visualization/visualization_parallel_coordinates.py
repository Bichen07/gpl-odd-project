import numpy as np
import matplotlib.pyplot as plt
import matplotlib.ticker as ticker
from scenario_search_visualization_base import ScenarioSearchVisualizationBase

DATA_FILTER = {
    "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records",
    "whitelist_patterns": ["*"],  # see data_utils/file_filter for more.
    "blacklist_patterns": [],
    "whitelist_extra_rules": [],
    "blacklist_extra_rules": []
}
CHOSEN_FEATURES_VERBOSE = [
    "moving_speed_kph",
    "move_trigger_distance",
    "begin_longitudinal_offset",
    "waypoint_lateral_offset",
]
# chosen_results = ["result_decel"]
CHOSEN_LABELS_VERBOSE = ["result_collide"]
DOWN_SAMPLE_RATE = 2

class VisualizationParallelCoordinatesPlot(ScenarioSearchVisualizationBase):
    def __init__(self):
        self.method = "3D scatter plot"
        super(VisualizationParallelCoordinatesPlot, self).__init__(self.method)
        x_shape, y_shape = self.load(
            DATA_FILTER["root_folder"],
            DATA_FILTER["whitelist_patterns"],
            DATA_FILTER["blacklist_patterns"],
            DATA_FILTER["whitelist_extra_rules"],
            DATA_FILTER["blacklist_extra_rules"],
            CHOSEN_FEATURES_VERBOSE, CHOSEN_LABELS_VERBOSE, DOWN_SAMPLE_RATE,
            self._normalize_x)

    def _normalize_x(self, data_x):
        # shape (n, 4)
        return (data_x - np.min(data_x, axis=0)) / (np.max(data_x, axis=0) - np.min(data_x, axis=0)) 


    def plot(self):
        cm = plt.get_cmap()
        fig = plt.figure()
        ax = fig.add_subplot(111)
        normalized = lambda c: abs(1 - (c - np.min(self.data_y, axis=0)[0]) / (np.max(self.data_y, axis=0)[0] - np.min(self.data_y, axis=0)[0]))
        color_map = np.array([cm(normalized(c)) for c in self.data_y[:, 0]])
        size_map = np.array([0.1] * len(color_map))
        if CHOSEN_LABELS_VERBOSE[0] == "result_collide":
            size_map[self.data_y[:, 0] == 1 ] = 2  # bigger size for collision data
            color_map[self.data_y[:, 0] != 1 , -1] = 0.8  # transparent for non-collision data
        for data_x, color, size in zip(self.data_x, color_map, size_map):
            ax.plot(CHOSEN_FEATURES_VERBOSE, data_x, color=color, linewidth=size)
        sm = plt.cm.ScalarMappable(norm=plt.Normalize(vmin=np.min(self.data_y, axis=0)[0], vmax=np.max(self.data_y, axis=0)[0]))
        sm.set_array([])
        # plot_color = ax.pcolor(color_map)
        fig.colorbar(sm)
        plt.show()


if __name__ == '__main__':
    vpcp = VisualizationParallelCoordinatesPlot()
    vpcp.plot()