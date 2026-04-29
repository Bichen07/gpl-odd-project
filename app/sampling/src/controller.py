from datetime import datetime, timezone
from pathlib import Path
import sys

from common import ConfigData, RegisterData, SuggestData
from handler import SurrogateHandler
from litestar import Controller, get, post
from litestar.exceptions import HTTPException


def _load_capture():
    here = Path(__file__).resolve()
    repo_root = next((p for p in [here, *here.parents] if p.name == "gpl-odd-project"), None)
    if repo_root is None:
        return None
    llm_pkg = repo_root / "app" / "llm_pipeline" / "python"
    if str(llm_pkg) not in sys.path:
        sys.path.append(str(llm_pkg))
    try:
        from llm_pipeline.capture import PipelineCapture

        return PipelineCapture(__file__)
    except Exception:
        return None


_capture = _load_capture()


def _run_id(batch_id: str) -> str:
    now = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    return f"batch_{batch_id}_{now}"


class SurrogateController(Controller):
    path = "/"
    handler: dict[str, SurrogateHandler] = {}

    @post("/initialize")
    async def initialize(self, data: ConfigData) -> dict[str, str]:
        if data.batch_id not in self.handler:
            self.handler[data.batch_id] = SurrogateHandler(data)
        rid = _run_id(data.batch_id)
        self.handler[data.batch_id].run_id = rid
        if _capture is not None:
            _capture.record(
                "stage1_capture",
                rid,
                "sampling_initialize",
                {"batch_id": data.batch_id},
            )
        return {"message": "ok"}

    @post("/register")
    async def register(self, data: RegisterData) -> dict[str, str | None]:
        if data.batch_id not in self.handler:
            raise HTTPException(
                f"Batch: {data.batch_id}. Should initialize first!", status_code=400
            )
        trial_id = self.handler[data.batch_id].register(data)
        rid = getattr(self.handler[data.batch_id], "run_id", _run_id(data.batch_id))
        if _capture is not None:
            _capture.record(
                "stage1_capture",
                rid,
                "sampling_register",
                {"batch_id": data.batch_id, "trial_index": data.trial_index, "outcome": data.outcome},
            )
        return {"trial_id": trial_id}

    @get("/suggest/{batch_id:str}")
    async def suggest(self, batch_id: str) -> SuggestData:
        if batch_id not in self.handler:
            raise HTTPException(
                f"Batch: {batch_id}. Should initialize first!", status_code=400
            )
        suggestion = self.handler[batch_id].suggest()
        rid = getattr(self.handler[batch_id], "run_id", _run_id(batch_id))
        if _capture is not None:
            _capture.record(
                "stage1_capture",
                rid,
                "sampling_suggest",
                {"batch_id": batch_id, "suggestion": suggestion},
            )
        return suggestion
