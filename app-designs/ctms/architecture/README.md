# OoBDev Architecture Documentation

This directory contains comprehensive architecture documentation for the OoBDev Clinical Trial Management System, converted from Visual Studio UML diagrams to PlantUML with detailed explanations.

## Table of Contents

- [Overview](#overview)
- [Architecture Modules](#architecture-modules)
- [Using This Documentation](#using-this-documentation)
- [Diagram Conventions](#diagram-conventions)

## Overview

OoBDev is a clinical trial management system designed for pharmaceutical research compliance and data integrity. The system follows a modular architecture with strict layering and separation of concerns.

### System Purpose

- **Clinical Trial Management**: Manage trials, sites, subjects, and investigators
- **Safety Reporting**: SAE (Safety Adverse Events) case management
- **Document Management**: Site library for protocol documents and study materials
- **Messaging System**: Multi-channel communication (email, SMS) with guaranteed delivery
- **Subject Engagement**: MARS (Medication Adherence Reminder System)
- **CEC**: Clinical Event Committee adjudication workflows
- **CTS**: Subject screening and enrollment
- **Administration**: User, role, and trial configuration management

### Regulatory Compliance

The system is designed to comply with:
- **21 CFR Part 11**: FDA regulations for electronic records and signatures
- **GCP (Good Clinical Practice)**: International clinical trial standards
- **HIPAA**: Health information privacy (where applicable)

## Architecture Modules

### 1. Gateway (Core)
**Location:** [`gateway/`](./gateway/)

The foundational module providing authentication, authorization, and common services.

**Documentation:**
- [README](./gateway/README.md) - Module overview
- [Use Cases](./gateway/use-cases.md) - User authentication, profile management, SAE workflows
- [Layering](./gateway/layering.md) - 6-layer architecture with validation rules
- [SAE Use Cases](./gateway/sae-use-cases.md) - Safety adverse event management

**Key Features:**
- User authentication and session management
- Role-based access control (RBAC)
- Password management and self-service
- Safety adverse event (SAE) case management
- System-wide exception logging
- Email queue processing

**Diagrams:** 4 diagrams (3 use case, 1 layer)

---

### 2. Admin
**Location:** [`admin/`](./admin/)

Administrative functions for system management.

**Documentation:**
- [README](./admin/README.md) - Module overview
- [Use Cases](./admin/use-cases.md) - User management, role assignment, trial configuration
- [Layering](./admin/layering.md) - 3-tier architecture

**Key Features:**
- User account creation and management
- Password reset and account unlock
- Role assignment
- Bulk user import (CSV/Excel)
- Trial configuration
- Email address modification

**Diagrams:** 2 diagrams (1 use case, 1 layer)

---

### 3. Messaging
**Location:** [`messaging/`](./messaging/)

Sophisticated messaging infrastructure with guaranteed delivery and multi-channel support.

**Documentation:**
- [README](./messaging/README.md) - Architecture overview
- [Gateway Queue](./messaging/gateway-queue.md) - External provider integration
- [Global Queue](./messaging/global-queue.md) - Message routing and stop lists
- [Trial Queue](./messaging/trial-queue.md) - Trial-specific message processing
- [State Machine](./messaging/state-machine.md) - Message lifecycle states
- [Workflows](./messaging/workflows.md) - User-initiated and scheduled messaging
- [Quick Reference](./messaging/QUICK_REFERENCE.md) - Developer guide
- [Index](./messaging/INDEX.md) - Complete navigation guide

**Key Features:**
- Multi-channel delivery (Email, SMS)
- Guaranteed delivery with retry logic
- Message threading and conversation tracking
- Stop list management (opt-out)
- Scheduled messaging and reminders
- Auto-reply handling
- Activity tracking
- Bulk messaging

**Diagrams:** 19 diagrams (18 sequence, 1 state machine)

**Queues:**
- **Gateway Queue**: External provider integration
- **Global Queue**: System-wide message routing
- **Trial Queue**: Trial-specific processing and scheduling

---

### 4. CEC (Clinical Event Committee)
**Location:** [`cec/`](./cec/)

Clinical event adjudication and committee management.

**Documentation:**
- [README](./cec/README.md) - Module overview
- [Use Cases](./cec/use-cases.md) - Event adjudication workflows

**Key Features:**
- Event case management
- Document upload and version control
- Medical review workflow
- Committee meeting management
- Adjudication voting
- Consensus building
- Final determination and reporting

**Actors:**
- Site User, Coordinator, Medical Reviewer
- Adjudicator, Meeting Manager
- Sponsor, Primary Researcher

**Diagrams:** 1 use case diagram

---

### 5. CTS (Clinical Trial System)
**Location:** [`cts/`](./cts/)

Subject screening and enrollment management.

**Documentation:**
- [README](./cts/README.md) - Module overview
- [Use Cases](./cts/use-cases.md) - Screening workflows

**Key Features:**
- Configurable screening questionnaires
- Dynamic question branching
- Inclusion/exclusion criteria evaluation
- Subject eligibility determination
- Subscription management
- Audit trail (21 CFR Part 11)

**Functional Requirements:** 16 detailed requirements (R1-R16)

**Diagrams:** 1 use case diagram

---

### 6. MARS (Medication Adherence Reminder System)
**Location:** [`mars/`](./mars/)

Subject engagement and medication adherence tracking.

**Documentation:**
- [README](./mars/README.md) - Module overview
- [Use Cases](./mars/use-cases.md) - Manager, site, and sponsor workflows

**Key Features:**
- Medication reminder scheduling
- Subject engagement tracking
- Adherence metrics and reporting
- Site and subject management
- Dashboard analytics
- Privacy-compliant communications

**User Roles:**
- MARS Manager
- MARS Site Member
- MARS Sponsor

**Diagrams:** 3 use case diagrams (Manager, Site, Sponsor)

---

### 7. Site Library
**Location:** [`site-library/`](./site-library/)

Document repository and knowledge management.

**Documentation:**
- [README](./site-library/README.md) - Module overview
- [Use Cases](./site-library/use-cases.md) - Document management workflows
- [Layering](./site-library/layering.md) - 6-layer architecture

**Key Features:**
- Document upload and storage
- Full-text search
- Version control
- Access permissions
- Document publishing workflow
- RSS/Atom feeds
- SQL FileStream for large files

**User Roles:**
- User (view/download)
- Writer (create/edit)
- Librarian (approve/publish)

**Diagrams:** 2 diagrams (1 use case, 1 layer)

---

## Using This Documentation

### For Developers

1. **Getting Started**: Read the [Gateway README](./gateway/README.md) for system fundamentals
2. **Architecture**: Review [layering diagrams](./gateway/layering.md) to understand system structure
3. **Specific Features**: Navigate to module-specific documentation
4. **Messaging**: Start with [Messaging INDEX](./messaging/INDEX.md) for the messaging system

### For Architects

1. **System Overview**: Review this README
2. **Layering**: Examine [Gateway Layering](./gateway/layering.md), [Admin Layering](./admin/layering.md), and [Site Library Layering](./site-library/layering.md)
3. **Integration Points**: Review [Messaging Architecture](./messaging/README.md)
4. **Compliance**: See regulatory notes in Gateway, CEC, and CTS documentation

### For Product Managers

1. **Capabilities**: Read README files for each module
2. **User Workflows**: Review use case documentation
3. **Compliance**: Review SAE, CEC, and CTS documentation for regulatory features

### For QA/Testing

1. **Use Cases**: Each module has detailed use case documentation
2. **State Machines**: See [Message State Machine](./messaging/state-machine.md)
3. **Error Handling**: Review sequence diagrams for error flows

## Diagram Conventions

### PlantUML Diagrams

All diagrams use PlantUML syntax and can be rendered using:

1. **Online**: [PlantUML Web Server](http://www.plantuml.com/plantuml/uml/)
2. **VS Code**: Install "PlantUML" extension
3. **IntelliJ IDEA**: Built-in PlantUML support
4. **Command Line**: `plantuml diagram.puml`

### Diagram Types

- **Use Case Diagrams**: Actor interactions and system boundaries
- **Sequence Diagrams**: Message flow and object interactions over time
- **Component/Layer Diagrams**: Architectural layers and dependencies
- **State Diagrams**: State machines and lifecycle management

### Reading Sequence Diagrams

```
participant User
participant System
participant Database

User -> System: Request
activate System
System -> Database: Query
activate Database
Database --> System: Results
deactivate Database
System --> User: Response
deactivate System
```

- **Solid Arrow (->)**: Synchronous call
- **Dashed Arrow (-->)**: Return/Response
- **activate/deactivate**: Object lifecycle
- **alt/else**: Conditional logic
- **loop**: Repeated operations
- **par**: Parallel execution

### Color Coding

- **Blue (#E3F2FD)**: Primary layers
- **Green (#E8F5E9)**: Gateway/Core components
- **Light Blue (#BBDEFB)**: Sub-layers/components

## Original Source

These diagrams were converted from Visual Studio Architecture projects (`.modelproj`) located in:

```
/current/src/CORE/Gateway/
├── OoBDev.Architecture/
├── OoBDev.Admin/OoBDev.Admin.Architecture/
├── OoBDev.Cec/OoBDev.Cec.Architecture/
├── OoBDev.Cts/OoBDev.Cts.Architecture/
├── OoBDev.Mars/OoBDev.Mars.Architecture/
├── OoBDev.Messaging/OoBDev.Messaging.Architecture/
└── OoBDev.SiteLibrary/OoBDev.SiteLibrary.Architecture/
```

Original formats:
- `.usecasediagram` - Use case diagrams
- `.layerdiagram` - Layered architecture diagrams
- `.sequencediagram` - Sequence diagrams
- `.activitydiagram` - Activity/State diagrams

## Architecture Validation

Several modules include architecture validation rules enforced at build time:

- **Gateway**: Namespace and layer dependency validation
- **Admin**: 3-tier architecture enforcement
- **Site Library**: 6-layer validation

Violations are tracked in `.layerdiagram.suppressions` files as technical debt.

## Technology Stack

- **Platform**: ASP.NET MVC (.NET Framework)
- **Database**: SQL Server with FileStream and Full-Text Search
- **ORM**: Entity Framework
- **Message Queue**: MSMQ or similar
- **External Providers**: Email (SMTP), SMS (Twilio/similar)
- **Architecture Tools**: Visual Studio Architecture Tools (deprecated after VS2017)

## Documentation Statistics

- **Modules**: 7 major modules
- **Markdown Files**: 40+ documentation files
- **PlantUML Diagrams**: 35+ diagrams
- **Original Diagrams Converted**: 35 diagram files
- **Lines of Documentation**: ~8,000 lines

## Contributing

When adding or modifying architecture:

1. Update PlantUML diagrams in markdown files
2. Update module README if architecture changes
3. Document new use cases with descriptions
4. Maintain consistency with existing diagram styles
5. Update this index if adding new modules

## Related Documentation

- **Source Code**: `/current/src/CORE/Gateway/`
- **Original Diagrams**: `/current/src/CORE/Gateway/*/OoBDev.*.Architecture/`
- **Project Files**: `*.modelproj` in architecture directories

---

*Last Updated: January 2026*
*Converted from Visual Studio UML diagrams to PlantUML markdown documentation*
