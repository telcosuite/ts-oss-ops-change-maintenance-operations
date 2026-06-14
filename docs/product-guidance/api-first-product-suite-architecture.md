# API-First Telecom Product Suite Architecture

Visual HTML version: [api-first-architecture.html](visuals/api-first-architecture.html)

## Architecture Intent

Build the telecom product suite as a headless, API-first product platform.

Principles:

- Every business capability is exposed through product APIs.
- TM Forum Open APIs are the primary external contract style where a TMF contract exists.
- Our own web/mobile/operator applications consume the same API layer as external consumers.
- UIs never access databases directly.
- Apps/modules own their operational data.
- Cross-app interaction happens through APIs, events, workflow, and governed integration contracts.
- Technology choices are intentionally deferred.

## View 1: API-First Logical Architecture

```mermaid
flowchart TB
  subgraph Consumers["Consumers And Channels"]
    OwnUIs["Company UIs<br/>Operator Apps, Admin Apps, Dashboards"]
    DigitalChannels["Digital Channels<br/>Self-Care, Mobile, Web"]
    PartnerChannels["Partner Channels<br/>Marketplace, Reseller, Open Gateway"]
    ExternalConsumers["External API Consumers<br/>Partners, Developers, Enterprise Customers"]
    InternalSystems["Internal Enterprise Systems<br/>ERP, GIS, Finance, Data, Workforce"]
  end

  subgraph APIProductLayer["Headless Product API Layer"]
    APICatalog["API Product Catalog<br/>API products, versions, ownership, docs"]
    TMFFacades["TMF Open API Facades<br/>TMF620, TMF622, TMF641, etc."]
    ProductAPIs["Product Suite APIs<br/>Non-TMF or extended capabilities"]
    EventAPIs["Event And Webhook APIs<br/>TMF688, subscriptions, notifications"]
    BulkAPIs["Bulk, Import, Export APIs<br/>Planning, inventory, billing, reporting"]
    SandboxAPIs["Sandbox And Mock APIs<br/>Developer and partner testing"]
  end

  subgraph PlatformControl["Platform Control Plane"]
    Identity["Identity, Access, Tenant, Policy"]
    Workflow["Workflow, Rules, Automation, Intent"]
    Governance["API Governance, Conformance, Audit"]
    Observability["Observability, API Health, Operational Audit"]
  end

  subgraph DomainSuites["Domain Product Suites"]
    StrategySuite["Strategy, Investment, Capacity"]
    BSSSuite["BSS Commercial"]
    OSSEngSuite["OSS Engineering, Inventory, Fulfillment"]
    OSSOpsSuite["OSS Operations, Assurance"]
    DigitalSuite["Digital, Partner, Ecosystem"]
    PlatformSuite["Enterprise Platform, Data, Governance"]
  end

  subgraph DataLayer["Owned Data Layer"]
    StrategyDBs["Planning, Geography, Capacity, Design, Build DBs"]
    BSSDBs["Customer, Catalog, Sales, Order, Billing, Fraud, Usage DBs"]
    OSSDBs["Service, Resource, Inventory, Activation, Field DBs"]
    AssuranceDBs["Alarm, Incident, Ticket, Performance, Change DBs"]
    EcosystemDBs["Self-Care, Partner, Marketplace, API Portal DBs"]
    PlatformDBs["Identity, Workflow, Audit, Event, Data, Test DBs"]
  end

  subgraph IntegrationLayer["Integration And External System Layer"]
    LegacyAdapters["Legacy BSS/OSS Adapters"]
    NetworkAdapters["Network Controller, EMS/NMS, SDN/NFV, Cloud Adapters"]
    ERPFinance["ERP, Finance, Procurement, Tax, Payment Gateways"]
    GISWorkforce["GIS, Address Providers, Workforce, Contractor Systems"]
    Regulatory["Regulatory, Security, Fraud, Credit, Clearinghouse Systems"]
  end

  OwnUIs --> APICatalog
  DigitalChannels --> APICatalog
  PartnerChannels --> APICatalog
  ExternalConsumers --> APICatalog
  InternalSystems --> APICatalog

  APICatalog --> TMFFacades
  APICatalog --> ProductAPIs
  APICatalog --> EventAPIs
  APICatalog --> BulkAPIs
  APICatalog --> SandboxAPIs

  TMFFacades --> DomainSuites
  ProductAPIs --> DomainSuites
  EventAPIs <--> DomainSuites
  BulkAPIs --> DomainSuites
  SandboxAPIs --> DomainSuites

  Identity --> APIProductLayer
  Workflow --> DomainSuites
  Governance --> APIProductLayer
  Observability --> APIProductLayer
  Observability --> DomainSuites

  StrategySuite --> StrategyDBs
  BSSSuite --> BSSDBs
  OSSEngSuite --> OSSDBs
  OSSOpsSuite --> AssuranceDBs
  DigitalSuite --> EcosystemDBs
  PlatformSuite --> PlatformDBs

  DomainSuites <--> IntegrationLayer
```

## View 2: API Exposure Model

```mermaid
flowchart LR
  subgraph APIConsumers["API Consumers"]
    UIs["Our UI Apps"]
    Partners["Partners And Developers"]
    Enterprise["Enterprise Customers"]
    Channels["Digital Channels"]
    BackOffice["Internal Back Office Systems"]
  end

  subgraph ProductAPILayer["Product API Layer"]
    PublicTMF["Public TMF APIs<br/>TMF-aligned external contracts"]
    ExtendedAPIs["Extended Product APIs<br/>Non-TMF capabilities"]
    QueryAPIs["Query And Experience APIs<br/>Read optimized, channel-safe"]
    EventContracts["Event Contracts<br/>Domain events, TMF688, webhooks"]
    AdminAPIs["Admin And Governance APIs"]
  end

  subgraph DomainLayer["Domain App API Layer"]
    AppAPIs["App-Owned Domain APIs"]
    WorkflowAPIs["Workflow And Task APIs"]
    IntegrationAPIs["Integration APIs And Adapters"]
  end

  subgraph DataStores["Domain-Owned Data"]
    OperationalDBs["Operational DBs Per App"]
    ReadModels["Read Models And Reporting Stores"]
    AuditStores["Audit, Evidence, Event, Test Stores"]
  end

  UIs --> PublicTMF
  UIs --> ExtendedAPIs
  UIs --> QueryAPIs
  Partners --> PublicTMF
  Partners --> EventContracts
  Enterprise --> PublicTMF
  Channels --> QueryAPIs
  BackOffice --> ExtendedAPIs

  PublicTMF --> AppAPIs
  ExtendedAPIs --> AppAPIs
  QueryAPIs --> AppAPIs
  AdminAPIs --> AppAPIs
  EventContracts <--> AppAPIs

  AppAPIs --> OperationalDBs
  AppAPIs --> ReadModels
  WorkflowAPIs --> OperationalDBs
  IntegrationAPIs --> OperationalDBs
  AppAPIs --> AuditStores
```

API rules:

- TMF APIs are product contracts, not database wrappers.
- Extended APIs are allowed when TMF does not cover a capability, but they must be cataloged and governed.
- UIs use the same API contracts as external consumers unless there is a clear experience-query need.
- Query APIs can compose across domains, but they should not become systems of record.
- Events are first-class product contracts, especially for order, inventory, assurance, billing, and partner flows.

## View 3: Product Suite And App Topology

```mermaid
flowchart TB
  subgraph Strategy["Strategy, Investment, Capacity Suite"]
    Demand["Demand And Market Planning"]
    Geo["Geography, Address, Site, Serviceability"]
    Capacity["Network Investment And Capacity Planning"]
    Design["Network Engineering And Design"]
    Build["Infrastructure Build Program"]
  end

  subgraph BSS["BSS Commercial Suite"]
    Customer360["Customer And Party 360"]
    OfferStudio["Product And Offer Studio"]
    Marketing["Marketing, Campaign, Customer Journey"]
    CPQ["Sales, CPQ, Cart"]
    OrderHub["Order Management Hub"]
    Billing["Billing, Payments, Account Operations"]
    Fraud["Credit, Fraud, Collections"]
    UsageRevenue["Usage, Charging, Revenue Settlement"]
  end

  subgraph OSSEng["OSS Engineering, Inventory, Fulfillment Suite"]
    SRDesign["Service And Resource Design Studio"]
    Inventory["Inventory And Topology"]
    Activation["Fulfillment And Activation Control Tower"]
    Field["Field Work, Stock, Logistics"]
  end

  subgraph OSSOps["OSS Operations And Assurance Suite"]
    NOC["NOC And Assurance"]
    Quality["Performance, Quality, SLA"]
    Change["Change And Maintenance Operations"]
    AssuranceShared["Cross-Assurance Shared Modules"]
  end

  subgraph Digital["Digital, Partner, Ecosystem Suite"]
    SelfCare["Customer Self-Care"]
    Partner["Partner And Marketplace"]
    Components["Digital And Network Component Operations"]
    DevPortal["Developer And API Portal"]
    EcosystemShared["Ecosystem Shared Modules"]
  end

  subgraph Enterprise["Enterprise Platform, Data, Governance Suite"]
    APIPlatform["Integration, Eventing, API Platform"]
    Admin["Platform Admin And Security"]
    SecReg["Security Operations, Compliance, Regulatory"]
    WorkflowStudio["Workflow And Automation Studio"]
    DataIntel["Data, Reporting, Intelligence"]
    TestLab["Test And Certification Lab"]
  end

  Demand --> Capacity
  Geo --> Capacity
  Capacity --> Design
  Design --> Build
  Build --> Inventory

  OfferStudio --> CPQ
  OfferStudio --> Marketing
  Customer360 --> CPQ
  Customer360 --> Marketing
  Marketing --> CPQ
  CPQ --> OrderHub
  OrderHub --> Activation
  Activation --> Inventory
  Activation --> Field
  Inventory --> NOC
  NOC --> Quality
  Change --> Inventory

  Billing --> UsageRevenue
  UsageRevenue --> Fraud
  OrderHub --> Billing
  Inventory --> Billing

  SelfCare --> Customer360
  SelfCare --> Billing
  SelfCare --> OrderHub
  Partner --> OfferStudio
  Partner --> OrderHub
  Components --> Activation
  DevPortal --> APIPlatform

  APIPlatform --> BSS
  APIPlatform --> OSSEng
  APIPlatform --> OSSOps
  WorkflowStudio --> OrderHub
  WorkflowStudio --> Activation
  WorkflowStudio --> NOC
  DataIntel --> Strategy
  TestLab --> APIPlatform
```

## View 4: Logical Databases And System Of Record Boundaries

Detailed entity-level mastership is defined in [Data Mastery And Entity Ownership](data-mastery-entity-ownership.md).
Recommended database instance and logical database setup is defined in [Recommended Database Setup](recommended-database-setup.md). The view below groups logical data by suite-level domain; the database setup document defines the recommended 9 runtime database instances.

```mermaid
flowchart TB
  subgraph Rule["Data Ownership Rule"]
    NoDirectDB["No cross-app direct DB access<br/>Share via APIs, events, workflow, governed data products"]
  end

  subgraph StrategyDB["Strategy, Investment, Capacity Data"]
    DemandDB["Demand Forecast DB"]
    GeoDB["Geography, Address, Site DB"]
    CapacityDB["Capacity Planning DB"]
    DesignDB["Network Design DB"]
    BuildDB["Build Program DB"]
  end

  subgraph BSSDB["BSS Commercial Data"]
    PartyDB["Party, Customer, Account, Identity DB"]
    CatalogDB["Product, Offer, Price, Agreement DB"]
    MarketingDB["Segment, Campaign, Journey DB"]
    SalesDB["Qualification, Quote, Cart, Sales DB"]
    ProductOrderDB["Product Order DB"]
    BillingDB["Bill, Payment, Prepay DB"]
    FraudDB["Credit, Fraud, Collections DB"]
    UsageDB["Usage, CDR, Settlement DB"]
  end

  subgraph OSSDB["OSS Engineering And Fulfillment Data"]
    ServiceCatalogDB["Service And Resource Design DB"]
    InventoryDB["Product, Service, Resource Inventory DB"]
    IdentifierDB["Number, IP, SIM/eSIM, Identifier DB"]
    ReservationDB["Reservation And Assignment DB"]
    ActivationDB["Fulfillment, Activation, Provisioning DB"]
    FieldDB["Field, Stock, Logistics DB"]
  end

  subgraph AssuranceDB["OSS Operations And Assurance Data"]
    AlarmDB["Alarm And Event DB"]
    IncidentDB["Incident, Service Problem, Ticket DB"]
    TestDiagDB["Service Test And Diagnostics DB"]
    PerformanceDB["Performance, Quality, SLA DB"]
    ChangeDB["Change, Maintenance, Risk DB"]
    KnowledgeDB["Known Error, Remediation, Command Center DB"]
  end

  subgraph EcosystemDB["Digital And Ecosystem Data"]
    SelfCareDB["Self-Care Experience DB"]
    PartnerDB["Partner, Marketplace, Open Gateway DB"]
    ComponentDB["IoT, NaaS, Self-Care Component DB"]
    APIPortalDB["Developer Portal, API Subscription DB"]
    ChannelDB["Channel, Preference, Notification DB"]
  end

  subgraph PlatformDB["Enterprise Platform Data"]
    IdentityDB["Tenant, User, Role, Policy DB"]
    APIRegistryDB["API Contract, Event Catalog DB"]
    WorkflowDB["Workflow, Rule, Task DB"]
    SecurityDB["Security, Compliance, Regulatory DB"]
    DataPlatformDB["Analytics, Reporting, Data Product DB"]
    TestDB["Test, Environment, Conformance DB"]
    AuditDB["Audit, Evidence, Retention DB"]
  end

  NoDirectDB --> StrategyDB
  NoDirectDB --> BSSDB
  NoDirectDB --> OSSDB
  NoDirectDB --> AssuranceDB
  NoDirectDB --> EcosystemDB
  NoDirectDB --> PlatformDB
```

Database rules:

- These are logical databases grouped by suite-level data domain. The recommended physical/runtime grouping is the 9-instance setup in the database setup document.
- Each app owns writes to its operational store.
- Other apps read through APIs, subscribed events, approved read models, or data products.
- Reporting stores must not become hidden operational masters.
- Customer, inventory, order, billing, assurance, security, and regulatory records need explicit ownership and retention rules.

## View 5: API And Event Interaction Across Major Operating Loops

```mermaid
sequenceDiagram
  autonumber
  participant UI as UI Or External Consumer
  participant API as Headless API Layer
  participant BSS as BSS Commercial Apps
  participant OSS as OSS Fulfillment Apps
  participant INV as Inventory And Topology
  participant ASSURE as Assurance Apps
  participant BILL as Billing And Usage Apps
  participant EVT as Event Contracts

  UI->>API: Discover offers, qualify, quote, cart
  API->>BSS: Product/customer/quote/cart APIs
  BSS->>OSS: Serviceability and capacity checks
  OSS->>INV: Availability, reservation, assignment
  INV-->>OSS: Capacity and reservation result
  OSS-->>BSS: Qualification and feasibility result
  UI->>API: Submit product order
  API->>BSS: TMF622 Product Order
  BSS->>EVT: Product order event
  BSS->>OSS: Decompose to service/resource orders
  OSS->>INV: Reserve and assign resources
  OSS->>OSS: Activate/configure service
  OSS->>EVT: Fulfillment and activation events
  OSS->>INV: Update product/service/resource inventory
  INV->>EVT: Inventory state events
  EVT->>BILL: Billing activation trigger
  BILL->>EVT: Bill/usage/payment events
  ASSURE->>EVT: Alarm, incident, ticket, service quality events
  UI->>API: Track order, service, bill, ticket status
```

## View 6: Suite Module Maps

These module maps are the architecture decomposition behind the diagrams. Each module should eventually map to APIs, events, owned data, UI surfaces, and backlog epics.

### Strategy, Investment, And Capacity

| App | High-Level Modules |
| --- | --- |
| Demand And Market Planning | Market Segmentation, Demand Forecasting, Revenue And Margin Scenario, Demand-To-Capacity Gap |
| Geography, Address, Site, And Serviceability | Geographic Master Data, Service Area And Coverage, Map And Spatial Visualization, Site Readiness And Eligibility |
| Network Investment And Capacity Planning | Capacity Model, Forecast And Exhaustion, Investment Scenario, Future Capacity Reservation |
| Network Engineering And Design | High-Level Network Design, Low-Level Design And Bill Of Materials, Design Rules And Validation, Planned Topology |
| Infrastructure Build Program | Build Portfolio, Permits/Dependencies/Readiness, Vendor Work Package, Build-To-Inventory Reconciliation |

### BSS Commercial

| App | High-Level Modules |
| --- | --- |
| Customer And Party 360 | Party Master, Customer Profile, Account Hierarchy, Identity/Access/Consent, Interaction/Communication/Document, Customer Care Case And Complaint, Loyalty And Engagement |
| Product And Offer Studio | Product Catalog, Pricing/Promotion/Discount, Product Configuration, Agreement And Contract, Catalog Governance |
| Marketing, Campaign, And Customer Journey | Segment And Audience, Campaign Planning And Offer Targeting, Journey Orchestration, Retention And Loyalty Treatment, Contact Policy And Consent Enforcement |
| Sales, CPQ, And Cart | Product Offering Qualification, Recommendation And Guided Selling, Quote Management, Shopping Cart, Sales Opportunity, Channel/Dealer/Commission Support |
| Order Management Hub | Product Order Capture, Order Decomposition, Order Orchestration And Jeopardy, Order Fallout And Exception |
| Billing, Payments, And Account Operations | Billing Account, Customer Bill, Payment And Payment Method, Prepay Balance, Collections And Adjustment |
| Credit, Fraud, And Collections | Credit Risk And Eligibility, Fraud Detection And Case Management, Collections Strategy, Service Restriction And Reconnection, Dispute And Recovery |
| Usage, Charging, And Revenue Settlement | Usage Ingestion And Mediation, Usage Consumption, Revenue Assurance, Partner Revenue Sharing, Rating/Charging/Tax Integration, Roaming/Interconnect/Wholesale Settlement |

### OSS Engineering, Inventory, And Fulfillment

| App | High-Level Modules |
| --- | --- |
| Service And Resource Design Studio | Service Catalog, Resource Catalog, Product-Service-Resource Mapping, Technical Compatibility And Design Rule, Entity Catalog |
| Inventory And Topology | Product Inventory, Service Inventory, Resource Inventory, Inventory Location Management, Topology And Relationship, Inventory Connectivity And Path Management, Resource Pool And Capacity, Operational Inventory Planning, Identifier Resources, Reservation And Assignment, Inventory Reconciliation, Network Discovery And Sync, Migration And Decommissioning |
| Fulfillment And Activation Control Tower | Service Order Execution, Resource Order Execution, Activation And Configuration, Provisioning Workflow, Fulfillment Fallout, Inventory Update And Handover |
| Field Work, Stock, And Logistics | Appointment Management, Work Order, Dispatch And Field Execution, Stock And Warehouse, Shipping And Shipment Tracking, Field-To-Inventory Handover |

### OSS Operations And Assurance

| App | High-Level Modules |
| --- | --- |
| NOC And Assurance | Alarm Intake And Normalization, Correlation And Impact Analysis, Incident Management, Service Problem Management, Trouble Ticket Management, Service Test And Diagnostics, Remediation And Dispatch |
| Performance, Quality, And SLA | Performance Collection, Threshold And Alerting, Service Quality, SLA And Enterprise Operations, Quality Analytics |
| Change And Maintenance Operations | Change Record, Maintenance Window, Risk And Impact, Change Execution, Customer And Stakeholder Communication |
| Cross-Assurance Shared Modules | Knowledge And Known Error, Assurance Automation, Operational Command Center |

### Digital, Partner, And Ecosystem

| App | High-Level Modules |
| --- | --- |
| Customer Self-Care | Customer Profile And Access, Product And Service View, Digital Sales And Change, Order And Appointment Tracking, Billing/Payment/Usage, Support And Trouble Ticket |
| Partner And Marketplace | Partner Onboarding, Partner Catalog And Offer, Partner Ordering, Marketplace Operations, Partner Usage And Settlement, Partner Support |
| Digital And Network Component Operations | Self-Care Component Operations, NaaS Component Operations, IoT Agent And Device Operations, IoT Service Operations |
| Developer And API Portal | API Catalog, Developer Onboarding And Subscription, Sandbox And Mock API, API Analytics And Health, API Governance And Conformance |
| Ecosystem Shared Modules | Channel Experience, Notification And Preference |

### Enterprise Platform, Data, And Governance

| App | High-Level Modules |
| --- | --- |
| Integration, Eventing, And API Platform | API Gateway, OpenAPI Contract Registry, Event Catalog And Subscription, Integration Adapter, Notification Delivery |
| Platform Admin And Security | Tenant And Environment Administration, Identity And Access, Policy And Authorization, Audit/Compliance/Privacy, Secrets And Platform Configuration |
| Security Operations, Compliance, And Regulatory | Security Monitoring And Incident, Compliance Control, Regulatory Operations, Data Retention And Legal Hold, Business Continuity And Operational Resilience |
| Workflow And Automation Studio | Process Definition, Rules And Decision, Work Queue And Task, Automation And Intent, Configuration And Extension Studio |
| Data, Reporting, And Intelligence | Operational Data Platform, Master Data And Reference Data, KPI And Dashboard, Analytics And AI Insight, Reporting And Regulatory |
| Test And Certification Lab | Test Case Management, Test Environment, Test Data, Test Scenario And Execution, Test Result And Defect, TMF Conformance |

## View 7: Detailed Suite Module Diagrams

### Strategy, Investment, And Capacity Module Diagram

```mermaid
flowchart LR
  subgraph Strategy["Strategy, Investment, And Capacity Suite"]
    DMP["Demand And Market Planning"]
    Geo["Geography, Address, Site, Serviceability"]
    Cap["Network Investment And Capacity Planning"]
    Eng["Network Engineering And Design"]
    Build["Infrastructure Build Program"]

    DMP --> DMPMods["Market Segmentation<br/>Demand Forecasting<br/>Revenue And Margin Scenario<br/>Demand-To-Capacity Gap"]
    Geo --> GeoMods["Geographic Master Data<br/>Service Area And Coverage<br/>Map And Spatial Visualization<br/>Site Readiness And Eligibility"]
    Cap --> CapMods["Capacity Model<br/>Forecast And Exhaustion<br/>Investment Scenario<br/>Future Capacity Reservation"]
    Eng --> EngMods["High-Level Network Design<br/>Low-Level Design And BoM<br/>Design Rules And Validation<br/>Planned Topology"]
    Build --> BuildMods["Build Portfolio<br/>Permits And Readiness<br/>Vendor Work Package<br/>Build-To-Inventory Reconciliation"]
  end

  DMP --> Cap
  Geo --> Cap
  Cap --> Eng
  Eng --> Build
```

### BSS Commercial Module Diagram

```mermaid
flowchart LR
  subgraph BSS["BSS Commercial Suite"]
    C360["Customer And Party 360"]
    Offer["Product And Offer Studio"]
    Marketing["Marketing, Campaign, And Customer Journey"]
    CPQ["Sales, CPQ, And Cart"]
    Order["Order Management Hub"]
    Billing["Billing, Payments, Account Operations"]
    Fraud["Credit, Fraud, Collections"]
    Revenue["Usage, Charging, Revenue Settlement"]

    C360 --> C360Mods["Party Master<br/>Customer Profile<br/>Account Hierarchy<br/>Identity, Access, Consent<br/>Interaction, Communication, Document<br/>Customer Care Case And Complaint<br/>Loyalty And Engagement"]
    Offer --> OfferMods["Product Catalog<br/>Pricing, Promotion, Discount<br/>Product Configuration<br/>Agreement And Contract<br/>Catalog Governance"]
    Marketing --> MarketingMods["Segment And Audience<br/>Campaign Planning And Offer Targeting<br/>Journey Orchestration<br/>Retention And Loyalty Treatment<br/>Contact Policy And Consent Enforcement"]
    CPQ --> CPQMods["Product Offering Qualification<br/>Recommendation And Guided Selling<br/>Quote Management<br/>Shopping Cart<br/>Sales Opportunity<br/>Channel, Dealer, Commission Support"]
    Order --> OrderMods["Product Order Capture<br/>Order Decomposition<br/>Order Orchestration And Jeopardy<br/>Order Fallout And Exception"]
    Billing --> BillingMods["Billing Account<br/>Customer Bill<br/>Payment And Payment Method<br/>Prepay Balance<br/>Collections And Adjustment"]
    Fraud --> FraudMods["Credit Risk And Eligibility<br/>Fraud Detection And Case Management<br/>Collections Strategy<br/>Service Restriction And Reconnection<br/>Dispute And Recovery"]
    Revenue --> RevenueMods["Usage Ingestion And Mediation<br/>Usage Consumption<br/>Revenue Assurance<br/>Partner Revenue Sharing<br/>Rating, Charging, Tax Integration<br/>Roaming, Interconnect, Wholesale Settlement"]
  end

  C360 --> CPQ
  Offer --> CPQ
  C360 --> Marketing
  Offer --> Marketing
  Marketing --> CPQ
  CPQ --> Order
  Order --> Billing
  Order --> Revenue
  Billing --> Fraud
  Revenue --> Fraud
```

### OSS Engineering, Inventory, And Fulfillment Module Diagram

```mermaid
flowchart LR
  subgraph OSSEng["OSS Engineering, Inventory, And Fulfillment Suite"]
    SRD["Service And Resource Design Studio"]
    Inv["Inventory And Topology"]
    Fulfill["Fulfillment And Activation Control Tower"]
    Field["Field Work, Stock, Logistics"]

    SRD --> SRDMods["Service Catalog<br/>Resource Catalog<br/>Product-Service-Resource Mapping<br/>Technical Compatibility And Design Rule<br/>Entity Catalog"]
    Inv --> InvMods["Product Inventory<br/>Service Inventory<br/>Resource Inventory<br/>Topology And Relationship<br/>Resource Pool And Capacity<br/>Identifier Resources<br/>Reservation And Assignment<br/>Inventory Reconciliation<br/>Network Discovery And Sync<br/>Migration And Decommissioning"]
    Fulfill --> FulfillMods["Service Order Execution<br/>Resource Order Execution<br/>Activation And Configuration<br/>Provisioning Workflow<br/>Fulfillment Fallout<br/>Inventory Update And Handover"]
    Field --> FieldMods["Appointment Management<br/>Work Order<br/>Dispatch And Field Execution<br/>Stock And Warehouse<br/>Shipping And Shipment Tracking<br/>Field-To-Inventory Handover"]
  end

  SRD --> Inv
  Inv --> Fulfill
  Fulfill --> Inv
  Fulfill --> Field
  Field --> Inv
```

### OSS Operations And Assurance Module Diagram

```mermaid
flowchart LR
  subgraph OSSOps["OSS Operations And Assurance Suite"]
    NOC["NOC And Assurance"]
    Perf["Performance, Quality, SLA"]
    Change["Change And Maintenance Operations"]
    Shared["Cross-Assurance Shared Modules"]

    NOC --> NOCMods["Alarm Intake And Normalization<br/>Correlation And Impact Analysis<br/>Incident Management<br/>Service Problem Management<br/>Trouble Ticket Management<br/>Service Test And Diagnostics<br/>Remediation And Dispatch"]
    Perf --> PerfMods["Performance Collection<br/>Threshold And Alerting<br/>Service Quality<br/>SLA And Enterprise Operations<br/>Quality Analytics"]
    Change --> ChangeMods["Change Record<br/>Maintenance Window<br/>Risk And Impact<br/>Change Execution<br/>Customer And Stakeholder Communication"]
    Shared --> SharedMods["Knowledge And Known Error<br/>Assurance Automation<br/>Operational Command Center"]
  end

  NOC <--> Perf
  NOC <--> Change
  Shared --> NOC
  Shared --> Perf
  Shared --> Change
```

### Digital, Partner, And Ecosystem Module Diagram

```mermaid
flowchart LR
  subgraph Digital["Digital, Partner, And Ecosystem Suite"]
    SelfCare["Customer Self-Care"]
    Partner["Partner And Marketplace"]
    Components["Digital And Network Component Operations"]
    DevPortal["Developer And API Portal"]
    Shared["Ecosystem Shared Modules"]

    SelfCare --> SelfCareMods["Customer Profile And Access<br/>Product And Service View<br/>Digital Sales And Change<br/>Order And Appointment Tracking<br/>Billing, Payment, Usage<br/>Support And Trouble Ticket"]
    Partner --> PartnerMods["Partner Onboarding<br/>Partner Catalog And Offer<br/>Partner Ordering<br/>Marketplace Operations<br/>Partner Usage And Settlement<br/>Partner Support"]
    Components --> ComponentMods["Self-Care Component Operations<br/>NaaS Component Operations<br/>IoT Agent And Device Operations<br/>IoT Service Operations"]
    DevPortal --> DevMods["API Catalog<br/>Developer Onboarding And Subscription<br/>Sandbox And Mock API<br/>API Analytics And Health<br/>API Governance And Conformance"]
    Shared --> SharedMods["Channel Experience<br/>Notification And Preference"]
  end

  SelfCare --> Shared
  Partner --> Shared
  Components --> Partner
  DevPortal --> Partner
  DevPortal --> Components
```

### Enterprise Platform, Data, And Governance Module Diagram

```mermaid
flowchart LR
  subgraph Platform["Enterprise Platform, Data, And Governance Suite"]
    APIPlat["Integration, Eventing, API Platform"]
    Admin["Platform Admin And Security"]
    SecReg["Security Operations, Compliance, Regulatory"]
    Workflow["Workflow And Automation Studio"]
    Data["Data, Reporting, Intelligence"]
    Test["Test And Certification Lab"]

    APIPlat --> APIPlatMods["API Gateway<br/>OpenAPI Contract Registry<br/>Event Catalog And Subscription<br/>Integration Adapter<br/>Notification Delivery"]
    Admin --> AdminMods["Tenant And Environment Administration<br/>Identity And Access<br/>Policy And Authorization<br/>Audit, Compliance, Privacy<br/>Secrets And Platform Configuration"]
    SecReg --> SecRegMods["Security Monitoring And Incident<br/>Compliance Control<br/>Regulatory Operations<br/>Data Retention And Legal Hold<br/>Business Continuity And Resilience"]
    Workflow --> WorkflowMods["Process Definition<br/>Rules And Decision<br/>Work Queue And Task<br/>Automation And Intent<br/>Configuration And Extension Studio"]
    Data --> DataMods["Operational Data Platform<br/>Master Data And Reference Data<br/>KPI And Dashboard<br/>Analytics And AI Insight<br/>Reporting And Regulatory"]
    Test --> TestMods["Test Case Management<br/>Test Environment<br/>Test Data<br/>Test Scenario And Execution<br/>Test Result And Defect<br/>TMF Conformance"]
  end

  APIPlat --> Admin
  APIPlat --> Workflow
  Workflow --> Data
  Test --> APIPlat
  SecReg --> Admin
  SecReg --> Data
```

## View 8: API Ownership By Suite

| Suite | API Ownership Role |
| --- | --- |
| Strategy, Investment, Capacity | Planning APIs, serviceability APIs, capacity APIs, build program APIs, geography/site/location APIs |
| BSS Commercial | Customer, catalog, marketing, journey, CPQ, order, billing, payment, usage, fraud, revenue APIs |
| OSS Engineering, Inventory, Fulfillment | Service/resource catalog, inventory, reservation, activation, field, logistics APIs |
| OSS Operations And Assurance | Alarm, incident, ticket, service test, performance, service quality, change APIs |
| Digital, Partner, Ecosystem | Self-care, partner, marketplace, Open Gateway, component-suite, developer portal APIs |
| Enterprise Platform, Data, Governance | Identity, event, workflow, governance, conformance, audit, data, reporting APIs |

## View 9: UI Architecture

```mermaid
flowchart TB
  subgraph UIProducts["Company UI Products"]
    PlanningUI["Planning And Capacity Workbench"]
    BSSUI["BSS Operator Workbench"]
    OSSUI["OSS Engineering And Fulfillment Workbench"]
    NOCUI["NOC And Assurance Workbench"]
    PartnerUI["Partner And Marketplace Portal"]
    SelfCareUI["Customer Self-Care"]
    DevUI["Developer And API Portal"]
    AdminUI["Platform, Security, Data, Test Admin"]
  end

  subgraph SharedExperience["Shared Experience Services"]
    AuthUX["Login, Tenant, Role Context"]
    NavUX["Navigation, Search, Notifications"]
    TaskUX["Task Inbox, Approvals, Work Queues"]
    ReportingUX["Dashboards, Reports, Exports"]
  end

  subgraph APIContracts["API Contracts Used By All UIs"]
    TMFAPI["TMF APIs"]
    ProductAPI["Extended Product APIs"]
    QueryAPI["Experience Query APIs"]
    EventAPI["Events And Notifications"]
  end

  UIProducts --> SharedExperience
  SharedExperience --> APIContracts
  UIProducts --> APIContracts
```

UI rules:

- Every UI is optional from an integration standpoint; APIs are the product core.
- Operator UIs may use query APIs for usability, but writes still go through app-owned command APIs.
- External consumers should be able to perform headless workflows without requiring our UI.
- UI modules should not become hidden business logic owners.

## Questions To Confirm Before Next Architecture Iteration

1. Should the product be designed for a single telecom operator first, or as a multi-tenant product for many telecom companies from day one?
2. Which first operating domain should we optimize for: mobile, fiber broadband, enterprise connectivity, IoT, NaaS, or a blended operator?
3. Do we want external consumers to see only strict TMF APIs, or can they also consume our extended product APIs where TMF does not cover the capability?
4. Should partner/Open Gateway APIs be a first-release requirement or a later ecosystem phase?
5. Do we want billing/charging/rating to be native in our suite, or should we design billing operations while integrating with external charging/rating engines?
6. Should the first MVP include a complete BSS-to-OSS flow, or should we start with the planning/inventory backbone as the first product slice?
