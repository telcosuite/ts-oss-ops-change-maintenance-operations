# Technology Stack Guidance

This document defines the default technology choices for building the telecom product suite and the decision process for any technology outside the primary stack.

The guiding rule is simple: **use open source technology only, and use the primary stack unless there is a clear reason not to.**

The primary stack is a default, not a constraint to force-fit every problem. Always evaluate what the capability actually needs. If Angular, Spring Boot, or PostgreSQL would create an awkward, fragile, inefficient, or hard-to-operate solution, recommend a better open source technology stack with pros and cons, then ask for a decision before implementation.

## Primary Technology Stack

Use this stack as the default for application implementation:

| Layer | Primary choice | Role in the product suite |
| --- | --- | --- |
| Front end | Angular | Web applications, operational consoles, workflow screens, dashboards, and admin experiences |
| Backend | Java Spring Boot | TM Forum API services, domain services, orchestration APIs, integration endpoints, and business logic |
| Database | PostgreSQL | Operational relational data, authoritative application data, transactional storage, and governed read models where relational storage fits |

These choices are the default build path. A team should not introduce another front-end framework, backend runtime, programming language, or operational database unless the extension decision process below is followed.

## Open Source Policy

All selected technology must be open source.

| Rule | Guidance |
| --- | --- |
| License | Prefer OSI-approved permissive licenses such as Apache-2.0, MIT, BSD, PostgreSQL, EPL, or MPL. |
| Copyleft review | GPL, LGPL, and AGPL products require explicit architecture and legal review before use. |
| Non-open-source licenses | SSPL-like, source-available, commercial-only, or proprietary licenses are not allowed for core product dependencies. |
| Dual-license products | Use only the open source license path. If the needed capability requires a commercial license, treat it as not allowed. |
| Self-hosting | The product must be able to run without depending on a proprietary managed service as the only implementation option. |
| Vendor lock-in | Managed services may be deployment options, but the application architecture must not require closed vendor-only APIs for core behavior. |
| Source availability | "Source available" is not enough. The license and operational model must allow normal product development, deployment, modification, and redistribution needs. |

When license terms are unclear, do not adopt the technology until the license is verified and recorded.

## Default Decision Rules

Use these rules during architecture, backlog refinement, implementation, and code review:

1. Start with Angular, Spring Boot, and PostgreSQL.
2. Validate that the primary stack is a good fit for the requirement before committing to an implementation.
3. Do not force the primary stack when it would produce a weak design, excessive complexity, poor performance, poor user experience, or avoidable operational risk.
4. Prefer built-in framework capabilities before adding a new platform component.
5. Keep PostgreSQL as the default operational system of record.
6. Use additional databases, search stores, caches, queues, workflow engines, or analytics platforms only when the requirement cannot be met cleanly by the primary stack.
7. Treat specialized stores as derived stores or read models unless a documented decision says they are authoritative.
8. Do not introduce closed-source dependencies, proprietary-only SDKs, or vendor-only runtime requirements.
9. Record every approved non-primary technology choice with its reason, license, owner, and operational impact.

## Additional Technology Decision Process

When implementation appears to require technology outside Angular, Spring Boot, or PostgreSQL, or when the primary stack is not a good fit, pause before adoption and offer choices.

The proposal must include:

| Required item | Description |
| --- | --- |
| Need | The specific capability that the primary stack does not cover well enough. |
| Options | At least two open source options, preferably three when there are realistic alternatives. |
| Pros and cons | Practical trade-offs for delivery, operations, security, scalability, maintainability, and team skills. |
| License | The license for each option, with any license risk called out. |
| Primary-stack alternative | A "stay within Angular/Spring Boot/PostgreSQL" option when viable. |
| Recommendation | A clear recommended choice, including why it fits this product suite. |
| Decision request | Ask the product or architecture owner to select before implementation begins. |

Do not silently add a new stack component because it is convenient. Ask first, then implement the selected option.

## Decision Prompt Template

Use this format when asking for a non-primary technology decision:

```markdown
We need an additional technology for: <capability>.

Primary-stack option:
- <How Angular/Spring Boot/PostgreSQL could handle it>
- Pros: <benefits>
- Cons: <limits>

Open source options:

| Option | License | Pros | Cons | Best fit |
| --- | --- | --- | --- | --- |
| <Option A> | <License> | <Pros> | <Cons> | <When to choose> |
| <Option B> | <License> | <Pros> | <Cons> | <When to choose> |
| <Option C> | <License> | <Pros> | <Cons> | <When to choose> |

Recommendation: <recommended option and rationale>.

Please select the option to use before implementation.
```

## Common Extension Areas

These categories often require a technology choice beyond the primary stack. The examples are not automatic approvals; they are starting points for an options discussion.

| Capability | First check within primary stack | Open source options to evaluate |
| --- | --- | --- |
| Event streaming or messaging | Spring events, PostgreSQL transactional outbox, scheduled polling | Apache Kafka, RabbitMQ, NATS |
| Caching | Spring cache abstraction, PostgreSQL tuning, materialized views | Valkey, Infinispan, Apache Ignite |
| Search | PostgreSQL full-text search and indexes | OpenSearch, Apache Solr |
| Workflow or BPMN | Spring state machines, application-owned workflow tables | Flowable, Activiti, Temporal |
| Identity and access management | Spring Security with existing enterprise identity integration | Keycloak, authentik, Apache Syncope |
| API gateway | Spring Cloud Gateway for simple gateway needs | Apache APISIX, Envoy Gateway, KrakenD Community Edition |
| Observability | Spring Boot Actuator, structured logs | OpenTelemetry, Prometheus, Grafana, Jaeger |
| Object storage | PostgreSQL large object or file metadata plus filesystem storage for small/simple cases | Ceph, Apache Ozone, MinIO Community with license review |
| Analytics and reporting | PostgreSQL read replicas, materialized views, governed data products | Apache Superset, Trino, Apache Druid, ClickHouse |
| Batch and scheduling | Spring Batch, Spring scheduling | Apache Airflow, Dagster, Argo Workflows |
| Container orchestration | Local Docker or Compose for development | Kubernetes, OKD, K3s |

For every category, verify the current license, project health, security posture, and operational fit before choosing.

## Stack Boundaries

### Front End

Angular is the standard front-end framework. Use Angular capabilities first for routing, forms, HTTP clients, validation, component composition, accessibility, and build tooling.

All application UIs must follow [TelcoSuite UI Design System](telcosuite-ui-design-system.md). PrimeNG community packages are the standard Angular component foundation, with TelcoSuite shared components, tokens, themes, and shell patterns layered on top.

Do not introduce React, Vue, Svelte, Next.js, Nuxt, or another front-end framework without an explicit decision using this document.

### Backend

Java Spring Boot is the standard backend platform. Use Spring Boot and the Spring ecosystem for REST APIs, validation, security integration, persistence, transactions, scheduling, batch jobs, and service-to-service integration.

Do not introduce Node.js, Python, Go, .NET, Ruby, or another backend runtime for product services without an explicit decision using this document.

### Database

PostgreSQL is the standard operational database. Use it for authoritative data unless the requirement clearly needs another storage model.

Do not introduce MongoDB, Cassandra, DynamoDB-compatible stores, graph databases, separate time-series databases, or another primary database without an explicit decision using this document.

Specialized stores, when approved, should normally be fed from PostgreSQL-owned data through APIs, events, or governed replication.

## Approval Record Template

When a non-primary technology is selected, record the decision in the relevant planning or architecture document:

```markdown
## Technology Decision: <Capability>

| Field | Decision |
| --- | --- |
| Capability | <What we needed> |
| Selected technology | <Chosen option> |
| License | <License and review note> |
| Alternatives considered | <Short list> |
| Why selected | <Rationale> |
| Data ownership impact | <Authoritative store, read model, event stream, cache, etc.> |
| Operational impact | <Deployment, backup, monitoring, scaling, security> |
| Decision owner | <Person/team/role> |
| Decision date | <YYYY-MM-DD> |
```

## Review Cadence

Review this guidance when:

- A new product suite or major platform capability begins implementation.
- A new technology category is proposed.
- A license changes or a project changes from open source to source-available.
- A selected component becomes unmaintained or creates operational risk.
- A deployment model introduces proprietary runtime dependencies.

The review should preserve the primary stack unless a documented product, operational, scale, regulatory, or integration need justifies an exception.
