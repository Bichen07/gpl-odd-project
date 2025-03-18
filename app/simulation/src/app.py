from litestar import Litestar
from controller import SimulationController

app = Litestar(route_handlers=[SimulationController])
