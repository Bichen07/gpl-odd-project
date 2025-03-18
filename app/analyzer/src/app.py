from litestar import Litestar
from litestar.openapi.config import OpenAPIConfig
from litestar.openapi.plugins import SwaggerRenderPlugin

# from controller.clustering import ClusteringController, compute_superpoints
from controller.trajectory_analysis import TrajectoryAnalysisController
from controller.state_analysis import StateAnalysisController
from litestar.config.cors import CORSConfig

cors_config = CORSConfig(allow_origins=["*"])

app = Litestar(
    cors_config=cors_config,
    route_handlers=[TrajectoryAnalysisController, StateAnalysisController],
    openapi_config=OpenAPIConfig(
        title="Litestar Analyzer Server",
        description="Litestar Analyzer Server",
        version="0.0.1",
        render_plugins=[SwaggerRenderPlugin()],
    ),
)
