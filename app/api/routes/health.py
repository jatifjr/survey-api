from fastapi import APIRouter, Response, status

from app.core.config import get_settings
from app.schemas.health import LivenessResponse, ReadinessResponse
from app.services.health import liveness_service, readiness_service

router = APIRouter(tags=["Health"])


@router.get("/livez", response_model=LivenessResponse)
async def liveness_probe() -> LivenessResponse:
    settings = get_settings()
    return liveness_service(service_name=settings.SERVICE_NAME)


@router.get(
    "/readyz",
    response_model=ReadinessResponse,
    responses={503: {"model": ReadinessResponse}},
)
async def readiness_probe(response: Response) -> ReadinessResponse:
    settings = get_settings()
    payload, status_code = await readiness_service(service_name=settings.SERVICE_NAME)

    if status_code == status.HTTP_503_SERVICE_UNAVAILABLE:
        response.status_code = status_code

    return payload
