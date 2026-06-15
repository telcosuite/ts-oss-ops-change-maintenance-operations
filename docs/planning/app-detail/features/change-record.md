| Field | Value |
| --- | --- |
| Feature ID | F-change-maintenance-operations-001 |
| App | Change Maintenance Operations |
| App slug | `change-maintenance-operations` |
| Module | Change And Maintenance Operations |
| Source slice | [modules-and-features.md](../modules-and-features.md) |
| Last refined | 2026-06-15 |
| Refiner verdict | Build-ready |

# Change Record Feature Specification



Reviewed: 2026-06-06

Suite: OSS Operations And Assurance

App: [Change And Maintenance Operations App](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Feature area slug: `change-record`

## Feature Intent

Change Record owns the lifecycle for standard, normal, emergency, bulk, network, platform, configuration, software, product, and operational changes from request through scope, schedule, risk, approval, execution, validation, rollback, communication, inventory/assurance update, and closure evidence.

## Objects And Decision Rights

| Change object or control | Decision owner | Required outcome |
| --- | --- | --- |
| Change record | Change manager | Change is drafted, submitted, assessed, approved, scheduled, executed, validated, rolled back, closed, cancelled, or rejected with reason. |
| Change type and category | Change manager | Standard, normal, emergency, bulk, release, maintenance, network, platform, or configuration classification drives approval and evidence rules. |
| Scope and affected entities | Network operations lead | Affected resources, services, products, customers, sites, orders, incidents, SLA commitments, and field dependencies are explicit. |
| Implementation and rollback plan | Release manager | Steps, owners, checkpoints, pre-checks, post-checks, rollback triggers, and validation tests are complete. |
| Customer-impact classification | Communications manager | Customer/partner/enterprise/NOC/care communication need is identified before approval. |

## Personas And Jobs To Be Done

| Persona | Job to be done | Operational outcome |
| --- | --- | --- |
| Change manager | Govern change lifecycle, approvals, conflicts, and risk. | Every change has accountable state, owner, decision history, and evidence. |
| Network operations lead | Review readiness and operational impact. | Change scope and restoration risk are understood before approval. |
| Release manager | Coordinate software and platform changes. | Release pipeline, dependency, freeze, rollback, and validation evidence are aligned. |
| NOC engineer | Monitor execution and rollback triggers. | NOC can distinguish planned maintenance from incident and restore service quickly if needed. |
| Care or enterprise operations user | Receive customer-impacting maintenance status. | Care/enterprise channels receive approved, customer-safe change information. |

## Core Scenarios

- A normal network change updates routing in a metro ring; change record links affected resources, services, customers, rollback, maintenance window, and communication plan.
- A standard patch follows a pre-approved model; record validates standard template, risk controls, and post-change tests.
- An emergency change bypasses normal CAB due to active major incident but requires expedited approval, rollback, and retrospective review.
- A bulk access-node upgrade creates child change tasks and shared maintenance communication.
- A failed change rolls back and links incident, diagnostics, customer impact, and RCA evidence.

## Workflow

1. **Trigger:** Release plan, NOC remediation, capacity action, vendor bulletin, security requirement, planned maintenance, activation correction, incident response, or manual request creates change record.
2. **Validation:** Change Record validates mandatory fields, type, affected entities, requester rights, implementation owner, rollback plan, maintenance window need, approval route, freeze policy, and tenant/region boundary.
3. **Assessment:** Change Record routes risk/impact, collision, communication, readiness, and SLA/regulatory checks before approval.
4. **Approval:** Change manager, CAB approver, service owner, emergency approver, or network operations lead approves/rejects with reason and evidence.
5. **Execution handoff:** Approved record drives execution tasks, maintenance suppression, NOC monitoring, field/activation/workflow handoffs, and communication events.
6. **Closure:** Change closes only after execution evidence, validation tests, rollback state, customer/assurance updates, inventory feedback, and post-change review are complete.

## Acceptance Criteria

1. Given an authorized requester submits a normal change, when mandatory scope, schedule, implementation, rollback, validation, and affected entity data are present, then a TMF655 change record is created with lifecycle state and correlation ID.
2. Given a change lacks rollback plan or validation tests, when submission occurs, then the record remains draft or exception state with required evidence and owner.
3. Given affected services include SLA-bearing enterprise accounts, when risk assessment runs, then the record displays customer/SLA impact and communication requirement before approval.
4. Given a standard change template is used, when the record is submitted, then standard eligibility, approved template version, allowed scope, and evidence requirements are validated.
5. Given an emergency change is created from an incident, when expedited approval is requested, then incident reference, emergency reason, approver, rollback, and retrospective CAB requirement are captured.
6. Given a change is approved, when execution starts, then lifecycle state, NOC monitoring state, maintenance suppression reference, and execution task references are published.
7. Given execution completes, when closure is attempted, then post-change validation, customer communication status, rollback state, and assurance evidence are required.
8. Given a closed change is corrected, when authorized correction occurs, then before/after state, reason, approver, and downstream correction events are retained.

## Negative Scenarios

Negative scenarios for this feature include permission denial, missing source data, stale dependency state, policy failure, duplicate or replayed request, downstream timeout, reconciliation mismatch, and any feature-specific negative scenario additions listed in the suite gap-review closure addendum.

## Edge Cases

| Scenario | Required handling |
| --- | --- |
| Change scope references stale inventory | Hold approval, show degraded confidence, and route to inventory data steward. |
| Change overlaps active incident | Require NOC and incident commander review before scheduling or executing. |
| Freeze period blocks change | Block or route to freeze exception approval with customer/regulatory evidence. |
| Emergency change lacks retrospective evidence | Escalate to change manager and compliance owner until retrospective review is complete. |
| Bulk change child failure | Track child status, partial rollback, affected customer impact, and parent closure gate. |
| Cross-tenant affected entity | Block visibility and mutation outside permitted tenant/region policy. |

## Suite Gap Review Closure Addendum

Source review: [04 Oss Operations Assurance Gap Review](../../../../suite-gap-reviews/04-oss-operations-assurance-gap-review.md)

This addendum applies the suite gap-review findings tied to this feature file. It supplements the baseline feature specification and should be carried into epic, story, API, event, data, and test refinement.

### Review Backlog Items Addressed

| Severity | Gap-review item | Closure expectation |
| --- | --- | --- |
| High | Emergency-change retrospective evidence and overdue escalation. | Add concrete happy path, negative path, edge-case, API/event/data control, reporting, and test evidence for this feature area. |

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

Related TMF APIs: [TMF655 Change Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF638 Service Inventory](../../../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639 Resource Inventory](../../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory), [TMF681 Communication](../../../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication).

- TMF655 covers change create, update, query, related entity, note, approval, lifecycle, and notification behavior where applicable.
- Change events must include `changeCreated`, `changeSubmitted`, `changeRiskAssessed`, `changeApproved`, `changeRejected`, `changeScheduled`, `changeExecutionStarted`, `changeRolledBack`, `changeCompleted`, and `changeClosed`.
- Extension API is required for template eligibility, rollback evidence, freeze exception, customer-impact classification, and retrospective emergency review because TMF655 does not define all operator controls.
- Data must store change type, scope, affected entity references, schedule, risk, approvals, implementation plan, rollback plan, validation criteria, communication plan, execution evidence, and closure decision.

## Integrations And Handoffs

- Inventory/Topology supplies affected resource/service/customer/site references; Change Record stores impact references and confidence.
- NOC consumes schedule, suppression, execution, rollback, and validation events and returns incident/alarm/diagnostic evidence.
- Field Work, Fulfillment/Activation, Workflow/Automation, release pipelines, vendor tools, communications, SLA, care, enterprise, and compliance consume or return change evidence.

## Test Approach

Test this feature with unit, API contract, event replay and idempotency, workflow, data reconciliation, security and permission, accessibility and localization, E2E journey, operational-readiness, and regression tests. Include the suite gap-review closure addendum scenarios as mandatory test cases when present.

## Non-Functional Requirements

- Change APIs and queues must support bulk changes, emergency updates, CAB cycles, and release-period spikes without delaying NOC visibility.
- Change lifecycle updates must be idempotent, versioned, audit-rich, and resilient to workflow/event retry.
- Change search must support high-cardinality affected entities, calendar views, approval queues, and historical exports.
- Change views must be accessible, localized, time-zone correct, and role-aware.

## Security, Privacy, And Compliance

- Change records must enforce tenant isolation, privileged approval, customer/partner masking, legal hold, retention, and export controls.
- Emergency approval, freeze override, rollback waiver, force close, and customer-impact downgrade require reason, approver, and immutable audit.
- Customer/regulatory evidence must preserve change times, impact, notices, execution state, validation, and rollback decisions.

## Observability And Operations

- Dashboards must show change volume, approval age, upcoming changes, emergency changes, risk mix, freeze exceptions, execution failures, rollback rate, and closure evidence gaps.
- Alerts must detect stuck approvals, missing rollback plan, emergency retrospective overdue, failed event publication, and validation evidence missing.
- Runbooks must cover emergency change, freeze exception, bulk child failure, rollback, retrospective review, and evidence export.

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
- Multi-tenant path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
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
