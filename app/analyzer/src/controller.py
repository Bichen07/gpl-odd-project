import os
import subprocess
import sys
import time
import math
from pathlib import Path
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle

from PIL.Image import Resampling
from matplotlib.colors import ListedColormap, BoundaryNorm, LinearSegmentedColormap


import numpy.typing as npt
from typing import Any, Dict, List, Literal, Optional, Set, Tuple, Union
from urllib.parse import urlencode, parse_qs, urlparse, quote
from dataclasses import dataclass, asdict
import itertools
from concurrent.futures import ThreadPoolExecutor, as_completed
import torch
from torch import nn, optim


from litestar.controller import Controller
from litestar import Litestar, get, post

from sklearn.manifold import TSNE

from scipy.spatial.distance import pdist
from scipy.cluster.hierarchy import (
    linkage,
    optimal_leaf_ordering,
    leaves_list,
    fcluster,
    dendrogram,
)


from collections import defaultdict
from pprint import pprint
from copy import deepcopy
import torch
import requests
import numpy as np
import pandas as pd
import umap
import hdbscan
import zipfile
import io
import json
from sklearn.cluster import DBSCAN
from sklearn.preprocessing import StandardScaler, MinMaxScaler
from sklearn.decomposition import PCA
from scipy.cluster.hierarchy import dendrogram, linkage, fcluster
from FDApy.preprocessing.dim_reduction.mfpca import MFPCA
from FDApy.preprocessing import PSplines
from FDApy.representation.argvals import DenseArgvals
from FDApy.representation import IrregularArgvals, IrregularValues
from FDApy.representation.functional_data import (
    IrregularFunctionalData,
    DenseFunctionalData,
    MultivariateFunctionalData,
)
from FDApy.representation.values import DenseValues
from sklearn.cluster import OPTICS
from sklearn.metrics import (
    calinski_harabasz_score,
    silhouette_score,
    davies_bouldin_score,
)
from shapely.geometry import Polygon, LineString, Point
from shapely.ops import nearest_points, split

from graphql import batch_query, trials_query
from timer import Timer
from env import PAYLOAD_API, PAYLOAD_GRAPHQL_API, PAYLOAD_API_KEY
import analysis_progress
from predict import calculate_gradients, train_surrogate_model, predict
from TwoDimTTC import getpoints, getpoints_np
from gradient import train_surrogate_nn_model
from collections import defaultdict
from third_party.ts2vec.ts2vec import TS2Vec
from train import LearningShapeletsCL
from utils import z_normalize
import numpy as np
from PIL import Image
import matplotlib.cm as cm
import matplotlib.colors as mcolors
from matplotlib.colors import Normalize
import colorsys


def _load_capture():
    here = Path(__file__).resolve()
    repo_root = next((p for p in [here, *here.parents] if p.name == "gpl-odd-project"), None)
    if repo_root is None:
        return None
    llm_pkg = repo_root / "app" / "llm_pipeline" / "python"
    if str(llm_pkg) not in sys.path:
        sys.path.append(str(llm_pkg))
    try:
        from llm_pipeline.capture import PipelineCapture

        return PipelineCapture(__file__)
    except Exception:
        return None


_capture = _load_capture()

def interpolate_angles(sample_s, route_s, angles_rad):
    """
    Circular interpolation for angles in degrees [0, 360).
    """
    # Project to unit circle
    x = np.cos(angles_rad)
    y = np.sin(angles_rad)

    # Interpolate components
    x_i = np.interp(sample_s, route_s, x, left=np.nan, right=np.nan)
    y_i = np.interp(sample_s, route_s, y, left=np.nan, right=np.nan)

    # Back to angle
    # interp_angles = (np.rad2deg(np.arctan2(y_i, x_i)) + 360) % 360
    # interp_angles = (np.arctan2(y_i, x_i) + 2 * np.pi) % (2 * np.pi)
    interp_angles = np.arctan2(y_i, x_i)
    return interp_angles

def draw_rect_subpixel(img, x, y, w, h, color):
    """
    Draws a rectangle at float x with subpixel accuracy
    """
    x0 = int(np.floor(x))
    frac = x - x0

    # Left pixel
    if 0 <= x0 < img.shape[1]:
        img[y:y+h, x0:x0+1] = (
            img[y:y+h, x0:x0+1] * frac +
            color * (1 - frac)
        ).astype(np.uint8)

    # Right pixel
    if frac > 0 and x0 + 1 < img.shape[1]:
        img[y:y+h, x0+1:x0+2] = (
            img[y:y+h, x0+1:x0+2] * (1 - frac) +
            color * frac
        ).astype(np.uint8)

def get_color(value, vmin, vmax, cmap, norm=None):
    if norm is None:
        norm = mcolors.Normalize(vmin=vmin, vmax=vmax, clip=True)
    rgba = cmap(norm(value))
    return (np.array(rgba[:3]) * 255).astype(np.uint8)

class PaddedNormalize(Normalize):
    def __init__(self, vmin, vmax, pad_low=0.2):
        super().__init__(vmin, vmax)
        self.pad_low = pad_low

    def __call__(self, value, clip=None):
        x = super().__call__(value, clip)
        return self.pad_low + (1 - self.pad_low) * x


def hue_colormap(n=500):
    colors = [
        colorsys.hls_to_rgb(h/360.0, 0.5, 1.0)
        for h in np.linspace(0, 360, n)
    ]
    return ListedColormap(colors, name="hue")

def get_chroma_like_colormap(attribute, value_range):
    vmin, vmax = value_range

    if "RelativeDistance" in attribute:
        # Reverse Chroma.js inferno array
        inferno_colors = [
            "#fcffa4",
            "#f7d13d",
            "#fb9b06",
            "#ed6925",
            "#cf4446",
            "#a52c60",
            "#781c6d",
            "#4a0c6b",
            "#1b0c41",
            "#000004",
        ]

        cmap = ListedColormap(inferno_colors)
        bounds = [0, 0.1, 0.3, 1, 3, 10, 30, 30.1]
        bounds = np.array(bounds)
        norm = BoundaryNorm(bounds, cmap.N)

        return cmap, norm

    if "EgoSpeed" in attribute:
        # 7 discrete classes
        class_bounds = np.array([0, 1, 2, 3, 4, 5, 6, 7]) / 7.0
        # Use built-in 'Blues' from matplotlib
        cmap = plt.get_cmap("Blues", 7)  # 7 discrete colors
        norm = BoundaryNorm(class_bounds, cmap.N)
        return cmap, norm

    if "Ttc" in attribute or "Spret" in attribute:
        cmap = cm.get_cmap("OrRd_r")
        norm = PaddedNormalize(vmin, vmax, pad_low=0.2)
        return cmap, norm

    if vmin >= 0:
        return cm.get_cmap("Purples"), mcolors.Normalize(vmin, vmax)

    if "YawRate" in attribute:
        return cm.get_cmap("PiYG"), mcolors.Normalize(vmin, vmax)

    if "Offset" in attribute or "RelativeYaw" in attribute:
        return cm.get_cmap("BrBG"), mcolors.Normalize(vmin, vmax)

    if "Acceleration" in attribute:
        return cm.get_cmap("RdBu"), mcolors.Normalize(vmin, vmax)

    return hue_colormap(), mcolors.Normalize(vmin, vmax)

def draw_full_heatmap(
    trajectory_data,  # dict[trialId][attribute] -> list of values
    trial_order,  # list of trialIds
    attribute,  # str
    value_range,  # (min, max)
    frame_period=0.1,
    resolution=4,
    output_path="heatmap.png",
):
    """
    Draws a full heatmap PNG similar to PixiJS implementation.
    Trials with shorter time series are padded on the right (gray) so rows align.
    """
    hex_color = "#555555"
    bg_rgb = np.array(
        tuple(int(hex_color[i : i + 2], 16) for i in (1, 3, 5)), dtype=np.uint8
    )

    ordered_trials = []
    for trial_id in trial_order:
        key = str(trial_id)
        if key not in trajectory_data:
            continue
        series = trajectory_data[key].get(attribute)
        if not series:
            continue
        ordered_trials.append(key)

    if not ordered_trials:
        print(f"Skipping heatmap {output_path}: no trials with attribute {attribute}")
        return

    max_frames = max(len(trajectory_data[tid][attribute]) for tid in ordered_trials)
    max_frames = max(max_frames, 1)
    num_trials = len(ordered_trials)
    width = int(max_frames * resolution)
    height = int(num_trials * resolution)
    img = np.tile(bg_rgb, (height, width, 1))

    vmin, vmax = value_range
    colormap, norm_ = get_chroma_like_colormap(attribute, value_range)
    norm = norm_ if "RelativeDistance" in attribute else mcolors.Normalize(
        vmin=vmin, vmax=vmax, clip=True
    )

    for y_idx, trial_id in enumerate(ordered_trials):
        values = list(trajectory_data[trial_id][attribute])
        if len(values) < max_frames:
            values.extend([np.nan] * (max_frames - len(values)))
        y = y_idx * resolution
        for i, val in enumerate(values[:max_frames]):
            if val is None or (isinstance(val, float) and np.isnan(val)):
                color = bg_rgb
            else:
                rgba = colormap(norm(val))
                color = (np.array(rgba[:3]) * 255).astype(np.uint8)
            x = i * resolution
            img[y : y + resolution, x : x + resolution] = color

    Image.fromarray(img, mode="RGB").save(output_path)
    print(f"Saved {output_path} ({num_trials} trials x {max_frames} frames)")

def draw_full_heatmap_s(
    trajectory_data,
    raw_traj_data,
    trial_order,
    attribute,
    value_range,
    road_bounds,
    road_id_order,
    s_bin_size=0.1,      # meters
    resolution=4,        # pixels per meter
    output_path="heatmap.png",
):
    """
    Draw a unified s-based heatmap across multiple roads,
    sampled every s_bin_size using spatial interpolation.
    """

    import math
    import numpy as np
    import matplotlib.colors as mcolors
    from PIL import Image

    # --------------------------------------------------
    # 1. Build route offsets
    # --------------------------------------------------
    road_lengths = {
        r: road_bounds[r][1] - road_bounds[r][0]
        for r in road_id_order
    }

    road_offsets = {}
    offset = 0.0
    for r in road_id_order:
        road_offsets[r] = offset
        offset += road_lengths[r]

    total_route_length = offset
    num_samples = math.ceil(total_route_length / s_bin_size)

    # --------------------------------------------------
    # 2. Image size
    # --------------------------------------------------
    width = num_samples * resolution
    height = len(trial_order) * resolution

    hex_color = "#555555"
    rgb = tuple(int(hex_color[i:i + 2], 16) for i in (1, 3, 5))
    img = np.full((height, width, 3), rgb, dtype=np.uint8)

    # --------------------------------------------------
    # 3. Color setup
    # --------------------------------------------------
    vmin, vmax = value_range
    norm = mcolors.Normalize(vmin=vmin, vmax=vmax, clip=True)
    colormap, norm_ = get_chroma_like_colormap(attribute, value_range)
    if "RelativeDistance" in attribute:
        norm = norm_

    reversed_roads = set(road_id_order[:2])

    # Precompute spatial sample positions
    sample_s = np.arange(0, total_route_length, s_bin_size)

    # --------------------------------------------------
    # 4. Populate heatmap (spatial resampling)
    # --------------------------------------------------
    for y_idx, trial_id in enumerate(trial_order):

        values = trajectory_data[trial_id][attribute]
        snapshots = raw_traj_data[trial_id]["trajectory"]["Ego"]

        route_samples = []

        # ---- Collect continuous (route_s, value) samples
        for i, val in enumerate(values):
            if val is None or np.isnan(val):
                continue

            snap = snapshots[i]
            road_id = snap.get("roadId")
            s = snap.get("s")

            if road_id not in road_offsets:
                continue

            s_min, s_max = road_bounds[road_id]
            if road_id in reversed_roads:
                s_local = s_max - (s - s_min)
            else:
                s_local = s - s_min

            route_s = road_offsets[road_id] + s_local
            route_samples.append((route_s, val))

        if not route_samples:
            continue

        route_samples.sort(key=lambda x: x[0])
        route_s_arr = np.array([p[0] for p in route_samples])
        val_arr = np.array([p[1] for p in route_samples])

        # ---- Interpolate values at fixed spatial positions
        if "RelativeTheta" in attribute or "theta" in attribute.lower():
            interp_vals = interpolate_angles(sample_s, route_s_arr, val_arr)
        else:
            interp_vals = np.interp(
                sample_s,
                route_s_arr,
                val_arr,
                left=np.nan,
                right=np.nan,
            )

        # ---- Draw
        for i, agg_val in enumerate(interp_vals):
            if np.isnan(agg_val):
                continue

            rgba = colormap(norm(agg_val))
            color = (np.array(rgba[:3]) * 255).astype(np.uint8)

            x = i * resolution
            y = y_idx * resolution

            img[
                y : y + resolution,
                x : x + resolution,
            ] = color

    # --------------------------------------------------
    # 5. Save PNG
    # --------------------------------------------------
    Image.fromarray(img, mode="RGB").save(output_path)
    print(f"✅ Saved unified s-heatmap → {output_path}")

@dataclass
class TsneParameter:
    perplexity: float
    learning_rate: Union[float, str] = "auto"
    n_iter: int = 1000
    early_exaggeration: float = 12.0
    init: str = "pca"
    random_state: Union[int, None] = 0


def _pick_perplexity(n_samples: int, n_neighbor: Union[int, float]) -> float:
    """
    t-SNE's perplexity is ~effective #neighbors.
    A good heuristic from n_neighbors is n_neighbors / 3, clipped to [5, 50]
    and strictly less than n_samples.
    """
    perp = n_neighbor / 3.0
    perp = max(5.0, min(50.0, perp))
    # must be < n_samples
    return min(perp, max(1.0, n_samples - 1.0))


# --- your variables: min_dist, n_neighbor, precomputed, and data X or D ---
# If precomputed=True, X should be a (n_samples x n_samples) distance matrix (not features).
# If precomputed=False, X should be a (n_samples x n_features) feature matrix.


def build_tsne(X, n_neighbor, precomputed=False, *, seed=0):
    n_samples = X.shape[0]
    perplexity = _pick_perplexity(n_samples, n_neighbor)
    parameters = TsneParameter(perplexity=perplexity)

    tsne = TSNE(
        n_components=2,
        perplexity=parameters.perplexity,
        learning_rate=parameters.learning_rate,
        n_iter=parameters.n_iter,
        early_exaggeration=parameters.early_exaggeration,
        init=parameters.init,
        metric="precomputed" if precomputed else "euclidean",
        random_state=parameters.random_state,
        # If your precomputed matrix contains squared distances, set square_distances=True
        # square_distances=False,
    )
    Y = tsne.fit_transform(X)
    return Y, parameters


def integrate(
    y: npt.NDArray[np.float64], *args: npt.NDArray[np.float64], method: str = "simpson"
) -> float:
    r"""Compute an estimate of the integral of 1-dimensional curve.

    This function computes an estimation of the integral of :math:`y(x)` over
    the domain :math:`x`:

    .. math:: \int y(x)dx

    Parameters
    ----------
    y
        Observations
    args
        Domain for the integration, it has to be ordered.
    method
        The method used to integrated.

    Returns
    -------
    float
        Estimation of the integration of :math:`y(x)`.

    Example
    -------
    >>> X = np.array([1, 2, 4])
    >>> Y = np.array([1, 4, 16])
    >>> _integrate(Y, X)
    21.0

    >>> X = np.array([1, 2, 4])
    >>> Y = np.array([1, 2])
    >>> Z = np.array([[1, 2], [4, 5], [7, 8]])
    >>> _integrate(Z, X, Y)
    15.75

    """
    if method == "trapz":
        integrate = np.trapz
    else:
        raise ValueError(f"{method} not implemented!")

    temp = integrate(x=args[0], y=y, axis=0)
    for dimension in args[1:]:
        temp = integrate(x=dimension, y=temp, axis=0)
    return temp


def _local_poly_value_from_neighbors(
    theta0,
    X0,
    y0,
    neighbor_idx,
    use_quadratic=False,
    weight="gaussian",
    rho=None,
    ridge=1e-10,
    standardize=True,
    debug=False,
):
    """
    Estimate function value at theta0 using local polynomial regression.
    Returns:
      f_est: scalar, estimated function value at theta0
    """
    # ---- Shapes & data extraction ----
    theta0 = np.asarray(theta0, float).reshape(-1)
    X0 = np.asarray(X0, float)
    y0 = np.asarray(y0, float).reshape(-1)
    idx = np.asarray(neighbor_idx, int).ravel()

    Xn = X0[idx]  # (K, d)
    yn = y0[idx]  # (K,)
    K, d = Xn.shape

    # Number of polynomial terms
    p = 1 + d + (d * (d + 1)) // 2 if use_quadratic else 1 + d
    if K < max(d + 1, 2):
        raise ValueError(f"Not enough neighbors (K={K}) for d={d}")

    # ---- Local diffs & distances ----
    diffs = Xn - theta0
    r = np.linalg.norm(diffs, axis=1)

    # ---- Weights ----
    if rho is None:
        nz = r[r > 0]
        rho_eff = np.median(nz) if nz.size else (np.max(r) + 1e-12)
    else:
        rho_eff = float(rho)

    if weight == "gaussian":
        w = np.exp(-(r**2) / (rho_eff**2 + 1e-30))
    elif weight == "tricube":
        t = np.clip(1 - (r / (rho_eff + 1e-30)) ** 3, 0.0, 1.0)
        w = t**3
    else:
        w = np.ones_like(r)

    Wsqrt = np.sqrt(w).reshape(-1, 1)

    # ---- Standardization of neighbor coordinates ----
    X = diffs.copy()
    if standardize:
        mu = X.mean(axis=0)
        sd = X.std(axis=0, ddof=1)
        sd = np.where(sd == 0, 1.0, sd)
        X = (X - mu) / sd
    else:
        sd = np.ones(d)

    # ---- Design matrix ----
    if use_quadratic:
        uk = [(i, k) for i in range(d) for k in range(i, d)]
        quad_terms = np.column_stack([X[:, i] * X[:, k] for (i, k) in uk])
        A = np.column_stack([np.ones(K), X, 0.5 * quad_terms])
    else:
        A = np.column_stack([np.ones(K), X])

    # ---- Weighted ridge least squares ----
    Aw = A * Wsqrt
    yw = yn.reshape(-1, 1) * Wsqrt

    ATA = Aw.T @ Aw
    R = np.zeros_like(ATA)
    R[1:, 1:] = ridge * np.eye(ATA.shape[0] - 1)
    ATA += R

    ATy = (Aw.T @ yw).reshape(-1)

    try:
        beta = np.linalg.solve(ATA, ATy)
    except np.linalg.LinAlgError:
        beta, *_ = np.linalg.lstsq(ATA, ATy, rcond=None)

    # ---- Function value is the intercept term beta[0] ----
    f_est = beta[0]

    if debug:
        print(f"[DEBUG] d={d} K={K} p={p} rho_eff={rho_eff:.3g}")
        print(f"[DEBUG] beta[0]={f_est} (estimated value)")

    return f_est


def _local_poly_grad_from_neighbors(
    theta0,
    X0,
    y0,
    neighbor_idx,
    use_quadratic=False,
    weight="gaussian",
    rho=None,
    ridge=1e-10,
    standardize=True,
    debug=False,
):
    """
    theta0: (d,)           target point
    X0:    (n,d)           sample locations (thetas)
    y0:    (n,)            function values (fvals)
    neighbor_idx: (K,)     integer indices of neighbors
    Returns:
      grad: (d,)
    """
    # ---- Shapes & indexing ----
    theta0 = np.asarray(theta0, float).reshape(-1)  # (d,)
    X0 = np.asarray(X0, float)
    y0 = np.asarray(y0, float).reshape(-1)  # (n,)
    idx = np.asarray(neighbor_idx, int).ravel()
    Xn = X0[idx]  # (K,d)
    yn = y0[idx].reshape(-1)  # (K,)

    K, d = Xn.shape
    # parameters count for the local model
    p = 1 + d + (d * (d + 1)) // 2 if use_quadratic else 1 + d

    if K < max(d + 1, 2):  # too few points even for linear fit
        raise ValueError(f"Not enough neighbors (K={K}) for d={d}")

    # ---- Local diffs & distances ----
    diffs = Xn - theta0  # (K,d)
    r = np.linalg.norm(diffs, axis=1)  # (K,)

    # ---- Weights ----
    if rho is None:
        nz = r[r > 0]
        rho_eff = np.median(nz) if nz.size else (np.max(r) + 1e-12)
    else:
        rho_eff = float(rho)

    if weight == "gaussian":
        w = np.exp(-(r**2) / (rho_eff**2 + 1e-30))
    elif weight == "tricube":
        t = np.clip(1 - (r / (rho_eff + 1e-30)) ** 3, 0.0, 1.0)
        w = t**3
    else:
        w = np.ones_like(r)
    Wsqrt = np.sqrt(w).reshape(-1, 1)  # (K,1)

    # ---- Standardize locally (improves conditioning) ----
    X = diffs.copy()
    if standardize:
        mu = X.mean(axis=0)
        sd = X.std(axis=0, ddof=1)
        # avoid zeros
        sd = np.where(sd == 0, 1.0, sd)
        X = (X - mu) / sd
    else:
        sd = np.ones(d)

    # ---- Build design matrix ----
    if use_quadratic:
        uk = [(i, k) for i in range(d) for k in range(i, d)]
        quad_terms = np.column_stack(
            [X[:, i] * X[:, k] for (i, k) in uk]
        )  # (K, d*(d+1)/2)
        A = np.column_stack([np.ones(K), X, 0.5 * quad_terms])  # (K, p)
    else:
        A = np.column_stack([np.ones(K), X])  # (K, 1+d)

    # ---- Weighted ridge least squares ----
    Aw = A * Wsqrt  # (K,p)
    yw = yn.reshape(-1, 1) * Wsqrt  # (K,1) keep as column for clarity

    # Normal equations with Tikhonov on non-intercept
    ATA = Aw.T @ Aw
    R = np.zeros_like(ATA)
    R[1:, 1:] = ridge * np.eye(ATA.shape[0] - 1)
    ATA += R

    ATy = (Aw.T @ yw).reshape(-1)  # (p,)

    # Prefer solve; if singular, fall back to lstsq
    try:
        beta = np.linalg.solve(ATA, ATy)  # (p,)
    except np.linalg.LinAlgError:
        beta, *_ = np.linalg.lstsq(ATA, ATy, rcond=None)  # (p,)

    # ---- Extract gradient in standardized coords, then unscale ----
    g_scaled = beta[1 : 1 + d]  # (d,)
    sd = np.asarray(sd, float).reshape(-1)  # (d,)
    grad = g_scaled / sd  # (d,)

    if debug:
        print(f"[DEBUG] d={d} K={K} p={p} rho_eff={rho_eff:.3g}")
        print(
            f"[DEBUG] shapes: Xn{Xn.shape}, diffs{diffs.shape}, A{A.shape}, Aw{Aw.shape}, yw{yw.shape}"
        )
        print(f"[DEBUG] g_scaled{g_scaled.shape}, sd{sd.shape}, grad{grad.shape}")

    return grad


def zscore_normalize_per_variable(X, eps=1e-8):
    """
    Z-score normalization per variable.

    X shape = (n_samples, n_timepoints, n_variables)

    Returns:
        X_norm: normalized data (same shape)
        mu: mean per variable (shape = n_variables)
        sigma: std per variable (shape = n_variables)
    """
    # Compute mean and std over all samples and all time points
    mu = np.nanmean(X, axis=(0, 1))  # shape (n_variables,)
    sigma = np.nanstd(X, axis=(0, 1))  # shape (n_variables,)

    # Avoid division by zero
    sigma_safe = np.where(sigma < eps, 1.0, sigma)

    # Normalize
    X_norm = (X - mu[None, None, :]) / sigma_safe[None, None, :]

    return X_norm, mu, sigma_safe


def robust_normalize_IQR(X, eps=1e-8):
    """
    Normalize using median and IQR (25th–75th percentile).
    Works per variable, robust to outliers.
    X: (n_samples, n_timepoints, n_variables)
    """
    median = np.nanmedian(X, axis=(0, 1))  # per variable
    q1 = np.nanpercentile(X, 25, axis=(0, 1))
    q3 = np.nanpercentile(X, 75, axis=(0, 1))
    iqr = q3 - q1

    iqr_safe = np.where(iqr < eps, 1.0, iqr)
    X_norm = (X - median) / iqr_safe

    return X_norm, median, iqr_safe


def estimate_values_scattered_kdtree(
    theta0s,
    thetas,
    fvals,
    k,
    use_quadratic=False,
    weight="gaussian",
    rho=None,
    ridge=1e-10,
    standardize=True,
    debug=False,
):
    """
    KD-tree accelerated KNN + local polynomial value estimation only (no gradients).
    """
    from sklearn.neighbors import KDTree

    theta0s = np.asarray(theta0s, float)
    thetas = np.asarray(thetas, float)
    fvals = np.asarray(fvals, float).reshape(-1)

    # shape checks
    if thetas.ndim != 2:
        raise ValueError("thetas must be (n,d)")
    if theta0s.ndim != 2:
        raise ValueError("theta0s must be (m,d)")
    if thetas.shape[1] != theta0s.shape[1]:
        raise ValueError(
            f"dim mismatch: thetas has d={thetas.shape[1]}, theta0s has d={theta0s.shape[1]}"
        )
    if thetas.shape[0] != fvals.shape[0]:
        raise ValueError("fvals length must match thetas rows")

    n, d = thetas.shape
    K = min(int(k), n)
    if K < (1 + d):  # same minimum as linear fitting
        raise ValueError(f"k too small for d={d}. Need k >= {1+d}.")

    # KD-tree neighbor search
    tree = KDTree(thetas)
    _, nbr_idx = tree.query(theta0s, k=K)

    # Compute **local polynomial value only**
    vals = np.array(
        [
            _local_poly_value_from_neighbors(
                theta0s[i].reshape(-1),
                thetas,
                fvals,
                nbr_idx[i],
                use_quadratic=use_quadratic,
                weight=weight,
                rho=rho,
                ridge=ridge,
                standardize=standardize,
                debug=debug,
            )
            for i in range(theta0s.shape[0])
        ]
    )
    return vals


def estimate_gradients_scattered_kdtree(
    theta0s,
    thetas,
    fvals,
    k,
    use_quadratic=False,
    weight="gaussian",
    rho=None,
    ridge=1e-10,
    standardize=True,
    debug=False,
):
    """
    KD-tree accelerated KNN + local polynomial gradient.
    """
    from sklearn.neighbors import KDTree

    theta0s = np.asarray(theta0s, float)
    thetas = np.asarray(thetas, float)
    fvals = np.asarray(fvals, float).reshape(-1)

    if thetas.ndim != 2:
        raise ValueError("thetas must be (n,d)")
    if theta0s.ndim != 2:
        raise ValueError("theta0s must be (m,d)")
    if thetas.shape[1] != theta0s.shape[1]:
        raise ValueError(
            f"dim mismatch: thetas has d={thetas.shape[1]}, theta0s has d={theta0s.shape[1]}"
        )
    if thetas.shape[0] != fvals.shape[0]:
        raise ValueError("fvals length must match thetas rows")

    n, d = thetas.shape
    K = min(int(k), n)
    if K < (1 + d):  # at least as many neighbors as parameters (linear)
        raise ValueError(f"k too small for d={d}. Need k >= {1+d} (linear).")

    tree = KDTree(thetas)
    # neighbor indices for all targets
    _, nbr_idx = tree.query(theta0s, k=K)

    grads = np.vstack(
        [
            _local_poly_grad_from_neighbors(
                theta0s[i].reshape(-1),  # ensure (d,)
                thetas,
                fvals,
                nbr_idx[i],
                use_quadratic=use_quadratic,
                weight=weight,
                rho=rho,
                ridge=ridge,
                standardize=standardize,
                debug=debug,
            )
            for i in range(theta0s.shape[0])
        ]
    )
    return grads


import numpy as np


def center_and_scale_range(X, eps=1e-8):
    """
    Center per variable (subtract mean) and scale by dividing (max - min) per variable.

    Args:
        X : ndarray of shape (n_samples, n_timepoints, n_variables)
        eps : small constant to avoid division by zero

    Returns:
        X_scaled : normalized array, same shape as X
        mu : mean per variable (shape: n_variables)
        range_val : max - min per variable (shape: n_variables)
    """
    # Means across samples & time per variable
    mu = np.nanmean(X, axis=(0, 1))  # shape: (n_variables,)

    # Center
    X_centered = X - mu[None, None, :]  # subtract mean

    # Compute min and max for each variable
    v_min = np.nanmin(X_centered, axis=(0, 1))
    v_max = np.nanmax(X_centered, axis=(0, 1))
    range_val = v_max - v_min

    # Prevent division by zero
    range_safe = np.where(range_val < eps, 1.0, range_val)

    # Scale by range
    X_scaled = X_centered / range_safe[None, None, :]

    return X_scaled, mu, range_safe


def center_timepoint_scale_variable(X, eps=1e-8):
    """
    Center per time-point (across samples) and scale globally per variable to [-1, 1].

    Args:
        X : ndarray of shape (n_samples, n_timepoints, n_variables)
        eps : small value to avoid division by zero

    Returns:
        X_scaled : normalized array
        mu : mean per (timepoint, variable) -> shape (n_timepoints, n_variables)
        max_abs : max absolute amplitude per variable -> shape (n_variables,)
    """
    # 1. Center per time-point & variable
    mu = np.nanmean(X, axis=0)  # shape: (n_timepoints, n_variables)
    X_centered = X - mu[None, :, :]  # broadcast across samples

    # 2. Compute max absolute per variable across all times & samples
    max_abs = np.nanmax(np.abs(X_centered), axis=(0, 1))  # shape: (n_variables,)
    max_abs_safe = np.where(max_abs < eps, 1.0, max_abs)

    # 3. Scale the centered data per variable
    X_scaled = X_centered / max_abs_safe[None, None, :]

    return X_scaled, mu, max_abs_safe


def center_and_rescale_per_time(X, eps=1e-8):
    """
    Center per timepoint & variable, then scale by max amplitude across samples.
    """
    mu = np.nanmean(X, axis=0)  # shape (n_timepoints, n_variables)
    X_centered = X - mu[None, :, :]

    max_abs = np.nanmax(np.abs(X_centered), axis=0)  # shape (n_timepoints, n_variables)
    max_abs_safe = np.where(max_abs < eps, 1.0, max_abs)

    X_scaled = X_centered / max_abs_safe[None, :, :]

    return X_scaled, mu, max_abs_safe


def normalize_per_variable_timepoint_nan(X, eps=1e-8):
    """
    Normalize X per variable **and per time point**, ignoring NaNs.
    Mean and std are computed across samples for each (time, variable) pair.

    X shape: (n_samples, n_timepoints, n_variables)

    Returns:
      - X_norm: normalized array, same shape as X
      - mu: mean per (time, variable), shape (n_timepoints, n_variables)
      - sigma: std per (time, variable), shape (n_timepoints, n_variables)
    """
    # Compute mean and std across samples (axis=0) for each time & variable
    mu = np.nanmean(X, axis=0)  # shape: (n_timepoints, n_variables)
    sigma = np.nanstd(X, axis=0)  # shape: (n_timepoints, n_variables)

    # Avoid division by zero (if sigma is 0 or extremely small)
    sigma_safe = np.where(sigma < eps, 1.0, sigma)

    # Normalize: (X - mean) / std, with broadcasting
    X_norm = (X - mu[None, :, :]) / sigma_safe[None, :, :]

    return X_norm, mu, sigma_safe


def normalize_per_variable_nan(X, eps=1e-8):
    """
    Normalize X per variable (v-axis) ignoring NaNs.
    X shape: (n_samples, n_timepoints, n_variables)
    Returns X_norm (same shape), mu, sigma for each variable.
    """
    # Flatten sample+time axes for each variable
    # Shape: (n_samples * n_timepoints, n_variables)
    flat = X.reshape(-1, X.shape[-1])  # now each column is a variable

    # Compute mean and std skipping NaNs
    mu = np.nanmean(flat, axis=0)  # shape (n_variables,)
    sigma = np.nanstd(flat, axis=0)  # shape (n_variables,)

    # Avoid division by zero or very small sigma
    sigma_safe = np.where(sigma < eps, 1.0, sigma)

    # Now normalize in place (or to a new array)
    X_norm = np.empty_like(X, dtype=float)
    for v in range(X.shape[-1]):
        X_norm[:, :, v] = (X[:, :, v] - mu[v]) / sigma_safe[v]

    # Note: NaNs in X will propagate to X_norm (i.e. normalized NaNs remain NaN)
    return X_norm, mu, sigma_safe


def is_on_front_third(ego_poly: Polygon, contact_pt: Point, yaw: float) -> bool:
    """
    Return True if contact_pt lies on the front 1/3 of ego_poly along its longitudinal axis.
    ego_poly: oriented rectangle of the vehicle footprint (meters).
    contact_pt: point on ego boundary (e.g., from shapely.ops.nearest_points).
    yaw: ego heading in radians (world frame).
    """
    # 1) center the polygon and point at ego centroid
    cx, cy = ego_poly.centroid.x, ego_poly.centroid.y
    px, py = contact_pt.x - cx, contact_pt.y - cy

    # 2) rotate world -> ego local (x=fwd, y=left). Rotate by -yaw
    c, s = np.cos(-yaw), np.sin(-yaw)
    R = np.array([[c, -s], [s, c]])

    # ego vertices in local frame
    ego_xy = np.array(ego_poly.exterior.coords[:-1], dtype=float)  # drop closing dup
    ego_local = (ego_xy - np.array([cx, cy])) @ R.T

    # contact point in local frame
    p_local = np.array([px, py]) @ R.T

    # 3) compute longitudinal extent
    x_min = np.min(ego_local[:, 0])
    x_max = np.max(ego_local[:, 0])
    L = x_max - x_min
    if L <= 0:
        return False  # degenerate

    # 4) "front third" = top third along +x
    front_threshold = x_min + (2.0 / 3.0) * L
    return p_local[0] >= front_threshold


def dict_to_qs(d, parent_key=""):
    pairs = []
    for k, v in d.items():
        new_key = f"{parent_key}[{k}]" if parent_key else k
        if isinstance(v, dict):
            pairs.extend(dict_to_qs(v, new_key))
        elif isinstance(v, list):
            for item in v:
                pairs.append((new_key + "[]", item))
        else:
            pairs.append((new_key, v))
    return pairs


def qs_stringify(params):
    pairs = dict_to_qs(params)
    return "&".join(f"{quote(str(k))}={quote(str(v))}" for k, v in pairs)


def object_to_array(data):
    # assume all values are lists of equal length
    keys = list(data.keys())
    length = len(next(iter(data.values()))) if data else 0
    result = []
    for i in range(length):
        item = {}
        for key in keys:
            item[key] = data[key][i]
        result.append(item)
    return result


def array_to_object(data):
    result = defaultdict(list)
    for item in data:
        for key, value in item.items():
            result[str(key)].append(value)
    return dict(result)


ClusteringMethod = Literal[
    "dbscan+mfpca",
    "hdbscan+mfpca",
    "hierarchy+mfpca",
    "kmedoids+dtw",
    "agg+dtw",
    "aff+dtw",
    "hdbscan+dtw",
    "dbscan+dtw",
    "hierarchy+dtw",
    "hdbscan+mfpca+umap",
    "hierarchy+mfpca+umap",
    "hdbscan+dtw+umap",
    "hierarchy+dtw+umap",
]
headers = {"Authorization": f"users API-Key {PAYLOAD_API_KEY}"}


@dataclass
class ClusteringTask:
    nClusters: int
    minClusterSize: int
    minSamples: int
    clusterSelectionEpsilon: float
    clusterSelectionMethod: str
    method: ClusteringMethod


@dataclass
class TrajectoryAnalysisRequest:
    batchIds: List[str]
    framePeriod: float
    tasks: List[ClusteringTask]


@dataclass
class GridPrediction:
    z: List[List[float]]


@dataclass
class TrialClusterItem:
    trialId: str
    label: str


@dataclass
class ClusteringScores:
    calinskiHarabazScore: Optional[float]
    silhouetteScore: Optional[float]
    daviesBouldinScore: Optional[float]
    relativeValidity: Optional[float]


@dataclass
class ClusteringResult:
    task: ClusteringTask
    data: Dict[str, TrialClusterItem]
    scores: ClusteringScores
    trialOrder: Dict[str, List[str]]


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
class Mfpca:
    scores: Dict[str, List[float]]
    timePoints: List[float]
    fpcs: List[List[List[float]]]
    means: List[List[float]]
    explainedVarianceRatio: List[float]
    clustering: List[Optional[ClusteringResult]]
    umapProjections: List[UmapProjection]
    attributes: List[str]
    durationIndices: Optional[Dict[str, List[int]]]
    trialOrder: List[str]
    # moreToVizTrialOrder: List[str]
    # moreToVizSeconds: float
    # dendrogram: Dict[str, Dendrogram]
    # parameters: Dict[Any, Any]


@dataclass
class TrajectoryAnalysisResponse:
    request: TrajectoryAnalysisRequest
    trials: Dict[str, Any]
    batches: Dict[str, Any]
    mfpca: Dict[str, Mfpca]
    attributes: List[str]
    parameters: Dict[Any, Any]
    metricGradients: Dict[str, Dict[str, List[float]]]
    metricGridPredictions: Dict[str, GridPrediction]
    metricGridGradients: Dict[str, GridPrediction]
    heatmapFileinfo: Dict[str, Any]
    trajectoriesFileinfo: Dict[str, Any]
    fullHeatmaps: List[Any]
    bound: Dict[str, Any]

    # durationIndices: Dict[str, List[int]]
    # fullTrialOrder: List[str]


@dataclass
class TrajectoryQuery:
    trialId: str
    index: int
    duration: float
    framePeriod: float
    standardized: bool
    forward: bool


def heading_vector_from_yaw(yaw):
    # type: (float) -> Tuple[float ,float]
    x_component = math.cos(yaw)
    y_component = math.sin(yaw)
    return (x_component, y_component)


class TrajectoryAnalysisController(Controller):
    path = "/trajectory_analysis"

    @get("/progress")
    async def analysis_progress_status(self) -> Dict[str, Any]:
        return analysis_progress.snapshot()

    @post("/")
    async def clustering(
        self, data: TrajectoryAnalysisRequest
    ) -> Dict[str, TrajectoryAnalysisResponse]:
        analysis_progress.begin_run(data.batchIds, len(data.tasks))
        run_id = f"analyzer_{int(time.time())}"
        if _capture is not None:
            _capture.record(
                "stage1_capture",
                run_id,
                "analyzer_request",
                {"batchIds": data.batchIds, "framePeriod": data.framePeriod, "tasks": [asdict(t) for t in data.tasks]},
            )
        egoIds = [1]

        returned = {}
        docsave = {}

        heatmapData = {}
        rawTrajectoryData = {}
        # Collect s ranges per road
        road_s_ranges = defaultdict(list)
        road_id_order = []
        phase6_context = None

        for egoId in egoIds:
            analysis_progress.update(
                "loading_trajectories",
                0,
                1,
                "Loading trials and trajectories from Payload…",
            )
            trajectories, rawTrajectories, trial_mappings, batch_mappings, columns = (
                self.get_trajectories(data, egoId)
            )
            # # with open("./.temp/.datatemp/scenario3-1.json", "r") as file:
            # # with open("./.temp/.datatemp2/sc2_ttc.json", "r") as file:
            # with open("./.temp/.datatemp1/sc1_spret.json", "r") as file:
            # # with open("./.temp/temp1-2/sc1-4.json", "r") as file:
            #     # with open("./.temp/no_collision_stop_3-1.json", "r") as file:
            #     # with open("./.temp/no_collision_2_2000.json", "r") as file:
            #     saved_clustering = json.load(file)
            #     batch_mappings = saved_clustering["ITRI"]["batches"]
            #     trial_mappings = saved_clustering["ITRI"]["trials"]
            # # with open("./.temp/databackup/trajectories.json", "r") as file:
            # # with open("./.temp/.datatemp/trajectories.json", "r") as file:
            # # with open("./.temp/.datatemp2/trajectories.json", "r") as file:
            # with open("./.temp/.datatemp1/trajectories.json", "r") as file:
            # # with open("./.temp/temp1-2/trajectories.json", "r") as file:
            #     trajectories = json.load(file)
            #     json_load = {}
            #     for trial_id, value in trajectories.items():
            #         json_load[str(trial_id)] = object_to_array(value)
            #     trajectories = json_load
            # # with open("./.temp/.datatemp/rawTrajectories.json", "r") as file:
            # # with open("./.temp/.datatemp2/rawTrajectories.json", "r") as file:
            # # with open("./.temp/temp1-2/rawTrajectories.json", "r") as file:
            #     # with open("./.temp/databackup/rawTrajectories.json", "r") as file:
            # with open("./.temp/.datatemp1/rawTrajectories.json", "r") as file:
            #     rawTrajectories = json.load(file)
            #
            # for trialId in trajectories.keys():
            #     for index, item in enumerate(trajectories[trialId]):
            #         item["EgoX"] = rawTrajectories[trialId]["trajectory"]["Ego"][index][
            #             "x"
            #         ]
            #         item["EgoY"] = rawTrajectories[trialId]["trajectory"]["Ego"][index][
            #             "y"
            #         ]

            # columns = [
            #     # "EgoX",
            #     # "EgoY",
            #     "EgoOffset",
            #     "EgoSpeed",
            #     "EgoAcceleration",
            #     "EgoYawRate",
            #     # "OppositeRelativeDistance",
            #     # "OppositeRelativeTheta",
            #     # "OppositeRelativeX",
            #     # "OppositeRelativeY",
            #     # "ParkingRelativeDistance",
            #     # "ParkingRelativeTheta",
            #     # "ParkingRelativeX",
            #     # "ParkingRelativeY",
            #     # "ParkingRelativeDistance",
            #     # "ParkingRelativeTheta",
            #     # "ParkingRelativeX",
            #     # "ParkingRelativeY",
            #     # "IdlingRelativeDistance",
            #     # "IdlingRelativeTheta",
            #     # "IdlingRelativeX",
            #     # "IdlingRelativeY",
            #     # "CuttingInRelativeDistance",
            #     # "CuttingInRelativeTheta",
            #     # "CuttingInRelativeX",
            #     # "CuttingInRelativeY",
            #     "OncomingRelativeDistance",
            #     "OncomingRelativeTheta",
            #     "OncomingRelativeX",
            #     "OncomingRelativeY",
            # ]


            clustering_columns = [
                # "EgoSpeed",
                # "EgoAcceleration",
                c
                for c in columns
                if (
                    "Ttc" not in c
                    and "Spret" not in c
                    # and c != "EgoX"
                    # and c != "EgoY"
                    and c != "EgoS"
                    and "EgoOffset" not in c
                    # and "RelativeX" not in c
                    # and "RelativeY" not in c
                    and "RelativeDistance" not in c
                    and "RelativeTheta" not in c
                    and "RelativeYaw" not in c
                )
                # # or "Cos" in c
                # # or "Sin" in c
                # # and "RelativeX" not in c
                # # and "RelativeY" not in c
            ]
            visualization_columns = [
                # "EgoX",
                # "EgoY",
                # "EgoSpeed",
                # "EgoAcceleration",
                c
                for c in columns
                if (
                    # "Ttc" not in c
                    # "Spret" not in c
                    "RelativeX" not in c
                    and "RelativeY" not in c
                    and "RelativeYaw" not in c
                    and c != "EgoX"
                    and c != "EgoY"
                    and c != "EgoS"
                    # and "EgoOffset" not in c
                    # and "Cos" not in c
                    # and "Sin" not in c
                )
                # # or ("RelativeYaw" in c and "Cos" not in c and "Sin" not in c)
                # # if "Ttc" not in c
            ]


            print("columns")
            pprint(columns)
            print("clustering columns")
            pprint(clustering_columns)
            print("visualization_columns")
            pprint(visualization_columns)

            batch = list(batch_mappings.values())[0]
            parameters = batch["scenario"]["parameters"]

            analysis_progress.update("mfpca", 0, 1, "Running MFPCA on ego trajectories…")
            t = Timer("MFPCA")
            clustering_duration = 5
            t.start()

            analysis_data = self.get_mfpca(
                trajectories,
                data,
                clustering_columns,
                trial_mappings,
                clustering_duration,
            )
            t.stop()

            mfpca_dict = {}
            for key, value in analysis_data.items():
                analysis_progress.update("umap", 0, 1, "Computing UMAP embeddings…")
                t = Timer("2D umap projection")
                t.start()
                umapProjections, X_umap = self.get_2d_umap_projections(
                    value["X_rep"], value["trial_ids"]
                )
                t.stop()

                analysis_progress.update(
                    "clustering",
                    0,
                    len(data.tasks),
                    f"Running HDBSCAN grid (0/{len(data.tasks)} tasks)…",
                )
                t = Timer("Clustering")
                t.start()
                results = self.cluster(
                    value["X_rep"], data, value["trial_ids"], key == "full"
                )
                t.stop()

                mfpcaResult = Mfpca(
                    attributes=clustering_columns,
                    scores=deepcopy(value["score_mappings"]),
                    timePoints=deepcopy(value["time_points"]),
                    fpcs=deepcopy(value["fpcs_data"]),
                    means=deepcopy(value["attribute_mean"]),
                    explainedVarianceRatio=deepcopy(value["explained_variance_ratio"]),
                    clustering=deepcopy(results),
                    umapProjections=deepcopy(umapProjections),
                    durationIndices=value["clustering_duration_indices"],
                    trialOrder=value["trial_order"],
                )

                mfpca_dict[key] = mfpcaResult
                if key == "full":
                    phase6_context = {
                        "mfpca_value": value,
                        "clustering_results": results,
                        "trial_mappings": trial_mappings,
                        "batch_mappings": batch_mappings,
                    }

            batch = list(batch_mappings.values())[0]
            parameters = batch["scenario"]["parameters"]
            input_trial_ids = []
            inputs = []
            for trial_id, _ in trajectories.items():
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
                input_trial_ids.append(trial_id)

            scaler_X = MinMaxScaler()
            X_original = torch.Tensor(np.array(inputs))
            X_normalized = torch.Tensor(scaler_X.fit_transform(np.array(inputs)))

            metrics = batch["scenario"]["testObjectives"]["criticalityMetrics"]
            metric_names = [
                m["keyPerformanceIndicator"]["name"]
                for m in metrics
            ]
            # used_metrics = ["ttc_min", "collision"]
            # used_metrics = ["ttc_min", "collision", "dce_min", "spret_min"]
            # used_metrics = ["spret_min", "collision"]
            # used_metrics = ["spret_min", "ttc_min", "dce_min", "collision"]
            # used_metrics = ["spret_min", "ttc_min", "dce_min", "collision"]
            # used_metrics = ["ttc_min", "collision"]
            metric_grid_predictions = {}
            metric_grid_gradients = {}
            metric_gradients = {}
            for metric_index, used_metric in enumerate(metric_names):
                analysis_progress.update(
                    "surrogate",
                    metric_index,
                    len(metric_names),
                    f"Training metric surrogate ({metric_index + 1}/{len(metric_names)})…",
                )
                used_metric_name = used_metric
                metric = [
                    m
                    for m in metrics
                    if m["keyPerformanceIndicator"]["name"] == used_metric_name
                ][0]

                metric_values = {}
                passed = {}
                for trial_id in input_trial_ids:
                    trial = trial_mappings[trial_id]
                    trial_metric = [
                        m
                        for m in trial["testObjectives"]["criticalityMetrics"]
                        if m["keyPerformanceIndicator"]["id"]
                        == metric["keyPerformanceIndicator"]["id"]
                    ][0]
                    value = trial_metric["value"]
                    if used_metric == "spret_min":
                        value = min(value, 9)
                    metric_values[trial_id] = value
                    passed[trial_id] = trial_metric["passed"]

                # grid_size = 100
                grid_size = 50
                values = np.linspace(0, 1, grid_size)
                x, y = np.meshgrid(values, values, indexing="ij")
                grid = np.stack((x, y), axis=-1)
                grid_2d = grid.reshape(-1, 2)
                scaled_grid_2d = scaler_X.inverse_transform(grid_2d)

                sign = (
                    1 if metric["keyPerformanceIndicator"]["rule"] == "lessThan" else -1
                )
                # metric_Y = np.array(
                #     [sign * metric_values[trial_id] for trial_id in input_trial_ids]
                # ).reshape(-1, 1)
                metric_Y = torch.Tensor(
                    [sign * metric_values[trial_id] for trial_id in input_trial_ids]
                ).reshape(-1, 1)

                print("TRAIN METRIC SURROGATE")
                model = train_surrogate_model(X_original, metric_Y, False, False)

                grid_estimate = estimate_values_scattered_kdtree(
                    scaled_grid_2d,
                    X_original.numpy(),
                    metric_Y,
                    30,
                    weight="gaussian",
                    standardize=False,
                )
                grid_estimate = np.array(grid_estimate.tolist()).reshape(
                    grid_size, grid_size
                )
                grid_estimate = sign * grid_estimate
                metric_grid_predictions[used_metric_name] = GridPrediction(
                    z=grid_estimate.tolist()
                )

                gradients = estimate_gradients_scattered_kdtree(
                    X_original.numpy(), X_original.numpy(), metric_Y, 10
                )
                gradient_mappings = {
                    # id: [0, 0]
                    id: gradients[i].flatten().tolist()
                    for i, id in enumerate(input_trial_ids)
                }
                metric_gradients[used_metric_name] = gradient_mappings

                grid_gradients = estimate_gradients_scattered_kdtree(
                    scaled_grid_2d,
                    X_original.numpy(),
                    metric_Y,
                    30,
                    weight="gaussian",
                    standardize=False,
                )
                grid_gradient_mags = np.array(
                    [float(np.linalg.norm(np.array(grad))) for grad in grid_gradients]
                ).reshape(grid_size, grid_size)
                metric_grid_gradients[used_metric_name] = GridPrediction(
                    z=grid_gradient_mags.tolist()
                )

            egoName = "ITRI"
            if egoId == 3:
                egoName = "ITRILatest"

            json_dump = {}
            for trial_id, value in trajectories.items():
                json_dump[str(trial_id)] = array_to_object(value)

            json_bytes = json.dumps(json_dump).encode("utf-8")
            zip_buffer = io.BytesIO()
            with zipfile.ZipFile(
                zip_buffer, mode="w", compression=zipfile.ZIP_DEFLATED
            ) as zip_file:
                zip_file.writestr("trajectories.json", json_bytes)
            zip_buffer.seek(0)
            files = {"file": ("heatmap.zip", zip_buffer, "application/zip")}
            response = requests.post(
                f"{PAYLOAD_API}/api/documents",
                files=files,
                headers=headers,
            )
            response.raise_for_status()
            heatmapFileinfo = response.json()["doc"]
            heatmapData[egoName] = json_dump

            replayerTrajectories = {}
            for trialId, trajectory in rawTrajectories.items():
                agents = {}
                for agent_name, agent in trajectory["trajectory"].items():
                    agents[agent_name] = []
                    for i, item in enumerate(agent):
                        # FIXED: Propagate last known valid roadId instead of defaulting
                        # to 0.  Handles None, NaN, non-numeric, and missing key safely.
                        roadId = 0
                        s = 0.0
                        if "roadId" in item:
                            if item["roadId"] is None:
                                roadId = agents[agent_name][-1]["roadId"] if agents[agent_name] else 0
                            else:
                                try:
                                    if isinstance(item["roadId"], (int, float)) and not math.isnan(item["roadId"]):
                                        roadId = int(item["roadId"])
                                    else:
                                        roadId = agents[agent_name][-1]["roadId"] if agents[agent_name] else 0
                                except (ValueError, TypeError, IndexError, KeyError):
                                    roadId = agents[agent_name][-1]["roadId"] if agents[agent_name] else 0

                        if "s" in item:
                            if item["s"] is None:
                                s = agents[agent_name][-1]["s"] if agents[agent_name] else 0.0
                            else:
                                try:
                                    s = float(item["s"])
                                except (ValueError, TypeError):
                                    s = agents[agent_name][-1]["s"] if agents[agent_name] else 0.0

                        agents[agent_name].append({
                            "x": item["x"],
                            "y": item["y"],
                            "yaw": item["yaw"],
                            "width": item.get("width", 0),
                            "length": item.get("length", 0),
                            "s": s,
                            "roadId": roadId
                        })
                replayerTrajectories[trialId] = {
                    "time": trajectory["time"],
                    "trajectory": agents,
                }
                rawTrajectoryData.setdefault(egoName, {})
                rawTrajectoryData[egoName][trialId] = {
                    "time": trajectory["time"],
                    "trajectory": agents,
                }

            for trial_id, trajectory in replayerTrajectories.items():
                ego_traj = trajectory["trajectory"]["Ego"]

                for snapshot in ego_traj:
                    road_id = snapshot.get("roadId")
                    s = snapshot.get("s")

                    if road_id is None or s is None:
                        continue

                    if road_id not in road_id_order:
                        road_id_order.append(road_id)

                    road_s_ranges[road_id].append(s)
            road_bounds = {
                road_id: (min(vals), max(vals))
                for road_id, vals in road_s_ranges.items()
            }
            road_lengths = {
                road_id: road_bounds[road_id][1] - road_bounds[road_id][0]
                for road_id in road_id_order
            }
            total_length = sum(road_lengths.values())
            road_offsets = {}
            offset = 0.0
            for road_id in road_id_order:
                road_offsets[road_id] = offset
                offset += road_lengths[road_id]
            reversed_roads = set(road_id_order[:2])
            for trial_id, trajectory in replayerTrajectories.items():
                for snapshot in trajectory["trajectory"]["Ego"]:
                    road_id = snapshot.get("roadId")
                    s = snapshot.get("s")

                    if road_id is None or s is None:
                        continue

                    min_s, max_s = road_bounds[road_id]
                    road_len = max_s - min_s

                    if road_len <= 0:
                        snapshot["s_ratio"] = 0.0
                        continue

                    if road_id in reversed_roads:
                        s_local = max_s - (s - min_s)   # reverse direction
                    else:
                        s_local = s - min_s

                    global_s = (
                        road_offsets[road_id]
                        + s_local
                    )

                    snapshot["s_ratio"] = global_s / total_length


            json_bytes = json.dumps(replayerTrajectories).encode("utf-8")
            zip_buffer = io.BytesIO()
            with zipfile.ZipFile(
                zip_buffer, mode="w", compression=zipfile.ZIP_DEFLATED
            ) as zip_file:
                zip_file.writestr("rawTrajectories.json", json_bytes)
            zip_buffer.seek(0)
            files = {"file": ("trajectories.zip", zip_buffer, "application/zip")}
            response = requests.post(
                f"{PAYLOAD_API}/api/documents",
                files=files,
                headers=headers,
            )
            response.raise_for_status()
            trajectoriesFileinfo = response.json()["doc"]

            result = TrajectoryAnalysisResponse(
                request=data,
                batches=batch_mappings,
                trials=trial_mappings,
                mfpca=mfpca_dict,
                attributes=visualization_columns,
                parameters=parameters,
                metricGradients=deepcopy(metric_gradients),
                metricGridPredictions=deepcopy(metric_grid_predictions),
                metricGridGradients=deepcopy(metric_grid_gradients),
                heatmapFileinfo=heatmapFileinfo,
                trajectoriesFileinfo=trajectoriesFileinfo,
                fullHeatmaps=[],
                bound={}
            )

            returned[egoName] = result
            docsave[egoName] = asdict(result)

        bound = {} 

        for egoName in returned.keys():
            trialOrder = returned[egoName].mfpca["full"].trialOrder
            for trialId in trialOrder:
                trajectory = heatmapData[egoName][trialId]
                for attribute in visualization_columns:
                    if "Spret" in attribute:
                        bound[attribute] = {
                            "range": [0, 5],
                            "colorscale": None,
                        }
                    elif "RelativeDistance" in attribute:
                        bound[attribute] = {
                            "range": [0, 30],
                            "colorscale": None,
                        }
                    elif "RelativeTheta" in attribute:
                        bound[attribute] = {
                            "range": [-3.14159265, 3.14159265],
                            "colorscale": None,
                        }
                    elif "Yaw" in attribute:
                        # valueMags = [abs(v) for v in heatmapData[attribute] if abs(v) > 15.001 * 3.14159265 / 180]
                        threshold = 15.001 * 3.14159265 / 180
                        bound[attribute] = {
                            "range": [-threshold, threshold],
                            "colorscale": None,
                        }
                    elif "Offset" in attribute:
                        valueMags = [abs(v) for v in trajectory[attribute]]
                        valueMax = max(valueMags)
                        if attribute not in bound:
                            bound[attribute] = {
                                "range": [-valueMax, valueMax],
                                "colorscale": None
                            }
                        else:
                            maxMag = max(bound[attribute]["range"][1], valueMax)
                            bound[attribute]["range"][0] = -maxMag
                            bound[attribute]["range"][1] = maxMag
                    elif "EgoAcc" in attribute:
                        bound[attribute] = {
                            "range": [-5, 5],
                            "colorscale": None,
                        }
                    elif "EgoSpeed" in attribute:
                        values = [abs(v) for v in trajectory[attribute]]
                        valueMax = max(values)
                        if attribute not in bound:
                            bound[attribute] = {
                                "range": [0, (math.ceil(valueMax / 10) * 10) / 3.6],
                                "colorscale": None
                            }
                        else:
                            maxMag = max(bound[attribute]["range"][1], valueMax)
                            bound[attribute]["range"][1] = maxMag
                    else:
                        values = [v for v in trajectory[attribute]]
                        valueMax = max(values)
                        valueMin = min(values)
                        if attribute not in bound:
                            bound[attribute] = {
                                "range": [valueMin, valueMax],
                                "colorscale": None
                            }
                        else:
                            maxValue = max(bound[attribute]["range"][1], valueMax)
                            minValue = min(bound[attribute]["range"][0], valueMin)
                            bound[attribute]["range"][0] = minValue
                            bound[attribute]["range"][1] = maxValue

        road_bounds = {
            road_id: (min(vals), max(vals))
            for road_id, vals in road_s_ranges.items()
        }
        for egoName in returned.keys():
            trialOrder = returned[egoName].mfpca["full"].trialOrder
            for attribute in visualization_columns:
                output_path = f"{egoName}_{attribute}_time_fullheatmap.png"
                draw_full_heatmap(
                    trajectory_data=heatmapData[egoName],  # your parsed data
                    trial_order=trialOrder,
                    attribute=attribute,
                    value_range=bound[attribute]["range"],
                    frame_period=0.1,
                    resolution=3,
                    output_path=output_path,
                )
                # Open the PNG file in binary mode
                with open(output_path, "rb") as f:
                    files = {
                        "file": (output_path, f, "image/png")
                    }
                    response = requests.post(
                        f"{PAYLOAD_API}/api/documents",
                        files=files,
                        headers=headers
                    )
                response.raise_for_status()
                imageDoc = response.json()["doc"]
                print("Uploaded file info:", imageDoc)
                returned[egoName].fullHeatmaps.append(imageDoc)
                docsave[egoName]["fullHeatmaps"].append(imageDoc)

                # output_path = f"{egoName}_{attribute}_s_fullheatmap.png"
                # draw_full_heatmap_s(
                #     trajectory_data=heatmapData[egoName],
                #     raw_traj_data=rawTrajectoryData[egoName],
                #     trial_order=trialOrder,
                #     attribute=attribute,
                #     value_range=bound[attribute]["range"],
                #     road_bounds=road_bounds,
                #     road_id_order=road_id_order,
                #     s_bin_size=0.25,
                #     resolution=3,
                #     output_path=output_path,
                # )
                # with open(output_path, "rb") as f:
                #     files = {
                #         "file": (output_path, f, "image/png")
                #     }
                #     response = requests.post(
                #         "{PAYLOAD_API}/documents",
                #         files=files,
                #         headers=headers
                #     )
                # response.raise_for_status()
                # imageDoc = response.json()["doc"]
                # print("Uploaded file info:", imageDoc)
                # returned[egoName].fullHeatmaps.append(imageDoc)

        for egoName in returned.keys():
            returned[egoName].bound = bound
            docsave[egoName]["bound"] = bound

        json_bytes = json.dumps(docsave).encode("utf-8")
        zip_buffer = io.BytesIO()
        with zipfile.ZipFile(
            zip_buffer, mode="w", compression=zipfile.ZIP_DEFLATED
        ) as zip_file:
            zip_file.writestr("trajectories.json", json_bytes)
        zip_buffer.seek(0)
        files = {"file": ("analysis.zip", zip_buffer, "application/zip")}
        response = requests.post(
            f"{PAYLOAD_API}/api/documents",
            files=files,
            headers=headers,
        )
        response.raise_for_status()

        if _capture is not None:
            _capture.record(
                "stage1_capture",
                run_id,
                "analyzer_response",
                {"egos": list(returned.keys()), "response_keys": list(docsave.keys())},
            )

        if (
            os.getenv("GPL_ODD_CLUSTER_INTERPRETATION", "").lower()
            in ("1", "true", "yes")
            and phase6_context is not None
        ):
            try:
                from cluster_interpretation_pipeline import (
                    run_post_analyzer_cluster_interpretation,
                    zip_interpretations,
                )

                run_dir = run_post_analyzer_cluster_interpretation(
                    analyzer_run_id=run_id,
                    batch_mappings=phase6_context["batch_mappings"],
                    trial_mappings=phase6_context["trial_mappings"],
                    mfpca_value=phase6_context["mfpca_value"],
                    clustering_results=phase6_context["clustering_results"],
                    capture=_capture,
                )
                if run_dir is not None:
                    zip_buffer = zip_interpretations(run_dir)
                    response = requests.post(
                        f"{PAYLOAD_API}/api/documents",
                        files={
                            "file": (
                                "cluster_interpretations.zip",
                                zip_buffer,
                                "application/zip",
                            )
                        },
                        headers=headers,
                    )
                    response.raise_for_status()
                    print(
                        "[Phase6] Uploaded cluster_interpretations.zip:",
                        response.json().get("doc", {}).get("id"),
                    )
            except Exception as exc:
                print(f"[Phase6] Cluster interpretation failed: {exc}", file=sys.stderr)

        analysis_progress.update("packaging", 1, 1, "Packaging results…")
        analysis_progress.finish()
        return returned

    def get_trajectories(self, data: TrajectoryAnalysisRequest, egoId: int):
        trajectory_queries = []
        trial_mappings = {}
        batch_mappings = {}

        batch_trials = []
        for batchId in data.batchIds:
            variables = {"id": batchId}

            response = requests.get(
                f"{PAYLOAD_API}/api/batches/{batchId}?depth=3",
                headers=headers,
            )
            response.raise_for_status()
            response_data = response.json()
            batch = response_data
            batch_mappings[batchId] = {"id": batchId, "scenario": batch["scenario"]}
            scenario_parameters = batch["scenario"]["parameters"]
            sorted(scenario_parameters, key=lambda p: p["id"])

            variables = {"limit": 0, "where": {"batch": {"equals": int(batchId)}}}

            # response_data = requests.post(
            #     str(PAYLOAD_GRAPHQL_API),
            #     json={"query": trials_query, "variables": variables},
            #     headers = {
            #         "Content-Type": "application/json",
            #         "Accept": "application/json"
            #     }
            # ).json()
            # pprint(response_data["data"].keys())
            # trials = response_data["data"]["docs"]

            params = {
                "limit": 0,
                "where": {"batch": {"equals": batchId}, "ego": {"equals": egoId}},
            }
            qs = qs_stringify(params)
            response = requests.get(
                f"{PAYLOAD_API}/api/trials?{qs}",
                headers=headers,
            )
            pprint(f"{PAYLOAD_API}/api/trials?{qs}")
            response.raise_for_status()
            trials_response_data = response.json()

            for trial in trials_response_data["docs"]:
                if trial is None or trial["testObjectives"] is None:
                    continue
                batch_trials.append(trial)
                trial["batchId"] = batchId
                trial_mappings[str(trial["id"])] = trial

        def split_into_chunks(lst, chunk_size):
            """Splits the list `lst` into chunks of size `chunk_size` using list comprehension."""
            return [lst[i : i + chunk_size] for i in range(0, len(lst), chunk_size)]

        trajectories_data = []
        trajectory_queries_chunks = split_into_chunks(
            [trial["id"] for trial in batch_trials], 100
        )
        total_chunks = len(trajectory_queries_chunks)
        for index, chunk in enumerate(trajectory_queries_chunks):
            analysis_progress.update(
                "loading_trajectories",
                index,
                total_chunks,
                f"Loading trajectories ({index + 1}/{total_chunks} chunks)…",
            )
            t = Timer("Get Trajectories" + f", chunk: {index}")
            t.start()
            response = requests.post(
                f"{PAYLOAD_API}/api/trials/trajectories",
                json={"trialIds": [int(v) for v in chunk], "framePeriod": 0.1},
                headers=headers,
            )
            response.raise_for_status()
            trajectories_data += response.json()

            t.stop()
            # if index >= 30:
            #     break
            if index >= 10:
                break
            # if index >= 5:
            #     break
            # if index >= 1:
            #     break

        trajectories_mappings = {
            str(item["trialId"]): item for item in trajectories_data
        }

        columns = []
        trajectories = {}
        rawTrajectories = {}
        i = 0
        for trial_id, item in trajectories_mappings.items():
            i += 1
            # print(i)
            time_series = self.get_time_series(item)
            collision_type = self.get_collision_type(item, trial_mappings[trial_id])
            # collision_type = self.get_collision_type_time_series(
            #     item, time_series, trial_mappings[trial_id]
            # )
            trial_mappings[trial_id]["collision_type"] = collision_type
            if time_series is None or len(time_series) == 0:
                print("{} time_series is none, continue...".format(trial_id))
                continue
            columns = list(time_series[0].keys())
            columns = [c for c in columns if c != "time"]
            trajectories[str(trial_id)] = time_series
            rawTrajectories[str(trial_id)] = item

        return trajectories, rawTrajectories, trial_mappings, batch_mappings, columns

    def get_collision_type(self, trajectory_item, trial) -> Literal[0, 1, 2]:
        trial_metric = [
            m
            for m in trial["testObjectives"]["criticalityMetrics"]
            if m["keyPerformanceIndicator"]["name"] == "collision"
        ][0]

        passed = trial_metric["passed"]
        if passed:
            return 0

        last_ego_item = trajectory_item["trajectory"]["Ego"][-1]

        ego_x = last_ego_item["x"]
        ego_y = last_ego_item["y"]
        ego_yaw = last_ego_item["yaw"]
        ego_speed = last_ego_item["speed"]
        ego_acc = last_ego_item["acceleration"]
        ego_yaw_rate = last_ego_item["yawRate"]
        ego_heading = heading_vector_from_yaw(ego_yaw)

        agent_names = sorted(trajectory_item["trajectory"].keys())

        is_ego_fault = False
        nearest_distance = float("inf")
        agent_data = {}
        for name in agent_names:
            if name == "Ego":
                continue
            last_agent_item = trajectory_item["trajectory"][name][-1]
            agent_data = {
                "x": last_agent_item["x"],
                "y": last_agent_item["y"],
                "yaw": last_agent_item["yaw"],
                "speed": last_agent_item["speed"],
                "length": last_agent_item["length"],
                "width": last_agent_item["width"],
                "rel_dist": last_agent_item["relativeDistance"],
                "dce": last_agent_item["dce"],
                "ttc": last_agent_item["ttc"],
                "spret": last_agent_item["spret"],
                "heading": heading_vector_from_yaw(last_agent_item["yaw"]),
            }

            pair_np = np.array(
                [
                    ego_x,
                    ego_y,
                    ego_speed * ego_heading[0],
                    ego_speed * ego_heading[1],
                    ego_heading[0],
                    ego_heading[1],
                    ego_speed,
                    5.17,
                    2.2,
                    agent_data["x"],
                    agent_data["y"],
                    agent_data["speed"] * agent_data["heading"][0],
                    agent_data["speed"] * agent_data["heading"][1],
                    agent_data["heading"][0],
                    agent_data["heading"][1],
                    agent_data["length"],
                    agent_data["width"],
                    agent_data["speed"],
                ],
                dtype=np.float32,
            )[
                None, :
            ]  # shape = (1, 18)

            points = getpoints_np(pair_np)
            ego_poly, agent_poly = Polygon(points[:4]), Polygon(points[4:])

            nearest_point_on_ego, nearest_point_on_agent = nearest_points(
                ego_poly, agent_poly
            )
            dist = nearest_point_on_ego.distance(nearest_point_on_agent)

            if nearest_distance != 0 and dist < nearest_distance:
                if agent_data["speed"] < 1.39:
                    is_ego_fault = True
                elif ego_speed < 1.39:
                    is_ego_fault = False
                else:
                    is_ego_fault = is_on_front_third(
                        ego_poly, nearest_point_on_ego, ego_yaw
                    )
                nearest_distance = dist

        # if ego_speed < 1.39:  # below 5 kph
        #     return 2

        return 1 if is_ego_fault else 2

    def get_collision_type_time_series(
        self, trajectory_item, time_series, trial
    ) -> Literal[0, 1, 2]:
        trial_metric = [
            m
            for m in trial["testObjectives"]["criticalityMetrics"]
            if m["keyPerformanceIndicator"]["name"] == "collision"
        ][0]

        passed = trial_metric["passed"]
        if passed:
            return 0

        agent_names = sorted(trajectory_item["trajectory"].keys())

        for index, timepoint in enumerate(trajectory_item["time"]):
            ego_x = trajectory_item["trajectory"]["Ego"][index]["x"]
            ego_y = trajectory_item["trajectory"]["Ego"][index]["y"]
            ego_yaw = trajectory_item["trajectory"]["Ego"][index]["yaw"]
            ego_speed = trajectory_item["trajectory"]["Ego"][index]["speed"]
            ego_heading = heading_vector_from_yaw(ego_yaw)
            for agent_name in agent_names:
                if agent_name == "Ego":
                    continue
                agent_data = {}
                last_agent_item = trajectory_item["trajectory"][agent_name][index]
                agent_data = {
                    "x": last_agent_item["x"],
                    "y": last_agent_item["y"],
                    "yaw": last_agent_item["yaw"],
                    "speed": last_agent_item["speed"],
                    "length": last_agent_item["length"],
                    "width": last_agent_item["width"],
                    # "rel_dist": last_agent_item["relativeDistance"],
                    # "dce": last_agent_item["dce"],
                    # "ttc": last_agent_item["ttc"],
                    # "spret": last_agent_item["spret"],
                    "heading": heading_vector_from_yaw(last_agent_item["yaw"]),
                }
                pair_np = np.array(
                    [
                        ego_x,
                        ego_y,
                        ego_speed * ego_heading[0],
                        ego_speed * ego_heading[1],
                        ego_heading[0],
                        ego_heading[1],
                        ego_speed,
                        5.17,
                        2.2,
                        agent_data["x"],
                        agent_data["y"],
                        agent_data["speed"] * agent_data["heading"][0],
                        agent_data["speed"] * agent_data["heading"][1],
                        agent_data["heading"][0],
                        agent_data["heading"][1],
                        agent_data["length"],
                        agent_data["width"],
                        agent_data["speed"],
                    ],
                    dtype=np.float32,
                )[
                    None, :
                ]  # shape = (1, 18)

                points = getpoints_np(pair_np)
                ego_poly, agent_poly = Polygon(points[:4]), Polygon(points[4:])

                nearest_point_on_ego, nearest_point_on_agent = nearest_points(
                    ego_poly, agent_poly
                )
                dist = nearest_point_on_ego.distance(nearest_point_on_agent)
                # if dist < 0.01:
                if ego_poly.intersects(agent_poly):
                    print(timepoint)
                    print(ego_poly)
                    print(agent_poly)
                    print(ego_yaw)
                    print("ego speed")
                    print(ego_speed)
                    print(agent_data["speed"])
                    print(agent_name)
                    print(nearest_point_on_ego)
                    if agent_data["speed"] < 1.39:
                        is_ego_fault = True
                    elif ego_speed < 1.39:
                        is_ego_fault = False
                    else:
                        print("is on front third")
                        is_ego_fault = is_on_front_third(
                            ego_poly, nearest_point_on_ego, ego_yaw
                        )
                        print(is_ego_fault)
                    if is_ego_fault:
                        return 1
                    else:
                        return 2

        target_index = 0
        target_agent_name = None
        for index, snapshot in enumerate(time_series):
            for agent_name in agent_names:
                if agent_name == "Ego":
                    continue
                attribute = agent_name + "RelativeDistance"
                # print(index)
                # print(snapshot[attribute])
                if snapshot[attribute] < 0.05:
                    pprint("found collide snapshot")
                    pprint(snapshot[attribute])
                    target_index = index
                    target_agent_name = agent_name
                    break
            if target_agent_name is not None:
                break

        pprint(target_agent_name)
        pprint(target_index)
        if target_index == 0 or target_agent_name is None:
            pprint("cannot found collision type")
            pprint(trial)
            return 2

        last_ego_item = trajectory_item["trajectory"]["Ego"][target_index]

        ego_x = last_ego_item["x"]
        ego_y = last_ego_item["y"]
        ego_yaw = last_ego_item["yaw"]
        ego_speed = last_ego_item["speed"]
        # ego_acc = last_ego_item["acceleration"]
        # ego_yaw_rate = last_ego_item["yawRate"]
        ego_heading = heading_vector_from_yaw(ego_yaw)

        is_ego_fault = False
        nearest_distance = float("inf")

        agent_data = {}
        last_agent_item = trajectory_item["trajectory"][target_agent_name][target_index]
        agent_data = {
            "x": last_agent_item["x"],
            "y": last_agent_item["y"],
            "yaw": last_agent_item["yaw"],
            "speed": last_agent_item["speed"],
            "length": last_agent_item["length"],
            "width": last_agent_item["width"],
            # "rel_dist": last_agent_item["relativeDistance"],
            # "dce": last_agent_item["dce"],
            # "ttc": last_agent_item["ttc"],
            # "spret": last_agent_item["spret"],
            "heading": heading_vector_from_yaw(last_agent_item["yaw"]),
        }

        pair_np = np.array(
            [
                ego_x,
                ego_y,
                ego_speed * ego_heading[0],
                ego_speed * ego_heading[1],
                ego_heading[0],
                ego_heading[1],
                ego_speed,
                5.17,
                2.2,
                agent_data["x"],
                agent_data["y"],
                agent_data["speed"] * agent_data["heading"][0],
                agent_data["speed"] * agent_data["heading"][1],
                agent_data["heading"][0],
                agent_data["heading"][1],
                agent_data["length"],
                agent_data["width"],
                agent_data["speed"],
            ],
            dtype=np.float32,
        )[
            None, :
        ]  # shape = (1, 18)

        points = getpoints_np(pair_np)
        ego_poly, agent_poly = Polygon(points[:4]), Polygon(points[4:])

        nearest_point_on_ego, nearest_point_on_agent = nearest_points(
            ego_poly, agent_poly
        )
        dist = nearest_point_on_ego.distance(nearest_point_on_agent)

        if agent_data["speed"] < 1.39:
            is_ego_fault = True
        elif ego_speed < 1.39:
            is_ego_fault = False
        else:
            is_ego_fault = is_on_front_third(ego_poly, nearest_point_on_ego, ego_yaw)
        nearest_distance = dist

        # if ego_speed < 1.39:  # below 5 kph
        #     return 2

        return 1 if is_ego_fault else 2

    def get_time_series(self, item) -> Optional[List[Dict[str, float]]]:
        agent_names = sorted(item["trajectory"].keys())
        ego_df = pd.DataFrame(item["trajectory"]["Ego"])

        # Preload ego variables
        ego_x = ego_df["x"].values
        ego_y = ego_df["y"].values
        ego_yaw = ego_df["yaw"].values
        ego_speed = ego_df["speed"].values
        ego_acc = ego_df["acceleration"].values
        ego_yaw_rate = ego_df["yawRate"].values
        # ego_t = ego_df["t"].values
        ego_offset = ego_df["laneOffset"].values
        ego_s = ego_df["s"].values
        ego_heading = np.array([heading_vector_from_yaw(yaw) for yaw in ego_yaw])

        agent_data = {}
        for name in agent_names:
            if name == "Ego":
                continue
            df = pd.DataFrame(item["trajectory"][name])
            agent_data[name] = {
                "x": df["x"].values,
                "y": df["y"].values,
                "yaw": df["yaw"].values,
                "speed": df["speed"].values,
                "length": df["length"].values,
                "width": df["width"].values,
                "rel_dist": df["relativeDistance"].values,
                "dce": df["dce"].values,
                "ttc": df["ttc"].values,
                "spret": df["spret"].values,
                "heading": np.array(
                    [heading_vector_from_yaw(y) for y in df["yaw"].values]
                ),
            }

        time_series = []

        for i, time in enumerate(item["time"]):
            row = {
                "time": float(time),
                "EgoX": float(ego_x[i]),
                "EgoY": float(ego_y[i]),
                "EgoS": float(ego_s[i]),
                "EgoOffset": float(ego_offset[i]),
                "EgoSpeed": float(ego_speed[i]),
                "EgoAcceleration": float(ego_acc[i]),
                "EgoYawRate": float(ego_yaw_rate[i]),
            }

            for agent_name, data in agent_data.items():
                dx = data["x"][i] - ego_x[i]
                dy = data["y"][i] - ego_y[i]
                yaw = ego_yaw[i]

                cos_yaw = np.cos(-yaw)
                sin_yaw = np.sin(-yaw)
                rel_x = dx * cos_yaw - dy * sin_yaw
                rel_y = dx * sin_yaw + dy * cos_yaw

                row[agent_name + "RelativeDistance"] = float(data["rel_dist"][i])
                # row[agent_name + "RelativeVelocityX"] = data["speed"][i] * math.cos(
                #     data["yaw"][i] - yaw
                # )
                # row[agent_name + "RelativeVelocityY"] = data["speed"][i] * math.sin(
                #     data["yaw"][i] - yaw
                # )

                # Compute 2D motion attributes
                # ego_vx, ego_vy = ego_speed[i] * ego_heading[i]
                # agent_vx, agent_vy = data["speed"][i] * data["heading"][i]

                pair_np = np.array(
                    [
                        ego_x[i],
                        ego_y[i],
                        ego_speed[i] * ego_heading[i][0],
                        ego_speed[i] * ego_heading[i][1],
                        ego_heading[i][0],
                        ego_heading[i][1],
                        ego_speed[i],
                        5.17,
                        2.2,
                        data["x"][i],
                        data["y"][i],
                        data["speed"][i] * data["heading"][i][0],
                        data["speed"][i] * data["heading"][i][1],
                        data["heading"][i][0],
                        data["heading"][i][1],
                        data["length"][i],
                        data["width"][i],
                        data["speed"][i],
                    ],
                    dtype=np.float32,
                )[
                    None, :
                ]  # shape = (1, 18)

                points = getpoints_np(pair_np)
                ego_poly, agent_poly = Polygon(points[:4]), Polygon(points[4:])

                nearest_point_on_ego, nearest_point_on_agent = nearest_points(
                    ego_poly, agent_poly
                )
                nx, ny = (
                    nearest_point_on_agent.x - ego_x[i],
                    nearest_point_on_agent.y - ego_y[i],
                )

                row[agent_name + "Ttc"] = float(data["ttc"][i])
                row[agent_name + "Spret"] = float(data["spret"][i])
                row[agent_name + "RelativeX"] = float(nx)
                row[agent_name + "RelativeY"] = float(ny)

                relativeTheta = float(np.arctan2(rel_y, rel_x))
                row[agent_name + "RelativeTheta"] = float(relativeTheta)

                # dist = nearest_point_on_ego.distance(nearest_point_on_agent)
                # if ego_poly.intersects(agent_poly):
                #     row[agent_name + "RelativeDistance"] = float(-0.01)

                # relativeTheta = float(np.arctan2(ny, nx))
                # row[agent_name + "RelativeThetaSin"] = float(math.sin(relativeTheta))
                # row[agent_name + "RelativeThetaCos"] = float(math.cos(relativeTheta))
                # relativeYaw = data["yaw"][i] - ego_yaw[i]
                # row[agent_name + "RelativeYaw"] = relativeYaw
                # row[agent_name + "RelativeYawSin"] = math.sin(relativeYaw)
                # row[agent_name + "RelativeYawCos"] = math.cos(relativeYaw)

            # Efficient NaN check
            if any(np.isnan(v) for v in row.values()):
                row = {
                    k: (None if isinstance(v, float) and np.isnan(v) else v)
                    for k, v in row.items()
                }
            time_series.append(row)

        return time_series

    def get_mfpca(
        self,
        trajectories,
        request: TrajectoryAnalysisRequest,
        columns: List[str],
        trial_mappings,
        clustering_duration=5,
    ):
        attributes = list(list(trajectories.values())[0][0].keys())
        frame_period = request.framePeriod
        indicies_length = int(clustering_duration / frame_period)

        # more_to_visualize_seconds = 3
        # more_to_viz_length = int(more_to_visualize_seconds / frame_period)

        agentNames = set()
        for attribute in attributes:
            if "RelativeDistance" not in attribute:
                continue
            agentName = attribute.split("RelativeDistance")[0]
            agentNames.add(agentName)

        analysis_data = {}

        # ==========================================================================
        # calculate full heatmap trial order
        # before your loops
        global_means = {}
        for col in columns:
            if col == "time":
                continue
            all_vals = []
            for traj in trajectories.values():
                all_vals.extend(item[col] for item in traj)
            global_means[col] = sum(all_vals) / len(all_vals)

        max_index_length = 0
        for trial_id, trajectory in trajectories.items():
            max_index_length = max(len(trajectory), max_index_length)
        X_full = []
        X_real = []
        trial_ids = []
        full_time_points = []
        for trial_id, trajectory in trajectories.items():
            full_time_points = []
            time_points = []
            time_point = 0
            series = []
            real_series = []
            for item in trajectory:
                full_time_points.append(time_point)
                time_points.append(time_point)
                snapshot = []
                for column in columns:
                    if column == "time":
                        continue
                    snapshot.append(item[column])
                time_point += frame_period
                # snapshot.append(1)
                series.append(snapshot)
                real_series.append(snapshot)

            while len(series) < max_index_length:
                full_time_points.append(time_point)
                snapshot = []
                real_snapshot = []
                for column in columns:
                    if column == "time":
                        continue
                    # snapshot.append(global_means[column])
                    # if "Speed" in column or "YawRate" in column or "Acc" in column:
                    #     snapshot.append(0)
                    # else:
                    #     snapshot.append(trajectory[-1][column])
                    snapshot.append(float("nan"))
                    # real_snapshot.append(float("nan"))
                    real_snapshot.append(np.nan)
                time_point += frame_period
                # snapshot.append(0)
                series.append(snapshot)
                real_series.append(real_snapshot)
            X_full.append(series)
            X_real.append(real_series)
            trial_ids.append(trial_id)

        X_full = np.array(X_full)
        X_real = np.array(X_real)

        analysis_data["full"] = {
            "X": X_full,
            "X_viz": X_full,
            "X_real": X_real,
            "trial_ids": trial_ids,
            "time_points": full_time_points,
            "viz_time_points": full_time_points,
            "clustering_duration_indices": None,
            # "more_to_viz_seconds": 0,
        }
        # ==========================================================================

        for key, value in analysis_data.items():
            X = np.array(value["X"])

            X_real = np.array(value["X_real"])

            n_samples, n_time, n_variables = X_real.shape

            time_points = np.array(value["time_points"])
            trial_ids = value["trial_ids"]

            n_samples, n_time_points, n_variables = X.shape
            list_of_fd = []
            for var_index in range(n_variables):
                data_var = X_real[:, :, var_index]  # Shape: (n_samples, n_time_points)

                new_vals = data_var.copy()

                # 1) Global std across all series/time points (ignoring NaNs)
                global_std = np.nanstd(new_vals)  # scalar

                # 2) Multiplier (e.g., 0.3 = 30% of global std)
                multiplier = 0.1
                noise_std = multiplier * global_std

                # 3) Build a full noise matrix with the same std everywhere
                n_samples, n_time_points = new_vals.shape
                noise_matrix = np.random.normal(
                    loc=0.0, scale=noise_std, size=new_vals.shape
                )

                # 4) Impute NaNs with series mean + noise
                series_means = np.nanmean(new_vals, axis=1)  # (n_samples,)
                mask_nan = np.isnan(new_vals)

                for i in range(n_samples):
                    nan_positions = mask_nan[i]
                    new_vals[i, nan_positions] = (
                        series_means[i] + noise_matrix[i, nan_positions]
                    )

                fd_var = DenseFunctionalData(
                    argvals=DenseArgvals({"input_dim_0": time_points}),
                    values=DenseValues(new_vals),
                )

                list_of_fd.append(fd_var)

            # Processing input data for MFPCA
            multivariate_fd = MultivariateFunctionalData(list_of_fd)
            t = Timer("mfpca for full order")
            t.start()
            univariate_expansions = [
                {"method": "UFPCA", "n_components": 0.95, "method_smoothing": "PS"}
                for _ in range(X.shape[2])
            ]

            # MFPCA for clustering
            mfpca = MFPCA(
                # n_components=4,
                n_components=0.95,
                normalize=True,
                method="covariance",
                univariate_expansions=univariate_expansions,
            )
            # mfpca.fit(multivariate_fd, scores_method="PACE")
            # mfpca.fit(multivariate_fd)
            mfpca.fit(multivariate_fd, method_smoothing="PS")
            scores = mfpca.transform(multivariate_fd)
            X_rep = scores

            analysis_data[key]["X_rep"] = X_rep

            score_mappings: Dict[str, List[float]] = {}
            for i, trialId in enumerate(trial_ids):
                score_mappings[trialId] = scores[i].tolist()

            analysis_data[key]["score_mappings"] = score_mappings

            # Linkage on trials
            Z = linkage(scores, method="ward", optimal_ordering=True)  # good default for continuous data
            # Z_olo = optimal_leaf_ordering(Z, pdist(scores))
            # order_idx = leaves_list(Z_olo)
            order_idx = leaves_list(Z)
            trial_order = [str(trial_ids[i]) for i in order_idx]
            analysis_data[key]["trial_order"] = trial_order

            # Mean and FPCs for see functional plot
            # Assuming X is of shape (n_samples, n_time_points, n_variables)
            attribute_mean = []
            # For each variable, standardize (center and scale)
            # for var_index in range(n_variables):
            #     # Extract the data for this variable across all samples and time points
            #     data_var = X[:, :, var_index]
            #     # Compute the mean and standard deviation for each variable
            #     mean_var = np.mean(
            #         data_var, axis=0
            #     )  # Mean across samples, shape (n_time_points,)
            #     attribute_mean.append(mean_var.astype("float64").tolist())

            analysis_data[key]["attribute_mean"] = attribute_mean

            fpcs_data = []
            # for n, fd in enumerate(mfpca.eigenfunctions.data):
            #     fd = fd.to_grid()
            #     fpcs_data.append(np.array(fd.values, dtype="float64").tolist())

            analysis_data[key]["fpcs_data"] = fpcs_data

            # Explained variation calculation
            univariate_expansions = [
                {"method": "UFPCA", "n_components": 0.99, "method_smoothing": "PS"}
                for _ in range(X.shape[2])
            ]
            t = Timer("mfpca_full")
            t.start()
            mfpca_all_explained = MFPCA(
                n_components=0.999,
                method="covariance",
                univariate_expansions=univariate_expansions,
                normalize=True,
            )
            mfpca_all_explained.fit(multivariate_fd)
            total_variance = np.sum(mfpca_all_explained.eigenvalues)
            t.stop()
            explained_variance_ratio = mfpca.eigenvalues / total_variance
            analysis_data[key][
                "explained_variance_ratio"
            ] = explained_variance_ratio.tolist()

            # ev = pd.read_csv("mfpca_explained_variance.csv")
            # analysis_data[key]["explained_variance_ratio"] = ev["PropVar"].tolist()
            # analysis_data[key]["explained_variance_ratio"] = []
            # analysis_data[key][
            #     "explained_variance_ratio"
            # ] = pca.explained_variance_ratio_.tolist()

        return analysis_data

    def get_2d_umap_projections(self, X, trialIds, precomputed=False):
        # min_dists = [0.8]
        # n_neighbors = [int(X.shape[0] / 5)]
        # n_neighbors = [200]
        min_dists = [0.5]
        # n_neighbors = [int(X.shape[0] / 4)]
        n_neighbors = [100]
        # min_dists = [0, 0.01, 0.05, 0.1, 0.5, 0.7]
        # n_neighbors = [5, 7, 10, 15, 25, 50, 100]
        # min_dists = [0, 0.01, 0.05, 0.1, 0.5, 0.7]
        # n_neighbors = [5, 7, 10, 15, 25, 50, 100]

        result: List[UmapProjection] = []
        X_umap = []
        for min_dist, n_neighbor in itertools.product(min_dists, n_neighbors):
            if n_neighbor <= 0 or n_neighbor > X.shape[0]:
                print(f"n_neighbor: {n_neighbor}, X.shape[0]: {X.shape[0]}, not good")
                continue

            # eigs = np.loadtxt("mfpca_eigs.csv", delimiter=",", skiprows=1)
            # scale = 1.0 / np.sqrt(np.maximum(eigs, 1e-12))
            # X_centered = X - X.mean(axis=0, keepdims=True)
            # Xw = X_centered * scale  # broadcast divide each column by sqrt(eigval)

            # scaler = StandardScaler(with_mean=True, with_std=True)
            # Xw = scaler.fit_transform(X)

            parameters = UmapParameter(min_dist, n_neighbor)
            um = umap.UMAP(
                n_components=2,
                n_neighbors=n_neighbor,
                min_dist=min_dist,
                metric="precomputed" if precomputed else "euclidean",
            )
            X_red = um.fit_transform(X)
            X_red = X_red.astype(dtype=float)

            # X_red, params = build_tsne(
            #     X, n_neighbor=n_neighbor, precomputed=precomputed, seed=0
            # )
            # tsne = TSNE(
            #     n_components=2,
            #     metric="precomputed" if precomputed else "euclidean",
            #     init="pca",  # or "pca"
            #     learning_rate="auto",
            # )
            # X_red = tsne.fit_transform(Xw)
            # X_red = X_red.astype(dtype=float)

            data: Dict[str, List[float]] = {}
            for i, trialId in enumerate(trialIds):
                data[trialId] = list(X_red[i])
                X_umap.append(list(X_red[i]))

            result.append(UmapProjection(parameters=parameters, data=data))

        return result, X_umap

    def cluster(
        self, X, data: TrajectoryAnalysisRequest, trialIds: List[str], isFull=False
    ):
        results: List[Union[ClusteringResult, None]] = []
        X = X.astype(np.float64)

        print("CLustering X shape")
        print(X.shape)

        def execute_task(task):
            # print("EXECUTE_TASK")
            # print(task.method)
            t = Timer("task " + f"{task.method}, {task.minClusterSize}, {task.minSamples}, {task.clusterSelectionEpsilon}, {task.clusterSelectionMethod}")
            t.start()
            clusterer = None
            try:
                if "hdbscan" in task.method:
                    hdbscan_clusterer = hdbscan.HDBSCAN(
                        min_cluster_size=task.minClusterSize,
                        min_samples=(
                            task.minSamples
                            if task.minSamples != -1 and task.minSamples < X.shape[0]
                            else None
                        ),
                        cluster_selection_epsilon=task.clusterSelectionEpsilon,
                        cluster_selection_method=task.clusterSelectionMethod,
                        prediction_data=True,
                        gen_min_span_tree=True,
                    ).fit(X)
                    clusterer = hdbscan_clusterer
                    cluster_labels = np.array(clusterer.labels_)
                else:
                    Z = linkage(X, method="ward")
                    cluster_labels = fcluster(Z, t=task.nClusters, criterion="maxclust")
            except:
                return None

            # Step 2: Group indices by label
            label_to_indices = defaultdict(list)
            for idx, label in enumerate(cluster_labels):
                label_to_indices[label].append(idx)

            # Step 3-5: Dendrogram leaf order per group
            label_leaf_orders = {}
            for label, indices in label_to_indices.items():
                n = len(indices)

                if n == 0:
                    # Shouldn't happen with 'maxclust', but keep it defensive
                    label_leaf_orders[str(label)] = []
                    continue

                if n == 1:
                    # No dendrogram possible; the only item is the order
                    only_idx = indices[0]
                    label_leaf_orders[str(label)] = [trialIds[only_idx]]
                    continue

                # X_sub = X[indices]
                # Z = linkage(X_sub, method="ward", optimal_ordering=True)  # good default for continuous data
                # order_idx = leaves_list(Z)
                # trial_order = [trialIds[int(indices[i])] for i in order_idx]

                trial_order = [trialIds[i] for i in indices]
                label_leaf_orders[str(label)] = trial_order

            cluster_items = [
                TrialClusterItem(
                    trialIds[i],
                    str(int(cluster_labels[i])),
                )
                for i in range(len(cluster_labels))
            ]
            t.stop()

            return (
                task,
                cluster_labels,
                cluster_items,
                label_leaf_orders,
                clusterer.relative_validity_ if clusterer is not None else 0,
            )

        def execute_tasks_in_parallel(tasks):
            total_tasks = len(tasks)
            completed_tasks = 0
            taskOutputs: List[Optional[tuple]] = [None] * total_tasks
            with ThreadPoolExecutor() as executor:
                future_to_index = {
                    executor.submit(execute_task, task): i
                    for i, task in enumerate(tasks)
                }
                for future in as_completed(future_to_index):
                    index = future_to_index[future]
                    taskOutputs[index] = future.result()
                    completed_tasks += 1
                    analysis_progress.update(
                        "clustering",
                        completed_tasks,
                        total_tasks,
                        f"HDBSCAN task {completed_tasks}/{total_tasks}",
                    )
            for i, output in enumerate(taskOutputs):
                if output is None:
                    results.append(None)
                    continue

                (
                    task,
                    cluster_labels,
                    cluster_items,
                    trial_order,
                    relative_validity,
                ) = output

                if cluster_labels is None or len(cluster_labels) <= 1:
                    scores = ClusteringScores(None, None, None, None)
                else:
                    try:
                        scores = ClusteringScores(
                            float(calinski_harabasz_score(X, cluster_labels)),
                            float(silhouette_score(X, cluster_labels)),
                            float(davies_bouldin_score(X, cluster_labels)),
                            float(relative_validity),
                        )

                    except:
                        scores = ClusteringScores(None, None, None, None)

                results.append(
                    ClusteringResult(
                        task=task,
                        data={item.trialId: item for item in cluster_items},
                        scores=scores,
                        trialOrder=trial_order,
                    )
                )

        execute_tasks_in_parallel(data.tasks)

        return results

    # ------------------------------------------------------------------
    # Phase 2 — Cluster Medoid Selection
    # ------------------------------------------------------------------

    def get_cluster_medoids(
        self,
        X_rep: np.ndarray,
        trial_ids: List[str],
        cluster_labels: np.ndarray,
    ) -> Dict[int, str]:
        """
        For each cluster, find the single trial whose MFPCA score vector
        is closest (L2) to the cluster centroid.  This is the medoid —
        the most representative, replayable trial for that cluster.

        Args:
            X_rep:          2-D float array of shape (n_trials, n_components).
                            MFPCA scores produced by ``mfpca.transform()``.
            trial_ids:      List of trial-ID strings, same order as X_rep rows.
            cluster_labels: 1-D int array, one label per trial.
                            Label -1 means HDBSCAN noise — excluded.

        Returns:
            Dict mapping cluster_label (int) → medoid_trial_id (str).

        Example:
            >>> medoids = controller.get_cluster_medoids(X_rep, trial_ids, labels)
            >>> medoids
            {0: "1042", 1: "887", 2: "1193"}
        """
        from sklearn.metrics import pairwise_distances_argmin

        X = np.asarray(X_rep, dtype=np.float64)
        ids = np.asarray(trial_ids)
        labels = np.asarray(cluster_labels, dtype=int)

        unique_labels = sorted(set(labels.tolist()) - {-1})
        medoids: Dict[int, str] = {}

        for label in unique_labels:
            mask = labels == label
            X_cluster = X[mask]
            ids_cluster = ids[mask]

            centroid = X_cluster.mean(axis=0, keepdims=True)
            idx = pairwise_distances_argmin(centroid, X_cluster, metric="euclidean")[0]
            medoids[label] = str(ids_cluster[idx])

        return medoids

    def get_medoid_observations(self, trial_id: str) -> List[Dict]:
        """
        Fetch raw Observations for *trial_id* directly from Payload CMS.

        This bypasses the ``replayerTrajectories`` reconstruction (which
        used to corrupt roadId/laneId values) and returns the authoritative
        esmini ground-truth values stored in the Observations collection.

        Each returned observation dict contains at minimum:
            egoX, egoY, egoYaw, egoSpeed,
            egoRoadId, egoLaneId,
            timestep, agents (list of per-agent dicts with roadId, laneId)

        Args:
            trial_id: String trial ID (as stored in Payload).

        Returns:
            List of observation dicts ordered by timestep.
            Returns [] on any API error (logged to stderr).
        """
        try:
            params = {
                "limit": 0,
                "where": {"trial": {"equals": trial_id}},
                "sort": "timestep",
            }
            qs = qs_stringify(params)
            response = requests.get(
                f"{PAYLOAD_API}/api/observations?{qs}",
                headers=headers,
                timeout=60,
            )
            response.raise_for_status()
            data = response.json()
            return data.get("docs", [])
        except Exception as exc:
            print(
                f"[get_medoid_observations] WARNING: could not fetch observations "
                f"for trial {trial_id}: {exc}",
                file=sys.stderr,
            )
            return []
