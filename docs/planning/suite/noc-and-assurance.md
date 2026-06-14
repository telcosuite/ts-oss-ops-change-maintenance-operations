# NOC And Assurance App

## Purpose

Provide the real-time operational cockpit for alarms, correlation, impact analysis, incidents, service problems, trouble tickets, diagnostics, remediation, and dispatch.

## Primary Personas

- NOC engineer: monitors alarms, impact, incidents, and remediation.
- Service assurance engineer: investigates service degradation and root cause.
- Incident manager: coordinates major incidents, timelines, escalation, and restoration.
- Support escalation user: links customer tickets to network/service problems.
- Field or vendor coordinator: receives dispatch and remediation work.

## Core Workflow

1. Ingest and normalize alarms from network, cloud, monitoring, activation, and partner systems.
2. Deduplicate, suppress, enrich, and correlate alarms.
3. Use inventory/topology to identify impacted services, customers, products, sites, and orders.
4. Create incident, service problem, trouble ticket, diagnostic test, work order, automation, or change.
5. Track remediation, evidence, customer communication, restoration, and post-incident learning.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Alarm Intake And Normalization | Ingest alarms, normalize severity/category/source/probable cause/resource/time, deduplicate, suppress, enrich, lifecycle-manage, and show real-time alarm views. | [TMF642](../../../references/tmforum-open-apis/openapi-specs/TMF642_AlarmManagement) |
| Correlation And Impact Analysis | Correlate alarms across resources, services, sites, regions, customers, orders, and incidents. Identify root-cause candidates and prioritize by severity, SLA, customer value, service criticality, and risk. | [TMF642](../../../references/tmforum-open-apis/openapi-specs/TMF642_AlarmManagement), [TMF638](../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639](../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory) |
| Incident Management | Manage incidents from alarms, monitoring, service problems, tickets, field reports, or manual action. Track severity, priority, ownership, bridge, timeline, restoration, and post-incident review. | [TMF724](../../../references/tmforum-open-apis/openapi-specs/TMF724_IncidentManagement) |
| Service Problem Management | Manage service-level problems affecting one or more services/customers. Link alarms, incidents, tickets, inventory, performance, and changes. Track root cause, workaround, fix, and closure. | [TMF656](../../../references/tmforum-open-apis/openapi-specs/TMF656_ServiceProblemManagement) |
| Trouble Ticket Management | Manage customer, partner, internal, and operational trouble tickets with categorization, priority, SLA, assignment, comments, attachments, resolution, and related products/services/resources. | [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket), [TMF681](../../../references/tmforum-open-apis/openapi-specs/TMF681_Communication), [TMF667](../../../references/tmforum-open-apis/openapi-specs/TMF667_Document) |
| Service Test And Diagnostics | Run on-demand, scheduled, pre-activation, post-activation, repair, SLA, line, CPE, connectivity, throughput, reachability, synthetic, and network diagnostics. Link tests to orders, tickets, incidents, changes, and repair closure. | [TMF653](../../../references/tmforum-open-apis/openapi-specs/TMF653_ServiceTestManagement), [TMF638](../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639](../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory), [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket), [TMF641](../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder) |
| Remediation And Dispatch | Recommend fixes, trigger automation, activation rollback, change rollback, field work, vendor escalation, approvals, evidence capture, and closure. | [TMF697](../../../references/tmforum-open-apis/openapi-specs/TMF697_Work_Order), [TMF701](../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow), [TMF640](../../../references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration) |

## Data Ownership

Owns alarm lifecycle, incident records, service problem records, trouble ticket operational state, diagnostic requests/results, remediation tasks, and NOC operational timelines.

## First Release Scope

Deliver alarm intake, correlation, incident, trouble ticket, service problem, service test hooks, and remediation work queues. Add advanced closed-loop automation and AI root-cause analysis after inventory/topology quality is dependable.

