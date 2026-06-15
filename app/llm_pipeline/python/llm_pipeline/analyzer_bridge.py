"""Add ``app/analyzer/src`` to ``sys.path`` for BEV/dataset modules."""

from __future__ import annotations

import sys
from pathlib import Path

from .paths import ANALYZER_SRC


def ensure_analyzer_src() -> Path:
    if str(ANALYZER_SRC) not in sys.path:
        sys.path.insert(0, str(ANALYZER_SRC))
    return ANALYZER_SRC
