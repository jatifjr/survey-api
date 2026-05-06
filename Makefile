SHELL := /bin/bash

.PHONY: help setup format lint test quality up down logs verify verify-db-down deploy rollback reliability

help:
	@echo "Available targets:"
	@echo "  make setup                          - Install dependencies with uv"
	@echo "  make format                         - Format code with ruff"
	@echo "  make lint                           - Lint code with ruff"
	@echo "  make test                           - Run pytest"
	@echo "  make quality                        - Run format check, lint, and test"
	@echo "  make up                             - Start compose stack in background"
	@echo "  make down                           - Stop compose stack"
	@echo "  make logs                           - Follow compose logs"
	@echo "  make verify                         - Verify /v1/livez and /v1/readyz expect 200"
	@echo "  make verify-db-down                 - Verify /v1/readyz expects 503 (DB outage scenario)"
	@echo "  make deploy IMAGE=<ghcr-ref:tag>    - Deploy with ops/deploy.sh"
	@echo "  make rollback IMAGE=<ghcr-ref:tag>  - Roll back with ops/rollback.sh"
	@echo "  make reliability [REQUESTS=30]      - Run reliability probe loop"

setup:
	uv sync --frozen --dev

format:
	uv run ruff format .

lint:
	uv run ruff check .

test:
	uv run pytest

quality:
	uv run ruff format --check .
	uv run ruff check .
	uv run pytest

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

verify:
	./ops/verify.sh

verify-db-down:
	EXPECT_READYZ=503 ./ops/verify.sh

deploy:
	@if [[ -z "$(IMAGE)" ]]; then echo "Usage: make deploy IMAGE=ghcr.io/<owner>/<repo>:<tag>"; exit 1; fi
	API_IMAGE="$(IMAGE)" ./ops/deploy.sh

rollback:
	@if [[ -z "$(IMAGE)" ]]; then echo "Usage: make rollback IMAGE=ghcr.io/<owner>/<repo>:<tag>"; exit 1; fi
	./ops/rollback.sh "$(IMAGE)"

reliability:
	REQUESTS="$${REQUESTS:-30}" ./ops/reliability-check.sh
