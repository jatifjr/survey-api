# Implementation Roadmap

## Priority Roadmap From Now

This roadmap is organized by **practical next work**, not by tool count.
The goal is to finish a thesis-worthy DevOps workflow with measurable evidence.

## Phase 1 - Lock Thesis Direction

- [x] Lock title and research direction
- [x] Narrow scope to deployment reliability and recovery consistency
- [ ] Confirm final title wording with academic supervisor
- [ ] Confirm BAB structure required by campus template

## Phase 2 - Capture Baseline

- [ ] Document the current manual deployment/update workflow step by step
- [ ] Record how image update or service restart is currently done on VM
- [ ] Measure manual deployment duration
- [ ] Measure downtime during manual update if any
- [ ] Record manual rollback or recovery steps
- [ ] Fill `baseline-manual-operations.md` with real evidence

## Phase 3 - Finish DevOps Intervention

### CI and Artifact Flow

- [x] Add automated format, lint, and test checks
- [x] Add image build/publish workflow
- [ ] Verify the exact branch/release policy to be used in evaluation
- [ ] Define the final release path for the thesis demo

### Deployment Workflow

- [ ] Finalize the VM deployment procedure using the published image
- [ ] Standardize environment variable injection on the VM
- [ ] Standardize post-deployment health verification
- [ ] Standardize rollback using previous stable image tag
- [ ] Ensure the full deployment flow can be repeated consistently

### Reliability Controls

- [x] Provide `/livez` and `/readyz`
- [x] Separate app liveness from DB readiness
- [ ] Rehearse DB outage handling procedure
- [ ] Rehearse failed-release detection and rollback
- [ ] Decide whether replica continuity test will be included as supporting evidence

## Phase 4 - Run Evaluation

- [ ] Run baseline measurements
- [ ] Run intervention measurements
- [ ] Run Scenario A: normal deployment
- [ ] Run Scenario B: DB outage
- [ ] Run Scenario C: quality regression blocked before rollout
- [ ] Run Scenario D: failed release and rollback
- [ ] Run optional Scenario E: single-container failure in replica mode
- [ ] Fill `reliability-evidence-template.md` with real numbers

## Phase 5 - Write Thesis Chapters

- [ ] Write BAB I using background, problem statement, objectives, and scope
- [ ] Write BAB II with DevOps, CI/CD, containerization, service reliability, and health probes
- [ ] Write BAB III with methodology, variables, scenarios, and KPI definitions
- [ ] Write BAB IV with current-state analysis and baseline workflow
- [ ] Write BAB V with workflow design and deployment architecture
- [ ] Write BAB VI with implementation details and operational procedure
- [ ] Write BAB VII with test results and evaluation
- [ ] Write BAB VIII with conclusions, limitations, and suggestions

## High-Value Deliverables

- [ ] baseline evidence collected
- [ ] release workflow proven end-to-end
- [ ] rollback proven with timestamps
- [ ] KPI comparison table completed
- [ ] chapter outline approved by supervisor

## Do Not Over-Invest In

- advanced Terraform/HCP workflow as main contribution
- Kubernetes migration
- multi-region or production-scale cloud architecture
- broad DevSecOps/compliance claims
