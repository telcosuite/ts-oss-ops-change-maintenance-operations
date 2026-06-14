# Change And Maintenance Operations App Feature Specifications

Reviewed: 2026-06-06

This folder defines the change-to-operate feature backlog for change records, maintenance windows, risk/impact, execution, communication, CAB, emergency change, collision detection, freeze controls, and post-change validation.

Parent app: [Change And Maintenance Operations App](../README.md)

## Feature Specification Index

| Feature specification | Change or maintenance object and outcome | Primary TMF alignment |
| --- | --- | --- |
| [Change Record](change-record.md) | Standard, normal, emergency, bulk, network, platform, configuration, software, product, and operational change lifecycle. | TMF655 |
| [Maintenance Window](maintenance-window.md) | Maintenance window lifecycle across geography, site, service, resource, customer, SLA, regulatory, freeze, blackout, field, and communication constraints. | TMF655, TMF681 |
| [Risk And Impact](risk-and-impact.md) | Risk and impact assessment using inventory/topology, service criticality, customers, SLA, incidents, history, readiness, and mitigation evidence. | TMF696, TMF638, TMF639 |
| [Change Execution](change-execution.md) | Implementation task, checkpoint, automation, activation, field, release, validation, rollback, monitoring, inventory, and assurance evidence lifecycle. | TMF655, TMF701, TMF640 |
| [Customer And Stakeholder Communication](customer-and-stakeholder-communication.md) | Customer, partner, NOC, care, enterprise, regulator, and internal communication plan and delivery evidence lifecycle. | TMF681, TMF629 |
| [Cross-Domain Release Change Calendar](cross-domain-release-change-calendar.md) | Operational calendar for network, IT, catalog, API, tenant configuration, partner, freeze, release, and customer-impacting changes. | TMF655, TMF681 |
| [CAB Emergency Change And Collision Detection](cab-emergency-change-and-collision-detection.md) | CAB approval, emergency change, topology collision, risk exception, rollback readiness, and expedited evidence lifecycle. | TMF655, TMF696, TMF638, TMF639 |
| [Maintenance Communication Validation And Freeze Control](maintenance-communication-validation-and-freeze-control.md) | Maintenance notice validation, post-change assurance validation, incident correlation, freeze window, blackout, and customer-impact closure lifecycle. | TMF655, TMF681, TMF642, TMF653 |

## Documentation Controls

- Change And Maintenance Operations owns change records, maintenance windows, impact assessments, approval history, change execution evidence, rollback state, freeze decisions, collision decisions, and change communication plans.
- Inventory And Topology remains master for resource, service, product, site, and topology references used for impact and collision checks.
- NOC And Assurance owns alarms, incidents, tickets, diagnostics, outage, restoration, and RCA evidence consumed before, during, and after change execution.
- Field Work owns work order execution; Fulfillment/Activation owns activation/configuration execution; Workflow/Automation owns reusable runtime; this app owns change approval, risk, communication, execution evidence, and closure controls.
- Customer And Party 360 owns customer/contact/consent references; this app owns maintenance communication plan and delivery evidence references.

## Delivery Expectations

- Each feature backlog item must define the change object lifecycle, decision owner, approval control, customer/SLA impact, TMF-aligned API/event behavior, extension API needs, ODA ownership boundary, private app-store evidence, and rollback/validation gates.
- Each acceptance test must cover planned maintenance, emergency change, CAB approval, collision detection, freeze override, customer notification, maintenance suppression, rollback, post-change validation, incident correlation, regulatory evidence, and cross-tenant masking where the scenario applies.

## Feature Detail Review Alignment (2026-06-14)

Source: [Suite Feature Detail Review](../../feature-detail-review.md) and [Critical Feature Review Enhancements](../modules-and-features.md#critical-feature-review-enhancements-2026-06-14).

The 2026-06-14 review upgrades this app feature set with required scope: change lifecycle, collision detection, risk and impact analysis, CAB approvals, execution evidence, rollback, and customer or partner communications.

Apply this scope when refining the feature specifications in this folder:

- Add or update epics, stories, UI workbenches, APIs, events, app-owned data fields, DDL gaps, test cases, observability, runbooks, and definition-of-done evidence for the review scope.
- Preserve the app data ownership boundary. Cross-app access must use APIs, events, workflow tasks, governed projections, or certified data products rather than direct database sharing.
- If this scope needs technology beyond Angular, Spring Boot, PostgreSQL, and PrimeNG, offer open-source options with pros, cons, and a recommendation before implementation.
