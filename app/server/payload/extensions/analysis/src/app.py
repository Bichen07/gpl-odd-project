from typing import Optional
import pandas as pd
import numpy as np
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler
import hdbscan
import umap
from ax import optimize
from ax.service.ax_client import AxClient, ObjectiveProperties, TParameterization
from litestar import Litestar, get, post
from dataclasses import dataclass


@get("/")
async def hello_world() -> str:
    return "Hello, world!"


@dataclass
class ClusterRequestBody:
    x: list[list[float]]
    best_parameters: Optional[TParameterization] = None


@dataclass
class ClusterResponseBody:
    clusters: list[int]
    memberships: list[int]


@post("cluster")
async def cluster(data: ClusterRequestBody) -> ClusterResponseBody:
    X = np.array(data.x)
    X_scaled = StandardScaler().fit_transform(X)

    def find_best_hdbscan_hyperparameters(iteration=25):
        ax_client = AxClient()
        ax_client.create_experiment(
            name="finding_best_hdbscan_hyperparameters",
            parameters=[
                {
                    "name": "min_cluster_size",
                    "type": "range",
                    "value_type": "int",
                    "bounds": [3.0, 100.0],
                },
            ],
            objectives={"DBCV": ObjectiveProperties(minimize=False)},
        )

        def evaluate(parameterization):
            clusterer = hdbscan.HDBSCAN(
                min_cluster_size=parameterization.get("min_cluster_size"),
                # min_samples=parameterization.get("min_samples"),
            )
            clusterer.fit(X_scaled)
            dbcv = hdbscan.validity_index(X_scaled, clusterer.labels_)
            return {"DBCV": (dbcv, 0.0)}

        for i in range(iteration):
            parameterization, trial_index = ax_client.get_next_trial()
            evaluation = evaluate(parameterization)
            ax_client.complete_trial(trial_index=trial_index, raw_data=evaluation)

        best_parameters, values = ax_client.get_best_parameters()
        return best_parameters

    if data.best_parameters == None:
        best_parameters = find_best_hdbscan_hyperparameters()
    else:
        best_parameters = data.best_parameters
    clusterer = hdbscan.HDBSCAN(
        min_cluster_size=best_parameters["min_cluster_size"],
    )
    clusterer.fit(X_scaled)

    return ClusterResponseBody(
        clusterer.labels_.tolist(), clusterer.probabilities_.tolist()
    )


@dataclass
class PcaRequestBody:
    x: list[list[float]]


@dataclass
class PcaResponseData:
    x: list[list[float]]
    explainedVarianceRatio: list[float]


@post("pca")
async def pca(data: ClusterRequestBody) -> PcaResponseData:
    X = np.array(data.x)
    X_scaled = StandardScaler().fit_transform(X)
    pca = PCA(n_components=X.shape[1])
    X_pca = pca.fit_transform(X_scaled)
    return PcaResponseData(X_pca.tolist(), pca.explained_variance_ratio_.tolist())


app = Litestar([hello_world, cluster, pca])
