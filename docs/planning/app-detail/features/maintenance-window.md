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

## Build-Ready Refinement (2026-06-14)

This refinement converts the feature review material for Maintenance Window into delivery slices that can become epics, stories, API contracts, migrations, and test cases. Treat Change And Maintenance Operations App as the owning application for this feature within Suite OSS Operations And Assurance and schema `change_maintenance`.

| Workstream | Build-ready delivery guidance |
| --- | --- |
| UX and workflow | Build the Maintenance Window workbench for authorized operational, product, compliance, and support personas. Include search or intake, guided validation, detail view, lifecycle timeline, decision panel, evidence drawer, exception queue, bulk or replay controls where relevant, saved filters, SLA/OLA aging, empty/error states, and role-aware masking. The UI must expose create, validate, approve, correct, close, and audit maintenance window state and block closure when required evidence, approval, reconciliation, or downstream acknowledgement is missing. |
| API and events | Implement command and query APIs around maintenance-window using TMF655, TMF681, TMF638, TMF639. Command APIs for Maintenance Window should cover create/initiate, validate, update, approve/reject, hold/release, retry, correct, cancel or compensate, and close where those states apply. Query APIs for Maintenance Window should cover search, detail, timeline, related entities, dependency status, work queue, metrics, and audit/evidence retrieval. Domain events for Maintenance Window should cover created, validated, blocked, approved, rejected, updated, exception raised, exception resolved, completed, corrected, and reconciliation failed where the lifecycle uses... Extension API is required for freeze/blackout control, collision explanation, expected alarm classes, suppression context, notice lead-time validation, and extension approval. Every command, query, and event must carry tenant/brand/market where applicable, actor, source channel, reason code, idempotency key, correlation ID, external reference, lifecycle state, and version metadata. |
| Data and controls | Persist maintenance window record inside `change_maintenance` with typed lifecycle, owner, status reason, timestamps, policy decision, source freshness, confidence, old/new value, evidence, and reconciliation fields. Change And Maintenance Operations App owns the app-local lifecycle and evidence records for Maintenance Window; consumers must use APIs, events, projections, workflow tasks, or certified data products. Keep TMF payloads, extension characteristics, imported evidence, and low-stability metadata in JSONB while promoting operationally searched lifecycle fields to typed columns. |
| Integration and handoff | Exchange not yet specified with Change Record and Change Execution consume the window for scheduling and execution gating., NOC consumes suppression context and returns alarms/incidents/restoration validation evidence., Customer 360 supplies consent/contact... only through APIs, events, workflow tasks, governed projections, adapters, evidence packages, or certified data products. Show source owner, freshness, confidence, dependency state, retry status, blocked consumer, and completion evidence so the app does not create shadow mastership or direct cross-schema coupling. |
| Security, privacy, and compliance | Enforce RBAC/ABAC, tenant and residency boundaries, least privilege, separation of duties, masking, purpose limitation, retention, legal hold, export control, manual override expiry, immutable audit, and evidence chain of custody for Maintenance Window. Sensitive customer, revenue, partner, security, network, credential, or regulatory evidence must be masked unless the persona has explicit operational purpose. |
| Tests and operations | Create unit, API contract, event replay/idempotency, workflow, integration, migration, data reconciliation, security/privacy, accessibility/localization, performance, dashboard, alert, and runbook tests for Maintenance Window. Cover happy path, assisted path, automated path, exception path, bulk/project path, stale or duplicate input, downstream outage, policy denial, manual override, and reconciliation mismatch. Use the existing review scope - change lifecycle, collision detection, risk and impact analysis, CAB approvals, execution evidence, rollback, and customer or partner communications. - as mandatory backlog and test evidence. |

Implementation notes:

- Treat Change And Maintenance Operations App as the lifecycle owner for maintenance window record; referenced data such as not yet specified must remain references, snapshots, projections, evidence packages, or consumer acknowledgements unless the source file explicitly gives this app mastership.
- Make TMF alignment visible in every story: use named TMF resources where they fit, document non-TMF extension APIs with OpenAPI, and keep extension payloads compatible with TMF-style identifiers, lifecycle state, related entities, pagination, errors, and event envelopes.
- Build UI and API behavior around decision evidence, not only CRUD: surface the permitted next actions, policy decision, state reason, owner, SLA/OLA timer, blocked dependency, retry or compensation path, and closure proof.
- Add development tasks for route/page/component work, command/query handlers, DTO validation, entity/repository/migration changes, outbox/event contracts, projection refresh, privacy/security checks, and operational dashboards.
- Definition-of-done evidence must show downstream consumers can use published state through APIs, events, projections, workflow tasks, or certified data products without direct database reads or manual spreadsheet reconciliation.

## Definition Of Done

1. Product owner validates planned maintenance, conflict, freeze, notice, extension, suppression, cancellation, and validation journeys.
2. Architecture owner validates TMF655/TMF681 usage, extension APIs, event contracts, and boundaries with NOC, field, customer, and communication apps.
3. QA owner covers collision, freeze block, DST/time-zone, missed notice, incident overlap, extension, cancellation, and suppression bypass.
4. Operations owner validates calendar dashboards, NOC suppression handoff, alerts, runbooks, and shift-handover evidence.
5. Data steward validates affected entity lineage, schedule precision, notice evidence, and retention class.
6. Compliance owner validates planned outage notices, legal hold, freeze override audit, and regulatory export.
