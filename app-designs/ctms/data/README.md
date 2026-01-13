# OoBDev Database - Entity Relationship Diagrams

## Overview

This directory contains comprehensive Entity Relationship Diagrams (ERDs) for all modules in the OoBDev Clinical Trial Management System. Each ERD includes both PlantUML and ASCII diagram formats, plus detailed table descriptions, relationships, business rules, and compliance mapping.

---

## ERD Documents

### 1. [Gateway (Core)](./gateway.md)
**Purpose**: Core authentication, authorization, user management, and multi-tenancy infrastructure

**Key Entities**:
- AspNetUsers - User accounts (ASP.NET Identity)
- AspNetRoles - Role definitions
- AspNetUserRoles - User-role assignments
- UserProfile - Extended user profile
- Trials - Multi-tenant trial definitions
- TrialUserAssignments - Trial access control
- AuditLog - Comprehensive audit trail (21 CFR Part 11)
- LoginHistory - Login/logout tracking
- PasswordHistory - Password reuse prevention
- SecurityQuestions - Account recovery

**Compliance**: 21 CFR Part 11, HIPAA, GCP

**Tables**: 20+ tables

---

### 2. [SAE (Safety Adverse Events)](./sae.md)
**Purpose**: Safety event reporting, medical review workflows, and regulatory reporting

**Key Entities**:
- SAECases - Adverse event cases
- SAECaseItems - Flexible case data (EAV pattern)
- SAECaseHistory - Complete audit trail
- SAEDocuments - Case documentation with FileStream
- MedicalReviews - Medical review process
- SiteQueries - Site query management
- SAEWorkflowTransitions - Workflow state machine
- RegulatoryReports - Regulatory authority submissions

**Workflow States**: Draft → Submitted → Medical Review → Query → Completed → Reported → Closed

**Compliance**: 21 CFR Part 11, GCP ICH E6(R2), ISO 14155

**Tables**: 15+ tables

---

### 3. [Messaging System](./messaging.md)
**Purpose**: Multi-channel communication with guaranteed delivery through 3-queue architecture

**Key Entities**:
- Messages - Central message record
- MessageStates - State transition audit
- MessageTemplate - Reusable message templates
- GatewayQueue - Entry point queue
- GlobalQueue - Channel routing queue
- TrialQueue - Delivery queue
- ScheduledMessages - Recurring messages
- ReminderSeries - Multi-step reminder workflows
- StopList - Opt-out management
- MessageActivity - Engagement tracking (opens, clicks)

**Queue Architecture**: Gateway Queue → Global Queue → Trial Queue → External Provider

**Channels**: Email (SMTP, SendGrid, AWS SES), SMS (Twilio, Azure Communication Services)

**Compliance**: CAN-SPAM Act, GDPR, CASL

**Tables**: 20+ tables

---

### 4. [CEC (Clinical Event Committee)](./cec.md)
**Purpose**: Clinical event adjudication through committee meetings and voting

**Key Entities**:
- CECCases - Event cases for adjudication
- MedicalReviews - Independent medical reviews
- Meetings - Committee meeting management
- MeetingAttendees - Attendance tracking
- MeetingAgenda - Case presentation agenda
- Adjudications - Final determinations
- AdjudicationVotes - Committee member votes
- CommitteeMembers - Committee roster

**Workflow**: Case Created → Medical Review → Meeting → Voting → Consensus → Final Determination

**Consensus Methods**: Unanimous, Majority, Super-majority, Weighted

**Compliance**: GCP ICH E6, 21 CFR Part 11

**Tables**: 10+ tables

---

### 5. [CTS (Clinical Trial Screening)](./cts.md)
**Purpose**: Subject screening, eligibility determination, and enrollment

**Key Entities**:
- Subjects - Subject master data (PHI encrypted)
- Subscriptions - Trial enrollments
- Questionnaires - Configurable screening forms
- Questions - Questionnaire items
- SubjectResponses - Subject answers
- EligibilityCriteria - Inclusion/exclusion criteria
- EligibilityEvaluations - Criteria evaluation results
- SubjectEligibility - Final eligibility determination

**Eligibility Logic**: All Inclusion MET + No Exclusion FAILED = Eligible

**Compliance**: GCP ICH E6, HIPAA (PHI encryption required)

**Tables**: 8+ tables

---

### 6. [MARS (Medication Adherence)](./mars.md)
**Purpose**: Medication adherence tracking through scheduled reminders and response collection

**Key Entities**:
- MedicationSchedules - Medication regimens
- ReminderLogs - Reminder delivery tracking
- AdherenceResponses - Subject responses ("Taken"/"Missed")
- AdherenceMetrics - Calculated adherence rates
- DashboardStats - Trial-level aggregate statistics

**Adherence Calculation**: Adherence Rate = Positive Responses / Total Reminders

**Categories**: High (≥80%), Medium (50-79%), Low (<50%)

**Integration**: Uses Messaging module for reminder delivery

**Tables**: 5+ tables

---

### 7. [Site Library](./site-library.md)
**Purpose**: Document management with version control, full-text search, and publishing workflows

**Key Entities**:
- Folders - Hierarchical folder structure
- Documents - Document metadata
- DocumentVersions - Version control (all versions retained)
- PublishingWorkflow - Librarian approval workflow
- DocumentPermissions - Role-based access control (RBAC)
- DocumentSearchIndex - Full-text search index

**Workflow**: Draft → Submit for Review → Librarian Review → Approved/Rejected → Published

**Storage**:
- Small files (<1MB): varbinary column
- Large files (≥1MB): SQL Server FileStream

**Search**: SQL Server Full-Text Search with stemming and relevance ranking

**Tables**: 7+ tables

---

### 8. [Admin](./admin.md)
**Purpose**: System administration including user management, trial configuration, and settings

**Key Entities**:
- UserAdministration - Admin action audit trail
- PasswordResets - Admin-initiated password resets
- EmailChanges - Email change tracking
- BulkImports - CSV/Excel bulk import
- BulkImportErrors - Import error logging
- TrialConfiguration - Trial-specific settings
- SystemSettings - Global system configuration
- AuditLogRetention - Data retention policies

**Admin Operations**: Create User, Assign Roles, Reset Password, Unlock Account, Bulk Import, Configure Trial

**Integration**: Extends Gateway core tables (AspNetUsers, AspNetRoles, Trials)

**Tables**: 8+ tables

---

## Database Technology Stack

### Database Server
- **RDBMS**: Microsoft SQL Server 2012+ (SQL Server 2016+ recommended)
- **Compatibility Level**: 130+ (SQL Server 2016)
- **Edition**: Standard or Enterprise (Enterprise required for TDE)

### Storage Features
- **FileStream**: Large document storage (Site Library, SAE Documents)
- **Full-Text Search**: Document content indexing (Site Library)
- **Column-Level Encryption**: Sensitive data (passwords, PHI)
- **Transparent Data Encryption (TDE)**: Database-level encryption

### ORM & Framework
- **ORM**: Entity Framework 6.x or Entity Framework Core 3.1+
- **Framework**: ASP.NET MVC / ASP.NET Core
- **Authentication**: ASP.NET Identity

### Queue System
- **Message Queue**: Service Broker, MSMQ, or Azure Service Bus
- **Queue Architecture**: 3-queue design (Gateway → Global → Trial)

---

## Cross-Module Relationships

### Gateway as Foundation
All modules depend on Gateway for:
- User authentication (AspNetUsers)
- Role-based authorization (AspNetRoles, AspNetUserRoles)
- Multi-tenancy (Trials)
- Audit logging (AuditLog)

### Module Interconnections

```
Gateway (Core)
  ├──► SAE (uses: Users, Trials, Sites, Subjects)
  ├──► CEC (uses: Users, Trials, Sites, Subjects)
  ├──► CTS (uses: Users, Trials, Sites)
  ├──► MARS (uses: Users, Trials, Subjects from CTS)
  ├──► Messaging (uses: Users, Trials)
  ├──► Site Library (uses: Users, Trials, Roles)
  └──► Admin (manages: Users, Roles, Trials)

Messaging Integration:
  ├──► SAE (sends: Case notifications, Query alerts)
  ├──► MARS (sends: Medication reminders)
  └──► Admin (sends: Password reset emails, Welcome emails)

CTS → MARS:
  └──► Subjects enrolled in CTS assigned to MARS schedules

Site Library:
  └──► Used by SAE (source documents), CEC (case materials)
```

---

## Data Model Statistics

| Module | Tables | Primary Entities | Relationships | Indexes | Total Columns |
|--------|--------|------------------|---------------|---------|---------------|
| Gateway | 20+ | 13 | 25+ | 40+ | 200+ |
| SAE | 15+ | 11 | 20+ | 25+ | 150+ |
| Messaging | 20+ | 15 | 25+ | 30+ | 180+ |
| CEC | 10+ | 8 | 12+ | 15+ | 90+ |
| CTS | 8+ | 7 | 10+ | 12+ | 70+ |
| MARS | 5+ | 5 | 6+ | 8+ | 45+ |
| Site Library | 7+ | 6 | 8+ | 10+ | 65+ |
| Admin | 8+ | 7 | 10+ | 12+ | 75+ |
| **TOTAL** | **93+** | **72** | **116+** | **152+** | **875+** |

---

## Compliance Coverage

### 21 CFR Part 11 (FDA Electronic Records)
- **Audit Trail**: AuditLog table (permanent retention)
- **Electronic Signatures**: User ID + Timestamp + IP Address
- **Record Integrity**: Checksums, foreign key constraints, triggers
- **Access Control**: AspNetRoles, AspNetUserRoles, DocumentPermissions
- **Version Control**: PasswordHistory, DocumentVersions, SAECaseHistory

**Covered By**: Gateway, SAE, CEC, CTS, Site Library, Admin

### GCP ICH E6(R2) (Good Clinical Practice)
- **Safety Reporting**: SAE module
- **Source Documentation**: Site Library
- **Query Management**: SAEQueries, SiteQueries
- **Medical Review**: MedicalReviews (SAE, CEC)
- **Investigator Accountability**: Sites, TrialUserAssignments
- **Subject Protection**: CTS eligibility, informed consent tracking

**Covered By**: SAE, CEC, CTS

### HIPAA (Health Insurance Portability and Accountability Act)
- **PHI Encryption**: Subjects table (FirstName, LastName, DOB, ContactInfo)
- **Access Logging**: LoginHistory, AuditLog
- **Minimum Necessary**: DocumentPermissions, role-based access
- **Audit Trail**: All PHI access logged
- **Data Retention**: Configurable retention policies

**Covered By**: Gateway, CTS

### GDPR (General Data Protection Regulation)
- **Right to be Forgotten**: Soft delete with IsActive flags
- **Data Portability**: Export capabilities
- **Opt-Out**: StopList table
- **Consent Tracking**: Subscriptions, OptOutRequests
- **Breach Notification**: Exception logging

**Covered By**: Messaging, CTS

### CAN-SPAM Act / CASL (Email/SMS Regulations)
- **Opt-Out Links**: Required in all commercial messages
- **Stop List**: Unsubscribe management
- **Sender Identification**: SenderEmail, SenderName
- **Physical Address**: Message footer requirements

**Covered By**: Messaging

---

## Performance Optimization

### Indexing Strategy
- **Primary Keys**: Clustered indexes on all PKs
- **Foreign Keys**: Non-clustered indexes on all FKs
- **Search Columns**: Composite indexes on commonly queried columns
- **Full-Text**: Catalog indexes on document content

### Partitioning
- **AuditLog**: Partitioned by year
- **MessageActivity**: Partitioned by month
- **LoginHistory**: Partitioned by quarter

### Caching
- **Application-Level**: StopList, RoutingRules, SystemSettings
- **Query Results**: Frequently accessed reference data
- **Refresh Frequency**: 5 minutes for configuration, 1 minute for stoplist

### Query Optimization
- **Read-Only Queries**: `AsNoTracking()` for performance
- **Compiled Queries**: Pre-compiled frequent queries
- **Pagination**: Skip/Take for large result sets
- **Lazy Loading**: Disabled (explicit eager loading)

---

## Data Retention Policies

### Permanent Retention (Regulatory)
- AuditLog: Permanent (21 CFR Part 11)
- SAECases, SAECaseHistory: Permanent
- CaseDocuments, DocumentVersions: Permanent
- MedicalReviews, Adjudications: Permanent
- RegulatoryReports: Permanent

### Limited Retention
- LoginHistory: 1 year
- MessageActivity: 2 years
- MessageBounces: 1 year
- InboundMessages: 90 days
- ExceptionLog: 90 days
- SAENotifications: 90 days (after read)

### Archive Policies
- Historical data moved to archive database after retention period
- Compressed storage for archived data
- Read-only access to archives

---

## Security Considerations

### Encryption
- **At Rest**: Transparent Data Encryption (TDE) for entire database
- **Column-Level**: PasswordHash, SecurityStamp, PHI fields
- **In Transit**: TLS 1.2+ for all connections

### Access Control
- **Principle of Least Privilege**: Application service account has minimal permissions
- **Role-Based Access**: AspNetRoles with fine-grained permissions
- **Row-Level Security**: Trial-level data isolation via TrialId filtering

### Audit Trail
- **Immutable**: AuditLog is append-only (no UPDATE/DELETE)
- **Comprehensive**: Who, What, When, Where, Why for all actions
- **Tamper-Proof**: Hash chains for critical records

---

## Migration & Deployment

### Initial Deployment
1. Create database and file groups (FileStream)
2. Run Entity Framework migrations in order
3. Create indexes and constraints
4. Insert seed data (roles, security questions)
5. Create initial admin user
6. Configure Full-Text Search catalogs
7. Set up TDE (if required)

### Version Control
- All schema changes in Entity Framework migrations
- Migration scripts in source control
- Rollback scripts for each migration
- Database version tracking table

### Backup Strategy
- **Full Backups**: Daily at 2:00 AM
- **Differential Backups**: Every 6 hours
- **Transaction Log Backups**: Every 15 minutes
- **FileStream Backups**: Included in full/differential
- **Retention**: 30 days online, 7 years archived

---

## How to Use These ERDs

### For Architects
1. Review overall data model structure
2. Understand module relationships
3. Plan integration points
4. Validate normalization and indexing
5. Design data migration strategies

### For Developers
1. Reference table structures for coding
2. Understand foreign key relationships
3. Implement business rules from ERD notes
4. Create Entity Framework models
5. Write queries based on index design

### For DBAs
1. Create physical database schema
2. Implement indexes and constraints
3. Configure FileStream and Full-Text Search
4. Set up partitioning and archival
5. Monitor performance and optimize

### For QA Engineers
1. Understand data relationships for testing
2. Validate business rules in ERDs
3. Create test data following constraints
4. Test data integrity and referential integrity
5. Verify compliance requirements

---

## Related Documentation

- [Architecture Documentation](../architecture/README.md) - System architecture diagrams
- [Feature Specifications](../features/README.md) - Feature-level documentation
- [TODO.md](../TODO.md) - Project work tracker

---

*Database ERD Documentation Version: 1.0*
*Last Updated: January 2026*
*Total ERD Documents: 8*
*Total Tables: 93+*
*Total Entities: 72*
