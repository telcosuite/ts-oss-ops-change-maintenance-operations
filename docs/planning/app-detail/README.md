# Change And Maintenance Operations App Detail Pack

Reviewed: 2026-06-06

This folder expands the concise app overview into build-ready module, feature, persona, and user journey planning. The concise source overview remains at [change-maintenance-operations.md](../change-maintenance-operations.md).

Suite: OSS Operations And Assurance

## Build Intent

Manage network, platform, configuration, product, software, and operational changes from request through impact analysis, approval, execution, validation, rollback, and communication.

## Detail Documents

- [Modules And Features](modules-and-features.md)
- [Feature Specifications](features/README.md)
- [Personas And User Journeys](personas-and-user-journeys.md)

## Primary Personas

- Change manager: governs change lifecycle, approvals, conflicts, and risk.
- Network operations lead: reviews operational impact and readiness.
- Release manager: coordinates software and platform changes.
- NOC engineer: monitors execution and rollback triggers.
- Care/enterprise operations user: receives customer-impacting maintenance communication.

## Core Operating Flow

1. Create change record with scope, affected services/resources/customers, schedule, risk, and implementation plan.
2. Plan maintenance windows and detect conflicts with orders, incidents, events, freeze periods, and other changes.
3. Calculate risk and impact using inventory, topology, SLA, history, incidents, and readiness.
4. Approve, execute, validate, and rollback changes.
5. Communicate planned or emergency work to customers, partners, NOC, care, and internal teams.
6. Update inventory, assurance, and post-change evidence.

## Module Map

| Module | Feature focus | Related APIs |
| --- | --- | --- |
| Change Record | Create and manage standard, normal, emergency, and bulk changes | [TMF655](../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement) |
| Maintenance Window | Plan windows by geography, site, service, resource, customer, SLA, regulatory constraint, freeze period, blackout, communications timeline, and field dependency | [TMF655](../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF681](../../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication) |
| Risk And Impact | Assess risk using service criticality, customer impact, topology, history, unresolved incidents, operational readiness, affected products/services/resources/customers/sites, and mitigation needs. | [TMF696](../../../../references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement), [TMF638](../../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639](../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory) |
| Change Execution | Track implementation tasks, owners, checkpoints, validation tests, rollback triggers, evidence, automation, activation, field work, release pipelines, monitoring, and inventory/assurance updates. | [TMF655](../../../../references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement), [TMF701](../../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow), [TMF640](../../../../references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration) |
| Customer And Stakeholder Communication | Generate and track customer, partner, NOC, care, and internal communications before, during, and after maintenance or emergency work | [TMF681](../../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF629](../../../../references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement) |

## Data Ownership

Owns change records, maintenance windows, impact assessments, change execution evidence, rollback state, approval history, and change communication plans.

## First Release Scope

Deliver change records, maintenance windows, approval workflow, impact view, and stakeholder communication. Add automated conflict detection, release pipeline integration, and change risk scoring later.

## Build Notes

- Treat this app as an API-first product surface. UI screens, automations, partner access, and internal integrations should use the same app-owned APIs.
- Keep the app database private to this app or its module owners. Other apps should consume APIs, events, governed read models, or data products.
- Create backlog items at feature level, but preserve module ownership so roadmap, permissions, observability, and data stewardship remain clear.

## Implementation Guidance

- [Implementation File Usage](implementation-file-usage.md)
