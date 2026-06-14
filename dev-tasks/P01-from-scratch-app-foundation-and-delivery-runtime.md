# Change And Maintenance Operations P01 - From Scratch App Foundation And Delivery Runtime Development Tasks

Suite: OSS Operations And Assurance

App: Change And Maintenance Operations

App slug: `change-maintenance-operations`

Implementation repository: `ts-oss-ops-change-maintenance-operations`

Phase: P01 - From Scratch App Foundation And Delivery Runtime

Phase file: `P01-from-scratch-app-foundation-and-delivery-runtime.md`

Phase rationale: The planning repository currently contains planning, database, TMF reference, and generated backlog artifacts but no runnable GitHub implementation repository for `change-maintenance-operations`. This phase bootstraps app repository `ts-oss-ops-change-maintenance-operations` with Angular/PrimeNG frontend, Spring Boot backend, PostgreSQL migration baseline, contracts, security context, event/outbox baseline, local Docker Compose workflow, GitHub Actions from `ts-shared-pipeline-templates`, Kubernetes/Helm deployment skeleton, observability, and a proof vertical slice before feature implementation begins.

Phase exit gate: A developer can clone `ts-oss-ops-change-maintenance-operations`, run the Angular shell and Spring Boot service, apply app-owned migrations for `change_maintenance`, execute baseline tests, validate Docker Compose and Kubernetes/Helm deployment assets, and prove a minimal UI-to-API-to-database-to-audit/event path with tracker evidence.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- Creates the runnable GitHub app repository `ts-oss-ops-change-maintenance-operations` and app surface needed before domain feature phases can be built.
- Establishes repository governance, frontend, backend, database, API contract, security, event, CI, observability, local development, deployment, and release evidence baselines.
- Converts missing platform or workspace conventions into explicit blockers instead of hidden assumptions.
- Adopts the TMF-aligned primary APIs: TMF655, TMF681, TMF696, TMF638, TMF639, TMF701, TMF640, TMF629.

## Default Scaffold Targets

Use these app-repository-relative targets for `ts-oss-ops-change-maintenance-operations` unless `DT-01-change-maintenance-operations-P01-T001` records an approved architecture exception:

- GitHub app repository: `ts-oss-ops-change-maintenance-operations` with `README.md`, `OWNERS.md`, `CODEOWNERS`, protected `main`, required GitHub Actions checks, security scanning, copied `dev-tasks/`, and planning source commit/link recorded in `docs/architecture.md` or an ADR.
- Shared prerequisites: consume versioned UI/design-system assets from `ts-shared-ui-design-system` and GitHub Actions workflow templates from `ts-shared-pipeline-templates`; app-specific UI, domain logic, migrations, and telecom lifecycle decisions remain in `ts-oss-ops-change-maintenance-operations`.
- Angular workspace: `frontend/` with app routes and components under `frontend/src/app/`, including `routes.ts`, `pages/`, `components/`, `services/`, `state/`, guards, and `testing/fixtures/`.
- Spring Boot service: `backend/` with package `com.telcosuite.ossops.change_maintenance`, including `controller/`, `service/`, `domain/`, `repository/`, `security/`, `events/`, and `config/`.
- API contracts: `contracts/openapi/v1/openapi.yaml` and generated/validated DTO contracts for command, query, admin/config, evidence, and health endpoints.
- Event contracts: `contracts/events/` with versioned JSON schemas, replay fixtures, and consumer acknowledgement examples.
- Database migrations: `database/postgres/migrations/` and `database/postgres/seeds/` with app-owned changes for schema `change_maintenance`, audit/evidence, idempotency, outbox, seed/demo data, and rollback/repair notes.
- App documentation: `docs/architecture.md`, `docs/api.md`, `docs/data-model.md`, `docs/operations-runbook.md`, and `docs/adr/` for app boundary, source planning evidence, API/event/data decisions, operations, and architecture exceptions.
- Local dev assets: `.env.example`, `deploy/compose/docker-compose.yml`, smoke-test fixtures, and clean-checkout setup notes.
- CI and deployment: `.github/workflows/ci.yml`, `.github/workflows/release.yml`, `deploy/k8s/`, and `deploy/helm/` with environment config, health probes, secrets references, migration order, rollback/repair, and support escalation.

Baseline commands to document or implement: `npm install`, `npm run lint`, `npm run test`, `npm run start`, `mvn test`, `mvn spring-boot:run`, PostgreSQL migration test command, OpenAPI contract test command, event schema/replay test command, Docker Compose validation command, Kubernetes/Helm validation command, and E2E smoke command.

## Phase Tasks

### DT-01-change-maintenance-operations-P01-T001: Bootstrap GitHub app repository and ownership boundary

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Implementation usage](../planning/app-detail/implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../planning/app-detail/modules-and-features.md), [Personas and journeys](../planning/app-detail/personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [TMF review](../../tmf-api-ddl-reviews/change-maintenance.md), [App migration](../../../../../database/postgres/suites/ts_oss_operations_assurance/V001__create_app_schemas_and_starter_tables.sql), [API-first architecture](../../../../api-first-product-suite-architecture.md), [Technology stack guidance](../../../../technology-stack-guidance.md), [UI design system](../../../../telcosuite-ui-design-system.md), [Database setup guidance](../../../../recommended-database-setup.md), [Data mastery ownership](../../../../data-mastery-entity-ownership.md) |
| Feature or module | From-scratch app foundation |
| Build area | Architecture/Docs |
| Dependencies | External: suite/app evidence chain |
| Outputs | GitHub repository `ts-oss-ops-change-maintenance-operations`, app boundary decision, copied `dev-tasks/`, ownership files, branch protection/check policy, app-root workspace names, and source-evidence map. |

#### Implementation Notes

- Confirm that `ts-oss-ops-change-maintenance-operations` is the implementation repository for this app and record the intended frontend, backend, database, test, CI, Docker Compose, Kubernetes/Helm, and deployment locations before code scaffolding starts.
- Map the app-owned schema `change_maintenance`, TMF/API posture (TMF655, TMF681, TMF696, TMF638, TMF639, TMF701, TMF640, TMF629), personas, feature folders, repository ownership, shared repository dependencies, and cross-app boundaries to concrete implementation artifacts.
- Create open decisions for any missing app-repo, package, build, GitHub, shared-repository, Docker Compose, Kubernetes/Helm, or deployment convention instead of letting feature teams invent local patterns.

#### Concrete Scaffold Artifacts

- Default artifact map: GitHub repo `ts-oss-ops-change-maintenance-operations` with app-root `frontend/`, `backend/`, `contracts/openapi/v1/openapi.yaml`, `contracts/events/`, `database/postgres/migrations/`, `database/postgres/seeds/`, `docs/`, `dev-tasks/`, `.github/workflows/ci.yml`, `.github/workflows/release.yml`, `deploy/compose/`, `deploy/k8s/`, and `deploy/helm/`.
- Bootstrap governance files: `README.md`, `OWNERS.md`, `CODEOWNERS`, branch protection configuration or evidence, required GitHub Actions checks, and security scanning policy for `ts-oss-ops-change-maintenance-operations`.
- Shared dependencies: pin `ts-shared-ui-design-system` and `ts-shared-pipeline-templates` versions or record blockers with owners and removal criteria.
- Copy `dev-tasks/` from planning into the app repo as a bootstrap copy and record the planning source commit/link; active task status is maintained in the app repo afterward.
- Record any deviation from the default scaffold targets as an architecture decision with owner, reason, affected tasks, migration path, and rollback impact.

#### Acceptance Criteria

1. Given a developer bootstraps this app repository from the current planning state, when they inspect the workspace, then the tracker names the exact GitHub, Angular, Spring Boot, PostgreSQL, test, CI, Docker Compose, Kubernetes/Helm, and deployment artifacts that must be created for this app before feature work begins.
2. Given `change-maintenance-operations` uses app-owned schema `change_maintenance`, when the task creates code, config, migrations, contracts, or test fixtures, then writes remain inside that schema and cross-app data access is represented as API, event, workflow, projection, or data product dependency.
3. Given later feature-slice tasks depend on this foundation output, when the task is complete, then the relevant app shell, service, database, security, event, observability, and CI surfaces are named, runnable or explicitly blocked, and linked from the tracker.
4. Given the default scaffold targets are approved, when this task is implemented, then the named repo paths, commands, tests, and evidence artifacts exist or the tracker links an approved exception with replacement paths and commands.
5. Given a clean checkout of `ts-oss-ops-change-maintenance-operations`, when the documented commands are run in dependency order, then the task output is reproducible without manual, undocumented setup.
6. Given `ts-oss-ops-change-maintenance-operations` is bootstrapped, when repository governance is reviewed, then `README.md`, `OWNERS.md`, `CODEOWNERS`, branch protection evidence, required GitHub Actions checks, security scanning, copied `dev-tasks/`, and planning source commit/link are present.
7. Given shared repositories are required immediately, when the app scaffold is created, then UI dependencies reference `ts-shared-ui-design-system` and CI/CD workflows use or intentionally disposition `ts-shared-pipeline-templates`.

#### Definition of Done

- The from-scratch artifact named in this task is implemented or captured as an explicit blocker with owner, target increment, and removal criteria.
- Source evidence, app boundary, generated files, configuration, scripts, local run steps, and GitHub repository bootstrap evidence are linked from the task evidence or tracker notes.
- Tests listed for the task exist and pass, or a documented platform dependency explains why they are blocked.
- Tracker status, owner, and evidence are updated before dependent P02+ tasks begin.

#### Negative Scenarios

- Do not start feature implementation if the app cannot run locally or the backend/database baseline is not reproducible from a clean checkout.
- Do not create or continue implementation under legacy shared frontend/backend monorepo folders or suite-nested contract/deployment folders; use app-root paths in the app repository.
- Do not create direct writes, joins, or foreign keys to another app schema; convert the need to API, event, workflow, governed projection, or data product dependency.
- Do not bypass tenant, role, data-residency, masking, audit, idempotency, or migration validation just to make the first slice pass.
- If suite platform services are unavailable, use a documented adapter/mock with removal criteria instead of hard-coding app-local platform behavior.

#### Edge Cases

- The app repository starts from a planning bootstrap copy, so links back to planning evidence must record a durable commit, tag, or URL before local task status diverges.
- The repository has no existing frontend/backend workspace, so the task must either create one or document the approved external workspace dependency.
- Multiple apps may share a platform shell, but app-specific routes, permissions, schemas, migrations, and task evidence remain separate.
- A future platform decision can move generated modules; preserve task IDs and tracker links while recording migration notes.
- Local development may run with mocked integrations while CI and release gates still require contract, replay, and reconciliation evidence.

#### Test Expectations

- Run or define app startup smoke tests for the Angular shell and Spring Boot service.
- Run migration tests against a clean PostgreSQL database and verify schema ownership boundaries.
- Run unit, contract, authorization, accessibility, event/outbox, observability, GitHub Actions, Docker Compose, Kubernetes/Helm, and CI smoke tests appropriate to the task output.
- Update the tracker with command output, PR links, screenshots, contract-test evidence, or blocker notes when implementation starts.

### DT-01-change-maintenance-operations-P01-T002: Create Angular application shell and suite navigation entry

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [UI design system](../../../../../telcosuite-ui-design-system.md), [App summary](../../../../../change-maintenance-operations.md), [Personas](../../../../../change-maintenance-operations-personas.md) |
| Feature or module | From-scratch app foundation |
| Build area | UI |
| Dependencies | DT-01-change-maintenance-operations-P01-T001 |
| Outputs | Angular workspace under `frontend/`, app routes, suite navigation entry, loading/empty/error/no-permission states, and shared UI package wiring. |

#### Implementation Notes

- Use the shared UI package from `ts-shared-ui-design-system` for tokens, layout shell, navigation, and accessibility patterns.
- Register the app under its suite path so cross-suite navigation can find it without hard-coded routes.
- Cover empty/loading/error/no-permission states in every primary screen from the start.

#### Concrete Scaffold Artifacts

- `frontend/src/app/app.config.ts`, `frontend/src/app/app.routes.ts`, `frontend/src/app/app.component.ts`.
- Suite navigation entry under the app's suite prefix.
- Storybook or component playground entries for shared UI usage.

#### Acceptance Criteria

1. Given a clean checkout, when the developer runs `npm install` and `npm start`, then the Angular shell launches with the suite navigation entry visible.
2. Given a primary screen, when the screen is empty, loading, errored, or accessed without permission, then a documented state is shown.
3. Given the shared UI package is required, when the app is built, then the version pin is recorded in `package.json` and the design tokens are applied.

#### Definition of Done

- App shell and suite navigation are reachable from a clean checkout.
- Loading/empty/error/no-permission states are wired into shared components.
- Shared UI package version is pinned.

#### Negative Scenarios

- Do not hard-code tenant/brand/market logic into the Angular shell.
- Do not skip accessibility roles, focus order, or screen reader labels.

#### Edge Cases

- Shared UI upgrades can shift component contracts; track and document deltas.
- Local development may need a mock auth provider; do not commit production auth secrets.

#### Test Expectations

- Run `npm run lint` and `npm run test` and verify they pass.
- Run an accessibility smoke check on the suite navigation and primary screens.
- Update the tracker with command output, screenshots, or blocker notes.

### DT-01-change-maintenance-operations-P01-T003: Create Spring Boot service skeleton and runtime configuration

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [API-first architecture](../../../../../api-first-product-suite-architecture.md), [Technology stack guidance](../../../../../technology-stack-guidance.md), [App summary](../../../../../change-maintenance-operations.md) |
| Feature or module | From-scratch app foundation |
| Build area | API/Ops |
| Dependencies | DT-01-change-maintenance-operations-P01-T002 |
| Outputs | Spring Boot service under `backend/`, health/readiness/app-info endpoints, runtime config profiles, and base security wiring. |

#### Implementation Notes

- Use the shared Spring Boot starter(s) from the platform team; do not reinvent logging, exception handling, or security scaffolding.
- Wire the health/readiness/app-info endpoints into the deployment probes from the start.
- Set the Java package under `com.telcosuite.ossops.change_maintenance`.

#### Concrete Scaffold Artifacts

- `backend/pom.xml`, `backend/src/main/java/.../Application.java`, `backend/src/main/resources/application.yml`, profile-specific overrides.
- `controller/HealthController`, `controller/InfoController`, `config/SecurityConfig`, `config/OpenApiConfig`.

#### Acceptance Criteria

1. Given a clean checkout, when the developer runs `mvn spring-boot:run`, then the service starts, exposes `/actuator/health`, `/actuator/info`, and `/api/v1/health`, and logs in JSON.
2. Given a profile-specific override, when the developer activates it, then the override is applied without code changes.
3. Given a security boundary, when an unauthenticated request hits a protected path, then the documented denial is returned and audited.

#### Definition of Done

- Service starts locally and in CI.
- Health and info endpoints return the documented payload.
- Base security profile is enforced.

#### Negative Scenarios

- Do not enable production-only features in the local profile.
- Do not commit secrets or real tenant data to the runtime config.

#### Edge Cases

- CI may run with limited resources; profile the JVM settings.
- Local Postgres may differ from CI; do not hard-code hosts.

#### Test Expectations

- Run `mvn test` and verify it passes.
- Run the application context-load test.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T004: Establish PostgreSQL migration, schema, repository, and seed baseline

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Recommended database setup](../../../../../recommended-database-setup.md), [Data mastery ownership](../../../../../data-mastery-entity-ownership.md), [Suite data model](../../../../data-model.md), [App migration](../../../../../database/postgres/suites/ts_oss_operations_assurance/V001__create_app_schemas_and_starter_tables.sql) |
| Feature or module | From-scratch app foundation |
| Build area | Data |
| Dependencies | DT-01-change-maintenance-operations-P01-T003 |
| Outputs | App-owned Flyway migrations under `database/postgres/migrations/`, seed scripts under `database/postgres/seeds/`, repository scaffolding, and rollback/repair notes. |

#### Implementation Notes

- Use Flyway with `database/postgres/migrations/` for forward migrations.
- Keep the app's write/read models in schema `change_maintenance`.
- Use a deterministic seed plan for local and CI environments.

#### Concrete Scaffold Artifacts

- `database/postgres/migrations/V001__create_app_owned_schema.sql`, audit/outbox/idempotency tables, app-specific starter tables.
- `database/postgres/seeds/seed-local.sql`, `database/postgres/seeds/seed-demo.sql`.
- `backend/src/main/java/.../repository/` scaffolding.

#### Acceptance Criteria

1. Given a clean PostgreSQL database, when Flyway runs the app's migrations, then only schema `change_maintenance` and its tables are created.
2. Given a second clean run, when migrations are re-applied, then the run is idempotent and produces no drift.
3. Given a rollback/repair scenario, when a documented forward-repair migration is applied, then the documented state is recovered.

#### Definition of Done

- App-owned schema and tables are created by the app's own migrations.
- Seed scripts run deterministically in local and CI.
- Repository scaffolding compiles and passes smoke tests.

#### Negative Scenarios

- Do not create tables in another app's schema.
- Do not run destructive migrations without a forward-repair plan.

#### Edge Cases

- Local Postgres version may differ; record the supported versions.
- CI may use a throwaway database; verify cleanup.

#### Test Expectations

- Run migration tests on a clean database and verify schema boundaries.
- Run repository smoke tests.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T005: Define TMF/OpenAPI contract workspace and API versioning baseline

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [TMF review](../../tmf-api-ddl-reviews/change-maintenance.md), [API-first architecture](../../../../api-first-product-suite-architecture.md) |
| Feature or module | From-scratch app foundation |
| Build area | API/Test |
| Dependencies | DT-01-change-maintenance-operations-P01-T004 |
| Outputs | `contracts/openapi/v1/openapi.yaml`, generated/validated DTO contracts, command/query/admin/evidence surface plan, and contract test scaffolding. |

#### Implementation Notes

- Use the TMF baseline selected in the per-app TMF review.
- Define a versioning policy (URI version + OpenAPI version) before any breaking change.
- Pin contract tests in CI.

#### Concrete Scaffold Artifacts

- `contracts/openapi/v1/openapi.yaml` baseline.
- Generated DTOs into the backend via OpenAPI Generator.
- Contract test harness.

#### Acceptance Criteria

1. Given a command/query/admin/evidence surface plan, when the OpenAPI file is generated, then it documents the planned endpoints and the TMF resource mapping.
2. Given a contract test, when the test runs in CI, then the response payload matches the OpenAPI schema.

#### Definition of Done

- OpenAPI document exists at v1.
- Contract tests are wired in CI.

#### Negative Scenarios

- Do not hand-edit generated DTOs.
- Do not introduce breaking contract changes without an approved versioning plan.

#### Edge Cases

- Generated clients may lag behind OpenAPI changes; pin and document.

#### Test Expectations

- Run OpenAPI lint and contract test commands.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T006: Implement authentication, authorization, tenant, and evidence context baseline

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [API-first architecture](../../../../api-first-product-suite-architecture.md), [Data mastery ownership](../../../../data-mastery-entity-ownership.md) |
| Feature or module | From-scratch app foundation |
| Build area | Security |
| Dependencies | DT-01-change-maintenance-operations-P01-T005 |
| Outputs | AuthN/AuthZ baseline, tenant/brand/market context propagation, denial audit tests, masking helper, and GitHub security scan evidence. |

#### Implementation Notes

- Propagate tenant/brand/market context from the auth layer through every request.
- Apply role-based and attribute-based controls consistently.
- Mask sensitive fields by default; unmask only on documented policy.

#### Concrete Scaffold Artifacts

- Security filter/interceptor, tenant context holder, masking utility, and authorization advisor.

#### Acceptance Criteria

1. Given an authenticated request, when the request hits a protected endpoint, then the tenant/brand/market context is present in the audit log.
2. Given an unauthorized request, when the request hits a protected endpoint, then the documented denial is returned and audited.
3. Given a sensitive field, when the field is rendered, then the masking policy is applied by default.

#### Definition of Done

- AuthN/AuthZ baseline is wired in.
- Tenant/brand/market context is enforced.
- Masking and audit helpers exist and are used.

#### Negative Scenarios

- Do not store secrets in the repo.
- Do not bypass masking for "trusted" callers without an approved policy.

#### Edge Cases

- Federated identity may be required; document the supported providers.
- Local development may use a mock identity provider.

#### Test Expectations

- Run authorization and denial audit tests.
- Run a security scan and capture the report.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T007: Create event, outbox, workflow, and integration contract baseline

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [API-first architecture](../../../../api-first-product-suite-architecture.md), [Data mastery ownership](../../../../data-mastery-entity-ownership.md) |
| Feature or module | From-scratch app foundation |
| Build area | Event/Workflow |
| Dependencies | DT-01-change-maintenance-operations-P01-T006 |
| Outputs | Event schema catalog, transactional outbox table and helper, replay fixtures, and consumer acknowledgement examples. |

#### Implementation Notes

- Use a transactional outbox pattern for cross-app events.
- Include correlation, causation, tenant, brand, market, and schema version in every event.
- Provide replay fixtures and acknowledgement examples.

#### Concrete Scaffold Artifacts

- `contracts/events/<event-name>.schema.json` and shared envelope schema.
- `event_outbox` table in schema `change_maintenance`.
- Outbox publisher and replay test harness.

#### Acceptance Criteria

1. Given a state change, when the outbox writer runs, then an event row is inserted in the same transaction and the publisher emits it.
2. Given a downstream consumer, when it processes the event, then the acknowledgement/reconciliation flow is documented and tested.
3. Given a replay scenario, when the outbox is replayed, then idempotency is preserved.

#### Definition of Done

- Event catalog and outbox writer are in place.
- Replay and acknowledgement tests pass.

#### Negative Scenarios

- Do not publish events from controllers directly; always go through the outbox.
- Do not drop tenant/brand/market context in events.

#### Edge Cases

- Outbox backlogs must be observable.
- Event schema changes must be backward-compatible or versioned.

#### Test Expectations

- Run outbox and replay tests.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T008: Build shared app UI patterns for queues, records, forms, dashboards, and evidence views

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [UI design system](../../../../../telcosuite-ui-design-system.md), [App summary](../../../../../change-maintenance-operations.md) |
| Feature or module | From-scratch app foundation |
| Build area | UI/Test |
| Dependencies | DT-01-change-maintenance-operations-P01-T007 |
| Outputs | Shared Angular patterns for queues, records, forms, dashboards, and evidence views, with accessibility and density checks. |

#### Implementation Notes

- Use the design system's dense table, form, and evidence panel patterns.
- Each shared pattern must be unit-tested and accessibility-checked.

#### Concrete Scaffold Artifacts

- `frontend/src/app/components/`, `frontend/src/app/patterns/`, and Storybook entries.

#### Acceptance Criteria

1. Given a shared pattern, when used by a feature screen, then the screen renders correctly and meets accessibility checks.
2. Given an empty/loading/error state, when the pattern is used, then the documented state is shown.

#### Definition of Done

- Shared patterns are reusable, tested, and documented.
- Accessibility checks pass.

#### Negative Scenarios

- Do not fork the design system inside the app.
- Do not skip accessibility roles or focus order.

#### Edge Cases

- Pattern changes may require coordinated updates across screens.

#### Test Expectations

- Run unit tests for the shared patterns.
- Run accessibility smoke tests.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T009: Add local developer environment, run scripts, seed data, and demo smoke flow

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [Repository strategy](../../../../repository-strategy.md), [Recommended database setup](../../../../../recommended-database-setup.md) |
| Feature or module | From-scratch app foundation |
| Build area | DevEx/Data/Test |
| Dependencies | DT-01-change-maintenance-operations-P01-T008 |
| Outputs | `.env.example`, `deploy/compose/docker-compose.yml`, local dev scripts, seed data, and a documented smoke flow. |

#### Implementation Notes

- Use Docker Compose for the local Postgres.
- Provide a one-shot script to start, migrate, seed, and run the smoke flow.

#### Concrete Scaffold Artifacts

- `deploy/compose/docker-compose.yml`, `.env.example`, `scripts/dev/<app>-start.sh`, and `scripts/dev/<app>-smoke.sh`.

#### Acceptance Criteria

1. Given a clean checkout, when the local dev script runs, then Postgres is up, migrations are applied, seeds are loaded, and the smoke flow passes.
2. Given a teardown, when the developer stops and removes the compose stack, then no orphan resources remain.

#### Definition of Done

- Local dev environment is reproducible from a clean checkout.
- Smoke flow is documented and passable.

#### Negative Scenarios

- Do not commit real credentials.
- Do not use production-like secrets in the local compose.

#### Edge Cases

- Local Postgres may differ from CI; document the supported versions.

#### Test Expectations

- Run the smoke flow end to end.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T010: Wire CI quality gates and test pyramid scaffolding

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [Repository strategy](../../../../repository-strategy.md), [Shared pipeline templates](../../../../../ts-shared-pipeline-templates) |
| Feature or module | From-scratch app foundation |
| Build area | CI/Test |
| Dependencies | DT-01-change-maintenance-operations-P01-T009 |
| Outputs | `.github/workflows/ci.yml`, `.github/workflows/release.yml`, and pinned shared pipeline template references. |

#### Implementation Notes

- Use the shared pipeline templates for lint, unit, contract, migration, E2E, security, and accessibility gates.
- Pin the shared template versions and record upgrade notes.

#### Concrete Scaffold Artifacts

- `.github/workflows/ci.yml` and `.github/workflows/release.yml`.

#### Acceptance Criteria

1. Given a pull request, when the CI workflow runs, then lint, unit, contract, migration, security, and accessibility gates run in the documented order.
2. Given a tagged release, when the release workflow runs, then the documented release artifacts are produced and signed.

#### Definition of Done

- CI gates run on PR and push.
- Release workflow is documented and pinned to shared templates.

#### Negative Scenarios

- Do not skip contract or migration gates to "make it pass".
- Do not silently absorb a shared template upgrade; record the diff.

#### Edge Cases

- CI may run with reduced concurrency; profile the gates.

#### Test Expectations

- Run CI on a draft PR and capture the report.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T011: Establish observability, operations, support, and deployment skeleton

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P1 |
| Source evidence | [Repository strategy](../../../../repository-strategy.md), [Recommended database setup](../../../../../recommended-database-setup.md) |
| Feature or module | From-scratch app foundation |
| Build area | Ops/Release |
| Dependencies | DT-01-change-maintenance-operations-P01-T010 |
| Outputs | Structured logging, metrics, traces, dashboards, alerts, runbooks, and Kubernetes/Helm deployment skeleton. |

#### Implementation Notes

- Emit JSON logs with correlation, tenant, brand, market, and user context.
- Wire metrics and traces into the platform observability stack.
- Provide dashboard JSON, alert rules, and runbook links.

#### Concrete Scaffold Artifacts

- `deploy/k8s/`, `deploy/helm/`, `docs/operations-runbook.md`, dashboard JSON, alert rules.

#### Acceptance Criteria

1. Given a request, when the service handles it, then structured logs, metrics, and traces are emitted with correlation IDs.
2. Given a deployment, when the Helm chart is rendered, then the documented health probes, resources, and secrets references are present.
3. Given an incident, when the on-call follows the runbook, then the documented steps are actionable.

#### Definition of Done

- Observability is wired in.
- Helm chart and Kustomize overlays are validated.
- Runbook and dashboards are linked.

#### Negative Scenarios

- Do not log secrets or PII.
- Do not deploy without health probes and resource limits.

#### Edge Cases

- Cluster autoscaling may require HPA; document the trigger.
- Multi-tenant deployments may require network policies.

#### Test Expectations

- Render and validate the Helm chart.
- Run a smoke test against a deployed environment.
- Update the tracker with command output or blocker notes.

### DT-01-change-maintenance-operations-P01-T012: Prove the first end-to-end vertical slice through UI, API, database, event, security, and CI

| Field | Value |
| --- | --- |
| Phase | P01 - From Scratch App Foundation And Delivery Runtime |
| Priority | P0 |
| Source evidence | [Repository strategy](../../../../repository-strategy.md), [App summary](../../../../../change-maintenance-operations.md) |
| Feature or module | From-scratch app foundation |
| Build area | Full-stack/Test/Release |
| Dependencies | DT-01-change-maintenance-operations-P01-T011 |
| Outputs | A documented end-to-end vertical slice (UI call to API to database to outbox to event), with screenshots, contract-test output, and tracker evidence. |

#### Implementation Notes

- The slice does not need to deliver business value; it must prove the foundation works.
- Capture screenshots, logs, and event payloads in the tracker.

#### Concrete Scaffold Artifacts

- `tests/e2e/vertical-slice.spec.ts`, `scripts/dev/<app>-vertical-slice.sh`, and tracker evidence.

#### Acceptance Criteria

1. Given a clean checkout, when the vertical-slice script runs, then the UI calls the API, the API persists data, the outbox emits an event, and CI shows green.
2. Given a failure, when the slice breaks, then the root cause is captured and the next task is updated.

#### Definition of Done

- Vertical slice runs on demand and in CI.
- Tracker has screenshots, logs, and event payloads.

#### Negative Scenarios

- Do not "fake" the slice with mocked outputs.
- Do not skip the audit/evidence trail.

#### Edge Cases

- Network or DB timing may be flaky; the slice must be retryable.

#### Test Expectations

- Run the vertical slice in CI.
- Update the tracker with command output, screenshots, and event payloads.
