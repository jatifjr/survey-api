from app.db.session import ping_database
from app.schemas.health import HealthResponse


def build_liveness(service_name: str) -> HealthResponse:
    return HealthResponse(
        status="ok",
        service=service_name,
        probe="liveness",
        checks={"app": "up"},
    )


async def build_readiness(service_name: str) -> tuple[HealthResponse, int]:
    db_is_up = await ping_database()
    status_code = 200 if db_is_up else 503
    status = "ok" if db_is_up else "error"

    payload = HealthResponse(
        status=status,
        service=service_name,
        probe="readiness",
        checks={"app": "up", "database": "up" if db_is_up else "down"},
    )
    return payload, status_code
