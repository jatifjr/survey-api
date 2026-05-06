# Operations (`ops/`)

| File | Purpose |
|------|---------|
| [`deploy.sh`](deploy.sh) | Pull API image and restart service; runs verify |
| [`verify.sh`](verify.sh) | Check `/v1/livez` and `/v1/readyz` via proxy |
| [`rollback.sh`](rollback.sh) | Deploy a specific previous `ghcr.io/...:tag` |
| [`reliability-check.sh`](reliability-check.sh) | Repeated livez probes + optional CSV log (`RELIABILITY_LOG`) |
| [`reliability-runbook.md`](reliability-runbook.md) | Failure/replica/rollback scenarios for thesis evaluation |
| [`experiment-log.template.md`](experiment-log.template.md) | Per-run notes template for evidence |
| [`nginx/default.conf`](nginx/default.conf) | Reverse proxy upstream config |

**Full deployment procedure:** see [`docs/deployment.md`](../docs/deployment.md).
