from litestar.exceptions import HTTPException
from litestar import Controller, post, get


class SimulationController(Controller):
    path = "/"

    @post("/run")
    async def run(self, data: ConfigData) -> str:
        return "TBI"
