from datetime import UTC, datetime
from enum import Enum
from typing import Literal

from pydantic import BaseModel, Field


class Status(Enum):
    ok = "ok"
    error = "error"


class CheckStatus(Enum):
    up = "up"
    down = "down"


class LivenessChecks(BaseModel):
    app: CheckStatus


class ReadinessChecks(BaseModel):
    app: CheckStatus
    database: CheckStatus


def utc_timestamp_iso() -> str:
    return datetime.now(UTC).isoformat()


class LivenessResponse(BaseModel):
    status: Status
    service: str
    probe: Literal["liveness"] = "liveness"
    checks: LivenessChecks
    timestamp: str = Field(default_factory=utc_timestamp_iso)


class ReadinessResponse(BaseModel):
    status: Status
    service: str
    probe: Literal["readiness"] = "readiness"
    checks: ReadinessChecks
    timestamp: str = Field(default_factory=utc_timestamp_iso)
