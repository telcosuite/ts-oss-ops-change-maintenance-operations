# Change And Maintenance Operations App Personas And User Journeys

Reviewed: 2026-06-06

This document describes how different personas should experience the app and how the app should support real operational journeys. Use it when designing screens, workflow tasks, API commands, notifications, reporting, and permissions.

Source overview: [change-maintenance-operations.md](../change-maintenance-operations.md)

## Personas Covered

- Change manager: governs change lifecycle, approvals, conflicts, and risk.
- Network operations lead: reviews operational impact and readiness.
- Release manager: coordinates software and platform changes.
- NOC engineer: monitors execution and rollback triggers.
- Care/enterprise operations user: receives customer-impacting maintenance communication.

## Journey Design Principles

- Start journeys from real work triggers: customer contact, partner request, order fallout, alarm, planning threshold, approval queue, compliance event, API error, or scheduled operational review.
- Keep every journey API-backed so the same capability can be exposed through internal UI, self-care, partner portal, automation, or headless integration.
- Show users the source of truth, related projections, and confidence level where data is derived from another app.
- Design every journey with exception handling, audit evidence, notification, and downstream event behavior.
- Avoid making digital or reporting views accidental masters of BSS, OSS, revenue, inventory, or security records.

## Core Workflow Journey

| Step | User intent | App responsibilities | Output |
| ---: | --- | --- | --- |
| 1 | Create change record with scope, affected services/resources/customers, schedule, risk, and implementation plan. | App validates context, permissions, dependencies, and lifecycle state. | App-owned record, event, task, projection, or handoff is updated. |
| 2 | Plan maintenance windows and detect conflicts with orders, incidents, events, freeze periods, and other changes. | App validates context, permissions, dependencies, and lifecycle state. | App-owned record, event, task, projection, or handoff is updated. |
| 3 | Calculate risk and impact using inventory, topology, SLA, history, incidents, and readiness. | App validates context, permissions, dependencies, and lifecycle state. | App-owned record, event, task, projection, or handoff is updated. |
| 4 | Approve, execute, validate, and rollback changes. | App validates context, permissions, dependencies, and lifecycle state. | App-owned record, event, task, projection, or handoff is updated. |
| 5 | Communicate planned or emergency work to customers, partners, NOC, care, and internal teams. | App validates context, permissions, dependencies, and lifecycle state. | App-owned record, event, task, projection, or handoff is updated. |
| 6 | Update inventory, assurance, and post-change evidence. | App validates context, permissions, dependencies, and lifecycle state. | App-owned record, event, task, projection, or handoff is updated. |

## Persona Journeys

## Persona Journey 1: Change manager

Need: governs change lifecycle, approvals, conflicts, and risk.

Typical journey:

1. Opens the app from a work queue, customer/account context, operational dashboard, external notification, or direct search.
2. Reviews relevant records, relationships, history, policy flags, and open exceptions across modules such as Change Record, Maintenance Window, Risk And Impact, Change Execution.
3. Performs the required domain action through the owning app workflow, API-backed form, task, approval, or automation.
4. Handles validation errors, missing dependencies, policy exceptions, or fallout by assigning work, requesting correction, escalating, or creating a linked case/task.
5. Confirms the outcome, captures evidence, triggers notifications/events, and leaves downstream apps with a reliable status to consume.

Success measures:

- The persona can complete work without switching to hidden spreadsheets or direct database access.
- The app records who changed what, why, from which channel, and what downstream dependency was affected.
- The journey creates an API/event trail that supports operations, customer visibility, analytics, and audit.

## Persona Journey 2: Network operations lead

Need: reviews operational impact and readiness.

Typical journey:

1. Opens the app from a work queue, customer/account context, operational dashboard, external notification, or direct search.
2. Reviews relevant records, relationships, history, policy flags, and open exceptions across modules such as Change Record, Maintenance Window, Risk And Impact, Change Execution.
3. Performs the required domain action through the owning app workflow, API-backed form, task, approval, or automation.
4. Handles validation errors, missing dependencies, policy exceptions, or fallout by assigning work, requesting correction, escalating, or creating a linked case/task.
5. Confirms the outcome, captures evidence, triggers notifications/events, and leaves downstream apps with a reliable status to consume.

Success measures:

- The persona can complete work without switching to hidden spreadsheets or direct database access.
- The app records who changed what, why, from which channel, and what downstream dependency was affected.
- The journey creates an API/event trail that supports operations, customer visibility, analytics, and audit.

## Persona Journey 3: Release manager

Need: coordinates software and platform changes.

Typical journey:

1. Opens the app from a work queue, customer/account context, operational dashboard, external notification, or direct search.
2. Reviews relevant records, relationships, history, policy flags, and open exceptions across modules such as Change Record, Maintenance Window, Risk And Impact, Change Execution.
3. Performs the required domain action through the owning app workflow, API-backed form, task, approval, or automation.
4. Handles validation errors, missing dependencies, policy exceptions, or fallout by assigning work, requesting correction, escalating, or creating a linked case/task.
5. Confirms the outcome, captures evidence, triggers notifications/events, and leaves downstream apps with a reliable status to consume.

Success measures:

- The persona can complete work without switching to hidden spreadsheets or direct database access.
- The app records who changed what, why, from which channel, and what downstream dependency was affected.
- The journey creates an API/event trail that supports operations, customer visibility, analytics, and audit.

## Persona Journey 4: NOC engineer

Need: monitors execution and rollback triggers.

Typical journey:

1. Opens the app from a work queue, customer/account context, operational dashboard, external notification, or direct search.
2. Reviews relevant records, relationships, history, policy flags, and open exceptions across modules such as Change Record, Maintenance Window, Risk And Impact, Change Execution.
3. Performs the required domain action through the owning app workflow, API-backed form, task, approval, or automation.
4. Handles validation errors, missing dependencies, policy exceptions, or fallout by assigning work, requesting correction, escalating, or creating a linked case/task.
5. Confirms the outcome, captures evidence, triggers notifications/events, and leaves downstream apps with a reliable status to consume.

Success measures:

- The persona can complete work without switching to hidden spreadsheets or direct database access.
- The app records who changed what, why, from which channel, and what downstream dependency was affected.
- The journey creates an API/event trail that supports operations, customer visibility, analytics, and audit.

## Persona Journey 5: Care/enterprise operations user

Need: receives customer-impacting maintenance communication.

Typical journey:

1. Opens the app from a work queue, customer/account context, operational dashboard, external notification, or direct search.
2. Reviews relevant records, relationships, history, policy flags, and open exceptions across modules such as Change Record, Maintenance Window, Risk And Impact, Change Execution.
3. Performs the required domain action through the owning app workflow, API-backed form, task, approval, or automation.
4. Handles validation errors, missing dependencies, policy exceptions, or fallout by assigning work, requesting correction, escalating, or creating a linked case/task.
5. Confirms the outcome, captures evidence, triggers notifications/events, and leaves downstream apps with a reliable status to consume.

Success measures:

- The persona can complete work without switching to hidden spreadsheets or direct database access.
- The app records who changed what, why, from which channel, and what downstream dependency was affected.
- The journey creates an API/event trail that supports operations, customer visibility, analytics, and audit.


## Cross-Module Journeys

The app should support journeys that cross these modules: Change Record, Maintenance Window, Risk And Impact, Change Execution, Customer And Stakeholder Communication.

| Journey type | Description | Required app behavior |
| --- | --- | --- |
| Happy path completion | The user has valid context, required permissions, complete source data, and no blocking dependency. | Guide the user through the shortest path, validate silently where possible, publish events, and show clear completion state. |
| Exception and fallout | Data is missing, validation fails, downstream app is unavailable, or policy requires review. | Preserve the attempted action, create an actionable exception, assign ownership, support retry/resume, and notify affected journeys. |
| Assisted correction | A consumer detects wrong or stale master data. | Route correction to the owning module, capture evidence, prevent local shadow fixes, and publish corrected state. |
| Supervisor review | A lead needs aging, volume, SLA, fallout, risk, or productivity visibility. | Provide dashboards, saved filters, bulk assignment, escalation, and exportable evidence without exposing direct database access. |
| Compliance and audit | A compliance or audit user needs proof of policy adherence. | Show decision history, access history, before/after values, approvals, retention/legal hold status, and evidence links. |
| API consumer journey | Another app, partner, channel, or automation uses this app headlessly. | Provide documented APIs, events, idempotency, correlation IDs, clear error models, version compatibility, and conformance tests. |

## Screen And Task Implications

- Provide landing views by persona: personal work queue, operational dashboard, search, recent records, exceptions, and approvals.
- Provide record detail views with lifecycle state, relationships, timeline, evidence, comments, tasks, and related external references.
- Provide guided actions for create, update, approve, reject, cancel, suspend, resume, retry, handoff, export, and close where relevant.
- Provide role-aware views so sensitive customer, revenue, security, partner, and network data is masked or restricted by policy.
- Provide journey telemetry so product owners can see drop-off, rework, exception causes, automation success, and user effort.

## Journey Completion Definition

A journey is complete only when:

1. The owning app record reaches a valid lifecycle state.
2. Required events, notifications, and downstream handoffs are sent or queued.
3. Audit evidence is stored with actor, source, reason, and correlation ID.
4. Linked apps can consume the outcome through APIs, events, or governed projections.
5. Operational dashboards and reports can explain the status without direct database inspection.
