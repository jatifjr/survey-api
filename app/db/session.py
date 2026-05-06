from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.ext.asyncio import AsyncEngine, create_async_engine

from app.core.config import get_settings

_engine: AsyncEngine | None = None


def get_engine() -> AsyncEngine | None:
    global _engine
    if _engine is None:
        settings = get_settings()
        if not settings.is_database_configured:
            return None
        database_url = settings.database_url
        _engine = create_async_engine(
            database_url or "",
            pool_pre_ping=True,
            pool_size=settings.DB_POOL_SIZE,
            max_overflow=settings.DB_MAX_OVERFLOW,
            pool_timeout=settings.DB_POOL_TIMEOUT,
            pool_recycle=settings.DB_POOL_RECYCLE,
        )
    return _engine


async def ping_database() -> bool:
    try:
        engine = get_engine()
        if engine is None:
            return False
        async with engine.connect() as connection:
            await connection.execute(text("SELECT 1"))
        return True
    except (SQLAlchemyError, OSError, ValueError):
        return False
