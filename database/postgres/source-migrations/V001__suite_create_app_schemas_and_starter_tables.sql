-- TelcoSuite starter DDL for OSS Operations And Assurance
-- Target database: ts_oss_operations_assurance
-- Source model: planning/suite-details/04-oss-operations-assurance/data-model.md
-- Migration type: Flyway SQL migration, run while connected to ts_oss_operations_assurance.
-- Purpose: create app schemas, starter tables, standard controls, and app event outboxes.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SCHEMA IF NOT EXISTS noc_assurance;
COMMENT ON SCHEMA noc_assurance IS 'App-owned schema for NOC And Assurance in OSS Operations And Assurance.';
CREATE SCHEMA IF NOT EXISTS performance_quality_sla;
COMMENT ON SCHEMA performance_quality_sla IS 'App-owned schema for Performance, Quality, And SLA in OSS Operations And Assurance.';
CREATE SCHEMA IF NOT EXISTS change_maintenance;
COMMENT ON SCHEMA change_maintenance IS 'App-owned schema for Change And Maintenance Operations in OSS Operations And Assurance.';
CREATE SCHEMA IF NOT EXISTS cross_assurance_shared;
COMMENT ON SCHEMA cross_assurance_shared IS 'App-owned schema for Cross-Assurance Shared Modules in OSS Operations And Assurance.';

CREATE TABLE IF NOT EXISTS noc_assurance.raw_event_ingestion (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_raw_event_ingestion_canonica_49d40da1 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_raw_event_ingestion_version_5e383e0d CHECK (version > 0),
    CONSTRAINT ck_noc_assur_raw_event_ingestion_validity_0b63afe2 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_raw_event_ingestion_canonica_3b6ea143 ON noc_assurance.raw_event_ingestion (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_raw_event_ingestion_status_8c6fa8bb ON noc_assurance.raw_event_ingestion (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_raw_event_ingestion_updated_0bdc3e3c ON noc_assurance.raw_event_ingestion (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_raw_event_ingestion_source_c7080b35 ON noc_assurance.raw_event_ingestion (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_raw_event_ingestion_attrgin_74fb17f6 ON noc_assurance.raw_event_ingestion USING gin (attributes);
COMMENT ON TABLE noc_assurance.raw_event_ingestion IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.raw_event_ingestion.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.raw_event_ingestion.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.raw_event_ingestion.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.alarm (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_alarm_canonica_5e88f0c6 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_alarm_version_f8c2ab59 CHECK (version > 0),
    CONSTRAINT ck_noc_assur_alarm_validity_2dec2810 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_canonica_f5902755 ON noc_assurance.alarm (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_status_ca5e392a ON noc_assurance.alarm (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_updated_f2cd81b7 ON noc_assurance.alarm (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_source_2d8aa3fc ON noc_assurance.alarm (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_attrgin_fc03de1e ON noc_assurance.alarm USING gin (attributes);
COMMENT ON TABLE noc_assurance.alarm IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.alarm.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.alarm.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.alarm.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.alarm_correlation (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_alarm_correlation_canonica_7cb90cb0 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_alarm_correlation_version_7062fe92 CHECK (version > 0),
    CONSTRAINT ck_noc_assur_alarm_correlation_validity_1d800359 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_correlation_canonica_9d34967c ON noc_assurance.alarm_correlation (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_correlation_status_262e6164 ON noc_assurance.alarm_correlation (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_correlation_updated_1458b63e ON noc_assurance.alarm_correlation (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_correlation_source_5e05c46e ON noc_assurance.alarm_correlation (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_alarm_correlation_attrgin_0225e50f ON noc_assurance.alarm_correlation USING gin (attributes);
COMMENT ON TABLE noc_assurance.alarm_correlation IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.alarm_correlation.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.alarm_correlation.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.alarm_correlation.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.impact_result (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_impact_result_canonica_9234649c UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_impact_result_version_21803133 CHECK (version > 0),
    CONSTRAINT ck_noc_assur_impact_result_validity_0775049f CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_impact_result_canonica_605b78a4 ON noc_assurance.impact_result (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_impact_result_status_32c01929 ON noc_assurance.impact_result (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_impact_result_updated_e4433043 ON noc_assurance.impact_result (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_impact_result_source_e9e59afe ON noc_assurance.impact_result (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_impact_result_attrgin_6b5d0610 ON noc_assurance.impact_result USING gin (attributes);
COMMENT ON TABLE noc_assurance.impact_result IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.impact_result.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.impact_result.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.impact_result.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.operational_incident (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_operational_incident_canonica_43307442 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_operational_incident_version_7839589e CHECK (version > 0),
    CONSTRAINT ck_noc_assur_operational_incident_validity_27ef2442 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_operational_incident_canonica_331e72cf ON noc_assurance.operational_incident (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_operational_incident_status_4b04e135 ON noc_assurance.operational_incident (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_operational_incident_updated_0a3a059d ON noc_assurance.operational_incident (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_operational_incident_source_75891547 ON noc_assurance.operational_incident (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_operational_incident_attrgin_e8313392 ON noc_assurance.operational_incident USING gin (attributes);
COMMENT ON TABLE noc_assurance.operational_incident IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.operational_incident.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.operational_incident.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.operational_incident.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.service_problem (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_service_problem_canonica_00919211 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_service_problem_version_23ac4e77 CHECK (version > 0),
    CONSTRAINT ck_noc_assur_service_problem_validity_5ec4f9b0 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_service_problem_canonica_fbac51eb ON noc_assurance.service_problem (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_problem_status_62abe7b8 ON noc_assurance.service_problem (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_problem_updated_8fc9d4cf ON noc_assurance.service_problem (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_problem_source_86ce578f ON noc_assurance.service_problem (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_problem_attrgin_064b1421 ON noc_assurance.service_problem USING gin (attributes);
COMMENT ON TABLE noc_assurance.service_problem IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.service_problem.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.service_problem.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.service_problem.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.trouble_ticket (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_trouble_ticket_canonica_42c50f13 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_trouble_ticket_version_ffb55d2d CHECK (version > 0),
    CONSTRAINT ck_noc_assur_trouble_ticket_validity_778c4a6b CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_trouble_ticket_canonica_6cba08e8 ON noc_assurance.trouble_ticket (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_trouble_ticket_status_7de623db ON noc_assurance.trouble_ticket (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_trouble_ticket_updated_1b3fcc36 ON noc_assurance.trouble_ticket (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_trouble_ticket_source_0c720336 ON noc_assurance.trouble_ticket (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_trouble_ticket_attrgin_1d8c6c43 ON noc_assurance.trouble_ticket USING gin (attributes);
COMMENT ON TABLE noc_assurance.trouble_ticket IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.trouble_ticket.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.trouble_ticket.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.trouble_ticket.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.service_test_request (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_service_test_request_canonica_42218ad0 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_service_test_request_version_d73b613b CHECK (version > 0),
    CONSTRAINT ck_noc_assur_service_test_request_validity_a7de9176 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_request_canonica_0cd2d42f ON noc_assurance.service_test_request (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_request_status_711af2e1 ON noc_assurance.service_test_request (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_request_updated_fbf1196f ON noc_assurance.service_test_request (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_request_source_ab2164f6 ON noc_assurance.service_test_request (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_request_attrgin_208b62a6 ON noc_assurance.service_test_request USING gin (attributes);
COMMENT ON TABLE noc_assurance.service_test_request IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.service_test_request.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.service_test_request.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.service_test_request.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.service_test_result (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_service_test_result_canonica_8073dcce UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_service_test_result_version_8ee7b985 CHECK (version > 0),
    CONSTRAINT ck_noc_assur_service_test_result_validity_ec8b9fe0 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_result_canonica_b2c854be ON noc_assurance.service_test_result (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_result_status_cee711cf ON noc_assurance.service_test_result (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_result_updated_90353535 ON noc_assurance.service_test_result (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_result_source_fd30d8bc ON noc_assurance.service_test_result (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_service_test_result_attrgin_405b5d30 ON noc_assurance.service_test_result USING gin (attributes);
COMMENT ON TABLE noc_assurance.service_test_result IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.service_test_result.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.service_test_result.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.service_test_result.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.remediation_task (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_noc_assur_remediation_task_canonica_904d2e8e UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_noc_assur_remediation_task_version_ac57570f CHECK (version > 0),
    CONSTRAINT ck_noc_assur_remediation_task_validity_868ecd84 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_remediation_task_canonica_53b702cd ON noc_assurance.remediation_task (canonical_id);
CREATE INDEX IF NOT EXISTS ix_noc_assur_remediation_task_status_66c80dad ON noc_assurance.remediation_task (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_noc_assur_remediation_task_updated_c2297ca7 ON noc_assurance.remediation_task (updated_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_remediation_task_source_0d88fb3e ON noc_assurance.remediation_task (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_noc_assur_remediation_task_attrgin_35a6e66a ON noc_assurance.remediation_task USING gin (attributes);
COMMENT ON TABLE noc_assurance.remediation_task IS 'Starter table for NOC And Assurance. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN noc_assurance.remediation_task.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN noc_assurance.remediation_task.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN noc_assurance.remediation_task.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS noc_assurance.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_noc_assur_event_outbox_status_9b7a8565 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_noc_assur_event_outbox_publish_38c6c60a ON noc_assurance.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_event_outbox_eventkey_dfff112d ON noc_assurance.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_noc_assur_event_outbox_agg_0ce0596e ON noc_assurance.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE noc_assurance.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS performance_quality_sla.performance_measurement (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_performan_performance_measurement_canonica_d6c81967 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_performan_performance_measurement_version_400a2c95 CHECK (version > 0),
    CONSTRAINT ck_performan_performance_measurement_validity_bac36e2d CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_performan_performance_measurement_canonica_c134f506 ON performance_quality_sla.performance_measurement (canonical_id);
CREATE INDEX IF NOT EXISTS ix_performan_performance_measurement_status_68bace11 ON performance_quality_sla.performance_measurement (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_performan_performance_measurement_updated_250372aa ON performance_quality_sla.performance_measurement (updated_at);
CREATE INDEX IF NOT EXISTS ix_performan_performance_measurement_source_e71b2728 ON performance_quality_sla.performance_measurement (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_performan_performance_measurement_attrgin_41fd9717 ON performance_quality_sla.performance_measurement USING gin (attributes);
COMMENT ON TABLE performance_quality_sla.performance_measurement IS 'Starter table for Performance, Quality, And SLA. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN performance_quality_sla.performance_measurement.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN performance_quality_sla.performance_measurement.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN performance_quality_sla.performance_measurement.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS performance_quality_sla.performance_threshold (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_performan_performance_threshold_canonica_24b43456 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_performan_performance_threshold_version_883c83cd CHECK (version > 0),
    CONSTRAINT ck_performan_performance_threshold_validity_e6ef7d2b CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_performan_performance_threshold_canonica_c6e77f46 ON performance_quality_sla.performance_threshold (canonical_id);
CREATE INDEX IF NOT EXISTS ix_performan_performance_threshold_status_8c7156eb ON performance_quality_sla.performance_threshold (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_performan_performance_threshold_updated_74fab138 ON performance_quality_sla.performance_threshold (updated_at);
CREATE INDEX IF NOT EXISTS ix_performan_performance_threshold_source_033da133 ON performance_quality_sla.performance_threshold (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_performan_performance_threshold_attrgin_769175fe ON performance_quality_sla.performance_threshold USING gin (attributes);
COMMENT ON TABLE performance_quality_sla.performance_threshold IS 'Starter table for Performance, Quality, And SLA. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN performance_quality_sla.performance_threshold.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN performance_quality_sla.performance_threshold.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN performance_quality_sla.performance_threshold.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS performance_quality_sla.service_quality_score (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_performan_service_quality_score_canonica_7841daff UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_performan_service_quality_score_version_75c55f1b CHECK (version > 0),
    CONSTRAINT ck_performan_service_quality_score_validity_e2694914 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_performan_service_quality_score_canonica_9be069cb ON performance_quality_sla.service_quality_score (canonical_id);
CREATE INDEX IF NOT EXISTS ix_performan_service_quality_score_status_eb98e633 ON performance_quality_sla.service_quality_score (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_performan_service_quality_score_updated_c0c18a4f ON performance_quality_sla.service_quality_score (updated_at);
CREATE INDEX IF NOT EXISTS ix_performan_service_quality_score_source_9db8919e ON performance_quality_sla.service_quality_score (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_performan_service_quality_score_attrgin_50253ac0 ON performance_quality_sla.service_quality_score USING gin (attributes);
COMMENT ON TABLE performance_quality_sla.service_quality_score IS 'Starter table for Performance, Quality, And SLA. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN performance_quality_sla.service_quality_score.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN performance_quality_sla.service_quality_score.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN performance_quality_sla.service_quality_score.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS performance_quality_sla.service_quality_objective (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_performan_service_quality_objective_canonica_07688ff9 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_performan_service_quality_objective_version_e751151c CHECK (version > 0),
    CONSTRAINT ck_performan_service_quality_objective_validity_013c75ee CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_performan_service_quality_objective_canonica_8781e1ab ON performance_quality_sla.service_quality_objective (canonical_id);
CREATE INDEX IF NOT EXISTS ix_performan_service_quality_objective_status_b9b26b23 ON performance_quality_sla.service_quality_objective (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_performan_service_quality_objective_updated_2462cc32 ON performance_quality_sla.service_quality_objective (updated_at);
CREATE INDEX IF NOT EXISTS ix_performan_service_quality_objective_source_75e63277 ON performance_quality_sla.service_quality_objective (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_performan_service_quality_objective_attrgin_d50cd31f ON performance_quality_sla.service_quality_objective USING gin (attributes);
COMMENT ON TABLE performance_quality_sla.service_quality_objective IS 'Starter table for Performance, Quality, And SLA. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN performance_quality_sla.service_quality_objective.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN performance_quality_sla.service_quality_objective.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN performance_quality_sla.service_quality_objective.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS performance_quality_sla.sla_calculation (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_performan_sla_calculation_canonica_cffb7f7b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_performan_sla_calculation_version_1e8b04c7 CHECK (version > 0),
    CONSTRAINT ck_performan_sla_calculation_validity_a1aa9551 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_performan_sla_calculation_canonica_b3865ba0 ON performance_quality_sla.sla_calculation (canonical_id);
CREATE INDEX IF NOT EXISTS ix_performan_sla_calculation_status_4f17e717 ON performance_quality_sla.sla_calculation (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_performan_sla_calculation_updated_4569993e ON performance_quality_sla.sla_calculation (updated_at);
CREATE INDEX IF NOT EXISTS ix_performan_sla_calculation_source_e1854c36 ON performance_quality_sla.sla_calculation (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_performan_sla_calculation_attrgin_9c6b7316 ON performance_quality_sla.sla_calculation USING gin (attributes);
COMMENT ON TABLE performance_quality_sla.sla_calculation IS 'Starter table for Performance, Quality, And SLA. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN performance_quality_sla.sla_calculation.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN performance_quality_sla.sla_calculation.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN performance_quality_sla.sla_calculation.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS performance_quality_sla.sla_breach_evidence (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_performan_sla_breach_evidence_canonica_aab96e3b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_performan_sla_breach_evidence_version_f4eb0bdb CHECK (version > 0),
    CONSTRAINT ck_performan_sla_breach_evidence_validity_1dc7b1d8 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_performan_sla_breach_evidence_canonica_f2e21657 ON performance_quality_sla.sla_breach_evidence (canonical_id);
CREATE INDEX IF NOT EXISTS ix_performan_sla_breach_evidence_status_b06a8b60 ON performance_quality_sla.sla_breach_evidence (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_performan_sla_breach_evidence_updated_3e5cf7fb ON performance_quality_sla.sla_breach_evidence (updated_at);
CREATE INDEX IF NOT EXISTS ix_performan_sla_breach_evidence_source_b09ac4f5 ON performance_quality_sla.sla_breach_evidence (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_performan_sla_breach_evidence_attrgin_f31207e9 ON performance_quality_sla.sla_breach_evidence USING gin (attributes);
COMMENT ON TABLE performance_quality_sla.sla_breach_evidence IS 'Starter table for Performance, Quality, And SLA. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN performance_quality_sla.sla_breach_evidence.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN performance_quality_sla.sla_breach_evidence.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN performance_quality_sla.sla_breach_evidence.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS performance_quality_sla.quality_analytics_output (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_performan_quality_analytics_output_canonica_690ae7a4 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_performan_quality_analytics_output_version_ce0c4e5d CHECK (version > 0),
    CONSTRAINT ck_performan_quality_analytics_output_validity_aebf2411 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_performan_quality_analytics_output_canonica_113f8534 ON performance_quality_sla.quality_analytics_output (canonical_id);
CREATE INDEX IF NOT EXISTS ix_performan_quality_analytics_output_status_b5610c4a ON performance_quality_sla.quality_analytics_output (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_performan_quality_analytics_output_updated_e4007127 ON performance_quality_sla.quality_analytics_output (updated_at);
CREATE INDEX IF NOT EXISTS ix_performan_quality_analytics_output_source_3984fde2 ON performance_quality_sla.quality_analytics_output (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_performan_quality_analytics_output_attrgin_31626b18 ON performance_quality_sla.quality_analytics_output USING gin (attributes);
COMMENT ON TABLE performance_quality_sla.quality_analytics_output IS 'Starter table for Performance, Quality, And SLA. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN performance_quality_sla.quality_analytics_output.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN performance_quality_sla.quality_analytics_output.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN performance_quality_sla.quality_analytics_output.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS performance_quality_sla.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_performan_event_outbox_status_c3c2b115 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_performan_event_outbox_publish_d9e2b2da ON performance_quality_sla.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_performan_event_outbox_eventkey_feea2158 ON performance_quality_sla.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_performan_event_outbox_agg_1792555c ON performance_quality_sla.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE performance_quality_sla.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS change_maintenance.change_record (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_change_ma_change_record_canonica_6ee6fedb UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_change_ma_change_record_version_fa201c55 CHECK (version > 0),
    CONSTRAINT ck_change_ma_change_record_validity_c1c1e498 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_change_ma_change_record_canonica_f4980447 ON change_maintenance.change_record (canonical_id);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_record_status_6422c348 ON change_maintenance.change_record (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_record_updated_30c75d72 ON change_maintenance.change_record (updated_at);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_record_source_7a28010d ON change_maintenance.change_record (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_change_ma_change_record_attrgin_e87899ab ON change_maintenance.change_record USING gin (attributes);
COMMENT ON TABLE change_maintenance.change_record IS 'Starter table for Change And Maintenance Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN change_maintenance.change_record.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN change_maintenance.change_record.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN change_maintenance.change_record.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS change_maintenance.maintenance_window (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_change_ma_maintenance_window_canonica_bf3b9e43 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_change_ma_maintenance_window_version_2f07dac1 CHECK (version > 0),
    CONSTRAINT ck_change_ma_maintenance_window_validity_5f812c48 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_change_ma_maintenance_window_canonica_849328b1 ON change_maintenance.maintenance_window (canonical_id);
CREATE INDEX IF NOT EXISTS ix_change_ma_maintenance_window_status_a80ff99c ON change_maintenance.maintenance_window (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_change_ma_maintenance_window_updated_ecabc0c5 ON change_maintenance.maintenance_window (updated_at);
CREATE INDEX IF NOT EXISTS ix_change_ma_maintenance_window_source_20304095 ON change_maintenance.maintenance_window (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_change_ma_maintenance_window_attrgin_7a178bf9 ON change_maintenance.maintenance_window USING gin (attributes);
COMMENT ON TABLE change_maintenance.maintenance_window IS 'Starter table for Change And Maintenance Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN change_maintenance.maintenance_window.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN change_maintenance.maintenance_window.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN change_maintenance.maintenance_window.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS change_maintenance.change_risk_impact_assessment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_change_ma_change_risk_impact_assessm_canonica_a1a37495 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_change_ma_change_risk_impact_assessm_version_3bdfcab5 CHECK (version > 0),
    CONSTRAINT ck_change_ma_change_risk_impact_assessm_validity_4856c31e CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_change_ma_change_risk_impact_assessm_canonica_957777c3 ON change_maintenance.change_risk_impact_assessment (canonical_id);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_risk_impact_assessm_status_50827923 ON change_maintenance.change_risk_impact_assessment (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_risk_impact_assessm_updated_7ea8862f ON change_maintenance.change_risk_impact_assessment (updated_at);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_risk_impact_assessm_source_b5ca8b35 ON change_maintenance.change_risk_impact_assessment (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_change_ma_change_risk_impact_assessm_attrgin_a626eca9 ON change_maintenance.change_risk_impact_assessment USING gin (attributes);
COMMENT ON TABLE change_maintenance.change_risk_impact_assessment IS 'Starter table for Change And Maintenance Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN change_maintenance.change_risk_impact_assessment.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN change_maintenance.change_risk_impact_assessment.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN change_maintenance.change_risk_impact_assessment.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS change_maintenance.change_execution_evidence (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_change_ma_change_execution_evidence_canonica_8b89eec8 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_change_ma_change_execution_evidence_version_c101425a CHECK (version > 0),
    CONSTRAINT ck_change_ma_change_execution_evidence_validity_3e72b3b2 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_change_ma_change_execution_evidence_canonica_1a5a5f39 ON change_maintenance.change_execution_evidence (canonical_id);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_execution_evidence_status_23c611db ON change_maintenance.change_execution_evidence (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_execution_evidence_updated_9804b135 ON change_maintenance.change_execution_evidence (updated_at);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_execution_evidence_source_a3c203fd ON change_maintenance.change_execution_evidence (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_change_ma_change_execution_evidence_attrgin_b127e959 ON change_maintenance.change_execution_evidence USING gin (attributes);
COMMENT ON TABLE change_maintenance.change_execution_evidence IS 'Starter table for Change And Maintenance Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN change_maintenance.change_execution_evidence.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN change_maintenance.change_execution_evidence.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN change_maintenance.change_execution_evidence.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS change_maintenance.rollback_plan (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_change_ma_rollback_plan_canonica_ab6fb417 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_change_ma_rollback_plan_version_386e796a CHECK (version > 0),
    CONSTRAINT ck_change_ma_rollback_plan_validity_434af93a CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_change_ma_rollback_plan_canonica_1a7d49ab ON change_maintenance.rollback_plan (canonical_id);
CREATE INDEX IF NOT EXISTS ix_change_ma_rollback_plan_status_b757732e ON change_maintenance.rollback_plan (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_change_ma_rollback_plan_updated_4083afc3 ON change_maintenance.rollback_plan (updated_at);
CREATE INDEX IF NOT EXISTS ix_change_ma_rollback_plan_source_c614fb7f ON change_maintenance.rollback_plan (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_change_ma_rollback_plan_attrgin_90cd374f ON change_maintenance.rollback_plan USING gin (attributes);
COMMENT ON TABLE change_maintenance.rollback_plan IS 'Starter table for Change And Maintenance Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN change_maintenance.rollback_plan.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN change_maintenance.rollback_plan.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN change_maintenance.rollback_plan.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS change_maintenance.change_communication_plan (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_change_ma_change_communication_plan_canonica_58e60b82 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_change_ma_change_communication_plan_version_d98ccfe6 CHECK (version > 0),
    CONSTRAINT ck_change_ma_change_communication_plan_validity_c3934a67 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_change_ma_change_communication_plan_canonica_555a7dfc ON change_maintenance.change_communication_plan (canonical_id);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_communication_plan_status_122d18e8 ON change_maintenance.change_communication_plan (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_communication_plan_updated_de240d78 ON change_maintenance.change_communication_plan (updated_at);
CREATE INDEX IF NOT EXISTS ix_change_ma_change_communication_plan_source_1d21abc7 ON change_maintenance.change_communication_plan (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_change_ma_change_communication_plan_attrgin_57e45039 ON change_maintenance.change_communication_plan USING gin (attributes);
COMMENT ON TABLE change_maintenance.change_communication_plan IS 'Starter table for Change And Maintenance Operations. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN change_maintenance.change_communication_plan.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN change_maintenance.change_communication_plan.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN change_maintenance.change_communication_plan.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS change_maintenance.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_change_ma_event_outbox_status_3a6cced3 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_change_ma_event_outbox_publish_c42b7d30 ON change_maintenance.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_change_ma_event_outbox_eventkey_26e00f9d ON change_maintenance.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_change_ma_event_outbox_agg_3ae3fd75 ON change_maintenance.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE change_maintenance.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS cross_assurance_shared.known_error (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_cross_ass_known_error_canonica_2536b5fa UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_cross_ass_known_error_version_685e2cf9 CHECK (version > 0),
    CONSTRAINT ck_cross_ass_known_error_validity_37954d41 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_cross_ass_known_error_canonica_5fd5b770 ON cross_assurance_shared.known_error (canonical_id);
CREATE INDEX IF NOT EXISTS ix_cross_ass_known_error_status_392034e7 ON cross_assurance_shared.known_error (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_cross_ass_known_error_updated_ed65b5b6 ON cross_assurance_shared.known_error (updated_at);
CREATE INDEX IF NOT EXISTS ix_cross_ass_known_error_source_f82b260e ON cross_assurance_shared.known_error (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_cross_ass_known_error_attrgin_4ce4cbc3 ON cross_assurance_shared.known_error USING gin (attributes);
COMMENT ON TABLE cross_assurance_shared.known_error IS 'Starter table for Cross-Assurance Shared Modules. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN cross_assurance_shared.known_error.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN cross_assurance_shared.known_error.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN cross_assurance_shared.known_error.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS cross_assurance_shared.knowledge_article (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_cross_ass_knowledge_article_canonica_65753c00 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_cross_ass_knowledge_article_version_6542e759 CHECK (version > 0),
    CONSTRAINT ck_cross_ass_knowledge_article_validity_9e8ecfb3 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_cross_ass_knowledge_article_canonica_8ad9e130 ON cross_assurance_shared.knowledge_article (canonical_id);
CREATE INDEX IF NOT EXISTS ix_cross_ass_knowledge_article_status_b4ee7519 ON cross_assurance_shared.knowledge_article (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_cross_ass_knowledge_article_updated_03e03d98 ON cross_assurance_shared.knowledge_article (updated_at);
CREATE INDEX IF NOT EXISTS ix_cross_ass_knowledge_article_source_c5419ac3 ON cross_assurance_shared.knowledge_article (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_cross_ass_knowledge_article_attrgin_85abddf6 ON cross_assurance_shared.knowledge_article USING gin (attributes);
COMMENT ON TABLE cross_assurance_shared.knowledge_article IS 'Starter table for Cross-Assurance Shared Modules. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN cross_assurance_shared.knowledge_article.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN cross_assurance_shared.knowledge_article.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN cross_assurance_shared.knowledge_article.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS cross_assurance_shared.assurance_playbook (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_cross_ass_assurance_playbook_canonica_be10c7ac UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_cross_ass_assurance_playbook_version_4983d351 CHECK (version > 0),
    CONSTRAINT ck_cross_ass_assurance_playbook_validity_ac98c5c4 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_cross_ass_assurance_playbook_canonica_8ba4e1a4 ON cross_assurance_shared.assurance_playbook (canonical_id);
CREATE INDEX IF NOT EXISTS ix_cross_ass_assurance_playbook_status_db258fc1 ON cross_assurance_shared.assurance_playbook (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_cross_ass_assurance_playbook_updated_69b08ce6 ON cross_assurance_shared.assurance_playbook (updated_at);
CREATE INDEX IF NOT EXISTS ix_cross_ass_assurance_playbook_source_51cdc881 ON cross_assurance_shared.assurance_playbook (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_cross_ass_assurance_playbook_attrgin_7dd06f9f ON cross_assurance_shared.assurance_playbook USING gin (attributes);
COMMENT ON TABLE cross_assurance_shared.assurance_playbook IS 'Starter table for Cross-Assurance Shared Modules. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN cross_assurance_shared.assurance_playbook.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN cross_assurance_shared.assurance_playbook.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN cross_assurance_shared.assurance_playbook.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS cross_assurance_shared.automation_action_template (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_cross_ass_automation_action_template_canonica_e77b3ad5 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_cross_ass_automation_action_template_version_f19e0973 CHECK (version > 0),
    CONSTRAINT ck_cross_ass_automation_action_template_validity_dd870e4a CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_cross_ass_automation_action_template_canonica_24c8598e ON cross_assurance_shared.automation_action_template (canonical_id);
CREATE INDEX IF NOT EXISTS ix_cross_ass_automation_action_template_status_6bed8a4b ON cross_assurance_shared.automation_action_template (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_cross_ass_automation_action_template_updated_564946b5 ON cross_assurance_shared.automation_action_template (updated_at);
CREATE INDEX IF NOT EXISTS ix_cross_ass_automation_action_template_source_c0827cb8 ON cross_assurance_shared.automation_action_template (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_cross_ass_automation_action_template_attrgin_b817f845 ON cross_assurance_shared.automation_action_template USING gin (attributes);
COMMENT ON TABLE cross_assurance_shared.automation_action_template IS 'Starter table for Cross-Assurance Shared Modules. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN cross_assurance_shared.automation_action_template.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN cross_assurance_shared.automation_action_template.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN cross_assurance_shared.automation_action_template.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS cross_assurance_shared.operational_command_center_session (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_cross_ass_operational_command_center_canonica_63b6830b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_cross_ass_operational_command_center_version_218eabea CHECK (version > 0),
    CONSTRAINT ck_cross_ass_operational_command_center_validity_0d974674 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_cross_ass_operational_command_center_canonica_81420b5e ON cross_assurance_shared.operational_command_center_session (canonical_id);
CREATE INDEX IF NOT EXISTS ix_cross_ass_operational_command_center_status_d3c11f35 ON cross_assurance_shared.operational_command_center_session (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_cross_ass_operational_command_center_updated_6abc58d6 ON cross_assurance_shared.operational_command_center_session (updated_at);
CREATE INDEX IF NOT EXISTS ix_cross_ass_operational_command_center_source_b08336c6 ON cross_assurance_shared.operational_command_center_session (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_cross_ass_operational_command_center_attrgin_6f10b995 ON cross_assurance_shared.operational_command_center_session USING gin (attributes);
COMMENT ON TABLE cross_assurance_shared.operational_command_center_session IS 'Starter table for Cross-Assurance Shared Modules. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN cross_assurance_shared.operational_command_center_session.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN cross_assurance_shared.operational_command_center_session.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN cross_assurance_shared.operational_command_center_session.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS cross_assurance_shared.shift_handover_note (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_cross_ass_shift_handover_note_canonica_e3567ef7 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_cross_ass_shift_handover_note_version_ff06bdda CHECK (version > 0),
    CONSTRAINT ck_cross_ass_shift_handover_note_validity_d28e99ef CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_cross_ass_shift_handover_note_canonica_793cf004 ON cross_assurance_shared.shift_handover_note (canonical_id);
CREATE INDEX IF NOT EXISTS ix_cross_ass_shift_handover_note_status_564f4f48 ON cross_assurance_shared.shift_handover_note (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_cross_ass_shift_handover_note_updated_8139b0a4 ON cross_assurance_shared.shift_handover_note (updated_at);
CREATE INDEX IF NOT EXISTS ix_cross_ass_shift_handover_note_source_b0655fc6 ON cross_assurance_shared.shift_handover_note (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_cross_ass_shift_handover_note_attrgin_eaa91978 ON cross_assurance_shared.shift_handover_note USING gin (attributes);
COMMENT ON TABLE cross_assurance_shared.shift_handover_note IS 'Starter table for Cross-Assurance Shared Modules. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN cross_assurance_shared.shift_handover_note.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN cross_assurance_shared.shift_handover_note.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN cross_assurance_shared.shift_handover_note.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS cross_assurance_shared.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_cross_ass_event_outbox_status_a835bc2c CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_cross_ass_event_outbox_publish_11570c5c ON cross_assurance_shared.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_cross_ass_event_outbox_eventkey_c743d3df ON cross_assurance_shared.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_cross_ass_event_outbox_agg_40bdc3bf ON cross_assurance_shared.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE cross_assurance_shared.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';


GRANT USAGE ON SCHEMA noc_assurance TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA noc_assurance TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA noc_assurance TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA noc_assurance GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA noc_assurance GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA performance_quality_sla TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA performance_quality_sla TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA performance_quality_sla TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA performance_quality_sla GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA performance_quality_sla GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA change_maintenance TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA change_maintenance TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA change_maintenance TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA change_maintenance GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA change_maintenance GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA cross_assurance_shared TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA cross_assurance_shared TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA cross_assurance_shared TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA cross_assurance_shared GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA cross_assurance_shared GRANT SELECT ON TABLES TO telcosuite_readonly;
