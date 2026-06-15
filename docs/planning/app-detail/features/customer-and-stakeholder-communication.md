| Field | Value |
| --- | --- |
| Feature ID | F-change-maintenance-operations-001 |
| App | Change Maintenance Operations |
| App slug | `change-maintenance-operations` |
| Module | Change And Maintenance Operations |
| Source slice | [modules-and-features.md](../modules-and-features.md) |
| Last refined | 2026-06-15 |
| Refiner verdict | Build-ready |

# Customer And Stakeholder Communication Feature Specification



Reviewed: 2026-06-06

Suite: OSS Operations And Assurance

App: [Change And Maintenance Operations App](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Feature area slug: `customer-and-stakeholder-communication`

## Feature Intent

Customer And Stakeholder Communication owns the change communication plan, audience, approval, message version, delivery evidence, and closure controls for customers, partners, NOC, care, enterprise users, regulators, vendors, field teams, and internal stakeholders before, during, and after planned maintenance or emergency work.

## Objects And Decision Rights

| Communication object or control | Decision owner | Required outcome |
| --- | --- | --- |
| Communication plan | Communications manager | Audience, channels, timing, status wording, approvers, and delivery tracking are defined. |
| Customer-impact audience | Care or enterprise operations user | Affected customer/account/service/product references are approved for notice and care guidance. |
| Message approval | Change manager | Message content aligns to change scope, risk, planned impact, outage duration, and rollback posture. |
| Regulatory notice | Compliance officer | Required notice, reportability, retention, and legal hold are controlled. |
| Delivery evidence | Data steward | Communication attempts, failures, corrections, and references are traceable without mastering customer records. |

## Personas And Jobs To Be Done

| Persona | Job to be done | Operational outcome |
| --- | --- | --- |
| Communications manager | Generate and track stakeholder notices. | Planned and emergency work has approved wording and delivery evidence. |
| Change manager | Ensure communication readiness gates approval and execution. | Customer-impacting changes cannot proceed without required communication state. |
| Care or enterprise operations user | Prepare support teams and enterprise contacts. | Care guidance, enterprise status, and escalation contacts are consistent. |
| NOC engineer | Understand planned notices during execution. | NOC can distinguish expected customer impact from incident communications. |
| Compliance officer | Prove notice obligations. | Regulatory or contractual notice evidence is retained and exportable. |

## Core Scenarios

- A planned broadband maintenance requires customer email/SMS, care script, self-care banner, NOC shift note, and enterprise account notice.
- Emergency change starts before customer notice; communication plan records emergency reason, approved post-start notice, and retrospective evidence.
- Partner-impacting API change requires marketplace partner and internal support notices.
- Planned maintenance extends; communication plan issues updated ETR and delivery evidence.
- Communication sent to wrong audience; correction notice and compliance review are recorded.

## Workflow

1. **Trigger:** Change record, maintenance window, emergency change, release calendar, risk/impact result, freeze exception, or communication manager action creates plan.
2. **Validation:** Communication validates affected audience, customer/contact/consent references, channel eligibility, notice lead time, regulatory obligation, message approval, tenant boundary, and role masking.
3. **Approval:** Communications manager, change manager, service owner, enterprise owner, and compliance officer approve wording, audience, channels, and timing.
4. **Publication:** TMF681-aligned communication requests are sent to communication platform, care desktop, self-care, partner portal, NOC shift notes, enterprise channels, or regulator package.
5. **Exception:** Delivery failure, consent restriction, audience mismatch, missed notice, or message correction creates a communication exception queue.
6. **Closure:** Plan closes when delivery evidence, failed/skipped recipients, correction state, customer/care guidance, and regulatory evidence are complete.

## Acceptance Criteria

1. Given a change has customer impact, when communication plan is created, then audience, affected service/customer references, channel, message version, approver, and timing are stored.
2. Given customer consent or contact preference restricts a channel, when publication runs, then Customer 360 consent reference is honored and skipped/alternate channel evidence is recorded.
3. Given notice lead time is missed, when change approval is requested, then approval is blocked or exception-approved with reason, customer/care visibility, and compliance review.
4. Given communication is approved, when delivery is requested, then TMF681 communication reference, channel, delivery state, retry state, and message version are stored.
5. Given emergency change starts before notice, when communication plan is created, then emergency reason, incident/change reference, delayed notice approval, and retrospective customer evidence are required.
6. Given maintenance is extended or cancelled, when status changes, then updated notice or cancellation message is versioned and published to affected channels.
7. Given delivery fails for enterprise contacts, when retry expires, then enterprise service manager and communications manager receive exception with affected accounts.
8. Given regulatory evidence export is requested, when communication is complete, then notice time, audience, message version, delivery result, approver, and correction history are included.

## Negative Scenarios

Negative scenarios for this feature include permission denial, missing source data, stale dependency state, policy failure, duplicate or replayed request, downstream timeout, reconciliation mismatch, and any feature-specific negative scenario additions listed in the suite gap-review closure addendum.

## Edge Cases

| Scenario | Required handling |
| --- | --- |
| Wrong customer audience | Stop pending delivery where possible, issue correction, record affected contacts, and create compliance review. |
| Restricted customer or protected service | Mask identity and route through authorized enterprise or compliance owner. |
| Channel outage | Retry, switch approved alternate channel, and preserve delivery failure evidence. |
| Partner confidentiality | Expose only partner-permitted scope and use partner-specific message versions. |
| Change scope changes after notice | Recalculate audience and issue update/correction before execution where policy requires. |
| Legal hold on notice | Preserve message versions, delivery attempts, and approvals under hold. |

## Suite Gap Review Closure Addendum

Source review: [04 Oss Operations Assurance Gap Review](../../../../suite-gap-reviews/04-oss-operations-assurance-gap-review.md)

This addendum applies the suite gap-review findings tied to this feature file. It supplements the baseline feature specification and should be carried into epic, story, API, event, data, and test refinement.

### Review Backlog Items Addressed

| Severity | Gap-review item | Closure expectation |
| --- | --- | --- |
| Medium | Customer notice compliance and communication proof. | Add concrete happy path, negative path, edge-case, API/event/data control, reporting, and test evidence for this feature area. |

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

Related TMF APIs: [TMF681 Communication](../../../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF629 Customer Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement), [TMF655 Change Management](../../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement).

- TMF681 covers communication request and delivery references; Customer And Party 360 owns customer/contact/consent records through customer APIs.
- Communication events must include `changeCommunicationPlanCreated`, `changeCommunicationApproved`, `changeCommunicationRequested`, `changeCommunicationDelivered`, `changeCommunicationFailed`, `changeCommunicationCorrected`, and `changeCommunicationClosed`.
- Extension API is required for communication readiness gate, affected-audience snapshot, lead-time validation, customer-safe message versioning, and correction workflow.
- Data must store audience snapshot, message versions, approvers, consent/contact references, channel states, delivery evidence, correction history, and retention class.

## Integrations And Handoffs

- Change Record, Maintenance Window, Risk/Impact, CAB, Release Calendar, and Freeze Control provide scope and readiness triggers.
- Customer 360 supplies contact/consent references; Communications platform sends messages; NOC, care, self-care, partner, enterprise, regulatory, and data platform consume communication status.

## Test Approach

Test this feature with unit, API contract, event replay and idempotency, workflow, data reconciliation, security and permission, accessibility and localization, E2E journey, operational-readiness, and regression tests. Include the suite gap-review closure addendum scenarios as mandatory test cases when present.

## Non-Functional Requirements

- Communication publication must support large customer fan-out, channel retry, emergency notices, and status corrections within notice SLAs.
- Audience calculation and message approval must be reproducible for audit and report regeneration.
- Communication views must be accessible, localized, time-zone aware, and role-aware.

## Security, Privacy, And Compliance

- Communication plans must enforce consent, purpose limitation, tenant isolation, protected customer masking, legal hold, retention, and export controls.
- Message approval, missed notice exception, audience override, correction, and regulatory export require reason and immutable audit.

## Observability And Operations

- Dashboards must show communication plans, approval age, upcoming notices, missed lead time, delivery failures, correction notices, and regulatory evidence state.
- Alerts must detect missed notice, channel failure, delivery backlog, audience calculation failure, and correction approval overdue.
- Runbooks must cover missed notice, wrong audience, channel outage, emergency notice, extension/cancellation, and regulatory export.

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
- Assisted path: Not applicable — feature is persona-driven happy path; assisted path is owned by exception / approval features.
- Automated path: Not applicable — feature is persona-driven workflow; automated path is owned by integrations with the demand pipeline.
- Exception path: Not applicable — no evidence of this path in `## Edge Cases` or `## Missing Use Cases And Scenarios`.
- Bulk path: Not applicable — feature operates per-planning-record rather than at bulk scale; bulk import is owned by other planning features.
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
