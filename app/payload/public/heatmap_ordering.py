import sys

from sklearn.manifold import TSNE
import json
import numpy as np
from scipy.cluster.hierarchy import linkage, optimal_leaf_ordering, leaves_list


def get_optimal_order(embeddings_dict):
    """Expects {trialId: [vector]} and returns [ordered_trialIds]"""
    trial_ids = list(embeddings_dict.keys())

    # If only one or zero trials, no ordering needed
    if len(trial_ids) <= 1:
        return trial_ids

    # Convert list of lists to numpy array
    vectors = np.array([embeddings_dict[tid] for tid in trial_ids])

    # Ensure vectors are 1D (if user sent [[1,2]], flatten to [1,2])
    # if vectors.ndim == 3:
    #     vectors = vectors.reshape(vectors.shape[0], -1)

    # # Hierarchical clustering + Optimal Leaf Ordering
    Z = linkage(vectors, method="ward", optimal_ordering=True)
    ordered_indices = leaves_list(Z)

    # # Use UMAP to embed into 1D
    # reducer = umap.UMAP(n_components=1, random_state=42, n_neighbors=500)
    # embedding_1d = reducer.fit_transform(vectors).flatten()

    # n_samples = vectors.shape[0]
    # # 1. Use a 5% to 8% multiplier instead of 15%
    # # 2. Cap it at 50 or 100 (standard sklearn t-SNE struggles above this)
    # # 3. Ensure it's at least 5 for small clusters
    # # optimal_perplexity = np.clip(n_samples * 0.01, 5, 50)
    # # optimal_perplexity = np.clip(n_samples * 0.07, 5, 100)
    # # optimal_perplexity = np.clip(n_samples * 0.07, 5, 100)
    # # optimal_perplexity = min(n_samples - 1, 15)
    # optimal_perplexity = min(n_samples - 1, 15)
    # if n_samples < 15:
    #     optimal_perplexity = min(n_samples - 1, 3)
    # # optimal_perplexity = min(50, n_samples - 1)
    # # reducer = umap.UMAP(n_components=1, random_state=42, n_neighbors=optimal_perplexity)
    # # embedding_1d = reducer.fit_transform(vectors).flatten()
    # tsne_1d = TSNE(
    #     n_components=1,
    #     perplexity=optimal_perplexity,
    #     init="pca",  # Must keep this to prevent 'flipping' the heatmap
    #     learning_rate="auto",
    # )
    # embedding_1d = tsne_1d.fit_transform(vectors).flatten()

    # n_samples = vectors.shape[0]
    # calc_perplexity = max(1, min(n_samples - 1, int(n_samples * 0.2)))
    # # t-SNE 1D embedding
    # tsne_1d = TSNE(
    #     n_components=1,
    #     perplexity=calc_perplexity,
    #     random_state=42,
    #     init="pca",
    #     learning_rate="auto",
    # )
    # embedding_1d = tsne_1d.fit_transform(vectors).flatten()

    # Get indices that would sort the embedding
    # ordered_indices = np.argsort(embedding_1d)

    return [trial_ids[i] for i in ordered_indices]


if __name__ == "__main__":
    try:
        input_data = sys.stdin.read()
        if not input_data:
            sys.exit(0)

        # input_data is { clusterLabel: { trialId: vector } }
        clusters = json.loads(input_data)
        output = {}

        for label, trials in clusters.items():
            # Process each cluster independently
            output[label] = get_optimal_order(trials)

        print(json.dumps(output))
    except Exception as e:
        sys.stderr.write(f"Python Error: {str(e)}")
        sys.exit(1)
