import logging
import traceback

from typing import Any, Dict

from litestar import Litestar, Request, Response, get
from litestar.openapi.config import OpenAPIConfig
from litestar.openapi.plugins import SwaggerRenderPlugin
from controller import TrajectoryAnalysisController
from litestar.config.cors import CORSConfig
from litestar.status_codes import HTTP_500_INTERNAL_SERVER_ERROR
from analysis_progress import snapshot as analysis_progress_snapshot

logger = logging.getLogger(__name__)

cors_config = CORSConfig(allow_origins=["*"])


@get("/analysis_progress")
async def analysis_progress_handler() -> Dict[str, Any]:
    """Polled by Dashboard during POST /trajectory_analysis (long-running)."""
    return analysis_progress_snapshot()


def log_unhandled_exception(request: Request, exc: Exception) -> Response:
    from analysis_progress import fail as fail_analysis_progress

    fail_analysis_progress(str(exc))
    logger.error(
        "Unhandled exception on %s %s\n%s",
        request.method,
        request.url.path,
        traceback.format_exc(),
    )
    return Response(
        content={"status_code": 500, "detail": str(exc)},
        status_code=HTTP_500_INTERNAL_SERVER_ERROR,
        media_type="application/json",
    )


app = Litestar(
    cors_config=cors_config,
    route_handlers=[TrajectoryAnalysisController, analysis_progress_handler],
    exception_handlers={Exception: log_unhandled_exception},
    openapi_config=OpenAPIConfig(
        title="Litestar Analyzer Server",
        description="Litestar Analyzer Server",
        version="0.0.1",
        render_plugins=[SwaggerRenderPlugin()],
    ),
)
