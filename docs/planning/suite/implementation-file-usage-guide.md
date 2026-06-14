# OSS Operations And Assurance Implementation File Usage Guide

Reviewed: 2026-06-14

## Purpose

This guide explains how to use the planning, TMF, UI, data, and DDL files for the OSS Operations And Assurance suite while building its apps.

Suite focus: assurance, operations, incidents, performance, SLA, change, maintenance, and shared assurance modules.

## Suite-Level Files

| File | Use it for |
| --- | --- |
| [README.md](README.md) | Suite navigation and app list. |
| [tech-and-ui-guidance.md](tech-and-ui-guidance.md) | Suite-specific Angular, PrimeNG, layout, navigation, density, and UI consistency guidance. |
| [data-model.md](data-model.md) | Suite database ownership, app schemas, data mastery, cross-app sharing, and physical model guidance. |
| [journey-coverage.md](journey-coverage.md) | Cross-app suite journeys and end-to-end flow validation. |
| [../build-artifact-usage-guide.md](../build-artifact-usage-guide.md) | Global explanation of how all generated files fit together. |
| [../suite-app-coverage-control-matrix.md](../suite-app-coverage-control-matrix.md) | Build-readiness status across all suites and apps. |
| [../tmf-api-to-ddl-traceability-matrix.md](../tmf-api-to-ddl-traceability-matrix.md) | API-level TMF-to-schema/table coverage. |
| [../../../database/postgres/README.md](../../../database/postgres/README.md) | Database execution model and migration usage. |

## Database And Migration Use

Physical database: `ts_oss_operations_assurance`

Run migrations in order inside this suite database. `V001` creates app schemas and starter tables. Each V002+ migration refines one app with promoted TMF fields, support tables, event contracts, and privacy/retention/audit policies.

| Migration | Path |
| --- | --- |
| `V001__create_app_schemas_and_starter_tables.sql` | `database/postgres/suites/ts_oss_operations_assurance/V001__create_app_schemas_and_starter_tables.sql` |
| `V002__refine_noc_assurance_tmf_core.sql` | `database/postgres/suites/ts_oss_operations_assurance/V002__refine_noc_assurance_tmf_core.sql` |
| `V003__refine_performance_quality_sla_tmf_core.sql` | `database/postgres/suites/ts_oss_operations_assurance/V003__refine_performance_quality_sla_tmf_core.sql` |
| `V004__refine_change_maintenance_tmf_core.sql` | `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |
| `V005__refine_cross_assurance_shared_tmf_core.sql` | `database/postgres/suites/ts_oss_operations_assurance/V005__refine_cross_assurance_shared_tmf_core.sql` |

## App File Map

| App | Schema | App usage guide | TMF review | App migration | Primary TMF/API areas |
| --- | --- | --- | --- | --- | --- |
| Change And Maintenance Operations | `change_maintenance` | [change-maintenance-operations/implementation-file-usage.md](change-maintenance-operations/implementation-file-usage.md) | [change-maintenance.md](../tmf-api-ddl-reviews/change-maintenance.md) | `V004__refine_change_maintenance_tmf_core.sql` | TMF655, TMF681, TMF696, TMF638, TMF639, TMF701, TMF640, TMF629 |
| Cross-Assurance Shared Modules | `cross_assurance_shared` | [cross-assurance-shared-modules/implementation-file-usage.md](cross-assurance-shared-modules/implementation-file-usage.md) | [cross-assurance-shared.md](../tmf-api-ddl-reviews/cross-assurance-shared.md) | `V005__refine_cross_assurance_shared_tmf_core.sql` | TMF621, TMF656, TMF701, TMF921, TMF724, TMF642 |
| NOC And Assurance | `noc_assurance` | [noc-and-assurance/implementation-file-usage.md](noc-and-assurance/implementation-file-usage.md) | [noc-assurance.md](../tmf-api-ddl-reviews/noc-assurance.md) | `V002__refine_noc_assurance_tmf_core.sql` | TMF642, TMF638, TMF639, TMF724, TMF656, TMF621, TMF681, TMF667, TMF653, TMF641, TMF697, TMF701, TMF640 |
| Performance, Quality, And SLA | `performance_quality_sla` | [performance-quality-sla/implementation-file-usage.md](performance-quality-sla/implementation-file-usage.md) | [performance-quality-sla.md](../tmf-api-ddl-reviews/performance-quality-sla.md) | `V003__refine_performance_quality_sla_tmf_core.sql` | TMF628, TMF649, TMF642, TMF657, TMF651, TMF621, TMF696 |

## Suite Build Workflow

1. Start with this guide and the suite `data-model.md` to confirm database, schema, and ownership boundaries.
2. Use `tech-and-ui-guidance.md` before any Angular work so all apps share the TelcoSuite design language.
3. Build apps in the priority order from [../tmf-api-ddl-reviews/backlog.md](../tmf-api-ddl-reviews/backlog.md), unless delivery priorities explicitly change.
4. For each app, open its `implementation-file-usage.md` and follow its checklist.
5. Apply `V001`, then the app's V002+ migration, before implementing repositories/entities that depend on promoted columns or support tables.
6. Emit events through the app `event_outbox` and use the app `event_contract` table as the baseline register.
7. Enforce table handling with the app `privacy_retention_policy` table and add jurisdiction-specific rules before release.
8. Keep cross-app interactions out of database writes; use APIs, events, governed views, workflow tasks, or data products.

## Suite Delivery Gate

The suite is implementation-ready when each app keeps these artifacts aligned: app overview, modules/features, personas/journeys, TMF review, V002+ DDL, endpoint contract tests, event behavior, and privacy/audit controls.
