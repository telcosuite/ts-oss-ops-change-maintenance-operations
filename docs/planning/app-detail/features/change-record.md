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

## Build-Ready Refinement (2026-06-14)

This refinement converts the feature review material for Change Record into delivery slices that can become epics, stories, API contracts, migrations, and test cases. Treat Change And Maintenance Operations App as the owning application for this feature within Suite OSS Operations And Assurance and schema `change_maintenance`.

| Workstream | Build-ready delivery guidance |
| --- | --- |
| UX and workflow | Build the Change Record workbench for authorized operational, product, compliance, and support personas. Include search or intake, guided validation, detail view, lifecycle timeline, decision panel, evidence drawer, exception queue, bulk or replay controls where relevant, saved filters, SLA/OLA aging, empty/error states, and role-aware masking. The UI must expose create, validate, approve, correct, close, and audit change record state and block closure when required evidence, approval, reconciliation, or downstream acknowledgement is missing. |
| API and events | Implement command and query APIs around change-record using TMF655, TMF638, TMF639, TMF681. Command APIs for Change Record should cover create/initiate, validate, update, approve/reject, hold/release, retry, correct, cancel or compensate, and close where those states apply. Query APIs for Change Record should cover search, detail, timeline, related entities, dependency status, work queue, metrics, and audit/evidence retrieval. Domain events for Change Record should cover created, validated, blocked, approved, rejected, updated, exception raised, exception resolved, completed, corrected, and reconciliation failed where the lifecycle uses those... Extension API is required for template eligibility, rollback evidence, freeze exception, customer-impact classification, and retrospective emergency review because TMF655 does not define all operator controls. Every command, query, and event must carry tenant/brand/market where applicable, actor, source channel, reason code, idempotency key, correlation ID, external reference, lifecycle state, and version metadata. |
| Data and controls | Persist change record record inside `change_maintenance` with typed lifecycle, owner, status reason, timestamps, policy decision, source freshness, confidence, old/new value, evidence, and reconciliation fields. Change And Maintenance Operations App owns the app-local lifecycle and evidence records for Change Record; consumers must use APIs, events, projections, workflow tasks, or certified data products. Keep TMF payloads, extension characteristics, imported evidence, and low-stability metadata in JSONB while promoting operationally searched lifecycle fields to typed columns. |
| Integration and handoff | Exchange not yet specified with Inventory/Topology supplies affected resource/service/customer/site references; Change Record stores impact references and confidence., NOC consumes schedule, suppression, execution, rollback, and validation events and returns... only through APIs, events, workflow tasks, governed projections, adapters, evidence packages, or certified data products. Show source owner, freshness, confidence, dependency state, retry status, blocked consumer, and completion evidence so the app does not create shadow mastership or direct cross-schema coupling. |
| Security, privacy, and compliance | Enforce RBAC/ABAC, tenant and residency boundaries, least privilege, separation of duties, masking, purpose limitation, retention, legal hold, export control, manual override expiry, immutable audit, and evidence chain of custody for Change Record. Sensitive customer, revenue, partner, security, network, credential, or regulatory evidence must be masked unless the persona has explicit operational purpose. |
| Tests and operations | Create unit, API contract, event replay/idempotency, workflow, integration, migration, data reconciliation, security/privacy, accessibility/localization, performance, dashboard, alert, and runbook tests for Change Record. Cover happy path, assisted path, automated path, exception path, bulk/project path, stale or duplicate input, downstream outage, policy denial, manual override, and reconciliation mismatch. Use the existing review scope - change lifecycle, collision detection, risk and impact analysis, CAB approvals, execution evidence, rollback, and customer or partner communications. - as mandatory backlog and test evidence. |

Implementation notes:

- Treat Change And Maintenance Operations App as the lifecycle owner for change record record; referenced data such as not yet specified must remain references, snapshots, projections, evidence packages, or consumer acknowledgements unless the source file explicitly gives this app mastership.
- Make TMF alignment visible in every story: use named TMF resources where they fit, document non-TMF extension APIs with OpenAPI, and keep extension payloads compatible with TMF-style identifiers, lifecycle state, related entities, pagination, errors, and event envelopes.
- Build UI and API behavior around decision evidence, not only CRUD: surface the permitted next actions, policy decision, state reason, owner, SLA/OLA timer, blocked dependency, retry or compensation path, and closure proof.
- Add development tasks for route/page/component work, command/query handlers, DTO validation, entity/repository/migration changes, outbox/event contracts, projection refresh, privacy/security checks, and operational dashboards.
- Definition-of-done evidence must show downstream consumers can use published state through APIs, events, projections, workflow tasks, or certified data products without direct database reads or manual spreadsheet reconciliation.

## Definition Of Done

1. Product owner validates standard, normal, emergency, bulk, rollback, communication, and closure journeys.
2. Architecture owner validates TMF655 usage, extension APIs, event contracts, private change-store ownership, and handoffs to NOC, field, activation, and communications.
3. QA owner covers missing rollback, stale inventory, active incident overlap, freeze block, emergency retrospective, bulk partial failure, and cross-tenant scenarios.
4. Operations owner validates dashboards, approval queues, NOC event visibility, runbooks, and shift-handover evidence.
5. Data steward validates affected entity lineage, template versioning, risk data, and retention class.
6. Compliance owner validates audit, legal hold, emergency approval, customer notices, and regulatory evidence.
