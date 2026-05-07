# KPI and Evaluation Metrics

## Main KPI Set

1. **Service Availability**
   - Percentage of successful responses during the defined observation window.
2. **Mean Time to Restore (MTTR)**
   - Time from incident detection until the service returns to stable condition.
3. **Deployment Recovery Duration**
   - Time required to recover from a failed release using the defined rollback workflow.
4. **Deployment Consistency**
   - Stability of the deployment result across repeated executions of the same procedure.

## Supporting Metrics

- CI pass/fail result
- CI duration per run
- deployment duration
- time from image availability to running service update
- correctness of probe behavior:
  - `/livez` remains `200` when only dependency fails
  - `/readyz` returns `503` when DB is unavailable
- request success rate during optional replica failure scenario

## Metric-to-Question Mapping

| Research Question | Primary Evidence |
|---|---|
| RQ1: workflow design for more reliable deployment and recovery | documented workflow components and implementation results |
| RQ2: effect compared with manual approach | baseline vs intervention KPI comparison |
| RQ3: effectiveness in failure scenarios | scenario-based test results and MTTR/recovery evidence |

## Suggested Baseline vs After Table

| Metric | Baseline | After Intervention | Improvement | Notes |
|---|---:|---:|---:|---|
| Availability in test window (%) |  |  |  |  |
| MTTR (minutes) |  |  |  |  |
| Failed release recovery duration (minutes) |  |  |  |  |
| Average deployment duration (minutes) |  |  |  |  |
| CI success rate (%) |  |  |  |  |
| Average CI duration (minutes) |  |  |  |  |

## Minimum Acceptance Criteria

- format, lint, and test checks run automatically before release workflow proceeds
- deployment uses a standardized container image artifact from the registry
- deployment outcome is verified using `/livez` and `/readyz`
- rollback procedure is documented and executable
- during DB outage simulation:
  - `/livez` returns `200`
  - `/readyz` returns `503`
- during failed release scenario:
  - rollback restores service health within measurable bounded time

## Notes on Scope

- Optional infrastructure provisioning metrics are not part of the main KPI set.
- Replica continuity testing is supporting evidence, not the primary claim of the thesis.
