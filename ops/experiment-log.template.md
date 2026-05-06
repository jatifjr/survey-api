# Experiment log (skripsi evidence)

Use this file on the deployment host or workstation during thesis evaluation runs. Copy summarized numbers into [`skripsi/reliability-evidence-template.md`](../skripsi/reliability-evidence-template.md).

## How to record

1. Note scenario name (e.g. baseline manual deploy, intervention deploy, DB outage).
2. Record start/end timestamps (UTC or local, but be consistent).
3. Paste command output or attach CI/deployment log references (no secrets).

## Template per run

| Field | Value |
|-------|-------|
| Scenario | |
| Start time | |
| End time | |
| Operator / environment | |
| Image tag (if applicable) | |
| Notes | |

### Metrics

| Metric | Value |
|--------|-------|
| Deployment duration | |
| Downtime observed | |
| MTTR (if recovery scenario) | |
| `/v1/livez` behavior | |
| `/v1/readyz` behavior | |

### Automated probe log

Optional: append machine-readable rows with [`ops/reliability-check.sh`](reliability-check.sh):

```bash
RELIABILITY_LOG=./ops/experiment-probes.csv ./ops/reliability-check.sh
```

Keep `experiment-probes.csv` out of git if it contains sensitive paths; add to `.gitignore` if needed.
