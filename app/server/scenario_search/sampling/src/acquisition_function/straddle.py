from typing import Any
import numpy as np
import torch
from torch import Tensor
from ax.models.torch.botorch_modular.surrogate import Surrogate
from .base import AcquisitionFunction


class Straddle(AcquisitionFunction):
    def __init__(
        self,
        surrogate: Surrogate,
        exploration_factor: float,
        safety_metrics_config: dict[str, dict[str, Any]],
    ):
        super().__init__(surrogate)
        self.exploration_factor = exploration_factor
        self.safety_metrics_config = safety_metrics_config
        self.outcome_names = sorted(list(self.safety_metrics_config.keys()))

        outcome_thresholds = []
        outcome_signs = []
        for index, key in enumerate(self.outcome_names):
            metric_safety_requirement = self.safety_metrics_config[key]
            outcome_thresholds.append(metric_safety_requirement["threshold"])
            outcome_signs.append(
                -1 if metric_safety_requirement["rule"] == "greaterThan" else 1
            )
        self.outcome_thresholds = Tensor(outcome_thresholds)
        self.outcome_signs = Tensor(outcome_signs)

    def __call__(self, X: Tensor) -> Tensor:
        self.outcome_thresholds.to(X.device, X.dtype)
        mu, sigma = self._predict(X)
        values = (
            self.exploration_factor * sigma - (mu - self.outcome_thresholds).abs()
        )  # n x o
        values = values / (mu.max(dim=0).values - mu.min(dim=0).values)  # normalize
        values = values.max(dim=-1).values.reshape(
            -1, 1
        )  # choose the max acq value between outputs for each rows and reshape to a single solumn: n x 1
        return values
