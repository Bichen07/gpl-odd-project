#!/usr/bin/env python3
"""Create a non-mutating inventory of a Payload CMS instance.

The default audit intentionally reads only collection metadata: total document
count, pagination metadata, and the field names of one sample document.  It does
not create/update/delete records, download uploaded binary files, or query Users.

Use ``PAYLOAD_READONLY_API_KEY`` only when an explicitly authorised, read-only
credential is required for a collection.  The key is never written to the report.
"""
from __future__ import annotations

import argparse
import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path
from typing import Any
from urllib.error import HTTPError, URLError
from urllib.parse import urlencode
from urllib.request import Request, urlopen


DEFAULT_BASE_URL = "https://gpl-odd-payloadcms.chiu41.com"
PUBLIC_COLLECTIONS = (
    "media",
    "esminiDats",
    "openDrives",
    "openScenarios",
    "documents",
    "observations",
    "trials",
    "batches",
    "samplings",
    "scenarios",
    "sessions",
    "keyPerformanceIndicators",
    "egos",
)


def fetch_json(url: str, api_key: str | None) -> tuple[int, dict[str, Any]]:
    headers = {"Accept": "application/json"}
    if api_key:
        headers["Authorization"] = "users API-Key {}".format(api_key)
    request = Request(url, headers=headers, method="GET")
    try:
        with urlopen(request, timeout=60) as response:  # nosec B310: user-selected CMS endpoint
            return response.status, json.loads(response.read().decode("utf-8"))
    except HTTPError as exc:
        raw = exc.read().decode("utf-8", errors="replace")
        return exc.code, {"error": raw[:500]}
    except URLError as exc:
        return 0, {"error": str(exc.reason)}


def collection_inventory(base_url: str, collection: str, api_key: str | None) -> dict[str, Any]:
    query = urlencode({"limit": 1, "depth": 0})
    url = "{}/api/{}?{}".format(base_url.rstrip("/"), collection, query)
    status, body = fetch_json(url, api_key)
    docs = body.get("docs") if isinstance(body, dict) else None
    sample = docs[0] if isinstance(docs, list) and docs else {}
    return {
        "collection": collection,
        "request": url,
        "http_status": status,
        "total_docs": body.get("totalDocs") if isinstance(body, dict) else None,
        "total_pages": body.get("totalPages") if isinstance(body, dict) else None,
        "sample_id": sample.get("id") if isinstance(sample, dict) else None,
        "sample_field_names": sorted(sample.keys()) if isinstance(sample, dict) else [],
        "error": body.get("error") if isinstance(body, dict) else "invalid JSON response",
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--base-url", default=DEFAULT_BASE_URL)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument(
        "--include-users",
        action="store_true",
        help="Include Users metadata only; requires PAYLOAD_READONLY_API_KEY.",
    )
    args = parser.parse_args()
    api_key = os.environ.get("PAYLOAD_READONLY_API_KEY")
    if args.include_users and not api_key:
        parser.error("--include-users requires PAYLOAD_READONLY_API_KEY; do not use an admin password")

    collections = list(PUBLIC_COLLECTIONS)
    if args.include_users:
        collections.append("users")

    report = {
        "schema_version": "payload-readonly-inventory/v1",
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "base_url": args.base_url.rstrip("/"),
        "mode": "metadata_only",
        "guarantees": [
            "GET requests only",
            "No create, update, delete, login, or binary-file download",
            "No document values or credentials are written into this report",
        ],
        "collections": [collection_inventory(args.base_url, name, api_key) for name in collections],
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    failed = [item for item in report["collections"] if item["http_status"] != 200]
    print("wrote {} ({} collections; {} non-200)".format(args.output, len(collections), len(failed)))
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
