#!/usr/bin/env python3
"""Upload paper casestudy media into *your* local Payload and attach to batches 7/8/9.

Prerequisites:
  - Local Payload running (docker compose in app/payload)
  - Batches 7, 8, 9 already exist OR create them in Admin (same scenario as senior)
  - API key for a local user with upload rights

This does NOT delete batches 1–3. It only uploads documents and PATCHes
savedTrajectoryAnalysis on batches 7–9 so Dashboard can Explore offline.

Usage:
  export LOCAL_PAYLOAD=http://localhost:3020
  export LOCAL_PAYLOAD_API_KEY=<your-local-key>
  python3 scripts/paper_casestudies/import_to_local_payload.py

After import, point Dashboard at local Payload:
  NEXT_PUBLIC_PAYLOAD_API_ADDRESS=http://localhost:3020
  NEXT_PUBLIC_PAYLOAD_API_KEY=<same key>
"""
from __future__ import annotations

import argparse
import json
import mimetypes
import os
import sys
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any, Dict, List, Optional

REPO = Path(__file__).resolve().parents[2]
DATA = REPO / "data" / "paper_casestudies"

# batch_id -> list of local files under data/paper_casestudies to attach as documents
ATTACH = {
    7: [
        "case1/casestudy1_twoAVs.zip",
        "case1/heatmap-272.zip",
        "case1/heatmap-273.zip",
        "case1/trajectories-270.zip",
        "case1/trajectories-271.zip",
    ],
    9: [
        "case2/casestudy2.zip",
        "case2/heatmap-261.zip",
        "case2/trajectories-259.zip",
    ],
    8: [
        "case3/casestudy3.zip",
        "case3/heatmap-251.zip",
        "case3/trajectories-249.zip",
    ],
}

# Primary analysis zip filename per batch (attached to savedTrajectoryAnalysis)
PRIMARY = {
    7: "casestudy1_twoAVs.zip",
    9: "casestudy2.zip",
    8: "casestudy3.zip",
}


def _req(
    method: str,
    url: str,
    api_key: str,
    data: Optional[bytes] = None,
    headers: Optional[Dict[str, str]] = None,
) -> Any:
    h = {"Authorization": f"users API-Key {api_key}"}
    if headers:
        h.update(headers)
    request = urllib.request.Request(url, data=data, headers=h, method=method)
    with urllib.request.urlopen(request, timeout=120) as resp:
        body = resp.read()
        if not body:
            return None
        ctype = resp.headers.get("Content-Type", "")
        if "json" in ctype:
            return json.loads(body.decode())
        return body


def _upload_document(base: str, api_key: str, path: Path) -> Dict[str, Any]:
    """Multipart upload to /api/documents (Payload upload collection)."""
    boundary = "----GplOddBoundary7MA4YWxkTrZu0gW"
    filename = path.name
    mime = mimetypes.guess_type(filename)[0] or "application/zip"
    file_bytes = path.read_bytes()
    parts: List[bytes] = []
    parts.append(
        f"--{boundary}\r\n"
        f'Content-Disposition: form-data; name="file"; filename="{filename}"\r\n'
        f"Content-Type: {mime}\r\n\r\n".encode()
        + file_bytes
        + b"\r\n"
    )
    parts.append(f"--{boundary}--\r\n".encode())
    body = b"".join(parts)
    return _req(
        "POST",
        f"{base}/api/documents",
        api_key,
        data=body,
        headers={"Content-Type": f"multipart/form-data; boundary={boundary}"},
    )


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument(
        "--base",
        default=os.environ.get("LOCAL_PAYLOAD", "http://localhost:3020"),
    )
    ap.add_argument(
        "--api-key",
        default=os.environ.get("LOCAL_PAYLOAD_API_KEY", ""),
    )
    ap.add_argument(
        "--dry-run",
        action="store_true",
        help="Only check batches / files exist",
    )
    args = ap.parse_args()
    base = args.base.rstrip("/")
    if not args.api_key and not args.dry_run:
        print("❌ Set LOCAL_PAYLOAD_API_KEY or --api-key")
        return 1
    if not DATA.is_dir():
        print(f"❌ Missing {DATA}; run download_mirror.py first")
        return 1

    for batch_id, rels in ATTACH.items():
        print(f"\n=== batch {batch_id} ===")
        for rel in rels:
            p = DATA / rel
            print(f"  {'OK' if p.is_file() else 'MISSING'} {rel}")
            if not p.is_file():
                return 1
        if args.dry_run:
            try:
                doc = _req("GET", f"{base}/api/batches/{batch_id}", args.api_key or "x")
                print(f"  batch exists id={doc.get('id') if isinstance(doc, dict) else '?'}")
            except Exception as exc:
                print(f"  batch check: {exc}")
            continue

        # Upload all media; collect primary analysis doc id
        primary_id = None
        uploaded_ids: List[int] = []
        for rel in rels:
            path = DATA / rel
            print(f"  ↑ uploading {path.name} ...")
            try:
                resp = _upload_document(base, args.api_key, path)
            except urllib.error.HTTPError as exc:
                print(f"  ❌ upload failed: {exc.read()[:300]}")
                return 1
            doc = resp.get("doc") if isinstance(resp, dict) else resp
            if not isinstance(doc, dict) or "id" not in doc:
                print(f"  ❌ unexpected upload response: {str(resp)[:200]}")
                return 1
            uploaded_ids.append(int(doc["id"]))
            print(f"    → document id={doc['id']}")
            if path.name == PRIMARY[batch_id]:
                primary_id = int(doc["id"])

        if primary_id is None:
            print("  ❌ primary analysis zip not uploaded")
            return 1

        # Attach primary (and keep any existing saves)
        try:
            batch = _req("GET", f"{base}/api/batches/{batch_id}?depth=0", args.api_key)
        except urllib.error.HTTPError as exc:
            print(
                f"  ❌ batch {batch_id} missing on local Payload ({exc.code}). "
                "Create batches 7/8/9 in Admin (or clone from senior), then re-run."
            )
            return 1
        existing = batch.get("savedTrajectoryAnalysis") or []
        ids = []
        for e in existing:
            if isinstance(e, dict) and "id" in e:
                ids.append(int(e["id"]))
            elif isinstance(e, int):
                ids.append(e)
        if primary_id not in ids:
            ids.append(primary_id)
        patch = json.dumps({"savedTrajectoryAnalysis": ids}).encode()
        _req(
            "PATCH",
            f"{base}/api/batches/{batch_id}",
            args.api_key,
            data=patch,
            headers={"Content-Type": "application/json"},
        )
        print(f"  ✓ batch {batch_id} savedTrajectoryAnalysis → {ids}")
        print(
            f"  note: also uploaded helper media ids={uploaded_ids}; "
            "heatmap/traj URLs inside the analysis JSON still point at senior "
            "until you re-save Explore or rewrite URLs (see README)."
        )

    print("\nDone. Point Dashboard .env at this local Payload and restart.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
