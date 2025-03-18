from collections import OrderedDict
import joblib
import datetime
import os
import json
import numpy as np
import pandas as pd
from pprint import pprint
import csv
import copy
import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib.colors import Normalize
from matplotlib.ticker import FormatStrFormatter
from scenario_search_visualization_base import ScenarioSearchVisualizationBase
from mpl_toolkits.mplot3d import Axes3D

from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import RBF, WhiteKernel, Matern
from sklearn.model_selection import train_test_split
from scipy.stats import norm
from scenario_search.bayes_opt.target_space import TargetSpace


DATA_FILTER = {
    # "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records",
    # "whitelist_patterns": ["*"],
    # "blacklist_patterns": ["*sub*"],
    "root_folder": "/project/mmsl_simulation/src/scenario_search/data/scenario_search_records/sub_long",
    "whitelist_patterns": ["*"],
    "blacklist_patterns": [],
    "whitelist_extra_rules": [],
    "blacklist_extra_rules": []
}

CHOSEN_FEATURES_VERBOSE = [
    "dx0", "vx0"
]
CHOSEN_LABELS_VERBOSE = ["result_ttc_2d_ward_min"]
DOWN_SAMPLE_RATE = 1


class Visualization3DScatterPlot(ScenarioSearchVisualizationBase):
    def __init__(self):
        self.method = "model 2d plot"
        super(Visualization3DScatterPlot, self).__init__(self.method)

    def plot(self):
        output_threshold = 1.5
        prob_threshold = 0.8

        target_space = joblib.load(
            "/project/mmsl_simulation/src/scenario_search/data/save_models/20231013_084019/target_space.pkl")  # type: TargetSpace
        pbounds = joblib.load(
            "/project/mmsl_simulation/src/scenario_search/data/save_models/20231013_084019/pbounds.pkl")  # type: OrderedDict
        surrogate = joblib.load(
            "/project/mmsl_simulation/src/scenario_search/data/save_models/20231013_084019/gpr.pkl")

        grid_size = 10
        X = OrderedDict()
        for key in target_space.keys:
            pbound = pbounds[key]
            if key == "dy0" or key == "vy0":
                continue
            X[key] = np.linspace(pbound[0], pbound[1], grid_size)
        X = pd.DataFrame(X)

        grid_dx0, grid_vx0 = np.meshgrid(X["dx0"], X["vx0"])
        # print("fSDFSDf")
        # print(grid_dx0)
        grid = OrderedDict()
        for key in target_space.keys:
            if key == "dx0":
                grid[key] = grid_dx0.ravel()
            if key == "vx0":
                grid[key] = grid_vx0.ravel()
            if key == "dy0":
                grid["dy0"] = np.ones(shape=grid_dx0.ravel().shape) * 0.0
            if key == "vy0":
                grid["vy0"] = np.ones(shape=grid_vx0.ravel().shape) * 0.0
        grid_df = pd.DataFrame(grid)
        for key in target_space.keys:
            lower_bound, upper_bound = pbounds[key]
            grid_df[key] = (grid_df[key] - lower_bound) / \
                (upper_bound - lower_bound)

        # pprint(grid_df)
        print(grid_df.head())
        means, stds = surrogate.predict(grid_df.to_numpy(), return_std=True)
        Z = means.reshape(grid_dx0.shape)

        # DEBUG
        # ------------------------------------------------------
        grid_size = 10
        meshgrid = np.meshgrid(*[np.linspace(0, 1, grid_size)
                               for i in range(4)])
        # print("DAMN")
        # print(meshgrid[0])
        grid_df = OrderedDict()
        temp = 0
        for i, key in enumerate(target_space.keys):
            grid_df[key] = meshgrid[i].ravel()
            # print(key)
            # if 'y' in key:
            #     if 'v' in key:
            #         grid_df[key] = np.zeros(
            #             shape=meshgrid[0].ravel().shape)
            #     else:
            #         grid_df[key] = np.ones(
            #             shape=meshgrid[0].ravel().shape)
            # else:
            #     grid_df[key] = meshgrid[i].ravel()
            #     temp += 1
        grid_df = pd.DataFrame(grid_df)
        print(grid_df.head())

        # debug_X = grid_df[target_space.keys].to_numpy()
        # debug_X = debug_X.reshape((10, 10, 10, 10, 4))
        # pprint(debug_X[:, 9, :, 0, :].reshape((100, 4)))

        means, stds = surrogate.predict(grid_df.to_numpy(), return_std=True)
        grid_df["predicted"] = means
        # Z = means.reshape(meshgrid[1].shape)
        Z = grid_df[(grid_df["dy0"] == 1.0) & (
            grid_df["vy0"] == 0.0)]["predicted"].to_numpy()
        print(Z.shape)
        Z = Z.reshape((10, 10))
        print(Z.shape)
        # pprint(Z)
        # print(Z.shape)
        # ------------------------------------------------------

        plt.contourf(grid_dx0, grid_vx0, Z,
                     levels=np.linspace(-1, 10, 50), cmap='RdYlGn')
        plt.colorbar()

        contours = plt.contour(grid_dx0, grid_vx0, Z, levels=[
            output_threshold], colors='white')
        plt.clabel(contours, inline=True, fontsize=8)

        plt.title('Longitudinal - GPR')

        plt.show()

        passed_prob = []
        failed_prob = []
        means = means.flatten()
        stds = stds.flatten()
        for i in range(len(means)):
            mean = means[i]
            std = stds[i]
            passed_prob.append(
                1 - norm.cdf(output_threshold, loc=mean, scale=std))
            failed_prob.append(norm.cdf(output_threshold, loc=mean, scale=std))

        passed_prob = np.array(passed_prob).reshape(grid_dx0.shape)
        failed_prob = np.array(failed_prob).reshape(grid_vx0.shape)
        # passed_prob = np.array(passed_prob).reshape(X.shape)
        # failed_prob = np.array(failed_prob).reshape(X.shape)

        passed_mask = passed_prob > prob_threshold
        failed_mask = failed_prob > prob_threshold

        # Create an empty canvas to overlay the masks
        overlay = np.zeros_like(passed_mask, dtype=np.float32)

        # Set different values for the masks
        overlay[passed_mask == 1] = 1.0
        overlay[failed_mask == 1] = 0.0
        overlay[(passed_mask == 0) & (failed_mask == 0)] = 0.5

        # Display the overlay using imshow
        extent = [X["dx0"].min(), X["dx0"].max(),
                  X["vx0"].min(), X["vx0"].max()]
        aspect = (extent[1] - extent[0]) / (extent[3] - extent[2])
        plt.imshow(overlay, cmap='RdYlGn', vmin=0, vmax=1,
                   extent=extent, aspect=aspect, origin='lower')
        plt.show()

        # plt.imshow(passed_mask.reshape(X.shape), extent=(x.min(), x.max(),
        #            y.min(), y.max()), origin='lower', cmap='Greens', alpha=1.0)
        # plt.imshow(failed_mask.reshape(X.shape), extent=(x.min(), x.max(),
        #            y.min(), y.max()), origin='lower', cmap='Reds', alpha=1.0)
        # plt.show()


if __name__ == '__main__':
    v3dsp = Visualization3DScatterPlot()
    v3dsp.plot()
