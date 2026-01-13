# Feature Specifications Index

This document provides an index of all feature specifications created for the OoBDev clinical trial system.

## Messaging System Features

Location: `/current/src/docs/features/messaging/`

### 1. Send Message (MSG-001)
**File:** `send-message.md`
**Description:** User-initiated messaging to trial subjects via SMS/Email
**Key Components:**
- Message composition and template selection
- Recipient selection and validation
- Send timing options (Send Now / Send Later)
- Message state tracking
- Stop list enforcement
- Activity logging

### 2. Message Routing (MSG-002)
**File:** `routing.md`
**Description:** Three-tier queue architecture for message processing
**Key Components:**
- Trial Queue - Trial-specific operations
- Global Queue - Central coordination and stop list validation
- Gateway Queue - Provider integration (SMS/Email)
- Service Bus dialogs
- Message flow patterns

### 3. State Machine (MSG-003)
**File:** `state-machine.md`
**Description:** Message lifecycle state management
**States:**
- Delayed, Ready, Pending, Sent, Received, Failed, Canceled
**Key Components:**
- State transition logic
- User-initiated transitions
- Scheduler-initiated transitions
- System-initiated transitions
- Concurrency handling

### 4. Scheduled Messages (MSG-004)
**File:** `scheduled-messages.md`
**Description:** Delayed messaging and reminder series
**Key Components:**
- Scheduler service (background worker)
- Send time validation
- Reminder series templates
- Recurring messages
- Business hours routing

### 5. Stop List (MSG-005)
**File:** `stop-list.md`
**Description:** Opt-out management and enforcement
**Key Components:**
- Global stop list database
- Automatic opt-out/opt-in processing
- Stop list enforcement at Global Queue
- Manual management interface
- Override capability for emergency messages
- Compliance (GDPR, CAN-SPAM, TCPA)

### 6. Auto-Reply (MSG-006)
**File:** `auto-reply.md`
**Description:** Automated response handling for inbound messages
**Key Components:**
- Inbound message processing
- Opt-out/opt-in detection
- Common question auto-replies
- Emergency keyword detection
- Business hours routing
- Configurable auto-reply rules

### 7. Activity Tracking (MSG-007)
**File:** `activity-tracking.md`
**Description:** Comprehensive messaging audit trail and engagement metrics
**Key Components:**
- Activity logging for all operations
- UserAuditManager implementation
- Engagement metrics calculation
- Subject communication history
- Audit reports
- 21 CFR Part 11 compliance

## System / Cross-Cutting Features

Location: `/current/src/docs/features/system/`

### 1. Audit Trail (SYS-001)
**File:** `audit-trail.md`
**Description:** Comprehensive system-wide audit logging (21 CFR Part 11)
**Key Components:**
- Universal audit logging
- UserAuditManager implementation
- Authentication audit
- Before/after value tracking
- Audit trail integrity (checksums, chaining)
- Audit reports
- Access control

**Audit Fields:**
- Action, Entity, EntityId
- User (ID, Name, Role)
- Timestamp (UTC, server-generated)
- IP Address, HostName
- BeforeValue, AfterValue (JSON)
- Checksum (SHA-256)

### 2. RBAC (SYS-002)
**File:** `rbac.md`
**Description:** Role-based access control with trial-level scoping
**Key Components:**
- TrialRole custom attribute
- String.IsAuthorized() extension method
- Role definitions (PI, Coordinator, etc.)
- Trial user role assignments
- Multi-tenancy support

**Standard Roles:**
- SystemAdministrator
- TrialManager
- PrincipalInvestigator
- TrialCoordinator
- StudyNurse
- DataManager
- Monitor
- Viewer

### 3. Email Queue (SYS-003)
**File:** `email-queue.md`
**Description:** Asynchronous email processing (Work Item #578)
**Key Components:**
- Email queue database
- Email service interface
- Background processor
- Retry logic
- Provider integration (SendGrid, AWS SES)

### 4. Exception Logging (SYS-004)
**File:** `exception-logging.md`
**Description:** Comprehensive exception tracking (Work Item #579)
**Key Components:**
- Global exception filter
- Exception database schema
- Exception logging service
- Correlation IDs
- Exception dashboard
- Integration with Application Insights

### 5. Multi-Tenancy (SYS-005)
**File:** `multi-tenancy.md`
**Description:** Trial-level data isolation
**Key Components:**
- ITrialScoped interface
- Automatic trial scoping
- TrialScopedController base class
- Row-level security (optional)
- Trial context middleware
- Cross-trial data prevention

## Architecture Components Referenced

### Queue Architecture (3-Queue System)

```
User → Trial Queue → Global Queue → Gateway Queue → Provider → Subject
  ↓         ↓             ↓              ↓
Thread   Activity    Stop List      Template
                                      Merge
```

**Trial Queue:**
- Handles trial-specific message processing
- Loads Subject, Contact, Template data
- Creates activity records
- Manages message thread state

**Global Queue:**
- Central coordination and routing
- Stop list validation
- Send-by-date validation
- Routes to Gateway Queue
- Handles acknowledgements and errors

**Gateway Queue:**
- Provider integration (Twilio, SendGrid)
- Message Builder (template merge)
- Delivery acknowledgement
- Error handling

### Message Providers

**SMS Providers:**
- Twilio
- AWS SNS

**Email Providers:**
- SendGrid
- AWS SES

### Service Bus Dialogs

All critical operations use SQL Server Service Bus dialogs for transactional messaging:

```sql
BEGIN DIALOG CONVERSATION
    FROM SERVICE [SenderService]
    TO SERVICE 'ReceiverService'
    ON CONTRACT [MessageContract];

SEND ON CONVERSATION
    MESSAGE TYPE [MessageRequestType];

WAITFOR RECEIVE FROM [ResponseQueue];

END CONVERSATION;
```

### Message Threading

Messages organized into conversation threads:
- Outbound messages to subjects
- Inbound replies from subjects
- Thread-level state tracking
- Activity logging per thread

### UserAuditManager Implementation

Centralized audit service used across all modules:

```csharp
var auditManager = new UserAuditManager();
auditManager.InsertAuditEntry(
    controllerName: "Gateway.AccountController",
    actionName: "Logon",
    userName: model.UserName,
    ipAddress: GetIPAddress(),
    action: UserAuditActions.Authentication,
    actionDetails: UserAuditDetails.Authentication_Success,
    beforeValue: previousState,
    afterValue: newState,
    entityId: recordId,
    entity: "EntityName",
    trialId: trialId
);
```

**Key Fields:**
- Action - What happened
- User - Who did it
- Timestamp - When (UTC)
- IP Address - Where from
- Before/After Values - State changes

### TrialRole Custom Attribute

Declarative authorization at controller/action level:

```csharp
[TrialRole("TrialCoordinator", "PrincipalInvestigator")]
public class MessagingController : Controller
{
    [TrialRole("PrincipalInvestigator")]
    public ActionResult SendEmergencyMessage(Guid trialId)
    {
        // Only PI can send emergency messages
    }
}
```

### String.IsAuthorized() Extension Method

Inline authorization checks within methods:

```csharp
public ActionResult Edit(Guid id)
{
    var currentUser = (Guid)Membership.GetUser().ProviderUserKey;

    if (id != currentUser && !"Administrators".IsAuthorized())
        return new HttpUnauthorizedResult();

    // Allow user to edit their own profile, or admin to edit anyone
}
```

## Compliance and Regulatory References

### 21 CFR Part 11
- Electronic records and electronic signatures
- Audit trail requirements (§11.10(e))
- System validation documentation
- User authentication and authorization

### HIPAA
- PHI protection in messages
- Business Associate Agreements with providers
- Access controls and encryption
- Breach notification procedures

### GDPR
- Right to be forgotten (stop list)
- Data minimization
- Consent management
- Data retention policies

### CAN-SPAM Act
- Email opt-out compliance
- Unsubscribe mechanisms
- Sender identification

### TCPA
- SMS opt-out compliance
- Prior express consent
- Do Not Call list compliance

## Technology Stack

### Backend
- ASP.NET MVC (.NET Framework)
- C# with Code Contracts
- Entity Framework (ORM)
- SQL Server with Service Broker

### Messaging Infrastructure
- Azure Service Bus (queues and dialogs)
- Twilio (SMS)
- SendGrid (Email)

### Storage
- SQL Server (primary database)
- Azure Key Vault (credentials)

### Monitoring
- Application Insights
- Custom exception logging
- Performance metrics

## Common Patterns and Practices

### Audit Logging Pattern
Every data modification creates audit entry in same transaction:
```csharp
using (var transaction = db.Database.BeginTransaction())
{
    // Perform operation
    entity.Status = newStatus;
    db.SaveChanges();

    // Log audit
    auditManager.InsertAuditEntry(...);

    transaction.Commit();
}
```

### Trial Scoping Pattern
All queries filtered by user's authorized trials:
```csharp
var subjects = db.Subjects.AsQueryable();
subjects = ScopeToAuthorizedTrials(subjects);
return View(subjects.ToList());
```

### Message State Transition Pattern
State changes logged with before/after values:
```csharp
var beforeValue = new { message.Status };
message.Status = MessageStatus.Sent;
var afterValue = new { message.Status };

auditManager.InsertAuditEntry(
    ...,
    beforeValue: beforeValue,
    afterValue: afterValue
);
```

### Error Handling Pattern
All exceptions logged with full context:
```csharp
try
{
    await PerformOperation();
}
catch (Exception ex)
{
    exceptionLogger.LogExceptionAsync(new ExceptionLog
    {
        ExceptionType = ex.GetType().FullName,
        Message = ex.Message,
        StackTrace = ex.StackTrace,
        CorrelationId = Activity.Current?.Id
    });

    throw;
}
```

## Document Status

**Created:** 2026-01-13
**Author:** Architecture Documentation Team
**Status:** Complete
**Review Date:** TBD

## Related Documentation

- [Architecture Overview](/current/src/docs/architecture/README.md)
- [Messaging Architecture](/current/src/docs/architecture/messaging/README.md)
- [Gateway Use Cases](/current/src/docs/architecture/gateway/use-cases.md)
- [Code Review](/current/src/docs/architecture/CODE_REVIEW.md)

---

*This index provides a comprehensive overview of all feature specifications. Each specification contains detailed functional requirements, technical implementation details, database schemas, API specifications, testing requirements, and compliance considerations.*
