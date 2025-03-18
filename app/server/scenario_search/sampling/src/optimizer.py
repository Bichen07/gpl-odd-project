from typing import Optional, List, Tuple, Union, Dict, Any
from ax.core.search_space import SearchSpace
from ax.modelbridge.modelbridge_utils import extract_search_space_digest
from ax.models.torch.botorch_modular.surrogate import SearchSpaceDigest, Surrogate
from ax.service.ax_client import Experiment
from sklearn.gaussian_process import GaussianProcessRegressor
from sklearn.gaussian_process.kernels import Matern
import math
import time
from pprint import pprint
import numpy as np
from sklearn.cluster import KMeans
import torch
from torch import Tensor
from botorch.models import SingleTaskGP
from botorch.fit import fit_gpytorch_mll
from gpytorch.mlls import ExactMarginalLogLikelihood
from botorch.models.transforms.input import Normalize
from botorch.models.transforms.outcome import Standardize
from ax.modelbridge.registry import Models
from acquisition_function.base import AcquisitionFunction


class Optimizer:
    def __init__(
        self,
        search_space: SearchSpace,
        acquisition_function: AcquisitionFunction,
        domain_size=3000,
    ):
        self.iteration_count = 0
        self.domain_size = domain_size
        self.acquisition_function = acquisition_function
        self.search_space = search_space

    """
    Using clustering to select next batch
    """

    def get_next_batch_clustering(
        self,
        X: Tensor,
        batch_size: int,
    ) -> np.ndarray:
        self.iteration_count = self.iteration_count + 1

        X_temp = X.detach().cpu().numpy()

        time_start = time.perf_counter()

        uniform = Models.UNIFORM(search_space=self.search_space)
        tries_df = uniform.gen(n=self.domain_size).param_df
        tries_df.sort_index(axis=1, inplace=True)
        print("tries_df")
        print(tries_df.head())
        X_tries = tries_df.to_numpy()

        time_end = time.perf_counter()
        time_duration = time_end - time_start
        print(
            f"[ParameterSearchingServer:Optimizer] Uniform generator took {time_duration:.3f} seconds to generate {self.domain_size} x tries"
        )

        print("X_tries shape")
        print(X_tries.shape)
        X_tries_tensor = torch.Tensor(X_tries).to(X.device, X.dtype)

        time_start = time.perf_counter()

        acquisition_values = self.acquisition_function(X_tries_tensor)
        acquisition_values = acquisition_values.detach().cpu().numpy()

        time_end = time.perf_counter()
        time_duration = time_end - time_start
        print(
            f"[ParameterSearchingServer:Optimizer] Acqusition values took {time_duration:.3f} seconds to calculate"
        )

        time_start = time.perf_counter()
        if batch_size > 1:
            gen = sorted(
                zip(acquisition_values, X_tries), key=lambda x: x[0], reverse=True
            )
            x_best_acq_value, x_best_acq_domain = (
                np.array(t)[: len(acquisition_values) // 4] for t in zip(*gen)
            )

            # Do the domain space based clustering on the best points
            kmeans = KMeans(n_init="auto", n_clusters=batch_size, random_state=0).fit(
                x_best_acq_domain
            )
            cluster_pred_domain = kmeans.labels_.reshape(kmeans.labels_.shape[0])

            # partition the space into the cluster in X and select the best X from each space
            partitioned_space = dict()
            partitioned_acq = dict()
            for i in range(batch_size):
                partitioned_space[i] = []
                partitioned_acq[i] = []

            for i in range(x_best_acq_domain.shape[0]):
                partitioned_space[cluster_pred_domain[i]].append(x_best_acq_domain[i])
                partitioned_acq[cluster_pred_domain[i]].append(x_best_acq_value[i])

            batch = []

            for i in partitioned_space:
                x_local = partitioned_space[i]
                acq_local = partitioned_acq[i]
                acq_local = np.array(acq_local)
                x_index = np.argmax(acq_local)
                x_final_selected = x_local[x_index]
                batch.append([x_final_selected])

        else:  # batch_size ==1
            batch = []
            x_index = np.argmax(acquisition_values)
            x_final_selected = self.remove_duplicates_serial(
                X_tries, X_temp, acquisition_values
            )
            # x_final_selected = X_tries[x_index]
            batch.append([x_final_selected])

        batch = np.array(batch)
        batch = batch.reshape(-1, X.shape[1])

        time_end = time.perf_counter()
        time_duration = time_end - time_start
        print(
            f"[ParameterSearchingServer:Optimizer] Optimization took {time_duration:.3f} seconds to select candidates"
        )
        return batch

    """
    Returns the most optmal x along with mean value from the domain of x and making sure it is not a Duplicate (depending on closeness)
    used in batch setting: As mean is also returned
    """

    def remove_duplicates(self, X, X_Sample, mu, Value):
        v_sorting_index = np.argsort(-Value, axis=0)
        index = 0
        # go through all the values in X_Sample and check if anyvalue is close
        # to the optimal x value, if yes, don't consider this optimal x value

        while index < v_sorting_index.shape[0]:
            x_optimal = X[v_sorting_index[index]]

            # check if x_optimal is in X_Sample
            check_closeness = self.closeness(x_optimal, X_Sample)

            if check_closeness == False:  # No close element to x_optimal in X_Sample
                break

                # we will look for next optimal value to try
            else:
                index = index + 1

        # If entire domain is same to the already selected samples, we will just pick the best by value then
        if index == v_sorting_index.shape[0]:
            index = 0

        return X[v_sorting_index[index]], mu[v_sorting_index[index]]

    """
    Returns the most optmal x only from the domain of x and making sure it is not a Duplicate (depending on closeness)
    Intended for usage in serial and clustering setting: As no mean is also returned, and no hullicination is considered
    """

    def remove_duplicates_serial(self, X, X_Sample, Value):
        v_sorting_index = np.argsort(-Value, axis=0)
        index = 0
        # go through all the values in X_Sample and check if anyvalue is close
        # to the optimal x value, if yes, don't consider this optimal x value

        while index < v_sorting_index.shape[0]:
            x_optimal = X[v_sorting_index[index]]

            # check if x_optimal is in X_Sample
            check_closeness = self.closeness(x_optimal, X_Sample)

            if check_closeness == False:  # No close element to x_optimal in X_Sample
                break

                # we will look for next optimal value to try
            else:
                index = index + 1

        # If entire domain is same to the already selected samples, we will just pick the best by value then
        if index == v_sorting_index.shape[0]:
            index = 0

        return X[v_sorting_index[index]]

    def closeness(self, x_optimal, X_Sample):
        # check if x_optimal is close to X_Sample
        tolerance = 1e-3

        for i in range(X_Sample.shape[0]):
            diff = np.sum(np.absolute(X_Sample[i] - x_optimal))
            if diff < tolerance:
                # print('Removed Duplicate')
                return True

        return False
