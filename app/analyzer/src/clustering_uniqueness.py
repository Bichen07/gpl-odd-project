"""Precompute Clustering Selection uniqueness (parity with dashboard PerEgoSelection).

Dashboard source of truth:
  app/dashboard/.../ClusteringSelection/PerEgoSelection/index.tsx
  (unique-mapping useEffect; duplicatedFilterRatio default 0.005)

algorithm id: perEgoSelection-v2 (same-k only; v1 could collapse k=4 into earlier k=2/3)
"""

from __future__ import annotations

from typing import Any, Callable, Dict, List, Mapping, Optional, Sequence, Set, Tuple

UNIQUENESS_ALGORITHM = "perEgoSelection-v2"
DEFAULT_DUPLICATED_FILTER_RATIO = 0.005


def _label_to_trials(result: Any) -> Dict[str, Set[str]]:
    """Build label -> set(trialId) from a ClusteringResult-like object or dict."""
    mapping: Dict[str, Set[str]] = {}
    if result is None:
        return mapping
    data = result.get("data") if isinstance(result, Mapping) else getattr(result, "data", None)
    if not data:
        return mapping
    for trial_id, item in data.items():
        if item is None:
            continue
        if isinstance(item, Mapping):
            label = item.get("label")
        else:
            label = getattr(item, "label", None)
        if label is None:
            continue
        key = str(label)
        if key not in mapping:
            mapping[key] = set()
        mapping[key].add(str(trial_id))
    return mapping


def compute_clustering_uniqueness(
    clustering: Sequence[Any],
    trial_order_len: int,
    duplicated_filter_ratio: float = DEFAULT_DUPLICATED_FILTER_RATIO,
    rank_for_index: Optional[Callable[[Any, int], int]] = None,
) -> Tuple[List[int], Dict[str, float], Dict[str, Any]]:
    """Return (uniqueResultIndices, noiseRatioByIndex, uniquenessMeta).

    ``noiseRatioByIndex`` uses string keys so JSON round-trips match JS objects.
    ``rank_for_index(result, index)`` defaults to 0 (plain HDBSCAN). Dashboard
    may pass analysis/preprocess ranks when re-saving from the UI.
    """
    if trial_order_len <= 0:
        trial_order_len = 1

    def default_rank(_result: Any, _index: int) -> int:
        return 0

    rank_fn = rank_for_index or default_rank

    noise_ratio_by_index: Dict[str, float] = {}
    # insertion-ordered: index -> label map
    unique_mappings: Dict[int, Dict[str, Set[str]]] = {}

    for i, result in enumerate(clustering):
        if result is None:
            continue

        mapping = _label_to_trials(result)
        if "-1" in mapping:
            noise_ratio_by_index[str(i)] = len(mapping["-1"]) / trial_order_len
        else:
            noise_ratio_by_index[str(i)] = 0.0

        found_duplicated = False
        duplicate_of: Optional[int] = None
        cand_k = sum(1 for lab in mapping if lab != "-1")

        for unique_index, unique in list(unique_mappings.items()):
            # Same-k only — refined k=4 must not collapse into earlier k=2/3.
            uniq_k = sum(1 for lab in unique if lab != "-1")
            if uniq_k != cand_k:
                continue

            different_counts = 0
            visited: Set[str] = set()
            for _label, set_u in unique.items():
                min_set_difference_counts = float("inf")
                min_set_difference_label: Optional[str] = None
                for label2, set2 in mapping.items():
                    if label2 in visited:
                        continue
                    # JS Set.difference(set2) == elements in set_u not in set2
                    set_difference_counts = len(set_u - set2)
                    if set_difference_counts < min_set_difference_counts:
                        min_set_difference_counts = set_difference_counts
                        min_set_difference_label = label2
                if min_set_difference_label is not None:
                    visited.add(min_set_difference_label)
                if min_set_difference_counts == float("inf"):
                    min_set_difference_counts = 0
                different_counts += int(min_set_difference_counts)

            different_ratio = different_counts / trial_order_len
            if different_ratio < duplicated_filter_ratio:
                found_duplicated = True
                duplicate_of = unique_index
            if found_duplicated:
                break

        if found_duplicated and duplicate_of is not None:
            cur_rank = rank_fn(result, i)
            dup_result = clustering[duplicate_of]
            dup_rank = rank_fn(dup_result, duplicate_of)
            if cur_rank > dup_rank:
                del unique_mappings[duplicate_of]
                unique_mappings[i] = mapping
            continue

        if found_duplicated:
            continue

        unique_mappings[i] = mapping

    indices = list(unique_mappings.keys())
    meta = {
        "duplicatedFilterRatio": duplicated_filter_ratio,
        "algorithm": UNIQUENESS_ALGORITHM,
    }
    return indices, noise_ratio_by_index, meta


def attach_uniqueness_to_mfpca(
    mfpca: Any,
    duplicated_filter_ratio: float = DEFAULT_DUPLICATED_FILTER_RATIO,
    rank_for_index: Optional[Callable[[Any, int], int]] = None,
) -> None:
    """Mutate an Mfpca dataclass / namespace with uniqueness fields."""
    clustering = getattr(mfpca, "clustering", None) or []
    trial_order = getattr(mfpca, "trialOrder", None) or []
    indices, noise, meta = compute_clustering_uniqueness(
        clustering,
        len(trial_order),
        duplicated_filter_ratio=duplicated_filter_ratio,
        rank_for_index=rank_for_index,
    )
    mfpca.uniqueResultIndices = indices
    mfpca.noiseRatioByIndex = noise
    mfpca.uniquenessMeta = meta


def attach_uniqueness_to_mfpca_dict(
    mfpca_dict: Mapping[str, Any],
    duplicated_filter_ratio: float = DEFAULT_DUPLICATED_FILTER_RATIO,
) -> None:
    for _mode, mfpca in mfpca_dict.items():
        if mfpca is None:
            continue
        attach_uniqueness_to_mfpca(mfpca, duplicated_filter_ratio=duplicated_filter_ratio)
