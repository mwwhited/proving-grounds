# OoBDev CEC (Clinical Event Committee) Architecture

The CEC module provides clinical event adjudication and management capabilities for the OoBDev clinical trial management system.

## Architecture Diagrams

- [Use Cases](./use-cases.md) - Clinical event committee use cases and workflows

## Overview

The Clinical Event Committee (CEC) module provides comprehensive event management for clinical trials, including:

- **Event Reporting** - Site users, coordinators, and adjudicators can report clinical events
- **Document Management** - Upload, view, and classify source documents with HIPAA compliance
- **Medical Review** - Medical reviewers evaluate events and approve them for committee meetings
- **Adjudication Process** - Adjudicators review and adjudicate events during scheduled meetings
- **Meeting Management** - Schedule meetings, assign members, and collect approved events
- **Reporting & Analytics** - Comprehensive reporting for sponsors, researchers, and stakeholders
- **Information Requests** - Query management between coordinators and site users
- **Compliance** - HIPAA violation tracking and reporting

## Key Components

### Actor Roles

- **Site User** - Reports events, uploads documents, and responds to information requests
- **Coordinator** - Manages events, source documents, information requests, and approves events for meetings
- **Medical Reviewer** - Reviews events, approves for meetings, manages checklists
- **Adjudicator** - Adjudicates events during meetings, classifies documents
- **Meeting Manager** - Schedules meetings, assigns members, manages meeting workflow
- **Sponsor** - Views adjudicated events and HIPAA violations
- **Primary Researcher** - Accesses comprehensive reports and analytics
- **Notification Service** - Automated system actor for meeting notifications

### Core Workflows

#### Event Lifecycle
1. Event reporting by site users
2. Source document upload and classification
3. Medical review and approval
4. Meeting collection and scheduling
5. Adjudication process
6. Final reporting to sponsors and researchers

#### Document Management
- Upload source documents with automatic classification
- View documents with private/public annotations
- HIPAA violation reporting and tracking
- Document page manipulation
- Information queries linked to documents

#### Meeting Process
- Collect approved events for adjudication
- Schedule meetings with date/time/location
- Assign adjudicators to meetings
- Notify members via notification service
- Conduct adjudication meeting process

## Business Features

### Event Management
- Report clinical events with full context
- Bulk import events from external sources
- Checklist management for standardized review
- Public and private annotations

### Document Workflows
- Upload and classify source documents by type
- Link documents to specific events
- Request additional information from sites
- Track document completeness

### Adjudication
- Independent adjudicator review
- Meeting-based decision process
- Classification of event outcomes
- Consensus tracking

### Reporting & Compliance
- Adjudicated events listing
- Event status by region and timeline
- Events without source documents
- Event classification summaries
- "Not an Event" reporting
- Adjudicator participation tracking
- HIPAA violation monitoring

## Integration Points

- **Gateway** - User authentication and authorization
- **Messaging** - Email notifications for meetings and information requests
- **File Storage** - Source document storage and retrieval
- **Audit System** - Comprehensive audit trail for regulatory compliance

## Related Documentation

- [Gateway Architecture](../gateway/README.md) - Core authentication and user management
- [Messaging Architecture](../messaging/README.md) - Email and notification services
