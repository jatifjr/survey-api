# FINAL TODO Scratch (Skripsi Completion)

Use this as the single checklist to finish technical evidence + writing.

## 0) Scope Lock and Admin

- Confirm final thesis title wording with supervisor.
- Confirm 8-BAB structure expected by campus template.
- Confirm claim boundaries: lightweight DevOps for reliability, not full enterprise DevOps.

## 1) Repository Hygiene Before Final Data Collection

- Ensure branch has all intended changes committed (no accidental leftovers).
- Re-run quality gate locally:
  - `make quality`
- Verify current health contract manually:
  - `make up`
  - `make verify`
- Check `app/db/session.py` handling is acceptable for advisor/reviewer (currently uses `database_url or ""` fallback; acceptable runtime, but can be cleaned for code clarity if needed).
- Ensure no secrets are committed:
  - `.env` stays ignored
  - no keys/tokens in docs/scripts

## 2) Environment and Deployment Readiness

- VM has Docker + Compose v2 installed.
- VM can pull GHCR images (docker login on VM).
- `.env` on VM is set (`POSTGRES_*`, etc.).
- Confirm immutable image tags are available from CI:
  - `:latest`
  - `:<short-sha>`
  - `:main-<short-sha>`
- Decide final deployment mode for thesis:
  - manual-assisted via scripts only, OR
  - optional GitHub Actions SSH deploy (`deploy.yml` + secrets).

## 3) Baseline Data Capture (Pre-Intervention)

- Fill environment snapshot in `skripsi/baseline-manual-operations.md`.
- Record manual workflow commands step-by-step.
- Capture timestamps for:
  - deployment start/end
  - downtime start/end (if any)
  - recovery start/end
- Run and record DB outage behavior (`/v1/livez`, `/v1/readyz`).
- Run and record rollback trial behavior.
- Complete all checklist items in `skripsi/baseline-manual-operations.md`.

## 4) Intervention Run (Standardized Workflow)

- Run `make quality` and save CI/local evidence.
- Deploy a pinned image:
  - `make deploy IMAGE=ghcr.io/<owner>/<repo>:<short-sha>`
- Verify service:
  - `make verify`
- Run DB outage scenario and verify expected readiness failure:
  - stop db
  - `make verify-db-down`
  - start db
  - `make verify`
- Run rollback scenario with previous immutable tag:
  - `make rollback IMAGE=ghcr.io/<owner>/<repo>:<previous-short-sha>`
  - `make verify`
- Run reliability probe measurement:
  - `RELIABILITY_LOG=./ops/experiment-probes.csv REQUESTS=120 ./ops/reliability-check.sh`
- Write run notes into `ops/experiment-log.template.md` (copy as working log if needed).

## 5) KPI Calculation and Evidence Consolidation

- Fill `skripsi/reliability-evidence-template.md` with real baseline vs intervention values.
- Use calculator:
  - `python skripsi/kpi-calculator-scratch.py`
- Transfer calculator outputs into BAB VII KPI table:
  - mapping notes in `skripsi/BAB-VII-kpi-example-scratch.md`
- Ensure each KPI row has an evidence source (log, CI run, command output, screenshot if needed).

## 6) BAB Draft Completion Order (Practical)

- BAB I final cleanup in `skripsi/draft/01-pendahuluan.md`.
- BAB II references and related work in `skripsi/draft/02-tinjauan-pustaka.md`.
- BAB III formulas and method detail in `skripsi/draft/03-metodologi-penelitian.md`.
- BAB IV with real baseline data in `skripsi/draft/04-analisis-kondisi-awal.md`.
- BAB V align design with final implemented workflow in `skripsi/draft/05-perancangan-workflow-devops.md`.
- BAB VI include concrete repo evidence in `skripsi/draft/06-implementasi.md`.
- BAB VII final results and analysis in `skripsi/draft/07-pengujian-dan-evaluasi.md`.
- BAB VIII strict conclusions linked to RQ in `skripsi/draft/08-kesimpulan-dan-saran.md`.

## 7) Final Consistency Check (Before Submission)

- No claim in thesis exceeds implementation reality.
- If process is manual-assisted, wording does not claim full automation.
- All scenario outcomes in BAB VII match runbook/evidence.
- Metrics and formulas are consistent across BAB III and BAB VII.
- README/ops docs and thesis text do not conflict.
- Optional Terraform discussion stays as supporting scope only.

## 8) Optional Nice-to-Have (Only if Time Remains)

- Add a short appendix with command transcript excerpts.
- Add one comparison chart (baseline vs intervention KPI) for presentation.
- Add a one-page demo run script for sidang rehearsal.

---

## Minimal “Done” Definition

You are practically done when all items below are true:

- Baseline evidence is complete.
- Intervention deployment + rollback proven with timestamps.
- KPI table is filled with real numbers + evidence sources.
- BAB I-VIII drafts are complete and internally consistent.
- Supervisor-reviewed version has no major scope mismatch.