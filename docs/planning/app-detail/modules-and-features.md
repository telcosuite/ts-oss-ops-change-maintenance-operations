# Change And Maintenance Operations App Modules And Features

Reviewed: 2026-06-06

This document expands each app module into feature-level planning guidance. It should be used to create epics, stories, API contracts, event contracts, screens, permissions, and test cases.

Source overview: [change-maintenance-operations.md](../change-maintenance-operations.md)

## App-Level Feature Principles

- Every feature must have an owning module and an owning app API.
- UI actions must call app APIs rather than writing directly to shared data stores.
- Cross-app reads should use APIs, subscribed events, governed projections, or data products.
- Each module should expose enough lifecycle state for operations, audit, automation, and customer/partner visibility.
- Feature design must include happy path, exception path, audit path, and reporting path.

## App Data Ownership Context

Owns change records, maintenance windows, impact assessments, change execution evidence, rollback state, approval history, and change communication plans.

## First Release Context

Deliver change records, maintenance windows, approval workflow, impact view, and stakeholder communication. Add automated conflict detection, release pipeline integration, and change risk scoring later.

## Module 1: Change Record

Anchor: `change-record`

### Capability Intent

Create and manage standard, normal, emergency, and bulk changes. Track scope, risk, affected resources/services/customers, schedule, approvals, steps, validation, rollback, and closure.

### Primary Personas Supported

- Change manager: governs change lifecycle, approvals, conflicts, and risk.
- Network operations lead: reviews operational impact and readiness.
- Release manager: coordinates software and platform changes.
- NOC engineer: monitors execution and rollback triggers.
- Care/enterprise operations user: receives customer-impacting maintenance communication.

### Feature Backlog Candidates

- Create and manage standard.
- And bulk changes.
- Affected resources/services/customers.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for change record records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate change record changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for change record work. |
| API and event behavior | Expose command, query, and event contracts for change record so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Change Record | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate change record state available through APIs |
| Handle Change Record exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Change Record performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF655](../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 2: Maintenance Window

Anchor: `maintenance-window`

### Capability Intent

Plan windows by geography, site, service, resource, customer, SLA, regulatory constraint, freeze period, blackout, communications timeline, and field dependency. Detect conflicts.

### Primary Personas Supported

- Change manager: governs change lifecycle, approvals, conflicts, and risk.
- Network operations lead: reviews operational impact and readiness.
- Release manager: coordinates software and platform changes.
- NOC engineer: monitors execution and rollback triggers.
- Care/enterprise operations user: receives customer-impacting maintenance communication.

### Feature Backlog Candidates

- Plan windows by geography.
- Regulatory constraint.
- Freeze period.
- Communications timeline.
- And field dependency.
- Detect conflicts.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for maintenance window records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate maintenance window changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for maintenance window work. |
| API and event behavior | Expose command, query, and event contracts for maintenance window so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Maintenance Window | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate maintenance window state available through APIs |
| Handle Maintenance Window exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Maintenance Window performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF655](../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF681](../../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 3: Risk And Impact

Anchor: `risk-and-impact`

### Capability Intent

Assess risk using service criticality, customer impact, topology, history, unresolved incidents, operational readiness, affected products/services/resources/customers/sites, and mitigation needs.

### Primary Personas Supported

- Change manager: governs change lifecycle, approvals, conflicts, and risk.
- Network operations lead: reviews operational impact and readiness.
- Release manager: coordinates software and platform changes.
- NOC engineer: monitors execution and rollback triggers.
- Care/enterprise operations user: receives customer-impacting maintenance communication.

### Feature Backlog Candidates

- Assess risk using service criticality.
- Customer impact.
- Unresolved incidents.
- Operational readiness.
- Affected products/services/resources/customers/sites.
- And mitigation needs.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for risk and impact records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate risk and impact changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for risk and impact work. |
| API and event behavior | Expose command, query, and event contracts for risk and impact so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Risk And Impact | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate risk and impact state available through APIs |
| Handle Risk And Impact exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Risk And Impact performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF696](../../../../references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement), [TMF638](../../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639](../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 4: Change Execution

Anchor: `change-execution`

### Capability Intent

Track implementation tasks, owners, checkpoints, validation tests, rollback triggers, evidence, automation, activation, field work, release pipelines, monitoring, and inventory/assurance updates.

### Primary Personas Supported

- Change manager: governs change lifecycle, approvals, conflicts, and risk.
- Network operations lead: reviews operational impact and readiness.
- Release manager: coordinates software and platform changes.
- NOC engineer: monitors execution and rollback triggers.
- Care/enterprise operations user: receives customer-impacting maintenance communication.

### Feature Backlog Candidates

- Track implementation tasks.
- Validation tests.
- Rollback triggers.
- Release pipelines.
- And inventory/assurance updates.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for change execution records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate change execution changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for change execution work. |
| API and event behavior | Expose command, query, and event contracts for change execution so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Change Execution | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate change execution state available through APIs |
| Handle Change Execution exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Change Execution performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF655](../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF701](../../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow), [TMF640](../../../../references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 5: Customer And Stakeholder Communication

Anchor: `customer-and-stakeholder-communication`

### Capability Intent

Generate and track customer, partner, NOC, care, and internal communications before, during, and after maintenance or emergency work. Link messages to accounts, products, services, incidents, and changes.

### Primary Personas Supported

- Change manager: governs change lifecycle, approvals, conflicts, and risk.
- Network operations lead: reviews operational impact and readiness.
- Release manager: coordinates software and platform changes.
- NOC engineer: monitors execution and rollback triggers.
- Care/enterprise operations user: receives customer-impacting maintenance communication.

### Feature Backlog Candidates

- Generate and track customer.
- And internal communications before.
- And after maintenance or emergency work.
- Link messages to accounts.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for customer and stakeholder communication records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate customer and stakeholder communication changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for customer and stakeholder communication work. |
| API and event behavior | Expose command, query, and event contracts for customer and stakeholder communication so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Customer And Stakeholder Communication | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate customer and stakeholder communication state available through APIs |
| Handle Customer And Stakeholder Communication exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Customer And Stakeholder Communication performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF681](../../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF629](../../../../references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Critical Feature Review Enhancements (2026-06-14)

### Critical Assessment

The baseline modules are directionally correct, but change management needs stronger governance and operational safety. This app must manage change lifecycle, maintenance windows, collision detection, risk and impact analysis, CAB approvals, customer and stakeholder communications, execution evidence, validation, rollback, and post-change review.

### Enhancements To Add

- Add a change intake workbench for standard, normal, emergency, and expedited changes with scope, affected services/resources/customers, implementation plan, rollback plan, and evidence.
- Add maintenance window and freeze-period controls for scheduled windows, blackout periods, NOC coverage, field readiness, customer commitments, and communication deadlines.
- Add collision detection across incidents, other changes, maintenance windows, field work, order activations, SLA windows, topology dependencies, and freeze periods.
- Add risk and impact scoring with topology impact, customer impact, SLA exposure, rollback complexity, implementation confidence, and approval requirements.
- Add CAB and emergency approval workflows with conditions, waivers, segregation of duties, emergency justification, and audit evidence.
- Add execution and rollback tracking with step status, validation checks, failed step, rollback trigger, rollback execution, and completion evidence.

### Required Screens

- Change calendar with conflicts, freeze periods, approval state, affected services/customers, and execution readiness.
- Change detail workspace with scope, plan, risk, approvals, communications, execution timeline, rollback, and post-change review.
- Collision analysis view with conflicting operational objects, severity, owner, recommended adjustment, and waiver path.
- CAB board with approval aging, risk score, customer impact, approver, due date, conditions, and emergency changes.
- Execution console with step checklist, validation result, NOC monitoring, rollback trigger, communications, and completion evidence.

### Open-Source Decision Points

- Workflow: start with Spring/PostgreSQL workflow tables; ask before adding Flowable or Camunda Community.
- Calendar/scheduling: start with PrimeNG calendar/table; ask before adding external calendar integration.
- Risk rules: start with Spring/PostgreSQL rules; add Drools/Kogito only if business-owned rule authoring and audit require it.
- Evidence storage: keep metadata in PostgreSQL; ask before adding MinIO or other object storage for large evidence packs.

### API/Event/Data Additions

APIs should cover change create/classify, maintenance window reserve, collision check, risk assess, CAB approve/reject, execution start/update/complete, rollback trigger, and communication plan publish.

Events should include `ChangeCreated`, `ChangeRiskAssessed`, `ChangeApproved`, `MaintenanceWindowScheduled`, `ChangeCollisionDetected`, `ChangeExecutionStarted`, `ChangeRolledBack`, `ChangeCompleted`, and `MaintenanceCommunicationPublished`.

Change and maintenance state is mastered here; inventory, incidents, field work, orders, customer, and communication apps provide references or projections only.

### First Release Scope

Include change intake, maintenance calendar, collision detection, risk/impact board, CAB approval, execution evidence, rollback plan, and communication plan. Defer advanced release train planning and automated risk optimization.
