#!/usr/bin/env bash
#
# Repeatedly probe /v1/livez for success-rate style thesis metrics.
#
# Environment:
#   BASE_URL           Default http://localhost:8000
#   REQUESTS           Number of probes (default 30)
#   SLEEP_SECONDS      Delay between probes (default 1)
#   RELIABILITY_LOG    If set, append one CSV line per run (timestamped header on first write)
#   LOG_SEP            Log separator for RELIABILITY_LOG (default |)
#
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8000}"
REQUESTS="${REQUESTS:-30}"
SLEEP_SECONDS="${SLEEP_SECONDS:-1}"
LOG_SEP="${LOG_SEP:-|}"

ts_iso() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

started_at="$(ts_iso)"
echo "Running reliability probe checks against ${BASE_URL}"
echo "Started at ${started_at}"

livez_code="$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "${BASE_URL}/v1/livez")"
readyz_code="$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "${BASE_URL}/v1/readyz")"

echo "Initial /v1/livez: ${livez_code}"
echo "Initial /v1/readyz: ${readyz_code}"

success=0
failure=0

for _ in $(seq 1 "${REQUESTS}"); do
  code="$(curl -sS -o /dev/null -w "%{http_code}" --max-time 10 "${BASE_URL}/v1/livez")"
  if [[ "${code}" == "200" ]]; then
    success=$((success + 1))
  else
    failure=$((failure + 1))
  fi
  sleep "${SLEEP_SECONDS}"
done

pct=$((success * 100 / REQUESTS))

echo "Request success count: ${success}"
echo "Request failure count: ${failure}"
echo "Success rate (%): ${pct}"
finished_at="$(ts_iso)"
echo "Finished at ${finished_at}"

if [[ -n "${RELIABILITY_LOG:-}" ]]; then
  log_file="${RELIABILITY_LOG}"
  if [[ ! -f "${log_file}" ]]; then
    {
      echo "# reliability-check CSV: started_at${LOG_SEP}finished_at${LOG_SEP}base_url${LOG_SEP}requests${LOG_SEP}success${LOG_SEP}failure${LOG_SEP}success_pct${LOG_SEP}initial_livez${LOG_SEP}initial_readyz"
      echo "# Append-only log for skripsi KPI; copy rows into skripsi/reliability-evidence-template.md"
    } >> "${log_file}"
  fi
  printf '%s\n' "${started_at}${LOG_SEP}${finished_at}${LOG_SEP}${BASE_URL}${LOG_SEP}${REQUESTS}${LOG_SEP}${success}${LOG_SEP}${failure}${LOG_SEP}${pct}${LOG_SEP}${livez_code}${LOG_SEP}${readyz_code}" >> "${log_file}"
  echo "Appended summary to ${log_file}"
fi
