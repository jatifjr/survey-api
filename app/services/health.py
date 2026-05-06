from app.db.session import ping_database
from app.schemas.health import (
    CheckStatus,
    LivenessChecks,
    LivenessResponse,
    ReadinessChecks,
    ReadinessResponse,
    Status,
)


def liveness_service(service_name: str) -> LivenessResponse:
    return LivenessResponse(
        status=Status.ok,
        service=service_name,
        checks=LivenessChecks(app=CheckStatus.up),
    )


async def readiness_service(service_name: str) -> tuple[ReadinessResponse, int]:
    db_is_up = await ping_database()

    status = Status.ok if db_is_up else Status.error
    status_code = 200 if db_is_up else 503

    payload = ReadinessResponse(
        status=status,
        service=service_name,
        checks=ReadinessChecks(
            app=CheckStatus.up,
            database=CheckStatus.up if db_is_up else CheckStatus.down,
        ),
    )

    return payload, status_code
