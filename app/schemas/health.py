from datetime import UTC, datetime
from typing import Literal

from pydantic import BaseModel, Field

ProbeStatus = Literal["ok", "error"]
CheckState = Literal["up", "down"]
ProbeType = Literal["liveness", "readiness"]


class HealthResponse(BaseModel):
    status: ProbeStatus
    service: str
    probe: ProbeType
    checks: dict[str, CheckState]
    timestamp: datetime = Field(default_factory=lambda: datetime.now(UTC))
