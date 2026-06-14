# Change And Maintenance Operations P02 - Phase 2 Foundation Development Tasks

Suite: OSS Operations And Assurance

App: Change And Maintenance Operations

App slug: `change-maintenance-operations`

Implementation repository: `ts-oss-ops-change-maintenance-operations`

Phase: P02 - Phase 2 Foundation

Phase file: `p02-phase-2-foundation.md`

Phase rationale: Build the first feature-area foundation specific to Change And Maintenance Operations before the next set of capability slices can be built.

Phase exit gate: First feature-area foundation in `change_maintenance` is testable against the V001/V00X migrations and TMF-aligned APIs.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- [cab-emergency-change-and-collision-detection](../planning/app-detail/features/cab-emergency-change-and-collision-detection.md)
- [customer-and-stakeholder-communication](../planning/app-detail/features/customer-and-stakeholder-communication.md)

## Phase Tasks

### DT-01-change-maintenance-operations-P02-T001: Implement P02 - Phase 2 Foundation enablement and cross-feature controls

| Field | Value |
| --- | --- |
| Phase | P02 - Phase 2 Foundation |
| Priority | P0 |
| Source evidence | [App README](../README.md), [Modules and features](../planning/app-detail/modules-and-features.md), [Personas and journeys](../planning/app-detail/personas-and-user-journeys.md), [Suite data model](../../data-model.md), [TMF review](../../tmf-api-ddl-reviews/change-maintenance.md) |
| Feature or module | Phase enablement and cross-feature controls |
| Build area | API/Data/Event |
| Dependencies | DT-01-change-maintenance-operations-P01-T012 (or earlier phase exit gate) |
| Outputs | Phase readiness evidence, implementation notes, task dependencies, and tracker updates. |

#### Implementation Notes

- Use this phase to establish or refine the app-specific delivery controls for P02 - Phase 2 Foundation.
- Confirm phase scope, exit gate, source evidence, app-owned schema `change_maintenance`, TMF/API posture (TMF655, TMF681, TMF696, TMF638, TMF639, TMF701, TMF640, TMF629), migration order, and no-direct-cross-app-write rules.
- Update the tracker and feature-slice coverage matrix when scope, dependencies, or implementation evidence changes.

#### Phase-Specific Build Details

- Feature specs in this phase: cab-emergency-change-and-collision-detection, customer-and-stakeholder-communication.
- Required screens/workbenches to implement or refine in this phase: derived from the per-feature feature specs in `docs/planning/app-detail/features/`.
- Required events to implement or disposition: derived from the per-feature event contracts.
- Required data/table groups: derived from the per-feature data ownership statements and the V001/V00X migration baseline.

#### Acceptance Criteria

1. Given the P02 - Phase 2 Foundation exit gate, when the tasks in this phase complete, then the documented evidence is produced and the tracker is updated.
2. Given the P02 - Phase 2 Foundation feature coverage list, when the tasks in this phase complete, then every source feature has at least one implementation task in the tracker.
3. Given cross-app boundaries, when the tasks in this phase complete, then the app does not write to any other app's schema or rely on cross-app joins.

#### Definition of Done

- Phase exit gate evidence is recorded.
- Tracker is updated with implementation evidence.
- Cross-app boundary rules are preserved.

#### Negative Scenarios

- Do not bypass audit, masking, or tenant controls.
- Do not publish events from controllers without going through the outbox.

#### Edge Cases

- Out-of-order phase work must still preserve the no-direct-cross-app-write rule.
- TMF coverage gaps must be documented as non-TMF extensions.

#### Test Expectations

- Run unit, contract, integration, and E2E tests appropriate to the phase output.
- Update the tracker with command output, PR links, screenshots, or blocker notes.

### DT-01-change-maintenance-operations-P02-T002: Implement feature-slice coverage and tracker linkage for P02 - Phase 2 Foundation

| Field | Value |
| --- | --- |
| Phase | P02 - Phase 2 Foundation |
| Priority | P0 |
| Source evidence | [Modules and features](../planning/app-detail/modules-and-features.md), [Personas and journeys](../planning/app-detail/personas-and-user-journeys.md) |
| Feature or module | Feature-slice coverage and tracker linkage |
| Build area | Docs/Test |
| Dependencies | DT-01-change-maintenance-operations-P02-T001 |
| Outputs | Tracker linkage for every source feature in this phase, including task IDs, feature names, and slice intent. |

#### Implementation Notes

- For each source feature in this phase, record the feature ID, feature name, source slice file, phase, and tracker task ID.
- Mark coverage as Not Started, In Progress, Blocked, or Complete.
- Surface missing evidence as explicit blockers with owners and target increments.

#### Phase-Specific Build Details

- Source features covered in this phase: cab-emergency-change-and-collision-detection, customer-and-stakeholder-communication.

#### Acceptance Criteria

1. Given the source feature pack, when the tracker linkage is updated, then every source feature is mapped to a DT task.
2. Given an unmapped source feature, when the tracker is reviewed, then it is listed as a blocker with an owner.

#### Definition of Done

- Tracker linkage is complete and current.
- Blockers are visible to the app team.

#### Negative Scenarios

- Do not silently skip features.
- Do not close coverage without evidence.

#### Edge Cases

- Source features may be merged or split; preserve traceability.

#### Test Expectations

- Review the tracker for completeness.
- Update the tracker with command output, screenshots, or blocker notes.

### DT-01-change-maintenance-operations-P02-T003: Prove phase readiness with end-to-end, contract, accessibility, event replay, and reconciliation evidence

| Field | Value |
| --- | --- |
| Phase | P02 - Phase 2 Foundation |
| Priority | P0 |
| Source evidence | [Repository strategy](../../../../repository-strategy.md), [App summary](../../../../../change-maintenance-operations.md) |
| Feature or module | Phase readiness evidence |
| Build area | Test/Ops/Release |
| Dependencies | DT-01-change-maintenance-operations-P02-T002 |
| Outputs | Phase readiness evidence covering E2E, contract, accessibility, event replay, and reconciliation. |

#### Implementation Notes

- Capture test reports, screenshots, and event payloads in the tracker.
- Reconcile cross-app handoffs with consumer acknowledgement evidence.

#### Phase-Specific Build Details

- E2E journeys covered: derived from the persona/user-journey planning.
- Contract tests: derived from the per-feature event/data contracts.
- Accessibility checks: at least the primary screens for this phase.
- Event replay: at least the outbox-to-event-to-consumer path.
- Reconciliation: at least one cross-app handoff.

#### Acceptance Criteria

1. Given the phase readiness checklist, when the evidence is captured, then every item is linked from the tracker.
2. Given a failure, when the evidence is reviewed, then the failure has an owner and a target increment.

#### Definition of Done

- Phase readiness evidence is complete and current.

#### Negative Scenarios

- Do not "make it pass" by skipping reconciliation or event replay.
- Do not close the phase without accessibility evidence.

#### Edge Cases

- Reconciliation may require coordinated work with another app; record the coordination evidence.

#### Test Expectations

- Run the documented test suite.
- Update the tracker with command output, screenshots, and event payloads.
