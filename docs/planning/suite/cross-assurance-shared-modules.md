# Cross-Assurance Shared Modules

## Purpose

Provide shared assurance capabilities used by NOC, incidents, tickets, performance, change, and field workflows: known errors, remediation knowledge, automation, command center views, shift handover, and war-room coordination.

## Primary Personas

- NOC engineer: uses known fixes and automation suggestions.
- Incident manager: coordinates war-room decisions, timeline, assignments, and communications.
- Service assurance engineer: captures root-cause learning and reusable diagnostics.
- Network operations lead: monitors operational health and shift handover.
- Automation engineer: governs safe remediation playbooks.

## Core Workflow

1. Capture known errors, root-cause patterns, troubleshooting guides, and remediation procedures.
2. Suggest fixes during alarm, incident, ticket, and service problem workflows.
3. Trigger automated diagnostics, checks, ticket creation, work orders, changes, or activation actions with safety controls.
4. Run command center views for major incidents, SLA risk, open changes, field remediation, and customer impact.
5. Capture decisions, handover notes, evidence, and post-incident learning.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Knowledge And Known Error | Maintain known errors, troubleshooting guides, root-cause patterns, remediation procedures, impact rules, suggested fixes, closure learnings, and reusable knowledge articles. | [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket), [TMF656](../../../references/tmforum-open-apis/openapi-specs/TMF656_ServiceProblemManagement) |
| Assurance Automation | Define remediation playbooks, event actions, approvals, rollback, escalation, diagnostics, configuration checks, capacity checks, ticket creation, work order creation, change creation, safety, success rate, and human override. | [TMF701](../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow), [TMF921](../../../references/tmforum-open-apis/openapi-specs/TMF921_Intent) |
| Operational Command Center | Provide executive and NOC views of health, customer impact, major incidents, SLA risk, open changes, and field remediation. Support war-room assignments, notes, decisions, timelines, communications, and shift handover. | [TMF724](../../../references/tmforum-open-apis/openapi-specs/TMF724_IncidentManagement), [TMF642](../../../references/tmforum-open-apis/openapi-specs/TMF642_AlarmManagement), [TMF621](../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket) |

## Data Ownership

Owns knowledge articles, known-error records, automation playbooks, command center sessions, shift handover notes, incident decisions, and operational evidence.

## First Release Scope

Deliver known-error library, manual playbooks, operational command center view, and shift handover. Add intent automation, AI recommendations, and closed-loop remediation after control and audit patterns are established.

