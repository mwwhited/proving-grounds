# Feature Specification: Message Routing

## Overview

**Feature Name:** Message Routing and Queue Architecture
**Feature ID:** MSG-002
**Category:** Messaging System
**Priority:** High
**Status:** Active

## Description

Implements a three-tier queue architecture (Gateway, Global, Trial) for reliable message processing, routing, and delivery. Provides message flow coordination, stop list validation, provider abstraction, and error handling across the messaging system.

## Business Context

Clinical trial messaging requires reliable, auditable, and compliant message delivery. The three-queue architecture provides separation of concerns, scalability, and fault tolerance while maintaining strict audit requirements and trial isolation.

## Architecture Layers

### 1. Trial Queue (Trial - Local Queue)

**Purpose:** Trial-specific message processing and subject interaction

**Responsibilities:**
- Receive message requests from application layer
- Load trial-specific data (Subject, Contact, Template)
- Create activity records for audit trail
- Forward prepared messages to Global Queue
- Handle delivery confirmations and errors
- Manage message thread state

**Technology:** Azure Service Bus - Trial-scoped queues

### 2. Global Queue (Global - Central Queue)

**Purpose:** Central coordination and system-level validation

**Responsibilities:**
- Stop list validation (enforce opt-outs)
- Send-by-date validation (prevent late delivery)
- Route messages to Gateway Queue
- Route incoming messages to Trial Queues
- Handle system-wide error classification
- Process delivery acknowledgements

**Technology:** Azure Service Bus - Centralized queue

### 3. Gateway Queue (Global - Gateway Queue)

**Purpose:** External provider integration and message delivery

**Responsibilities:**
- Build final messages from templates
- Integrate with messaging providers (SMS, Email)
- Handle provider-specific formatting
- Send delivery acknowledgements
- Capture incoming messages from providers
- Return errors to Global Queue

**Technology:** Azure Service Bus - Provider interface queue

## Message Flow Patterns

### Outbound Message Flow (User → Subject)

```
┌──────────┐
│   User   │
└────┬─────┘
     │ Send Message
     ▼
┌──────────────────────┐
│   Trial Queue        │
│  - Load Subject      │
│  - Load Contact      │
│  - Load Template     │
│  - Create Activity   │
└────┬─────────────────┘
     │ Forward Request
     ▼
┌──────────────────────┐
│   Global Queue       │
│  - Check Stop List   │
│  - Validate Timing   │
│  - Route to Gateway  │
└────┬─────────────────┘
     │ Forward to Provider
     ▼
┌──────────────────────┐
│   Gateway Queue      │
│  - Build Message     │
│  - Call Provider API │
│  - Return Status     │
└────┬─────────────────┘
     │ API Call
     ▼
┌──────────────────────┐
│  Messaging Provider  │
│  (Twilio/SendGrid)   │
└────┬─────────────────┘
     │ Deliver
     ▼
┌──────────┐
│ Subject  │
└──────────┘
```

### Inbound Message Flow (Subject → User)

```
┌──────────┐
│ Subject  │
└────┬─────┘
     │ Reply
     ▼
┌──────────────────────┐
│  Messaging Provider  │
└────┬─────────────────┘
     │ Webhook
     ▼
┌──────────────────────┐
│   Gateway Queue      │
│  - Receive Message   │
│  - Parse Content     │
└────┬─────────────────┘
     │ Route to Trial
     ▼
┌──────────────────────┐
│   Global Queue       │
│  - Identify Trial    │
│  - Forward Message   │
└────┬─────────────────┘
     │ Deliver
     ▼
┌──────────────────────┐
│   Trial Queue        │
│  - Update Thread     │
│  - Create Activity   │
│  - Notify User       │
└──────────────────────┘
```

### Acknowledgement Flow

```
┌──────────────────────┐
│  Gateway Queue       │
│  - Provider Confirms │
└────┬─────────────────┘
     │ Acknowledgement
     ▼
┌──────────────────────┐
│   Global Queue       │
│  - Forward ACK       │
└────┬─────────────────┘
     │ Update Status
     ▼
┌──────────────────────┐
│   Trial Queue        │
│  - Update to "Sent"  │
│  - Log Activity      │
│  - Notify User       │
└──────────────────────┘
```

## Functional Requirements

### FR-001: Trial Queue Operations

**Requirement:** Trial Queue must process trial-specific message operations.

**Operations:**

#### TrialQueueHandleMessageRequest
- Dequeue message request
- Load Subject, Contact, Template (consider: Subject, Email/SMS)
- Create activity record
- Forward to Global Queue
- Handle response

#### TrialQueueHandleMessageReceived
- Receive incoming message from Global Queue
- Parse content and identify thread
- Update message thread
- Log activity
- Send acknowledgement

#### TrialQueueHandleAcknowledgement
- Receive delivery confirmation
- Update message status to "Sent"
- Record delivery timestamp
- Update activity record

#### TrialQueueHandleError
- Receive error notification
- Parse error details
- Update message status to "Failed"
- Log error activity
- Retry if transient error

**Acceptance Criteria:**
- All operations use critical sections for atomicity
- Service Bus dialogs ensure transactional processing
- Activity created for every operation
- Errors propagated to UI layer

### FR-002: Global Queue Operations

**Requirement:** Global Queue must coordinate routing and enforce system-wide rules.

**Operations:**

#### GlobalQueueHandleMessageRequest
- Dequeue request from Trial Queue
- Check stop list (optional: Contact in Stop List)
- If stopped, send error to Trial Queue
- Validate send-by-date
- If too late, send error to Trial Queue
- Forward to Gateway Queue

#### GlobalQueueHandleMessageReceived
- Receive message from Gateway Queue
- Parse message content
- Identify trial and subject
- Forward to appropriate Trial Queue

#### GlobalQueueHandleAcknowledgement
- Receive delivery confirmation from Gateway
- Record delivery status
- Forward to Trial Queue

#### GlobalQueueHandleAcknowledgeReceived
- Receive read receipt from provider
- Parse acknowledgement
- Forward to Trial Queue to update status to "Received"

#### GlobalQueueHandleError
- Receive error from Gateway Queue
- Classify error (temporary vs permanent)
- If temporary, schedule retry
- If permanent, forward to Trial Queue as "Failed"

#### GlobalQueueHandleSystemMessage
- Generate system messages
- Route to Trial Queue or Gateway based on type

**Acceptance Criteria:**
- Stop list checked before forwarding to Gateway
- Errors classified correctly
- All routing decisions logged
- Service Bus dialogs maintain consistency

### FR-003: Gateway Queue Operations

**Requirement:** Gateway Queue must integrate with external providers.

**Operations:**

#### GatewayReceiveMessage
- Message provider receives message
- Enqueue to Global Central Queue
- Begin dialog
- Send message received request
- End dialog

#### GatewayQueueHandleMessageRequest
- Dequeue message request
- Load Subject, Contact, Template (consider: Subject, Contact, Template)
- Build message using Message Builder
- Choose provider (consider: SMS, Email)
- Call provider API
- If acknowledgement required, enqueue to Global Queue
- Return status

**Acceptance Criteria:**
- Template merge produces correct message
- Provider selection based on contact type
- API errors captured and returned
- Delivery confirmations sent to Global Queue

### FR-004: Stop List Validation

**Requirement:** System must prevent messages to opted-out contacts.

**Implementation:**
- Global Queue checks Global Stop List table
- Lookup by ContactId
- If found, return error to Trial Queue
- Error message: "Contact on stop list"
- Log stop list block attempt

**Override Capability:**
- Emergency messages can override (requires permission)
- Override logged with user and reason
- Stop list entry remains active

**Acceptance Criteria:**
- Stop list checked before Gateway Queue
- Blocked messages never reach provider
- Override requires explicit permission
- All attempts logged

### FR-005: Send-By-Date Validation

**Requirement:** System must prevent delivery of late messages.

**Implementation:**
- Global Queue checks message send-by-date
- Compare current time to scheduled time + send window
- If past window, return error to Trial Queue
- Error message: "Too late to send"

**Configuration:**
- Send window default: 4 hours
- Configurable per trial
- Configurable per message type

**Acceptance Criteria:**
- Late messages transition to "Failed" state
- Reason recorded as "Too Late"
- User notified of failure

### FR-006: Message Provider Integration

**Requirement:** Gateway Queue must integrate with multiple providers.

**Providers:**

#### SMS Providers
- Twilio
- AWS SNS
- Provider selection configurable

#### Email Providers
- SendGrid
- AWS SES
- Provider selection configurable

**Provider Interface:**
```csharp
public interface IMessageProvider
{
    Task<SendResult> SendAsync(MessageRequest request);
    Task<bool> ValidateContactAsync(string contact);
}
```

**Acceptance Criteria:**
- Provider selected based on contact type
- Provider credentials stored securely (Azure Key Vault)
- Provider errors mapped to standard error codes
- Rate limiting enforced per provider

### FR-007: Service Bus Dialogs

**Requirement:** Critical operations must use Service Bus dialogs for transactional processing.

**Dialog Pattern:**
```sql
BEGIN DIALOG CONVERSATION @DialogHandle
    FROM SERVICE [SenderService]
    TO SERVICE 'ReceiverService'
    ON CONTRACT [MessageContract]
    WITH ENCRYPTION = OFF;

SEND ON CONVERSATION @DialogHandle
    MESSAGE TYPE [MessageRequestType]
    (@MessageBody);

WAITFOR (
    RECEIVE TOP(1) @ResponseBody
    FROM [ResponseQueue]
), TIMEOUT 30000;

END CONVERSATION @DialogHandle;
```

**Use Cases:**
- Gateway receiving external messages
- Trial Queue requesting message send
- Acknowledgement handling
- Error responses

**Acceptance Criteria:**
- All critical operations use dialogs
- Timeout configured per operation
- Dialog failures logged and retried
- Orphaned dialogs cleaned up

## Non-Functional Requirements

### NFR-001: Performance

- Queue processing latency < 30 seconds (95th percentile)
- Throughput: 10,000 messages/hour per queue
- Message retention: 14 days
- Dead letter queue retention: 30 days

### NFR-002: Reliability

- At-least-once delivery guarantee
- Duplicate detection (1-hour window)
- Automatic retry with exponential backoff
- Dead letter queue for poison messages

### NFR-003: Scalability

- Auto-scaling based on queue depth
- Partitioned queues for high-volume trials
- Connection pooling for database access
- Caching of frequently accessed data

### NFR-004: Security

- TLS 1.2+ for all queue communications
- Managed identity for Azure Service Bus
- Encryption at rest for queue messages
- No PHI in queue message bodies (only IDs)

## Technical Implementation

### Queue Configuration

#### Trial Queue
```json
{
  "QueueName": "trial-{trialId}-local",
  "MaxDeliveryCount": 5,
  "LockDuration": "00:05:00",
  "DefaultMessageTimeToLive": "14.00:00:00",
  "DuplicateDetectionHistoryTimeWindow": "01:00:00",
  "EnablePartitioning": true,
  "MaxSizeInMegabytes": 5120
}
```

#### Global Queue
```json
{
  "QueueName": "global-central",
  "MaxDeliveryCount": 5,
  "LockDuration": "00:05:00",
  "DefaultMessageTimeToLive": "14.00:00:00",
  "RequiresDuplicateDetection": true,
  "EnablePartitioning": false,
  "MaxSizeInMegabytes": 10240
}
```

#### Gateway Queue
```json
{
  "QueueName": "global-gateway",
  "MaxDeliveryCount": 3,
  "LockDuration": "00:03:00",
  "DefaultMessageTimeToLive": "14.00:00:00",
  "RequiresDuplicateDetection": true,
  "EnablePartitioning": false,
  "MaxSizeInMegabytes": 5120
}
```

### Message Formats

#### Message Request
```json
{
  "MessageThreadId": "guid",
  "TrialId": "guid",
  "SubjectId": "guid",
  "ContactId": "guid",
  "TemplateId": "guid",
  "ContactType": "SMS|Email",
  "ScheduledSendTime": "ISO8601",
  "Priority": "Normal|High|Urgent"
}
```

#### Message Received
```json
{
  "MessageId": "provider-message-id",
  "From": "phone-or-email",
  "To": "system-contact",
  "Body": "message-content",
  "ReceivedTime": "ISO8601",
  "ProviderData": {}
}
```

#### Acknowledgement
```json
{
  "MessageThreadId": "guid",
  "Status": "Sent|Failed",
  "DeliveryTime": "ISO8601",
  "ProviderMessageId": "provider-id",
  "ErrorDetails": "optional-error"
}
```

### Database Schema

#### Global Stop List
```sql
CREATE TABLE GlobalStopList (
    StopListId UNIQUEIDENTIFIER PRIMARY KEY,
    ContactId UNIQUEIDENTIFIER NOT NULL,
    ContactType VARCHAR(10) NOT NULL, -- SMS, Email
    ContactValue VARCHAR(255) NOT NULL,
    OptOutDate DATETIME2 NOT NULL,
    OptOutReason NVARCHAR(500),
    SourceTrialId UNIQUEIDENTIFIER,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedDate DATETIME2 NOT NULL,
    INDEX IX_Contact (ContactId, IsActive),
    INDEX IX_ContactValue (ContactValue, ContactType, IsActive)
);
```

#### Queue Processing Log
```sql
CREATE TABLE QueueProcessingLog (
    LogId UNIQUEIDENTIFIER PRIMARY KEY,
    QueueName VARCHAR(100) NOT NULL,
    MessageId UNIQUEIDENTIFIER NOT NULL,
    Operation VARCHAR(50) NOT NULL,
    Status VARCHAR(20) NOT NULL, -- Processing, Completed, Failed
    StartTime DATETIME2 NOT NULL,
    EndTime DATETIME2,
    DurationMs INT,
    ErrorMessage NVARCHAR(MAX),
    RetryCount INT DEFAULT 0,
    INDEX IX_Message (MessageId),
    INDEX IX_Queue_Status (QueueName, Status, StartTime)
);
```

## Error Handling

### Error Classification

#### Temporary Errors (Retry)
- Network timeout
- Provider temporarily unavailable
- Database deadlock
- Service Bus throttling

#### Permanent Errors (Fail)
- Invalid contact (malformed phone/email)
- Contact on stop list (without override)
- Subject withdrawn from trial
- Template not found
- Too late to send

#### Validation Errors (Reject)
- Missing required fields
- Invalid message format
- Unauthorized user
- Trial not found

### Retry Strategy

| Attempt | Delay | Queue |
|---------|-------|-------|
| 1st | 1 minute | Same queue |
| 2nd | 5 minutes | Same queue |
| 3rd | 15 minutes | Same queue |
| 4th | 1 hour | Same queue |
| 5th+ | Dead letter | Dead letter queue |

### Dead Letter Queue Handling

- Monitor dead letter queues
- Alert on threshold (> 10 messages)
- Manual review and reprocessing
- Root cause analysis
- Permanent storage for compliance

## Monitoring and Observability

### Queue Metrics

- **Queue Depth** - Current message count
- **Incoming Rate** - Messages/second enqueued
- **Processing Rate** - Messages/second dequeued
- **Dead Letter Count** - Messages in dead letter queue
- **Average Processing Time** - Time from enqueue to complete

### Alerts

- Queue depth > 1000 (Warning)
- Queue depth > 5000 (Critical)
- Dead letter count > 10 (Warning)
- Processing rate drops below 50% of incoming rate (Warning)
- Provider API errors > 5% (Critical)

### Distributed Tracing

- Correlation ID propagated across queues
- Span created for each queue operation
- Parent-child relationships maintained
- Integration with Application Insights

### Logging

```csharp
logger.LogInformation(
    "Processing message {MessageId} in {QueueName}. CorrelationId: {CorrelationId}",
    messageId,
    queueName,
    correlationId
);
```

## Testing Strategy

### Unit Tests

- Queue message serialization/deserialization
- Stop list lookup logic
- Send-by-date validation
- Error classification
- Retry logic

### Integration Tests

- End-to-end message flow (all three queues)
- Stop list enforcement
- Provider integration (with test provider)
- Service Bus dialog handling
- Dead letter queue routing

### Load Tests

- 10,000 messages/hour sustained
- Spike to 50,000 messages/hour
- Queue depth recovery after outage
- Provider rate limiting

### Chaos Tests

- Network failures between queues
- Database unavailability
- Provider API failures
- Service Bus throttling

## Configuration

### Application Settings

```json
{
  "Messaging": {
    "Queues": {
      "Trial": {
        "LockDurationSeconds": 300,
        "MaxDeliveryCount": 5,
        "RetryDelays": [60, 300, 900, 3600]
      },
      "Global": {
        "LockDurationSeconds": 300,
        "MaxDeliveryCount": 5,
        "StopListCacheMinutes": 10
      },
      "Gateway": {
        "LockDurationSeconds": 180,
        "MaxDeliveryCount": 3,
        "ProviderTimeoutSeconds": 30
      }
    },
    "Providers": {
      "SMS": {
        "Default": "Twilio",
        "RateLimitPerMinute": 100
      },
      "Email": {
        "Default": "SendGrid",
        "RateLimitPerMinute": 500
      }
    }
  }
}
```

## Security Considerations

### Authentication

- Azure Managed Identity for Service Bus
- No connection strings in code
- Separate queues per trial for isolation

### Authorization

- Queue-level permissions
- Trial-scoped access
- Role-based queue access

### Data Protection

- Message bodies contain only IDs (no PHI)
- Full message content in encrypted database
- TLS for all queue communications

### Audit Trail

- All queue operations logged
- Message routing decisions logged
- Stop list checks logged
- Provider API calls logged

## Dependencies

- Azure Service Bus
- SQL Server with Service Broker
- Messaging Providers (Twilio, SendGrid)
- Azure Key Vault (credentials)
- Application Insights (monitoring)

## Migration Plan

### Phase 1: Infrastructure Setup
- Provision Service Bus namespace
- Create queue configurations
- Configure managed identities
- Deploy monitoring

### Phase 2: Trial Queue Implementation
- Implement message handling
- Deploy to pilot trial
- Monitor and tune

### Phase 3: Global Queue Implementation
- Implement routing logic
- Implement stop list checking
- Deploy to pilot

### Phase 4: Gateway Queue Implementation
- Implement provider integration
- Deploy to pilot
- End-to-end testing

### Phase 5: Production Rollout
- Gradual rollout to all trials
- Monitor performance
- Optimize based on metrics

## Related Documentation

- [Send Message](./send-message.md) - User-initiated messaging
- [State Machine](./state-machine.md) - Message lifecycle
- [Scheduled Messages](./scheduled-messages.md) - Reminder series
- [Stop List](./stop-list.md) - Opt-out management

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
