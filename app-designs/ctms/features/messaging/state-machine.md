# Feature Specification: Message State Machine

## Overview

**Feature Name:** Message Thread State Machine
**Feature ID:** MSG-003
**Category:** Messaging System
**Priority:** High
**Status:** Active

## Description

Defines the complete lifecycle of a message from creation through delivery and confirmation. Manages state transitions based on user actions, scheduler events, delivery results, and error conditions. Ensures data integrity and auditability throughout the message lifecycle.

## Business Context

Clinical trial messages must maintain strict audit trails and state consistency for regulatory compliance. The state machine provides deterministic state transitions, prevents invalid operations, and ensures complete tracking of every message throughout its lifecycle.

## Message States

### State Definitions

| State | Description | Type | Next States |
|-------|-------------|------|-------------|
| **Delayed** | Scheduled for future delivery | Intermediate | Ready, Failed, Canceled |
| **Ready** | Prepared and ready to send | Intermediate | Pending |
| **Pending** | Queued for delivery | Intermediate | Sent, Failed |
| **Sent** | Successfully delivered | Terminal | None |
| **Received** | Confirmed receipt by subject | Terminal | None |
| **Failed** | Delivery failed permanently | Terminal | None |
| **Canceled** | User canceled before delivery | Terminal | None |

### State Categories

#### Intermediate States
States where messages can transition to other states:
- **Delayed** - Awaiting scheduled time
- **Ready** - Ready for immediate sending
- **Pending** - Being processed by provider

#### Terminal States
Final states with no further transitions:
- **Sent** - Successfully delivered
- **Received** - Subject confirmed receipt
- **Failed** - Delivery failed permanently
- **Canceled** - User canceled message

## State Diagram

```
                        ┌─────────────┐
                        │ User Request│
                        └──────┬──────┘
                               │
                    ┌──────────┴──────────┐
                    │                     │
              Send Now              Send Later
                    │                     │
                    ▼                     ▼
              ┌──────────┐         ┌──────────┐
              │  Ready   │         │ Delayed  │
              └────┬─────┘         └────┬─────┘
                   │                    │
         Fire      │         ┌──────────┼──────────┐
        Trigger    │         │          │          │
                   │    Scheduler  Scheduler  User Cancel
                   │         │          │          │
                   │      Now Ready  Now Late      │
                   │         │          │          │
                   ▼         ▼          │          ▼
              ┌──────────┐         ┌───┴────┐  ┌──────────┐
              │ Pending  │         │ Failed │  │Canceled  │
              └────┬─────┘         └────────┘  └──────────┘
                   │
        ┌──────────┴──────────┐
        │                     │
   Acknowledged          Failed Send
        │                     │
        ▼                     ▼
  ┌──────────┐         ┌──────────┐
  │   Sent   │         │ Failed   │
  └────┬─────┘         └──────────┘
       │
  (Optional)
  Receipt Ack
       │
       ▼
  ┌──────────┐
  │ Received │
  └──────────┘

  Incoming Message Path:
  ┌──────────────────┐
  │ Message Received │
  │   from Subject   │
  └────────┬─────────┘
           │
           ▼
      ┌──────────┐
      │ Received │
      └──────────┘
```

## State Transitions

### Entry Points

#### User Request → Ready (Send Now)
**Trigger:** User selects "Send Now" option

**Preconditions:**
- User has permission to send messages
- Subject is active in trial
- Contact is valid
- Template exists

**Actions:**
1. Create MessageThread record with Status = Ready
2. Set CreatedDate = Current UTC time
3. Set CreatedBy = Current user ID
4. Create activity record (MessageCreated)
5. Enqueue to Trial Queue immediately

**Postconditions:**
- Message in Ready state
- Message in Trial Queue
- Activity logged

**Code Example:**
```csharp
var messageThread = new MessageThread
{
    MessageThreadId = Guid.NewGuid(),
    TrialId = request.TrialId,
    SubjectId = request.SubjectId,
    ContactId = request.ContactId,
    TemplateId = request.TemplateId,
    Status = MessageStatus.Ready,
    CreatedBy = currentUserId,
    CreatedDate = DateTime.UtcNow
};

db.MessageThreads.Add(messageThread);
db.SaveChanges();

await trialQueue.SendAsync(new MessageRequest
{
    MessageThreadId = messageThread.MessageThreadId
});
```

#### User Request → Delayed (Send Later)
**Trigger:** User selects "Send Later" with scheduled time

**Preconditions:**
- Same as Send Now
- ScheduledSendTime is in the future
- ScheduledSendTime within allowed window

**Actions:**
1. Create MessageThread with Status = Delayed
2. Set ScheduledSendTime
3. Register with scheduler
4. Create activity record (MessageScheduled)

**Postconditions:**
- Message in Delayed state
- Scheduler monitoring message
- Activity logged

**Code Example:**
```csharp
var messageThread = new MessageThread
{
    // ... same fields as Ready
    Status = MessageStatus.Delayed,
    ScheduledSendTime = request.ScheduledSendTime
};

db.MessageThreads.Add(messageThread);
db.SaveChanges();

await scheduler.RegisterDelayedMessageAsync(messageThread.MessageThreadId);
```

### Scheduler Transitions

#### Delayed → Ready (Now Ready)
**Trigger:** Scheduler determines send time has arrived

**Preconditions:**
- Current time >= ScheduledSendTime
- Current time <= ScheduledSendTime + SendWindow
- Subject still active
- Contact still valid

**Actions:**
1. Update Status = Ready
2. Validate send conditions
3. Enqueue to Trial Queue
4. Create activity (MessageReady)

**Postconditions:**
- Message in Ready state
- Message in Trial Queue
- Scheduler unregistered

**Code Example:**
```csharp
public async Task ProcessDelayedMessages()
{
    var now = DateTime.UtcNow;
    var messages = db.MessageThreads
        .Where(m => m.Status == MessageStatus.Delayed
                 && m.ScheduledSendTime <= now
                 && m.ScheduledSendTime >= now.AddHours(-SendWindowHours))
        .ToList();

    foreach (var message in messages)
    {
        if (await ValidateSendConditions(message))
        {
            message.Status = MessageStatus.Ready;
            db.SaveChanges();

            await trialQueue.SendAsync(new MessageRequest
            {
                MessageThreadId = message.MessageThreadId
            });
        }
    }
}
```

#### Delayed → Failed (Now Late)
**Trigger:** Scheduler determines send window has passed

**Preconditions:**
- Current time > ScheduledSendTime + SendWindow

**Actions:**
1. Update Status = Failed
2. Set FailureReason = "Too Late"
3. Create activity (MessageFailed)
4. Notify user

**Postconditions:**
- Message in Failed state
- User notified
- Activity logged

**Code Example:**
```csharp
var lateMessages = db.MessageThreads
    .Where(m => m.Status == MessageStatus.Delayed
             && m.ScheduledSendTime < now.AddHours(-SendWindowHours))
    .ToList();

foreach (var message in lateMessages)
{
    message.Status = MessageStatus.Failed;
    message.FailureReason = "Message send window expired";
    db.SaveChanges();

    await notificationService.NotifyUserAsync(
        message.CreatedBy,
        $"Message to {message.Subject.Name} was not sent (too late)"
    );
}
```

### User Transitions

#### Delayed → Canceled (User Cancel)
**Trigger:** User cancels scheduled message

**Preconditions:**
- Message Status = Delayed
- User has permission to cancel
- User is original creator OR has manager role

**Actions:**
1. Update Status = Canceled
2. Record cancellation user and time
3. Unregister from scheduler
4. Create activity (MessageCanceled)

**Postconditions:**
- Message in Canceled state
- Scheduler unregistered
- Activity logged with reason

**Code Example:**
```csharp
[TrialRole("TrialCoordinator")]
public async Task<IActionResult> CancelMessage(Guid messageThreadId, string reason)
{
    var message = await db.MessageThreads.FindAsync(messageThreadId);

    if (message.Status != MessageStatus.Delayed)
    {
        return BadRequest("Only delayed messages can be canceled");
    }

    if (message.CreatedBy != currentUserId && !"TrialManager".IsAuthorized())
    {
        return Forbid("You can only cancel your own messages");
    }

    message.Status = MessageStatus.Canceled;
    message.CanceledBy = currentUserId;
    message.CanceledDate = DateTime.UtcNow;
    message.CancelReason = reason;
    await db.SaveChangesAsync();

    await scheduler.UnregisterMessageAsync(messageThreadId);

    return Ok();
}
```

### System Transitions

#### Ready → Pending (Fire Trigger / Enqueue)
**Trigger:** System enqueues ready message for delivery

**Preconditions:**
- Message Status = Ready

**Actions:**
1. Update Status = Pending
2. Set QueuedTime = Current time
3. Create activity (MessageQueued)

**Postconditions:**
- Message in Pending state
- Message in Trial Queue → Global Queue → Gateway Queue

**Note:** This transition is automatic when message reaches Ready state.

#### Pending → Sent (Acknowledged)
**Trigger:** Provider confirms successful delivery

**Preconditions:**
- Valid acknowledgement received from provider

**Actions:**
1. Update Status = Sent
2. Set SentTime = Delivery time
3. Set ProviderMessageId
4. Create activity (MessageSent)
5. Notify user (optional)

**Postconditions:**
- Message in Sent terminal state
- Activity logged
- User optionally notified

**Code Example:**
```csharp
public async Task HandleAcknowledgement(AcknowledgementMessage ack)
{
    var message = await db.MessageThreads.FindAsync(ack.MessageThreadId);

    if (message.Status != MessageStatus.Pending)
    {
        logger.LogWarning(
            "Received ACK for message {MessageId} in unexpected state {Status}",
            message.MessageThreadId,
            message.Status
        );
        return;
    }

    message.Status = MessageStatus.Sent;
    message.SentTime = ack.DeliveryTime;
    message.ProviderMessageId = ack.ProviderMessageId;
    await db.SaveChangesAsync();
}
```

#### Pending → Failed (Failed Send)
**Trigger:** Provider returns error or delivery fails

**Preconditions:**
- Error received from provider or queue

**Actions:**
1. Update Status = Failed
2. Set FailureReason = Error details
3. Set FailedTime = Current time
4. Create activity (MessageFailed)
5. Notify user
6. Determine if retry appropriate

**Postconditions:**
- Message in Failed state (or retrying)
- Error logged
- User notified

**Code Example:**
```csharp
public async Task HandleError(ErrorMessage error)
{
    var message = await db.MessageThreads.FindAsync(error.MessageThreadId);

    var errorType = ClassifyError(error);

    if (errorType == ErrorType.Temporary && message.RetryCount < MaxRetries)
    {
        message.RetryCount++;
        message.NextRetryTime = DateTime.UtcNow.AddMinutes(
            RetryDelays[message.RetryCount - 1]
        );
        await db.SaveChangesAsync();

        await scheduler.ScheduleRetryAsync(message);
    }
    else
    {
        message.Status = MessageStatus.Failed;
        message.FailureReason = error.ErrorMessage;
        message.FailedTime = DateTime.UtcNow;
        await db.SaveChangesAsync();

        await notificationService.NotifyUserAsync(
            message.CreatedBy,
            $"Message failed: {error.ErrorMessage}"
        );
    }
}
```

#### Sent → Received (Optional Receipt Acknowledgement)
**Trigger:** Subject confirms receipt (read receipts, if supported)

**Preconditions:**
- Message Status = Sent
- Provider supports read receipts
- Subject client supports read receipts

**Actions:**
1. Update Status = Received
2. Set ReceivedTime = Receipt time
3. Create activity (MessageReceived)

**Postconditions:**
- Message in Received terminal state
- Activity logged

**Note:** Not all providers support this. Sent is often the final state.

### Incoming Message Path

#### [*] → Received (Message Received from Subject)
**Trigger:** Subject sends message (reply)

**Preconditions:**
- Valid message received from provider
- Contact can be identified
- Trial and subject can be identified

**Actions:**
1. Parse incoming message
2. Identify or create message thread
3. Create MessageThread with Status = Received
4. Set message content
5. Create activity (IncomingMessage)
6. Notify assigned users

**Postconditions:**
- Received message logged in thread
- Activity recorded
- Users notified

**Code Example:**
```csharp
public async Task HandleIncomingMessage(IncomingMessage msg)
{
    var contact = await db.Contacts
        .FirstOrDefaultAsync(c => c.ContactValue == msg.From);

    if (contact == null)
    {
        logger.LogWarning("Received message from unknown contact {From}", msg.From);
        return;
    }

    var thread = new MessageThread
    {
        MessageThreadId = Guid.NewGuid(),
        TrialId = contact.TrialId,
        SubjectId = contact.SubjectId,
        ContactId = contact.ContactId,
        Status = MessageStatus.Received,
        MessageContent = msg.Body,
        ReceivedTime = msg.ReceivedTime,
        Direction = MessageDirection.Incoming
    };

    db.MessageThreads.Add(thread);
    await db.SaveChangesAsync();

    await notificationService.NotifyTrialStaffAsync(
        contact.TrialId,
        $"New message from {contact.Subject.Name}"
    );
}
```

## Invalid Transitions

### Prevented Transitions

| From | To | Reason |
|------|----|----|
| Ready | Delayed | Cannot reschedule immediate send |
| Pending | Delayed | Already queued |
| Sent | Any | Terminal state |
| Failed | Any | Terminal state |
| Canceled | Any | Terminal state |
| Received (incoming) | Sent | Incoming messages don't get sent |

### Error Handling

**Invalid Transition Attempt:**
```csharp
public async Task<bool> TransitionState(
    Guid messageThreadId,
    MessageStatus newStatus)
{
    var message = await db.MessageThreads.FindAsync(messageThreadId);

    if (!IsValidTransition(message.Status, newStatus))
    {
        logger.LogWarning(
            "Invalid state transition for message {MessageId}: {From} -> {To}",
            messageThreadId,
            message.Status,
            newStatus
        );

        await auditManager.InsertAuditEntry(
            "MessageStateMachine",
            "TransitionState",
            currentUser,
            ipAddress,
            UserAuditActions.InvalidOperation,
            $"Attempted invalid transition {message.Status} -> {newStatus}"
        );

        return false;
    }

    message.Status = newStatus;
    await db.SaveChangesAsync();
    return true;
}

private bool IsValidTransition(MessageStatus from, MessageStatus to)
{
    return ValidTransitions.TryGetValue(from, out var validNext)
        && validNext.Contains(to);
}

private static readonly Dictionary<MessageStatus, HashSet<MessageStatus>>
    ValidTransitions = new()
{
    { MessageStatus.Delayed, new() {
        MessageStatus.Ready,
        MessageStatus.Failed,
        MessageStatus.Canceled
    }},
    { MessageStatus.Ready, new() {
        MessageStatus.Pending
    }},
    { MessageStatus.Pending, new() {
        MessageStatus.Sent,
        MessageStatus.Failed
    }},
    { MessageStatus.Sent, new() {
        MessageStatus.Received
    }}
};
```

## State Persistence

### Database Fields

**MessageThread Table:**
```sql
CREATE TABLE MessageThread (
    MessageThreadId UNIQUEIDENTIFIER PRIMARY KEY,
    TrialId UNIQUEIDENTIFIER NOT NULL,
    SubjectId UNIQUEIDENTIFIER NOT NULL,
    ContactId UNIQUEIDENTIFIER NOT NULL,
    TemplateId UNIQUEIDENTIFIER NULL,

    -- State tracking
    Status VARCHAR(20) NOT NULL, -- Delayed, Ready, Pending, Sent, Received, Failed, Canceled
    Direction VARCHAR(10) NOT NULL DEFAULT 'Outgoing', -- Outgoing, Incoming

    -- Timing
    CreatedDate DATETIME2 NOT NULL,
    ScheduledSendTime DATETIME2 NULL,
    QueuedTime DATETIME2 NULL,
    SentTime DATETIME2 NULL,
    ReceivedTime DATETIME2 NULL,
    FailedTime DATETIME2 NULL,
    CanceledDate DATETIME2 NULL,

    -- Users
    CreatedBy UNIQUEIDENTIFIER NOT NULL,
    CanceledBy UNIQUEIDENTIFIER NULL,

    -- Content
    MessageContent NVARCHAR(MAX) NULL,

    -- Provider details
    ProviderMessageId VARCHAR(100) NULL,

    -- Failure/Cancel details
    FailureReason NVARCHAR(500) NULL,
    CancelReason NVARCHAR(500) NULL,
    RetryCount INT DEFAULT 0,
    NextRetryTime DATETIME2 NULL,

    -- Indexes
    INDEX IX_Status (Status, ScheduledSendTime),
    INDEX IX_Subject (SubjectId, Status),
    INDEX IX_Trial (TrialId, Status, CreatedDate)
);
```

### State History

**MessageStateHistory Table:**
```sql
CREATE TABLE MessageStateHistory (
    StateHistoryId UNIQUEIDENTIFIER PRIMARY KEY,
    MessageThreadId UNIQUEIDENTIFIER NOT NULL,
    PreviousStatus VARCHAR(20) NOT NULL,
    NewStatus VARCHAR(20) NOT NULL,
    TransitionDate DATETIME2 NOT NULL,
    TransitionReason VARCHAR(100) NULL, -- User, Scheduler, Provider, Error
    TransitionDetails NVARCHAR(MAX) NULL,
    UserId UNIQUEIDENTIFIER NULL,

    FOREIGN KEY (MessageThreadId) REFERENCES MessageThread(MessageThreadId),
    INDEX IX_Message (MessageThreadId, TransitionDate)
);
```

**Trigger to Log State Changes:**
```sql
CREATE TRIGGER TR_MessageThread_StateChange
ON MessageThread
AFTER UPDATE
AS
BEGIN
    INSERT INTO MessageStateHistory (
        StateHistoryId,
        MessageThreadId,
        PreviousStatus,
        NewStatus,
        TransitionDate,
        TransitionReason
    )
    SELECT
        NEWID(),
        i.MessageThreadId,
        d.Status,
        i.Status,
        GETUTCDATE(),
        CASE
            WHEN i.CanceledBy IS NOT NULL THEN 'User'
            WHEN i.FailedTime IS NOT NULL THEN 'Error'
            WHEN i.SentTime IS NOT NULL THEN 'Provider'
            ELSE 'System'
        END
    FROM inserted i
    INNER JOIN deleted d ON i.MessageThreadId = d.MessageThreadId
    WHERE i.Status <> d.Status;
END;
```

## Concurrency and Race Conditions

### Race Condition: User Cancel vs Scheduler Ready

**Scenario:** User attempts to cancel while scheduler is processing "Now Ready"

**Resolution:**
- Use database-level locking
- Optimistic concurrency with row version
- Last write wins, but both logged

**Implementation:**
```csharp
public async Task<bool> CancelMessage(Guid messageThreadId)
{
    using var transaction = await db.Database.BeginTransactionAsync();

    try
    {
        var message = await db.MessageThreads
            .FromSqlRaw("SELECT * FROM MessageThread WITH (UPDLOCK) WHERE MessageThreadId = {0}",
                messageThreadId)
            .FirstOrDefaultAsync();

        if (message.Status != MessageStatus.Delayed)
        {
            // Already transitioned by scheduler
            return false;
        }

        message.Status = MessageStatus.Canceled;
        message.CanceledBy = currentUserId;
        message.CanceledDate = DateTime.UtcNow;

        await db.SaveChangesAsync();
        await transaction.CommitAsync();

        return true;
    }
    catch (DbUpdateConcurrencyException)
    {
        await transaction.RollbackAsync();
        return false;
    }
}
```

### Race Condition: Multiple Delivery Attempts

**Scenario:** Retry logic triggers while original attempt completes

**Resolution:**
- Idempotency keys prevent duplicate delivery
- Provider-side deduplication (1-hour window)
- Check current state before processing acknowledgement

**Implementation:**
```csharp
// Include idempotency key in provider request
var providerRequest = new ProviderMessageRequest
{
    IdempotencyKey = messageThreadId.ToString(),
    // ... other fields
};

// Provider deduplicates based on key
// Azure Service Bus also provides duplicate detection
```

## Monitoring and Metrics

### State Distribution Metrics

**Query:**
```sql
SELECT
    Status,
    COUNT(*) as MessageCount,
    AVG(DATEDIFF(SECOND, CreatedDate, GETUTCDATE())) as AvgAgeSeconds
FROM MessageThread
WHERE CreatedDate >= DATEADD(HOUR, -24, GETUTCDATE())
GROUP BY Status;
```

**Expected Distribution (24-hour window):**
- Delayed: 5-15% (scheduled messages)
- Ready: < 1% (transient state)
- Pending: < 5% (in flight)
- Sent: 70-85% (successfully delivered)
- Received: 0-5% (if provider supports)
- Failed: < 5% (delivery failures)
- Canceled: < 5% (user cancellations)

### Dwell Time by State

Track how long messages spend in each state:

```csharp
public class StateDwellMetrics
{
    public TimeSpan AverageDelayedTime { get; set; }
    public TimeSpan AveragePendingTime { get; set; }
    public TimeSpan TotalDeliveryTime { get; set; } // Created to Sent
}
```

**Target Metrics:**
- Pending → Sent: < 30 seconds (95th percentile)
- Ready → Sent: < 60 seconds (95th percentile)
- Delayed → Sent: Within 5 minutes of scheduled time

### Alerts

- Pending state > 5 minutes: Critical
- Failed rate > 10%: Warning
- Failed rate > 25%: Critical
- Canceled rate > 15%: Warning (unusual pattern)

## Testing Requirements

### Unit Tests

- Valid state transitions
- Invalid transition rejection
- Concurrent state change handling
- State history logging

### Integration Tests

- Full lifecycle: Created → Ready → Pending → Sent
- Scheduled lifecycle: Created → Delayed → Ready → Pending → Sent
- Cancellation: Created → Delayed → Canceled
- Failure handling: Created → Ready → Pending → Failed
- Retry logic: Failed → Pending → Sent

### State Machine Tests

```csharp
[Fact]
public async Task SendNow_TransitionsToReady()
{
    var message = await SendMessage(SendOption.SendNow);
    Assert.Equal(MessageStatus.Ready, message.Status);
}

[Fact]
public async Task CancelDelayedMessage_TransitionsToCanceled()
{
    var message = await SendMessage(SendOption.SendLater);
    var result = await CancelMessage(message.MessageThreadId);

    var updated = await db.MessageThreads.FindAsync(message.MessageThreadId);
    Assert.Equal(MessageStatus.Canceled, updated.Status);
}

[Fact]
public async Task CannotCancelSentMessage()
{
    var message = await SendMessage(SendOption.SendNow);
    await SimulateDelivery(message.MessageThreadId);

    var result = await CancelMessage(message.MessageThreadId);
    Assert.False(result);
}
```

## Related Documentation

- [Send Message](./send-message.md) - User workflows
- [Routing](./routing.md) - Queue architecture
- [Scheduled Messages](./scheduled-messages.md) - Delayed message handling
- [Activity Tracking](./activity-tracking.md) - Audit trail

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
