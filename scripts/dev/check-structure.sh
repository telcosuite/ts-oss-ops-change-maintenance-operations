#!/usr/bin/env bash
set -euo pipefail
test -f README.md
test -d dev-tasks
test -d frontend
test -d backend
test -f contracts/openapi/v1/openapi.yaml
test -f contracts/events/domain-event.schema.json
test -d database/postgres/migrations
test -d deploy/compose
