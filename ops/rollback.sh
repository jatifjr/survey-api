#!/usr/bin/env bash
#
# Roll back the API to a previously published image tag (immutable SHA recommended).
#
# Usage:
#   ./ops/rollback.sh <full-image:tag>
# Example:
#   ./ops/rollback.sh ghcr.io/myorg/survey-api:a1b2c3d
#
# Same prerequisites as deploy.sh (compose at repo root, GHCR auth if needed).
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${ROOT_DIR:-$(cd "${SCRIPT_DIR}/.." && pwd)}"

IMAGE="${1:?Usage: $0 <full-image:tag e.g. ghcr.io/org/repo:abc1234>}"

cd "${ROOT_DIR}"

export API_IMAGE="${IMAGE}"

echo "Rollback to API_IMAGE=${API_IMAGE}"

docker compose pull api
docker compose up -d --no-deps api

echo "Running verify..."
BASE_URL="${BASE_URL:-http://localhost:8000}" "${SCRIPT_DIR}/verify.sh"
