from functools import lru_cache
from typing import cast
from urllib.parse import quote_plus

from pydantic import Field, field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        extra="ignore",
    )

    SERVICE_NAME: str = Field(default="FastAPI Service")
    SERVICE_VERSION: str = Field(default="0.1.0")
    ENVIRONMENT: str = Field(default="production")
    POSTGRES_HOST: str | None = None
    POSTGRES_PORT: int | None = Field(default=5432, ge=1)
    POSTGRES_USER: str | None = None
    POSTGRES_PASSWORD: str | None = None
    POSTGRES_DB: str | None = None
    DB_POOL_SIZE: int = Field(default=5, ge=1)
    DB_MAX_OVERFLOW: int = Field(default=10, ge=0)
    DB_POOL_TIMEOUT: int = Field(default=30, ge=1)
    DB_POOL_RECYCLE: int = Field(default=1800, ge=1)

    @field_validator(
        "POSTGRES_HOST", "POSTGRES_USER", "POSTGRES_PASSWORD", "POSTGRES_DB", mode="before"
    )
    @classmethod
    def normalize_optional_str(cls, value: str | None) -> str | None:
        if value is None:
            return None
        normalized = value.strip()
        return normalized if normalized else None

    @field_validator("POSTGRES_PORT", mode="before")
    @classmethod
    def normalize_port(cls, value: int | str | None) -> int:
        if value is None:
            return 5432
        if isinstance(value, str):
            normalized = value.strip()
            if not normalized:
                return 5432
            return int(normalized)
        return value

    @property
    def database_url(self) -> str | None:
        required = (
            self.POSTGRES_HOST,
            self.POSTGRES_PORT,
            self.POSTGRES_USER,
            self.POSTGRES_PASSWORD,
            self.POSTGRES_DB,
        )
        if any(value in (None, "") for value in required):
            return None
        postgres_user = cast(str, self.POSTGRES_USER)
        postgres_password = cast(str, self.POSTGRES_PASSWORD)
        username = quote_plus(postgres_user)
        password = quote_plus(postgres_password)
        return (
            f"postgresql+asyncpg://{username}:{password}"
            f"@{self.POSTGRES_HOST}:{self.POSTGRES_PORT}/{self.POSTGRES_DB}"
        )

    @property
    def is_production(self) -> bool:
        return self.ENVIRONMENT.strip().lower() == "production"

    @property
    def is_database_configured(self) -> bool:
        return self.database_url is not None


@lru_cache
def get_settings() -> Settings:
    return Settings()
