from __future__ import print_function
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
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
CHOSEN_LABELS_VERBOSE = ["result_collide"]
DOWN_SAMPLE_RATE = 1


class VisualizationPCA(ScenarioSearchVisualizationBase):
    def __init__(self):
        self.method = "PCA plot"
        super(VisualizationPCA, self).__init__(self.method)
        self.config_check()
        x_shape, y_shape = self.load(
            DATA_FILTER["root_folder"],
            DATA_FILTER["whitelist_patterns"],
            DATA_FILTER["blacklist_patterns"],
            DATA_FILTER["whitelist_extra_rules"],
            DATA_FILTER["blacklist_extra_rules"],
            CHOSEN_FEATURES_VERBOSE, CHOSEN_LABELS_VERBOSE, DOWN_SAMPLE_RATE)
        self.pca = PCA(n_components=len(CHOSEN_FEATURES_VERBOSE))
        self.principal_components_names = ["PC{}".format(i) \
            for i in range(1, len(CHOSEN_FEATURES_VERBOSE) + 1)]
        scaled_data_x = StandardScaler().fit_transform(self.data_x)
        self.principal_components = self.pca.fit_transform(scaled_data_x)

    def config_check(self):
        assert len(CHOSEN_LABELS_VERBOSE) == 1, \
            "len(CHOSEN_LABELS_VERBOSE) != 1 "\
            "is not supported for {} yet.".format(self.method)
        print("config check: all pass")

    def print_loadings(self):
        columns = self.principal_components_names[:3]
        column_width = 10
        max_length = 0
        for feature_name in CHOSEN_FEATURES_VERBOSE:
            max_length = max(max_length, len(feature_name))
        feature_column_width = max_length + 5

        print("PCA loadings:\n")
        print("\t".ljust(feature_column_width), end="")
        for column in columns:
            print("\t" + column.ljust(column_width), end="")
        print()
        for index, row in enumerate(self.pca.components_.T[:, :3]):
            print("\t" + CHOSEN_FEATURES_VERBOSE[index].ljust(
                feature_column_width), end="")
            for loading in row:
                print("\t" + "{:.6f}".format(loading).ljust(column_width),
                      end="")
            print()
        print()

    def show_all_plots(self):
        self.draw_scree_plot()
        self.draw_pca_plot()
        plt.show()

    def draw_scree_plot(self):
        plt.bar(self.principal_components_names,
                self.pca.explained_variance_ratio_)
        plt.plot(self.principal_components_names,
                self.pca.explained_variance_ratio_, "ko-")
        plt.title('Scree Plot')
        plt.ylabel('Variance Explained')
        ax = plt.gca()
        ax.yaxis.grid(True)

        for name, ratio in zip(self.principal_components_names,
                        self.pca.explained_variance_ratio_):
            ax.annotate(str(round(ratio, 4)), xy=(name, ratio))

    def draw_pca_plot(self):
        y = self.data_y
        cm = plt.get_cmap()

        normalized = lambda c: abs((c - np.min(y)) / (np.max(y) - np.min(y)))
        color_map = np.array([cm(normalized(c)) for c in y[:, 0]])
        size_map = np.array([5] * len(color_map))
        if CHOSEN_LABELS_VERBOSE[0] == "result_collide":
            normalized = lambda c: abs(1 - (c - np.min(y, axis=0)[0])
                / (np.max(y, axis=0)[0] - np.min(y, axis=0)[0]))
            color_map = np.array([cm(normalized(c)) for c in y[:, 0]])
            size_map[self.data_y[:, 0] == 1] = 50
            color_map[self.data_y[:, 0] != 1 , -1] = 0.1

        fig = plt.figure(figsize=(12, 10))
        ax = fig.add_subplot(111, projection="3d")
        ax.set_xlabel('PC1 ({}%)'.format(round(
            self.pca.explained_variance_ratio_[0] * 100, 2)), fontsize = 11)
        ax.set_ylabel('PC2 ({}%)'.format(round(
            self.pca.explained_variance_ratio_[1] * 100, 2)), fontsize = 11)
        ax.set_zlabel('PC3 ({}%)'.format(round(
            self.pca.explained_variance_ratio_[2] * 100, 2)), fontsize = 11)
        ax.scatter(self.principal_components[:, 0],
                   self.principal_components[:, 1],
                   self.principal_components[:, 2],
                   c = color_map,
                   s = size_map)
        sm = plt.cm.ScalarMappable(norm=plt.Normalize(vmin=np.min(y),
                                                      vmax=np.max(y)))
        sm.set_array([])
        colorbar = fig.colorbar(sm, pad=0.1, shrink=0.8)


if __name__ == '__main__':
    vpca = VisualizationPCA()
    vpca.print_loadings()
    vpca.show_all_plots()
