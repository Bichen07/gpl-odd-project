from typing import Optional

from common import ConfigData, RegisterData, SuggestData
from handler import SurrogateHandler
from litestar import Controller, get, post
from litestar.exceptions import HTTPException


class SurrogateController(Controller):
    path = "/"
    handler: dict[str, SurrogateHandler] = {}

    @post("/initialize")
    async def initialize(self, data: ConfigData) -> dict[str, str]:
        if data.batch_id not in self.handler:
            self.handler[data.batch_id] = SurrogateHandler(data)
        return {"message": "ok"}

    @post("/register")
    async def register(self, data: RegisterData) -> dict[str, str | None]:
        if data.batch_id not in self.handler:
            raise HTTPException(
                f"Batch: {data.batch_id}. Should initialize first!", status_code=400
            )
        trial_id = self.handler[data.batch_id].register(data)
        return {"trial_id": trial_id}

    @get("/suggest/{batch_id:str}")
    async def suggest(self, batch_id: str) -> SuggestData:
        if batch_id not in self.handler:
            raise HTTPException(
                f"Batch: {batch_id}. Should initialize first!", status_code=400
            )
        return self.handler[batch_id].suggest()
