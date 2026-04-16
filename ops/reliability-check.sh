#!/usr/bin/env bash

set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8000}"
REQUESTS="${REQUESTS:-30}"
SLEEP_SECONDS="${SLEEP_SECONDS:-1}"

echo "Running reliability probe checks against ${BASE_URL}"

livez_code="$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/v1/livez")"
readyz_code="$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/v1/readyz")"

echo "Initial /v1/livez: ${livez_code}"
echo "Initial /v1/readyz: ${readyz_code}"

success=0
failure=0

for _ in $(seq 1 "${REQUESTS}"); do
  code="$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/v1/livez")"
  if [[ "${code}" == "200" ]]; then
    success=$((success + 1))
  else
    failure=$((failure + 1))
  fi
  sleep "${SLEEP_SECONDS}"
done

echo "Request success count: ${success}"
echo "Request failure count: ${failure}"
echo "Success rate (%): $(( success * 100 / REQUESTS ))"
