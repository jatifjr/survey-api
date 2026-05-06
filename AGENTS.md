# AGENTS.md

## Purpose

This repository is used for an academic thesis (skripsi) focused on a **lightweight DevOps workflow** for a VM-based FastAPI service.
The primary goal is to improve and evaluate **deployment reliability** and **recovery consistency**, not to build a production-scale DevOps platform.

All changes should support:

- measurable baseline-vs-intervention evaluation,
- reproducible operational workflow,
- clear thesis documentation.

---

## Thesis Focus (Locked)

### Main Contribution

1. Standardized quality gate before release (`format`, `lint`, `test`).
2. Standardized artifact flow (build and publish container image).
3. Standardized deployment verification and rollback procedure.
4. Reliability evaluation using metrics such as availability and MTTR.

### Not the Main Contribution

- Full SDLC transformation.
- Kubernetes adoption.
- Enterprise-grade DevSecOps/compliance program.
- Infrastructure provisioning as the core research novelty.

Terraform may be used only as supporting setup.

---

## Source of Truth for Thesis Writing

- Reference notes and planning documents: `skripsi/`
- Active chapter writing workspace: `skripsi/draft/`

When updating thesis materials:

1. keep `skripsi/` as concise reference docs,
2. keep `skripsi/draft/` as per-BAB writing drafts,
3. preserve alignment between implementation and thesis claims.

---

## Current Technical Baseline

- Backend: FastAPI (Python 3.12)
- Database: PostgreSQL
- Runtime packaging: Docker
- Service runtime orchestration: Docker Compose
- CI workflows: GitHub Actions
- Deployment artifact: image published to container registry
- Health endpoints:
  - `/v1/livez` for liveness
  - `/v1/readyz` for readiness

---

## Architectural Constraints

- Keep architecture simple: single API service + PostgreSQL + reverse proxy.
- Do not replace FastAPI or PostgreSQL.
- Do not introduce major new subsystems unless clearly required by thesis scope.
- Prefer minimal and maintainable implementation over broad feature expansion.

---

## Allowed Changes

- Improve CI quality gates and build workflows.
- Improve deployment and rollback procedures for consistency and measurability.
- Improve health verification, reliability checks, and testability.
- Improve documentation tied to thesis evidence collection.
- Add scripts or automation that directly support thesis experiments.

---

## Discouraged or Out-of-Scope Changes

- Adding heavy platform components not needed for the thesis claim.
- Expanding to multi-service/multi-region architecture.
- Treating Terraform/HCP setup as the center of the project.
- Introducing monitoring stacks not currently required by thesis metrics.
- Over-engineering that does not improve reliability evaluation quality.

---

## Reliability and Evaluation Expectations

Any meaningful change should be assessed against thesis evaluation needs:

- Does this improve deployment consistency?
- Does this improve recovery consistency?
- Can this be measured in baseline-vs-intervention comparison?
- Can the result be explained clearly in BAB IV-VII?

Preferred evidence artifacts:

- CI logs and status outcomes,
- deployment/rollback timestamps,
- health endpoint results,
- scenario-based reliability records.

---

## Workflow Expectations for Contributors

1. Make incremental changes with clear operational impact.
2. Reuse existing repo patterns before introducing new ones.
3. Keep instructions reproducible from a clean environment.
4. Update relevant docs whenever behavior or workflow changes.
5. Avoid claims in documentation that are not implemented and tested.

---

## Quality and Safety Rules

- Never commit secrets, private keys, credentials, or `.env` values.
- Do not bypass failing quality checks.
- Do not weaken validation just to make CI pass.
- Keep rollback path available when changing deployment flow.
- Preserve local/CI reproducibility.

---

## Documentation Rules for Skripsi Alignment

When workflow behavior changes:

- update operational docs (`README.md`, `ops/` runbooks),
- update thesis references in `skripsi/` if scope/metrics/procedure changes,
- keep chapter drafts in `skripsi/draft/` consistent with implementation reality.

Avoid writing thesis text that claims:

- full automation if process is manual-assisted,
- enterprise-grade operations without supporting controls,
- reliability improvements without measured evidence.

---

## Guiding Principles

- Keep it practical.
- Keep it measurable.
- Keep it reproducible.
- Keep it scoped to the thesis objective.