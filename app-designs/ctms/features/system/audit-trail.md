# Feature Specification: Comprehensive Audit Trail (21 CFR Part 11)

## Overview

**Feature Name:** Comprehensive Audit Trail
**Feature ID:** SYS-001
**Category:** System / Cross-Cutting
**Priority:** Critical (Regulatory Requirement)
**Status:** Active

## Description

System-wide audit trail implementation that logs all user actions, data changes, and system events to meet 21 CFR Part 11 requirements for electronic records and electronic signatures. Provides tamper-evident, time-stamped, and complete tracking of all operations across all system modules.

## Regulatory Context

**21 CFR Part 11** - FDA regulations for electronic records and electronic signatures in clinical trials:
- §11.10(e) - Use of secure, computer-generated, time-stamped audit trails
- §11.10(c) - Ability to generate accurate and complete copies of records
- §11.50(a) - Signed electronic records shall contain information:
  - Printed name of signer
  - Date and time when signature executed
  - Meaning of signature (approval, review, responsibility)

## User Roles

- **All Users** - Generate audit entries through actions
- **Data Manager** - Reviews audit trails
- **Compliance Officer** - Audit verification and certification
- **Quality Assurance** - Audit trail validation
- **System Administrator** - Audit system maintenance

## Functional Requirements

### FR-001: Universal Audit Logging

**Requirement:** All data modifications must create audit entries.

**Scope:**
- User authentication (login, logout, password changes)
- Authorization (permission checks, role assignments)
- Data creation, modification, deletion
- Message operations
- Stop list changes
- Template modifications
- Subject enrollment/status changes
- Adverse event reporting
- Document uploads/approvals
- System configuration changes

**Audit Fields (Required):**
```csharp
public class AuditEntry
{
    // Unique identifier
    public Guid AuditId { get; set; }

    // What happened
    public string Action { get; set; }
    public string Entity { get; set; }
    public Guid? EntityId { get; set; }
    public string BeforeValue { get; set; } // JSON
    public string AfterValue { get; set; } // JSON

    // Who did it
    public Guid UserId { get; set; }
    public string UserName { get; set; }
    public string UserRole { get; set; }
    public string UserFullName { get; set; }

    // When
    public DateTime Timestamp { get; set; } // UTC, server-generated

    // Where
    public string IPAddress { get; set; }
    public string HostName { get; set; }
    public string UserAgent { get; set; }

    // Context
    public Guid? TrialId { get; set; }
    public Guid? SiteId { get; set; }
    public string SessionId { get; set; }
    public string ControllerName { get; set; }
    public string ActionName { get; set; }
    public string RequestUrl { get; set; }

    // Integrity
    public string Checksum { get; set; } // SHA-256 hash
    public Guid? PreviousAuditId { get; set; } // Chain
}
```

**Database Schema:**
```sql
CREATE TABLE AuditTrail (
    AuditId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),

    -- Action
    Action VARCHAR(50) NOT NULL,
    Entity VARCHAR(100) NOT NULL,
    EntityId UNIQUEIDENTIFIER NULL,
    BeforeValue NVARCHAR(MAX) NULL,
    AfterValue NVARCHAR(MAX) NULL,

    -- User
    UserId UNIQUEIDENTIFIER NOT NULL,
    UserName VARCHAR(255) NOT NULL,
    UserRole VARCHAR(100) NULL,
    UserFullName VARCHAR(255) NOT NULL,

    -- Timestamp (server-generated, UTC)
    Timestamp DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),

    -- Location
    IPAddress VARCHAR(45) NOT NULL,
    HostName VARCHAR(255) NULL,
    UserAgent NVARCHAR(500) NULL,

    -- Context
    TrialId UNIQUEIDENTIFIER NULL,
    SiteId UNIQUEIDENTIFIER NULL,
    SessionId VARCHAR(100) NULL,
    ControllerName VARCHAR(200) NULL,
    ActionName VARCHAR(100) NULL,
    RequestUrl NVARCHAR(1000) NULL,

    -- Integrity
    Checksum VARCHAR(64) NOT NULL, -- SHA-256
    PreviousAuditId UNIQUEIDENTIFIER NULL,

    -- Indexes
    INDEX IX_Entity (Entity, EntityId, Timestamp DESC),
    INDEX IX_User (UserId, Timestamp DESC),
    INDEX IX_Trial (TrialId, Timestamp DESC),
    INDEX IX_Timestamp (Timestamp DESC),
    INDEX IX_Action (Action, Timestamp DESC),

    -- Foreign Keys
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (TrialId) REFERENCES Trials(TrialId),
    FOREIGN KEY (SiteId) REFERENCES Sites(SiteId),

    -- Constraints
    CHECK (Timestamp <= SYSUTCDATETIME()) -- Prevent future timestamps
);

-- Prevent modifications to audit records
CREATE TRIGGER TR_AuditTrail_PreventModification
ON AuditTrail
INSTEAD OF UPDATE, DELETE
AS
BEGIN
    RAISERROR ('Audit trail records cannot be modified or deleted', 16, 1);
    ROLLBACK TRANSACTION;
END;
```

**Acceptance Criteria:**
- Every data modification creates audit entry
- Audit saved in same transaction as operation
- No operation succeeds without audit log
- Timestamps server-generated (not client)
- Records immutable after creation

### FR-002: UserAuditManager Implementation

**Requirement:** Centralized audit service used across all modules.

**Implementation:**
```csharp
public class UserAuditManager
{
    private readonly ApplicationDbContext _db;
    private readonly IHttpContextAccessor _httpContext;
    private readonly IConfiguration _config;

    public void InsertAuditEntry(
        string controllerName,
        string actionName,
        string userName,
        string ipAddress,
        UserAuditActions action,
        string actionDetails = null,
        object beforeValue = null,
        object afterValue = null,
        Guid? entityId = null,
        string entity = null,
        Guid? trialId = null,
        Guid? siteId = null)
    {
        var user = GetCurrentUser();

        // Calculate checksum
        var checksum = CalculateChecksum(
            action.ToString(),
            userName,
            DateTime.UtcNow,
            beforeValue,
            afterValue
        );

        var auditEntry = new AuditEntry
        {
            AuditId = Guid.NewGuid(),
            Action = action.ToString(),
            Entity = entity ?? controllerName,
            EntityId = entityId,
            BeforeValue = beforeValue != null ? JsonSerializer.Serialize(beforeValue) : null,
            AfterValue = afterValue != null ? JsonSerializer.Serialize(afterValue) : null,

            UserId = user?.UserId ?? Guid.Empty,
            UserName = userName,
            UserRole = user?.Role,
            UserFullName = user?.FullName ?? userName,

            Timestamp = DateTime.UtcNow,

            IPAddress = ipAddress ?? GetIPAddress(),
            HostName = GetHostName(),
            UserAgent = GetUserAgent(),

            TrialId = trialId,
            SiteId = siteId,
            SessionId = GetSessionId(),
            ControllerName = controllerName,
            ActionName = actionName,
            RequestUrl = GetRequestUrl(),

            Checksum = checksum,
            PreviousAuditId = GetLastAuditId()
        };

        _db.AuditTrail.Add(auditEntry);
        _db.SaveChanges();
    }

    private string CalculateChecksum(string action, string userName, DateTime timestamp, object before, object after)
    {
        var data = $"{action}|{userName}|{timestamp:O}|{JsonSerializer.Serialize(before)}|{JsonSerializer.Serialize(after)}";
        using var sha256 = SHA256.Create();
        var hash = sha256.ComputeHash(Encoding.UTF8.GetBytes(data));
        return Convert.ToBase64String(hash);
    }

    private Guid? GetLastAuditId()
    {
        return _db.AuditTrail
            .OrderByDescending(a => a.Timestamp)
            .Select(a => a.AuditId)
            .FirstOrDefault();
    }

    private string GetIPAddress()
    {
        var httpContext = _httpContext.HttpContext;
        if (httpContext == null) return null;

        // Check for proxy headers
        var forwardedFor = httpContext.Request.Headers["X-Forwarded-For"].FirstOrDefault();
        if (!string.IsNullOrEmpty(forwardedFor))
            return forwardedFor.Split(',')[0].Trim();

        var realIP = httpContext.Request.Headers["X-Real-IP"].FirstOrDefault();
        if (!string.IsNullOrEmpty(realIP))
            return realIP;

        return httpContext.Connection.RemoteIpAddress?.ToString();
    }

    private string GetHostName()
    {
        try
        {
            return Dns.GetHostName();
        }
        catch
        {
            return Environment.MachineName;
        }
    }

    private string GetUserAgent()
    {
        return _httpContext.HttpContext?.Request.Headers["User-Agent"].FirstOrDefault();
    }

    private string GetSessionId()
    {
        return _httpContext.HttpContext?.Session?.Id;
    }

    private string GetRequestUrl()
    {
        var request = _httpContext.HttpContext?.Request;
        if (request == null) return null;

        return $"{request.Scheme}://{request.Host}{request.Path}{request.QueryString}";
    }

    private User GetCurrentUser()
    {
        var userId = _httpContext.HttpContext?.User?.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userId)) return null;

        return _db.Users.Find(Guid.Parse(userId));
    }
}
```

**Usage in Controllers:**
```csharp
[HttpPost("subject/{id}/enroll")]
[TrialRole("Administrators")]
public async Task<IActionResult> EnrollSubject(Guid id, [FromBody] EnrollmentData data)
{
    var auditManager = new UserAuditManager();
    var subject = await _db.Subjects.FindAsync(id);

    var beforeValue = new { subject.Status, subject.EnrollmentDate };

    // Perform enrollment
    subject.Status = SubjectStatus.Enrolled;
    subject.EnrollmentDate = DateTime.UtcNow;
    subject.EnrolledBy = CurrentUserId;

    await _db.SaveChangesAsync();

    var afterValue = new { subject.Status, subject.EnrollmentDate, subject.EnrolledBy };

    // Audit
    auditManager.InsertAuditEntry(
        "SubjectController",
        "EnrollSubject",
        User.Identity.Name,
        HttpContext.Connection.RemoteIpAddress?.ToString(),
        UserAuditActions.SubjectEnrolled,
        $"Subject {subject.SubjectNumber} enrolled in trial",
        beforeValue: beforeValue,
        afterValue: afterValue,
        entityId: id,
        entity: "Subject",
        trialId: subject.TrialId,
        siteId: subject.SiteId
    );

    return Ok();
}
```

**Acceptance Criteria:**
- Used consistently across all modules
- Captures all required fields
- Calculates checksums correctly
- Chains audit entries
- Handles errors gracefully

### FR-003: Authentication Audit

**Requirement:** All authentication attempts must be logged.

**Logged Events:**
- Login success
- Login failure (username not found)
- Login failure (invalid password)
- Account locked out
- Password changed
- Password reset requested
- Password reset completed
- Two-factor authentication success/failure
- Session timeout
- Logout

**Example (from CODE_REVIEW.md):**
```csharp
var auditManager = new UserAuditManager();

// Failed login - username not found
if (selecteduser == null)
{
    auditManager.InsertAuditEntry(
        "Gateway.AccountController",
        "Logon",
        model.UserName,
        ipAddress,
        UserAuditActions.Authentication,
        UserAuditDetails.Authentication_Username_Not_Found
    );
}

// Failed login - account locked
if (selecteduser.IsLockedOut)
{
    auditManager.InsertAuditEntry(
        "Gateway.AccountController",
        "Logon",
        model.UserName,
        ipAddress,
        UserAuditActions.Authentication,
        UserAuditDetails.User_Account_Locked_Out
    );
}

// Successful login
auditManager.InsertAuditEntry(
    "Gateway.AccountController",
    "Logon",
    model.UserName,
    ipAddress,
    UserAuditActions.Authentication,
    UserAuditDetails.Authentication_Success
);
```

**Acceptance Criteria:**
- All authentication attempts logged (success and failure)
- IP address captured
- Failed attempt details included
- Supports forensic analysis

### FR-004: Before/After Value Tracking

**Requirement:** Audit trail must capture data state changes.

**Implementation:**
```csharp
public async Task<IActionResult> UpdateSubject(Guid id, [FromBody] SubjectUpdate update)
{
    var subject = await _db.Subjects.FindAsync(id);

    // Capture before state
    var beforeValue = new
    {
        subject.Status,
        subject.Email,
        subject.Phone,
        subject.WithdrawalDate,
        subject.WithdrawalReason
    };

    // Apply updates
    subject.Status = update.Status;
    subject.Email = update.Email;
    subject.Phone = update.Phone;
    if (update.Status == SubjectStatus.Withdrawn)
    {
        subject.WithdrawalDate = DateTime.UtcNow;
        subject.WithdrawalReason = update.WithdrawalReason;
    }

    await _db.SaveChangesAsync();

    // Capture after state
    var afterValue = new
    {
        subject.Status,
        subject.Email,
        subject.Phone,
        subject.WithdrawalDate,
        subject.WithdrawalReason
    };

    // Audit with before/after
    auditManager.InsertAuditEntry(
        "SubjectController",
        "UpdateSubject",
        User.Identity.Name,
        GetIPAddress(),
        UserAuditActions.SubjectUpdated,
        "Subject information updated",
        beforeValue: beforeValue,
        afterValue: afterValue,
        entityId: id,
        entity: "Subject",
        trialId: subject.TrialId
    );

    return Ok();
}
```

**Acceptance Criteria:**
- Before values captured before modification
- After values captured after modification
- Only changed fields included (optional optimization)
- JSON format for complex objects

### FR-005: Audit Trail Integrity

**Requirement:** Audit trail must be tamper-evident.

**Mechanisms:**

#### Checksums
Each audit entry includes SHA-256 checksum of:
- Action
- User
- Timestamp
- Before value
- After value

#### Chaining
Each entry references previous entry ID, creating blockchain-like chain.

#### Verification:**
```csharp
public class AuditIntegrityService
{
    public async Task<AuditIntegrityReport> VerifyIntegrityAsync(Guid? trialId = null)
    {
        var query = _db.AuditTrail.OrderBy(a => a.Timestamp);

        if (trialId.HasValue)
            query = query.Where(a => a.TrialId == trialId);

        var entries = await query.ToListAsync();

        var report = new AuditIntegrityReport
        {
            TotalEntries = entries.Count,
            InvalidChecksums = 0,
            BrokenChains = 0,
            FutureTimestamps = 0
        };

        Guid? expectedPrevious = null;

        foreach (var entry in entries)
        {
            // Verify checksum
            var calculatedChecksum = CalculateChecksum(
                entry.Action,
                entry.UserName,
                entry.Timestamp,
                entry.BeforeValue,
                entry.AfterValue
            );

            if (entry.Checksum != calculatedChecksum)
                report.InvalidChecksums++;

            // Verify chain
            if (entry.PreviousAuditId != expectedPrevious)
                report.BrokenChains++;

            expectedPrevious = entry.AuditId;

            // Verify timestamp
            if (entry.Timestamp > DateTime.UtcNow)
                report.FutureTimestamps++;
        }

        report.IsValid = report.InvalidChecksums == 0
                      && report.BrokenChains == 0
                      && report.FutureTimestamps == 0;

        return report;
    }
}
```

**Acceptance Criteria:**
- Checksums verify data integrity
- Chain links verify completeness
- Verification reports available
- Automated integrity checks (daily)

### FR-006: Audit Reports

**Requirement:** Generate comprehensive audit reports for regulatory submissions.

**Report Types:**

#### User Activity Report
```sql
SELECT
    UserName,
    COUNT(*) as TotalActions,
    COUNT(CASE WHEN Action LIKE '%Create%' THEN 1 END) as Creates,
    COUNT(CASE WHEN Action LIKE '%Update%' THEN 1 END) as Updates,
    COUNT(CASE WHEN Action LIKE '%Delete%' THEN 1 END) as Deletes,
    MIN(Timestamp) as FirstAction,
    MAX(Timestamp) as LastAction
FROM AuditTrail
WHERE TrialId = @TrialId
    AND Timestamp BETWEEN @StartDate AND @EndDate
GROUP BY UserName
ORDER BY TotalActions DESC;
```

#### Data Change Report
```sql
SELECT
    a.Timestamp,
    a.UserFullName,
    a.Action,
    a.Entity,
    a.EntityId,
    a.BeforeValue,
    a.AfterValue,
    a.IPAddress
FROM AuditTrail a
WHERE a.TrialId = @TrialId
    AND a.Timestamp BETWEEN @StartDate AND @EndDate
    AND a.Action IN ('Create', 'Update', 'Delete')
ORDER BY a.Timestamp DESC;
```

#### Authentication Report
```sql
SELECT
    Timestamp,
    UserName,
    Action,
    IPAddress,
    CASE
        WHEN Action = 'Authentication_Success' THEN 'Success'
        ELSE 'Failed'
    END as Result
FROM AuditTrail
WHERE Action LIKE 'Authentication%'
    AND Timestamp BETWEEN @StartDate AND @EndDate
ORDER BY Timestamp DESC;
```

**Acceptance Criteria:**
- Reports meet 21 CFR Part 11 requirements
- Include all required fields
- Exportable (PDF, CSV, Excel)
- Electronic signatures supported
- Tamper-evident (checksums included)

### FR-007: Audit Trail Access Control

**Requirement:** Audit trail access must be restricted and logged.

**Access Levels:**
- **Read-Only** - Data managers, compliance officers
- **Export** - Quality assurance, regulatory affairs
- **Verify** - System administrators
- **No Access** - Regular users (except their own actions)

**Audit Access Logging:**
```csharp
[HttpGet("audit-trail")]
[Authorize(Roles = "DataManager,ComplianceOfficer")]
public async Task<IActionResult> GetAuditTrail(Guid trialId, DateTime startDate, DateTime endDate)
{
    // Log audit trail access
    var auditManager = new UserAuditManager();
    auditManager.InsertAuditEntry(
        "AuditController",
        "GetAuditTrail",
        User.Identity.Name,
        GetIPAddress(),
        UserAuditActions.AuditTrailAccessed,
        $"Accessed audit trail for Trial {trialId}, {startDate} to {endDate}",
        trialId: trialId
    );

    var entries = await _db.AuditTrail
        .Where(a => a.TrialId == trialId
                 && a.Timestamp >= startDate
                 && a.Timestamp <= endDate)
        .OrderByDescending(a => a.Timestamp)
        .ToListAsync();

    return Ok(entries);
}
```

**Acceptance Criteria:**
- Role-based access control
- All access logged
- Users can view their own audit records
- Compliance officers have full access

## Non-Functional Requirements

### NFR-001: Performance

- Audit insert < 50ms (95th percentile)
- No impact on primary operation (< 5% overhead)
- Async logging where appropriate
- Optimized indexes for queries

### NFR-002: Storage

- Estimated 10-20 audit entries per user per day
- 100 users = 2,000 entries/day = 60,000/month
- Average entry size: 2 KB
- Monthly storage: ~120 MB
- Annual storage: ~1.5 GB per trial

### NFR-003: Retention

- Online retention: Trial duration + 2 years
- Archive retention: 25 years (regulatory requirement)
- No deletion without compliance approval

### NFR-004: Reliability

- 99.99% audit logging success rate
- Transaction consistency (audit with operation)
- Backup and disaster recovery
- Automated integrity verification

## Monitoring and Metrics

### Metrics

- Audit entries per hour/day
- Audit insert performance (latency)
- Storage growth rate
- Integrity check results

### Alerts

- Audit logging failure
- Integrity check failure
- Storage threshold exceeded
- Unusual activity patterns

## Testing Requirements

### Unit Tests

- Checksum calculation
- Chain verification
- Before/after value capture
- IP address extraction

### Integration Tests

- Audit created with operation
- Transaction rollback removes audit
- Concurrent audit logging
- Export functionality

### Compliance Tests

- All required fields populated
- Immutability enforcement
- Access control verification
- Report accuracy

## Configuration

```json
{
  "AuditTrail": {
    "Enabled": true,
    "EnableChecksums": true,
    "EnableChaining": true,
    "LogIPAddress": true,
    "LogBeforeAfterValues": true,
    "MaxBeforeAfterValueSize": 4000,
    "OnlineRetentionYears": 2,
    "ArchiveRetentionYears": 25,
    "DailyIntegrityCheck": true
  }
}
```

## Related Documentation

- [Activity Tracking](../messaging/activity-tracking.md) - Messaging-specific audit
- [RBAC](./rbac.md) - Role-based access control
- [Exception Logging](./exception-logging.md) - Error audit trail

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
