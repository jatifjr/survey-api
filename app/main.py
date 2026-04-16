import logging

from fastapi import FastAPI

from app.api.routes.health import router as health_router
from app.core.config import get_settings

logger = logging.getLogger(__name__)
API_V1_PREFIX = "/v1"


def create_app() -> FastAPI:
    settings = get_settings()
    application = FastAPI(
        title=settings.SERVICE_NAME,
        docs_url=None if settings.is_production else "/docs",
        redoc_url=None if settings.is_production else "/redoc",
        openapi_url=None if settings.is_production else "/openapi.json",
    )
    application.include_router(health_router, prefix=API_V1_PREFIX)
    if not settings.is_database_configured:
        logger.warning(
            "PostgreSQL env vars are incomplete; application started without database "
            "connectivity "
            "and /v1/readyz will report database as down."
        )
    return application


app = create_app()
