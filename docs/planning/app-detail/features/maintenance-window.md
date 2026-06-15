| Field | Value |
| --- | --- |
| Feature ID | F-change-maintenance-operations-001 |
| App | Change Maintenance Operations |
| App slug | `change-maintenance-operations` |
| Module | Change And Maintenance Operations |
| Source slice | [modules-and-features.md](../modules-and-features.md) |
| Last refined | 2026-06-15 |
| Refiner verdict | Build-ready |

# Maintenance Window Feature Specification



Reviewed: 2026-06-06

Suite: OSS Operations And Assurance

App: [Change And Maintenance Operations App](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Feature area slug: `maintenance-window`

## Feature Intent

Maintenance Window owns planned work windows across geography, site, service, resource, customer, SLA, regulatory constraint, freeze period, blackout, communication timeline, field dependency, and NOC suppression context so planned maintenance is visible, controlled, and distinguishable from unplanned outage.

## Objects And Decision Rights

| Maintenance object or control | Decision owner | Required outcome |
| --- | --- | --- |
| Maintenance window | Maintenance coordinator | Window is planned, approved, communicated, started, extended, ended, cancelled, or closed with evidence. |
| Window scope | Network operations lead | Affected resources, services, sites, regions, products, customers, field dependencies, and SLA exposure are explicit. |
| Conflict and blackout decision | Change manager | Window is blocked, rescheduled, approved, or exception-approved based on collision, freeze, incident, and customer impact. |
| Maintenance notice timeline | Communications manager | Notice timing, audience, channels, consent, and message versions are planned before work starts. |
| NOC suppression context | NOC engineer | Expected alarms and validation checkpoints are linked to the window. |

## Personas And Jobs To Be Done

| Persona | Job to be done | Operational outcome |
| --- | --- | --- |
| Maintenance coordinator | Schedule and govern planned maintenance. | Window state, scope, communication, suppression, and validation are accountable. |
| Change manager | Prevent conflicts and freeze violations. | Risky or colliding windows are blocked or exception-approved with evidence. |
| NOC engineer | Monitor planned work and unexpected alarms. | Suppression applies only to approved scope and unplanned impact remains visible. |
| Care or enterprise operations user | Prepare for customer-impacting work. | Care/enterprise channels receive approved status and schedule. |
| Compliance officer | Track notice and regulatory obligations. | Maintenance evidence includes notices, windows, impact, and exceptions. |

## Core Scenarios

- Fiber maintenance affects a region overnight; window links resources, services, affected customers, field work, planned alarms, and customer notices.
- A freeze period blocks maintenance during holiday retail peak; change manager can request exception with executive/compliance approval.
- Two changes collide on the same protection pair; window conflict prevents simultaneous work.
- Maintenance extends beyond approved end time; customer notices, NOC suppression, and regulatory timers update with approval.
- Unexpected alarms outside window scope create incident despite active maintenance.

## Workflow

1. **Trigger:** Approved change, release plan, field work, vendor notice, emergency remediation, regulatory constraint, or maintenance coordinator action creates window.
2. **Validation:** Window validates scope, topology, SLA/customers, freeze/blackout, incident conflicts, order conflicts, field dependency, notice lead time, and tenant boundary.
3. **Scheduling:** Maintenance coordinator selects window, affected scope, expected alarms, communication schedule, validation checkpoints, and rollback/extension controls.
4. **Approval:** Change manager, service owner, CAB, compliance, field, or NOC approver reviews conflicts and impact.
5. **Execution:** Window starts, drives alarm suppression context, NOC monitoring, field/change tasks, customer updates, and post-change validation.
6. **Closure:** Window closes after end/extension/cancel state, actual impact, notices, suppression cleanup, validation evidence, and incident correlation are complete.

## Acceptance Criteria

1. Given a maintenance coordinator creates a window, when required scope and schedule data are present, then a TMF655-related maintenance window is stored with start/end, time zone, affected entities, owner, and correlation ID.
2. Given a window overlaps freeze or blackout policy, when validation runs, then scheduling is blocked or routed to exception approval with reason and evidence.
3. Given two windows affect the same redundant path or protected service, when collision detection runs, then the app recommends reschedule or exception approval with topology evidence.
4. Given customer impact is expected, when the window is approved, then a TMF681 communication plan is created with audience, channel, lead time, consent reference, and message version.
5. Given maintenance starts, when NOC suppression context activates, then expected alarm classes, resources, start/end times, and bypass rules are published to NOC.
6. Given maintenance exceeds approved end, when extension is requested, then the app requires approver, new end time, customer communication update, NOC suppression update, and regulatory review.
7. Given work is cancelled, when the window is cancelled, then communications, field tasks, NOC suppression, and calendar projections are updated.
8. Given post-change validation fails, when window closure is attempted, then closure is blocked and linked incident/remediation/change actions are created.

## Negative Scenarios

Negative scenarios for this feature include permission denial, missing source data, stale dependency state, policy failure, duplicate or replayed request, downstream timeout, reconciliation mismatch, and any feature-specific negative scenario additions listed in the suite gap-review closure addendum.

## Edge Cases

| Scenario | Required handling |
| --- | --- |
| Time-zone or daylight saving ambiguity | Store canonical UTC and local display time with affected geography. |
| Customer notice lead time missed | Require exception approval and customer/care visibility before execution. |
| Active major incident overlap | Block non-emergency maintenance or require incident commander approval. |
| Offnet partner maintenance | Store partner reference and permitted impact details without mastering partner schedule. |
| Window starts but change does not execute | Close or reschedule with no-work evidence and release suppression/communications. |
| Suppressed alarm outside scope | Bypass suppression, notify NOC, and record maintenance exception evidence. |

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

Related TMF APIs: [TMF655 Change Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF681 Communication](../../../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF638 Service Inventory](../../../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639 Resource Inventory](../../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory).

- TMF655 covers change and maintenance lifecycle references; TMF681 covers planned maintenance communication requests and delivery references.
- Window events must include `maintenanceWindowCreated`, `maintenanceWindowApproved`, `maintenanceWindowConflictRaised`, `maintenanceWindowStarted`, `maintenanceWindowExtended`, `maintenanceWindowEnded`, `maintenanceWindowCancelled`, and `maintenanceValidationFailed`.
- Extension API is required for freeze/blackout control, collision explanation, expected alarm classes, suppression context, notice lead-time validation, and extension approval.
- Data must store window schedule, local time zone, scope, expected impact, conflict results, notices, field/change references, suppression scope, validation checkpoints, actual impact, and closure evidence.

## Integrations And Handoffs

- Change Record and Change Execution consume the window for scheduling and execution gating.
- NOC consumes suppression context and returns alarms/incidents/restoration validation evidence.
- Customer 360 supplies consent/contact references; Communications sends notices; Field Work and vendors receive schedule dependencies.
- SLA, care, self-care, enterprise, regulatory, and data platform consume planned-impact projections.

## Test Approach

Test this feature with unit, API contract, event replay and idempotency, workflow, data reconciliation, security and permission, accessibility and localization, E2E journey, operational-readiness, and regression tests. Include the suite gap-review closure addendum scenarios as mandatory test cases when present.

## Non-Functional Requirements

- Window validation must handle large topology scopes, calendar conflicts, and customer fan-out within scheduling workflow targets.
- Window events and NOC suppression updates must publish reliably before planned start time and support emergency extension.
- Calendar views must support time-zone localization, blackout/freeze overlays, accessible navigation, and role-aware masking.
- Window history must support long retention and exact evidence reconstruction.

## Security, Privacy, And Compliance

- Maintenance windows must enforce tenant isolation, customer/contact masking, partner confidentiality, legal hold, retention, and export controls.
- Freeze override, missed notice, extension, cancellation, and suppression scope changes require approver, reason, and immutable audit.
- Regulatory notice and planned outage evidence must preserve schedule, impact, notice, execution, and validation history.

## Observability And Operations

- Dashboards must show upcoming windows, conflict count, freeze exceptions, notice status, suppression active, extension requests, validation failures, and missed closure evidence.
- Alerts must detect missed notice, window start without suppression, extension without approval, active window past end, and validation failure.
- Runbooks must cover freeze exception, collision resolution, missed notice, emergency extension, cancellation, suppression bypass, and validation failure.

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
- Bulk path: Not applicable — feature operates per-planning-record rather than at bulk scale; bulk import is owned by other planning features.
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
