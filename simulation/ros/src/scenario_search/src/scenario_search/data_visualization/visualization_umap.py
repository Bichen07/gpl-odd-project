from __future__ import print_function
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import StandardScaler
from scenario_search_visualization_base import ScenarioSearchVisualizationBase
import umap


DATA_FILTER = {
    # "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records/sub_latin_1126_0827",
    "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records/sub_hct_14_gp_1126_1331",
    "whitelist_patterns": ["*"],  # see data_utils/file_filter for more.
    "blacklist_patterns": [],
    "whitelist_extra_rules": [],
    "blacklist_extra_rules": [],
}

CHOSEN_FEATURES_VERBOSE = [
    "ve0_kph",
    "vo0_kph",
    "vy_mps",
    "dx0_m",
    "dy0_m",
]
# CHOSEN_LABELS_VERBOSE = ["result_collide"]
CHOSEN_LABELS_VERBOSE = ["result_ttc_first_order_min"]
DOWN_SAMPLE_RATE = 1


class VisualizationUmap(ScenarioSearchVisualizationBase):
    def __init__(self):
        self.method = "UMAP plot"
        super(VisualizationUmap, self).__init__(self.method)
        self.config_check()
        self.pandas_load(
            DATA_FILTER["root_folder"],
            DATA_FILTER["whitelist_patterns"],
            DATA_FILTER["blacklist_patterns"],
            DATA_FILTER["whitelist_extra_rules"],
            DATA_FILTER["blacklist_extra_rules"],
            CHOSEN_FEATURES_VERBOSE,
            CHOSEN_LABELS_VERBOSE,
            DOWN_SAMPLE_RATE,
        )

    def config_check(self):
        assert (
            len(CHOSEN_LABELS_VERBOSE) == 1
        ), "len(CHOSEN_LABELS_VERBOSE) != 1 " "is not supported for {} yet.".format(
            self.method
        )
        print("config check: all pass")

    def plot(self):
        data_x = self.data_df[CHOSEN_FEATURES_VERBOSE]
        data_y = self.data_df[CHOSEN_LABELS_VERBOSE]
        y = data_y.to_numpy()

        cm = plt.get_cmap("RdYlGn")
        # color_map = np.array([cm(1 - c) for c in y[:, 0]])
        color_map = np.array(
            [cm((c - np.min(y)) / (np.max(y) - np.min(y))) for c in y[:, 0]])
        size_map = np.array([10] * len(color_map))
        if CHOSEN_LABELS_VERBOSE[0] == "result_collide":
            # bigger size for collision data
            size_map[y[:, 0] == 1] = 50
            # transparent for non-collision data
            color_map[self.data_y[:, 0] != 1, -1] = 0.1
            color_map[self.data_y[:, 0] == 1, -1] = 0.1

        scaled_data_x = StandardScaler().fit_transform(data_x)
        reducer = umap.UMAP(n_neighbors=5, min_dist=0.0)
        # reducer = umap.UMAP()
        embedding = reducer.fit_transform(scaled_data_x)
        print(embedding.shape)

        def onpick3(event):
            ind = event.ind
            print('onpick3 scatter:', ind)
            if len(ind) > 0:
                print(self.data_df.iloc[ind[0], :])

        fig, ax = plt.subplots()

        ax.scatter(
            embedding[:, 0],
            embedding[:, 1],
            # c=[int(v) for v in y],
            c=color_map,
            s=size_map,
            picker=True
        )
        fig.canvas.mpl_connect('pick_event', onpick3)

        plt.show()


if __name__ == "__main__":
    vumap = VisualizationUmap()
    vumap.plot()
