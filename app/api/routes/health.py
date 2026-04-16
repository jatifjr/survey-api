from fastapi import APIRouter
from fastapi.responses import JSONResponse

from app.core.config import get_settings
from app.schemas.health import HealthResponse
from app.services.health import build_liveness, build_readiness

router = APIRouter(tags=["Health"])


@router.get(
    "/livez",
    response_model=HealthResponse,
)
async def liveness_probe() -> HealthResponse:
    settings = get_settings()
    return build_liveness(service_name=settings.SERVICE_NAME)


@router.get(
    "/readyz",
    response_model=HealthResponse,
    responses={503: {"model": HealthResponse}},
)
async def readiness_probe() -> HealthResponse | JSONResponse:
    settings = get_settings()
    payload, status_code = await build_readiness(service_name=settings.SERVICE_NAME)
    if status_code == 503:
        return JSONResponse(status_code=503, content=payload.model_dump(mode="json"))
    return payload
