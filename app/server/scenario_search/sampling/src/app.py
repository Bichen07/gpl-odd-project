from litestar import Litestar
from controller import SurrogateController

app = Litestar(route_handlers=[SurrogateController])
