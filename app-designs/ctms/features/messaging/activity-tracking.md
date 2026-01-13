# Feature Specification: Activity Tracking and Engagement Metrics

## Overview

**Feature Name:** Activity Tracking and Engagement Metrics
**Feature ID:** MSG-007
**Category:** Messaging System
**Priority:** High (Compliance Requirement)
**Status:** Active

## Description

Comprehensive logging and tracking of all messaging activities for audit compliance, engagement analytics, and troubleshooting. Records every message operation with full context (user, timestamp, IP address, before/after values) to meet 21 CFR Part 11 requirements. Provides engagement metrics and subject communication history.

## Business Context

Clinical trials operate under strict regulatory requirements for audit trails and electronic records (21 CFR Part 11, GxP). Every communication with trial subjects must be logged with complete traceability. Activity tracking provides compliance evidence, supports investigator queries, enables engagement analysis, and facilitates troubleshooting.

## User Roles

- **Trial Coordinator** - Views subject communication history
- **Principal Investigator** - Reviews messaging compliance
- **Data Manager** - Exports audit reports
- **Compliance Officer** - Audit trail verification
- **System Administrator** - Troubleshooting and monitoring

## Functional Requirements

### FR-001: Comprehensive Activity Logging

**Requirement:** All messaging operations must create activity records.

**Logged Operations:**
- Message created
- Message scheduled
- Message sent
- Message delivered
- Message received (from subject)
- Message failed
- Message canceled
- Stop list added/removed
- Template used
- Auto-reply triggered

**Activity Record Structure:**
```csharp
public class Activity
{
    public Guid ActivityId { get; set; }
    public Guid TrialId { get; set; }
    public Guid? SubjectId { get; set; }
    public Guid? MessageThreadId { get; set; }

    // What happened
    public UserAuditActions Action { get; set; }
    public string ActionDetails { get; set; }

    // Who did it
    public Guid? UserId { get; set; }
    public string UserName { get; set; }
    public string UserRole { get; set; }

    // When and where
    public DateTime Timestamp { get; set; }
    public string IPAddress { get; set; }
    public string UserAgent { get; set; }

    // State changes
    public string BeforeValue { get; set; } // JSON
    public string AfterValue { get; set; } // JSON

    // Context
    public string ControllerName { get; set; }
    public string ActionName { get; set; }
    public string SessionId { get; set; }
}

public enum UserAuditActions
{
    // Message Operations
    MessageCreated,
    MessageScheduled,
    MessageSent,
    MessageDelivered,
    MessageReceived,
    MessageFailed,
    MessageCanceled,
    MessageRescheduled,

    // Stop List
    StopListAdded,
    StopListRemoved,
    StopListOverride,

    // Auto-Reply
    AutoReplyTriggered,
    AutoRuleCreated,
    AutoRuleModified,

    // Emergency
    EmergencyDetected,
    EmergencyEscalated,

    // Authentication
    Authentication,
    Authorization,

    // General
    InvalidOperation,
    SystemError
}
```

**Database Schema:**
```sql
CREATE TABLE Activity (
    ActivityId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    TrialId UNIQUEIDENTIFIER NOT NULL,
    SubjectId UNIQUEIDENTIFIER NULL,
    MessageThreadId UNIQUEIDENTIFIER NULL,

    -- Action
    Action VARCHAR(50) NOT NULL,
    ActionDetails NVARCHAR(500) NULL,

    -- User
    UserId UNIQUEIDENTIFIER NULL,
    UserName VARCHAR(255) NULL,
    UserRole VARCHAR(100) NULL,

    -- Timestamp and location
    Timestamp DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    IPAddress VARCHAR(45) NULL,
    UserAgent NVARCHAR(500) NULL,

    -- State changes
    BeforeValue NVARCHAR(MAX) NULL,
    AfterValue NVARCHAR(MAX) NULL,

    -- Context
    ControllerName VARCHAR(200) NULL,
    ActionName VARCHAR(100) NULL,
    SessionId VARCHAR(100) NULL,

    -- Indexes for performance
    INDEX IX_Trial_Timestamp (TrialId, Timestamp DESC),
    INDEX IX_Subject_Timestamp (SubjectId, Timestamp DESC),
    INDEX IX_Message_Timestamp (MessageThreadId, Timestamp DESC),
    INDEX IX_User_Timestamp (UserId, Timestamp DESC),
    INDEX IX_Action_Timestamp (Action, Timestamp DESC)
);
```

**Acceptance Criteria:**
- Every message operation creates activity record
- Activity created in same transaction as operation
- No operations succeed without activity log
- Timestamps in UTC
- IP address captured from HTTP context

### FR-002: UserAuditManager Implementation

**Requirement:** Centralized service for creating audit entries.

**Implementation:**
```csharp
public class UserAuditManager
{
    private readonly ApplicationDbContext _db;
    private readonly IHttpContextAccessor _httpContext;

    public void InsertAuditEntry(
        string controllerName,
        string actionName,
        string userName,
        string ipAddress,
        UserAuditActions action,
        string actionDetails = null,
        object beforeValue = null,
        object afterValue = null)
    {
        var activity = new Activity
        {
            ActivityId = Guid.NewGuid(),
            ControllerName = controllerName,
            ActionName = actionName,
            UserName = userName,
            IPAddress = ipAddress ?? GetIPAddress(),
            Action = action.ToString(),
            ActionDetails = actionDetails,
            Timestamp = DateTime.UtcNow,
            BeforeValue = beforeValue != null ? JsonSerializer.Serialize(beforeValue) : null,
            AfterValue = afterValue != null ? JsonSerializer.Serialize(afterValue) : null,
            UserAgent = _httpContext.HttpContext?.Request.Headers["User-Agent"].ToString(),
            SessionId = _httpContext.HttpContext?.Session?.Id
        };

        _db.Activities.Add(activity);
        _db.SaveChanges();
    }

    private string GetIPAddress()
    {
        var httpContext = _httpContext.HttpContext;
        if (httpContext == null)
            return null;

        // Check for proxy/load balancer headers
        var forwardedFor = httpContext.Request.Headers["X-Forwarded-For"].FirstOrDefault();
        if (!string.IsNullOrEmpty(forwardedFor))
            return forwardedFor.Split(',')[0].Trim();

        return httpContext.Connection.RemoteIpAddress?.ToString();
    }
}
```

**Usage Example:**
```csharp
[HttpPost("send")]
[TrialRole("TrialCoordinator")]
public async Task<IActionResult> SendMessage([FromBody] SendMessageRequest request)
{
    var auditManager = new UserAuditManager();

    try
    {
        var message = await messagingService.SendAsync(request);

        auditManager.InsertAuditEntry(
            "MessagingController",
            "SendMessage",
            User.Identity.Name,
            HttpContext.Connection.RemoteIpAddress?.ToString(),
            UserAuditActions.MessageCreated,
            $"Message sent to Subject {request.SubjectId}",
            beforeValue: null,
            afterValue: new { message.MessageThreadId, message.Status, request.TemplateId }
        );

        return Ok(message);
    }
    catch (Exception ex)
    {
        auditManager.InsertAuditEntry(
            "MessagingController",
            "SendMessage",
            User.Identity.Name,
            HttpContext.Connection.RemoteIpAddress?.ToString(),
            UserAuditActions.SystemError,
            $"Failed to send message: {ex.Message}"
        );

        throw;
    }
}
```

**Acceptance Criteria:**
- Consistent audit format across all controllers
- IP address captured correctly (behind proxy)
- User agent logged for troubleshooting
- Before/after values stored as JSON
- Transaction consistency (audit saved with operation)

### FR-003: Message State Change Tracking

**Requirement:** Track all message state transitions with reasons.

**State Transition Audit:**
```csharp
public async Task TransitionState(
    Guid messageThreadId,
    MessageStatus newStatus,
    string reason = null)
{
    var message = await db.MessageThreads.FindAsync(messageThreadId);
    var oldStatus = message.Status;

    var auditManager = new UserAuditManager();
    auditManager.InsertAuditEntry(
        "MessageStateMachine",
        "TransitionState",
        "System",
        null,
        GetAuditAction(newStatus),
        reason,
        beforeValue: new { Status = oldStatus },
        afterValue: new { Status = newStatus, Reason = reason }
    );

    message.Status = newStatus;
    await db.SaveChangesAsync();
}

private UserAuditActions GetAuditAction(MessageStatus status)
{
    return status switch
    {
        MessageStatus.Sent => UserAuditActions.MessageSent,
        MessageStatus.Failed => UserAuditActions.MessageFailed,
        MessageStatus.Canceled => UserAuditActions.MessageCanceled,
        _ => UserAuditActions.MessageCreated
    };
}
```

**Acceptance Criteria:**
- All state changes logged
- Previous and new state in audit
- Reason captured when available
- Actor identified (User, Scheduler, System, Provider)

### FR-004: Engagement Metrics

**Requirement:** Calculate and track subject engagement metrics.

**Metrics:**

#### Message Delivery Metrics
- **Delivery Rate:** % messages delivered successfully
- **Response Rate:** % delivered messages that received reply
- **Average Response Time:** Time from sent to subject reply
- **Engagement Score:** Composite metric

**Calculation:**
```csharp
public class EngagementMetrics
{
    public async Task<SubjectEngagement> CalculateAsync(Guid subjectId, DateTime startDate, DateTime endDate)
    {
        var activities = await db.Activities
            .Where(a => a.SubjectId == subjectId
                     && a.Timestamp >= startDate
                     && a.Timestamp <= endDate)
            .ToListAsync();

        var messagesSent = activities.Count(a => a.Action == "MessageSent");
        var messagesDelivered = activities.Count(a => a.Action == "MessageDelivered");
        var messagesReceived = activities.Count(a => a.Action == "MessageReceived");

        return new SubjectEngagement
        {
            SubjectId = subjectId,
            Period = $"{startDate:yyyy-MM-dd} to {endDate:yyyy-MM-dd}",
            MessagesSent = messagesSent,
            MessagesDelivered = messagesDelivered,
            DeliveryRate = messagesSent > 0 ? (double)messagesDelivered / messagesSent : 0,
            ResponsesReceived = messagesReceived,
            ResponseRate = messagesDelivered > 0 ? (double)messagesReceived / messagesDelivered : 0,
            AverageResponseTimeMinutes = CalculateAvgResponseTime(activities),
            EngagementScore = CalculateEngagementScore(messagesSent, messagesReceived)
        };
    }

    private double CalculateEngagementScore(int sent, int received)
    {
        if (sent == 0) return 0;

        var responseRate = (double)received / sent;

        // Score: 0-100 based on response rate
        return Math.Min(100, responseRate * 100);
    }
}
```

#### Activity Patterns
- **Peak Activity Hours:** When subject most responsive
- **Preferred Channel:** SMS vs Email engagement
- **Appointment Compliance:** Confirmation response rate

**Acceptance Criteria:**
- Metrics calculated on-demand or cached
- Historical trending available
- Trial-level aggregation
- Export to CSV/Excel

### FR-005: Subject Communication History

**Requirement:** Comprehensive view of all communications with subject.

**UI Components:**

**Timeline View:**
```
2026-01-13 10:30 AM  [Sent]      Appointment reminder
2026-01-13 10:35 AM  [Delivered] Message delivered via SMS
2026-01-13 11:45 AM  [Received]  Subject replied: "CONFIRMED"
2026-01-13 11:46 AM  [AutoReply] Auto-reply sent: "Thank you for confirming"
```

**Filtering:**
- Date range
- Message type (Sent, Received, System)
- Status (Delivered, Failed, etc.)
- Channel (SMS, Email)

**Details View:**
- Full message content
- Template used
- Sent by (user)
- Delivery status
- Subject response (if any)
- All state transitions

**Implementation:**
```csharp
[HttpGet("subject/{subjectId}/communications")]
[TrialRole("TrialCoordinator")]
public async Task<IActionResult> GetCommunications(
    Guid subjectId,
    DateTime? startDate = null,
    DateTime? endDate = null)
{
    var query = db.Activities
        .Where(a => a.SubjectId == subjectId);

    if (startDate.HasValue)
        query = query.Where(a => a.Timestamp >= startDate.Value);

    if (endDate.HasValue)
        query = query.Where(a => a.Timestamp <= endDate.Value);

    var activities = await query
        .OrderByDescending(a => a.Timestamp)
        .Select(a => new CommunicationHistoryItem
        {
            Timestamp = a.Timestamp,
            Action = a.Action,
            Details = a.ActionDetails,
            UserName = a.UserName,
            MessageContent = GetMessageContent(a.MessageThreadId)
        })
        .ToListAsync();

    return Ok(activities);
}
```

**Acceptance Criteria:**
- All communications visible to authorized users
- Real-time updates
- Printable format for source documents
- Export capability

### FR-006: Audit Reports

**Requirement:** Generate compliance audit reports.

**Report Types:**

#### Message Audit Trail
- All messages sent in date range
- User who sent each message
- Delivery status
- Any failures or errors

#### Stop List Activity
- All opt-outs in period
- Source of opt-out (inbound, manual, etc.)
- Any reactivations
- Override attempts

#### System Activity
- Failed message summary
- Emergency escalations
- Stop list overrides
- Auto-reply performance

**SQL Examples:**

**Message Audit Report:**
```sql
SELECT
    a.Timestamp,
    a.UserName,
    a.Action,
    s.SubjectNumber,
    s.InitialsBlinded,
    mt.MessageContent,
    mt.Status,
    a.IPAddress
FROM Activity a
INNER JOIN Subject s ON a.SubjectId = s.SubjectId
LEFT JOIN MessageThread mt ON a.MessageThreadId = mt.MessageThreadId
WHERE a.TrialId = @TrialId
    AND a.Timestamp BETWEEN @StartDate AND @EndDate
    AND a.Action IN ('MessageCreated', 'MessageSent', 'MessageFailed')
ORDER BY a.Timestamp DESC;
```

**Stop List Audit:**
```sql
SELECT
    a.Timestamp,
    a.UserName,
    a.Action,
    a.ActionDetails,
    a.IPAddress,
    JSON_VALUE(a.AfterValue, '$.Reason') as Reason
FROM Activity a
WHERE a.Action IN ('StopListAdded', 'StopListRemoved', 'StopListOverride')
    AND a.Timestamp BETWEEN @StartDate AND @EndDate
ORDER BY a.Timestamp DESC;
```

**Acceptance Criteria:**
- Reports meet 21 CFR Part 11 requirements
- Include all required audit fields
- Tamper-evident (checksums)
- Exportable formats (PDF, CSV, Excel)
- Electronic signatures for certified reports

### FR-007: Activity Data Retention

**Requirement:** Retain activity data per regulatory requirements.

**Retention Policy:**
- **Active Trial Period:** All activity retained online
- **Post-Trial 2 years:** Online retention
- **Years 3-25:** Archive to cold storage
- **After 25 years:** Eligible for deletion (per protocol)

**Archival Process:**
```csharp
public async Task ArchiveOldActivities()
{
    var archiveDate = DateTime.UtcNow.AddYears(-2);

    var oldActivities = await db.Activities
        .Where(a => a.Timestamp < archiveDate)
        .ToListAsync();

    // Export to archive storage
    await archiveService.ArchiveAsync(oldActivities);

    // Verify archive
    var verified = await archiveService.VerifyArchiveAsync(oldActivities);

    if (verified)
    {
        // Delete from primary database
        db.Activities.RemoveRange(oldActivities);
        await db.SaveChangesAsync();
    }
}
```

**Acceptance Criteria:**
- Automated archival process
- Verification before deletion
- Retrieval process for archived data
- Compliance with retention regulations

## Non-Functional Requirements

### NFR-001: Performance

- Activity insert < 50ms (95th percentile)
- No impact on primary operation performance
- Async logging where appropriate
- Batch inserts for high-volume operations

### NFR-002: Data Integrity

- Activity logged in same transaction as operation
- No operation succeeds without activity log
- Foreign key constraints enforced
- JSON validation for Before/After values

### NFR-003: Security

- Activity table append-only (no updates/deletes)
- Access restricted to authorized roles
- Audit reports include access logs
- Tamper detection (checksums)

### NFR-004: Compliance

- Meets 21 CFR Part 11 requirements
- GxP compliance
- HIPAA compliance (no PHI in logs where possible)
- GDPR compliance (right to access audit data)

## Monitoring and Metrics

### System Metrics

- **Activity Volume:** Records created per hour
- **Storage Growth:** GB per month
- **Query Performance:** Report generation time
- **Archival Status:** Records archived per month

### Alerts

- Activity logging failure
- Activity table growth exceeds threshold
- Compliance report generation failure
- Archive verification failure

## Testing Requirements

### Unit Tests

- UserAuditManager implementation
- Engagement metric calculations
- JSON serialization/deserialization
- IP address extraction

### Integration Tests

- Activity created with message send
- Transaction rollback removes activity
- Concurrent activity logging
- Archive and retrieval process

### Compliance Tests

- All required fields populated
- Audit trail completeness
- Report accuracy
- Data retention compliance

## Configuration

```json
{
  "ActivityTracking": {
    "Enabled": true,
    "LogIPAddress": true,
    "LogUserAgent": true,
    "LogBeforeAfterValues": true,
    "MaxBeforeAfterValueSize": 4000,
    "RetentionYears": 25,
    "ArchiveAfterYears": 2,
    "EnablePerformanceLogging": false
  }
}
```

## Related Documentation

- [Send Message](./send-message.md) - Message operations that create activities
- [Stop List](./stop-list.md) - Stop list activity tracking
- [Auto-Reply](./auto-reply.md) - Auto-reply activity logging
- [Audit Trail](/current/src/docs/features/system/audit-trail.md) - System-wide audit requirements

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
