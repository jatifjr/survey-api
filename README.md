# SDKPT Survey API

Survey API for SDKPT system

## Environment

Configuration is read from a `.env` file in the project root when present. Copy `.env.example` to `.env` and change values as needed.

## Run

Set PostgreSQL environment variables (needed when you want DB readiness to turn green):

```bash
export POSTGRES_HOST="localhost"
export POSTGRES_PORT="5432"
export POSTGRES_USER="postgres"
export POSTGRES_PASSWORD="postgres"
export POSTGRES_DB="postgres"
```

When running with Docker Compose, keep `POSTGRES_HOST=db` (default from `.env.example`).
Use `POSTGRES_HOST=localhost` only when running the API directly on your host machine.

Optional configuration:

- `SERVICE_NAME` (default: `survey-api`)
- `ENVIRONMENT` (default: `production`)
- `DB_POOL_SIZE` (default: `5`)
- `DB_MAX_OVERFLOW` (default: `10`)
- `DB_POOL_TIMEOUT` (default: `30`)
- `DB_POOL_RECYCLE` (default: `1800`)

When `ENVIRONMENT=production`, API docs are disabled (`/docs`, `/redoc`, `/openapi.json`).

Start the API:

```bash
fastapi dev
```

Start in production mode:

```bash
fastapi run
```

## Health Probes

- `GET /v1/livez`: liveness check (`200`)
- `GET /v1/readyz`: readiness check with PostgreSQL ping (`200` if DB reachable, `503` otherwise)
  - If PostgreSQL env vars are not fully set, app still starts and readiness reports DB as down (`503`).

Both endpoints return a standardized JSON payload:

```json
{
  "status": "ok",
  "service": "survey-api",
  "probe": "readiness",
  "checks": {
    "app": "up",
    "database": "up"
  },
  "timestamp": "2026-04-14T00:00:00+00:00"
}
```

## Docker Runtime (Reliability Focus)

Build and run the stack (API + Postgres + Nginx reverse proxy):

```bash
docker compose up --build
```

Access the service through the proxy on:

- `http://localhost:8000/v1/livez`
- `http://localhost:8000/v1/readyz`

Run with replica mode to test continuity under single-container failure:

```bash
docker compose up --build --scale api=2
```

In replica mode, stopping one API container should still keep the proxy endpoint reachable.

## CI Quality Gate

The `Quality` workflow runs format, lint, and tests in GitHub Actions on every PR and on pushes to `devel` and `main`.
For the intended workflow, configure repository branch protection to require the `Quality / Format, lint, test` check before merge.

## Production Deployment (Manual)

The default root `compose.yml` is used for both local and production-style manual deployment.

**End-to-end guide:** [`docs/deployment.md`](docs/deployment.md) (GHCR auth, env vars, [`ops/deploy.sh`](ops/deploy.sh), [`ops/verify.sh`](ops/verify.sh), [`ops/rollback.sh`](ops/rollback.sh)).

After merges to `main`, the **Build** workflow publishes the API image to GitHub Container Registry:

- `ghcr.io/<owner>/<repo>:latest` — convenience tag
- `ghcr.io/<owner>/<repo>:<short-sha>` — **immutable** tag for reproducible rollback (7-character SHA)
- `ghcr.io/<owner>/<repo>:main-<short-sha>` — same commit with branch prefix

The workflow builds on an ARM runner and uses repository-derived image names (lowercase). Private repositories require Docker login on the VM to pull images.

Production required env injection values:

- `POSTGRES_HOST` (typically `db` in compose network)
- `POSTGRES_PORT`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `POSTGRES_DB`

Optional production image override:

- `API_IMAGE` (defaults to `survey-api:local` when not set; for GHCR use e.g. `ghcr.io/<owner>/<repo>:latest` or a pinned SHA tag)

This production setup is intended for a college project demo: production-usable, but not enterprise-grade (for example, no automated secret rotation and no advanced compliance controls).

## Rolling Update (Minimal Downtime)

Use replica overlap during updates:

```bash
docker compose pull api
docker compose up -d --scale api=2 --no-deps api
curl -fsS http://localhost:8000/v1/livez
curl -fsS http://localhost:8000/v1/readyz
docker compose up -d --no-deps api
docker compose up -d --scale api=1 --no-deps api
```

Rollback (pinned SHA recommended):

```bash
./ops/rollback.sh ghcr.io/<owner>/<repo>:<previous-short-sha>
```

Or equivalently:

```bash
API_IMAGE=ghcr.io/<owner>/<repo>:<previous-short-sha> docker compose pull api
API_IMAGE=ghcr.io/<owner>/<repo>:<previous-short-sha> docker compose up -d --no-deps api
```

## Optional VM Provisioning (Infra)

The `infra/` directory is an optional Terraform module for provisioning a VM when needed.

- It is **not** part of the main app delivery path.
- GitHub Actions runs infra checks in [`.github/workflows/infra.yml`](.github/workflows/infra.yml) (`fmt`, `validate`, `tflint`) when `infra/**` changes are detected.
- No `terraform apply` is executed in CI.

## Optional SSH deploy from GitHub Actions

If repository secrets are configured (`DEPLOY_SSH_HOST`, `DEPLOY_SSH_USER`, `DEPLOY_SSH_KEY`, optional `DEPLOY_REMOTE_PATH`), you can trigger a remote deploy via [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml) (**workflow_dispatch**). See [`docs/deployment.md`](docs/deployment.md).

## Tests

```bash
uv run pytest
```

## Pre-Production Checks

```bash
uv run ruff format .
uv run ruff check .
uv run pytest
```
