# Feature Specification: Stop List Management

## Overview

**Feature Name:** Stop List and Opt-Out Management
**Feature ID:** MSG-005
**Category:** Messaging System
**Priority:** High (Compliance Requirement)
**Status:** Active

## Description

Manages contacts who have opted out of receiving messages or must be blocked for compliance reasons. Enforces opt-out requests at the Global Queue level to prevent messages from reaching messaging providers. Provides management interface for administrators and automatic opt-out processing from inbound messages. Ensures GDPR "right to be forgotten" and CAN-SPAM compliance.

## Business Context

Clinical trials must respect subject communication preferences and legal opt-out requirements. The stop list provides a centralized mechanism to block messages to contacts who have opted out, ensuring compliance with regulations (GDPR, CAN-SPAM, TCPA) and preventing unwanted communications.

## User Roles

- **Trial Coordinator** - Views stop list for their trials
- **Trial Manager** - Manages stop list entries
- **System Administrator** - Global stop list management
- **Compliance Officer** - Audit and reporting

## Functional Requirements

### FR-001: Stop List Storage

**Requirement:** Centralized database of stopped contacts accessible by all queues.

**Database Schema:**
```sql
CREATE TABLE GlobalStopList (
    StopListId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ContactId UNIQUEIDENTIFIER NOT NULL,
    ContactType VARCHAR(10) NOT NULL, -- SMS, Email
    ContactValue VARCHAR(255) NOT NULL, -- Phone number or email address
    OptOutDate DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    OptOutReason NVARCHAR(500) NULL,
    OptOutSource VARCHAR(50) NOT NULL, -- Manual, InboundMessage, UserRequest, Compliance
    SourceTrialId UNIQUEIDENTIFIER NULL,
    SourceMessageThreadId UNIQUEIDENTIFIER NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedBy UNIQUEIDENTIFIER NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ReactivatedBy UNIQUEIDENTIFIER NULL,
    ReactivatedDate DATETIME2 NULL,
    ReactivationReason NVARCHAR(500) NULL,

    INDEX IX_Contact (ContactId, IsActive),
    INDEX IX_ContactValue (ContactValue, ContactType, IsActive),
    INDEX IX_Trial (SourceTrialId, IsActive),
    INDEX IX_OptOutDate (OptOutDate DESC)
);
```

**Acceptance Criteria:**
- Unique constraint on (ContactId, IsActive) where IsActive = 1
- Fast lookup by ContactId (< 10ms)
- Indexed for reporting queries
- Audit trail in Activity table

### FR-002: Global Queue Enforcement

**Requirement:** Global Queue must check stop list before forwarding messages to Gateway Queue.

**Implementation:**
```csharp
public async Task<bool> ProcessMessageRequest(MessageRequest request)
{
    // Load message details
    var message = await db.MessageThreads.FindAsync(request.MessageThreadId);

    // Check stop list
    var isStopped = await stopListService.IsStoppedAsync(message.ContactId);

    if (isStopped && !request.OverrideStopList)
    {
        // Return error to Trial Queue
        await trialQueue.SendErrorAsync(new MessageError
        {
            MessageThreadId = message.MessageThreadId,
            ErrorCode = "STOP_LIST_BLOCKED",
            ErrorMessage = "Contact has opted out of messages",
            ErrorType = ErrorType.Permanent
        });

        // Log block attempt
        await auditManager.InsertAuditEntry(
            "GlobalQueue",
            "ProcessMessageRequest",
            "System",
            null,
            UserAuditActions.MessageBlocked,
            $"Message blocked by stop list for ContactId {message.ContactId}"
        );

        return false;
    }

    // Proceed to Gateway Queue
    await gatewayQueue.SendAsync(request);
    return true;
}
```

**Acceptance Criteria:**
- Stop list checked before every message send
- Blocked messages return to Trial Queue with error
- Block attempts logged for compliance
- Override mechanism for emergency messages

### FR-003: Automatic Opt-Out Processing

**Requirement:** System must automatically process opt-out requests from inbound messages.

**Opt-Out Keywords:**
- STOP
- UNSUBSCRIBE
- OPT OUT
- QUIT
- CANCEL
- END

**Processing Logic:**
```csharp
public async Task HandleIncomingMessage(IncomingMessage message)
{
    // Check for opt-out keywords
    var keywords = new[] { "STOP", "UNSUBSCRIBE", "OPT OUT", "QUIT", "CANCEL", "END" };
    var messageText = message.Body.ToUpper().Trim();

    if (keywords.Any(k => messageText.Contains(k)))
    {
        // Add to stop list
        var stopListEntry = new GlobalStopList
        {
            StopListId = Guid.NewGuid(),
            ContactId = message.ContactId,
            ContactType = message.ContactType,
            ContactValue = message.From,
            OptOutDate = DateTime.UtcNow,
            OptOutReason = $"Inbound opt-out message: '{message.Body}'",
            OptOutSource = "InboundMessage",
            SourceTrialId = message.TrialId,
            SourceMessageThreadId = message.MessageThreadId,
            IsActive = true
        };

        db.GlobalStopList.Add(stopListEntry);
        await db.SaveChangesAsync();

        // Send confirmation message (required by law)
        await SendOptOutConfirmationAsync(message);

        // Notify trial staff
        await notificationService.NotifyTrialStaffAsync(
            message.TrialId,
            $"Subject {message.Subject.Name} has opted out of messages"
        );
    }
}

private async Task SendOptOutConfirmationAsync(IncomingMessage message)
{
    var confirmationMessage = "You have been unsubscribed and will not receive further messages. " +
                             "Reply START to resubscribe or contact [site phone] for assistance.";

    await messagingProvider.SendAsync(new ProviderMessage
    {
        To = message.From,
        Body = confirmationMessage,
        Type = message.ContactType
    });
}
```

**Acceptance Criteria:**
- Opt-out keywords case-insensitive
- Immediate stop list addition
- Confirmation message sent within 60 seconds
- Trial staff notified
- All actions logged

### FR-004: Manual Stop List Management

**Requirement:** Administrators must be able to manually add/remove contacts from stop list.

**Add to Stop List:**
```csharp
[HttpPost("stop-list")]
[TrialRole("TrialManager")]
public async Task<IActionResult> AddToStopList([FromBody] AddStopListRequest request)
{
    var contact = await db.Contacts.FindAsync(request.ContactId);
    if (contact == null)
        return NotFound("Contact not found");

    // Check if already stopped
    var existing = await db.GlobalStopList
        .Where(s => s.ContactId == request.ContactId && s.IsActive)
        .FirstOrDefaultAsync();

    if (existing != null)
        return Conflict("Contact already on stop list");

    var stopListEntry = new GlobalStopList
    {
        StopListId = Guid.NewGuid(),
        ContactId = request.ContactId,
        ContactType = contact.ContactType,
        ContactValue = contact.ContactValue,
        OptOutDate = DateTime.UtcNow,
        OptOutReason = request.Reason,
        OptOutSource = "Manual",
        SourceTrialId = contact.TrialId,
        IsActive = true,
        CreatedBy = CurrentUserId,
        CreatedDate = DateTime.UtcNow
    };

    db.GlobalStopList.Add(stopListEntry);
    await db.SaveChangesAsync();

    // Audit
    await auditManager.InsertAuditEntry(
        "StopListController",
        "AddToStopList",
        CurrentUserName,
        HttpContext.Connection.RemoteIpAddress?.ToString(),
        UserAuditActions.StopListAdded,
        $"Added {contact.ContactValue} to stop list. Reason: {request.Reason}"
    );

    return Ok();
}
```

**Remove from Stop List (Reactivate):**
```csharp
[HttpPost("stop-list/{stopListId}/reactivate")]
[TrialRole("TrialManager")]
public async Task<IActionResult> ReactivateContact(Guid stopListId, [FromBody] ReactivateRequest request)
{
    var stopListEntry = await db.GlobalStopList.FindAsync(stopListId);
    if (stopListEntry == null || !stopListEntry.IsActive)
        return NotFound();

    stopListEntry.IsActive = false;
    stopListEntry.ReactivatedBy = CurrentUserId;
    stopListEntry.ReactivatedDate = DateTime.UtcNow;
    stopListEntry.ReactivationReason = request.Reason;

    await db.SaveChangesAsync();

    await auditManager.InsertAuditEntry(
        "StopListController",
        "ReactivateContact",
        CurrentUserName,
        HttpContext.Connection.RemoteIpAddress?.ToString(),
        UserAuditActions.StopListRemoved,
        $"Reactivated {stopListEntry.ContactValue}. Reason: {request.Reason}"
    );

    return Ok();
}
```

**Acceptance Criteria:**
- Only authorized users can modify stop list
- Reason required for add/remove
- All changes audited with user, timestamp, IP
- Duplicate prevention

### FR-005: Stop List Override

**Requirement:** Emergency messages can override stop list with proper authorization.

**Use Cases:**
- Safety notifications (serious adverse events)
- Critical protocol updates
- Regulatory communications
- Emergency trial closure

**Authorization:**
```csharp
[HttpPost("send-message")]
[TrialRole("PrincipalInvestigator")]
public async Task<IActionResult> SendEmergencyMessage([FromBody] EmergencyMessageRequest request)
{
    if (!request.EmergencyOverride)
        return BadRequest("Emergency override flag required");

    if (string.IsNullOrWhiteSpace(request.OverrideReason))
        return BadRequest("Override reason required");

    // Require PI or higher role for override
    if (!"PrincipalInvestigator,TrialManager,SystemAdministrator".IsAuthorized())
        return Forbid("Insufficient permissions for stop list override");

    var messageRequest = new MessageRequest
    {
        // ... message details
        OverrideStopList = true,
        OverrideReason = request.OverrideReason,
        OverrideAuthorizedBy = CurrentUserId
    };

    await messagingService.SendAsync(messageRequest);

    // Special audit for override
    await auditManager.InsertAuditEntry(
        "EmergencyMessageController",
        "SendEmergencyMessage",
        CurrentUserName,
        HttpContext.Connection.RemoteIpAddress?.ToString(),
        UserAuditActions.StopListOverride,
        $"Stop list override approved. Reason: {request.OverrideReason}"
    );

    return Ok();
}
```

**Acceptance Criteria:**
- Override requires specific role (PI or higher)
- Reason mandatory and logged
- Special audit entry created
- Override flag passed through queue system
- Compliance officer notified of overrides

### FR-006: Stop List Reporting

**Requirement:** Comprehensive reporting for compliance and management.

**Reports:**

#### Stop List Summary
```sql
SELECT
    ContactType,
    COUNT(*) as TotalStopped,
    COUNT(CASE WHEN SourceTrialId = @TrialId THEN 1 END) as ThisTrial,
    COUNT(CASE WHEN OptOutSource = 'InboundMessage' THEN 1 END) as AutoOptOut,
    COUNT(CASE WHEN OptOutSource = 'Manual' THEN 1 END) as ManualOptOut
FROM GlobalStopList
WHERE IsActive = 1
GROUP BY ContactType;
```

#### Recent Opt-Outs
```sql
SELECT
    s.OptOutDate,
    s.ContactType,
    s.ContactValue,
    s.OptOutSource,
    s.OptOutReason,
    t.TrialName,
    sub.SubjectNumber
FROM GlobalStopList s
LEFT JOIN Contact c ON s.ContactId = c.ContactId
LEFT JOIN Subject sub ON c.SubjectId = sub.SubjectId
LEFT JOIN Trial t ON s.SourceTrialId = t.TrialId
WHERE s.IsActive = 1
    AND s.OptOutDate >= @StartDate
ORDER BY s.OptOutDate DESC;
```

#### Override Audit
```sql
SELECT
    a.Timestamp,
    a.UserName,
    a.IPAddress,
    mt.SubjectId,
    mt.MessageContent,
    JSON_VALUE(a.AfterValue, '$.OverrideReason') as OverrideReason
FROM Activity a
INNER JOIN MessageThread mt ON JSON_VALUE(a.AfterValue, '$.MessageThreadId') = mt.MessageThreadId
WHERE a.Action = 'StopListOverride'
    AND a.Timestamp >= @StartDate
ORDER BY a.Timestamp DESC;
```

**Acceptance Criteria:**
- Reports available to compliance officers
- Export to CSV/Excel
- Scheduled email reports
- Dashboard widgets

### FR-007: Opt-In/Re-Subscribe

**Requirement:** Contacts must be able to opt back in to messages.

**Re-Subscribe Keywords:**
- START
- SUBSCRIBE
- OPT IN
- YES
- RESTART

**Processing:**
```csharp
if (keywords.Any(k => messageText.Contains(k)))
{
    var stopListEntry = await db.GlobalStopList
        .Where(s => s.ContactId == message.ContactId && s.IsActive)
        .FirstOrDefaultAsync();

    if (stopListEntry != null)
    {
        stopListEntry.IsActive = false;
        stopListEntry.ReactivatedDate = DateTime.UtcNow;
        stopListEntry.ReactivationReason = "Subject opted back in via inbound message";
        await db.SaveChangesAsync();

        // Send confirmation
        var confirmationMessage = "You have been resubscribed and will receive trial messages. " +
                                 "Reply STOP to unsubscribe.";

        await messagingProvider.SendAsync(new ProviderMessage
        {
            To = message.From,
            Body = confirmationMessage,
            Type = message.ContactType
        });
    }
}
```

**Acceptance Criteria:**
- Re-subscribe keywords recognized
- Immediate reactivation
- Confirmation message sent
- Audit trail maintained

## Non-Functional Requirements

### NFR-001: Performance

- Stop list lookup < 10ms (95th percentile)
- Cache frequently accessed entries (10-minute TTL)
- Support 100,000+ stop list entries
- Index optimization for fast lookups

### NFR-002: Compliance

- GDPR "right to be forgotten" compliance
- CAN-SPAM Act compliance (email)
- TCPA compliance (SMS)
- Audit trail for all operations
- Data retention per regulations

### NFR-003: Reliability

- Stop list check never fails open (fail-safe)
- Fallback to block if check uncertain
- Retry logic for database timeouts
- Alert if stop list unavailable

## Technical Implementation

### Stop List Service

```csharp
public interface IStopListService
{
    Task<bool> IsStoppedAsync(Guid contactId);
    Task AddToStopListAsync(Guid contactId, string reason, string source);
    Task RemoveFromStopListAsync(Guid stopListId, string reason);
    Task<List<StopListEntry>> GetStopListEntriesAsync(Guid trialId);
}

public class StopListService : IStopListService
{
    private readonly ApplicationDbContext _db;
    private readonly IMemoryCache _cache;
    private readonly ILogger<StopListService> _logger;

    public async Task<bool> IsStoppedAsync(Guid contactId)
    {
        var cacheKey = $"stoplist:{contactId}";

        if (_cache.TryGetValue(cacheKey, out bool isStopped))
            return isStopped;

        isStopped = await _db.GlobalStopList
            .AnyAsync(s => s.ContactId == contactId && s.IsActive);

        _cache.Set(cacheKey, isStopped, TimeSpan.FromMinutes(10));

        return isStopped;
    }

    public async Task AddToStopListAsync(Guid contactId, string reason, string source)
    {
        var contact = await _db.Contacts.FindAsync(contactId);

        var entry = new GlobalStopList
        {
            ContactId = contactId,
            ContactType = contact.ContactType,
            ContactValue = contact.ContactValue,
            OptOutReason = reason,
            OptOutSource = source,
            SourceTrialId = contact.TrialId,
            IsActive = true
        };

        _db.GlobalStopList.Add(entry);
        await _db.SaveChangesAsync();

        // Invalidate cache
        _cache.Remove($"stoplist:{contactId}");
    }

    public async Task RemoveFromStopListAsync(Guid stopListId, string reason)
    {
        var entry = await _db.GlobalStopList.FindAsync(stopListId);
        if (entry != null && entry.IsActive)
        {
            entry.IsActive = false;
            entry.ReactivatedDate = DateTime.UtcNow;
            entry.ReactivationReason = reason;
            await _db.SaveChangesAsync();

            // Invalidate cache
            _cache.Remove($"stoplist:{entry.ContactId}");
        }
    }
}
```

### Caching Strategy

**Memory Cache:**
- TTL: 10 minutes
- Eviction: LRU
- Size limit: 100,000 entries
- Invalidate on add/remove

**Redis Cache (Optional):**
- Distributed cache for multi-instance deployments
- TTL: 10 minutes
- Pub/sub for cache invalidation

## Error Handling

### Stop List Service Unavailable

**Fail-Safe Behavior:**
```csharp
public async Task<bool> IsStoppedAsync(Guid contactId)
{
    try
    {
        return await _db.GlobalStopList
            .AnyAsync(s => s.ContactId == contactId && s.IsActive);
    }
    catch (Exception ex)
    {
        _logger.LogError(ex, "Stop list check failed for ContactId {ContactId}", contactId);

        // FAIL-SAFE: Block message if uncertain
        return true;
    }
}
```

**Rationale:** Better to block a message than violate opt-out request.

### Database Timeout

- Retry 3 times with exponential backoff
- If all retries fail, fail-safe to block
- Alert operations team

## Monitoring and Metrics

### Metrics

- **Stop List Size** - Total active entries
- **Opt-Out Rate** - Daily opt-outs per 1000 messages
- **Opt-In Rate** - Daily opt-ins per 1000 messages
- **Block Rate** - Messages blocked by stop list
- **Override Count** - Stop list overrides per day

### Alerts

- Opt-out rate spike (> 5% of messages)
- Stop list size > 10,000 entries
- Stop list override used
- Stop list service unavailable

## Testing Requirements

### Unit Tests

- Opt-out keyword detection
- Cache invalidation logic
- Fail-safe behavior
- Override authorization

### Integration Tests

- End-to-end opt-out flow
- Global Queue stop list enforcement
- Manual add/remove operations
- Override flow

### Compliance Tests

- Opt-out confirmation sent within 60 seconds
- All operations audited
- Override requires proper authorization
- Fail-safe blocks on error

## Configuration

```json
{
  "StopList": {
    "CacheTTLMinutes": 10,
    "OptOutKeywords": ["STOP", "UNSUBSCRIBE", "OPT OUT", "QUIT", "CANCEL", "END"],
    "OptInKeywords": ["START", "SUBSCRIBE", "OPT IN", "YES", "RESTART"],
    "SendConfirmationMessage": true,
    "FailSafeOnError": true,
    "NotifyComplianceOnOverride": true
  }
}
```

## Related Documentation

- [Send Message](./send-message.md) - User-initiated messaging
- [Routing](./routing.md) - Queue architecture with stop list check
- [Activity Tracking](./activity-tracking.md) - Audit trail
- [Auto-Reply](./auto-reply.md) - Automatic opt-out processing

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
