from typing import Tuple
from abc import ABC, abstractmethod
from ax.models.torch.botorch_modular.surrogate import Surrogate
import numpy as np
import torch
from torch import Tensor


class AcquisitionFunction(ABC):
    def __init__(self, surrogate: Surrogate):
        self.surrogate = surrogate

    @abstractmethod
    def __call__(self, X: Tensor) -> Tensor:
        return NotImplementedError()

    def _predict(self, X: Tensor) -> Tuple[Tensor, Tensor]:
        Y_pred, Y_cov = self.surrogate.predict(X)
        Y_std = torch.zeros_like(Y_pred)
        for index in range(Y_pred.shape[1]):
            y_std = Y_cov[:, index, index]
            Y_std[:, index] = y_std
        return (Y_pred, Y_std)
