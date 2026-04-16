# Reliability Runbook

This runbook is used for evaluation scenarios in the skripsi.

## Prerequisites

- Stack running via `docker compose up --build` (or `--scale api=2` for replica test)
- `curl` available from host machine
- Start time recording enabled (manual or script)
- For production-style use with root `compose.yml`, provide injected variables before deployment:
  - `POSTGRES_HOST` (typically `db`)
  - `POSTGRES_PORT`
  - `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
  - optional `API_IMAGE` override

## Scenario 1: DB Outage

1. Stop database:
  - `docker compose stop db`
2. Verify health behavior:
  - `curl -i http://localhost:8000/v1/livez` should return `200`
  - `curl -i http://localhost:8000/v1/readyz` should return `503`
3. Start database:
  - `docker compose start db`
4. Record:
  - detection time
  - recovery time until `/v1/readyz` returns `200`

## Scenario 2: Single-Container Crash (Replica Mode)

1. Run stack in replica mode:
  - `docker compose up --build --scale api=2 -d`
2. Find one API container and stop it:
  - `docker compose ps`
  - `docker stop <api_container_id>`
3. Send repeated requests through proxy:
  - `for i in $(seq 1 30); do curl -s -o /dev/null -w "%{http_code}\n" http://localhost:8000/v1/livez; sleep 1; done`
4. Record:
  - success-rate percentage
  - outage duration if any non-200 responses appear

## Scenario 3: Rollback

1. Deploy a new image tag.
2. If failure is observed, redeploy previous stable image tag:
  - set `API_IMAGE=<previous_tag>`
  - `docker compose pull`
  - `docker compose up -d`
3. Verify:
  - `/v1/livez` returns `200`
  - `/v1/readyz` matches DB state
4. Record MTTR from failure detection to restored healthy status.

## Scenario 4: Rolling Update (Production, Minimal Downtime)

1. Pull new image:
  - `docker compose pull api`
2. Temporarily increase replicas:
  - `docker compose up -d --scale api=2 --no-deps api`
3. Verify proxy health:
  - `curl -fsS http://localhost:8000/v1/livez`
  - `curl -fsS http://localhost:8000/v1/readyz`
4. Replace remaining old instance(s):
  - `docker compose up -d --no-deps api`
5. Normalize to baseline replica count:
  - `docker compose up -d --scale api=1 --no-deps api`
6. Final checks:
  - `docker compose ps`
  - `/v1/livez` and `/v1/readyz` responses