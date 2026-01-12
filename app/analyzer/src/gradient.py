from numpy.typing import NDArray
from sklearn.model_selection import train_test_split
import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim

# Check if GPU is available
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Using device: {device}")


# Define a neural network with multiple outputs
class SurrogateNN(nn.Module):
    def __init__(self, input_num, output_num):
        super().__init__()
        self.layers = nn.Sequential(
            nn.Linear(input_num, 64),  # First hidden layer
            nn.ReLU(),
            nn.Linear(64, 128),  # Second hidden layer
            nn.ReLU(),
            nn.Linear(128, 128),  # Second hidden layer
            nn.ReLU(),
            nn.Linear(128, 64),  # Second hidden layer
            nn.ReLU(),
            nn.Dropout(p=0.5),  # 50% dropout
            nn.Linear(64, output_num),  # Output layer (2 outputs)
        )

    def forward(self, x):
        return self.layers(x)

    # Calculate gradients
    def calculate_gradients(self, X: torch.Tensor) -> torch.Tensor:
        self.eval()  # Use evaluation mode for deterministic outputs

        # Ensure input tensor has requires_grad=True
        if not X.requires_grad:
            X.requires_grad = True

        # Forward pass
        output = self.forward(X)

        gradients = []
        for i in range(output.size(1)):  # Loop over output dimensions
            grad = torch.autograd.grad(
                outputs=output[:, i],
                inputs=X,
                grad_outputs=torch.ones_like(output[:, i]),
                retain_graph=True,  # Needed to compute multiple gradients
                create_graph=False,  # Avoid higher-order gradient tracking
            )[0]
            gradients.append(grad)

        return torch.stack(
            gradients, dim=2
        )  # Shape: (input_samples, input_num, output_num)


# Training function with Early Stopping
def train_surrogate_nn_model(
    X: torch.Tensor,
    Y: torch.Tensor,
    val_split: float = 0.2,
    patience: int = 50,
    max_epochs: int = 100,
    lr: float = 0.01,
) -> SurrogateNN:
    # Split the data into training and validation sets
    X_train, X_val, Y_train, Y_val = train_test_split(
        X, Y, test_size=val_split, random_state=42
    )
    X_train = torch.tensor(X_train).float()
    X_val = torch.tensor(X_val).float()
    Y_train = torch.tensor(Y_train).float()
    Y_val = torch.tensor(Y_val).float()

    # Initialize the model, loss function, and optimizer
    model = SurrogateNN(X.shape[1], Y.shape[1])
    criterion = nn.MSELoss()
    # optimizer = optim.Adam(model.parameters(), lr=lr)
    optimizer = torch.optim.Adam(
        model.parameters(), lr=lr, weight_decay=1e-4
    )  # L2 regularization

    # Early stopping variables
    best_val_loss = float("inf")
    patience_counter = 0
    best_model_state = None

    for epoch in range(max_epochs):
        # Training phase
        model.train()
        optimizer.zero_grad()
        predictions = model(X_train)
        loss = criterion(predictions, Y_train)
        loss.backward()
        optimizer.step()

        # Validation phase
        model.eval()
        with torch.no_grad():
            val_predictions = model(X_val)
            val_loss = criterion(val_predictions, Y_val)

        # Check for early stopping
        if val_loss < best_val_loss:
            best_val_loss = val_loss
            patience_counter = 0  # Reset patience counter
            best_model_state = model.state_dict()  # Save best model
        else:
            patience_counter += 1

        print(
            f"Epoch {epoch + 1}/{max_epochs} - Loss: {loss.item():.4f}, "
            f"Val Loss: {val_loss.item():.4f}"
        )

        if patience_counter >= patience:
            print("Early stopping triggered.")
            break

    # Load the best model before returning
    model.load_state_dict(best_model_state)
    return model
