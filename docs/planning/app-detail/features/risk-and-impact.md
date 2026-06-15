| Field | Value |
| --- | --- |
| Feature ID | F-change-maintenance-operations-001 |
| App | Change Maintenance Operations |
| App slug | `change-maintenance-operations` |
| Module | Change And Maintenance Operations |
| Source slice | [modules-and-features.md](../modules-and-features.md) |
| Last refined | 2026-06-15 |
| Refiner verdict | Build-ready |

# Risk And Impact Feature Specification


Reviewed: 2026-06-06

Suite: OSS Operations And Assurance

App: [Change And Maintenance Operations App](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Feature area slug: `risk-and-impact`

## Feature Intent

Risk And Impact owns the change risk and impact assessment lifecycle using service criticality, customer impact, topology, unresolved incidents, SLA exposure, history, operational readiness, regulatory constraints, affected products/services/resources/customers/sites, and mitigation needs before approval and execution.

## Objects And Decision Rights

| Risk object or control | Decision owner | Required outcome |
| --- | --- | --- |
| Impact assessment | Network operations lead | Affected services, resources, customers, products, sites, orders, incidents, SLA, and regions are calculated with confidence. |
| Risk score | Change manager | Change risk is accepted, mitigated, escalated, or rejected with evidence and policy version. |
| Collision risk | Release manager | Overlapping releases, changes, maintenance, field work, freeze, and customer events are visible. |
| Mitigation plan | Service owner | Rollback, test, staffing, field, customer communication, and NOC monitoring mitigations are approved. |
| Regulatory or customer-critical impact | Compliance officer | Reportability, notice, legal hold, and protected customer handling are controlled. |

## Personas And Jobs To Be Done

| Persona | Job to be done | Operational outcome |
| --- | --- | --- |
| Change manager | Decide whether a change can proceed. | Approval is based on transparent risk, collision, and mitigation evidence. |
| Network operations lead | Assess operational readiness. | NOC, domain SME, field, and rollback readiness are known before execution. |
| Release manager | Coordinate cross-domain dependencies. | Release risks and schedule conflicts are visible on the calendar. |
| SLA manager | Identify SLA and enterprise exposure. | Customer commitments are considered before approval. |
| Compliance officer | Review regulatory and protected-service impact. | High-risk changes meet notice and reporting obligations. |

## Core Scenarios

- A router software upgrade affects protected enterprise services; risk assessment calculates customer/SLA impact, incident history, rollback readiness, and NOC staffing need.
- A change overlaps unresolved incident and planned field work; approval is blocked until collision is resolved.
- A low-risk standard change becomes high risk because topology shows single-homed service path.
- A maintenance change affects emergency services; compliance review and customer notification are mandatory.
- Inventory confidence is low; risk score shows degraded confidence and blocks automated approval.

## Workflow

1. **Trigger:** Change submission, schedule update, scope update, emergency request, CAB review, or collision check starts risk/impact assessment.
2. **Validation:** Risk validates inventory/topology freshness, service/customer scope, SLA/regulatory flags, incident/change history, field readiness, rollback/test evidence, and tenant boundary.
3. **Calculation:** Risk engine evaluates impact, criticality, complexity, collision, customer exposure, SLA risk, incident history, maintenance/freeze, operational readiness, and mitigation coverage.
4. **Decision:** Change manager or CAB accepts risk, requests mitigation, escalates exception, rejects change, or routes emergency approval.
5. **Publication:** Approved risk/impact updates change record, maintenance window, communication plan, NOC monitoring, SLA evidence, field readiness, and release calendar.
6. **Reassessment:** Scope, schedule, topology, incident, or customer changes trigger recalculation and preserve prior versions.

## Acceptance Criteria

1. Given a change has affected resource references, when risk assessment runs, then impact includes services, customers, products, sites, regions, SLA commitments, incidents, and topology confidence.
2. Given topology shows no redundancy, when risk score calculates, then risk severity increases and mitigation requires rollback, NOC monitoring, and service owner approval.
3. Given unresolved incidents affect the same service/resource, when assessment runs, then approval is blocked or escalated with incident commander visibility.
4. Given customer-critical or regulatory services are affected, when risk is calculated, then compliance and communications requirements are added to approval checklist.
5. Given a mitigation plan is incomplete, when CAB review starts, then change cannot be approved until rollback, validation, staffing, or communication gaps are addressed.
6. Given the change schedule moves, when reassessment runs, then collision, freeze, maintenance, and customer impact are recalculated and versioned.
7. Given inventory data is stale, when impact is requested, then assessment marks confidence degraded and creates data steward task.
8. Given risk exception is approved, when change proceeds, then exception reason, approver, expiry, compensating controls, and audit evidence are stored.

## Negative Scenarios

Negative scenarios for this feature include permission denial, missing source data, stale dependency state, policy failure, duplicate or replayed request, downstream timeout, reconciliation mismatch, and any feature-specific negative scenario additions listed in the suite gap-review closure addendum.

## Edge Cases

| Scenario | Required handling |
| --- | --- |
| Impact calculation overcounts customers | Deduplicate product/service/customer relationships and preserve calculation method. |
| Incomplete topology hides risk | Mark confidence degraded and block low-risk auto approval. |
| Risk exception used repeatedly | Escalate recurring exception to change manager and compliance review. |
| Emergency change cannot wait for full impact | Require minimum impact evidence, retrospective assessment, and incident link. |
| Partner/offnet resource | Store partner references and permitted evidence without mastering partner topology. |
| Late incident appears before execution | Trigger reassessment and execution gate review. |

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

Related TMF APIs: [TMF696 Risk Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement), [TMF638 Service Inventory](../../../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639 Resource Inventory](../../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory), [TMF655 Change Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF657 Service Quality Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF657_ServiceQualityManagement).

- TMF696 can represent risk items and assessment context; TMF638/TMF639 supply affected service/resource references.
- Risk events must include `changeRiskAssessmentRequested`, `changeImpactCalculated`, `changeRiskScoreChanged`, `riskMitigationRequired`, `riskExceptionApproved`, and `riskAssessmentRecalculated`.
- Extension API is required for topology blast-radius evidence, collision scoring, mitigation checklist, customer/SLA exposure, and readiness gate because TMF696 does not define full change-impact workflow.
- Data must store assessment version, inputs, topology snapshot, affected entities, score, policy version, mitigations, exceptions, approvals, confidence, and recalculation history.

## Integrations And Handoffs

- Inventory/Topology supplies topology and service/resource/customer relationships.
- NOC supplies incident/alarm history and consumes risk monitoring and maintenance suppression context.
- SLA, communications, field, activation, release calendar, compliance, and data platform consume risk/impact evidence.

## Test Approach

Test this feature with unit, API contract, event replay and idempotency, workflow, data reconciliation, security and permission, accessibility and localization, E2E journey, operational-readiness, and regression tests. Include the suite gap-review closure addendum scenarios as mandatory test cases when present.

## Non-Functional Requirements

- Impact calculation must handle large topology traversals and customer fan-out within CAB scheduling targets.
- Risk recalculation must be event-driven for scope, schedule, topology, incident, and SLA changes.
- Risk views must be explainable, accessible, localized, and role-aware.
- Assessment history must be reproducible for audit and post-change review.

## Security, Privacy, And Compliance

- Impact lists must enforce customer masking, protected-service controls, partner confidentiality, tenant isolation, legal hold, retention, and export controls.
- Risk exception, downgrade, auto-approval, and emergency bypass require approver, reason, compensating control, and immutable audit.
- Regulatory and customer-critical impacts must preserve evidence for outage, safety, and service-quality reporting.

## Observability And Operations

- Dashboards must show assessment queue, high-risk changes, degraded-confidence assessments, recurring exceptions, collision risks, mitigation gaps, and recalculation failures.
- Alerts must detect assessment failure, stale topology, unresolved incident overlap, missing mitigation, and emergency change without retrospective assessment.
- Runbooks must cover topology confidence failure, high-risk escalation, recurring risk exception, emergency minimum assessment, and impact export.

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

This refinement converts the feature review material for Risk And Impact into delivery slices that can become epics, stories, API contracts, migrations, and test cases. Treat Change And Maintenance Operations App as the owning application for this feature within Suite OSS Operations And Assurance and schema `change_maintenance`.

| Workstream | Build-ready delivery guidance |
| --- | --- |
| UX and workflow | Build the Risk And Impact workbench for authorized operational, product, compliance, and support personas. Include search or intake, guided validation, detail view, lifecycle timeline, decision panel, evidence drawer, exception queue, bulk or replay controls where relevant, saved filters, SLA/OLA aging, empty/error states, and role-aware masking. The UI must expose create, validate, approve, correct, close, and audit risk and impact state and block closure when required evidence, approval, reconciliation, or downstream acknowledgement is missing. |
| API and events | Implement command and query APIs around risk-and-impact using TMF696, TMF638, TMF639, TMF655, TMF657. Command APIs for Risk And Impact should cover create/initiate, validate, update, approve/reject, hold/release, retry, correct, cancel or compensate, and close where those states apply. Query APIs for Risk And Impact should cover search, detail, timeline, related entities, dependency status, work queue, metrics, and audit/evidence retrieval. Domain events for Risk And Impact should cover created, validated, blocked, approved, rejected, updated, exception raised, exception resolved, completed, corrected, and reconciliation failed where the lifecycle uses... Extension API is required for topology blast-radius evidence, collision scoring, mitigation checklist, customer/SLA exposure, and readiness gate because TMF696 does not define full change-impact workflow. Every command, query, and event must carry tenant/brand/market where applicable, actor, source channel, reason code, idempotency key, correlation ID, external reference, lifecycle state, and version metadata. |
| Data and controls | Persist risk and impact record inside `change_maintenance` with typed lifecycle, owner, status reason, timestamps, policy decision, source freshness, confidence, old/new value, evidence, and reconciliation fields. Change And Maintenance Operations App owns the app-local lifecycle and evidence records for Risk And Impact; consumers must use APIs, events, projections, workflow tasks, or certified data products. Keep TMF payloads, extension characteristics, imported evidence, and low-stability metadata in JSONB while promoting operationally searched lifecycle fields to typed columns. |
| Integration and handoff | Exchange not yet specified with Inventory/Topology supplies topology and service/resource/customer relationships., NOC supplies incident/alarm history and consumes risk monitoring and maintenance suppression context., SLA, communications, field, activation... only through APIs, events, workflow tasks, governed projections, adapters, evidence packages, or certified data products. Show source owner, freshness, confidence, dependency state, retry status, blocked consumer, and completion evidence so the app does not create shadow mastership or direct cross-schema coupling. |
| Security, privacy, and compliance | Enforce RBAC/ABAC, tenant and residency boundaries, least privilege, separation of duties, masking, purpose limitation, retention, legal hold, export control, manual override expiry, immutable audit, and evidence chain of custody for Risk And Impact. Sensitive customer, revenue, partner, security, network, credential, or regulatory evidence must be masked unless the persona has explicit operational purpose. |
| Tests and operations | Create unit, API contract, event replay/idempotency, workflow, integration, migration, data reconciliation, security/privacy, accessibility/localization, performance, dashboard, alert, and runbook tests for Risk And Impact. Cover happy path, assisted path, automated path, exception path, bulk/project path, stale or duplicate input, downstream outage, policy denial, manual override, and reconciliation mismatch. Use the existing review scope - change lifecycle, collision detection, risk and impact analysis, CAB approvals, execution evidence, rollback, and customer or partner communications. - as mandatory backlog and test evidence. |

Implementation notes:

- Treat Change And Maintenance Operations App as the lifecycle owner for risk and impact record; referenced data such as not yet specified must remain references, snapshots, projections, evidence packages, or consumer acknowledgements unless the source file explicitly gives this app mastership.
- Make TMF alignment visible in every story: use named TMF resources where they fit, document non-TMF extension APIs with OpenAPI, and keep extension payloads compatible with TMF-style identifiers, lifecycle state, related entities, pagination, errors, and event envelopes.
- Build UI and API behavior around decision evidence, not only CRUD: surface the permitted next actions, policy decision, state reason, owner, SLA/OLA timer, blocked dependency, retry or compensation path, and closure proof.
- Add development tasks for route/page/component work, command/query handlers, DTO validation, entity/repository/migration changes, outbox/event contracts, projection refresh, privacy/security checks, and operational dashboards.
- Definition-of-done evidence must show downstream consumers can use published state through APIs, events, projections, workflow tasks, or certified data products without direct database reads or manual spreadsheet reconciliation.

## Definition Of Done

1. Product owner validates risk scoring, impact calculation, mitigation, collision, emergency minimum assessment, and reassessment journeys.
2. Architecture owner validates TMF696/TMF638/TMF639/TMF655 usage, extension APIs, event contracts, and inventory/NOC/SLA boundaries.
3. QA owner covers stale topology, unresolved incident, single-homed path, customer-critical service, missing mitigation, risk exception, and late incident scenarios.
4. Operations owner validates risk dashboards, CAB queues, alerts, runbooks, and change gate evidence.
5. Data steward validates topology snapshot lineage, customer impact calculation, confidence, and retention class.
6. Compliance owner validates protected service handling, exception audit, legal hold, and regulatory evidence.


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
- Automated path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
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
