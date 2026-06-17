# Change And Maintenance Operations P01 - From-Scratch App Foundation And Delivery Runtime Development Tasks

Suite: 04 OSS Operations And Assurance

App: Change And Maintenance Operations

App slug: `change-maintenance-operations`

Implementation repository: `ts-oss-ops-change-maintenance-operations`

Phase: P01 - From-Scratch App Foundation And Delivery Runtime

Phase file: `P01-from-scratch-app-foundation-and-delivery-runtime.md`

Phase rationale: The planning pack and local repo inspection do not prove a complete runnable implementation for `ts-oss-ops-change-maintenance-operations`; this from-scratch foundation phase creates the app-root runtime, governance, contracts, data, CI, deployment, observability, and proof slice before feature delivery.

Phase exit gate: A clean checkout of `ts-oss-ops-change-maintenance-operations` can run Angular and Spring Boot, apply `change_maintenance` migrations, validate contracts/events, run Docker Compose and Helm checks, and prove one UI/API/data/event slice.

Out of scope for this phase: Feature-domain behavior lands in P02+ after the app runtime foundation is reproducible.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- Foundation artifacts and runtime proof slice

## Phase Tasks

### DT-04-change-maintenance-operations-P01-T001: Bootstrap GitHub app repository and ownership boundary

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Architecture/Docs |
| Target artifact | GitHub repository `ts-oss-ops-change-maintenance-operations` with `change_maintenance` schema ownership |
| Dependencies | External: suite/app evidence chain |
| Outputs | `ts-oss-ops-change-maintenance-operations` repository, branch protection, security scanning, source-evidence map |
| Missing evidence | No |

#### Implementation Notes

- Implement `GitHub repository `ts-oss-ops-change-maintenance-operations` with `change_maintenance` schema ownership` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then `GitHub repository `ts-oss-ops-change-maintenance-operations` with `change_maintenance` schema ownership` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- `GitHub repository `ts-oss-ops-change-maintenance-operations` with `change_maintenance` schema ownership` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T002: Create README, OWNERS, CODEOWNERS, and contribution policy

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Docs |
| Target artifact | `README.md`, `OWNERS.md`, `CODEOWNERS`, and `CONTRIBUTING.md` governance documents |
| Dependencies | DT-04-change-maintenance-operations-P01-T001 |
| Outputs | `README.md`, `OWNERS.md`, `CODEOWNERS`, `CONTRIBUTING.md`, branch-protection evidence |
| Missing evidence | No |

#### Implementation Notes

- Implement ``README.md`, `OWNERS.md`, `CODEOWNERS`, and `CONTRIBUTING.md` governance documents` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``README.md`, `OWNERS.md`, `CODEOWNERS`, and `CONTRIBUTING.md` governance documents` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``README.md`, `OWNERS.md`, `CODEOWNERS`, and `CONTRIBUTING.md` governance documents` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T003: Copy dev-tasks/ from planning source commit

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Docs |
| Target artifact | `dev-tasks/` mirror plus `docs/architecture.md` planning-source reference |
| Dependencies | DT-04-change-maintenance-operations-P01-T002 |
| Outputs | `dev-tasks/` app-repo copy, planning source commit, mirror validation evidence |
| Missing evidence | No |

#### Implementation Notes

- Implement ``dev-tasks/` mirror plus `docs/architecture.md` planning-source reference` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``dev-tasks/` mirror plus `docs/architecture.md` planning-source reference` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``dev-tasks/` mirror plus `docs/architecture.md` planning-source reference` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T004: Build Angular app shell and shared UI dependency

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | UI |
| Target artifact | `frontend/src/app/app.routes.ts` plus `change-maintenance-operations` shell route |
| Dependencies | DT-04-change-maintenance-operations-P01-T003 |
| Outputs | Angular/PrimeNG app shell, navigation entry, empty/loading/error/no-permission states |
| Missing evidence | No |

#### Implementation Notes

- Implement ``frontend/src/app/app.routes.ts` plus `change-maintenance-operations` shell route` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``frontend/src/app/app.routes.ts` plus `change-maintenance-operations` shell route` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``frontend/src/app/app.routes.ts` plus `change-maintenance-operations` shell route` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T005: Build Spring Boot service skeleton and runtime configuration

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | API |
| Target artifact | `backend/` package `com.telcosuite.ossoperationsassurance.changemaintenanceoperations` with `/api/04-oss-operations-assurance/change-maintenance-operations/v1/app-info` and `/actuator/health` |
| Dependencies | DT-04-change-maintenance-operations-P01-T004 |
| Outputs | Spring Boot service, health endpoint, config profiles, exception model, local run notes |
| Missing evidence | No |

#### Implementation Notes

- Implement ``backend/` package `com.telcosuite.ossoperationsassurance.changemaintenanceoperations` with `/api/04-oss-operations-assurance/change-maintenance-operations/v1/app-info` and `/actuator/health`` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``backend/` package `com.telcosuite.ossoperationsassurance.changemaintenanceoperations` with `/api/04-oss-operations-assurance/change-maintenance-operations/v1/app-info` and `/actuator/health`` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``backend/` package `com.telcosuite.ossoperationsassurance.changemaintenanceoperations` with `/api/04-oss-operations-assurance/change-maintenance-operations/v1/app-info` and `/actuator/health`` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T006: Establish OpenAPI and event contract workspace baseline

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | API/Event |
| Target artifact | `contracts/openapi/v1/openapi.yaml` and `contracts/events/ChangeMaintenanceOperationsStateChangedEvent.json` |
| Dependencies | DT-04-change-maintenance-operations-P01-T005 |
| Outputs | OpenAPI workspace, event schema baseline, generated stubs or contract tests |
| Missing evidence | No |

#### Implementation Notes

- Implement ``contracts/openapi/v1/openapi.yaml` and `contracts/events/ChangeMaintenanceOperationsStateChangedEvent.json`` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``contracts/openapi/v1/openapi.yaml` and `contracts/events/ChangeMaintenanceOperationsStateChangedEvent.json`` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``contracts/openapi/v1/openapi.yaml` and `contracts/events/ChangeMaintenanceOperationsStateChangedEvent.json`` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T007: Establish PostgreSQL migration, schema, repository, and seed baseline

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Data |
| Target artifact | `database/postgres/migrations/V001__baseline.sql` for `change_maintenance` plus outbox/idempotency tables |
| Dependencies | DT-04-change-maintenance-operations-P01-T006 |
| Outputs | `change_maintenance` migration baseline, repository package, audit columns, outbox table, seed data |
| Missing evidence | No |

#### Implementation Notes

- Implement ``database/postgres/migrations/V001__baseline.sql` for `change_maintenance` plus outbox/idempotency tables` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``database/postgres/migrations/V001__baseline.sql` for `change_maintenance` plus outbox/idempotency tables` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``database/postgres/migrations/V001__baseline.sql` for `change_maintenance` plus outbox/idempotency tables` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T008: Author ADRs, runbooks, and app docs skeleton

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Docs/Ops |
| Target artifact | `docs/architecture.md`, `docs/api.md`, `docs/data-model.md`, `docs/operations-runbook.md`, and `docs/adr/` |
| Dependencies | DT-04-change-maintenance-operations-P01-T007 |
| Outputs | Architecture docs, API docs, data docs, runbook, first ADR |
| Missing evidence | No |

#### Implementation Notes

- Implement ``docs/architecture.md`, `docs/api.md`, `docs/data-model.md`, `docs/operations-runbook.md`, and `docs/adr/`` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``docs/architecture.md`, `docs/api.md`, `docs/data-model.md`, `docs/operations-runbook.md`, and `docs/adr/`` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``docs/architecture.md`, `docs/api.md`, `docs/data-model.md`, `docs/operations-runbook.md`, and `docs/adr/`` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T009: Wire GitHub Actions quality gates from shared pipeline templates

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | CI/Test |
| Target artifact | `.github/workflows/ci.yml`, `.github/workflows/release.yml`, and `ts-shared-pipeline-templates` pins |
| Dependencies | DT-04-change-maintenance-operations-P01-T008 |
| Outputs | CI/release workflows for lint, unit, contract, migration, E2E, security, Docker Compose, Helm |
| Missing evidence | No |

#### Implementation Notes

- Implement ``.github/workflows/ci.yml`, `.github/workflows/release.yml`, and `ts-shared-pipeline-templates` pins` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``.github/workflows/ci.yml`, `.github/workflows/release.yml`, and `ts-shared-pipeline-templates` pins` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``.github/workflows/ci.yml`, `.github/workflows/release.yml`, and `ts-shared-pipeline-templates` pins` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T010: Validate local Docker Compose stack and demo data

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Ops/Test |
| Target artifact | `deploy/compose/docker-compose.yml`, `.env.example`, and local start script |
| Dependencies | DT-04-change-maintenance-operations-P01-T009 |
| Outputs | Docker Compose stack, PostgreSQL seed/demo data, clean-checkout smoke evidence |
| Missing evidence | No |

#### Implementation Notes

- Implement ``deploy/compose/docker-compose.yml`, `.env.example`, and local start script` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``deploy/compose/docker-compose.yml`, `.env.example`, and local start script` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``deploy/compose/docker-compose.yml`, `.env.example`, and local start script` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T011: Validate Kubernetes and Helm deployment skeleton

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Ops |
| Target artifact | `deploy/k8s/` manifests and `deploy/helm/Chart.yaml` |
| Dependencies | DT-04-change-maintenance-operations-P01-T010 |
| Outputs | Kubernetes manifests, Helm chart, health probes, secrets references, rollback notes |
| Missing evidence | No |

#### Implementation Notes

- Implement ``deploy/k8s/` manifests and `deploy/helm/Chart.yaml`` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``deploy/k8s/` manifests and `deploy/helm/Chart.yaml`` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``deploy/k8s/` manifests and `deploy/helm/Chart.yaml`` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T012: Establish observability, operations, and support baseline

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Ops |
| Target artifact | Grafana dashboard, alert rules, logs/traces with `app='change-maintenance-operations'`, and runbook |
| Dependencies | DT-04-change-maintenance-operations-P01-T011 |
| Outputs | Metrics, traces, structured logs, `/actuator/ready`, dashboard JSON, alerts, support handoff |
| Missing evidence | No |

#### Implementation Notes

- Implement `Grafana dashboard, alert rules, logs/traces with `app='change-maintenance-operations'`, and runbook` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then `Grafana dashboard, alert rules, logs/traces with `app='change-maintenance-operations'`, and runbook` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- `Grafana dashboard, alert rules, logs/traces with `app='change-maintenance-operations'`, and runbook` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T013: Prove the first end-to-end vertical slice through UI, API, data, and event

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | UI/API/Data/Event/Test |
| Target artifact | Vertical slice using `/api/04-oss-operations-assurance/change-maintenance-operations/v1/app-info`, `change_maintenance.event_outbox`, and `ChangeMaintenanceOperationsStateChangedEvent` |
| Dependencies | DT-04-change-maintenance-operations-P01-T012 |
| Outputs | E2E smoke, API contract test, migration check, outbox event proof, audit timeline evidence |
| Missing evidence | No |

#### Implementation Notes

- Implement `Vertical slice using `/api/04-oss-operations-assurance/change-maintenance-operations/v1/app-info`, `change_maintenance.event_outbox`, and `ChangeMaintenanceOperationsStateChangedEvent`` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then `Vertical slice using `/api/04-oss-operations-assurance/change-maintenance-operations/v1/app-info`, `change_maintenance.event_outbox`, and `ChangeMaintenanceOperationsStateChangedEvent`` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- `Vertical slice using `/api/04-oss-operations-assurance/change-maintenance-operations/v1/app-info`, `change_maintenance.event_outbox`, and `ChangeMaintenanceOperationsStateChangedEvent`` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.

### DT-04-change-maintenance-operations-P01-T014: Add negative scenario preventing legacy or suite-nested implementation

| Field | Value |
| --- | --- |
| Phase | P01 - From-Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | From-scratch app foundation |
| Build area | Test/Architecture |
| Target artifact | `tests/architecture/no-legacy-paths.spec.ts` CI guard for shared-repo or suite-nested implementation paths |
| Dependencies | DT-04-change-maintenance-operations-P01-T013 |
| Outputs | Architecture guard test, CI blocker, runbook note, tracker evidence |
| Missing evidence | No |

#### Implementation Notes

- Implement ``tests/architecture/no-legacy-paths.spec.ts` CI guard for shared-repo or suite-nested implementation paths` inside `ts-oss-ops-change-maintenance-operations` using app-root paths `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `.github/workflows/`.
- Keep writes inside `change_maintenance`; any cross-app dependency uses APIs, events, workflow tasks, governed projections, or certified data products.
- Record source evidence, owner, command output, and blocker/removal criteria in `development-task-tracker.md` before dependent P02+ work starts.

#### Acceptance Criteria

1. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when this task is complete, then ``tests/architecture/no-legacy-paths.spec.ts` CI guard for shared-repo or suite-nested implementation paths` exists or `development-task-tracker.md` links an approved exception with owner and removal date.
2. Given `change_maintenance` is app-owned, when migrations, services, contracts, or fixtures are created, then no write crosses another app schema and `mvn test` returns exit code `0`.
3. Given the local stack starts, when `docker compose config` and `helm lint deploy/helm` run, then `docker compose config` returns exit code `0`, `helm lint` returns exit code `0`, and `$.validation.status='passed'` is linked in the tracker.

#### Definition Of Done

- ``tests/architecture/no-legacy-paths.spec.ts` CI guard for shared-repo or suite-nested implementation paths` is implemented in `ts-oss-ops-change-maintenance-operations` or blocked with owner, target increment, and removal criteria.
- `npm run lint`, `npm test`, `mvn test`, OpenAPI/event contract checks, Flyway migration checks, Docker Compose validation, and Helm validation are run where relevant.
- `development-task-tracker.md`, `docs/architecture.md`, and `docs/operations-runbook.md` are updated with command output, PR links, and evidence.

#### Negative Scenarios

- Do not implement this task in a shared frontend/backend repo or under `ts-planning`; `tests/architecture/no-legacy-paths.spec.ts` must fail such paths.
- Do not create direct joins, foreign keys, or writes outside `change_maintenance`; convert the need to an API, event, workflow, projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation to make the proof slice pass.

#### Edge Cases

- The planning-to-app mirror records `$.sourceCommit` in `docs/architecture.md` before app-local task status diverges.
- Shared package or pipeline version changes preserve task IDs of the form `DT-04-change-maintenance-operations-P01-Txxx` and add migration notes.
- Platform services may be mocked locally, but CI and release gates still require OpenAPI, event replay, migration, security, and reconciliation evidence.

#### Test Expectations

- `npm run lint`, `npm test`, and a Playwright/Cypress smoke validate the Angular shell or route changed by this task.
- `mvn test`, OpenAPI contract tests, event replay tests, Flyway migration tests, and `/actuator/health` validate the backend, contracts, and database surface.
- `docker compose config`, clean-checkout startup, `helm lint`, Kubernetes dry-run, and GitHub Actions workflow validation produce linked evidence in the tracker.
