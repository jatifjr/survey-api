from datetime import datetime


def assert_health_payload_contract(payload: dict) -> None:
    assert set(payload.keys()) == {"status", "service", "probe", "checks", "timestamp"}
    assert isinstance(payload["service"], str)
    assert payload["probe"] in {"liveness", "readiness"}
    assert isinstance(payload["checks"], dict)
    datetime.fromisoformat(payload["timestamp"])


def test_liveness_returns_ok_payload(client) -> None:
    response = client.get("/v1/livez")

    assert response.status_code == 200
    assert response.headers["content-type"].startswith("application/json")

    payload = response.json()
    assert_health_payload_contract(payload)
    assert payload["status"] == "ok"
    assert payload["probe"] == "liveness"
    assert payload["checks"]["app"] == "up"


def test_liveness_does_not_depend_on_database(client, monkeypatch) -> None:
    async def db_down() -> bool:
        return False

    monkeypatch.setattr("app.services.health.ping_database", db_down)
    response = client.get("/v1/livez")

    assert response.status_code == 200
    payload = response.json()
    assert payload["status"] == "ok"
    assert payload["probe"] == "liveness"
    assert payload["checks"]["app"] == "up"


def test_readiness_returns_ok_when_database_is_up(client, monkeypatch) -> None:
    async def db_up() -> bool:
        return True

    monkeypatch.setattr("app.services.health.ping_database", db_up)
    response = client.get("/v1/readyz")

    assert response.status_code == 200
    payload = response.json()
    assert_health_payload_contract(payload)
    assert payload["status"] == "ok"
    assert payload["probe"] == "readiness"
    assert payload["checks"]["database"] == "up"


def test_readiness_returns_503_when_database_is_down(client, monkeypatch) -> None:
    async def db_down() -> bool:
        return False

    monkeypatch.setattr("app.services.health.ping_database", db_down)
    response = client.get("/v1/readyz")

    assert response.status_code == 503
    payload = response.json()
    assert_health_payload_contract(payload)
    assert payload["status"] == "error"
    assert payload["probe"] == "readiness"
    assert payload["checks"] == {"app": "up", "database": "down"}
