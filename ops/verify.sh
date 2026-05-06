#!/usr/bin/env bash
#
# Verify deployment health via proxy (default http://localhost:8000).
# Exit 0 when probes match expectations; non-zero on failure or timeout.
#
# Environment:
#   BASE_URL           Base URL (default http://localhost:8000)
#   EXPECT_LIVEZ       Expected HTTP code for /v1/livez (default 200)
#   EXPECT_READYZ      Expected HTTP code for /v1/readyz (default 200)
#   CURL_MAX_TIME      Seconds per request (default 10)
#
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8000}"
EXPECT_LIVEZ="${EXPECT_LIVEZ:-200}"
EXPECT_READYZ="${EXPECT_READYZ:-200}"
CURL_MAX_TIME="${CURL_MAX_TIME:-10}"

livez_code="$(curl -sS -o /dev/null -w "%{http_code}" --max-time "${CURL_MAX_TIME}" "${BASE_URL}/v1/livez")"
readyz_code="$(curl -sS -o /dev/null -w "%{http_code}" --max-time "${CURL_MAX_TIME}" "${BASE_URL}/v1/readyz")"

echo "/v1/livez  HTTP ${livez_code} (expected ${EXPECT_LIVEZ})"
echo "/v1/readyz HTTP ${readyz_code} (expected ${EXPECT_READYZ})"

fail=0
if [[ "${livez_code}" != "${EXPECT_LIVEZ}" ]]; then
  echo "ERROR: liveness check failed" >&2
  fail=1
fi
if [[ "${readyz_code}" != "${EXPECT_READYZ}" ]]; then
  echo "ERROR: readiness check failed" >&2
  fail=1
fi

exit "${fail}"
