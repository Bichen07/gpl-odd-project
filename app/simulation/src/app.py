"""
Mission Control Litestar application.

Start with:
    conda activate simulation
    cd app/simulation/src
    litestar run --port 8282 --host 0.0.0.0
"""
from __future__ import annotations

import logging
import os

from litestar import Litestar
from litestar.config.cors import CORSConfig

from controller import SimulationController

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
)

_DASHBOARD_ORIGIN = os.getenv("DASHBOARD_URL", "http://localhost:3000")

cors_config = CORSConfig(
    allow_origins=[
        _DASHBOARD_ORIGIN,
        "http://localhost:3000",
        "http://localhost:3001",
        "https://gpl-odd-dashboard.chiu41.com",
    ],
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["Content-Type", "Authorization"],
)

app = Litestar(
    route_handlers=[SimulationController],
    cors_config=cors_config,
)
