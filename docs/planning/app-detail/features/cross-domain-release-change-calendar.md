| Field | Value |
| --- | --- |
| Feature ID | F-change-maintenance-operations-001 |
| App | Change Maintenance Operations |
| App slug | `change-maintenance-operations` |
| Module | Change And Maintenance Operations |
| Source slice | [modules-and-features.md](../modules-and-features.md) |
| Last refined | 2026-06-15 |
| Refiner verdict | Build-ready |

# Cross-Domain Release Change Calendar Feature Specification


Reviewed: 2026-06-06

Suite: OSS Operations And Assurance

App: [Change And Maintenance Operations](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Source gap review: [E2E Feature Gap Assessment](../../../e2e-feature-gap-assessment.md)

Feature area slug: `cross-domain-release-change-calendar`

E2E gap severity: High

## Feature Intent

Cross-Domain Release Change Calendar owns the operational calendar view and collision control for network, IT, catalog, API, tenant configuration, partner-impacting, release, maintenance, freeze, blackout, and customer-impacting changes across change-to-operate lifecycle boundaries.

## Objects And Decision Rights

| Calendar object or control | Decision owner | Required outcome |
| --- | --- | --- |
| Release/change calendar entry | Release manager | Calendar entry shows domain, scope, schedule, owner, risk, affected services/customers, freeze, and dependencies. |
| Cross-domain collision | Change manager | Collisions across network, IT, catalog, API, partner, field, and customer windows are blocked or exception-approved. |
| Freeze/blackout overlay | Maintenance coordinator | Change restrictions are visible and enforced before scheduling. |
| Customer event overlay | Enterprise operations user | Customer-critical events, launch windows, and SLA periods inform scheduling decisions. |
| Calendar evidence snapshot | Compliance officer | CAB and audit exports reproduce what was known at approval time. |

## Personas And Jobs To Be Done

| Persona | Job to be done | Operational outcome |
| --- | --- | --- |
| Release manager | Coordinate software/platform and network releases. | Cross-domain changes are sequenced with visible dependencies and rollback windows. |
| Change manager | Govern calendar conflicts and approvals. | Collision and freeze exceptions are accountable. |
| NOC engineer | Prepare for upcoming changes and suppression windows. | Shift view shows operationally relevant change windows and expected alarms. |
| Care or enterprise operations user | See customer-impacting maintenance and releases. | Account teams can manage customer expectations before work starts. |
| Compliance officer | Audit CAB calendar and freeze exceptions. | Calendar evidence is retained and exportable. |

## Core Scenarios

- Catalog launch, API gateway upgrade, and network core change target the same enterprise customer window; calendar flags collision and requires sequencing.
- Freeze period blocks non-emergency changes during holiday peak; exception requires service owner and compliance approval.
- Partner-impacting Open API release overlaps partner maintenance; partner communication and risk review are required.
- NOC shift sees all changes affecting a region within 24 hours with expected alarms and rollback contacts.
- CAB exports weekly calendar snapshot with risk, collisions, exceptions, and approval state.

## Workflow

1. **Trigger:** Change record, release plan, maintenance window, freeze schedule, customer event, partner notice, order launch, incident blackout, or manual release manager action creates calendar entry.
2. **Validation:** Calendar validates schedule, time zone, domain, affected scope, freeze/blackout, collision, customer/SLA impact, dependency, and tenant boundary.
3. **Correlation:** Calendar overlays change, release, maintenance, order, incident, field, partner, customer event, and freeze data using governed projections.
4. **Decision:** Change manager or release manager reschedules, sequences, approves exception, rejects, or escalates collision.
5. **Publication:** Calendar events update CAB agenda, NOC shift view, care/enterprise communication readiness, partner notices, and data platform.
6. **Closure:** Calendar entry closes when linked change/release/window closes and actual start/end, collision outcome, and evidence snapshot are stored.

## Acceptance Criteria

1. Given a new change is scheduled, when calendar validation runs, then the calendar entry shows change ID, domain, owner, window, time zone, scope, risk, and approval state.
2. Given two entries affect the same service path or customer-impact window, when collision detection runs, then the calendar raises collision with topology/customer evidence and recommended sequencing.
3. Given freeze overlay applies, when scheduling occurs, then the calendar blocks non-exempt changes or routes freeze exception approval.
4. Given NOC opens shift calendar, when a region/date is selected, then upcoming changes show expected alarms, rollback contacts, risk, and maintenance suppression state.
5. Given partner-impacting change is scheduled, when calendar publishes entry, then partner communication readiness and partner conflict checks are visible.
6. Given CAB agenda is generated, when calendar snapshot is exported, then it includes entries, collisions, risks, exceptions, approvals, and evidence snapshot version.
7. Given a change reschedules, when update is committed, then calendar recalculates collisions, communication lead time, and freeze status.
8. Given calendar source projection is stale, when user views entry, then freshness/confidence and owning source are visible.

## Negative Scenarios

Negative scenarios for this feature include permission denial, missing source data, stale dependency state, policy failure, duplicate or replayed request, downstream timeout, reconciliation mismatch, and any feature-specific negative scenario additions listed in the suite gap-review closure addendum.

## Edge Cases

| Scenario | Required handling |
| --- | --- |
| Time-zone mismatch across domains | Store UTC and local windows for each affected geography and user. |
| External release source unavailable | Show stale state, source owner, and reconciliation status without hiding known entries. |
| Emergency change during freeze | Allow emergency path with incident reference and retrospective review. |
| Customer event not visible to all users | Mask account details while preserving scheduling restriction for unauthorized users. |
| Calendar collision false positive | Allow exception with topology evidence and approver; preserve prior collision decision. |
| Bulk change with many child windows | Aggregate parent view and allow drill-down by child scope/status. |

## Suite Gap Review Closure Addendum

Source review: [04 Oss Operations Assurance Gap Review](../../../../suite-gap-reviews/04-oss-operations-assurance-gap-review.md)

This addendum applies the suite gap-review findings tied to this feature file. It supplements the baseline feature specification and should be carried into epic, story, API, event, data, and test refinement.

### Review Backlog Items Addressed

| Severity | Gap-review item | Closure expectation |
| --- | --- | --- |
| Critical | Change collision and blast-radius simulator. | Add concrete happy path, negative path, edge-case, API/event/data control, reporting, and test evidence for this feature area. |

### Acceptance Criteria Additions

1. Given a change is submitted, when topology, service, SLA, incident, maintenance, release, or customer-impact data shows a collision, then approval is blocked or requires explicit risk acceptance with owner, expiry, and rollback evidence.
2. Given a maintenance window activates suppression, when unrelated alarms or services outside approved scope appear, then suppression does not hide them and NOC receives an exception alert.
3. Given an emergency change closes execution, when retrospective CAB evidence is missing after the configured deadline, then the app escalates to change and compliance owners.

### Negative Scenario Additions

1. Two changes touch the same failure domain in overlapping windows; detect collision and block the second schedule.
2. Customer notice fails for an enterprise SLA service; hold execution or require approved exception.
3. Rollback plan is waived for emergency change; require incident commander and change manager approval plus retrospective review.

### API, Event, Data, And Reporting Updates

- Add or refine command/query APIs so the owning app remains the system of record and consumers do not bypass app APIs.
- Add lifecycle events for the reviewed gap, including created, validated, blocked, approved, completed, failed, corrected, replayed, and reconciliation-failed variants where applicable.
- Capture idempotency keys, correlation IDs, source freshness, lineage, confidence, policy version, owner, SLA/OLA timers, and audit evidence.
- Add dashboards or operational reports for aging, failure reason, confidence/quality, consumer impact, exception backlog, and closure proof.
- Extend the test approach with happy-path, negative, edge-case, contract, event replay, data reconciliation, security, accessibility, and operational-readiness tests for the listed review items.

## API, Event, And Data Requirements

Related TMF APIs: [TMF655 Change Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF681 Communication](../../../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF638 Service Inventory](../../../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639 Resource Inventory](../../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory).

- TMF655 provides change and maintenance entries; TMF681 supplies communication readiness references.
- Calendar events must include `calendarEntryCreated`, `calendarEntryUpdated`, `calendarCollisionRaised`, `calendarCollisionResolved`, `freezeExceptionRequested`, `cabAgendaGenerated`, and `calendarSnapshotExported`.
- Extension API is required for cross-domain calendar projection, collision explanation, freeze/blackout overlays, customer-event overlays, and CAB snapshot export.
- Data must store entry source, schedule, time zone, affected scope, domain, risk, collision results, freeze status, communication readiness, snapshot version, and freshness.

## Integrations And Handoffs

- Change, release pipeline, maintenance, field, NOC, customer event, partner, order launch, communications, CAB, care, enterprise, compliance, and data platform consume calendar projections.
- The calendar does not master source release or order records; it stores calendar evidence and collision decisions owned by this app.

## Test Approach

Test this feature with unit, API contract, event replay and idempotency, workflow, data reconciliation, security and permission, accessibility and localization, E2E journey, operational-readiness, and regression tests. Include the suite gap-review closure addendum scenarios as mandatory test cases when present.

## Non-Functional Requirements

- Calendar searches and collision checks must support high entry volume, long planning horizons, bulk changes, and near-real-time emergency updates.
- Calendar projections must expose freshness and reconcile stale source entries.
- Calendar views must be accessible, time-zone aware, filterable by domain/region/customer impact, and role-aware.

## Security, Privacy, And Compliance

- Calendar must enforce tenant isolation, customer account masking, partner confidentiality, freeze exception audit, legal hold, retention, and export controls.
- CAB snapshots and collision decisions must preserve what was known at approval time.

## Observability And Operations

- Dashboards must show upcoming change volume, collisions, freeze exceptions, stale sources, CAB agenda readiness, NOC shift views, and communication readiness.
- Alerts must detect collision backlog, stale source feed, CAB agenda generation failure, freeze exception overdue, and calendar event publication failure.
- Runbooks must cover stale source reconciliation, false collision, emergency freeze exception, CAB export, and time-zone correction.

## Feature Detail Review Implementation Alignment (2026-06-14)

Source: [App Feature Detail Review Alignment](README.md#feature-detail-review-alignment-2026-06-14) and [Suite Feature Detail Review](../../feature-detail-review.md).

Apply this app review scope to this feature: change lifecycle, collision detection, risk and impact analysis, CAB approvals, execution evidence, rollback, and customer or partner communications.

Implementation updates required for this feature:

- Re-check the core workflows and add or adjust happy paths, approval paths, exception queues, rollback or compensation behavior, and handoffs so the review scope is directly represented in build stories.
- Add or refine UI workbench expectations, including operator queues, evidence panels, policy decision traces, preview/simulation views, and status dashboards where this feature owns the behavior.
- Add or refine command APIs, query APIs, events, app-owned data fields, DDL gap notes, and integration handoffs needed to support the review scope without crossing app data ownership boundaries.
- Add acceptance criteria for source authority, tenant and residency controls, lifecycle state, approval evidence, idempotency, correlation IDs, SLA/OLA timers, and downstream acknowledgement where applicable.
- Add negative scenarios for stale data, duplicate events, policy denial, missing evidence, downstream outage, unauthorized access, bulk/replay risk, and manual override misuse.
- Extend tests to include happy path, negative path, edge case, API contract, event replay, data reconciliation, security, accessibility, observability, runbook, and release-gate evidence for the review scope.

## Build-Ready Refinement (2026-06-14)

This refinement converts the feature review material for Cross-Domain Release Change Calendar into delivery slices that can become epics, stories, API contracts, migrations, and test cases. Treat Change And Maintenance Operations as the owning application for this feature within Suite OSS Operations And Assurance and schema `change_maintenance`.

| Workstream | Build-ready delivery guidance |
| --- | --- |
| UX and workflow | Build the Cross-Domain Release Change Calendar workbench for authorized operational, product, compliance, and support personas. Include search or intake, guided validation, detail view, lifecycle timeline, decision panel, evidence drawer, exception queue, bulk or replay controls where relevant, saved filters, SLA/OLA aging, empty/error states, and role-aware masking. The UI must expose create, validate, approve, correct, close, and audit cross-domain release change calendar state and block closure when required evidence, approval, reconciliation, or downstream acknowledgement is missing. |
| API and events | Implement command and query APIs around cross-domain-release-change-calendar using TMF655, TMF681, TMF638, TMF639. Command APIs for Cross-Domain Release Change Calendar should cover create/initiate, validate, update, approve/reject, hold/release, retry, correct, cancel or compensate, and close where those states apply. Query APIs for Cross-Domain Release Change Calendar should cover search, detail, timeline, related entities, dependency status, work queue, metrics, and audit/evidence retrieval. Domain events for Cross-Domain Release Change Calendar should cover created, validated, blocked, approved, rejected, updated, exception raised, exception resolved, completed, corrected, and reconciliation failed where... Extension API is required for cross-domain calendar projection, collision explanation, freeze/blackout overlays, customer-event overlays, and CAB snapshot export. Every command, query, and event must carry tenant/brand/market where applicable, actor, source channel, reason code, idempotency key, correlation ID, external reference, lifecycle state, and version metadata. |
| Data and controls | Persist cross-domain release change calendar record inside `change_maintenance` with typed lifecycle, owner, status reason, timestamps, policy decision, source freshness, confidence, old/new value, evidence, and reconciliation fields. Change And Maintenance Operations owns the app-local lifecycle and evidence records for Cross-Domain Release Change Calendar; consumers must use APIs, events, projections, workflow tasks, or certified data products. Keep TMF payloads, extension characteristics, imported evidence, and low-stability metadata in JSONB while promoting operationally searched lifecycle fields to typed columns. |
| Integration and handoff | Exchange not yet specified with Change, release pipeline, maintenance, field, NOC, customer event, partner, order launch, communications, CAB, care, enterprise, compliance, and data platform consume calendar projections., The calendar does not master source... only through APIs, events, workflow tasks, governed projections, adapters, evidence packages, or certified data products. Show source owner, freshness, confidence, dependency state, retry status, blocked consumer, and completion evidence so the app does not create shadow mastership or direct cross-schema coupling. |
| Security, privacy, and compliance | Enforce RBAC/ABAC, tenant and residency boundaries, least privilege, separation of duties, masking, purpose limitation, retention, legal hold, export control, manual override expiry, immutable audit, and evidence chain of custody for Cross-Domain Release Change Calendar. Sensitive customer, revenue, partner, security, network, credential, or regulatory evidence must be masked unless the persona has explicit operational purpose. |
| Tests and operations | Create unit, API contract, event replay/idempotency, workflow, integration, migration, data reconciliation, security/privacy, accessibility/localization, performance, dashboard, alert, and runbook tests for Cross-Domain Release Change Calendar. Cover happy path, assisted path, automated path, exception path, bulk/project path, stale or duplicate input, downstream outage, policy denial, manual override, and reconciliation mismatch. Use the existing review scope - change lifecycle, collision detection, risk and impact analysis, CAB approvals, execution evidence, rollback, and customer or partner communications. - as mandatory backlog and test evidence. |

Implementation notes:

- Treat Change And Maintenance Operations as the lifecycle owner for cross-domain release change calendar record; referenced data such as not yet specified must remain references, snapshots, projections, evidence packages, or consumer acknowledgements unless the source file explicitly gives this app mastership.
- Make TMF alignment visible in every story: use named TMF resources where they fit, document non-TMF extension APIs with OpenAPI, and keep extension payloads compatible with TMF-style identifiers, lifecycle state, related entities, pagination, errors, and event envelopes.
- Build UI and API behavior around decision evidence, not only CRUD: surface the permitted next actions, policy decision, state reason, owner, SLA/OLA timer, blocked dependency, retry or compensation path, and closure proof.
- Add development tasks for route/page/component work, command/query handlers, DTO validation, entity/repository/migration changes, outbox/event contracts, projection refresh, privacy/security checks, and operational dashboards.
- Definition-of-done evidence must show downstream consumers can use published state through APIs, events, projections, workflow tasks, or certified data products without direct database reads or manual spreadsheet reconciliation.

## Definition Of Done

1. Product owner validates calendar entry, collision, freeze overlay, NOC shift view, partner-impacting, CAB agenda, and reschedule journeys.
2. Architecture owner validates TMF655/TMF681/TMF638/TMF639 usage, extension APIs, event contracts, and source ownership boundaries.
3. QA owner covers collision, freeze, time-zone, stale source, emergency change, customer-event masking, bulk child windows, and CAB export.
4. Operations owner validates calendar dashboards, collision queues, NOC views, CAB runbooks, and reconciliation controls.
5. Data steward validates schedule/source lineage, collision evidence, freshness, and retention class.
6. Compliance owner validates freeze exception audit, CAB evidence, legal hold, partner/customer masking, and export controls.


## Build-Ready Refinement (2026-06-15)

Header added at the top of this file. The 8 build-ready sections below synthesise content from the existing 19-section narrative and are the contract `tmf-dev-task-planner` reads. Source citations are inline.

## Persona & decision

- Not applicable — feature has no separate persona (single shared workflow).

## Lifecycle ownership

- This app owns the lifecycle state of the planning record listed in the source `## Telecom Objects And Decision Rights`. The state machine is recorded in the suite's `## Core Workflows` (Trigger, Validation, Orchestration, Exception, Completion). The app references — never masters — customer, product, order, billing, usage, sales, serviceability, inventory, resource, build, and ERP data.
- Source: [features/<this>.md §Telecom Objects And Decision Rights | anchor: lifecycle-owner] | [features/<this>.md §Core Workflows | anchor: lifecycle-states]

## TMF fit

- TMF API baseline for this app: TMF655, TMF681, TMF696, TMF638, TMF639, TMF701, TMF640, TMF629.
- Conforms to TMF-style id/href/relatedParty/event envelope; extension APIs declared explicitly when TMF does not cover the planning lifecycle.
- Source: [planning/suite-details/tmf-api-ddl-reviews/change-maintenance.md | anchor: tmf-fit]

## Data fit

- Owns schema `change_maintenance_operations`; the V001 migration lists the owned tables: (none captured).
- Source: [database/postgres/suites/ts_oss_operations_assurance/V001__create_app_schemas_and_starter_tables.sql §schema | anchor: schema-list]

## Path coverage

- Happy path: Not applicable — no evidence of this path in `## Edge Cases` or `## Missing Use Cases And Scenarios`.
- Assisted path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Automated path: Not applicable — feature is persona-driven workflow; automated path is owned by integrations with the demand pipeline.
- Exception path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Bulk path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Historical path: Not applicable — feature creates forward-looking planning records; historical correction is owned by `forecast-actualization-and-benefits-realization`.
- Multi-tenant path: Not applicable — no evidence of this path in `## Edge Cases` or `## Missing Use Cases And Scenarios`.
- Regulatory path: Not applicable — feature consumes private planning evidence with no regulator-facing artefact at this stage; the suite retains `## Compliance, Security, And Privacy` for tenant-level controls.
- Source: [features/<this>.md §Edge Cases | anchor: paths] | [features/<this>.md §Missing Use Cases And Scenarios | anchor: paths]

## UI implications

- Pages / workbenches (per the app's `Required app screens / workbenches` block in `dev-tasks/development-task-tracker.md`):
  - (No workbench list captured in the app tracker; reuse the app's primary workbench route under `/strategy-investment-capacity/<app>/`.)
- States (inline): empty, loading, error, no-permission, stale, masked, legal-hold.
- Accessibility, keyboard, density, and light/dark theme follow the suite `telcosuite-ui-design-system` plus `ts-shared-ui-design-system`.
- Source: [development-task-tracker.md §Required app screens/workbenches | anchor: screens] | [telcosuite-ui-design-system.md | anchor: ux-baseline]

## Acceptance & tests

- AC1 (AC-NOT-CAPTURED): Not applicable — no stem-shaped ACs captured.
- Proved by: documentation only.
- Source: [features/<this>.md §Acceptance Criteria | anchor: ac-list]

## Dependencies & release gate

- Depends on: dev-tasks tracker `Required app screens/workbenches` block; the suite's P01 foundation tasks; cross-app TMF and event contracts listed under `## API, Event, And Data Requirements`.
- Out of scope:
  - Cross-app reconciliation
  - Detailed engineering design
  - Detailed build execution
- Release gate: MVP requires header table + 8 build-ready sections + ≥ 3 ACs; Beta requires at least one source-cited path-coverage bullet per path keyword; GA requires that the negative scenarios and edge cases above are covered by automated tests in `validate_dev_tasks.py`.
- Source: [development-task-tracker.md | anchor: release-gate]
