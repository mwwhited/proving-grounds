# Messaging Architecture Quick Reference

## Message Flow Overview

```
User → Trial Queue → Global Queue → Gateway Queue → Provider → Recipient
  ↓         ↓             ↓              ↓
Thread   Activity    Stop List      Template
         Tracking                    Merge
```

## Queue Hierarchy

1. **Trial Queue** - Trial-specific operations
2. **Global Queue** - Central routing and coordination
3. **Gateway Queue** - External provider integration

## Message States

| State | Description | Next States |
|-------|-------------|-------------|
| Delayed | Scheduled for later | Ready, Failed, Canceled |
| Ready | Prepared for sending | Pending |
| Pending | Queued for delivery | Sent, Failed |
| Sent | Successfully delivered | (terminal) |
| Received | Incoming from subject | (terminal) |
| Failed | Delivery failed | (terminal) |
| Canceled | User canceled | (terminal) |

## Key Operations by Queue

### Trial Queue Operations

| Operation | Purpose |
|-----------|---------|
| HandleMessageRequest | Process outbound message from thread |
| HandleMessageReceived | Process incoming message from subject |
| HandleAcknowledgement | Update message status to Sent |
| HandleError | Handle delivery failures |
| HandleSystemMessage | Process automated messages |
| TriggerMessageReady | Fire when delayed message is ready |

### Global Queue Operations

| Operation | Purpose |
|-----------|---------|
| HandleMessageRequest | Route to Gateway with stop list check |
| HandleMessageReceived | Route incoming message to trial |
| HandleAcknowledgement | Forward delivery confirmation |
| HandleAcknowledgeReceived | Process receipt confirmation |
| HandleError | Classify and route errors |
| HandleSystemMessage | Distribute system messages |

### Gateway Queue Operations

| Operation | Purpose |
|-----------|---------|
| ReceiveMessage | Capture incoming messages from provider |
| HandleMessageRequest | Build and send message via provider |

## Message Types

| Type | Description | Route |
|------|-------------|-------|
| Message Request | New outbound message | Trial → Global → Gateway → Provider |
| Message Received | Incoming from subject | Provider → Gateway → Global → Trial |
| Acknowledgement | Delivery confirmation | Gateway → Global → Trial |
| Error | Delivery failure | Gateway/Global → Trial |
| System Message | Automated notification | Global → Trial or Gateway |

## User Actions

| Action | Starting State | Ending State |
|--------|---------------|--------------|
| Send Now | (new) | Ready |
| Send Later | (new) | Delayed |
| Cancel | Delayed | Canceled |

## Scheduler Actions

| Action | Condition | Transition |
|--------|-----------|------------|
| Now Ready | Send time arrived & valid | Delayed → Ready |
| Now Late | Past send window | Delayed → Failed |

## Components Reference

### Trial Components
- **Trial - Local Queue** - Trial-specific message queue
- **Trial - Message Thread** - Conversation with subject
- **Trial - Subject** - Trial participant
- **Trial - Contact** - Subject contact info (phone/email)
- **Trial - Message Template** - Pre-defined message templates
- **Trial - Activity** - Audit trail
- **Trial - Scheduler** - Delayed message management

### Global Components
- **Global - Central Queue** - Main routing queue
- **Global - Stop List** - Opt-out/blocked contacts
- **Global - Gateway Queue** - External interface

### Gateway Components
- **Message Builder** - Template + data → final message
- **Messaging Provider** - SMS/Email service integration
- **Message Provider** - Receives incoming messages

## Common Patterns

### Critical Section
Most operations wrapped in critical sections for atomicity:
```
Begin Critical Section
  Load Data
  Process
  Update State
End Critical Section
```

### Service Bus Dialog
Transactional message processing:
```
Begin Dialog
  Send/Receive Operations
End Dialog
```

### Optional Processing (opt)
Conditional processing based on message type:
```
opt [Condition]
  Process if condition met
end
```

### Consider Fragment
Process specific message types:
```
consider [Subject, Contact, Template]
  Load required entities
end
```

## Error Handling Strategy

### Temporary Errors
- Network timeout
- Provider temporarily unavailable
- **Action:** Retry with exponential backoff

### Permanent Errors
- Invalid phone number
- Unsubscribed email
- Contact on stop list
- **Action:** Mark Failed, notify user

### Validation Errors
- Missing template
- Invalid subject
- **Action:** Mark Failed, log error

## Retry Policy

| Attempt | Delay | Action |
|---------|-------|--------|
| 1st failure | 1 min | Retry |
| 2nd failure | 5 min | Retry |
| 3rd failure | 15 min | Retry |
| 4th failure | - | Mark Failed |

## Performance Tips

### Optimization Points
- **Caching** - Subject, Contact, Template data
- **Batching** - Multiple messages to same queue
- **Indexing** - Status, ScheduledTime, TrialId fields
- **Partitioning** - Separate queues per trial range
- **Connection Pooling** - Reuse database connections

### Monitoring Metrics
- Messages per state (gauge)
- Transition rates (counter)
- Delivery success rate (percentage)
- Average dwell time per state (histogram)
- Error rates by type (counter)

## Security Considerations

### Data Protection
- **Encryption at Rest** - Database encryption
- **Encryption in Transit** - TLS for all communications
- **PII Handling** - Minimal message content logging

### Access Control
- **User Permissions** - Role-based message sending
- **Trial Isolation** - Users can only send to their trials
- **Audit Trail** - All actions logged with user ID

### Provider Security
- **API Keys** - Secure credential storage
- **Rate Limiting** - Prevent abuse
- **IP Whitelisting** - Restrict provider access

## Compliance

### Requirements
- **HIPAA** - PHI protection in messages
- **21 CFR Part 11** - Electronic records and signatures
- **GDPR** - Right to be forgotten (stop list)

### Audit Trail
All operations logged with:
- Timestamp
- User ID
- Action type
- Before/after state
- Message content (if allowed)

## Troubleshooting Guide

### Message Stuck in Pending
1. Check Gateway Queue processing
2. Verify provider API status
3. Review error logs
4. Check service bus health

### Message Not Delivered
1. Check stop list
2. Verify contact information
3. Review message status history
4. Check provider delivery reports

### Delayed Message Not Sending
1. Verify scheduler is running
2. Check message send window
3. Verify subject still active
4. Review message state transitions

### Duplicate Messages
1. Check for retry logic issues
2. Verify idempotency keys
3. Review message occurrence specs
4. Check service bus duplicate detection

## API Reference (Quick)

### Send Message
```csharp
var message = new MessageRequest {
    TrialId = trialId,
    SubjectId = subjectId,
    TemplateId = templateId,
    ContactType = ContactType.SMS,
    SendOption = SendOption.SendNow
};
await messageService.SendAsync(message);
```

### Schedule Message
```csharp
var message = new MessageRequest {
    // ... same as above
    SendOption = SendOption.SendLater,
    ScheduledSendTime = DateTime.UtcNow.AddHours(24)
};
await messageService.SendAsync(message);
```

### Cancel Message
```csharp
await messageService.CancelAsync(messageThreadId);
```

## Configuration Settings

### Queue Settings
- `MessageQueue:PollInterval` - 60 seconds
- `MessageQueue:BatchSize` - 100 messages
- `MessageQueue:MaxConcurrency` - 10 workers

### Scheduler Settings
- `Scheduler:PollInterval` - 60 seconds
- `Scheduler:SendWindowHours` - 4 hours
- `Scheduler:TimeZone` - UTC

### Provider Settings
- `SMS:Provider` - Twilio/AWS SNS
- `Email:Provider` - SendGrid/AWS SES
- `Provider:RateLimit` - 100/minute
- `Provider:Timeout` - 30 seconds

### Retry Settings
- `Retry:MaxAttempts` - 4
- `Retry:InitialDelay` - 60 seconds
- `Retry:BackoffMultiplier` - 5

## Additional Resources

- [Full Architecture Docs](./README.md)
- [State Machine Details](./state-machine.md)
- [User Workflows](./workflows.md)
- [Diagram Mapping](./DIAGRAM_MAPPING.md)
