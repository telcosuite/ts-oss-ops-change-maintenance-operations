# Change And Maintenance Operations P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar Development Tasks

Suite: 04 OSS Operations And Assurance

App: Change And Maintenance Operations

App slug: `change-maintenance-operations`

Implementation repository: `ts-oss-ops-change-maintenance-operations`

Phase: P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar

Phase file: `P02-change-record-intake-risk-assessment-and-cross-domain-release-calendar.md`

Phase rationale: Build the Cross-Domain Release Change Calendar, Change Record, Risk And Impact capability cluster for Change And Maintenance Operations, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work.

Phase exit gate: Change And Maintenance Operations can execute the Cross-Domain Release Change Calendar, Change Record, Risk And Impact workflows through UI, API, `change_maintenance` persistence, outbox events, audit evidence, and release tests.

Out of scope for this phase: Runtime bootstrap is in P01; unrelated feature clusters and post-launch operations remain in their own phases.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- [Cross-Domain Release Change Calendar](../features/cross-domain-release-change-calendar.md)
- [Change Record](../features/change-record.md)
- [Risk And Impact](../features/risk-and-impact.md)

## Phase Tasks

### DT-04-change-maintenance-operations-P02-T001: Build Cross-Domain Release Change Calendar API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar |
| Priority | P0 |
| Source evidence | [Cross-Domain Release Change Calendar](../features/cross-domain-release-change-calendar.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Cross-Domain Release Change Calendar |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossoperationsassurance/changemaintenanceoperations/CrossDomainReleaseChangeCalendarController.java`, `change_maintenance.cross_domain_release_change_calendar`, `contracts/events/CrossDomainReleaseChangeCalendarStateChangedEvent.json`, and `/api/04-oss-operations-assurance/change-maintenance-operations/v1/cross-domain-release-change-calendar` |
| Dependencies | DT-04-change-maintenance-operations-P01-T013 |
| Outputs | `CrossDomainReleaseChangeCalendarController`, `CrossDomainReleaseChangeCalendarService`, `change_maintenance.cross_domain_release_change_calendar` migration, `CrossDomainReleaseChangeCalendarStateChangedEvent` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/04-oss-operations-assurance/change-maintenance-operations/v1/cross-domain-release-change-calendar` using TMF629, TMF638, TMF639, TMF640, TMF655, TMF681, TMF696, TMF701, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Cross-Domain Release Change Calendar` state in `change_maintenance.cross_domain_release_change_calendar` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `CrossDomainReleaseChangeCalendarStateChangedEvent` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: create or update, validate, close.
- Carry source details into code and tests for personas Release manager, Change manager, NOC engineer and objects Calendar object or control, Release/change calendar entry, Cross-domain collision, Freeze/blackout overlay; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/04-oss-operations-assurance/change-maintenance-operations/v1/cross-domain-release-change-calendar`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `change_maintenance.cross_domain_release_change_calendar.id`, and appends `CrossDomainReleaseChangeCalendarStateChangedEvent` to `change_maintenance.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/04-oss-operations-assurance/change-maintenance-operations/v1/cross-domain-release-change-calendar/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Cross-Domain Release Change Calendar` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `change_maintenance.cross_domain_release_change_calendar` is required.

#### Definition Of Done

- `CrossDomainReleaseChangeCalendarController`, service, repository, DTOs, validation, error model, and migration for `change_maintenance.cross_domain_release_change_calendar` are committed under `ts-oss-ops-change-maintenance-operations`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/04-oss-operations-assurance/change-maintenance-operations/v1/cross-domain-release-change-calendar`, `change_maintenance.cross_domain_release_change_calendar`, and `CrossDomainReleaseChangeCalendarStateChangedEvent`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/04-oss-operations-assurance/change-maintenance-operations/v1/cross-domain-release-change-calendar` return `403` and write a denial audit row instead of exposing `Cross-Domain Release Change Calendar` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `change_maintenance.cross_domain_release_change_calendar` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `CrossDomainReleaseChangeCalendarStateChangedEvent` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Cross-Domain Release Change Calendar` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `change_maintenance.cross_domain_release_change_calendar` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `CrossDomainReleaseChangeCalendarService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/04-oss-operations-assurance/change-maintenance-operations/v1/cross-domain-release-change-calendar` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `change_maintenance.cross_domain_release_change_calendar` columns and indexes; event replay tests validate `contracts/events/CrossDomainReleaseChangeCalendarStateChangedEvent.json` and `change_maintenance.event_outbox` ordering.

### DT-04-change-maintenance-operations-P02-T002: Build Cross-Domain Release Change Calendar workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar |
| Priority | P1 |
| Source evidence | [Cross-Domain Release Change Calendar](../features/cross-domain-release-change-calendar.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Cross-Domain Release Change Calendar |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/cross-domain-release-change-calendar/`, `tests/e2e/cross-domain-release-change-calendar.spec.ts`, Grafana panel `cross-domain-release-change-calendar`, and `docs/operations-runbook.md#cross-domain-release-change-calendar` |
| Dependencies | DT-04-change-maintenance-operations-P02-T001 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/cross-domain-release-change-calendar/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Release manager, Change manager, NOC engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows create or update, validate, close, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/change-maintenance-operations/cross-domain-release-change-calendar`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Cross-Domain Release Change Calendar` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `cross-domain-release-change-calendar` refreshes, then it shows the metric and links to `docs/operations-runbook.md#cross-domain-release-change-calendar`.

#### Definition Of Done

- `frontend/src/app/pages/cross-domain-release-change-calendar/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/cross-domain-release-change-calendar.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Cross-Domain Release Change Calendar` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Cross-Domain Release Change Calendar` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/cross-domain-release-change-calendar.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-04-change-maintenance-operations-P02-T003: Build Change Record API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar |
| Priority | P0 |
| Source evidence | [Change Record](../features/change-record.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Change Record |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossoperationsassurance/changemaintenanceoperations/ChangeRecordController.java`, `change_maintenance.change_record`, `contracts/events/ChangeRecordStateChangedEvent.json`, and `/api/04-oss-operations-assurance/change-maintenance-operations/v1/change-record` |
| Dependencies | DT-04-change-maintenance-operations-P02-T001 |
| Outputs | `ChangeRecordController`, `ChangeRecordService`, `change_maintenance.change_record` migration, `ChangeRecordStateChangedEvent` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/04-oss-operations-assurance/change-maintenance-operations/v1/change-record` using TMF629, TMF638, TMF639, TMF640, TMF655, TMF681, TMF696, TMF701, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Change Record` state in `change_maintenance.change_record` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `ChangeRecordStateChangedEvent` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: create or update, validate, close.
- Carry source details into code and tests for personas Change manager, Network operations lead, Release manager and objects Change object or control, Change record, Change type and category, Scope and affected entities; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/04-oss-operations-assurance/change-maintenance-operations/v1/change-record`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `change_maintenance.change_record.id`, and appends `ChangeRecordStateChangedEvent` to `change_maintenance.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/04-oss-operations-assurance/change-maintenance-operations/v1/change-record/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Change Record` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `change_maintenance.change_record` is required.

#### Definition Of Done

- `ChangeRecordController`, service, repository, DTOs, validation, error model, and migration for `change_maintenance.change_record` are committed under `ts-oss-ops-change-maintenance-operations`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/04-oss-operations-assurance/change-maintenance-operations/v1/change-record`, `change_maintenance.change_record`, and `ChangeRecordStateChangedEvent`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/04-oss-operations-assurance/change-maintenance-operations/v1/change-record` return `403` and write a denial audit row instead of exposing `Change Record` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `change_maintenance.change_record` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `ChangeRecordStateChangedEvent` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Change Record` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `change_maintenance.change_record` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `ChangeRecordService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/04-oss-operations-assurance/change-maintenance-operations/v1/change-record` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `change_maintenance.change_record` columns and indexes; event replay tests validate `contracts/events/ChangeRecordStateChangedEvent.json` and `change_maintenance.event_outbox` ordering.

### DT-04-change-maintenance-operations-P02-T004: Build Change Record workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar |
| Priority | P1 |
| Source evidence | [Change Record](../features/change-record.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Change Record |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/change-record/`, `tests/e2e/change-record.spec.ts`, Grafana panel `change-record`, and `docs/operations-runbook.md#change-record` |
| Dependencies | DT-04-change-maintenance-operations-P02-T003 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/change-record/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Change manager, Network operations lead, Release manager.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows create or update, validate, close, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/change-maintenance-operations/change-record`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Change Record` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `change-record` refreshes, then it shows the metric and links to `docs/operations-runbook.md#change-record`.

#### Definition Of Done

- `frontend/src/app/pages/change-record/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/change-record.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Change Record` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Change Record` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/change-record.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-04-change-maintenance-operations-P02-T005: Build Risk And Impact API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar |
| Priority | P0 |
| Source evidence | [Risk And Impact](../features/risk-and-impact.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Risk And Impact |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossoperationsassurance/changemaintenanceoperations/RiskAndImpactController.java`, `change_maintenance.risk_and_impact`, `contracts/events/RiskAndImpactStateChangedEvent.json`, and `/api/04-oss-operations-assurance/change-maintenance-operations/v1/risk-and-impact` |
| Dependencies | DT-04-change-maintenance-operations-P02-T003 |
| Outputs | `RiskAndImpactController`, `RiskAndImpactService`, `change_maintenance.risk_and_impact` migration, `RiskAndImpactStateChangedEvent` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/04-oss-operations-assurance/change-maintenance-operations/v1/risk-and-impact` using TMF629, TMF638, TMF639, TMF640, TMF655, TMF657, TMF681, TMF696, TMF701, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Risk And Impact` state in `change_maintenance.risk_and_impact` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `RiskAndImpactStateChangedEvent` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: create or update, validate, close.
- Carry source details into code and tests for personas Change manager, Network operations lead, Release manager and objects Risk object or control, Impact assessment, Risk score, Collision risk; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/04-oss-operations-assurance/change-maintenance-operations/v1/risk-and-impact`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `change_maintenance.risk_and_impact.id`, and appends `RiskAndImpactStateChangedEvent` to `change_maintenance.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/04-oss-operations-assurance/change-maintenance-operations/v1/risk-and-impact/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Risk And Impact` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `change_maintenance.risk_and_impact` is required.

#### Definition Of Done

- `RiskAndImpactController`, service, repository, DTOs, validation, error model, and migration for `change_maintenance.risk_and_impact` are committed under `ts-oss-ops-change-maintenance-operations`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/04-oss-operations-assurance/change-maintenance-operations/v1/risk-and-impact`, `change_maintenance.risk_and_impact`, and `RiskAndImpactStateChangedEvent`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/04-oss-operations-assurance/change-maintenance-operations/v1/risk-and-impact` return `403` and write a denial audit row instead of exposing `Risk And Impact` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `change_maintenance.risk_and_impact` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `RiskAndImpactStateChangedEvent` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Risk And Impact` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `change_maintenance.risk_and_impact` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `RiskAndImpactService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/04-oss-operations-assurance/change-maintenance-operations/v1/risk-and-impact` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `change_maintenance.risk_and_impact` columns and indexes; event replay tests validate `contracts/events/RiskAndImpactStateChangedEvent.json` and `change_maintenance.event_outbox` ordering.

### DT-04-change-maintenance-operations-P02-T006: Build Risk And Impact workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar |
| Priority | P1 |
| Source evidence | [Risk And Impact](../features/risk-and-impact.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Risk And Impact |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/risk-and-impact/`, `tests/e2e/risk-and-impact.spec.ts`, Grafana panel `risk-and-impact`, and `docs/operations-runbook.md#risk-and-impact` |
| Dependencies | DT-04-change-maintenance-operations-P02-T005 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/risk-and-impact/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Change manager, Network operations lead, Release manager.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows create or update, validate, close, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/change-maintenance-operations/risk-and-impact`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Risk And Impact` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `risk-and-impact` refreshes, then it shows the metric and links to `docs/operations-runbook.md#risk-and-impact`.

#### Definition Of Done

- `frontend/src/app/pages/risk-and-impact/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/risk-and-impact.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Risk And Impact` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Risk And Impact` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/risk-and-impact.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-04-change-maintenance-operations-P02-T007: Prove Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar release gate, replay, and handoff evidence

| Field | Value |
| --- | --- |
| Phase | P02 - Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar |
| Priority | P1 |
| Source evidence | [Cross-Domain Release Change Calendar](../features/cross-domain-release-change-calendar.md), [Change Record](../features/change-record.md), [Risk And Impact](../features/risk-and-impact.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../change-maintenance-operations.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Change Record Intake, Risk Assessment, And Cross-Domain Release Calendar |
| Build area | Test/Ops/Release/Event |
| Target artifact | `tests/release/change-record-intake-risk-assessment-and-cross-domain-release-calendar.spec.ts`, `docs/release-notes/change-record-intake-risk-assessment-and-cross-domain-release-calendar.md`, Grafana dashboard `change-record-intake-risk-assessment-and-cross-domain-release-calendar`, and replay fixtures |
| Dependencies | DT-04-change-maintenance-operations-P02-T002, DT-04-change-maintenance-operations-P02-T004, DT-04-change-maintenance-operations-P02-T006 |
| Outputs | Release-gate test, replay/reconciliation evidence, accessibility/security/performance reports, dashboard/runbook links, support handoff notes |
| Missing evidence | No |

#### Implementation Notes

- Create a release-gate checklist for `change-record-intake-risk-assessment-and-cross-domain-release-calendar` covering Cross-Domain Release Change Calendar, Change Record, Risk And Impact, with happy path, assisted path, negative path, edge cases, event replay, data reconciliation, security, accessibility, performance, and support evidence.
- Record producer and consumer acknowledgements for phase events, reconcile `change_maintenance.event_outbox`, and link replay fixtures and correlation IDs.
- Update `docs/operations-runbook.md`, `docs/release-notes/change-record-intake-risk-assessment-and-cross-domain-release-calendar.md`, and `development-task-tracker.md` with release evidence and unresolved blockers.

#### Acceptance Criteria

1. Given all tasks in `P02-change-record-intake-risk-assessment-and-cross-domain-release-calendar.md` are complete, when `tests/release/change-record-intake-risk-assessment-and-cross-domain-release-calendar.spec.ts` runs, then it returns exit code `0` and links evidence for UI, API, data, event, security, ops, and test gates.
2. Given a consumer rejects an event from `change-record-intake-risk-assessment-and-cross-domain-release-calendar`, when replay is triggered, then the replay fixture preserves `$.correlationId`, `$.eventId`, and consumer acknowledgement state.
3. Given release notes are generated, when support reviews `docs/release-notes/change-record-intake-risk-assessment-and-cross-domain-release-calendar.md`, then open blockers, rollback steps, runbook links, and ownership contacts are present.

#### Definition Of Done

- `tests/release/change-record-intake-risk-assessment-and-cross-domain-release-calendar.spec.ts`, replay fixtures, dashboard/runbook links, and release notes are committed.
- Accessibility, security, contract, migration, event replay, performance, and operational-readiness evidence is linked from the tracker.
- Open blockers have owner, due date, target increment, and rollback or removal criteria.

#### Negative Scenarios

- Do not mark the phase Done if event replay, reconciliation, accessibility, security, or downstream acknowledgement evidence is missing.
- Do not release `change-record-intake-risk-assessment-and-cross-domain-release-calendar` with unresolved cross-app writes, direct schema coupling, or stale source authority assumptions.
- Do not suppress failed release gates; record failures with owner, due date, and target increment.

#### Edge Cases

- Coordinated release gates may require downstream app windows; record scheduling, owner, and fallback route in release notes.
- Historical backfill, replay, bulk update, or migration repair runs must include preview, partial failure report, and rollback evidence.
- High-volume launch periods require dashboard thresholds, alert owners, queue back-pressure, and support escalation paths.

#### Test Expectations

- `tests/release/change-record-intake-risk-assessment-and-cross-domain-release-calendar.spec.ts`, `mvn test`, OpenAPI/event replay tests, Flyway checks, Playwright/Cypress E2E, accessibility, security, and k6/performance gates pass.
- `docker compose config`, clean-checkout smoke, `helm lint`, Kubernetes dry-run, dashboard JSON validation, and runbook link checks pass.
- Tracker evidence links command output, PRs, screenshots, replay payloads, dashboards, release notes, and support handoff notes.
