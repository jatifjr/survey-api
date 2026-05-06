#!/usr/bin/env bash
#
# Pull and restart the API service using Docker Compose from the repo root.
# Run from the machine that hosts the stack (e.g. staging VM). Requires Docker Compose v2.
#
# Prerequisites:
#   - Repository (or deployment checkout) at ROOT_DIR with compose.yml
#   - For GHCR images: docker logged in (gh auth token | docker login ghcr.io -u USER --password-stdin)
#   - Env vars for Postgres (see .env.example); API_IMAGE must point at registry image when not building locally
#
# Environment:
#   API_IMAGE   Full image reference (e.g. ghcr.io/org/repo:latest or ghcr.io/org/repo:abc1234)
#   ROOT_DIR    Repo root (default: parent of this script's directory)
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="${ROOT_DIR:-$(cd "${SCRIPT_DIR}/.." && pwd)}"

cd "${ROOT_DIR}"

if [[ -z "${API_IMAGE:-}" ]]; then
  echo "WARNING: API_IMAGE is unset; compose will use default build/local image from compose.yml." >&2
fi

echo "Deploy from ${ROOT_DIR}"
echo "API_IMAGE=${API_IMAGE:-<compose default>}"

docker compose pull api
docker compose up -d --no-deps api

echo "Running verify (override BASE_URL if proxy listens elsewhere)..."
BASE_URL="${BASE_URL:-http://localhost:8000}" "${SCRIPT_DIR}/verify.sh"
