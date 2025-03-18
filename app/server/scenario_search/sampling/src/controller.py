from datetime import datetime
from typing import Optional, Any
from litestar.exceptions import HTTPException
from litestar import Controller, post, get
import uuid

from handler import SurrogateHandler
from common import ConfigData, NewConfigFileData, RegisterData, SuggestData


class SurrogateController(Controller):
    path = "/"
    handler: Optional[SurrogateHandler] = None
    uuid = uuid.uuid4()
    created_time = datetime.now()

    @post("/initialize")
    async def initialize(self, data: ConfigData) -> dict[str, str]:
        if self.handler is None:
            self.handler = SurrogateHandler(data)
        return {"message": "ok"}

    @post("/register")
    async def register(self, data: RegisterData) -> dict[str, str | None]:
        if self.handler is None:
            raise HTTPException("Should initialize first!", status_code=400)
        trial_id = self.handler.register(data)
        return {"trial_id": trial_id}

    @get("/suggest")
    async def suggest(self) -> SuggestData:
        if self.handler is None:
            raise HTTPException("Should initialize first!", status_code=400)
        return self.handler.suggest()

    @get("/created_time")
    async def get_created_time(self) -> dict[str, str]:
        return {"data": str(self.created_time.strftime("%m%d_%H%M%S"))}
