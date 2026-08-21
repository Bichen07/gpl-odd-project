"""S3 — Parameter rules: shallow CART on scenario parameters (auditable, not "the ODD").

Reads ``odd_all_trials.json`` (written by S2 — ``odd_export.py`` or the
Dashboard "Export ODD boundary" button) and fits a depth<=3 decision tree
classifying ``fail = not passed`` from scenario parameters, per
implementation_plan.md §6.2 / §9 (S3). Writes ``odd_parameter_rules.json``.

Deliberately shallow + a plain CART (not a tuned/boosted model): per the plan's
XAI paper support (Atakishiyev et al.), the goal is an *auditable* predicate
engineers can read, not maximum predictive accuracy. This is a fail-region
hypothesis generator, not an ODD definition — see "Limitations" in the written
rules doc and implementation_plan.md §6.4.
"""

from __future__ import annotations

import json
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import numpy as np
from sklearn.model_selection import StratifiedKFold, cross_val_score
from sklearn.tree import DecisionTreeClassifier

ALL_TRIALS_FILENAME = "odd_all_trials.json"
EXPORT_FILENAME = "odd_boundary_export.json"
RULES_FILENAME = "odd_parameter_rules.json"


@dataclass
class TrainingSet:
    X: np.ndarray
    y: np.ndarray
    trial_ids: List[str]
    feature_names: List[str]
    n_dropped_unknown_kpi: int


def load_training_set(run_dir: Path) -> TrainingSet:
    p = run_dir / ALL_TRIALS_FILENAME
    if not p.is_file():
        raise FileNotFoundError(
            f"Missing {p} — run S2 first (odd_export.export_run_dir or the Dashboard "
            "'Export ODD boundary' button)."
        )
    doc = json.loads(p.read_text(encoding="utf-8"))
    trials = doc.get("trials") or []
    if not trials:
        raise RuntimeError(f"{p} has no trials.")

    feature_names = sorted({name for t in trials for name in (t.get("parameters") or {}).keys()})

    trial_ids: List[str] = []
    rows: List[List[float]] = []
    labels: List[int] = []
    n_dropped = 0
    for t in trials:
        passed = t.get("passed")
        if passed is None:
            n_dropped += 1
            continue
        params = t.get("parameters") or {}
        if any(name not in params for name in feature_names):
            n_dropped += 1
            continue
        trial_ids.append(str(t.get("trial_id")))
        rows.append([float(params[name]) for name in feature_names])
        labels.append(0 if passed else 1)  # y = 1 means FAIL (collision)

    if not trial_ids:
        raise RuntimeError(f"No trials in {p} have a known pass/fail KPI outcome.")

    return TrainingSet(
        X=np.asarray(rows, dtype=np.float64),
        y=np.asarray(labels, dtype=np.int64),
        trial_ids=trial_ids,
        feature_names=feature_names,
        n_dropped_unknown_kpi=n_dropped,
    )


def _load_boundary_trial_ids(run_dir: Path) -> Optional[set]:
    p = run_dir / EXPORT_FILENAME
    if not p.is_file():
        return None
    doc = json.loads(p.read_text(encoding="utf-8"))
    ids = {t["trial_id"] for t in (doc.get("collision_boundary") or {}).get("boundary_trials", [])}
    return ids


def _extract_rules(
    clf: DecisionTreeClassifier,
    feature_names: List[str],
    X: np.ndarray,
    y: np.ndarray,
    trial_ids: List[str],
    boundary_trial_ids: Optional[set],
) -> List[Dict[str, Any]]:
    """Walk every root->leaf path and describe it as a human-readable AND-predicate."""
    tree = clf.tree_
    leaf_ids = clf.apply(X)  # which leaf each training sample lands in

    def path_to_leaf(leaf_node: int) -> List[Tuple[int, str, float]]:
        """Find the root->leaf_node path as (feature_idx, '<=' | '>', threshold) steps."""
        path: List[Tuple[int, str, float]] = []

        def walk(node: int) -> bool:
            if node == leaf_node:
                return True
            left, right = tree.children_left[node], tree.children_right[node]
            if left != -1 and walk(left):
                path.append((tree.feature[node], "<=", tree.threshold[node]))
                return True
            if right != -1 and walk(right):
                path.append((tree.feature[node], ">", tree.threshold[node]))
                return True
            return False

        walk(0)
        return list(reversed(path))

    rules: List[Dict[str, Any]] = []
    for leaf_node in sorted(set(int(x) for x in leaf_ids)):
        mask = leaf_ids == leaf_node
        n_support = int(mask.sum())
        n_fail = int(y[mask].sum())
        predicted = "collision" if n_fail * 2 > n_support else "safe"
        precision = (n_fail / n_support) if predicted == "collision" else (n_support - n_fail) / n_support

        steps = path_to_leaf(leaf_node)
        if not steps:
            predicate = "(root — single-leaf tree, no split found)"
        else:
            predicate = " AND ".join(
                f"{feature_names[fidx]} {op} {thresh:.4g}" for fidx, op, thresh in steps
            )

        hit_trial_ids = [trial_ids[i] for i in np.flatnonzero(mask)]
        boundary_hits = (
            len(boundary_trial_ids.intersection(hit_trial_ids)) if boundary_trial_ids is not None else None
        )

        rules.append(
            {
                "id": f"R{len(rules) + 1}",
                "leaf_node": leaf_node,
                "predicate": predicate,
                "predicted": predicted,
                "support": n_support,
                "fail_count": n_fail,
                "precision": round(precision, 4),
                "boundary_trial_hits": boundary_hits,
            }
        )

    rules.sort(key=lambda r: (-r["support"] if r["predicted"] == "collision" else 0, -r["support"]))
    return rules


def train_rules(
    run_dir: Path,
    *,
    max_depth: int = 3,
    min_samples_leaf: int = 10,
    cv_folds: int = 5,
    random_state: int = 0,
) -> Dict[str, Any]:
    ts = load_training_set(run_dir)
    boundary_ids = _load_boundary_trial_ids(run_dir)

    clf = DecisionTreeClassifier(
        max_depth=max_depth,
        min_samples_leaf=min_samples_leaf,
        criterion="gini",
        random_state=random_state,
    )
    clf.fit(ts.X, ts.y)
    train_acc = float(clf.score(ts.X, ts.y))

    cv_acc: Optional[float] = None
    n_classes = len(set(ts.y.tolist()))
    if n_classes > 1 and len(ts.y) >= cv_folds * 2:
        try:
            cv = StratifiedKFold(n_splits=cv_folds, shuffle=True, random_state=random_state)
            scores = cross_val_score(
                DecisionTreeClassifier(max_depth=max_depth, min_samples_leaf=min_samples_leaf, random_state=random_state),
                ts.X,
                ts.y,
                cv=cv,
            )
            cv_acc = float(scores.mean())
        except ValueError:
            cv_acc = None

    rules = _extract_rules(clf, ts.feature_names, ts.X, ts.y, ts.trial_ids, boundary_ids)

    doc = {
        "generated_at": _now_iso(),
        "model": "cart",
        "max_depth": max_depth,
        "min_samples_leaf": min_samples_leaf,
        "features": ts.feature_names,
        "n_trials_used": len(ts.trial_ids),
        "n_trials_dropped_unknown_kpi": ts.n_dropped_unknown_kpi,
        "class_balance": {"fail": int(ts.y.sum()), "pass": int(len(ts.y) - ts.y.sum())},
        "rules": rules,
        "metrics": {"train_acc": round(train_acc, 4), "cv_acc": round(cv_acc, 4) if cv_acc is not None else None,
                    "cv_folds": cv_folds if cv_acc is not None else None},
        "limitations": [
            "Auditable hypothesis about the sampled trials only, not a certified ODD boundary.",
            "max_depth<=3 trades accuracy for readability by design (XAI interpretable-by-design choice).",
            "Trained on ALL trials incl. non-clustered ones; boundary_trial_hits references the S2 kNN "
            "collision-boundary export (min-max L2), not the parameter-space-pair z-score distance.",
            "Class balance / sampling density directly reflects the scenario sampler, not real-world exposure.",
        ],
    }

    out_path = run_dir / RULES_FILENAME
    out_path.write_text(json.dumps(doc, indent=2), encoding="utf-8")
    return {
        "rules_path": str(out_path),
        "n_rules": len(rules),
        "n_collision_rules": sum(1 for r in rules if r["predicted"] == "collision"),
        "train_acc": doc["metrics"]["train_acc"],
        "cv_acc": doc["metrics"]["cv_acc"],
        "n_trials_used": doc["n_trials_used"],
    }


def _now_iso() -> str:
    from datetime import datetime, timezone

    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")
