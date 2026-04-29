from __future__ import annotations

import json
import os
import time
from pathlib import Path
from typing import Any

import requests

from .paths import artifacts_root


def _load_prompt(stage3_dir: Path) -> dict[str, Any]:
    return json.loads((stage3_dir / "prompt_input.json").read_text(encoding="utf-8"))


def run_llm(source_file: str | Path, run_id: str) -> Path:
    source = Path(source_file).resolve()
    artifacts = artifacts_root(source)
    stage3_dir = artifacts / "stage3_prompt" / run_id
    stage4_dir = artifacts / "stage4_llm" / run_id
    stage4_dir.mkdir(parents=True, exist_ok=True)

    prompt_obj = _load_prompt(stage3_dir)

    provider = os.getenv("LLM_PROVIDER", "openai_compatible")
    model = os.getenv("LLM_MODEL", "gpt-4o-mini")
    endpoint = os.getenv("LLM_ENDPOINT", "https://api.openai.com/v1/chat/completions")
    api_key = os.getenv("LLM_API_KEY", "")

    request_payload = {
        "model": model,
        "messages": [
            {"role": "system", "content": prompt_obj["system_prompt"]},
            {"role": "user", "content": prompt_obj["prompt"]},
        ],
        "temperature": 0.2,
    }

    start = time.time()
    if api_key:
        resp = requests.post(
            endpoint,
            headers={
                "Authorization": f"Bearer {api_key}",
                "Content-Type": "application/json",
            },
            json=request_payload,
            timeout=120,
        )
        resp.raise_for_status()
        body = resp.json()
        result_text = body["choices"][0]["message"]["content"]
        usage = body.get("usage", {})
    else:
        body = {"message": "LLM_API_KEY not set. Generated stub response."}
        result_text = (
            "Stub result: configure LLM_API_KEY, LLM_MODEL and LLM_ENDPOINT "
            "to run live inference."
        )
        usage = {}
    latency_ms = round((time.time() - start) * 1000, 2)

    (stage4_dir / "request.json").write_text(
        json.dumps(
            {
                "run_id": run_id,
                "stage": "stage4_llm",
                "provider": provider,
                "model": model,
                "request": request_payload,
            },
            indent=2,
        ),
        encoding="utf-8",
    )
    (stage4_dir / "response.json").write_text(json.dumps(body, indent=2), encoding="utf-8")
    (stage4_dir / "result.md").write_text(result_text + "\n", encoding="utf-8")
    (stage4_dir / "latency_cost.json").write_text(
        json.dumps(
            {
                "run_id": run_id,
                "stage": "stage4_llm",
                "provider": provider,
                "model": model,
                "latency_ms": latency_ms,
                "usage": usage,
                "result": result_text,
            },
            indent=2,
        ),
        encoding="utf-8",
    )
    return stage4_dir / "result.md"
