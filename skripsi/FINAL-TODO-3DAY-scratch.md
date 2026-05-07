# FINAL TODO 3-DAY Scratch (Emergency Plan)

Use this only if timeline is tight. Focus on evidence and defensible results first.

## Day 1 - Evidence First (Critical)

### Scope and lock
- [ ] Confirm title + scope quickly with supervisor.
- [ ] Lock claim boundary: lightweight DevOps reliability improvement (no overclaim).

### Baseline capture
- [ ] Run manual-style baseline flow.
- [ ] Fill key sections in `skripsi/baseline-manual-operations.md`.
- [ ] Record deployment start/end time.
- [ ] Record downtime (if any).
- [ ] Record DB outage behavior (`/v1/livez`, `/v1/readyz`).

### Intervention proof
- [ ] Run `make quality`.
- [ ] Deploy pinned image: `make deploy IMAGE=ghcr.io/<owner>/<repo>:<short-sha>`.
- [ ] Verify: `make verify`.
- [ ] Rollback once: `make rollback IMAGE=ghcr.io/<owner>/<repo>:<previous-short-sha>`.
- [ ] Verify after rollback: `make verify`.
- [ ] Save timestamps and command outputs.

**Day 1 done when:** baseline + intervention + rollback evidence exist.

---

## Day 2 - KPI + BAB VII

### Measurement run
- [ ] Run reliability probe with log:
  - `RELIABILITY_LOG=./ops/experiment-probes.csv REQUESTS=120 ./ops/reliability-check.sh`

### KPI computation
- [ ] Edit inputs in `skripsi/kpi-calculator-scratch.py`.
- [ ] Run: `python skripsi/kpi-calculator-scratch.py`.
- [ ] Move results into KPI table.

### Evidence docs
- [ ] Fill `skripsi/reliability-evidence-template.md`.
- [ ] Fill `skripsi/draft/07-pengujian-dan-evaluasi.md`.
- [ ] Use mapping guide in `skripsi/BAB-VII-kpi-example-scratch.md`.

**Day 2 done when:** BAB VII has real numbers + evidence sources.

---

## Day 3 - Complete Remaining BABs + Consistency

### Writing order (priority)
- [ ] `skripsi/draft/04-analisis-kondisi-awal.md`
- [ ] `skripsi/draft/05-perancangan-workflow-devops.md`
- [ ] `skripsi/draft/06-implementasi.md`
- [ ] `skripsi/draft/01-pendahuluan.md`
- [ ] `skripsi/draft/03-metodologi-penelitian.md`
- [ ] `skripsi/draft/08-kesimpulan-dan-saran.md`
- [ ] `skripsi/draft/02-tinjauan-pustaka.md` (minimum viable then polish later)

### Final consistency checks
- [ ] BAB III formulas align with BAB VII calculations.
- [ ] No thesis claim exceeds implementation reality.
- [ ] If workflow is manual-assisted, wording does not claim full automation.
- [ ] README/docs and thesis narrative are consistent.

**Day 3 done when:** BAB I-VIII draft is complete, coherent, and defensible.

---

## If Time is Very Tight (Cut List)

- [ ] Skip optional Scenario E (replica continuity) if it blocks core completion.
- [ ] Keep Terraform discussion short and supporting only.
- [ ] Do not add new features; prioritize finishing evidence and writing.

---

## Minimum Pass Criteria

- [ ] Baseline evidence is available.
- [ ] Intervention deploy/verify/rollback is proven.
- [ ] KPI comparison table has real values.
- [ ] BAB VII is data-backed and complete.
- [ ] Conclusions answer research questions directly.
