from litestar import Litestar
from litestar.openapi.config import OpenAPIConfig
from litestar.openapi.plugins import SwaggerRenderPlugin
from controller import TrajectoryAnalysisController
from litestar.config.cors import CORSConfig

cors_config = CORSConfig(allow_origins=["*"])

app = Litestar(
    cors_config=cors_config,
    route_handlers=[TrajectoryAnalysisController],
    openapi_config=OpenAPIConfig(
        title="Litestar Analyzer Server",
        description="Litestar Analyzer Server",
        version="0.0.1",
        render_plugins=[SwaggerRenderPlugin()],
    ),
)
