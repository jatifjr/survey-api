# Reliability Evidence Template (Baseline vs Intervention)

Use this file to collect final metrics and evidence for Chapter 5.

Supporting helpers: [`ops/reliability-check.sh`](../ops/reliability-check.sh) (optional CSV append via `RELIABILITY_LOG`), [`ops/experiment-log.template.md`](../ops/experiment-log.template.md) (per-run notes).

## KPI Table

| Metric | Baseline | After Intervention | Improvement | Evidence Source |
|---|---:|---:|---:|---|
| Availability in test window (%) |  |  |  |  |
| MTTR (minutes) |  |  |  |  |
| Container crash recovery (minutes) |  |  |  |  |
| Single-replica failure success rate (%) |  |  |  |  |
| CI success rate (%) |  |  |  |  |
| Avg pipeline duration (minutes) |  |  |  |  |

## Scenario Results

### Scenario 1: Normal Deploy/Update

- Baseline result:
- Intervention result:
- Reliability impact:

### Scenario 2: DB Outage

- `/livez` behavior:
- `/readyz` behavior:
- Detection and recovery notes:

### Scenario 3: Single-Container Failure

- Single-replica mode outcome:
- Multi-replica mode outcome:
- Outage duration comparison:

### Scenario 4: Rollback Execution

- Baseline rollback duration:
- Automated rollback duration:
- Final service state:

## Interpretation Notes

- Most significant reliability improvement:
- Remaining limitations:
- Threats to validity:
