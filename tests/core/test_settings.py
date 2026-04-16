from app.core.config import Settings


def test_builds_database_url_from_postgres_components() -> None:
    settings = Settings.model_validate(
        {
            "POSTGRES_HOST": "db",
            "POSTGRES_PORT": "5432",
            "POSTGRES_USER": "postgres",
            "POSTGRES_PASSWORD": "postgres",
            "POSTGRES_DB": "postgres",
        }
    )
    assert settings.database_url == "postgresql+asyncpg://postgres:postgres@db:5432/postgres"
