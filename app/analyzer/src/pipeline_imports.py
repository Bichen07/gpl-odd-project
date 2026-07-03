"""Ensure the ``llm_pipeline`` package is importable from analyzer scripts."""

from __future__ import annotations

import sys

from repo_paths import REPO_ROOT

_LLM_PKG = REPO_ROOT / "app" / "llm_pipeline" / "python"


def ensure_llm_pipeline() -> None:
    if str(_LLM_PKG) not in sys.path:
        sys.path.insert(0, str(_LLM_PKG))
