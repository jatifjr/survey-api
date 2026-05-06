# Deployment guide (VM + Docker Compose)

This document is the single entry point for **staging/production-style** deployment aligned with the skripsi workflow: quality gate in CI, immutable image tags in GHCR, scripted deploy/verify/rollback on the VM.

## Prerequisites

- Docker Engine and Docker Compose v2 on the VM.
- A checkout of this repository on the VM (contains root [`compose.yml`](../compose.yml), [`ops/`](../ops/), [`.env.example`](../.env.example)).
- For images from GitHub Container Registry (GHCR): authenticate Docker on the VM (private repos need a PAT or `GITHUB_TOKEN` with `read:packages`).

```bash
echo "$GITHUB_TOKEN_OR_PAT" | docker login ghcr.io -u YOUR_USER --password-stdin
```

- Environment variables for PostgreSQL (copy [`.env.example`](../.env.example) to `.env` and adjust). Never commit `.env`.

## Image tags from CI

After each push to `main`, the **Build** workflow pushes:

| Tag | Purpose |
|-----|---------|
| `:latest` | Convenience pointer to newest build |
| `:XXXXXXXX` | Short Git SHA (7 chars), **immutable** — use for rollback |
| `:main-XXXXXXXX` | Same SHA with branch prefix |

Find the SHA in the GitHub Actions run log or commit page. Roll back by deploying the previous `:XXXXXXXX` tag.

## First-time stack on the VM

From the repo root on the VM:

```bash
cp .env.example .env
# edit .env — set secrets and POSTGRES_* for compose network

export API_IMAGE="ghcr.io/<owner>/<repo>:latest"
./ops/deploy.sh
```

`deploy.sh` runs `docker compose pull api`, `docker compose up -d --no-deps api`, then [`ops/verify.sh`](../ops/verify.sh). On first install you may need a full stack bring-up once:

```bash
docker compose up -d
```

so Postgres, proxy, and API all start; afterward routine updates use `deploy.sh`.

## Routine deploy (intervention workflow)

```bash
cd /path/to/survey-api
export API_IMAGE="ghcr.io/<owner>/<repo>:<short-sha-or-latest>"
./ops/deploy.sh
```

## Verify only

```bash
./ops/verify.sh
# or
BASE_URL=http://localhost:8000 ./ops/verify.sh
```

For DB outage experiments, expect readiness to fail:

```bash
EXPECT_READYZ=503 ./ops/verify.sh
```

## Rollback

```bash
./ops/rollback.sh ghcr.io/<owner>/<repo>:<previous-short-sha>
```

## Optional: GitHub Actions SSH deploy

Repository workflow [`.github/workflows/deploy.yml`](../.github/workflows/deploy.yml) can run deploy remotely via `workflow_dispatch` if you configure secrets:

| Secret | Description |
|--------|-------------|
| `DEPLOY_SSH_HOST` | VM hostname or IP |
| `DEPLOY_SSH_USER` | SSH user |
| `DEPLOY_SSH_KEY` | Private key (PEM) |
| `DEPLOY_REMOTE_PATH` | Optional; path to repo checkout on VM (defaults to `~/survey-api` on the remote if unset) |

## Thesis evidence

- Baseline manual steps: [`skripsi/baseline-manual-operations.md`](../skripsi/baseline-manual-operations.md)
- KPI table template: [`skripsi/reliability-evidence-template.md`](../skripsi/reliability-evidence-template.md)
- Scenario commands: [`ops/reliability-runbook.md`](../ops/reliability-runbook.md)
- Optional probe CSV + notes: [`ops/experiment-log.template.md`](../ops/experiment-log.template.md), `RELIABILITY_LOG=... ./ops/reliability-check.sh`

## Infra (optional)

Terraform for OCI VM provisioning lives under [`infra/`](../infra/). CI validates Terraform with [`.github/workflows/infra.yml`](../.github/workflows/infra.yml). It is **not** required for the main deployment path.
