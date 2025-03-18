from shapely.ops import nearest_points, split
from sklearn import svm
import matplotlib.pyplot as plt
from shapely import Polygon, LineString, affinity
from scipy.stats import f_oneway
import dataclasses
from copy import deepcopy
import math
import pandas as pd
import itertools
import numpy as np
from dataclasses import dataclass
from typing import Any, Dict, List, Literal, Optional, Set, Tuple
from litestar.exceptions import HTTPException
import requests
import umap
from FDApy.preprocessing.dim_reduction.mfpca import MFPCA
from FDApy.representation.argvals import DenseArgvals
from FDApy.representation.functional_data import (
    DenseFunctionalData,
    MultivariateFunctionalData,
)
from FDApy.representation.values import DenseValues
from FDApy.visualization import plot_multivariate
from scipy.spatial.distance import squareform, pdist, cdist
from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
import hdbscan
from hdbscan.validity import validity_index
from hdbscan.flat import (
    HDBSCAN_flat,
    approximate_predict_flat,
    membership_vector_flat,
    all_points_membership_vectors_flat,
)
from sklearn.decomposition import PCA
import umap
import json
import math
from pprint import pprint
import pandas as pd
import numpy as np
from scipy.stats import sem
import os
import dataclasses
from dataclasses import dataclass
from litestar import Litestar, get, post
from sklearn.preprocessing import StandardScaler, MinMaxScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.manifold import MDS
from litestar.response import File
from pathlib import Path
from sklearn.cluster import KMeans
from scipy.special import softmax
from sklearn.metrics import (
    calinski_harabasz_score,
    silhouette_score,
    davies_bouldin_score,
)
import requests
from concurrent.futures import ThreadPoolExecutor
from litestar.config.cors import CORSConfig

from litestar import post
from litestar.controller import Controller

import torch
from .gradient import calculate_gradients, train_surrogate_model, predict

from .utils.timer import Timer
from .utils.s_dbw import S_Dbw
from .utils.env import PAYLOAD_GRAPHQL_API, PAYLOAD_API
from .utils.TwoDimTTC import getpoints


def predict_position(x, y, v, theta, t):
    return [x + v * math.cos(theta) * t, y + v * math.sin(theta) * t]


def heading_vector_from_yaw(yaw):
    # type: (float) -> Tuple[float ,float]
    x_component = math.cos(yaw)
    y_component = math.sin(yaw)
    return (x_component, y_component)


def extract_points(geom):
    points = []
    if geom.is_empty:
        return points
    # Single point
    if geom.geom_type == "Point":
        points.append([geom.x, geom.y])
    # Multiple points
    elif geom.geom_type == "MultiPoint":
        points = [[pt.x, pt.y] for pt in geom.geoms]
    # A line segment (or several) - here we take the endpoints
    elif geom.geom_type == "LineString":
        coords = list(geom.coords)
        points.extend([[coords[0][0], coords[0][1]], [coords[-1][0], coords[-1][1]]])
    # If there are multiple line segments
    elif geom.geom_type == "MultiLineString":
        for line in geom.geoms:
            coords = list(line.coords)
            points.extend(
                [[coords[0][0], coords[0][1]], [coords[-1][0], coords[-1][1]]]
            )
    # If a GeometryCollection, iterate through each part
    else:
        for part in geom.geoms:
            points.extend(extract_points(part))
    return points


ClusteringMethod = Literal["hdbscan", "hdbscanFlat", "kmeans", "hierarchy"]


@dataclass
class ClusteringScores:
    calinskiHarabazScore: float
    silhouetteScore: float
    daviesBouldinScore: float
    gapStatisticScore: float
    sDbwScore: float
    dbcvScore: float


@dataclass
class ClusteringTask:
    nClusters: int
    method: ClusteringMethod


@dataclass
class TrialClusterItem:
    trialId: str
    label: str
    probability: float


@dataclass
class AnovaItem:
    fvalue: float
    pvalue: float


@dataclass
class ClusteringResult:
    task: ClusteringTask
    data: Dict[str, TrialClusterItem]
    scores: ClusteringScores
    anova: Dict[str, List[AnovaItem]]


@dataclass
class Dendrogram:
    iCoord: List[List[float]]
    dCoord: List[List[float]]
    trialIds: List[str]


@dataclass
class UmapParameter:
    minDist: float
    nNeighbors: int


@dataclass
class UmapProjection:
    parameters: UmapParameter
    data: Dict[str, List[float]]


@dataclass
class IsoSurfaceItem:
    x: float
    y: float
    value: float


@dataclass
class Pca:
    loadings: List[List[float]]
    explainedVarianceRatio: List[float]
    results: List[Optional[ClusteringResult]]
    projections: Dict[str, List[float]]


@dataclass
class Gradient:
    data: Dict[str, List[List[float]]]
    umapProjections: List[UmapProjection]
    clustering: Pca
    isosurface: List[IsoSurfaceItem]


@dataclass
class MetricGradient:
    metricValue: Dict[str, float]
    data: Dict[str, List[float]]
    clustering: Pca
    # isosurface: List[IsoSurfaceItem]


@dataclass
class Mfpca:
    scores: Dict[str, List[float]]
    timePoints: List[float]
    attributes: List[str]
    fpcs: List[List[List[float]]]
    means: List[List[float]]
    explainedVarianceRatio: List[float]
    nComponents: int
    results: List[Optional[ClusteringResult]]
    dendrogram: Dict[str, Dendrogram]
    durationIndices: Dict[str, List[int]]
    umapProjections: List[UmapProjection]
    # gradients: Dict[str, List[float]]
    gradients: Gradient
    metricGradients: Dict[str, MetricGradient]  # Dict[metricId, MetricGradient]
    metrics: Dict[str, Any]  # Dict[metricId, Metric]
    parameters: Dict[Any, Any]


@dataclass
class TrajectoryAnalysisRequest:
    batchIds: List[str]
    framePeriod: float
    tasks: List[ClusteringTask]


@dataclass
class GridPrediction:
    z: List[List[float]]


@dataclass
class TrajectoryAnalysisResponse:
    request: TrajectoryAnalysisRequest
    batches: Dict[str, Any]
    trials: Dict[str, Any]
    trajectories: Dict[str, Dict[str, List[float]]]
    rawTrajectories: Dict[str, Dict[str, List[float]]]
    columns: List[str]
    clustering: Mfpca
    metricGridPredictions: Dict[str, GridPrediction]
    boundaryGrid: Dict[str, GridPrediction]
    boundaryPaths: Dict[str, List[List[List[float]]]]


@dataclass
class TrajectoryQuery:
    trialId: str
    index: int
    duration: float
    # nFrames: int
    framePeriod: float
    standardized: bool
    forward: bool


class TrajectoryAnalysisController(Controller):
    path = "/trajectory_analysis"

    @post("/")
    async def clustering(
        self, data: TrajectoryAnalysisRequest
    ) -> TrajectoryAnalysisResponse:
        t = Timer("fetch trajectories")
        t.start()
        trajectories_mappings, trial_mappings, batch_mappings = self.get_trajectories(
            data
        )
        t.stop()
        print(len(trial_mappings.keys()))

        columns = []
        fpaColumns = []
        rawTrajs = {}
        trajectories = {}
        i = 0
        for trial_id, item in trajectories_mappings.items():
            i += 1
            print(i)
            time_series = self.get_time_series(item)
            if time_series is None or len(time_series) == 0:
                print("{} time_series is none, continue...".format(trial_id))
                continue
            columns = list(time_series[0].keys())
            columns = [c for c in columns if c != "time"]
            fpaColumns = [
                c
                for c in columns
                if c != "time"
                and "AccReq" not in c
                and "Ttc" not in c
                and "Dce" not in c
                and "RssRatio" not in c
                and "PathBox" not in c
                and "Intersected" not in c
            ]
            trajectories[trial_id] = time_series
            rawTrajs[trial_id] = item
        print(len(trajectories.keys()))

        t = Timer("MFPCA")
        t.start()
        (
            mfpca,
            fpcs_data,
            explained_variance_ratio,
            score_mappings,
            attribute_mean,
            X_rep,
            trial_ids,
            time_points,
            clustering_duration_indices,
        ) = self.get_mfpca(trajectories, data, fpaColumns, trial_mappings)
        t.stop()

        t = Timer("2D umap projection")
        t.start()
        umapProjections = self._get_2d_umap_projections(X_rep, trial_ids)
        t.stop()

        t = Timer("Clustering")
        t.start()
        results, dendro_data = self.cluster(X_rep, X_rep, data, trial_ids)
        t.stop()

        # --------------------------------------------------
        batch = list(batch_mappings.values())[0]
        parameters = batch["scenario"]["parameters"]
        gradient_trial_ids = []
        inputs = []
        for trial_id in trial_ids:
            trial = trial_mappings[trial_id]
            row = []
            failed = False
            for param in parameters:
                param_id = param["id"]
                value = 0
                found = False
                for tp in trial["parameters"]:
                    if tp["parameterId"] == param_id:
                        found = True
                        value = tp["value"]
                    if param["unit"] == "kph":
                        value = value / 3.6
                if not found:
                    failed = True
                    break
                row.append(value)
            if failed:
                continue
            inputs.append(row)
            gradient_trial_ids.append(trial_id)

        scaler_X = MinMaxScaler()
        X_original = torch.Tensor(np.array(inputs))
        X_normalized = torch.Tensor(scaler_X.fit_transform(np.array(inputs)))
        # X = torch.Tensor(inputs)
        Y = torch.Tensor([score_mappings[trial_id] for trial_id in gradient_trial_ids])
        # surrogate_gp, surrogate_likelihood = train_surrogate_model(X_normalized, Y)
        print("TRAIN SURROGATE")
        model = train_surrogate_model(X_normalized, Y)
        gradients = calculate_gradients(model, X_normalized)
        gradient_mappings = {
            id: gradients[i].tolist() for i, id in enumerate(gradient_trial_ids)
        }

        # --------------------------------------------------
        # grid_size = 3
        # values = np.linspace(0, 1, grid_size)
        # x, y, z = np.meshgrid(values, values, values, indexing="ij")
        # grid = np.stack((x, y, z), axis=-1)
        # grid_2d = grid.reshape(-1, 3)
        # grid_gradients = calculate_gradients(model, torch.Tensor(grid_2d))
        # grid_with_gradients = [
        #     IsoSurfaceItem(
        #         coord[0], coord[1], coord[2], float(np.linalg.norm(np.array(grad)))
        #     )
        #     for coord, grad in zip(grid_2d, grid_gradients)
        # ]

        # grid_size = 15
        # values = np.linspace(0, 1, grid_size)
        # x, y = np.meshgrid(values, values, indexing="ij")
        # grid = np.stack((x, y), axis=-1)
        # grid_2d = grid.reshape(-1, 2)
        # grid_gradients = calculate_gradients(model, torch.Tensor(grid_2d))
        # grid_with_gradients = [
        #     IsoSurfaceItem(coord[0], coord[1], float(np.linalg.norm(np.array(grad))))
        #     for coord, grad in zip(grid_2d, grid_gradients)
        # ]

        # --------------------------------------------------

        # --------------------------------------------------
        X_grad = gradients.reshape(gradients.shape[0], -1)
        print("X_grad shape")
        print(X_grad.shape)
        X_grad_scaler = StandardScaler()
        X_grad_scaled = X_grad_scaler.fit_transform(X_grad)

        pca = PCA(n_components=0.99)  # Retain 99% of variance
        X_grad_pca = pca.fit_transform(X_grad_scaled)
        explained_variance = pca.explained_variance_ratio_
        loadings = (
            pca.components_.T
        )  # Transpose to get variables' loadings on each component
        t = Timer("Gradient Clustering")
        t.start()
        grad_clustering_results, grad_dendro = self.cluster(
            X_grad_pca,
            X_grad_scaled,
            data,
            gradient_trial_ids,
        )
        t.stop()

        gradient_clustering = Pca(
            loadings=np.array(loadings, dtype="float64").tolist(),
            explainedVarianceRatio=np.array(
                explained_variance, dtype="float64"
            ).tolist(),
            projections={
                trial_id: np.array(X_grad_pca[i], dtype="float64").tolist()
                for i, trial_id in enumerate(gradient_trial_ids)
            },
            results=grad_clustering_results,
        )

        t = Timer("Gradient 2D umap projection")
        t.start()
        gradUmapProjections = self._get_2d_umap_projections(
            np.array(X_grad_scaled),
            gradient_trial_ids,
        )
        t.stop()
        # --------------------------------------------------

        # --------------------------------------------------
        upload_gradients = {}
        upload_metrics = {}
        used_metrics = ["ttc_min", "collision"]
        # used_metrics = ["dce_min", "collision"]
        # used_metrics = [
        #     "acc_req_max",
        #     "ttc_min",
        #     "collision",
        #     "min_rss_ratio",
        #     "dce_min",
        # ]
        # used_metrics = ["ttc_min", "acc_req_max"]
        metric_grid_predictions = {}
        boundary_grid_predictions = {}
        boundary_paths_predictions = {}
        for used_metric in used_metrics:
            metrics = batch["scenario"]["testObjectives"]["criticalityMetrics"]
            used_metric_name = used_metric
            metric = [
                m
                for m in metrics
                if m["keyPerformanceIndicator"]["name"] == used_metric_name
            ][0]

            upload_metrics[used_metric] = metric
            metric_values = {}
            passed = {}
            for trial_id in gradient_trial_ids:
                trial = trial_mappings[trial_id]
                trial_metric = [
                    m
                    for m in trial["testObjectives"]["criticalityMetrics"]
                    if m["keyPerformanceIndicator"]["id"]
                    == metric["keyPerformanceIndicator"]["id"]
                ][0]
                metric_values[trial_id] = trial_metric["value"]
                passed[trial_id] = trial_metric["passed"]

            boundary_Y = np.array(
                [int(passed[trial_id]) for trial_id in gradient_trial_ids]
            ).reshape(-1, 1)
            # clf = svm.SVC(kernel="rbf", C=1000)
            clf = svm.SVC(kernel="rbf", C=10000)

            X_original_np = X_original.numpy()
            clf.fit(X_original_np, boundary_Y)

            print("X_original_np shape")
            print(X_original_np.shape)
            minx = np.min(X_original_np[:, 0])
            maxx = np.max(X_original_np[:, 0])
            miny = np.min(X_original_np[:, 1])
            maxy = np.max(X_original_np[:, 1])
            xx, yy = np.meshgrid(
                np.linspace(minx, maxx, 500),
                np.linspace(miny, maxy, 500),
            )
            # xx, yy = np.meshgrid(
            #     np.linspace(parameters[0]["min"], parameters[0]["max"], 1000),
            #     np.linspace(parameters[1]["min"], parameters[1]["max"], 1000),
            # )
            Z = clf.decision_function(np.c_[xx.ravel(), yy.ravel()])
            Z = Z.reshape(xx.shape)
            boundary_grid_predictions[used_metric_name] = GridPrediction(z=Z.tolist())

            sign = 1 if metric["keyPerformanceIndicator"]["rule"] == "lessThan" else -1
            # sign = 1
            metric_gradient_Y = torch.Tensor(
                [sign * metric_values[trial_id] for trial_id in gradient_trial_ids]
            ).reshape(-1, 1)
            print("TRAIN METRIC SURROGATE")
            metric_gradient_model = train_surrogate_model(
                X_original, metric_gradient_Y, False, False
            )
            metric_gradients = calculate_gradients(metric_gradient_model, X_original)

            plt.scatter(
                X_original[boundary_Y.ravel() == 1, 0].flatten(),
                X_original[boundary_Y.ravel() == 1, 1].flatten(),
                label="Pass",
                marker="o",
                # color="green",
                facecolors="none",
                edgecolors="green",
            )
            plt.scatter(
                X_original[boundary_Y.ravel() == 0, 0].flatten(),
                X_original[boundary_Y.ravel() == 0, 1].flatten(),
                label="Fail",
                marker="x",
                color="red",
            )

            contours = plt.contour(
                xx, yy, Z, levels=[0], linewidths=2, colors="blue", linestyles="dashed"
            )  # Decision boundary

            # Extract contour points
            boundary_paths = []
            for collection in contours.collections:
                for path in collection.get_paths():
                    boundary_paths.append(path.vertices.tolist())
            boundary_paths_predictions[used_metric] = boundary_paths

            plt.contour(
                xx,
                yy,
                Z,
                levels=[-1, 1],
                linewidths=1,
                colors="gray",
                linestyles="dotted",
            )  # Margins

            plt.xlabel("TriggerDistance [m]")
            plt.ylabel("OncomingSpeed [mps]")
            plt.title("Non-linear SVM Boundary (RBF Kernel)")
            plt.legend()
            plt.grid(True)
            plt.show()

            # metric_gradient_model = train_surrogate_model(
            #     X_normalized, metric_gradient_Y, False, False
            # )
            # metric_gradients = calculate_gradients(metric_gradient_model, X_normalized)
            # metric_gradient_model = train_surrogate_model(
            #     X_normalized, metric_gradient_Y, True, False
            # )
            # metric_gradients = calculate_gradients(metric_gradient_model, X_normalized)
            metric_gradient_mappings = {
                id: metric_gradients[i].tolist()
                for i, id in enumerate(gradient_trial_ids)
            }

            grid_size = 25
            values = np.linspace(0, 1, grid_size)
            x, y = np.meshgrid(values, values, indexing="ij")
            grid = np.stack((x, y), axis=-1)
            grid_2d = grid.reshape(-1, 2)
            scaled_grid_2d = scaler_X.inverse_transform(grid_2d)

            # grid_gradients = calculate_gradients(
            #     metric_gradient_model, torch.Tensor(scaled_grid_2d)
            # )
            # grid_with_gradients = [
            #     IsoSurfaceItem(
            #         coord[0], coord[1], float(np.linalg.norm(np.array(grad)))
            #     )
            #     for coord, grad in zip(grid_2d, grid_gradients)
            # ]

            print("metric gradients shape")
            print(metric_gradients.shape)
            metric_gradients = metric_gradients.reshape(metric_gradients.shape[0], -1)
            print("metric gradients shape")
            print(metric_gradients.shape)
            scaler = StandardScaler()
            X_metric_grad_scaled = scaler.fit_transform(metric_gradients)
            pca = PCA(n_components=0.99)  # Keep both components for visualization
            X_metric_grad_pca = pca.fit_transform(X_metric_grad_scaled)
            explained_variance = pca.explained_variance_ratio_
            loadings = (
                pca.components_.T
            )  # Transpose to get variables' loadings on each component

            t = Timer("Gradient Clustering")
            t.start()
            grad_clustering_results, grad_dendro = self.cluster(
                X_metric_grad_pca,
                X_metric_grad_scaled,
                data,
                gradient_trial_ids,
            )
            t.stop()

            # Plot the PCA results
            # plt.figure(figsize=(8, 6))
            # plt.scatter(
            #     X_metric_grad_pca[:, 0],
            #     X_metric_grad_pca[:, 1],
            #     alpha=0.6,
            #     edgecolor="k",
            #     label="Projected Data",
            # )
            # plt.axhline(0, color="gray", linestyle="--", linewidth=0.5)
            # plt.axvline(0, color="gray", linestyle="--", linewidth=0.5)
            #
            # # Label the axes with the explained variance ratio
            # plt.xlabel(
            #     f"Principal Component 1 ({pca.explained_variance_ratio_[0]*100:.2f}% Variance)"
            # )
            # plt.ylabel(
            #     f"Principal Component 2 ({pca.explained_variance_ratio_[1]*100:.2f}% Variance)"
            # )
            # plt.title("PCA Projection of Data")
            # plt.legend()
            # plt.grid(True)
            # plt.show()

            metric_gradient_clustering = Pca(
                loadings=np.array(loadings, dtype="float64").tolist(),
                explainedVarianceRatio=np.array(
                    explained_variance, dtype="float64"
                ).tolist(),
                projections={
                    trial_id: np.array(X_grad_pca[i], dtype="float64").tolist()
                    for i, trial_id in enumerate(gradient_trial_ids)
                },
                results=grad_clustering_results,
            )

            grad = MetricGradient(
                metric_values, metric_gradient_mappings, metric_gradient_clustering
            )
            upload_gradients[used_metric] = grad

            print("grid_predictions")
            grid_predictions = predict(
                metric_gradient_model, torch.Tensor(scaled_grid_2d)
            )
            grid_predictions = np.array(grid_predictions.tolist()).reshape(
                grid_size, grid_size
            )
            grid_predictions = sign * grid_predictions
            # grid_predictions = np.array(grid_predictions.tolist()).flatten()
            print(grid_predictions.shape)
            metric_grid_predictions[used_metric_name] = GridPrediction(
                z=grid_predictions.tolist()
            )

        # t = Timer("Gradient 2D umap projection")
        # t.start()
        # X_grad = metric_gradients.reshape(gradients.shape[0], -1)
        # print("X_grad shape")
        # print(X_grad.shape)
        # X_grad_scaler = StandardScaler()
        # X_grad_scaled = X_grad_scaler.fit_transform(X_grad)
        # metricGradUmapProjections = self._get_2d_umap_projections(
        #     np.array(X_grad_scaled),
        #     gradient_trial_ids,
        # )
        # t.stop()
        # --------------------------------------------------

        clustering = Mfpca(
            scores=deepcopy(score_mappings),
            timePoints=deepcopy(time_points.tolist()),
            attributes=deepcopy(columns),
            nComponents=mfpca.n_components,
            fpcs=deepcopy(fpcs_data),
            means=deepcopy(attribute_mean),
            explainedVarianceRatio=deepcopy(explained_variance_ratio.tolist()),
            results=deepcopy(results),
            dendrogram={
                "hierarchy": Dendrogram(
                    iCoord=dendro_data["hierarchy"]["iCoord"],
                    dCoord=dendro_data["hierarchy"]["dCoord"],
                    trialIds=dendro_data["hierarchy"]["trialIds"],
                ),
            },
            durationIndices=clustering_duration_indices,
            umapProjections=deepcopy(umapProjections),
            parameters=parameters,
            gradients=Gradient(
                gradient_mappings,
                gradUmapProjections,
                gradient_clustering,
                # grid_with_gradients,
                [],
            ),
            metricGradients=upload_gradients,
            metrics=upload_metrics,
        )

        return TrajectoryAnalysisResponse(
            request=data,
            trials=trial_mappings,
            batches=batch_mappings,
            trajectories=trajectories,
            rawTrajectories=rawTrajs,
            columns=columns,
            clustering=clustering,
            metricGridPredictions=metric_grid_predictions,
            boundaryGrid=boundary_grid_predictions,
            boundaryPaths=boundary_paths_predictions,
        )

    def get_trajectories(self, data: TrajectoryAnalysisRequest):
        batch_query = """
            query GetBatch($id: String!) {
                Batch(id: $id) {
                    id
                    scenario {
                        parameters {
                            id
                            name
                            min
                            max
                            unit
                        }
                        testObjectives {
                            criticalityMetrics {
                                id
                                threshold
                                keyPerformanceIndicator { 
                                    id 
                                    name
                                    rule
                                    unit
                                }
                            }
                        }
                    }
                    trials {
                        id
                        parameters {
                            parameterId
                            value
                        }
                        events {
                            name
                            time
                            esminiSeconds
                            observationIndex
                        }
                        testObjectives {
                            criticalityMetrics {
                                id
                                value
                                passed
                                keyPerformanceIndicator {
                                    id
                                    name
                                    rule
                                    unit
                                }
                            }
                        }
                    }
                }
            } 
        """
        trial_query = """
            query GetTrial($id: String!) {
                Trial(id: $id) {
                    id
                    observations {
                        id
                        egoX
                        egoY
                        agents {
                            name
                            x
                            y
                        }
                    }
                }
            } 
        """
        trajectory_queries = []
        trial_mappings = {}
        batch_mappings = {}
        for batchId in data.batchIds:
            variables = {"id": batchId}
            response_data = requests.post(
                str(PAYLOAD_GRAPHQL_API),
                json={"query": batch_query, "variables": variables},
            ).json()
            batch = response_data["data"]["Batch"]
            batch_mappings[batchId] = {"id": batchId, "scenario": batch["scenario"]}
            # print(batchId)
            # print(batch)

            # response_data = requests.get(
            #     str(PAYLOAD_API) + f"/batches/{batchId}?depth=1",
            # ).json()
            # pprint(response_data)
            # batch = response_data["data"]["doc"]

            scenario_parameters = batch["scenario"]["parameters"]
            sorted(scenario_parameters, key=lambda p: p["id"])

            batch_trials = []

            # pprint(batch)
            for trial in batch["trials"]:
                if trial is None or trial["testObjectives"] is None:
                    continue

                if (
                    (
                        (
                            batch["id"] == "66b33556840605cf386ea226"
                            and trial["parameters"][1]["value"] > 60
                        )
                        or (
                            batch["id"] == "669e071aa2d2efa08f082800"
                            and trial["parameters"][1]["value"] > 55
                        )
                    )
                    or trial["id"] == "66b934c3a806981f8860aa63"
                    or (
                        batch["id"] == "674a8015dfa0b36b163d9234"
                        and trial["parameters"][0]["value"] > 18
                    )
                ):
                    print(f"continue trial {trial['id']}")
                    continue

                # trial["testObjectives"]["criticalityMetrics"][2]["value"] -= 0.579
                trial["testObjectives"]["criticalityMetrics"][2]["value"] -= 0.579

                batch_trials.append(trial)
                trial["batchId"] = batchId
                trial_mappings[trial["id"]] = trial

                trajectory_queries.append(
                    TrajectoryQuery(
                        trialId=trial["id"],
                        index=-1,
                        duration=-1,
                        framePeriod=data.framePeriod,
                        standardized=False,
                        forward=False,
                    )
                )

        def split_into_chunks(lst, chunk_size):
            """Splits the list `lst` into chunks of size `chunk_size` using list comprehension."""
            return [lst[i : i + chunk_size] for i in range(0, len(lst), chunk_size)]

        trajectories_data = []
        trajectory_queries_chunks = split_into_chunks(trajectory_queries, 100)
        for index, chunk in enumerate(trajectory_queries_chunks):
            t = Timer("Get Trajectories" + f", chunk: {index}")
            t.start()
            response = requests.post(
                PAYLOAD_API + "/trials" + "/trajectories",
                json={"queries": [dataclasses.asdict(query) for query in chunk]},
            )
            trajectories_data += response.json()
            t.stop()
            # if index >= 1:
            #     break

        trajectories_mappings = {item["trialId"]: item for item in trajectories_data}

        return trajectories_mappings, trial_mappings, batch_mappings

    def get_time_series(self, item) -> Optional[List[Dict[str, float]]]:
        agent_names = [agent_name for agent_name in item["trajectory"]]
        sorted(agent_names)

        contains_nan = False
        ego_df = pd.DataFrame(item["trajectory"]["Ego"])

        time_series = []
        for i, time in enumerate(item["time"]):
            row = {}
            row["time"] = time
            # row["x"] = ego_df["x"].iloc[i]
            # row["y"] = ego_df["y"].iloc[i]
            # row["yaw"] = ego_df["yaw"].iloc[i]
            row["EgoSpeed"] = ego_df["speed"].iloc[i]
            row["EgoAcceleration"] = ego_df["acceleration"].iloc[i]
            row["EgoYawRate"] = ego_df["yawRate"].iloc[i]
            ego_x = ego_df["x"].iloc[i]
            ego_y = ego_df["y"].iloc[i]

            for agent_name in agent_names[1:]:
                agent_label = agent_name
                df = pd.DataFrame(item["trajectory"][agent_name])

                # ego_heading = heading_vector_from_yaw(ego_df["yaw"].iloc[i])
                # agent_heading = heading_vector_from_yaw(df["yaw"].iloc[i])
                # pair_sample = pd.DataFrame(
                #     {
                #         "x_i": [ego_df["x"].iloc[i]],
                #         "y_i": [ego_df["y"].iloc[i]],
                #         "vx_i": [ego_df["speed"].iloc[i] * ego_heading[0]],
                #         "vy_i": [ego_df["speed"].iloc[i] * ego_heading[1]],
                #         "hx_i": [ego_heading[0]],
                #         "hy_i": [ego_heading[1]],
                #         "length_i": [5.14],
                #         "width_i": [2.45],
                #         "x_j": [df["x"].iloc[i]],
                #         "y_j": [df["y"].iloc[i]],
                #         "vx_j": [df["speed"].iloc[i] * agent_heading[0]],
                #         "vy_j": [df["speed"].iloc[i] * agent_heading[1]],
                #         "hx_j": [agent_heading[0]],
                #         "hy_j": [agent_heading[1]],
                #         "length_j": [df["length"].iloc[i]],
                #         "width_j": [df["width"].iloc[i] + 0.25],
                #     }
                # )
                #
                # (
                #     point_i1,
                #     point_i2,
                #     point_i3,
                #     point_i4,
                #     point_j1,
                #     point_j2,
                #     point_j3,
                #     point_j4,
                # ) = getpoints(pair_sample)
                #
                # point_i1 = point_i1.flatten()
                # point_i2 = point_i2.flatten()
                # point_i3 = point_i3.flatten()
                # point_i4 = point_i4.flatten()
                # point_j1 = point_j1.flatten()
                # point_j2 = point_j2.flatten()
                # point_j3 = point_j3.flatten()
                # point_j4 = point_j4.flatten()
                #
                # ttc_max = 5
                # ppi1 = predict_position(
                #     point_i1[0],
                #     point_i1[1],
                #     ego_df["speed"].iloc[i],
                #     ego_df["yaw"].iloc[i],
                #     ttc_max,
                # )
                # ppi2 = predict_position(
                #     point_i2[0],
                #     point_i2[1],
                #     ego_df["speed"].iloc[i],
                #     ego_df["yaw"].iloc[i],
                #     ttc_max,
                # )
                # ppi3 = predict_position(
                #     point_i3[0],
                #     point_i3[1],
                #     ego_df["speed"].iloc[i],
                #     ego_df["yaw"].iloc[i],
                #     ttc_max,
                # )
                #
                # ppi4 = predict_position(
                #     point_i4[0],
                #     point_i4[1],
                #     ego_df["speed"].iloc[i],
                #     ego_df["yaw"].iloc[i],
                #     ttc_max,
                # )
                # ppj1 = predict_position(
                #     point_j1[0],
                #     point_j1[1],
                #     df["speed"].iloc[i],
                #     df["yaw"].iloc[i],
                #     ttc_max,
                # )
                # ppj2 = predict_position(
                #     point_j2[0],
                #     point_j2[1],
                #     df["speed"].iloc[i],
                #     df["yaw"].iloc[i],
                #     ttc_max,
                # )
                # ppj3 = predict_position(
                #     point_j3[0],
                #     point_j3[1],
                #     df["speed"].iloc[i],
                #     df["yaw"].iloc[i],
                #     ttc_max,
                # )
                # ppj4 = predict_position(
                #     point_j4[0],
                #     point_j4[1],
                #     df["speed"].iloc[i],
                #     df["yaw"].iloc[i],
                #     ttc_max,
                # )
                #
                # # row[agent_label + "EgoPathBox"] = [
                # #     ppi1,
                # #     ppi2,
                # #     list(point_i3),
                # #     list(point_i4),
                # # ]
                # # row[agent_label + "AgentPathBox"] = [
                # #     ppj1,
                # #     ppj2,
                # #     list(point_j3),
                # #     list(point_j4),
                # # ]
                #
                # item["trajectory"]["Ego"][i]["agent_path_box"] = [
                #     ppi1,
                #     ppi2,
                #     list(point_i3),
                #     list(point_i4),
                # ]
                # item["trajectory"][agent_label][i]["ego_path_box"] = [
                #     ppi1,
                #     ppi2,
                #     list(point_i3),
                #     list(point_i4),
                # ]
                # item["trajectory"][agent_label][i]["agent_path_box"] = [
                #     ppj1,
                #     ppj2,
                #     list(point_j3),
                #     list(point_j4),
                # ]
                #
                # ego_path_box = Polygon([ppi1, ppi2, point_i4, point_i3])
                # agent_path_box = Polygon([ppj1, ppj2, point_j3, point_j4])
                #
                # row[agent_label + "isPathIntersected"] = 0
                # found_smaller_ttc = False
                # if ego_path_box.intersects(agent_path_box):
                #     row[agent_label + "isPathIntersected"] = 1
                #
                #     # Compute the intersection of their boundaries
                #     intersection = ego_path_box.boundary.intersection(
                #         agent_path_box.boundary
                #     )
                #     intersected_points = extract_points(intersection)
                #
                #     min_dist = 1000
                #     for p in intersected_points:
                #         dist = math.sqrt(
                #             (point_i1[0] - p[0]) ** 2 + (point_i1[1] - p[1]) ** 2
                #         )
                #         min_dist = dist if dist < min_dist else min_dist
                #
                #     min_dist_agent = 1000
                #     for p in intersected_points:
                #         dist = math.sqrt(
                #             (point_j1[0] - p[0]) ** 2 + (point_j1[1] - p[1]) ** 2
                #         )
                #         min_dist_agent = (
                #             dist if dist < min_dist_agent else min_dist_agent
                #         )
                #
                #     row[agent_label + "Dce"] = float(min_dist)
                #     # agent["dce"] = min(agent["relativeDistance"], self.dce_max)
                #     # # agent["dce"] = min(min_dist, self.dce_max)
                #     #
                #     # if snapshot["egoSpeed"] != 0:
                #     #     ttc = min_dist / snapshot["egoSpeed"]
                #     # else:
                #     #     ttc = self.ttc_max
                #     #
                #     if df["speed"].iloc[i] > 0.001:
                #         row[agent_label + "Dce"] = max(
                #             float(min_dist), float(min_dist_agent)
                #         )
                #         # ttc = max(ttc, min_dist_agent / agent["speed"])
                # else:
                #     dce_max = 10
                #     row[agent_label + "Dce"] = max(
                #         float(df["relativeDistance"].iloc[i]), dce_max
                #     )

                # ego_agent_distance = math.sqrt((df["x"].iloc[i] - ego_x) ** 2 + (df["y"].iloc[i] - ego_y) ** 2)
                # row[agent_label + "RelativeDistance"] = max(df["relativeDistance"].iloc[i], ego_agent_distance)
                row[agent_label + "RelativeDistance"] = df["relativeDistance"].iloc[i]
                row[agent_label + "RelativeTheta"] = math.atan2(
                    df["localY"].iloc[i], df["localX"].iloc[i]
                )
                # row[agent_label + "RelativeX"] = df["localX"].iloc[i]
                # row[agent_label + "RelativeY"] = df["localY"].iloc[i]
                # row[agent_label + "RelativeYaw"] = df["localYaw"].iloc[i]
                row[agent_label + "RelativeVelocityX"] = df["relativeVelocityX"].iloc[i]
                row[agent_label + "RelativeVelocityY"] = df["relativeVelocityY"].iloc[i]
                # row[agent_label + "Ttc"] = float(df["ttc"].iloc[i])
                # row[agent_label + "Dce"] = float(df["dce"].iloc[i])
                # row[agent_label + "Dce"] = (
                #     float(row[agent_label + "RelativeDistance"])
                #     if float(row[agent_label + "RelativeDistance"]) > 10
                #     else row[agent_label + "Dce"]
                # )

                # row[agent_label + "RelativeYawRate"] = df["relativeYawRate"].iloc[i]
                # time_series[agent_label + "RelativeYawRate"] = df[
                #     "relativeYawRate"
                # ].to_numpy()

                # row[agent_label + "AccReq"] = max(
                #     10,
                #     float(
                #         (10 if np.isnan(df["accReq"].iloc[i]) else df["accReq"].iloc[i])
                #     ),
                # )
                # row[agent_label + "Ttc"] = float(
                #     (10 if np.isnan(df["ttc"].iloc[i]) else df["ttc"].iloc[i])
                # )
                # row[agent_label + "RssRatio"] = float(
                #     (4 if np.isnan(df["rssRatio"].iloc[i]) else df["rssRatio"].iloc[i])
                # )

            contains_nan = False
            for value in row.values():
                if np.isnan(value).any():
                    contains_nan = True
                    break
            if contains_nan:
                continue

            time_series.append(row)

        return time_series

    def get_mfpca(
        self,
        trajectories,
        request: TrajectoryAnalysisRequest,
        columns: List[str],
        trial_mappings,
    ):
        # time_series_df = pd.DataFrame(time_series)
        # time_series_df = time_series_df.drop(columns=["time"])
        X = []
        time_points = []
        trial_ids = []
        clustering_duration = 5
        frame_period = request.framePeriod
        indicies_length = int(clustering_duration / frame_period)
        attributes = list(list(trajectories.values())[0][0].keys())
        # relativeDistanceColumnName = "OncomingRelativeDistance"
        # print(relativeDistanceColumnName)
        # realativeDistanceColumnName = [
        #     column
        #     for column in list(trajectories.values())[0]
        #     if "RelativeDistance" in column
        # ][0]
        # relativeYColumnName = [column for column in columns if "RelativeY" in column][0]
        clustering_duration_indices = {}
        for trial_id, trajectory in trajectories.items():
            target_index = 0
            min_idx = len(trajectory) - 1
            min_dist = float("inf")
            min_ttc = float("inf")
            min_relative_x = float("inf")
            trial = trial_mappings[trial_id]

            collided_with_parking = False
            collided_with_bicycle = False
            for event in trial["events"]:
                if "collisionWithParking" in event["name"]:
                    collided_with_parking = True
                    break
                if "collisionWithBicycle" in event["name"]:
                    collided_with_bicycle = True
                    break

            for attribute in attributes:
                if "RelativeDistance" not in attribute:
                    continue

                agentName = attribute.split("RelativeDistance")[0]
                # if agentName != "Oncoming" or agentName != "Opposite":
                if agentName == "Parking" or agentName == "Bicycle":
                    continue

                # if "Ttc" not in attribute:
                #     continue
                # agentName = attribute.split("Ttc")[0]
                # ttcs = [item[attribute] for item in trajectory]
                # attribute_min_ttc = min(ttcs)
                # if attribute_min_ttc < min_ttc:
                #     min_idx = ttcs.index(attribute_min_ttc)
                #     min_ttc = min(min_ttc, attribute_min_ttc)

                # not working comment out
                # if "Dce" not in attribute:
                #     continue
                # agentName = attribute.split("Dce")[0]
                # dces = [item[attribute] for item in trajectory]
                # attribute_min_dce = min(dces)
                # if attribute_min_dce < min_dist:
                #     min_idx = dces.index(attribute_min_dce)
                #     min_dist = min(min_dist, attribute_min_dce)

                # if "RelativeDistance" not in attribute:
                #     continue
                # agentName = attribute.split("RelativeDistance")[0]
                # # if not collided_with_parking and agentName == "Parking":
                # #     continue
                # # if not collided_with_bicycle and agentName == "Bicycle":
                # #     continue
                # # relative_xs = [item[agentName + "RelativeX"] for item in trajectory]

                relative_thetas = [
                    item[agentName + "RelativeTheta"] for item in trajectory
                ]
                distances = [item[attribute] for item in trajectory]
                attribute_min_distance = min(distances)
                if attribute_min_distance < min_dist:
                    min_idx = distances.index(attribute_min_distance)
                    relative_theta = relative_thetas[min_idx]
                    # if (relative_theta > 0 and relative_theta > 3.14 / 1.95) or (
                    #     relative_theta < 0 and relative_theta < -3.14 / 1.95
                    # ):
                    #     continue
                    min_dist = min(min_dist, attribute_min_distance)

                    # print(trial_id)
                    # print(agentName)
                    # print(min_dist)
                    # print(min_idx)
                    # print("\n")

            # if min_dist > 10:
            #     print("min distance to large, ignore")
            #     continue

            # print("distances")
            # pprint(distances)
            # print("min_idx")
            # pprint(min_idx)
            # print("indicies_length")
            # print(indicies_length)
            start_idx = int(min_idx - indicies_length)
            end_idx = int(min_idx)
            if min_dist > 10 and start_idx < 0:
                idx_length = len(trajectory)
                end_idx = idx_length - 1
                start_idx = int(end_idx - indicies_length)
                print(
                    f"{trial_id} start_idx {start_idx} cannot fit to trajectory, use last idx as end_idx"
                )
            elif start_idx < 0:
                start_idx = 0
                end_idx = int(start_idx + indicies_length)
                print(
                    f"{trial_id} start_idx {start_idx} cannot fit to trajectory, use 0 idx"
                )
            trajectory_slice = trajectory[start_idx : end_idx + 1]
            # if trajectory_slice[-1]["OncomingRelativeX"] < -2.0:
            #     print("Oncoming RelativeX is negative, ignore")
            #     continue
            series = []
            time_points = []
            time_point = 0
            for item in trajectory_slice:
                time_points.append(time_point)
                snapshot = []
                for column in columns:
                    snapshot.append(item[column])
                series.append(snapshot)
                time_point += frame_period
            clustering_duration_indices[trial_id] = [start_idx, end_idx]

            if len(series) == 0 or (len(X) > 0 and len(series) != len(X[0])):
                print("SERIES NOT SAME SIZE, CONTINUE>>>>")
                continue

            X.append(series)
            trial_ids.append(trial_id)

        X = np.array(X)
        time_points = np.array(time_points)

        # Assuming X is of shape (n_samples, n_time_points, n_variables)
        n_samples, n_time_points, n_variables = X.shape
        attribute_mean = []
        # For each variable, standardize (center and scale)
        for var_index in range(n_variables):
            # Extract the data for this variable across all samples and time points
            data_var = X[:, :, var_index]

            # Compute the mean and standard deviation for each variable
            mean_var = np.mean(
                data_var, axis=0
            )  # Mean across samples, shape (n_time_points,)
            attribute_mean.append(mean_var.astype("float64").tolist())

        list_of_fd = []
        for var_index in range(X.shape[2]):
            # Extract data for the current variable
            # data_var = X_normalized[
            #     :, :, var_index
            # ]  # Shape: (n_samples, n_time_points)
            data_var = X[:, :, var_index]  # Shape: (n_samples, n_time_points)

            # Create DenseFunctionalData object for this variable
            fd_var = DenseFunctionalData(
                argvals=DenseArgvals({"input_dim_0": time_points}),
                values=DenseValues(data_var),
            )

            list_of_fd.append(fd_var)

        # Combine into a MultivariateFunctionalData object
        multivariate_fd = MultivariateFunctionalData(list_of_fd)
        univariate_expansions = [
            {"method": "UFPCA", "n_components": 15, "method_smoothing": "PS"}
            for _ in range(X.shape[2])
        ]
        t = Timer("mfpca")
        t.start()
        mfpca = MFPCA(
            n_components=0.99,
            method="covariance",
            univariate_expansions=univariate_expansions,
            normalize=True,
        )
        mfpca.fit(multivariate_fd, scores_method="PACE")
        scores = mfpca.transform(multivariate_fd)
        X_rep = scores
        print("score shape [1]")
        print(scores.shape[1])
        t.stop()

        eigenvalues = mfpca.eigenvalues
        total_variance = np.sum(eigenvalues)
        explained_variance_ratio = eigenvalues / total_variance
        cumulative_variance_ratio = np.array(
            np.cumsum(explained_variance_ratio), dtype="float64"
        ).tolist()

        fpcs_data = []
        for n, fd in enumerate(mfpca.eigenfunctions.data):
            fd = fd.to_grid()
            fpcs_data.append(np.array(fd.values, dtype="float64").tolist())

        score_mappings: Dict[str, List[float]] = {}
        for i, trialId in enumerate(trial_ids):
            score_mappings[trialId] = scores[i].tolist()

        return (
            mfpca,
            fpcs_data,
            explained_variance_ratio,
            score_mappings,
            attribute_mean,
            X_rep,
            trial_ids,
            time_points,
            clustering_duration_indices,
        )

    def cluster(
        self,
        X_rep,
        X_raw,
        data: TrajectoryAnalysisRequest,
        trialIds: List[str],
    ):
        results: List[ClusteringResult | None] = []
        X_raw = X_raw.astype(np.float64)
        X = X_rep.astype(np.float64)
        X_rep = X
        print("CLustering X shape")
        print(X.shape)

        dendro_data = {}
        Z = linkage(X, method="ward")
        # Generate dendrogram data without plotting
        dendro = dendrogram(Z, no_plot=True)
        # Extract coordinates and leaf node indices
        dendro_data["hierarchy"] = {
            "iCoord": dendro["icoord"],
            "dCoord": dendro["dcoord"],
            "trialIds": [
                trialIds[trial_id_idx] for trial_id_idx in dendro["leaves"]
            ],  # This provides the indices of the original samples
        }

        hdbscan_clusterer = hdbscan.HDBSCAN(
            min_cluster_size=10, prediction_data=True
        ).fit(X)
        # Convert to linkage format
        # Z_hdbscan = hdbscan_clusterer.single_linkage_tree_.to_numpy()
        # dendro = dendrogram(Z_hdbscan, no_plot=False)
        # dendro_data["hdbscan"] = {
        #     "iCoord": dendro["icoord"],
        #     "dCoord": dendro["dcoord"],
        #     "trialIds": [
        #         trialIds[trial_id_idx] for trial_id_idx in dendro["leaves"]
        #     ],  # This provides the indices of the original samples
        # }

        def execute_task(task):
            try:
                validity_index_score = None
                cluster_labels = []
                if task.method == "hdbscanFlat" and task.nClusters >= 2:
                    cluster_labels = fcluster(
                        Z_hdbscan, task.nClusters, criterion="maxclust"
                    )
                    centroids = np.array(
                        [
                            X[cluster_labels == i].mean(axis=0)
                            for i in range(task.nClusters)
                        ]
                    )
                    distances = cdist(X, centroids)
                    cluster_probabilities = softmax(-distances, axis=1)
                    probabilities = np.max(cluster_probabilities, axis=1)
                    # clusterer = HDBSCAN_flat(
                    #     X,
                    #     n_clusters=task.nClusters,
                    #     cluster_selection_method="leaf",
                    # )
                    # soft_clusters = all_points_membership_vectors_flat(clusterer)
                    # probabilities = np.array([np.max(x) for x in soft_clusters])
                    # cluster_labels = np.array([np.argmax(x) for x in soft_clusters])
                    # clusterer = hdbscan.HDBSCAN(
                    #     min_cluster_size=10, prediction_data=True
                    # ).fit(X)
                    # soft_clusters = hdbscan.all_points_membership_vectors(clusterer)
                    # probabilities = np.array([np.max(x) for x in soft_clusters])
                    # cluster_labels = np.array([np.argmax(x) for x in soft_clusters])
                elif task.method == "hdbscan":
                    clusterer = hdbscan_clusterer
                    soft_clusters = hdbscan.all_points_membership_vectors(clusterer)
                    probabilities = np.array([np.max(x) for x in soft_clusters])
                    cluster_labels = np.array([np.argmax(x) for x in soft_clusters])
                elif task.method == "hierarchy":
                    cluster_labels = fcluster(Z, task.nClusters, criterion="maxclust")
                    # centroids = np.array(
                    #     [
                    #         X[cluster_labels == i].mean(axis=0)
                    #         for i in range(task.nClusters)
                    #     ]
                    # )
                    # distances = cdist(X, centroids)
                    # cluster_probabilities = softmax(-distances, axis=1)
                    # probabilities = np.max(cluster_probabilities, axis=1)
                    linkage_distances = Z[:, 2]  # Third column is the distance
                    # print(linkage_distances)
                    ward_values = np.zeros(len(cluster_labels))
                    # Iterate over the linkage matrix
                    for i in range(Z.shape[0]):
                        cluster1, cluster2, ward_value, _ = Z[i]
                        cluster1, cluster2 = int(cluster1), int(cluster2)
                        # If cluster1 and cluster2 are individual points, assign the Ward value to them
                        if cluster1 < len(cluster_labels):
                            ward_values[cluster1] = ward_value
                        if cluster2 < len(cluster_labels):
                            ward_values[cluster2] = ward_value
                    probabilities = 1 / ward_values
                else:
                    kmeans = KMeans(n_clusters=task.nClusters, random_state=42)
                    kmeans.fit(X)
                    cluster_labels = kmeans.labels_
                    distances = kmeans.transform(X)
                    cluster_probabilities = softmax(-distances, axis=1)
                    probabilities = np.max(cluster_probabilities, axis=1)

                cluster_items = [
                    TrialClusterItem(
                        trialIds[i],
                        str(int(cluster_labels[i])),
                        float(probabilities[i]),
                    )
                    for i in range(len(cluster_labels))
                ]

                return (task, cluster_labels, cluster_items, validity_index_score)
            except:
                return None

        def execute_tasks_in_parallel(tasks):
            with ThreadPoolExecutor() as executor:
                taskOutputs = list(executor.map(execute_task, tasks))
            for i, output in enumerate(taskOutputs):
                if output is None:
                    results.append(None)
                    continue

                (task, cluster_labels, cluster_items, validity_index_score) = output
                t = Timer(f"scoring and append clustering result {i}")
                t.start()
                print("APPEND TASK RESULT")
                print(task)

                anova: Dict[str, List[AnovaItem]] = {}
                try:
                    validity_value = float(validity_index(X_rep, cluster_labels))
                except:
                    print("Failed to calculate validity index")
                    validity_value = 0
                if cluster_labels is None or len(cluster_labels) <= 1:
                    scores = ClusteringScores(
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                    )
                else:
                    try:
                        scores = ClusteringScores(
                            float(calinski_harabasz_score(X_rep, cluster_labels)),
                            float(silhouette_score(X_rep, cluster_labels)),
                            float(davies_bouldin_score(X_rep, cluster_labels)),
                            # float(gapstat_score(X, cluster_labels)),
                            0.0,
                            float(S_Dbw(X_rep, cluster_labels)),
                            validity_value,
                        )

                    except:
                        scores = ClusteringScores(
                            0.0,
                            -1.0,
                            0.0,
                            0.0,
                            0.0,
                            -1.0,
                        )

                    uniques = np.unique(cluster_labels)
                    for unique in uniques:
                        binary_labels = np.where(cluster_labels == unique, 1, 0)
                        anova_items = []
                        for feature in X_raw.T:  # Iterate over features (columns in X)
                            group_one = feature[binary_labels == 1]
                            group_rest = feature[binary_labels == 0]
                            f_value, p_value = f_oneway(group_one, group_rest)
                            anova_items.append(
                                AnovaItem(fvalue=float(f_value), pvalue=float(p_value))
                            )
                        anova[str(unique)] = anova_items

                results.append(
                    ClusteringResult(
                        task=task,
                        data={item.trialId: item for item in cluster_items},
                        scores=scores,
                        anova=anova,
                    )
                )
                t.stop()

        execute_tasks_in_parallel(data.tasks)

        return results, dendro_data

    def _get_2d_umap_projections(self, X, trialIds):
        # min_dists = [0.3, 0.5, 0.7, 0.99]
        min_dists = [0.8]
        n_neighbors = [
            # 30,
            # 50,
            # 100,
            int(X.shape[0] / 5),
            # int(X.shape[0] / 2),
            # int(X.shape[0] - 5),
        ]

        result: List[UmapProjection] = []
        for min_dist, n_neighbor in itertools.product(min_dists, n_neighbors):
            if n_neighbor <= 0 or n_neighbor > X.shape[0]:
                print(f"n_neighbor: {n_neighbor}, X.shape[0]: {X.shape[0]}, not good")
                continue

            parameters = UmapParameter(min_dist, n_neighbor)
            um = umap.UMAP(
                n_neighbors=n_neighbor,
                min_dist=min_dist,
            )
            X_red = um.fit_transform(X)
            X_red = X_red.astype(dtype=float)

            data: Dict[str, List[float]] = {}
            for i, trialId in enumerate(trialIds):
                data[trialId] = list(X_red[i])

            result.append(UmapProjection(parameters=parameters, data=data))

        return result

    # def ego_frontal_nearest(self, trajectories):
    #     def heading_vector_from_yaw(yaw):
    #         x_component = math.cos(yaw)
    #         y_component = math.sin(yaw)
    #         return (x_component, y_component)
    #
    #     not_ego_fault = set()
    #     for trial_id, trajectory_data in trajectories.items():
    #         agent_name = failed_events[failed_trial_id]["name"].partition("With")[-1]
    #         if not agent_name:
    #             print(f"no agent_name {agent_name}")
    #             continue
    #
    #         ego_state = trajectory_data["trajectory"]["Ego"][-1]
    #         agent_state = trajectory_data["trajectory"][agent_name][-1]
    #
    #         if agent_state["speed"] < 0.1:
    #             print(f"{failed_trial_id}, agent does not have speed, is ego's fault")
    #             continue
    #
    #         if ego_state["speed"] < 1:
    #             print(f"{failed_trial_id}, ego does not have speed, is not ego's fault")
    #             not_ego_fault.add(failed_trial_id)
    #             continue
    #
    #         ego_heading = heading_vector_from_yaw(ego_state["yaw"])
    #         agent_heading = heading_vector_from_yaw(agent_state["yaw"])
    #
    #         ego_width = 2.2
    #         ego_length = 5.14
    #         pair_sample = pd.DataFrame(
    #             {
    #                 "x_i": [ego_state["x"]],
    #                 "y_i": [ego_state["y"]],
    #                 "vx_i": [ego_state["speed"] * ego_heading[0]],
    #                 "vy_i": [ego_state["speed"] * ego_heading[1]],
    #                 "hx_i": [ego_heading[0]],
    #                 "hy_i": [ego_heading[1]],
    #                 "length_i": [ego_length],
    #                 "width_i": [ego_width],
    #                 "x_j": [agent_state["x"]],
    #                 "y_j": [agent_state["y"]],
    #                 "vx_j": [agent_state["speed"] * agent_heading[0]],
    #                 "vy_j": [agent_state["speed"] * agent_heading[1]],
    #                 "hx_j": [agent_heading[0]],
    #                 "hy_j": [agent_heading[1]],
    #                 "length_j": [agent_state["length"]],
    #                 "width_j": [agent_state["width"]],
    #             }
    #         )
    #
    #         (
    #             point_i1,
    #             point_i2,
    #             point_i3,
    #             point_i4,
    #             point_j1,
    #             point_j2,
    #             point_j3,
    #             point_j4,
    #         ) = getpoints(pair_sample)
    #
    #         point_i1 = point_i1.flatten()
    #         point_i2 = point_i2.flatten()
    #         point_i3 = point_i3.flatten()
    #         point_i4 = point_i4.flatten()
    #
    #         point_j1 = point_j1.flatten()
    #         point_j2 = point_j2.flatten()
    #         point_j3 = point_j3.flatten()
    #         point_j4 = point_j4.flatten()
    #
    #         ego_left_edge = LineString([point_i1, point_i3])
    #         ego_right_edge = LineString([point_i2, point_i4])
    #         partition_length = ego_length * 1 / 3
    #         ego_partition_left_point = ego_left_edge.interpolate(partition_length)
    #         ego_partition_right_point = ego_right_edge.interpolate(partition_length)
    #
    #         ego_front_polygon = Polygon(
    #             [
    #                 point_i1,
    #                 point_i2,
    #                 ego_partition_right_point,
    #                 ego_partition_left_point,
    #             ]
    #         )
    #         ego_polygon = Polygon([point_i1, point_i2, point_i4, point_i3])
    #         agent_polygon = Polygon([point_j1, point_j2, point_j4, point_j3])
    #
    #         nearest_point_on_ego, _ = nearest_points(ego_polygon, agent_polygon)
    #
    #         scale = 1.005
    #         scaled_ego_front = affinity.scale(
    #             ego_front_polygon, xfact=scale, yfact=scale, origin="centroid"
    #         )
    #         if scaled_ego_front.contains(nearest_point_on_ego):
    #             pass
    #         else:
    #             print(f"{failed_trial_id}, not waymo collision, is not ego's fault")
    #             not_ego_fault.add(failed_trial_id)
    #             continue
