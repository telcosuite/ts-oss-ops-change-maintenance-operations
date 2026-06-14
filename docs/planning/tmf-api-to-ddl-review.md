# Change And Maintenance Operations TMF API To DDL Review

Reviewed: 2026-06-14

Status: Complete for baseline app implementation. Endpoint-specific contract tests and final story-level field promotion still happen during build.

## Scope

This review covers `change_maintenance` in suite database `ts_oss_operations_assurance`. It uses the local TMF Open API reference set, the suite data model, the API-to-DDL traceability matrix, and the V001 starter DDL.

The review confirms that the app can move into implementation with a V002 typed DDL baseline while preserving full TMF payload compatibility through validated `tmf_payload`, typed common TMF columns, and normalized support tables.

## TMF API Baseline Selection

| TMF API | Local baseline spec | Resources/path roots reviewed | V001 table groups |
| --- | --- | --- | --- |
| TMF655 | `references/tmforum-open-apis/openapi-specs/TMF655_ChangeManagement/TMF655_Change_Management_API_v4.0.0_swagger.json` | `changeRequest` | change_record; maintenance_window; migration_decommissioning_state references |
| TMF681 | `references/tmforum-open-apis/openapi-specs/TMF681_Communication/TMF681_Communication_Management_API_v4.0.0_swagger.json` | `communicationMessage` | communication_record; notification_template; notification_delivery_attempt references |
| TMF696 | `references/tmforum-open-apis/openapi-specs/TMF696_RiskManagement/TMF696_Risk_Management_API_v4.0.0_swagger.json` | `partyRoleProductOfferingRiskAssessment`, `partyRoleRiskAssessment`, `productOfferingRiskAssessment`, `productOrderRiskAssessment`, `shoppingCartRiskAssessment` | rule_definition; decision_definition; credit_decision; risk_exposure; compliance_control |
| TMF638 | `references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory/TMF638-Service_Inventory_Management-v5.0.0.oas.yaml` | `service` | service_inventory; topology_edge; topology_node; discovered_resource_staging |
| TMF639 | `references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory/TMF639-Resource_Inventory_Management-v5.0.0.oas.yaml` | `resource` | resource_inventory; identifier_resource; inventory_location_binding; topology; assignment |
| TMF701 | `references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow/TMF701-ProcessFlow-v4.0.0.swagger.json` | `processFlow` | process_definition; process_version; work_queue; task; provisioning_workflow_state |
| TMF640 | `references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration/TMF640_Service_Activation_Management_API_v4.0.0_swagger.json` | `monitor`, `service` | activation_request; activation_response; restriction/reconnection execution references |
| TMF629 | `references/tmforum-open-apis/openapi-specs/TMF629_CustomerManagement/TMF629-Customer_Management-v5.0.1.oas.yaml` | `customer` | customer; segment and customer-impact snapshots |

## Current DDL Coverage

Current starter DDL is in `database/postgres/suites/ts_oss_operations_assurance/V001__create_app_schemas_and_starter_tables.sql` under schema `change_maintenance`.

| Current table | TMF purpose | V002 decision |
| --- | --- | --- |
| `change_maintenance.change_record` | Starter table for Change And Maintenance Operations; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |
| `change_maintenance.maintenance_window` | Starter table for Change And Maintenance Operations; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |
| `change_maintenance.change_risk_impact_assessment` | Starter table for Change And Maintenance Operations; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |
| `change_maintenance.change_execution_evidence` | Starter table for Change And Maintenance Operations; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |
| `change_maintenance.rollback_plan` | Starter table for Change And Maintenance Operations; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |
| `change_maintenance.change_communication_plan` | Starter table for Change And Maintenance Operations; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |
| `change_maintenance.event_outbox` | App outbox for domain and TMF notification events. | Keep and refine through `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |

## Resource To Table Decisions

| TMF API/resource | Master or anchor table | Path coverage | Promoted field candidates | Field handling strategy |
| --- | --- | --- | --- | --- |
| TMF655 `changeRequest` | `change_maintenance.change_record` | `/changeRequest`, `/changeRequest/{id}` | `id`, `href`, `actualEndTime`, `actualStartTime`, `channel`, `completionDate`, `description`, `impact` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF681 `communicationMessage` | `change_maintenance.change_communication_plan` | `/communicationMessage`, `/communicationMessage/{id}` | `id`, `href`, `content`, `description`, `logFlag`, `messageType`, `priority`, `scheduledSendTime` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `partyRoleProductOfferingRiskAssessment` | `change_maintenance.change_risk_impact_assessment` | `/partyRoleProductOfferingRiskAssessment`, `/partyRoleProductOfferingRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `partyRole`, `place`, `productOffering`, `riskAssessmentResult` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `partyRoleRiskAssessment` | `change_maintenance.change_risk_impact_assessment` | `/partyRoleRiskAssessment`, `/partyRoleRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `riskAssessmentResult`, `@baseType`, `@schemaLocation` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `productOfferingRiskAssessment` | `change_maintenance.change_risk_impact_assessment` | `/productOfferingRiskAssessment`, `/productOfferingRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `partyRole`, `place`, `productOffering`, `riskAssessmentResult` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `productOrderRiskAssessment` | `change_maintenance.change_risk_impact_assessment` | `/productOrderRiskAssessment`, `/productOrderRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `productOrder`, `riskAssessmentResult`, `@baseType` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF696 `shoppingCartRiskAssessment` | `change_maintenance.change_risk_impact_assessment` | `/shoppingCartRiskAssessment`, `/shoppingCartRiskAssessment/{id}` | `id`, `href`, `status`, `characteristic`, `place`, `riskAssessmentResult`, `shoppingCart`, `@baseType` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF638 `service` | `change_maintenance.change_record` | `/service`, `/service/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF639 `resource` | `change_maintenance.change_record` | `/resource`, `/resource/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF701 `processFlow` | `change_maintenance.change_record` | `/processFlow`, `/processFlow/{id}`, `/processFlow/{processFlowId}/taskFlow` | `id`, `href`, `processFlowDate`, `processFlowSpecification`, `channel`, `characteristic`, `relatedEntity`, `relatedParty` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF640 `monitor` | `change_maintenance.change_record` | `/monitor`, `/monitor/{id}` | `id`, `href`, `sourceHref`, `state`, `request`, `response`, `@baseType`, `@schemaLocation` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF640 `service` | `change_maintenance.change_record` | `/service`, `/service/{id}` | `id`, `href`, `category`, `description`, `endDate`, `hasStarted`, `isBundle`, `isServiceEnabled` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF629 `customer` | `change_maintenance.change_record` | `/customer`, `/customer/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |

## V002 DDL Refinement

Migration: `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql`

The migration adds this implementation baseline for the app:

| Area | Decision |
| --- | --- |
| Common TMF fields | Add reusable typed columns such as `tmf_id`, `tmf_href`, `tmf_type`, `tmf_base_type`, `tmf_schema_location`, `tmf_referred_type`, `tmf_name`, `tmf_description`, `tmf_lifecycle_status`, `tmf_state`, dates, priority, and external ID to every V001 app table. |
| Full TMF compatibility | Keep the V001 `tmf_payload` column as the complete validated TMF resource snapshot for fields that are not yet promoted to typed columns. |
| Characteristics and references | Add normalized `tmf_characteristic`, `tmf_resource_reference`, `tmf_external_identifier`, `tmf_related_party`, `tmf_note`, `tmf_attachment`, and `tmf_relationship` support tables. |
| API/resource map | Add `tmf_api_resource_map` rows for the selected local TMF APIs and resource roots. |
| Event contracts | Add baseline event contract rows for create, update, state-change, and delete events per reviewed API resource. |
| Privacy and audit | Add table-level privacy, retention, legal-hold, residency, masking, and audit policy rows. |
| High-volume candidates | `change_maintenance.event_outbox` |

## Event Contract Baseline

Events are registered in `change_maintenance.event_contract` using `change_maintenance.event_outbox` as the publication basis. Consumers must be added when integrations are designed; no app should directly write another app schema.

## Privacy, Retention, And Audit Baseline

| Table | Data classification | Retention class | Audit level |
| --- | --- | --- | --- |
| `change_maintenance.change_record` | internal | domain_lifecycle | standard |
| `change_maintenance.maintenance_window` | internal | domain_lifecycle | standard |
| `change_maintenance.change_risk_impact_assessment` | internal | domain_lifecycle | standard |
| `change_maintenance.change_execution_evidence` | internal | domain_lifecycle | standard |
| `change_maintenance.rollback_plan` | internal | domain_lifecycle | standard |
| `change_maintenance.change_communication_plan` | confidential | business_lifecycle | standard-high |
| `change_maintenance.event_outbox` | internal | operational_telemetry | standard |

## Build Gate Result

| Gate item | Result |
| --- | --- |
| API/resource review | Complete for baseline implementation |
| V002 typed DDL | Complete: `database/postgres/suites/ts_oss_operations_assurance/V004__refine_change_maintenance_tmf_core.sql` |
| Event contract register | Baseline complete |
| Privacy/retention/audit classification | Baseline complete |
| Remaining implementation control | Validate exact endpoint operations and contract tests as Angular/Spring Boot features are built |
