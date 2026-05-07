# Baseline: Manual Operations Reliability Log

Use this document to capture the **pre-intervention baseline** before CI/CD and Docker-based automation are applied.

## Objective

Establish reference reliability performance for the manual VM workflow, then compare against the automated workflow.

## Environment Snapshot

- Date:
- VM OS/version:
- Docker/Compose version:
- App revision (commit hash):
- Operator:

## Manual Workflow Steps (Current State)

Record the exact sequence used today.

1. Connect to VM
2. Pull code / upload files
3. Build image manually
4. Restart app services
5. Validate reverse proxy and endpoint health
6. Handle rollback if needed

Add command-level detail in the table below.

| Step | Command/Action | Start Time | End Time | Duration | Error? | Notes |
|---|---|---|---|---:|---|---|
| 1 |  |  |  |  |  |  |
| 2 |  |  |  |  |  |  |
| 3 |  |  |  |  |  |  |
| 4 |  |  |  |  |  |  |
| 5 |  |  |  |  |  |  |
| 6 |  |  |  |  |  |  |

## Baseline Reliability Measurements

### A. Normal Update

- Total operation duration:
- Time service unavailable:
- Requests failed during update:
- Recovery actions needed:

### B. DB Outage Simulation

- Trigger method:
- `/livez` result:
- `/readyz` result:
- Time to detect issue:
- Time to return to stable state:

### C. Container Crash Simulation

- Trigger method:
- Single-replica behavior:
- Time to restore service:
- Manual intervention count:

### D. Rollback Trial

- Reason for rollback:
- Rollback procedure used:
- Rollback completion time:
- Post-rollback health status:

## Baseline Summary

- Mean recovery time (manual):
- Number of manual commands:
- Number of operator interventions:
- Key reliability risks identified:

## Evidence Checklist

- [ ] Terminal command transcript
- [ ] Health endpoint outputs (`/livez`, `/readyz`)
- [ ] Timestamps for downtime/recovery
- [ ] Screenshot/log snippets (if needed)
