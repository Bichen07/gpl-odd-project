"""Shared analysis-stage clip start from ``app/analyzer/config/clip_conditions.yaml``.

Used by Replayer (via TS port / API) and LLM preprocess so both share one rule.
Simulation upload clip is unchanged; this only rebases analysis clocks from raw
or already-clipped esmini CSV.
"""
from __future__ import annotations

import re
from functools import lru_cache
from pathlib import Path
from typing import Any, Dict, Mapping, Optional, Union

import yaml

from repo_paths import REPO_ROOT

CONFIG_PATH = REPO_ROOT / "app" / "analyzer" / "config" / "clip_conditions.yaml"

EgoRow = Mapping[str, Any]
PathLike = Union[str, Path]


def clip_config_path() -> Path:
    return CONFIG_PATH


@lru_cache(maxsize=1)
def load_clip_config(path: Optional[str] = None) -> Dict[str, Any]:
    cfg_path = Path(path) if path else CONFIG_PATH
    with open(cfg_path, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f) or {}
    if not isinstance(data, dict):
        raise ValueError(f"clip_conditions.yaml must be a mapping: {cfg_path}")
    return data


def reload_clip_config() -> Dict[str, Any]:
    load_clip_config.cache_clear()
    return load_clip_config()


def map_id_from_opendrive_meta(meta_line: str) -> Optional[str]:
    """Extract map id from esmini CSV line0, e.g. ``.../hct_6_no_930.xodr``."""
    if not meta_line:
        return None
    m = re.search(r"([^/\\]+)\.xodr", meta_line, flags=re.IGNORECASE)
    if not m:
        return None
    return m.group(1)


def map_id_for_batch(batch_id: Union[int, str], config: Optional[Mapping[str, Any]] = None) -> str:
    cfg = dict(config or load_clip_config())
    defaults = cfg.get("batch_map_defaults") or {}
    key = str(int(batch_id))
    mid = defaults.get(key) or defaults.get(int(batch_id))  # type: ignore[arg-type]
    return str(mid) if mid else "hct_6"


def active_profile(
    map_id: Optional[str] = None,
    config: Optional[Mapping[str, Any]] = None,
    batch_id: Optional[Union[int, str]] = None,
) -> Dict[str, Any]:
    cfg = dict(config or load_clip_config())
    name = str(cfg.get("active") or "current_startvalid")
    profiles = cfg.get("profiles") or {}
    if name not in profiles:
        raise KeyError(
            f"clip profile {name!r} not in profiles {list(profiles)}. "
            f"Edit active: in {CONFIG_PATH}"
        )
    prof = dict(profiles[name])
    prof["_profile_name"] = name
    overrides = (cfg.get("map_overrides") or {}).get(map_id or "", {}) or {}
    if isinstance(overrides, dict):
        prof.update(overrides)
    if batch_id is not None:
        bkey = str(int(batch_id))
        batch_block = (cfg.get("batch_overrides") or {}).get(bkey) or {}
        if isinstance(batch_block, dict):
            # Prefer profile-named sub-block; else treat as flat field overlay.
            if name in batch_block and isinstance(batch_block[name], dict):
                prof.update(batch_block[name])
            elif "type" in batch_block or "x" in batch_block or "road_id" in batch_block:
                prof.update(batch_block)
        prof["_batch_id"] = int(batch_id)
    if map_id:
        prof["_map_id"] = map_id
    return prof


def _col(df_or_rows: Any, *names: str) -> Optional[str]:
    if hasattr(df_or_rows, "columns"):
        cols = {str(c).strip().lower(): str(c) for c in df_or_rows.columns}
        for n in names:
            if n.lower() in cols:
                return cols[n.lower()]
    return None


def _ego_dataframe(df: Any):
    """Return ego rows sorted by time (pandas DataFrame) or None."""
    if df is None or getattr(df, "empty", True):
        return None
    time_col = _col(df, "time")
    if time_col is None:
        return None
    if "trackId" in df.columns or "trackid" in [str(c).lower() for c in df.columns]:
        tid = _col(df, "trackId", "trackid")
        ego = df[df[tid] == 0].sort_values(time_col) if tid else df
    elif "name" in [str(c).lower() for c in df.columns]:
        name_col = _col(df, "name")
        names = df[name_col].astype(str).str.strip().str.lower()
        ego = df[names == "ego"].sort_values(time_col)
    else:
        return None
    if getattr(ego, "empty", True):
        return None
    return ego


def resolve_clip_start_from_ego_df(
    ego: Any,
    profile: Mapping[str, Any],
) -> Optional[float]:
    """Compute clip start (absolute esmini seconds) from Ego dataframe."""
    if ego is None or getattr(ego, "empty", True):
        return None

    time_col = _col(ego, "time")
    x_col = _col(ego, "x")
    y_col = _col(ego, "y")
    if time_col is None or x_col is None or y_col is None:
        return None
    road_col = _col(ego, "road_id", "roadId", "roadid")
    s_col = _col(ego, "s")

    # Drop placeholders
    usable = ego
    if road_col is not None:
        rid = ego[road_col].astype(float)
        xx = ego[x_col].astype(float)
        yy = ego[y_col].astype(float)
        placeholder = (rid == -1) | ((xx.abs() < 1e-9) & (yy.abs() < 1e-9))
        usable = ego.loc[~placeholder]
    else:
        xx = ego[x_col].astype(float)
        yy = ego[y_col].astype(float)
        usable = ego.loc[~((xx.abs() < 1e-9) & (yy.abs() < 1e-9))]
    if getattr(usable, "empty", True):
        usable = ego

    ptype = str(profile.get("type") or "world_xy")
    hit_time: Optional[float] = None

    if ptype in ("road_s", "road_s_with_world_fallback") and road_col and s_col:
        road_id = float(profile.get("road_id", 92))
        s_tol = float(profile.get("s_tol", 3.0))
        s_target = float(profile.get("s", 0.0))
        tgt_rows = usable[
            (usable[road_col].astype(float) == road_id)
            & ((usable[s_col].astype(float) - s_target).abs() <= s_tol)
        ]
        if not tgt_rows.empty:
            tgt = tgt_rows.iloc[0]
            xy_tol = float(profile.get("xy_tol_m", 3.0))
            dx = usable[x_col].astype(float) - float(tgt[x_col])
            dy = usable[y_col].astype(float) - float(tgt[y_col])
            dist = (dx * dx + dy * dy) ** 0.5
            near = usable[dist <= xy_tol]
            if not near.empty:
                hit_time = float(near.iloc[0][time_col])

    if hit_time is None and ptype in ("world_xy", "road_s_with_world_fallback"):
        if ptype == "world_xy":
            tx = float(profile.get("x", profile.get("fallback_x", 300.0)))
            ty = float(profile.get("y", profile.get("fallback_y", 58.0)))
            tol = float(profile.get("xy_tol_m", 3.0))
        else:
            tx = float(profile.get("fallback_x", 300.0))
            ty = float(profile.get("fallback_y", 58.0))
            tol = float(profile.get("fallback_xy_tol_m", profile.get("xy_tol_m", 5.0)))
        dx = usable[x_col].astype(float) - tx
        dy = usable[y_col].astype(float) - ty
        dist = (dx * dx + dy * dy) ** 0.5
        near = usable[dist <= tol]
        if not near.empty:
            hit_time = float(near.iloc[0][time_col])
        else:
            # Closest frame if within 2x tol (soft match for already-clipped CSV)
            if len(usable) > 0:
                i = int(dist.astype(float).to_numpy().argmin())
                if float(dist.iloc[i]) <= tol * 2.0:
                    hit_time = float(usable.iloc[i][time_col])

    if hit_time is None:
        return None

    offset = float(profile.get("frame_offset_s", 0.0) or 0.0)
    return round(hit_time + offset, 3)


def resolve_clip_start_from_df(
    df: Any,
    *,
    map_id: Optional[str] = None,
    batch_id: Optional[Union[int, str]] = None,
    config: Optional[Mapping[str, Any]] = None,
) -> Optional[float]:
    """Resolve clip start from a trajectory / esmini dataframe."""
    cfg = config or load_clip_config()
    mid = map_id
    if mid is None and batch_id is not None:
        mid = map_id_for_batch(batch_id, cfg)
    profile = active_profile(mid, cfg, batch_id=batch_id)
    ego = _ego_dataframe(df)
    return resolve_clip_start_from_ego_df(ego, profile)


def _read_esmini_csv_as_df(csv_path: Path):
    """Load esmini CSV via csv.reader (rows have more cols than the header)."""
    import csv as _csv

    import pandas as pd

    rows = []
    meta = ""
    with open(csv_path, "r", encoding="utf-8", errors="ignore") as f:
        reader = _csv.reader(f)
        meta_row = next(reader, None)
        meta = ",".join(meta_row) if meta_row else ""
        header = next(reader, None)
        if not header:
            return None, meta
        # Strip spaces from header names: " name" -> "name"
        names = [h.strip() for h in header]
        # Need at least time,name,x,y,roadId,s
        for cells in reader:
            if len(cells) < 15:
                continue
            rec = {
                "time": cells[0].strip(),
                "id": cells[1].strip() if len(cells) > 1 else "",
                "name": cells[2].strip(),
                "x": cells[3].strip(),
                "y": cells[4].strip(),
                "h": cells[6].strip() if len(cells) > 6 else "0",
                "roadId": cells[9].strip() if len(cells) > 9 else "",
                "laneId": cells[10].strip() if len(cells) > 10 else "",
                "s": cells[13].strip() if len(cells) > 13 else "",
                "speed": cells[14].strip() if len(cells) > 14 else "",
            }
            rows.append(rec)
    if not rows:
        return None, meta
    df = pd.DataFrame(rows)
    for col in ("time", "x", "y", "h", "roadId", "laneId", "s", "speed"):
        df[col] = pd.to_numeric(df[col], errors="coerce")
    return df, meta


def resolve_clip_start_from_csv(
    csv_path: PathLike,
    *,
    map_id: Optional[str] = None,
    batch_id: Optional[Union[int, str]] = None,
    config: Optional[Mapping[str, Any]] = None,
) -> Optional[float]:
    """Resolve clip start from an esmini CSV path."""
    path = Path(csv_path)
    if not path.is_file():
        return None
    df, meta = _read_esmini_csv_as_df(path)
    if df is None:
        return None
    mid = map_id or map_id_from_opendrive_meta(meta)
    if mid is None and batch_id is not None:
        mid = map_id_for_batch(batch_id, config)
    return resolve_clip_start_from_df(df, map_id=mid, batch_id=batch_id, config=config)


def clip_meta_dict(
    clip_start_s: float,
    *,
    map_id: Optional[str] = None,
    profile: Optional[Mapping[str, Any]] = None,
) -> Dict[str, Any]:
    prof = dict(profile or active_profile(map_id))
    return {
        "clip_start_esmini_s": round(float(clip_start_s), 3),
        "time_origin": "analysis_clip_conditions",
        "source": "clip_conditions.yaml",
        "profile": prof.get("_profile_name"),
        "map_id": map_id or prof.get("_map_id"),
        "rule": {
            k: v
            for k, v in prof.items()
            if not str(k).startswith("_")
        },
        "note": (
            "t'=esmini_t - clip_start. Shared by Replayer analysis-clip mode "
            "and LLM timelines. Not the simulation upload filter."
        ),
    }
