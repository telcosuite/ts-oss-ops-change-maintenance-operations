# TelcoSuite UI Design System

This document defines the shared user interface design system for TelcoSuite. Every suite and app should follow it so the product feels like one polished enterprise platform rather than a collection of unrelated applications.

TelcoSuite is the default product name used in the UI, documentation, navigation, and shared shell. The product name must be configurable so deployments can rebrand it without code changes.

## Design System Mandate

TelcoSuite applications must present a consistent, modern, professional, enterprise-grade experience across BSS, OSS, digital, partner, planning, platform, data, and operations suites.

The target product feel is closer to Salesforce or ServiceNow: practical, polished, operational, configurable, and trusted for repeated daily use by enterprise teams.

| Mandate | Standard |
| --- | --- |
| Product feel | Premium enterprise utility: polished, calm, structured, and dependable |
| Primary UI technology | Angular with PrimeNG community components |
| Theme model | Light and dark mode from day one |
| Default palette | Monochrome neutral system with configurable accent palettes |
| Density | Compact by default for operational workflows; dashboard layouts can be more spacious |
| Consistency | Shared shell, tokens, page templates, interaction patterns, and reusable components |
| Accessibility | WCAG 2.2 AA minimum |
| Responsiveness | Desktop, tablet, and mobile considered for every app |
| Reuse | Prefer shared modules and configurable components over custom one-off UI |

## Core Principles

1. Build one product language across all suites.
2. Use Angular and PrimeNG as the UI foundation.
3. Wrap repeated PrimeNG usage in TelcoSuite shared components so apps do not rebuild the same patterns.
4. Keep operational screens compact, scannable, and action-oriented.
5. Use dashboard composition only where users need summary, KPI, trend, or exception views.
6. Support light mode, dark mode, and user-selected accent palettes from the beginning.
7. Make accessibility, keyboard navigation, and responsive behavior part of the definition of done.
8. Keep common navigation and shell behavior shared wherever feasible.
9. Allow app-specific layout variations only when the workflow genuinely needs them.
10. Do not add custom UI libraries, visual frameworks, or styling systems without following [Technology Stack Guidance](technology-stack-guidance.md).

## Open Source UI Policy

TelcoSuite UI dependencies must follow the open source policy in [Technology Stack Guidance](technology-stack-guidance.md).

PrimeNG is the selected Angular component library. Use PrimeNG community packages and PrimeIcons as the default component and icon base. Do not require commercial-only PrimeNG capabilities, proprietary themes, or paid LTS packages for core application behavior unless a separate technology decision is approved.

Before each major dependency upgrade, verify the license, package ownership, maintenance state, security posture, and Angular compatibility.

## UI Architecture

The UI should be built as reusable Angular modules and libraries that feature apps consume.

| Shared package or module | Purpose |
| --- | --- |
| `@telcosuite/ui-shell` | Product shell, suite navigation, app navigation, top bar, breadcrumbs, user menu, global context controls |
| `@telcosuite/theme` | Design tokens, light/dark themes, accent palettes, density settings, theme persistence |
| `@telcosuite/ui-kit` | Shared buttons, status indicators, page headers, tabs, filters, dialogs, empty states, error states, skeletons |
| `@telcosuite/data-grid` | Standard PrimeNG table patterns, filtering, sorting, pagination, column settings, exports, saved views |
| `@telcosuite/forms` | Form layout, validation summary, field wrappers, lookup fields, date/time fields, stepper patterns |
| `@telcosuite/dashboard` | KPI tiles, chart containers, dashboard grid, drill-down links, refresh and time-range controls |
| `@telcosuite/a11y` | Focus management, skip links, ARIA helpers, keyboard interaction helpers, contrast checks |
| `@telcosuite/domain-ui` | Reusable telecom domain UI such as entity headers, lifecycle status, order timelines, resource badges, customer/account summaries |

Feature apps should import shared TelcoSuite components for common patterns. Raw PrimeNG components are acceptable for simple local composition, but any repeated page pattern, table pattern, form pattern, or shell behavior should move into a shared library.

## PrimeNG Usage Rules

PrimeNG is the component base, not the full design system by itself. TelcoSuite should layer consistent tokens, spacing, density, states, and interaction behavior on top.

| Area | Rule |
| --- | --- |
| Buttons | Use PrimeNG buttons with TelcoSuite variants for primary, secondary, subtle, danger, success, and icon-only actions. |
| Tables | Use PrimeNG table through `@telcosuite/data-grid` for operational list views. |
| Forms | Use PrimeNG form controls through TelcoSuite form wrappers for label, help text, validation, density, and accessibility consistency. |
| Dialogs | Use shared modal patterns with consistent size, footer actions, escape behavior, and focus trapping. |
| Toasts | Use shared severity rules and avoid noisy success toasts for routine autosave behavior. |
| Menus | Use PrimeNG menus with standardized placement, keyboard behavior, and permission filtering. |
| Icons | Use PrimeIcons by default; icon-only actions must include tooltips and accessible names. |
| Custom styling | Prefer design tokens and shared classes. Avoid one-off component overrides inside feature apps. |

## Product Shell

Use a common application shell wherever feasible.

| Shell area | Standard behavior |
| --- | --- |
| Product identity | Configurable product name, default `TelcoSuite`; optional deployment logo |
| Suite switcher | Gives access to BSS, OSS, digital, planning, platform, data, and admin suites based on permissions |
| App navigation | Suite-level navigation with app groups, favorites, recent apps, and permission-aware visibility |
| Global search | Searches allowed entities, apps, orders, customers, resources, tickets, and tasks where supported |
| Context selector | Tenant, market, environment, customer/account, or operational domain context when relevant |
| Notifications | Alerts, tasks, approvals, assignment changes, operational exceptions |
| User menu | Profile, preferences, theme mode, palette, density, accessibility preferences, sign out |
| Breadcrumbs | Always show location for deep pages, record pages, and task flows |
| Command actions | Page-specific create, save, submit, approve, assign, export, and more actions in predictable locations |

The shell may adapt for specialized full-screen workflows such as topology maps, field execution, dashboard wallboards, test labs, or operations command views. When it adapts, the product identity, navigation escape path, theme, accessibility, and user controls must remain available.

## Navigation Model

Use navigation that supports enterprise scale without feeling crowded.

| Pattern | Use for |
| --- | --- |
| Collapsible left navigation | Main suite and app navigation on desktop |
| Top utility bar | Product identity, search, context, notifications, help, user menu |
| Breadcrumbs | Record, detail, configuration, wizard, and deep workflow pages |
| Tabs | Related views inside the same record or app area |
| Side panels | Filters, details, activity, history, comments, and contextual inspection |
| Command palette or global search | Fast cross-app navigation and entity lookup where supported |
| Mobile drawer | Navigation on narrow screens |

Navigation must be permission-aware, route-driven, and configurable through app metadata where possible.

## Theme System

TelcoSuite must support theme mode, accent palette, and density as user preferences.

| Preference | Required options |
| --- | --- |
| Theme mode | Light, dark, system |
| Accent palette | Default monochrome plus selectable enterprise accent palettes |
| Density | Compact, comfortable |
| Motion | Standard, reduced motion |
| Contrast | Standard, high contrast where feasible |

The default visual system is monochrome: neutral surfaces, strong type hierarchy, restrained borders, clear focus states, and one accent color at a time. Accent palettes should be configurable so deployments can align with customer branding without changing component code.

### Token Categories

Use semantic tokens rather than hard-coded values in feature apps.

| Token category | Examples |
| --- | --- |
| Surface | `--ts-surface-page`, `--ts-surface-card`, `--ts-surface-raised`, `--ts-surface-overlay` |
| Text | `--ts-text-primary`, `--ts-text-secondary`, `--ts-text-muted`, `--ts-text-inverse` |
| Border | `--ts-border-subtle`, `--ts-border-strong`, `--ts-border-focus` |
| Accent | `--ts-accent`, `--ts-accent-hover`, `--ts-accent-subtle`, `--ts-accent-text` |
| Status | `--ts-status-success`, `--ts-status-warning`, `--ts-status-danger`, `--ts-status-info`, `--ts-status-neutral` |
| Spacing | `--ts-space-1` through `--ts-space-10` |
| Radius | `--ts-radius-sm`, `--ts-radius-md`, `--ts-radius-lg`; cards and panels should stay at 8px or less unless a component requires otherwise |
| Elevation | `--ts-shadow-sm`, `--ts-shadow-md`, `--ts-shadow-overlay` |
| Density | `--ts-control-height`, `--ts-row-height`, `--ts-toolbar-height`, `--ts-page-gap` |

Feature apps must not hard-code colors for status, severity, charts, or actions. Use semantic tokens and shared status mappings.

## Visual Language

TelcoSuite should feel precise, calm, and durable.

| Element | Standard |
| --- | --- |
| Typography | Use a clean system font stack. Keep headings useful, not oversized. Use tabular numbers for KPI and operational counters where helpful. |
| Layout | Favor clear grids, aligned edges, restrained spacing, and strong grouping. |
| Cards and panels | Use cards for repeated items, dashboard metrics, modals, and framed tools. Avoid nested cards. |
| Borders | Use subtle borders for separation in dense layouts. Avoid heavy outlines unless indicating focus or high severity. |
| Shadows | Use lightly and mainly for overlays, menus, dialogs, and raised panels. |
| Icons | Use simple icons for recognition. Pair with labels where meaning is not obvious. |
| Color | Use color to signal priority, state, and selection. Avoid decorative color overload. |
| Motion | Use short, purposeful transitions. Respect reduced-motion preferences. |

## Layout Density

Operational applications should be compact and efficient. Users should be able to scan many records, compare state, and act quickly.

| UI type | Density guidance |
| --- | --- |
| Work queues | Compact rows, visible filters, saved views, bulk actions, priority/status columns |
| Data tables | Compact by default with user-adjustable density and column visibility |
| Forms | Use compact spacing while preserving readable labels, validation, and touch targets |
| Record details | Summary header, key fields, tabs, related lists, activity, and actions |
| Dashboards | More spacious composition with KPI tiles, charts, trend panels, and drill-down links |
| Admin screens | Compact tables and forms, clear grouping, strong validation, audit visibility |
| Mobile screens | Do not simply shrink desktop tables. Use stacked summaries, filters, drawers, and focused task flows. |

Compact does not mean cramped. Preserve readability, accessible hit targets, clear focus, and meaningful whitespace.

## Page Templates

Every app should use one or more standard page templates.

| Template | Purpose | Required elements |
| --- | --- | --- |
| List and workbench | Manage operational records, queues, tasks, orders, tickets, customers, resources | Page header, saved views, filters, data grid, bulk actions, row actions, empty/loading/error states |
| Record detail | View and act on one business entity | Entity header, lifecycle status, key fields, primary actions, tabs, related lists, activity timeline |
| Create or edit form | Create or maintain structured data | Form title, required field indicators, validation summary, save/cancel actions, dirty-state warning |
| Wizard or guided flow | Complete multi-step operational processes | Step indicator, validation per step, review step, save draft, cancel/exit path |
| Dashboard | Monitor KPIs, trends, exceptions, and operational health | Time range, refresh state, KPI tiles, charts, drill-downs, exception lists |
| Configuration | Manage rules, policies, mappings, and app settings | Grouped settings, audit metadata, validation, test/simulate where relevant |
| Full-screen operational view | Maps, topology, command centers, wallboards, labs | Full-screen canvas, persistent escape navigation, contextual side panels, zoom/filter controls |

New page types should be added to the design system before being repeated across apps.

## Data Grid Standard

Data grids are central to TelcoSuite. Use `@telcosuite/data-grid` over direct table implementation for repeated operational tables.

Required behavior:

- Server-side pagination, sorting, and filtering for large datasets.
- Saved views with filters, columns, sort, and density preferences.
- Column resizing and visibility controls where useful.
- Frozen key columns only when they materially improve scanning.
- Bulk selection and bulk actions where business rules allow it.
- Row-level primary action and overflow menu.
- Clear loading, empty, error, no-permission, and no-results states.
- Export only when allowed by permission, data policy, and privacy rules.
- Keyboard-accessible row navigation and action menus.
- Mobile fallback pattern for important tables.

Avoid custom table implementations unless the table is truly unique, such as topology adjacency, schedule grids, or visual planning canvases.

## Forms Standard

Forms should be reusable, predictable, and hard to misuse.

Required behavior:

- Labels are always visible, not placeholder-only.
- Required fields are clearly indicated.
- Validation errors appear near the field and in a summary for long forms.
- Use consistent formats for dates, times, currencies, identifiers, phone numbers, and addresses.
- Use lookup components for selecting customers, accounts, products, resources, places, users, teams, and related entities.
- Warn before losing unsaved changes.
- Support save draft where workflows are long or operationally interruptible.
- Keep keyboard traversal logical.
- Avoid building custom controls when PrimeNG plus TelcoSuite wrappers can handle the need.

## Dashboard Standard

Dashboards should be useful for monitoring and decision-making, not decorative landing pages.

Required behavior:

- Use clear KPI definitions, units, and time ranges.
- Show last refreshed time and data freshness when relevant.
- Use charts only when they help compare, trend, or diagnose.
- Provide drill-downs from KPI and chart elements into operational lists.
- Avoid overusing color. Use status colors consistently.
- Support responsive layouts that preserve chart readability.
- Include loading, unavailable, partial-data, and permission-limited states.

## Status And Severity

Use shared status and severity language across all apps.

| Semantic state | Use for |
| --- | --- |
| Neutral | Draft, pending, inactive, informational, not started |
| Info | In progress, scheduled, updated, acknowledged |
| Success | Completed, active, passed, healthy, approved |
| Warning | At risk, degraded, due soon, partial, blocked by dependency |
| Danger | Failed, overdue, rejected, critical, breached, outage |

Every app should map domain-specific states into these shared semantic categories while preserving the exact domain label for business meaning.

## Accessibility Standard

WCAG 2.2 AA is the minimum standard for TelcoSuite.

Required behavior:

- Keyboard access for all interactive controls.
- Visible focus indicators.
- Sufficient contrast in light and dark modes.
- Accessible names for icon-only buttons.
- ARIA usage for menus, dialogs, tabs, toasts, tables, and dynamic regions where needed.
- Screen-reader friendly loading, error, validation, and status changes.
- Reduced-motion support.
- No color-only state communication.
- Logical heading order.
- Responsive layouts that do not trap or hide required functionality.

Accessibility failures are product quality defects, not optional polish work.

## Responsive Behavior

TelcoSuite must consider all device types, but not every workflow needs identical behavior on every device.

| Device class | Guidance |
| --- | --- |
| Desktop | Primary experience for dense enterprise operations, administration, dashboards, and command workflows |
| Tablet | First-class for field work, approvals, dashboards, inventory inspection, and operational reviews |
| Mobile | First-class for approvals, notifications, lightweight tasks, status checks, field updates, and focused workflows |

For mobile, replace dense desktop tables with summary cards, search, filters, and detail drill-downs. Do not hide critical actions without a mobile alternative.

## Reusable Component Strategy

To avoid repeated custom implementation, each app should assemble pages from shared TelcoSuite building blocks.

| Reusable component | Purpose |
| --- | --- |
| App shell | Standard navigation, search, context, preferences, and user controls |
| Page header | Title, subtitle, breadcrumbs, entity summary, status, and primary actions |
| Action bar | Standard placement for create, save, submit, approve, assign, export, and overflow actions |
| Filter bar | Common filters, advanced filters, saved views, reset, and search within page |
| Data grid | Standard operational table behavior |
| Entity summary | Customer, account, order, resource, service, ticket, party, agreement, or location summary |
| Status badge | Shared semantic status, severity, and lifecycle rendering |
| Timeline | Activities, lifecycle events, approvals, tasks, changes, and audit trail |
| Form field | Label, help text, validation, required marker, accessibility, and layout |
| Lookup field | Reusable remote search and selection for business entities |
| Empty state | Helpful state for no records, no search results, no permissions, and first use |
| Error state | Recoverable error, retry, support detail, and correlation ID display |
| Skeleton loader | Loading state for tables, forms, record headers, dashboards, and side panels |
| Confirmation dialog | Destructive or irreversible action confirmation |
| Audit metadata | Created by, updated by, timestamps, source, version, and traceability |

When a feature team needs a new reusable component, it should be added to the shared UI library if at least two apps or modules are likely to need it.

## Domain UI Patterns

Because TelcoSuite is a telecom product suite, some domain patterns should be standardized early.

| Pattern | Applies to |
| --- | --- |
| Entity lifecycle header | Orders, tickets, agreements, resources, services, customers, parties, appointments |
| Customer/account context panel | BSS, care, billing, assurance, sales, self-care support |
| Service/resource hierarchy viewer | Inventory, topology, fulfillment, assurance, planning |
| Order decomposition view | Product order, service order, resource order, activation, fallout |
| Work queue | Fulfillment, trouble tickets, incidents, field work, approvals, fraud, collections |
| Timeline and audit trail | Most operational and regulated records |
| Exception and fallout panel | Order fallout, activation failure, incident response, compliance gaps |
| Geographic or topology canvas | Planning, inventory, field work, assurance, impact analysis |

These patterns should be implemented once and configured by app metadata where possible.

## Configuration Model

TelcoSuite UI should be configurable without code changes where practical.

| Configurable item | Examples |
| --- | --- |
| Product identity | Product name, logo, favicon, copyright text |
| Theme | Default mode, accent palette, density, high-contrast preference |
| Navigation | Suites, apps, groups, favorites, permission visibility |
| Shell context | Tenant, market, environment, customer/account, operational domain |
| Data grids | Default columns, saved views, page sizes, exports, row actions |
| Forms | Field visibility, labels, help text, validation messages where safely configurable |
| Dashboards | KPI visibility, chart order, time ranges, refresh cadence |

Configuration must respect authorization and cannot expose hidden fields, actions, or data to unauthorized users.

## Common Shell Feasibility Rules

Use the shared shell by default. Adapt it only when the user workflow requires it.

| Scenario | Decision |
| --- | --- |
| Standard app pages | Use full shared shell. |
| Dense operational workbench | Use shared shell with compact navigation and optional side panels. |
| Dashboard or executive view | Use shared shell with dashboard-friendly page template. |
| Field or mobile task flow | Use responsive shell with simplified navigation and focused actions. |
| Full-screen topology, map, lab, or command view | Use adapted shell with persistent product identity, escape path, user controls, theme, and accessibility. |
| Embedded widget or portal fragment | Use shared tokens and components even when full shell is not present. |

## Build Acceptance Checklist

Every new UI feature should pass this checklist before it is considered ready:

- Uses Angular, PrimeNG, and TelcoSuite shared components unless a documented exception exists.
- Uses semantic design tokens, not hard-coded colors or one-off spacing.
- Works in light mode and dark mode.
- Supports the default monochrome theme and configurable accent palette.
- Uses compact density correctly for operational screens.
- Has responsive behavior for desktop, tablet, and mobile.
- Meets WCAG 2.2 AA expectations for keyboard, focus, labels, contrast, and screen-reader behavior.
- Includes loading, empty, error, no-results, and no-permission states where applicable.
- Uses standard shell, navigation, breadcrumbs, and page templates unless a documented exception exists.
- Avoids custom components when reusable TelcoSuite components are available.
- Documents any new reusable pattern so other apps can adopt it.

## Design Governance

The design system should evolve deliberately.

| Change type | Required action |
| --- | --- |
| New page template | Add to this document before broad use. |
| New reusable component | Add to shared UI library and document usage rules. |
| New accent palette | Verify contrast in light and dark modes. |
| New third-party UI dependency | Follow [Technology Stack Guidance](technology-stack-guidance.md) with open source options, pros and cons, and a decision request. |
| App-specific deviation | Record why the shared pattern does not fit and what reusable learning should come back into the system. |

The goal is not to make every app identical. The goal is to make every app feel unmistakably part of TelcoSuite while preserving the workflow needs of each suite.
