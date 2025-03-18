from pprint import pprint
from ax.models.torch.botorch_modular.utils import MultiTaskGP
from numpy.typing import NDArray
from sklearn.model_selection import train_test_split
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
import gpytorch
from ax.modelbridge.modelbridge_utils import (
    SupervisedDataset,
    checked_cast,
    extract_search_space_digest,
)
from ax.modelbridge.registry import Models
from ax.models.torch.botorch_modular.surrogate import SearchSpaceDigest, Surrogate
from ax.service.ax_client import (
    AxClient,
    GeneratorRun,
    ObjectiveProperties,
    TEvaluationOutcome,
    TParameterization,
    exp_to_df,
)
from botorch.models.transforms.input import Normalize
from botorch.models.transforms.outcome import Standardize

from .utils.timer import Timer

# Check if GPU is available
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
device = "cpu"
print(f"Using device: {device}")


# Training function with Early Stopping
def train_surrogate_model(
    X: torch.Tensor,
    Y: torch.Tensor,
    normalized_input=True,
    standardize_output=True,
):
    X = X[: min(1300, X.shape[0])]
    Y = Y[: min(1300, X.shape[0])]
    X_numpy = X.numpy()  # Convert to NumPy
    feature_min = np.min(X_numpy, axis=0)  # Minimum for each feature
    feature_max = np.max(X_numpy, axis=0)  # Maximum for each feature
    bounds = np.array(list(zip(feature_min, feature_max))).tolist()
    feature_names = [str(i) for i in range(X.shape[1])]
    search_space_digest = SearchSpaceDigest(feature_names=feature_names, bounds=bounds)
    model = Surrogate(
        # botorch_model_class=MultiTaskGP,
        # model_options={"nu": 5 / 2},
        input_transform_classes=[Normalize],
        input_transform_options={"Normalize": {"d": X.shape[1]}},
        outcome_transform_classes=[Standardize],
        outcome_transform_options={"Standardize": {"m": Y.shape[1]}},
    )
    if not normalized_input and standardize_output:
        model = Surrogate(
            outcome_transform_classes=[Standardize],
            outcome_transform_options={"Standardize": {"m": Y.shape[1]}},
        )
    if not standardize_output and normalized_input:
        model = Surrogate(
            input_transform_classes=[Normalize],
            input_transform_options={"Normalize": {"d": X.shape[1]}},
        )
    if not standardize_output and not normalized_input:
        model = Surrogate()

    # indices = np.random.choice(X_numpy.shape[0], size=1500, replace=False)
    # X = X[indices]
    X = X.to(device)
    # Y = Y[indices]
    Y = Y.to(device)
    print("yshape")
    print(Y.shape)

    supervised_datasets: list[SupervisedDataset] = []
    outcome_names = [str(i) for i in range(Y.shape[1])]
    for index, outcome_name in enumerate(outcome_names):
        y_train = Y[:, index].reshape(-1, 1)
        print(y_train.shape)
        dataset = SupervisedDataset(
            X=X,
            Y=y_train,
            feature_names=feature_names,
            outcome_names=[outcome_name],
        )
        supervised_datasets.append(dataset)

    t = Timer("fit surrogate")
    t.start()
    model.fit(
        datasets=supervised_datasets,
        search_space_digest=search_space_digest,
    )
    t.stop()

    return model


def calculate_gradients(model: Surrogate, X: torch.Tensor):
    """
    Calculate the gradients of each output with respect to each input feature using the Jacobian.

    Args:
        model (Surrogate): The trained Ax surrogate model.
        X (torch.Tensor): Input tensor of shape [num_samples, num_features].

    Returns:
        torch.Tensor: Gradients of shape [num_samples, num_outputs, num_features].
    """
    # Access the underlying BoTorch model
    botorch_model = model.model
    botorch_model.eval()

    # Ensure X requires gradients
    X = X.clone().detach().requires_grad_(True).to(device)

    posterior = botorch_model(X)
    mean = posterior.mean
    print("meanshape")
    print(mean.shape)
    pprint(torch.max(mean))
    pprint(torch.min(mean))

    if len(mean.shape) == 1:
        mean = mean.reshape(1, -1)

    # Since inputs and outputs are both batched, we need to handle the batch dimension
    # Typically, you would compute gradients per sample
    # Here, we assume independence and extract gradients per sample
    # This step may vary based on your specific use case

    # grad_mean = torch.autograd.grad(
    #     outputs=mean,
    #     inputs=X,
    #     grad_outputs=torch.ones_like(mean),  # Gradient weights
    #     retain_graph=True,  # Keep computation graph for multiple grads
    #     create_graph=False,  # No need to construct higher-order gradients
    # )[0]

    print("Compute Grad...")
    # Compute gradients
    grad_mean = []
    for i in range(mean.shape[0]):  # Loop over output dimensions
        print("Iter %d/%d - grad computing" % (i + 1, mean.shape[0]))
        grad = torch.autograd.grad(
            outputs=mean[i, :],  # i-th output dimension
            inputs=X,
            grad_outputs=torch.ones_like(mean[i, :]),  # Gradient weights
            retain_graph=True,  # Keep computation graph for multiple grads
            create_graph=False,  # No need to construct higher-order gradients
        )[
            0
        ]  # Extract tensor from tuple
        grad_mean.append(grad)

    # Stack gradients along the output dimension
    grad_mean = torch.stack(grad_mean, dim=2)  # Shape: (N, D, Output_Dim)
    print("gradmeanshape")
    print(grad_mean.shape)
    print(torch.max(grad_mean))
    print(torch.min(grad_mean))

    grad_mean = grad_mean.detach().cpu().numpy()
    return grad_mean


def predict(model: Surrogate, X: torch.Tensor):
    # Access the underlying BoTorch model
    botorch_model = model.model
    botorch_model.eval()

    # Ensure X requires gradients
    X = X.clone().detach().requires_grad_(True).to(device)

    posterior = botorch_model(X)
    mean = posterior.mean
    print("meanshape")
    print(mean.shape)
    pprint(torch.max(mean))
    pprint(torch.min(mean))

    if len(mean.shape) == 1:
        mean = mean.reshape(1, -1)

    return mean
