import os
from pathlib import Path
from dotenv import load_dotenv

current_folder_path = Path(os.path.abspath(__file__)).parent
dotenv_path = str(current_folder_path / "../.env")
load_dotenv(dotenv_path)
print(dotenv_path)

PAYLOAD_API_KEY = str(os.getenv("PAYLOAD_API_KEY", ""))


def _normalize_payload_api(url: str) -> str:
    """Base Payload URL without trailing /api (controller appends /api/... paths)."""
    base = (url or "http://localhost:3020").rstrip("/")
    if base.endswith("/api"):
        base = base[: -len("/api")]
    return base


PAYLOAD_API = _normalize_payload_api(str(os.getenv("PAYLOAD_API", "http://localhost:3020")))
PAYLOAD_GRAPHQL_API = PAYLOAD_API + "/api/graphql"

if not PAYLOAD_API_KEY or PAYLOAD_API_KEY == "None":
    print(
        "WARNING: PAYLOAD_API_KEY is not set in app/analyzer/.env — "
        "analysis will fail when uploading heatmaps to Payload (HTTP 403). "
        "Copy PAYLOAD_API_KEY from app/dashboard/.env."
    )

print(PAYLOAD_API)
print(PAYLOAD_GRAPHQL_API)
