# OSS Operations And Assurance Tech And UI Guidance

This document guides implementation of the OSS Operations And Assurance suite. It applies the shared [Technology Stack Guidance](../../technology-stack-guidance.md) and [TelcoSuite UI Design System](../../telcosuite-ui-design-system.md) to assurance, NOC, performance, SLA, change, maintenance, and shared operational command apps.

## Apps Covered

| App | Implementation focus |
| --- | --- |
| NOC And Assurance | Alarms, events, incidents, service problems, trouble tickets, diagnostics, and operational response |
| Performance, Quality, And SLA | Performance collection, thresholds, quality analytics, SLA evidence, breach tracking, and credit recommendations |
| Change And Maintenance Operations | Change records, maintenance windows, CAB, risk, collision detection, communications, and validation |
| Cross-Assurance Shared Modules | Command center, known error, knowledge, playbooks, remediation, and shared assurance action libraries |

## Recommended Build Order

1. NOC And Assurance.
2. Performance, Quality, And SLA.
3. Change And Maintenance Operations.
4. Cross-Assurance Shared Modules.

This order establishes core alarm, incident, ticket, and assurance workflows before performance/SLA evidence, change governance, and reusable command/playbook capabilities.

## Suite Technology Posture

Use Angular, Spring Boot, and PostgreSQL as the default implementation stack. PostgreSQL should own incidents, tickets, service problems, change records, maintenance windows, SLA evidence, playbooks, known errors, and operational action state according to each app boundary.

Assurance apps may need high-volume event ingestion, correlation, time-series performance storage, observability integrations, topology impact, workflow, or automation support. Do not add those technologies automatically. If the default stack is not sufficient, present open source options with pros and cons and ask for a decision.

## Suite UI Posture

The suite should feel like a calm command environment for high-pressure operations: dense queues, clear severity, strong filtering, fast triage, visible ownership, and drill-down from dashboards into operational records.

Use dashboard layouts for command center, service health, SLA health, and change risk views. Use compact workbenches for alarms, incidents, tickets, service problems, changes, maintenance windows, and remediation tasks.

## Shared Suite Components

| Shared pattern | Use across apps |
| --- | --- |
| Severity and impact badge | Alarm, incident, SLA breach, change risk, service impact, and customer impact |
| Assurance work queue | Alarm triage, incident ownership, ticket routing, change approval, and remediation tasks |
| Service health header | Service/resource/customer impact, SLA status, active incidents, and maintenance state |
| Operational timeline | Alarm, incident, diagnostic, ticket, change, maintenance, remediation, and communication events |
| Runbook/playbook panel | Suggested remediation, automation actions, approvals, evidence, and rollback steps |
| Maintenance window banner | Active/scheduled maintenance, freeze period, affected services, and communications |
| Command dashboard tile | Health, breach, queue, risk, response time, backlog, and trend indicators |

## Standard Page Templates

Use TelcoSuite page templates consistently:

- List and workbench for alarms, incidents, trouble tickets, service problems, SLA breaches, changes, maintenance windows, known errors, and remediation tasks.
- Record detail for incident, service problem, trouble ticket, SLA evidence, change, maintenance, known error, and playbook records.
- Dashboard for NOC command, assurance health, SLA health, performance quality, change risk, and maintenance calendar.
- Wizard or guided flow for incident escalation, change approval, maintenance setup, remediation execution, and post-incident review.
- Full-screen operational view for command center, wallboard, topology impact, and service health views.

## Data, API, And Integration Guidance

- Keep assurance, performance, SLA, change, maintenance, and remediation write models private to their owning apps.
- Use APIs and events for alarms, incidents, tickets, service problems, diagnostics, changes, SLA evidence, and customer/partner notifications.
- Consume inventory, topology, customer, product, agreement, order, and billing context through APIs, events, governed projections, or data products.
- Publish lifecycle events for alarm correlation, incident state, ticket state, service problem state, SLA evidence, change status, maintenance state, and remediation outcomes.
- Preserve auditability for operator actions, automation actions, approvals, overrides, communications, and regulatory evidence.

## Candidate Extra Technology Decision Areas

These categories may require a decision when implementation starts:

| Need | Why it may arise | Decision rule |
| --- | --- | --- |
| Event ingestion and streaming | High-volume alarms, telemetry, incidents, and operational events | Ask before adding a broker or streaming platform. |
| Time-series performance storage | Metrics, thresholds, quality, SLA, and trend analytics | Start with PostgreSQL where viable; ask before adding time-series storage. |
| Correlation and impact analysis | Alarm grouping, service impact, root-cause hints, and dependency traversal | Ask before adding graph, rules, or correlation engines. |
| Workflow and automation | Runbooks, remediation, approvals, rollback, and command actions | Prefer Spring-owned workflow first; ask before adding a workflow engine. |
| Observability integration | Metrics, traces, logs, synthetic checks, and operational telemetry | Evaluate open source observability options before adoption. |

## App Readiness Checklist

- Uses shared severity, service health, work queue, timeline, playbook, and command dashboard patterns.
- Defines app-owned assurance, performance, SLA, change, maintenance, and remediation write models.
- Provides compact triage workbenches with filtering, ownership, priority, SLA, and escalation controls.
- Supports wallboard/full-screen views only where operational command needs them.
- Records operator action, automation action, approval, override, communication, and evidence history.
- Supports responsive approvals, incident updates, maintenance reviews, and executive health checks.
- Documents any non-primary technology need with open source options, pros and cons, and a decision request.
