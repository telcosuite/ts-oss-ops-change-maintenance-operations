| Field | Value |
| --- | --- |
| Feature ID | F-change-maintenance-operations-001 |
| App | Change Maintenance Operations |
| App slug | `change-maintenance-operations` |
| Module | Change And Maintenance Operations |
| Source slice | [modules-and-features.md](../modules-and-features.md) |
| Last refined | 2026-06-15 |
| Refiner verdict | Build-ready |

# Change Execution Feature Specification


Reviewed: 2026-06-06

Suite: OSS Operations And Assurance

App: [Change And Maintenance Operations App](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Feature area slug: `change-execution`

## Feature Intent

Change Execution owns execution evidence for implementation tasks, owners, checkpoints, validation tests, rollback triggers, automation, activation/configuration, field work, release pipelines, monitoring, inventory feedback, assurance updates, and closure gates while execution engines remain owned by their domain apps.

## Objects And Decision Rights

| Execution object or control | Decision owner | Required outcome |
| --- | --- | --- |
| Execution task | Release manager | Step owner, planned time, actual time, state, dependency, evidence, and blocker are tracked. |
| Go/no-go checkpoint | Change manager | Execution proceeds, pauses, rolls back, or aborts using approved criteria. |
| Rollback trigger | Network operations lead | Rollback starts when KPI, alarm, diagnostic, customer impact, or implementation checkpoint threshold is met. |
| Post-change validation | NOC engineer | Alarm, diagnostic, service quality, field, activation, and inventory evidence confirm success. |
| Execution evidence | Compliance officer | Implementation, rollback, approval, validation, and customer impact evidence are retained. |

## Personas And Jobs To Be Done

| Persona | Job to be done | Operational outcome |
| --- | --- | --- |
| Release manager | Coordinate execution steps and dependencies. | Each step has owner, sequence, status, and evidence. |
| Change manager | Control go/no-go and closure gates. | Execution does not proceed without required approvals and checkpoints. |
| NOC engineer | Monitor alarms, performance, diagnostics, and rollback triggers. | NOC can react when execution creates customer impact. |
| SRE or automation engineer | Execute runbooks and release pipelines. | Automation outputs and rollback status are linked to the change. |
| Field dispatcher | Complete field-dependent implementation. | Field evidence and access status are visible to the change timeline. |

## Core Scenarios

- A network change starts and NOC monitoring sees unexpected alarms; execution pauses and rollback criteria are evaluated.
- Release pipeline step fails; change execution records pipeline evidence and blocks closure.
- Activation rollback completes after failed provisioning; execution links TMF640 evidence and incident update.
- Field work finishes late; maintenance window extension and customer communication update are required.
- Post-change diagnostics fail; change remains validation failed and creates remediation/incident action.

## Workflow

1. **Trigger:** Approved change reaches execution window, emergency change starts, release pipeline begins, field work starts, automation runbook starts, or manual checkpoint updates execution.
2. **Validation:** Execution validates approval state, active window, freeze exception, role rights, pre-checks, rollback readiness, monitoring readiness, and customer communication status.
3. **Execution:** Step owners update implementation tasks, automation/workflow/activation/field/release references, actual times, blockers, and evidence.
4. **Monitoring:** NOC and performance systems monitor alarms, quality, diagnostics, incident signals, and rollback triggers.
5. **Rollback or continue:** Change manager approves continue, pause, rollback, emergency extension, or abort using checkpoint evidence.
6. **Closure:** Execution closes after post-checks, tests, inventory/assurance feedback, communication completion, rollback state, and compliance evidence are complete.

## Acceptance Criteria

1. Given an approved change reaches its window, when execution starts, then execution state, step plan, owners, pre-check evidence, NOC monitoring, and rollback plan are visible.
2. Given a required pre-check fails, when execution start is attempted, then the change is blocked or exception-approved with reason, approver, and compensating control.
3. Given an automation runbook executes, when result returns, then execution records TMF701 process reference, runbook version, output, success/failure, and rollback status.
4. Given activation/configuration action executes, when result returns, then execution records TMF640 reference, command state, error, and validation evidence.
5. Given field work is required, when work order status changes, then execution timeline records TMF697 reference, field evidence, access blockers, and expected completion.
6. Given rollback trigger fires, when thresholds are breached, then execution pauses, notifies change manager/NOC, records trigger evidence, and starts rollback approval or execution.
7. Given post-change tests pass, when closure is requested, then execution links diagnostics, alarm status, service quality, customer communication, and inventory feedback.
8. Given post-change validation fails, when closure is requested, then closure is blocked and remediation, incident, or rollback action is created.

## Negative Scenarios

Negative scenarios for this feature include permission denial, missing source data, stale dependency state, policy failure, duplicate or replayed request, downstream timeout, reconciliation mismatch, and any feature-specific negative scenario additions listed in the suite gap-review closure addendum.

## Edge Cases

| Scenario | Required handling |
| --- | --- |
| Execution starts outside approved window | Block start or require emergency exception and customer/NOC visibility. |
| Pipeline reports success but NOC sees alarms | Keep validation pending and require NOC review before closure. |
| Rollback fails | Create incident/remediation, escalate commander, and preserve failed rollback evidence. |
| Step owner unavailable | Reassign with approval and preserve accountability history. |
| Partial success in bulk change | Track child outcomes, affected customers, rollback scope, and parent closure gates. |
| Event adapter outage | Allow manual evidence capture with replay reconciliation and audit. |

## Suite Gap Review Closure Addendum

Source review: [04 Oss Operations Assurance Gap Review](../../../../suite-gap-reviews/04-oss-operations-assurance-gap-review.md)

This addendum applies the suite gap-review findings tied to this feature file. It supplements the baseline feature specification and should be carried into epic, story, API, event, data, and test refinement.

### Review Backlog Items Addressed

| Severity | Gap-review item | Closure expectation |
| --- | --- | --- |
| High | Suppression safety controller for maintenance windows. | Add concrete happy path, negative path, edge-case, API/event/data control, reporting, and test evidence for this feature area. |

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

Related TMF APIs: [TMF655 Change Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF701 Process Flow](../../../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow), [TMF640 Activation Configuration](../../../../../references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration), [TMF697 Work Order](../../../../../references/tmforum-open-apis/openapi-specs/TMF697_Work_Order), [TMF653 Service Test Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF653_ServiceTestManagement).

- TMF655 covers change execution lifecycle references, TMF701 covers workflow/runbook execution, TMF640 covers activation/configuration action, and TMF697 covers field work handoff.
- Execution events must include `changeExecutionStarted`, `changeStepUpdated`, `changeCheckpointPassed`, `changeCheckpointFailed`, `changeRollbackTriggered`, `changeRollbackCompleted`, `changeValidationPassed`, `changeValidationFailed`, and `changeExecutionClosed`.
- Extension API is required for go/no-go gates, rollback trigger policy, execution evidence pack, manual evidence reconciliation, and bulk child execution status.
- Data must store step plan, actual times, owners, process/activation/work order references, checkpoint evidence, rollback evidence, monitoring evidence, validation results, and closure state.

## Integrations And Handoffs

- Workflow/Automation, Activation/Fulfillment, Field Work, release pipeline, NOC, Diagnostics, Performance/SLA, Inventory, Communications, and Data Platform provide or consume execution evidence.
- Change Execution stores change evidence and does not master workflow, activation, field, or inventory operational state.

## Test Approach

Test this feature with unit, API contract, event replay and idempotency, workflow, data reconciliation, security and permission, accessibility and localization, E2E journey, operational-readiness, and regression tests. Include the suite gap-review closure addendum scenarios as mandatory test cases when present.

## Non-Functional Requirements

- Execution state updates must be near-real-time during change windows and resilient to event adapter outages.
- Execution dashboards must support major release volume, bulk child changes, and emergency rollback visibility.
- Evidence capture must handle large logs, test results, field photos/documents, and long retention periods.
- Execution views must be accessible, time-zone aware, and optimized for bridge/war-room use.

## Security, Privacy, And Compliance

- Execution must enforce privileged command approval, tenant isolation, field/vendor data masking, legal hold, retention, and export controls.
- Go/no-go, rollback, force close, manual evidence, and validation override require reason, approver, and immutable audit.
- Customer/regulatory evidence must preserve actual start/end, impact, rollback, validation, and communication history.

## Observability And Operations

- Dashboards must show active changes, step status, blockers, rollback triggers, validation state, failed automation, field blockers, NOC alarms, and closure evidence gaps.
- Alerts must detect execution outside window, failed pre-check, rollback trigger, validation failure, step overdue, and event reconciliation gap.
- Runbooks must cover start block, manual evidence, rollback failure, validation failure, field delay, pipeline failure, and bulk partial completion.

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

This refinement converts the feature review material for Change Execution into delivery slices that can become epics, stories, API contracts, migrations, and test cases. Treat Change And Maintenance Operations App as the owning application for this feature within Suite OSS Operations And Assurance and schema `change_maintenance`.

| Workstream | Build-ready delivery guidance |
| --- | --- |
| UX and workflow | Build the Change Execution workbench for authorized operational, product, compliance, and support personas. Include search or intake, guided validation, detail view, lifecycle timeline, decision panel, evidence drawer, exception queue, bulk or replay controls where relevant, saved filters, SLA/OLA aging, empty/error states, and role-aware masking. The UI must expose create, validate, approve, correct, close, and audit change execution state and block closure when required evidence, approval, reconciliation, or downstream acknowledgement is missing. |
| API and events | Implement command and query APIs around change-execution using TMF655, TMF701, TMF640, TMF697, TMF653. Command APIs for Change Execution should cover create/initiate, validate, update, approve/reject, hold/release, retry, correct, cancel or compensate, and close where those states apply. Query APIs for Change Execution should cover search, detail, timeline, related entities, dependency status, work queue, metrics, and audit/evidence retrieval. Domain events for Change Execution should cover created, validated, blocked, approved, rejected, updated, exception raised, exception resolved, completed, corrected, and reconciliation failed where the lifecycle uses... Extension API is required for go/no-go gates, rollback trigger policy, execution evidence pack, manual evidence reconciliation, and bulk child execution status. Every command, query, and event must carry tenant/brand/market where applicable, actor, source channel, reason code, idempotency key, correlation ID, external reference, lifecycle state, and version metadata. |
| Data and controls | Persist change execution record inside `change_maintenance` with typed lifecycle, owner, status reason, timestamps, policy decision, source freshness, confidence, old/new value, evidence, and reconciliation fields. Change And Maintenance Operations App owns the app-local lifecycle and evidence records for Change Execution; consumers must use APIs, events, projections, workflow tasks, or certified data products. Keep TMF payloads, extension characteristics, imported evidence, and low-stability metadata in JSONB while promoting operationally searched lifecycle fields to typed columns. |
| Integration and handoff | Exchange not yet specified with Workflow/Automation, Activation/Fulfillment, Field Work, release pipeline, NOC, Diagnostics, Performance/SLA, Inventory, Communications, and Data Platform provide or consume execution evidence., Change Execution stores change... only through APIs, events, workflow tasks, governed projections, adapters, evidence packages, or certified data products. Show source owner, freshness, confidence, dependency state, retry status, blocked consumer, and completion evidence so the app does not create shadow mastership or direct cross-schema coupling. |
| Security, privacy, and compliance | Enforce RBAC/ABAC, tenant and residency boundaries, least privilege, separation of duties, masking, purpose limitation, retention, legal hold, export control, manual override expiry, immutable audit, and evidence chain of custody for Change Execution. Sensitive customer, revenue, partner, security, network, credential, or regulatory evidence must be masked unless the persona has explicit operational purpose. |
| Tests and operations | Create unit, API contract, event replay/idempotency, workflow, integration, migration, data reconciliation, security/privacy, accessibility/localization, performance, dashboard, alert, and runbook tests for Change Execution. Cover happy path, assisted path, automated path, exception path, bulk/project path, stale or duplicate input, downstream outage, policy denial, manual override, and reconciliation mismatch. Use the existing review scope - change lifecycle, collision detection, risk and impact analysis, CAB approvals, execution evidence, rollback, and customer or partner communications. - as mandatory backlog and test evidence. |

Implementation notes:

- Treat Change And Maintenance Operations App as the lifecycle owner for change execution record; referenced data such as not yet specified must remain references, snapshots, projections, evidence packages, or consumer acknowledgements unless the source file explicitly gives this app mastership.
- Make TMF alignment visible in every story: use named TMF resources where they fit, document non-TMF extension APIs with OpenAPI, and keep extension payloads compatible with TMF-style identifiers, lifecycle state, related entities, pagination, errors, and event envelopes.
- Build UI and API behavior around decision evidence, not only CRUD: surface the permitted next actions, policy decision, state reason, owner, SLA/OLA timer, blocked dependency, retry or compensation path, and closure proof.
- Add development tasks for route/page/component work, command/query handlers, DTO validation, entity/repository/migration changes, outbox/event contracts, projection refresh, privacy/security checks, and operational dashboards.
- Definition-of-done evidence must show downstream consumers can use published state through APIs, events, projections, workflow tasks, or certified data products without direct database reads or manual spreadsheet reconciliation.

## Definition Of Done

1. Product owner validates execution, automation, activation, field, rollback, validation, and closure journeys.
2. Architecture owner validates TMF655/TMF701/TMF640/TMF697/TMF653 usage, extension APIs, event contracts, and execution ownership boundaries.
3. QA owner covers pre-check failure, outside-window start, rollback trigger/failure, post-change alarms, field delay, pipeline failure, bulk partial success, and manual evidence.
4. Operations owner validates execution dashboards, NOC monitoring, runbooks, bridge views, and shift-handover evidence.
5. Data steward validates execution references, validation lineage, inventory feedback, and retention class.
6. Compliance owner validates privileged execution audit, legal hold, regulatory evidence, and customer-impact evidence.


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
- Historical path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Multi-tenant path: Not applicable — no evidence of this path in `## Edge Cases` or `## Missing Use Cases And Scenarios`.
- Regulatory path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
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
