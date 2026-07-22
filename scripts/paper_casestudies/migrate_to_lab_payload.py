#!/usr/bin/env python3
"""Import paper case studies into the lab Payload (offline from senior).

Target: http://140.113.208.174:3020 (= localhost:3020 on this machine)

Steps:
  1. Ensure ego ITRILatest + sessions paper_cs1/2/3 exist
  2. Create placeholder batches so next IDs are 7,8,9 (keeps paper numbering)
  3. Create batches 7/8/9 with lab scenarios
  4. Upload heatmap + trajectory zips
  5. Rewrite analysis JSON URLs to lab host, re-zip, upload
  6. Attach analysis zips to savedTrajectoryAnalysis

Usage:
  python3 scripts/paper_casestudies/migrate_to_lab_payload.py
  python3 scripts/paper_casestudies/migrate_to_lab_payload.py --dry-run
"""
from __future__ import annotations

import argparse
import io
import json
import mimetypes
import os
import sys
import urllib.error
import urllib.request
import zipfile
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple
from urllib.parse import quote, urlparse, urlunparse

REPO = Path(__file__).resolve().parents[2]
DATA = REPO / "data" / "paper_casestudies"

DEFAULT_BASE = os.environ.get("LOCAL_PAYLOAD", "http://140.113.208.174:3020")
DEFAULT_KEY = os.environ.get(
    "LOCAL_PAYLOAD_API_KEY",
    os.environ.get("NEXT_PUBLIC_PAYLOAD_API_KEY", "4a18c49f-0d97-45a9-9a1f-4088d456541e"),
)

SENIOR_HOSTS = (
    "gpl-odd-payloadcms.chiu41.com",
    "lssvip-research-payload.chiu41.com",
)

# Paper batch plan on LAB payload
# CS1 -> batch 7 (two egos), CS3 -> batch 8, CS2 -> batch 9
CASES = [
    {
        "paper": "Case Study 1",
        "batch_id": 7,
        "session_name": "paper_cs1",
        "scenario_id": 1,  # Drive out Hct Exit with Oncoming Straight from Right
        "ego_names": ["ITRI", "ITRILatest"],
        "analysis_rel": "case1/casestudy1_twoAVs.zip",
        "media_rels": [
            "case1/heatmap-272.zip",
            "case1/heatmap-273.zip",
            "case1/trajectories-270.zip",
            "case1/trajectories-271.zip",
        ],
    },
    {
        "paper": "Case Study 3",
        "batch_id": 8,
        "session_name": "paper_cs3",
        "scenario_id": 3,  # Overtake cutin
        "ego_names": ["ITRI"],
        "analysis_rel": "case3/casestudy3.zip",
        "media_rels": [
            "case3/heatmap-251.zip",
            "case3/trajectories-249.zip",
        ],
    },
    {
        "paper": "Case Study 2",
        "batch_id": 9,
        "session_name": "paper_cs2",
        "scenario_id": 2,  # Overtake Parking with Opposite Oncoming
        "ego_names": ["ITRI"],
        "analysis_rel": "case2/casestudy2.zip",
        "media_rels": [
            "case2/heatmap-261.zip",
            "case2/trajectories-259.zip",
        ],
    },
]


class PayloadClient:
    def __init__(self, base: str, api_key: str):
        self.base = base.rstrip("/")
        self.api_key = api_key

    def request(
        self,
        method: str,
        path: str,
        *,
        data: Optional[bytes] = None,
        headers: Optional[Dict[str, str]] = None,
        timeout: int = 300,
    ) -> Any:
        h = {"Authorization": f"users API-Key {self.api_key}"}
        if headers:
            h.update(headers)
        req = urllib.request.Request(
            self.base + path, data=data, headers=h, method=method
        )
        try:
            with urllib.request.urlopen(req, timeout=timeout) as resp:
                raw = resp.read()
                if not raw:
                    return None
                ctype = resp.headers.get("Content-Type", "")
                if "json" in ctype or raw[:1] in (b"{", b"["):
                    return json.loads(raw.decode())
                return raw
        except urllib.error.HTTPError as exc:
            body = exc.read()[:800]
            raise RuntimeError(f"{method} {path} -> {exc.code}: {body!r}") from exc

    def get(self, path: str) -> Any:
        return self.request("GET", path)

    def post_json(self, path: str, payload: Dict[str, Any]) -> Any:
        return self.request(
            "POST",
            path,
            data=json.dumps(payload).encode(),
            headers={"Content-Type": "application/json"},
        )

    def patch_json(self, path: str, payload: Dict[str, Any]) -> Any:
        return self.request(
            "PATCH",
            path,
            data=json.dumps(payload).encode(),
            headers={"Content-Type": "application/json"},
        )

    def upload_document(self, path: Path, filename: Optional[str] = None) -> Dict[str, Any]:
        filename = filename or path.name
        mime = mimetypes.guess_type(filename)[0] or "application/zip"
        boundary = "----GplOddMigrate7MA4YWxk"
        content = path.read_bytes()
        body = (
            f"--{boundary}\r\n"
            f'Content-Disposition: form-data; name="file"; filename="{filename}"\r\n'
            f"Content-Type: {mime}\r\n\r\n"
        ).encode() + content + f"\r\n--{boundary}--\r\n".encode()
        resp = self.request(
            "POST",
            "/api/documents",
            data=body,
            headers={"Content-Type": f"multipart/form-data; boundary={boundary}"},
            timeout=600,
        )
        doc = resp.get("doc") if isinstance(resp, dict) else None
        if not isinstance(doc, dict) or "id" not in doc:
            raise RuntimeError(f"upload failed for {filename}: {str(resp)[:300]}")
        return doc


def _find_by_name(docs: List[Dict], name: str) -> Optional[Dict]:
    for d in docs:
        if d.get("name") == name:
            return d
    return None


def ensure_ego(client: PayloadClient, name: str) -> int:
    docs = (client.get("/api/egos?limit=50") or {}).get("docs") or []
    hit = _find_by_name(docs, name)
    if hit:
        return int(hit["id"])
    out = client.post_json("/api/egos", {"name": name})
    return int(out["doc"]["id"])


def ensure_session(client: PayloadClient, name: str) -> int:
    docs = (client.get("/api/sessions?limit=50") or {}).get("docs") or []
    hit = _find_by_name(docs, name)
    if hit:
        return int(hit["id"])
    out = client.post_json("/api/sessions", {"name": name, "_status": "published"})
    return int(out["doc"]["id"])


def list_batch_ids(client: PayloadClient) -> List[int]:
    docs = (client.get("/api/batches?limit=100") or {}).get("docs") or []
    return sorted(int(d["id"]) for d in docs)


def ensure_batch_id(
    client: PayloadClient,
    target_id: int,
    *,
    scenario_id: int,
    session_id: int,
    ego_ids: List[int],
    dry_run: bool,
) -> int:
    """Create batches until *target_id* exists; configure it for the paper case."""
    ids = list_batch_ids(client)
    if target_id in ids:
        if not dry_run:
            client.patch_json(
                f"/api/batches/{target_id}",
                {
                    "scenario": scenario_id,
                    "session": session_id,
                    "egos": ego_ids,
                    "sampling": 1,
                    "requiredNumberOfTrials": 1,
                },
            )
        return target_id

    # Create fillers until next auto-id reaches target_id
    while True:
        ids = list_batch_ids(client)
        nxt = max(ids) + 1 if ids else 1
        if dry_run:
            print(f"  [dry-run] would create batch (next≈{nxt}) toward {target_id}")
            if nxt >= target_id:
                return target_id
            # simulate
            ids.append(nxt)
            continue
        payload = {
            "scenario": scenario_id,
            "session": session_id,
            "egos": ego_ids,
            "sampling": 1,
            "requiredNumberOfTrials": 1,
        }
        out = client.post_json("/api/batches", payload)
        new_id = int(out["doc"]["id"])
        print(f"  created batch id={new_id}")
        if new_id == target_id:
            return new_id
        if new_id > target_id:
            raise RuntimeError(
                f"batch id jumped to {new_id}, past target {target_id}; fix manually"
            )


def rewrite_analysis_zip(
    src_zip: Path,
    *,
    lab_base: str,
    filename_to_url: Dict[str, str],
    out_zip: Path,
) -> Tuple[int, int]:
    """Rewrite senior media URLs inside analysis JSON to lab document URLs."""
    import re

    replaced = 0
    with zipfile.ZipFile(src_zip, "r") as zin:
        names = zin.namelist()
        json_name = next(
            (n for n in names if n.endswith(".json") and "selected" not in n),
            None,
        )
        if json_name is None:
            raise FileNotFoundError(f"no analysis json in {src_zip}")
        text = zin.read(json_name).decode("utf-8")

        for fname, url in filename_to_url.items():
            pattern = rf"https?://[^\"'\\s]+/api/documents/file/{re.escape(fname)}"
            text, n = re.subn(pattern, url, text)
            replaced += n
            bare_q = f'"/api/documents/file/{fname}"'
            if bare_q in text:
                replaced += text.count(bare_q)
                text = text.replace(bare_q, f'"{url}"')

        for host in SENIOR_HOSTS:
            for scheme in ("https", "http"):
                old = f"{scheme}://{host}"
                if old in text:
                    replaced += text.count(old)
                    text = text.replace(old, lab_base.rstrip("/"))

        out_zip.parent.mkdir(parents=True, exist_ok=True)
        with zipfile.ZipFile(out_zip, "w", compression=zipfile.ZIP_DEFLATED) as zout:
            for n in names:
                if n == json_name:
                    zout.writestr(n, text.encode("utf-8"))
                else:
                    zout.writestr(n, zin.read(n))
    return replaced, len(text.encode("utf-8"))


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--base", default=DEFAULT_BASE)
    ap.add_argument("--api-key", default=DEFAULT_KEY)
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument(
        "--work-dir",
        type=Path,
        default=DATA / "_lab_rewritten",
        help="Where rewritten analysis zips are written",
    )
    args = ap.parse_args()
    if not args.api_key or args.api_key.strip() in {"…", "..."}:
        print("❌ Provide a real --api-key / LOCAL_PAYLOAD_API_KEY")
        return 1
    if not DATA.is_dir():
        print(f"❌ Missing {DATA}; run download_mirror.py first")
        return 1

    client = PayloadClient(args.base, args.api_key)
    print(f"Lab Payload: {args.base}")
    try:
        batches = list_batch_ids(client)
    except Exception as exc:
        print(f"❌ Cannot reach Payload: {exc}")
        return 1
    print(f"Existing batch ids: {batches}")

    # --- egos / sessions ---
    if args.dry_run:
        print("[dry-run] skip create ego/session/batch")
        ego_ids = {"ITRI": 1, "ITRILatest": -1}
    else:
        ego_ids = {
            "ITRI": ensure_ego(client, "ITRI"),
            "ITRILatest": ensure_ego(client, "ITRILatest"),
        }
        print(f"egos: {ego_ids}")

    for case in CASES:
        print(f"\n=== {case['paper']} → batch {case['batch_id']} ===")
        for rel in [case["analysis_rel"], *case["media_rels"]]:
            p = DATA / rel
            if not p.is_file():
                print(f"  ❌ missing {p}")
                return 1
            print(f"  OK {rel} ({p.stat().st_size} bytes)")

        if args.dry_run:
            print("  [dry-run] would upload media, rewrite analysis, create batch")
            continue

        session_id = ensure_session(client, case["session_name"])
        egos = [ego_ids[n] for n in case["ego_names"]]
        bid = ensure_batch_id(
            client,
            int(case["batch_id"]),
            scenario_id=int(case["scenario_id"]),
            session_id=session_id,
            ego_ids=egos,
            dry_run=False,
        )
        print(f"  batch ready id={bid} session={session_id} egos={egos}")

        # Upload media first
        filename_to_url: Dict[str, str] = {}
        media_doc_ids: List[int] = []
        for rel in case["media_rels"]:
            path = DATA / rel
            print(f"  ↑ media {path.name}")
            doc = client.upload_document(path)
            url = doc.get("url") or f"{args.base}/api/documents/file/{quote(path.name)}"
            # Prefer absolute lab URL
            if url.startswith("/"):
                url = args.base + url
            filename_to_url[path.name] = url
            media_doc_ids.append(int(doc["id"]))
            print(f"    → id={doc['id']} url={url}")

        # Rewrite analysis zip
        src = DATA / case["analysis_rel"]
        out_name = f"lab_{src.name}"
        out_zip = args.work_dir / out_name
        nrep, nbytes = rewrite_analysis_zip(
            src,
            lab_base=args.base.rstrip("/"),
            filename_to_url=filename_to_url,
            out_zip=out_zip,
        )
        print(f"  rewrote {nrep} URL refs → {out_zip.name} ({nbytes} bytes json)")

        print(f"  ↑ analysis {out_name}")
        adoc = client.upload_document(out_zip, filename=out_name)
        print(f"    → id={adoc['id']} url={adoc.get('url')}")

        # Attach analysis (+ keep prior saves)
        batch = client.get(f"/api/batches/{bid}?depth=0")
        existing = batch.get("savedTrajectoryAnalysis") or []
        ids: List[int] = []
        for e in existing:
            if isinstance(e, int):
                ids.append(e)
            elif isinstance(e, dict) and "id" in e:
                ids.append(int(e["id"]))
        aid = int(adoc["id"])
        if aid not in ids:
            ids.append(aid)
        # also keep media docs discoverable via images? optional — attach analysis only
        client.patch_json(
            f"/api/batches/{bid}",
            {"savedTrajectoryAnalysis": ids, "images": media_doc_ids},
        )
        print(f"  ✓ batch {bid} savedTrajectoryAnalysis={ids}")

    print("\nDone. Dashboard .env should already point at lab Payload.")
    print("Restart Dashboard if needed, then open sessions paper_cs1 / paper_cs2 / paper_cs3")
    print("or batches 7 / 8 / 9 directly.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
