"""Deterministic geometric-visibility and profile-sensitivity artifacts.

The module intentionally distinguishes an external geometric opportunity from a
sensor detection.  It never writes ``perception.first_detected`` and never
produces a legal-fault or certification conclusion.
"""
from __future__ import annotations

import csv
import math
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, Iterable, List, Mapping, Optional

import yaml

from capability_sources import sha256_file
from perception_profiles import profile_number, profile_sha256, validate_profile


SCHEMA_VERSION = "visibility-evidence/v1"
_FULL_COVERAGE = "complete"


def _unavailable(key: str, rationale: str, unit: Optional[str] = None) -> Dict[str, Any]:
    value: Dict[str, Any] = {"key": key, "status": "unavailable", "rationale": rationale}
    if unit:
        value["unit"] = unit
    return value


def _derived(key: str, value: float, unit: str, source: str, method: str, source_sha256: Optional[str]) -> Dict[str, Any]:
    result: Dict[str, Any] = {
        "key": key,
        "value": round(float(value), 4),
        "unit": unit,
        "status": "derived",
        "source": source,
        "method": method,
    }
    if source_sha256:
        result["source_sha256"] = source_sha256
    return result


def _norm_angle_deg(angle: float) -> float:
    return (math.degrees(angle) + 180.0) % 360.0 - 180.0


def _float(row: Mapping[str, str], *keys: str) -> Optional[float]:
    for key in keys:
        raw = row.get(key)
        if raw not in (None, ""):
            try:
                return float(raw)
            except (TypeError, ValueError):
                return None
    return None


def _read_actor_rows(path: Path, actor: str) -> Dict[float, Dict[str, float]]:
    """Read one named or track-id actor from normalized trajectory CSV."""
    values: Dict[float, Dict[str, float]] = {}
    with path.open(newline="", encoding="utf-8") as source:
        for row in csv.DictReader(source):
            row_name = str(row.get("name") or "").strip()
            row_track = str(row.get("trackId") or row.get("track_id") or "").strip()
            if actor not in {row_name, row_track}:
                continue
            time_s = _float(row, "time")
            x = _float(row, "x")
            y = _float(row, "y")
            heading = _float(row, "heading", "h", "yaw")
            if None in (time_s, x, y, heading):
                continue
            values[round(float(time_s), 3)] = {
                "x": float(x),
                "y": float(y),
                "heading": float(heading),
            }
    return values


def _segment_intersects_polygon(start: tuple[float, float], end: tuple[float, float], polygon: Iterable[Iterable[float]]) -> bool:
    """Small dependency-free segment/polygon check for supplied static occluders."""
    points = [(float(p[0]), float(p[1])) for p in polygon]
    if len(points) < 3:
        return False

    def ccw(a, b, c) -> bool:
        return (c[1] - a[1]) * (b[0] - a[0]) > (b[1] - a[1]) * (c[0] - a[0])

    def intersects(a, b, c, d) -> bool:
        return ccw(a, c, d) != ccw(b, c, d) and ccw(a, b, c) != ccw(a, b, d)

    for i, p in enumerate(points):
        q = points[(i + 1) % len(points)]
        if intersects(start, end, p, q):
            return True
    return False


def build_visibility_evidence(
    *,
    trial_id: str,
    trajectory_path: str | Path,
    ego_actor: str,
    target_actor: Optional[str],
    profile: Optional[Dict[str, Any]] = None,
    geometry: Optional[Dict[str, Any]] = None,
) -> Dict[str, Any]:
    """Create a provenance-preserving visibility artifact.

    ``geometry.coverage`` must be ``complete`` before a clear-line-of-sight
    opportunity is emitted.  A FOV/range candidate is still useful to show what
    would be required, but is never promoted to actual detection.
    """
    path = Path(trajectory_path)
    evidence: Dict[str, Any] = {
        "schema_version": SCHEMA_VERSION,
        "trial_id": str(trial_id),
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "perception": {
            "first_detected": _unavailable(
                "first_detected",
                "No timestamped sensor or tracker event is present in a trajectory-only analysis.",
                "s",
            )
        },
    }
    if not path.is_file():
        evidence["fov_range_opportunity"] = _unavailable("fov_range_opportunity", "Trajectory file is unavailable.", "s")
        evidence["visibility_opportunity"] = _unavailable("visibility_opportunity", "Trajectory file is unavailable.", "s")
        return evidence
    if not target_actor:
        rationale = "No target actor was identified from a recorded event or derived collision interaction."
        evidence["fov_range_opportunity"] = _unavailable("fov_range_opportunity", rationale, "s")
        evidence["visibility_opportunity"] = _unavailable("visibility_opportunity", rationale, "s")
        return evidence
    if profile is None:
        rationale = "No versioned perception profile supplies FOV/range assumptions."
        evidence["fov_range_opportunity"] = _unavailable("fov_range_opportunity", rationale, "s")
        evidence["visibility_opportunity"] = _unavailable("visibility_opportunity", rationale, "s")
        return evidence

    validate_profile(profile)
    profile_hash = profile_sha256(profile)
    trajectory_hash = sha256_file(path)
    geo = dict(geometry or {})
    coverage = str(geo.get("coverage") or "unavailable")
    coverage_source = str(geo.get("source") or "")
    coverage_rationale = str(geo.get("rationale") or "No map/occluder coverage declaration was supplied.")
    static_occluders = list(geo.get("static_occluders") or [])

    ego = _read_actor_rows(path, ego_actor)
    target = _read_actor_rows(path, target_actor)
    common_times = sorted(set(ego).intersection(target))
    source = "{} + perception-profile:{}".format(str(path), profile.get("profile_id"))
    method = "trajectory_relative_bearing_fov_range/v1"
    candidate: Optional[Dict[str, float]] = None
    clear: Optional[Dict[str, float]] = None
    half_fov = profile_number(profile, "visibility", "horizontal_fov_deg") / 2.0
    near = profile_number(profile, "visibility", "near_range_m")
    far = profile_number(profile, "visibility", "far_range_m")

    for time_s in common_times:
        e, t = ego[time_s], target[time_s]
        dx, dy = t["x"] - e["x"], t["y"] - e["y"]
        distance = math.hypot(dx, dy)
        bearing = _norm_angle_deg(math.atan2(dy, dx) - e["heading"])
        if distance < near or distance > far or abs(bearing) > half_fov:
            continue
        frame = {"time_s": time_s, "range_m": distance, "bearing_deg": bearing}
        if candidate is None:
            candidate = frame
        if coverage == _FULL_COVERAGE and not any(
            _segment_intersects_polygon((e["x"], e["y"]), (t["x"], t["y"]), polygon)
            for polygon in static_occluders
        ):
            clear = frame
            break

    evidence["profile"] = {
        "profile_id": profile["profile_id"],
        "status": profile["status"],
        "source": profile["source"],
        "profile_sha256": profile_hash,
        "applicability": profile["applicability"],
    }
    evidence["geometry_coverage"] = {
        "status": "recorded" if coverage == _FULL_COVERAGE else "unavailable",
        "value": coverage if coverage_source else None,
        "source": coverage_source or None,
        "rationale": coverage_rationale,
    }
    if candidate is None:
        evidence["fov_range_opportunity"] = _unavailable(
            "fov_range_opportunity",
            "No common trajectory frame satisfies the stated assumed/configured FOV and range profile.",
            "s",
        )
    else:
        evidence["fov_range_opportunity"] = {
            **_derived("fov_range_opportunity", candidate["time_s"], "s", source, method, trajectory_hash),
            "range_m": round(candidate["range_m"], 4),
            "bearing_deg": round(candidate["bearing_deg"], 4),
            "profile_sha256": profile_hash,
            "limitation": "This is a derived FOV/range candidate, not a sensor detection or a clear-line-of-sight claim.",
        }
    if coverage != _FULL_COVERAGE:
        evidence["visibility_opportunity"] = _unavailable(
            "visibility_opportunity",
            "Clear-line-of-sight cannot be derived because static/dynamic occluder coverage is {}. {}".format(coverage, coverage_rationale),
            "s",
        )
    elif clear is None:
        evidence["visibility_opportunity"] = _unavailable(
            "visibility_opportunity",
            "No frame has an unoccluded line segment under the declared complete geometry coverage and profile.",
            "s",
        )
    else:
        evidence["visibility_opportunity"] = {
            **_derived("visibility_opportunity", clear["time_s"], "s", source, "ray_cast_static_occluders/v1", trajectory_hash),
            "range_m": round(clear["range_m"], 4),
            "bearing_deg": round(clear["bearing_deg"], 4),
            "profile_sha256": profile_hash,
            "limitation": "Derived geometric opportunity only; it does not prove that the ADS detected, tracked, or used the actor.",
        }
    return evidence


def evaluate_profile_response_window(
    *, visibility: Dict[str, Any], collision_time: Dict[str, Any], profile: Dict[str, Any]
) -> Dict[str, Any]:
    """Evaluate an assumed detection-to-command window without changing a verdict."""
    validate_profile(profile)
    profile_hash = profile_sha256(profile)
    opportunity = (visibility or {}).get("visibility_opportunity") or {}
    if opportunity.get("status") != "derived" or collision_time.get("status") not in {"recorded", "derived"}:
        return {
            "profile_id": profile["profile_id"],
            "profile_sha256": profile_hash,
            "status": "unavailable",
            "primary_verdict_unchanged": True,
            "rationale": "A derived clear-line-of-sight opportunity and a recorded/derived collision time are both required.",
        }
    try:
        opportunity_time = float(opportunity["value"])
        crash_time = float(collision_time["value"])
        detection = opportunity_time + profile_number(profile, "latency", "detection_delay_s")
        response_start = detection + profile_number(profile, "latency", "planning_delay_s") + profile_number(profile, "latency", "control_delay_s")
    except (KeyError, TypeError, ValueError):
        return {
            "profile_id": profile["profile_id"],
            "profile_sha256": profile_hash,
            "status": "unavailable",
            "primary_verdict_unchanged": True,
            "rationale": "Profile or collision values are invalid for a conditional response-window calculation.",
        }
    return {
        "profile_id": profile["profile_id"],
        "profile_sha256": profile_hash,
        "status": "assumed",
        "first_detection_assumed_s": round(detection, 4),
        "response_start_assumed_s": round(response_start, 4),
        "response_window_before_collision_s": round(crash_time - response_start, 4),
        "source": profile["source"],
        "rationale": "Conditional sensitivity result from a derived visibility opportunity plus an assumed/configured profile; not a historical detection or command record.",
        "primary_verdict_unchanged": True,
    }


def save_visibility_evidence(evidence: Dict[str, Any], path: str | Path) -> None:
    target = Path(path)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(yaml.safe_dump(evidence, sort_keys=False), encoding="utf-8")
