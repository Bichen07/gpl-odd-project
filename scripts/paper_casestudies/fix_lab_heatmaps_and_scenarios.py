#!/usr/bin/env python3
"""Upload missing fullHeatmap PNGs for paper cases and refresh analysis zips on lab Payload.

Also creates dedicated paper scenarios with correct ODD ranges and re-links batches 7–9.

Usage:
  python3 scripts/paper_casestudies/fix_lab_heatmaps_and_scenarios.py
"""
from __future__ import annotations

import argparse
import io
import json
import mimetypes
import os
import re
import sys
import urllib.error
import urllib.request
import zipfile
from pathlib import Path
from typing import Any, Dict, List, Optional
from urllib.parse import quote

REPO = Path(__file__).resolve().parents[2]
DATA = REPO / "data" / "paper_casestudies"

LAB = os.environ.get("LOCAL_PAYLOAD", "http://140.113.208.174:3020").rstrip("/")
LAB_KEY = os.environ.get(
    "LOCAL_PAYLOAD_API_KEY", "4a18c49f-0d97-45a9-9a1f-4088d456541e"
)
SEN = os.environ.get("SENIOR_PAYLOAD", "https://gpl-odd-payloadcms.chiu41.com").rstrip("/")
SEN_KEY = os.environ.get(
    "SENIOR_PAYLOAD_API_KEY", "fca12850-1a88-43c0-a547-e9fabf061439"
)

CASES = [
    {
        "batch_id": 7,
        "analysis_zip": DATA / "case1" / "casestudy1_twoAVs.zip",
        "lab_analysis_name": "lab_casestudy1_twoAVs.zip",
        "scenario_name": "paper_cs1_DriveOut_OncomingRight",
        "params": [
            {"name": "OncomingStartDelay", "unit": "seconds", "min": 11, "max": 14},
            {"name": "OncomingSpeed", "unit": "m/s", "min": 7, "max": 14},
        ],
    },
    {
        "batch_id": 8,
        "analysis_zip": DATA / "case3" / "casestudy3.zip",
        "lab_analysis_name": "lab_casestudy3.zip",
        "scenario_name": "paper_cs3_OvertakeCutIn",
        "params": [
            {"name": "OncomingStartDelay", "unit": "seconds", "min": 3.7, "max": 4.7},
            {"name": "OncomingSpeed", "unit": "m/s", "min": 2, "max": 4},
        ],
    },
    {
        "batch_id": 9,
        "analysis_zip": DATA / "case2" / "casestudy2.zip",
        "lab_analysis_name": "lab_casestudy2.zip",
        "scenario_name": "paper_cs2_OvertakeParkingOpposite",
        "params": [
            {"name": "OncomingStartDelay", "unit": "seconds", "min": 1, "max": 8},
            {"name": "OncomingSpeed", "unit": "m/s", "min": 7, "max": 14},
        ],
    },
]


class Client:
    def __init__(self, base: str, key: str):
        self.base = base
        self.key = key

    def req(
        self,
        method: str,
        path: str,
        *,
        data: Optional[bytes] = None,
        headers: Optional[Dict[str, str]] = None,
        timeout: int = 300,
    ) -> Any:
        h = {"Authorization": f"users API-Key {self.key}"}
        if headers:
            h.update(headers)
        request = urllib.request.Request(
            self.base + path, data=data, headers=h, method=method
        )
        try:
            with urllib.request.urlopen(request, timeout=timeout) as resp:
                raw = resp.read()
                if not raw:
                    return None
                ctype = resp.headers.get("Content-Type", "")
                if "json" in ctype or raw[:1] in (b"{", b"["):
                    return json.loads(raw.decode())
                return raw
        except urllib.error.HTTPError as exc:
            body = exc.read()[:500]
            raise RuntimeError(f"{method} {path} -> {exc.code}: {body!r}") from exc

    def get(self, path: str) -> Any:
        return self.req("GET", path)

    def post_json(self, path: str, payload: Dict[str, Any]) -> Any:
        return self.req(
            "POST",
            path,
            data=json.dumps(payload).encode(),
            headers={"Content-Type": "application/json"},
        )

    def patch_json(self, path: str, payload: Dict[str, Any]) -> Any:
        return self.req(
            "PATCH",
            path,
            data=json.dumps(payload).encode(),
            headers={"Content-Type": "application/json"},
        )

    def download_bytes(self, url: str) -> bytes:
        if url.startswith("/"):
            url = self.base + url
        # allow cross-host with this client's key when same pattern
        host_key = self.key
        if "gpl-odd-payloadcms" in url or "chiu41.com" in url:
            host_key = SEN_KEY
            client = Client(SEN, SEN_KEY)
            path = url.split(SEN, 1)[-1] if SEN in url else url
            if path.startswith("http"):
                # full url
                request = urllib.request.Request(
                    url, headers={"Authorization": f"users API-Key {SEN_KEY}"}
                )
                with urllib.request.urlopen(request, timeout=120) as resp:
                    return resp.read()
            return client.req("GET", path)  # type: ignore
        request = urllib.request.Request(
            url, headers={"Authorization": f"users API-Key {host_key}"}
        )
        with urllib.request.urlopen(request, timeout=120) as resp:
            return resp.read()

    def upload_file(self, content: bytes, filename: str) -> Dict[str, Any]:
        mime = mimetypes.guess_type(filename)[0] or "application/octet-stream"
        boundary = "----GplOddFixHeatmap"
        body = (
            f"--{boundary}\r\n"
            f'Content-Disposition: form-data; name="file"; filename="{filename}"\r\n'
            f"Content-Type: {mime}\r\n\r\n"
        ).encode() + content + f"\r\n--{boundary}--\r\n".encode()
        resp = self.req(
            "POST",
            "/api/documents",
            data=body,
            headers={"Content-Type": f"multipart/form-data; boundary={boundary}"},
            timeout=600,
        )
        doc = resp.get("doc") if isinstance(resp, dict) else None
        if not isinstance(doc, dict) or "id" not in doc:
            raise RuntimeError(f"upload failed {filename}: {str(resp)[:200]}")
        return doc


def ensure_paper_scenario(lab: Client, name: str, params: List[Dict[str, Any]]) -> int:
    docs = (lab.get("/api/scenarios?limit=50") or {}).get("docs") or []
    for d in docs:
        if d.get("name") == name:
            lab.patch_json(
                f"/api/scenarios/{d['id']}",
                {
                    "parameters": [
                        {k: p[k] for k in ("name", "unit", "min", "max") if k in p}
                        for p in params
                    ],
                    "_status": "published",
                },
            )
            return int(d["id"])
    base = lab.get("/api/scenarios/1?depth=0")
    clean_metrics = []
    for m in (base.get("testObjectives") or {}).get("criticalityMetrics") or []:
        clean_metrics.append(
            {
                "keyPerformanceIndicator": m.get("keyPerformanceIndicator"),
                "threshold": m.get("threshold"),
                "description": m.get("description"),
            }
        )
    clean_params = [
        {k: p[k] for k in ("name", "unit", "min", "max") if k in p} for p in params
    ]
    osc = base.get("openScenarioField") or {}
    payload = {
        "name": name,
        "description": f"Paper casestudy scenario ({name})",
        "parameters": clean_params,
        "testObjectives": {"criticalityMetrics": clean_metrics},
        "openDrive": base.get("openDrive"),
        "openScenarioField": {
            "type": osc.get("type") or "File",
            "content": osc.get("content") or "",
            "openScenario": osc.get("openScenario"),
        },
        "egoTargetSpeed": base.get("egoTargetSpeed"),
        "startObservationSamplingConditions": [
            {"condition": c.get("condition")}
            for c in (base.get("startObservationSamplingConditions") or [])
            if c.get("condition")
        ],
        "_status": "published",
    }
    out = lab.post_json("/api/scenarios", payload)
    return int(out["doc"]["id"])


def _heatmap_stem(filename: str) -> str:
    return re.sub(r"(-\d+)?\.png$", "", filename, flags=re.IGNORECASE)


def resolve_senior_heatmap_url(sen: Client, filename: str) -> str:
    """Exact filename first; if missing on senior, use newest same-stem PNG."""
    exact = f"/api/documents/file/{quote(filename)}"
    try:
        data = sen.req("GET", exact)
        if isinstance(data, (bytes, bytearray)) and len(data) > 1000:
            return f"{SEN}{exact}"
    except Exception:
        pass

    stem = _heatmap_stem(filename)
    q = quote(stem)
    # Payload where[filename][contains]
    try:
        listing = sen.get(
            f"/api/documents?where[filename][contains]={q}&limit=20&sort=-createdAt"
        )
    except Exception as exc:
        raise RuntimeError(f"senior lookup failed for {filename}: {exc}") from exc
    docs = (listing or {}).get("docs") or []
    candidates = [
        d
        for d in docs
        if isinstance(d, dict)
        and str(d.get("filename") or "").startswith(stem)
        and str(d.get("filename") or "").endswith(".png")
    ]
    if not candidates:
        raise RuntimeError(f"no senior heatmap for stem {stem!r} (wanted {filename})")
    # Prefer *-1.png then unsuffixed then anything
    def rank(fn: str) -> tuple:
        if fn == f"{stem}-1.png":
            return (0, fn)
        if fn == f"{stem}.png":
            return (1, fn)
        return (2, fn)

    best = sorted(candidates, key=lambda d: rank(str(d.get("filename"))))[0]
    best_fn = best["filename"]
    print(f"    fallback {filename} ← {best_fn}")
    return f"{SEN}/api/documents/file/{quote(best_fn)}"


def collect_fullheatmap_urls(analysis_zip: Path) -> List[Dict[str, str]]:
    with zipfile.ZipFile(analysis_zip) as zf:
        doc = json.loads(zf.read(zf.namelist()[0]))
    out: List[Dict[str, str]] = []
    for ego, body in doc.items():
        if not isinstance(body, dict):
            continue
        for item in body.get("fullHeatmaps") or []:
            if not isinstance(item, dict):
                continue
            fn = item.get("filename")
            if fn:
                out.append({"filename": fn, "url": ""})
    # unique by filename
    seen = set()
    uniq = []
    for x in out:
        if x["filename"] in seen:
            continue
        seen.add(x["filename"])
        uniq.append(x)
    return uniq


def rewrite_zip_urls(
    src: Path, filename_to_url: Dict[str, str], out: Path, lab_base: str
) -> int:
    replaced = 0
    with zipfile.ZipFile(src) as zin:
        names = zin.namelist()
        jn = next(n for n in names if n.endswith(".json") and "selected" not in n)
        doc = json.loads(zin.read(jn))
        for _ego, body in doc.items():
            if not isinstance(body, dict):
                continue
            for item in body.get("fullHeatmaps") or []:
                if not isinstance(item, dict):
                    continue
                fn = item.get("filename")
                if not fn:
                    continue
                if fn in filename_to_url:
                    item["url"] = filename_to_url[fn]
                    replaced += 1
                else:
                    item["url"] = f"{lab_base}/api/documents/file/{quote(fn)}"
                    replaced += 1
            for key in ("heatmapFileinfo", "trajectoriesFileinfo"):
                info = body.get(key)
                if isinstance(info, dict) and info.get("filename"):
                    info["url"] = (
                        f"{lab_base}/api/documents/file/{quote(info['filename'])}"
                    )
                    replaced += 1
        text = json.dumps(doc)
        out.parent.mkdir(parents=True, exist_ok=True)
        with zipfile.ZipFile(out, "w", compression=zipfile.ZIP_DEFLATED) as zout:
            for n in names:
                if n == jn:
                    zout.writestr(n, text.encode("utf-8"))
                else:
                    zout.writestr(n, zin.read(n))
    return replaced


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--skip-scenarios", action="store_true")
    ap.add_argument("--skip-heatmaps", action="store_true")
    args = ap.parse_args()

    lab = Client(LAB, LAB_KEY)
    sen = Client(SEN, SEN_KEY)
    print(f"Lab={LAB}")

    for case in CASES:
        print(f"\n=== batch {case['batch_id']} ===")
        if not case["analysis_zip"].is_file():
            print(f"  missing {case['analysis_zip']}")
            return 1

        if not args.skip_scenarios:
            sid = ensure_paper_scenario(lab, case["scenario_name"], case["params"])
            lab.patch_json(f"/api/batches/{case['batch_id']}", {"scenario": sid})
            print(f"  scenario id={sid} ({case['scenario_name']}) linked")

        filename_to_url: Dict[str, str] = {}
        if not args.skip_heatmaps:
            items = collect_fullheatmap_urls(case["analysis_zip"])
            print(f"  fullHeatmaps to mirror: {len(items)}")
            for item in items:
                fn = item["filename"]
                print(f"  ↓ {fn}")
                existing_url = f"{LAB}/api/documents/file/{quote(fn)}"
                try:
                    got = lab.download_bytes(existing_url)
                    # Reject stale lab copies that are far smaller than senior
                    # (batch 9 Opposite* were ~12KB / wrong height vs ~120KB).
                    if len(got) > 1000:
                        src_url = resolve_senior_heatmap_url(sen, fn)
                        try:
                            senior = lab.download_bytes(src_url)
                        except Exception:
                            senior = b""
                        if (
                            isinstance(senior, (bytes, bytearray))
                            and len(senior) > 1000
                            and len(got) < 0.5 * len(senior)
                        ):
                            print(
                                f"    stale on lab ({len(got)}B << senior {len(senior)}B), re-upload"
                            )
                        else:
                            filename_to_url[fn] = existing_url
                            print(f"    skip (already on lab, {len(got)} bytes)")
                            continue
                except Exception:
                    pass
                try:
                    src_url = resolve_senior_heatmap_url(sen, fn)
                    content = lab.download_bytes(src_url)
                except Exception as exc:
                    print(f"    ❌ download failed: {exc}")
                    return 1
                if not isinstance(content, (bytes, bytearray)) or len(content) < 1000:
                    print(f"    ❌ bad content for {fn}")
                    return 1
                # Upload under a unique prefix so Payload cannot keep serving a
                # previously corrupted file that shared the same filename.
                upload_name = f"paper_b{case['batch_id']}_{fn}"
                doc = lab.upload_file(bytes(content), upload_name)
                url = doc.get("url") or f"{LAB}/api/documents/file/{quote(upload_name)}"
                if url.startswith("/"):
                    url = LAB + url
                filename_to_url[fn] = url
                print(f"    → id={doc['id']} bytes={len(content)} as {upload_name}")

        # also keep previously uploaded media zip names mapped if present
        for media in (
            "heatmap-272.zip",
            "heatmap-273.zip",
            "heatmap-261.zip",
            "heatmap-251.zip",
            "trajectories-270.zip",
            "trajectories-271.zip",
            "trajectories-259.zip",
            "trajectories-249.zip",
        ):
            u = f"{LAB}/api/documents/file/{quote(media)}"
            try:
                lab.download_bytes(u)
                filename_to_url.setdefault(media, u)
            except Exception:
                pass

        out = DATA / "_lab_rewritten" / case["lab_analysis_name"]
        n = rewrite_zip_urls(case["analysis_zip"], filename_to_url, out, LAB)
        print(f"  rewritten refs≈{n} → {out.name}")
        adoc = lab.upload_file(out.read_bytes(), case["lab_analysis_name"])
        aid = int(adoc["id"])
        print(f"  ↑ analysis id={aid}")
        batch = lab.get(f"/api/batches/{case['batch_id']}?depth=0")
        # Replace prior lab_* analysis docs with the freshly uploaded one only.
        lab.patch_json(
            f"/api/batches/{case['batch_id']}",
            {"savedTrajectoryAnalysis": [aid]},
        )
        print(f"  ✓ batch {case['batch_id']} saves=[{aid}]")

    print("\nDone. Reload Dashboard batch 7 and re-select the saved analysis.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
