from controller import SurrogateController
from litestar import Litestar
from litestar.openapi.config import OpenAPIConfig
from litestar.openapi.plugins import SwaggerRenderPlugin

app = Litestar(
    route_handlers=[SurrogateController],
    openapi_config=OpenAPIConfig(
        title="Litestar Sampling Server",
        description="Litestar Sampling Server",
        version="0.0.1",
        render_plugins=[SwaggerRenderPlugin()],
    ),
)
