# OSS Operations And Assurance Data Model

This document defines the suite-level data model for OSS Operations And Assurance. It translates the product-suite data mastery decisions into one PostgreSQL suite database with app-owned schemas and TMF-aligned entity ownership.

## Suite Database Layout

Physical database: `ts_oss_operations_assurance`

| App | Owning schema | Primary data role |
| --- | --- | --- |
| NOC And Assurance | `noc_assurance` | Alarms, incidents, trouble tickets, service problems, diagnostics, remediation tasks |
| Performance, Quality, And SLA | `performance_quality_sla` | Measurements, thresholds, quality scores, SLA evidence, breach records |
| Change And Maintenance Operations | `change_maintenance` | Change records, maintenance windows, impact, risk, communication plans |
| Cross-Assurance Shared Modules | `cross_assurance_shared` | Known errors, playbooks, command sessions, shared action libraries |

## Data Modeling Rules

- Separate raw external event input from normalized alarm, incident, problem, ticket, and SLA evidence records.
- NOC And Assurance owns operational ticket and incident state; Customer 360 owns customer care cases.
- Performance and SLA evidence must retain measurement source, time range, quality rule, agreement reference, and calculation version.
- Change records must preserve approval, risk, impact, maintenance, execution, rollback, and communication evidence.
- Operator actions, automation actions, overrides, and command center decisions require audit evidence.

## Entity Mastery Matrix

| Entity family | Master app | Owning schema | TMF API anchors | Main consumers | Data role |
| --- | --- | --- | --- | --- | --- |
| Alarm | NOC And Assurance | `noc_assurance` | TMF642 | Incident, service problem, assurance dashboards | Master normalized lifecycle |
| Alarm correlation and impact result | NOC And Assurance | `noc_assurance` | TMF642, TMF638, TMF639 | Incident, service health, command center | Master derived result |
| Operational incident | NOC And Assurance | `noc_assurance` | TMF724 | Care, self-care, SLA, command center | Master |
| Service problem | NOC And Assurance | `noc_assurance` | TMF656 | Known error, SLA, field, care | Master |
| Trouble ticket | NOC And Assurance | `noc_assurance` | TMF621 | Customer care, partner, self-care | Master operational ticket |
| Service test request/result | NOC And Assurance | `noc_assurance` | TMF653 | Activation, repair, SLA, self-care | Master diagnostic evidence |
| Remediation task | NOC And Assurance | `noc_assurance` | TMF697, TMF701, TMF640 | Field, fulfillment, workflow | Master assurance task |
| Performance measurement | Performance, Quality, And SLA | `performance_quality_sla` | TMF628 | Assurance, planning, SLA, reporting | Master normalized measurement |
| Performance threshold | Performance, Quality, And SLA | `performance_quality_sla` | TMF649 | Alarm, assurance, planning | Master rule |
| Service quality score/objective | Performance, Quality, And SLA | `performance_quality_sla` | TMF657 | SLA, care, self-care, reporting | Master quality result |
| SLA calculation and breach evidence | Performance, Quality, And SLA | `performance_quality_sla` | TMF657, TMF651, TMF621 | Billing, care, enterprise reporting | Master evidence |
| Quality analytics output | Performance, Quality, And SLA | `performance_quality_sla` | TMF628, TMF696 | Planning, optimization, reporting | Analytical output with lineage |
| Change record | Change And Maintenance Operations | `change_maintenance` | TMF655 | Inventory, NOC, field, customer comms | Master |
| Maintenance window | Change And Maintenance Operations | `change_maintenance` | TMF655, TMF681 | Order, care, self-care, partner, NOC | Master schedule |
| Change risk and impact assessment | Change And Maintenance Operations | `change_maintenance` | TMF696, TMF638, TMF639 | CAB, NOC, field, assurance | Master assessment |
| Change execution evidence | Change And Maintenance Operations | `change_maintenance` | TMF655, TMF701, TMF640 | NOC, audit, reporting | Master evidence |
| Change communication plan | Change And Maintenance Operations | `change_maintenance` | TMF681, TMF629 | Customer 360, self-care, partner | Master plan/reference |
| Known error and knowledge article | Cross-Assurance Shared Modules | `cross_assurance_shared` | TMF621, TMF656 | NOC, field, change, care | Master knowledge |
| Assurance automation playbook | Cross-Assurance Shared Modules | `cross_assurance_shared` | TMF701, TMF921 | NOC, workflow, automation | Master playbook |
| Operational command center session | Cross-Assurance Shared Modules | `cross_assurance_shared` | TMF724, TMF642, TMF621 | Executives, NOC, reporting | Master command record |

## Schema-Ready App Physical Design

Candidate table names are starter names for app migrations. Each app must validate exact TMF API version, resource, operation, and field paths against `references/tmforum-open-apis/openapi-specs/` before creating DDL.

| Owning schema | Starter table groups and candidate tables | Key and relationship rules | Controls and storage notes |
| --- | --- | --- | --- |
| `noc_assurance` | Fault and incident operations: `raw_event_ingestion`, `alarm`, `alarm_correlation`, `impact_result`, `operational_incident`, `service_problem`, `trouble_ticket`, `service_test_request`, `service_test_result`, `remediation_task`, `event_outbox` | Raw events stage by source/event ID before normalized alarms. Incidents, tickets, and problems reference service/resource inventory, customer/product snapshots, and change/maintenance IDs. | Partition raw event ingestion by source and time. Preserve correlation rule version, severity, impact, customer impact, and operator action audit. |
| `performance_quality_sla` | Measurements and SLA: `performance_measurement`, `performance_threshold`, `service_quality_score`, `service_quality_objective`, `sla_calculation`, `sla_breach_evidence`, `quality_analytics_output`, `event_outbox` | Measurements reference service/resource/customer/agreement IDs and period. SLA evidence references calculation rule, threshold, agreement term, and source measurements. | Time-series tables need partitioning and retention by metric family. SLA breach evidence must be immutable and replayable. |
| `change_maintenance` | Change and maintenance: `change_record`, `maintenance_window`, `change_risk_impact_assessment`, `change_execution_evidence`, `rollback_plan`, `change_communication_plan`, `event_outbox` | Change records reference affected service/resource topology, customers/products, tickets, work orders, and communication records. | Keep approval, CAB, risk, impact, rollback, execution, and customer/stakeholder communication evidence. |
| `cross_assurance_shared` | Shared operations: `known_error`, `knowledge_article`, `assurance_playbook`, `automation_action_template`, `operational_command_center_session`, `shift_handover_note`, `event_outbox` | Shared records reference incidents, problems, alarms, changes, playbook versions, workflow tasks, and automation runs. | Version playbooks and articles. Command center sessions require immutable timeline, decisions, actor, and audit evidence. |

## Consumed Cross-Suite Data

| Source suite/app | Consumed data | Storage rule |
| --- | --- | --- |
| OSS Engineering, Inventory, And Fulfillment | Inventory, topology, service/resource relationships, field state | Store impact projections and source references only |
| BSS Commercial | Customer, product, agreement, order, billing context | Store customer-impact snapshots and references |
| Strategy, Investment, And Capacity | Planned topology, build, capacity, geography | Store planning references for impact and trend analysis |
| Digital, Partner, And Ecosystem | Self-care tickets, partner tickets, notification context | Store submitted operational records and portal references |
| Enterprise Platform, Data, And Governance | Workflow, automation, policy, audit, observability, data products | Store references and local operational evidence |

## TMF Compliance Rules

- Use TMF642, TMF724, TMF656, TMF621, and TMF653 for alarms, incidents, service problems, tickets, and diagnostics.
- Use TMF628, TMF649, and TMF657 for performance, threshold, and service quality data.
- Use TMF651 references for SLA agreement terms and keep SLA evidence mastered here.
- Use TMF655 and TMF681 for change, maintenance, and communications.
- Use TMF701 and TMF921 for playbooks, workflow, automation, and intent records where applicable.

## Events And Projections

- Publish events for alarm changed, incident changed, ticket changed, service problem changed, service test completed, performance threshold breached, SLA evidence changed, change approved, maintenance scheduled, known error published, playbook changed, and command session closed.
- Each event must be registered with event name/version, event key, payload basis, outbox table, known consumers, replay retention, and masking controls before implementation.
- Customer, partner, and digital apps consume customer-impact projections, not raw operational tables.
- SLA and compliance projections must preserve source measurement, calculation rule, agreement reference, and evidence link.

## App-Level Data Model Checklist

- Raw event ingestion is separated from normalized operational state.
- Candidate tables, primary keys, alternate identifiers, cross-app reference fields, and migration owner must be recorded before creating migrations.
- Each app must maintain TMF conformance, event contract, and privacy/retention/audit registers for every table group.
- Severity, impact, SLA, customer impact, and service impact are consistently classified.
- Operator and automation actions are auditable and traceable.
- Customer-facing communications reference Customer 360 records without duplicating customer masters.
- Time-based evidence records include period, source, rule version, and calculation lineage.
