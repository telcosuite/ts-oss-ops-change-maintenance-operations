# TelcoSuite Repository Strategy

Reviewed: 2026-06-14

## Decision Summary

TelcoSuite should be managed in GitHub as one product program with one implementation repository per application. Use the `ts-` repository prefix. Each app repository should contain the app's front end, backend, API/event contracts, database migrations, deployment assets, app documentation, and development task tracker.

This model keeps each app independently owned and releasable while preserving one coherent product suite through shared governance, architecture standards, contract rules, and portfolio-level planning.

## Goals

- Let different teams own different telecom apps without stepping on each other's delivery pipelines.
- Keep each app buildable from scratch from its own repository.
- Keep front-end and back-end changes close together when they belong to the same app capability.
- Preserve API-first, TMF-aligned, app-owned data boundaries.
- Make ownership, CI/CD, releases, security posture, and operational responsibility clear per app.
- Avoid turning shared code into hidden cross-app coupling.

## Product And Repository Topology

Use one GitHub organization or GitHub project for the full TelcoSuite product. Inside that product container, create one implementation repository per app. Create shared UI/design-system and pipeline-template repositories immediately so app teams can start from the same baseline.

```text
TelcoSuite GitHub organization/project
  ts-planning
  ts-shared-ui-design-system
  ts-shared-pipeline-templates
  ts-sic-demand-market-planning
  ts-sic-geography-address-site-serviceability
  ts-sic-network-investment-capacity-planning
  ts-sic-network-engineering-design
  ts-sic-infrastructure-build-program
  ts-bss-customer-party-360
  ts-bss-product-offer-studio
  ...
```

Repository roles:

| Repository type | Purpose | Ownership |
| --- | --- | --- |
| Planning repository | Product strategy, suite/app planning, architecture guidance, data ownership, TMF references, app dev-task packs | Product architecture and planning owners |
| App implementation repository | One deployable app with UI, backend, contracts, database migrations, deployment, tests, runbooks, and app docs | App squad or domain team |
| Shared platform repository | Reusable platform capability that is not owned by one app, such as API gateway policy templates or observability standards | Platform team |
| Shared UI/design-system repository | Reusable UI tokens, themes, layout shells, accessibility patterns, PrimeNG wrappers, generated UI utilities, and shared design documentation | Design system team |
| Shared pipeline-template repository | GitHub Actions workflow templates, reusable checks, security scan wiring, OpenAPI/event validation jobs, and release workflow standards | Platform operations team |
| Infrastructure/environment repository | Environment definitions, cluster/platform configuration, secrets references, and environment promotion policy | Platform operations team |

Create `ts-shared-ui-design-system` and `ts-shared-pipeline-templates` immediately. Do not create additional shared code repositories just because two apps look similar. Additional shared code should be extracted only when reuse is stable, versioned, tested, and owned.

## App Repository Standard

Every app repository should be a vertical implementation slice.

Recommended structure:

```text
/
  README.md
  OWNERS.md
  CODEOWNERS
  docs/
    architecture.md
    api.md
    data-model.md
    operations-runbook.md
    adr/
  dev-tasks/
    development-task-tracker.md
    P01-<phase>.md
    P02-<phase>.md
  frontend/
    README.md
    package.json
    angular.json
    src/
  backend/
    README.md
    pom.xml
    src/
  contracts/
    openapi/
      v1/openapi.yaml
    events/
      <event-name>.schema.json
  database/
    postgres/
      migrations/
      seeds/
  deploy/
    compose/
    k8s/
    helm/
  scripts/
    dev/
    ci/
  tests/
    e2e/
    contract/
    performance/
  .github/
    workflows/
```

The app repository is responsible for:

- Angular app routes, workbenches, components, API clients, guards, and UI tests for that app.
- Spring Boot service APIs, domain logic, validation, security enforcement, workflow orchestration, event publication, adapters, and operational jobs for that app.
- App-owned PostgreSQL migrations, read models, audit tables, outbox tables, seed data, and data retention controls.
- TMF-aligned OpenAPI contracts, extension APIs, event schemas, and compatibility tests.
- App-specific deployment manifests, configuration templates, observability dashboards, runbooks, and release notes.
- The app's development task tracker and phase task files copied from planning when implementation begins. After bootstrap, the app repository owns the active implementation backlog.

## Why Front End And Back End Stay Together

For these apps, the UI and backend usually evolve as one product capability. Keeping them in the same app repository helps the owning team deliver complete slices:

- A workflow screen can be implemented with its command/query APIs in the same pull request.
- Acceptance criteria can be verified across UI, API, data, event, and observability behavior.
- App CI can run unit, integration, contract, accessibility, and E2E tests together.
- Each app can publish and deploy independently without coordinating a large shared monorepo release.
- Security, data, and operational ownership remain clear because the repository maps to the app's lifecycle boundary.

This does not mean the UI can bypass the API boundary. The front end must call app APIs and shared platform APIs. It must never read or write a database directly.

## Naming Convention

Use stable, short names that encode suite and app identity.

Recommended repository pattern:

```text
ts-<suite-code>-<app-slug>
```

Suite codes:

| Suite | Code |
| --- | --- |
| Strategy, Investment, And Capacity | `sic` |
| BSS Commercial | `bss` |
| OSS Engineering, Inventory, And Fulfillment | `oss-eng` |
| OSS Operations And Assurance | `oss-ops` |
| Digital, Partner, And Ecosystem | `dpe` |
| Enterprise Platform, Data, And Governance | `epdg` |

First suite examples:

| App | Repository |
| --- | --- |
| Demand And Market Planning | `ts-sic-demand-market-planning` |
| Geography, Address, Site, And Serviceability | `ts-sic-geography-address-site-serviceability` |
| Network Investment And Capacity Planning | `ts-sic-network-investment-capacity-planning` |
| Network Engineering And Design | `ts-sic-network-engineering-design` |
| Infrastructure Build Program | `ts-sic-infrastructure-build-program` |

## Source Of Truth

The planning repository remains the source of truth for:

- Product suite strategy and app portfolio decisions.
- Suite/app planning files.
- Architecture guidance.
- Technology stack guidance.
- UI/UX design system guidance.
- Data mastery and entity ownership.
- TMF API references and traceability.
- Initial development task generation.

An app implementation repository becomes the source of truth for:

- App code.
- App runtime configuration templates.
- App database migrations.
- App API/event contract versions that have entered implementation.
- App build, test, deployment, release, and runbook details.
- The active implementation backlog after it is copied from planning into the app repository.

When planning changes affect an app already in implementation, the app team should either:

1. Pull the revised planning into the app repository through a backlog update pull request, or
2. Record an app-level architecture decision explaining why the app intentionally diverges.

## Boundary Rules

Each app repository must preserve the product architecture boundaries already defined in:

- [API-First Telecom Product Suite Architecture](api-first-product-suite-architecture.md)
- [Data Mastery And Entity Ownership](data-mastery-entity-ownership.md)
- [Technology Stack Guidance](technology-stack-guidance.md)
- [TelcoSuite UI Design System](telcosuite-ui-design-system.md)
- [Recommended Database Setup](recommended-database-setup.md)

Mandatory rules:

- Each app owns its operational schema and write model.
- Cross-app behavior happens through APIs, events, workflow tasks, governed projections, or data products.
- No app may directly write to another app's database.
- No app may add cross-app foreign keys into another app's operational schema.
- TMF Open APIs should be used where they fit. Non-TMF extension APIs must be documented and governed.
- Events are product contracts and must have schemas, versioning, compatibility tests, and replay guidance.
- Front ends use API contracts, not database access or private backend internals.
- Shared libraries are consumed as versioned packages, not by copying source files between app repositories.

## Branching And Release Model

Recommended default:

- `main` is always releasable.
- Feature branches are short-lived and linked to task IDs.
- Pull requests require GitHub code-owner review, passing CI, security checks, and contract checks.
- Releases use annotated tags such as `v1.4.0`.
- Hotfix branches are allowed only for production incidents and are merged back to `main`.

Versioning:

- App version: semantic version for the deployable app.
- API version: contract version for OpenAPI and external consumers.
- Event version: schema version for event consumers.
- Database version: migration sequence managed by the app repository.

The app version and API/event versions do not need to match, but release notes must say which API and event contract versions are included.

## CI/CD Requirements

Every app repository should have pipelines for:

- Front-end lint, unit tests, build, accessibility checks, and E2E smoke tests.
- Backend compile, unit tests, integration tests, API contract tests, and database migration tests.
- OpenAPI linting, backward compatibility checks, generated-client checks, and documentation publishing.
- Event schema validation, backward compatibility checks, replay/idempotency tests, and outbox tests.
- Container image build and vulnerability scan.
- License policy checks for open source dependencies.
- Deployment validation for local Docker Compose and Kubernetes/Helm paths across test, staging, and production-like environments.
- Operational readiness checks for metrics, traces, structured logs, health endpoints, dashboards, and runbook links.

CI should block merges when a change breaks a public API/event contract without an approved versioning plan.

## Shared Assets And Reuse

Shared assets should be deliberately versioned. Create `ts-shared-ui-design-system` and `ts-shared-pipeline-templates` before the first app repository starts implementation so the app scaffolds can consume common UI and CI/CD standards from day one.

| Asset | Recommended ownership | Rule |
| --- | --- | --- |
| UI tokens and common components | Design system team, through `ts-shared-ui-design-system` | Publish as a versioned package; app teams upgrade intentionally |
| Generated API clients | Owning API/app team or platform tooling | Generate from OpenAPI; never hand-edit generated code |
| Spring Boot starters | Platform team | Keep small and infrastructure-focused; avoid embedding domain logic |
| Pipeline templates | Platform operations, through `ts-shared-pipeline-templates` | Version templates and publish migration notes |
| OpenAPI/event lint rules | API governance team | Apply consistently across app repos |
| Test utilities | Platform or quality engineering | Keep generic; app-specific fixtures stay in the app repo |

Domain logic, workflow state, database writes, app-specific UI flows, and telecom lifecycle decisions should stay inside the owning app repository.

## Cross-App Coordination

Use lightweight coordination around contracts, not shared source control.

Required practices:

- Maintain a product-level repository catalog with app owner, suite, lifecycle domain, repo URL, primary contacts, deployment name, and operational channel.
- Use an API/event review process for new or breaking cross-app contracts.
- Create consumer-driven contract tests for important app-to-app dependencies.
- Publish release notes for API, event, data migration, and operational changes.
- Track cross-app dependencies in the product project board.
- Use architecture decision records for changes that affect app boundaries, data ownership, TMF mapping, or shared runtime components.


## Product Repository Catalog

Maintain a product-level repository catalog in the planning repository or GitHub project metadata. The catalog should be reviewed monthly and whenever a new app repository is created.

Recommended catalog columns:

| Field | Description |
| --- | --- |
| Suite | Product suite name |
| App | App name |
| Repository | Source-control repository name and URL |
| Owning team | Delivery team accountable for implementation |
| Product owner | Role or person accountable for backlog priority |
| Engineering owner | Role or person accountable for technical delivery |
| Data steward | Role or person accountable for entity ownership and privacy controls |
| Runtime name | Service, UI, container, or deployment name |
| Primary APIs | Main OpenAPI contracts exposed by the app |
| Primary events | Main event families published or consumed by the app |
| Operational channel | Support or incident channel |
| Release cadence | Independent, release train, or platform-aligned |
| Status | Planned, bootstrapping, active build, beta, production, deprecated |

First suite starter catalog:

| Suite | App | Repository | Status |
| --- | --- | --- | --- |
| Strategy, Investment, And Capacity | Demand And Market Planning | `ts-sic-demand-market-planning` | Planned |
| Strategy, Investment, And Capacity | Geography, Address, Site, And Serviceability | `ts-sic-geography-address-site-serviceability` | Planned |
| Strategy, Investment, And Capacity | Network Investment And Capacity Planning | `ts-sic-network-investment-capacity-planning` | Planned |
| Strategy, Investment, And Capacity | Network Engineering And Design | `ts-sic-network-engineering-design` | Planned |
| Strategy, Investment, And Capacity | Infrastructure Build Program | `ts-sic-infrastructure-build-program` | Planned |

## Initial Shared Repositories

Create these shared repositories before the first app repository is bootstrapped:

| Repository | Purpose | First responsibilities |
| --- | --- | --- |
| `ts-shared-ui-design-system` | Shared Angular/PrimeNG design-system package and documentation | Design tokens, app shell patterns, shared navigation, accessibility guidance, reusable workbench/table/form patterns, theme assets, and versioned package publishing |
| `ts-shared-pipeline-templates` | Shared GitHub Actions workflow templates and CI/CD policy checks | Angular checks, Spring Boot checks, OpenAPI/event validation, database migration tests, container scans, license checks, Docker Compose validation, Kubernetes/Helm validation, and release workflow templates |

These repositories should not own app-specific UI screens, domain logic, API behavior, database migrations, or telecom lifecycle decisions. Those stay in the app repositories.

## Creating A New App Repository

Use this sequence when an app moves from planning into implementation:

1. Confirm app boundary, owner, suite, personas, data ownership, API/event contracts, and first-release scope from the planning repository.
2. Create the repository using the naming convention.
3. Add `OWNERS.md`, `CODEOWNERS`, GitHub branch protection, required reviews, required CI checks, and security scanning.
4. Copy the app's `dev-tasks/` folder from planning into the repository. This is a bootstrap copy, not an automatic sync.
5. Add the standard app repository structure.
6. Scaffold Angular under `frontend/` and Spring Boot under `backend/`.
7. Add OpenAPI and event contract placeholders under `contracts/`.
8. Add PostgreSQL migration scaffolding under `database/postgres/`.
9. Add local development scripts and local environment templates.
10. Add GitHub Actions workflows using `ts-shared-pipeline-templates`, including local Docker Compose validation and Kubernetes/Helm validation.
11. Link the repository back to the product project catalog.
12. Open the first implementation milestone using the app's phase 01 dev tasks.

## Maintenance Model

### Product-Level Maintenance

The product architecture and planning owners maintain:

- The app portfolio and repository catalog.
- Suite and app planning documents.
- Shared architecture, stack, UI, and data ownership rules.
- API/event governance.
- Cross-suite dependency maps.
- Delivery governance gates.

Review cadence:

- Monthly: repository catalog, app ownership, delivery status, and cross-app dependency review.
- Per release train or major milestone: API/event compatibility, security posture, data ownership changes, and operational readiness.
- Per new app: repository creation readiness review.

### App-Level Maintenance

Each app team maintains:

- Application code, tests, migrations, contracts, deployment assets, and runbooks.
- App-specific backlog and development task tracker.
- Dependency upgrades and vulnerability remediation.
- API/event contract compatibility.
- App observability and operational dashboards.
- App release notes and production support handoff.

Each app repository should include a visible ownership file:

```markdown
# OWNERS

| Area | Owner |
| --- | --- |
| Product owner | <name or role> |
| Engineering owner | <name or role> |
| Architecture owner | <name or role> |
| Operations owner | <name or role> |
| Security contact | <name or role> |
| Data steward | <name or role> |
```

### Shared Asset Maintenance

Shared repositories must have:

- A named owning team.
- Semantic versioning.
- Changelogs.
- Upgrade guidance.
- Compatibility policy.
- Deprecation policy.
- Security and license review.

No shared repository should become an unowned utility dump. If no team owns it, the asset should stay inside the app that needs it.

## Governance Gates

Before an app repository starts implementation:

- App boundary and data ownership are documented.
- First-release scope and dev tasks are available.
- UI/UX guidance and workbenches are defined.
- API and event contract approach is known.
- Database ownership and migration strategy are known.
- Team ownership and operational ownership are assigned.
- CI/CD baseline is ready.

Before first production release:

- All required CI gates pass.
- Public API/event contracts are versioned and documented.
- Database migrations are reversible or have documented forward-repair plans.
- Observability dashboards and alerts exist.
- Runbook and incident response ownership are complete.
- Security, privacy, accessibility, and tenant/residency controls are tested.
- Release notes include contract, migration, deployment, and operational impacts.

## Recommended Defaults

Use these defaults unless the delivery organization chooses otherwise:

| Decision | Recommendation |
| --- | --- |
| Source-control model | GitHub organization/project with one repository per app |
| Repository prefix | `ts-` for planning, shared, platform, and app repositories |
| App repo shape | Vertical app repo containing `frontend/`, `backend/`, `contracts/`, `database/`, `deploy/`, `docs/`, and `dev-tasks/` |
| Planning source of truth | Keep product planning in this repository |
| Active implementation source of truth | Keep app code and active implementation backlog in each app repo |
| Dev task transfer | Copy app `dev-tasks/` from planning into the app repo at bootstrap; the app repo owns active task updates afterward |
| Shared repositories | Create `ts-shared-ui-design-system` and `ts-shared-pipeline-templates` immediately |
| Deployment targets | Support both local Docker Compose and Kubernetes/Helm from the first app bootstrap |
| Front end | Angular |
| Backend | Java Spring Boot |
| Database | PostgreSQL per app boundary |
| Contract style | TMF Open API first, governed extension APIs when needed |
| Shared code | Extract only after stable reuse is proven and ownership is clear |
| Release | Independent app release with product-level dependency tracking |

## Confirmed Decisions

These decisions are confirmed for the initial repository rollout:

| Decision | Confirmed choice |
| --- | --- |
| Repository prefix | Use `ts-` |
| Source-control platform | Use GitHub |
| Shared repositories | Create shared UI/design-system and pipeline-template repositories immediately |
| Deployment target | Support both local Docker Compose and Kubernetes/Helm |
| Development task transfer | Copy `dev-tasks/` into each app repository at bootstrap |

Implementation note: after the bootstrap copy, app teams maintain active task status in their app repositories. Planning updates should flow into app repositories through explicit backlog update pull requests or app-level architecture decisions, not automatic file synchronization.
