"""Utility to load roadId/laneId ground truth directly from esmini CSV cache.

This bypasses Payload's agent roadId=0 bug by reading the local CSV files
produced by esmini's dat2csv.py script.
"""

import csv
import os
import re
from pathlib import Path
from typing import Dict, Iterator, List, Optional, Tuple

import pandas as pd

from repo_paths import REPO_ROOT

CACHE_DIR = REPO_ROOT / "simulation/ros/.cache/scenario_search/records"

_KEEP_COLS = {
    "time",
    "name",
    "x",
    "y",
    "h",
    "roadId",
    "laneId",
    "s",
    "t",
    "offset",
    "speed",
    "height",
    "width",
    "length",
}

def _parse_dimensions_from_cells(cells: List[str]) -> Dict[str, str]:
    """Extract height/width/length from trailing esmini columns (layout varies by version)."""
    out: Dict[str, str] = {}
    if len(cells) < 22:
        return out
    for base in (19, 20, 21):
        if len(cells) <= base + 2:
            continue
        try:
            h = float(cells[base])
            w = float(cells[base + 1])
            ln = float(cells[base + 2])
        except ValueError:
            continue
        if 0.3 <= w <= 3.5 and 2.0 <= ln <= 12.0:
            out["height"] = str(h)
            out["width"] = str(w)
            out["length"] = str(ln)
            return out
    return out


def _csv_path(batch_id: int, trial_index: int) -> Path:
    """Return the path to the esmini CSV for a given batch and trial."""
    return CACHE_DIR / f"esmini_{batch_id}_{trial_index}.csv"


def csv_exists(batch_id: int, trial_index: int) -> bool:
    """Check if the esmini CSV exists for a given batch and trial."""
    return _csv_path(batch_id, trial_index).exists()


def get_csv_road_data(batch_id: int, trial_index: int) -> Optional[pd.DataFrame]:
    """Return a DataFrame of all agents at all sampled timestamps.

    Returns None if the file does not exist.
    Caller should del the DataFrame when done to free RAM.
    
    Columns: time, name, x, y, h, roadId, laneId, s, t, offset, speed
    - roadId, laneId are int (NaN coerced to 0)
    - Other numeric columns are float
    """
    path = _csv_path(batch_id, trial_index)
    if not path.exists():
        return None

    with path.open() as fh:
        reader = csv.reader(fh)
        next(reader)  # version / metadata line
        raw_header = next(reader)
        header = [h.strip() for h in raw_header]
        ncols = len(header)

        rows: List[Dict[str, str]] = []
        for raw_row in reader:
            cells = [v.strip() for v in raw_row]
            row = dict(zip(header, cells[:ncols]))
            if len(cells) > ncols:
                row.update(_parse_dimensions_from_cells(cells))
            rows.append({k: row[k] for k in _KEEP_COLS if k in row})

    if not rows:
        return None

    df = pd.DataFrame(rows)
    # coerce numeric columns
    for col in ("time", "x", "y", "h", "speed", "s", "t", "offset", "height", "width", "length"):
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce")
    # roadId / laneId must be int; NaN rows fall back to 0
    for col in ("roadId", "laneId"):
        if col in df.columns:
            df[col] = pd.to_numeric(df[col], errors="coerce").fillna(0).astype(int)
    return df


def list_available_csvs() -> List[Tuple[int, int]]:
    """Return a list of (batch_id, trial_index) tuples for all available CSV files.
    
    Returns sorted by batch_id, then trial_index.
    """
    pattern = re.compile(r"esmini_(\d+)_(\d+)\.csv")
    results = []
    if not CACHE_DIR.exists():
        return results
    for fname in os.listdir(CACHE_DIR):
        m = pattern.match(fname)
        if m:
            results.append((int(m.group(1)), int(m.group(2))))
    return sorted(results)


def iter_batches(
    batch_size: int = 50,
    batch_ids: Optional[List[int]] = None,
) -> Iterator[List[Tuple[int, int, pd.DataFrame]]]:
    """Iterate over available CSVs in memory-managed chunks.
    
    Args:
        batch_size: Number of trials to load at once
        batch_ids: If provided, only process trials from these batches
    
    Yields:
        List of (batch_id, trial_index, dataframe) tuples
    """
    all_csvs = list_available_csvs()
    if batch_ids is not None:
        all_csvs = [(b, t) for b, t in all_csvs if b in batch_ids]

    batch = []
    for batch_id, trial_index in all_csvs:
        df = get_csv_road_data(batch_id, trial_index)
        if df is not None:
            batch.append((batch_id, trial_index, df))
        
        if len(batch) >= batch_size:
            yield batch
            batch = []
    
    if batch:
        yield batch
