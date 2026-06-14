# Change And Maintenance Operations

Repository: `ts-oss-ops-change-maintenance-operations`

Suite: OSS Operations And Assurance

This repository is the implementation home for Change And Maintenance Operations. It is bootstrapped from the TelcoSuite planning repository and is intended to contain the complete app vertical slice: front end, backend, contracts, database migrations, deployment assets, app documentation, tests, operations runbooks, and the active development task tracker.

## App Scope

Change And Maintenance Operations implementation surface and app-owned responsibilities are documented in `docs/planning/app-detail/README.md` and the suite-wide data model in `docs/planning/suite/data-model.md`.

## Bootstrap Contents

- `dev-tasks/` contains the phased build backlog generated from the source planning pack.
- `docs/planning/app-detail/` contains app-level planning, personas, modules, and feature specifications.
- `docs/planning/suite/` contains suite-level architecture, data, tech, UI, and journey guidance.
- `docs/product-guidance/` contains product-wide architecture, data ownership, stack, UI, database, and repo strategy guidance.
- `database/postgres/source-migrations/` contains the suite V001 starter DDL and the per-app V00X TMF refine copied from planning.
- `contracts/` contains API and event placeholders to be replaced by the task-driven contracts.
- `frontend/` and `backend/` are ready for Angular and Spring Boot scaffolding from phase 01 tasks.

## First Implementation Step

Start with `dev-tasks/P01-from-scratch-app-foundation-and-delivery-runtime.md`. The app team owns task status in this repository after bootstrap.

## Source Planning Anchor

This bootstrap was generated from `ts-planning/planning/suite-details/04-oss-operations-assurance/change-maintenance-operations/`. After bootstrap, the app repository owns the active implementation backlog; planning updates should flow back through explicit pull requests or app-level architecture decisions, not automatic file synchronization.
