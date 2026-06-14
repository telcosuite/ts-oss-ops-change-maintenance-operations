# OSS Operations And Assurance Architecture Diagrams

Reviewed: 2026-06-14

## Purpose

Use these diagrams when building the OSS Operations And Assurance suite and its apps. They clarify how alarms, incidents, service problems, trouble tickets, performance, SLA, change, maintenance, knowledge, remediation, and command-center operations work together.

Primary sources:

- [Implementation File Usage Guide](implementation-file-usage-guide.md)
- [Tech And UI Guidance](tech-and-ui-guidance.md)
- [Data Model](data-model.md)
- [Journey Coverage](journey-coverage.md)
- App `implementation-file-usage.md`, `README.md`, `modules-and-features.md`, `personas-and-user-journeys.md`, and `features/` detail packs
- [TMF API To DDL Traceability Matrix](../tmf-api-to-ddl-traceability-matrix.md)
- `database/postgres/suites/ts_oss_operations_assurance/`

## Suite Architecture

```mermaid
flowchart LR
  subgraph Inputs["Operational Inputs"]
    Network["Network events, alarms, telemetry, probes, device and application signals"]
    Inventory["Inventory, topology, service/resource relationships, customer impact references"]
    Field["Field, fulfillment, activation, maintenance, and work-order evidence"]
    BSS["Customer, account, product order, care case, billing, SLA, and communication context"]
  end

  subgraph Suite["OSS Operations And Assurance Suite"]
    NOC["NOC And Assurance"]
    Perf["Performance, Quality, And SLA"]
    Change["Change And Maintenance Operations"]
    Shared["Cross-Assurance Shared Modules"]
  end

  subgraph APIs["Suite API And Event Contracts"]
    TMF["TMF APIs: TMF621, TMF628, TMF638, TMF639, TMF640, TMF642, TMF649, TMF651, TMF653, TMF655, TMF656, TMF657, TMF681, TMF697, TMF701, TMF724"]
    Extensions["Extension APIs for correlation, command center, remediation, maintenance risk, SLA evidence, and operational knowledge"]
    Events["Alarm, incident, problem, trouble ticket, test, diagnostic, performance, threshold, quality, SLA, change, maintenance, known-error, and remediation events"]
  end

  subgraph Data["ts_oss_operations_assurance"]
    NOCDB["noc_assurance schema"]
    PerfDB["performance_quality_sla schema"]
    ChangeDB["change_maintenance schema"]
    SharedDB["cross_assurance_shared schema"]
  end

  subgraph Consumers["Consumers And External Boundaries"]
    Fulfillment["Fulfillment, inventory, field, activation"]
    Care["Customer care, self-care, enterprise account teams"]
    Security["Security operations, compliance, lawful/regulatory response"]
    Platform["Workflow, API/eventing, data products, test, audit"]
    External["EMS/NMS, probes, observability tools, vendor systems"]
  end

  Network --> NOC
  Inventory --> NOC
  Network --> Perf
  Inventory --> Perf
  Field --> Change
  BSS --> NOC

  NOC --> Perf
  Perf --> NOC
  NOC --> Shared
  Change --> NOC
  Shared --> Change
  Change --> Field

  Suite --> TMF
  Suite --> Extensions
  Suite --> Events

  NOC --> NOCDB
  Perf --> PerfDB
  Change --> ChangeDB
  Shared --> SharedDB

  Events --> Fulfillment
  Events --> Care
  Events --> Security
  Events --> Platform
  External --> NOC
  External --> Perf
```

## Suite Build Flow

```mermaid
sequenceDiagram
  autonumber
  participant Network as Network/probe/event source
  participant NOC as NOC And Assurance
  participant Perf as Performance Quality SLA
  participant Shared as Cross-Assurance Shared
  participant Change as Change Maintenance
  participant Field as Field/Fulfillment
  participant Care as Care/Self-care
  participant Platform as Workflow, data, audit

  Network->>NOC: Ingest alarm, event, incident, diagnostic, or trouble signal
  NOC->>NOC: Normalize, correlate, assess impact, create incident/problem/ticket
  NOC->>Perf: Link quality, SLA, performance, and degradation evidence
  Perf-->>NOC: Return quality score, breach risk, chronic condition, or threshold breach
  NOC->>Shared: Request known-error, playbook, automation, or command-center support
  Shared-->>NOC: Return remediation plan or automated action
  NOC->>Change: Create preventive/emergency change or maintenance need
  Change->>Field: Request dispatch, maintenance, or execution support
  NOC-->>Care: Publish customer impact, ticket status, and restoration evidence
  NOC-->>Platform: Publish operational events, audit, metrics, and data products
```

## App Architecture: NOC And Assurance

```mermaid
flowchart LR
  Inputs["Alarms, events, incidents, diagnostics, service tests, inventory/topology, order/fulfillment state, customer impact, field evidence"]
  UI["NOC command console, alarm queue, correlation graph, incident/problem/ticket detail, diagnostic runner, remediation/dispatch board"]
  API["TMF642/TMF638/TMF639/TMF724/TMF656/TMF621/TMF681/TMF667/TMF653/TMF641/TMF697/TMF701/TMF640 APIs"]
  Domain["Alarm intake and normalization, correlation and impact analysis, incident management, service problem, trouble ticket, service test/diagnostics, remediation/dispatch"]
  Data["noc_assurance schema: alarms, events, correlations, incidents, service problems, trouble tickets, diagnostics, tests, impact evidence, event_outbox"]
  Consumers["Performance/SLA, change, field, fulfillment, care, self-care, security, data products"]
  Tests["Alarm ingestion, deduplication, correlation, impact, ticket lifecycle, diagnostic execution, customer impact masking, high-volume tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Performance, Quality, And SLA

```mermaid
flowchart LR
  Inputs["Resource, service, network, cloud, probe, device, app, customer, product, site, region, SLA, and incident measurements"]
  UI["Performance explorer, threshold editor, quality scorecard, SLA operations dashboard, enterprise review pack, chronic degradation analysis"]
  API["TMF628/TMF649/TMF642/TMF657/TMF651/TMF621/TMF696 APIs plus SLA evidence and analytics commands"]
  Domain["Performance collection, threshold and alerting, service quality, SLA and enterprise operations, quality analytics"]
  Data["performance_quality_sla schema: metrics, thresholds, alerts, quality measurements, SLA obligations, breach evidence, analytics snapshots, event_outbox"]
  Consumers["NOC, change, care, enterprise account teams, capacity planning, data products, regulatory reporting"]
  Tests["Metric ingestion, threshold, quality score, SLA breach, chronic fault, freshness, retention, performance-volume tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Change And Maintenance Operations

```mermaid
flowchart LR
  Inputs["Incident/problem remediation, capacity/design/build work, inventory/topology, field work, maintenance windows, customer/SLA impact, regulatory constraints"]
  UI["Change calendar, risk/impact workbench, maintenance window planner, execution checklist, rollback evidence, communication planner"]
  API["TMF655/TMF681/TMF696/TMF638/TMF639/TMF701/TMF640/TMF629 APIs plus risk, approval, execution, and rollback commands"]
  Domain["Change record, maintenance window, risk and impact, change execution, customer and stakeholder communication"]
  Data["change_maintenance schema: change records, maintenance windows, risk assessments, impacted services/customers, execution steps, rollback evidence, event_outbox"]
  Consumers["NOC, field, fulfillment, inventory, care, self-care, partner, security, data products"]
  Tests["Change approval, conflict, risk scoring, customer impact, emergency change, rollback, communication, audit and legal hold tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Cross-Assurance Shared Modules

```mermaid
flowchart LR
  Inputs["Incidents, problems, known errors, alarms, change history, performance trends, workflow tasks, remediation actions, command-center events"]
  UI["Known-error library, playbook editor, automation runbook, command-center board, major incident timeline, remediation analytics"]
  API["TMF621/TMF656/TMF701/TMF921/TMF724/TMF642 APIs plus playbook, automation, and command-center extension commands"]
  Domain["Knowledge and known error, assurance automation, operational command center, remediation coordination, shared playbooks"]
  Data["cross_assurance_shared schema: known errors, playbooks, automation runs, command-center incidents, remediation actions, shared evidence, event_outbox"]
  Consumers["NOC, performance, change, field, security, workflow automation, data products"]
  Tests["Known-error matching, playbook approval, automation guardrails, command-center escalation, remediation audit, replay and access tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## Build Use

Use these diagrams to keep assurance writes in the owning app: NOC owns alarms/incidents/problems/tickets, Performance owns measurements/quality/SLA, Change owns maintenance/change execution, and Cross-Assurance owns shared knowledge, playbooks, automation, and command-center state.
