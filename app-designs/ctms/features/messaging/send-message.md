# Feature Specification: Send Message

## Overview

**Feature Name:** User-Initiated Messaging
**Feature ID:** MSG-001
**Category:** Messaging System
**Priority:** High
**Status:** Active

## Description

Enables site members (trial coordinators, investigators) to send messages to trial subjects through SMS or Email channels. Messages can be sent immediately or scheduled for future delivery.

## Business Context

Clinical trial sites need to communicate with trial subjects for appointment reminders, protocol updates, safety notifications, and general trial information. This feature provides a compliant, auditable messaging system that respects subject preferences and opt-out requests.

## User Roles

- **Site Coordinator** - Primary message sender
- **Principal Investigator** - Authorized to send critical communications
- **Study Nurse** - Sends routine reminders and notifications
- **Trial Manager** - Oversees messaging operations

## Functional Requirements

### FR-001: Message Composition

**Requirement:** Users must be able to compose messages using pre-approved templates.

**Details:**
- Select from trial-approved message templates
- Templates support variable substitution (subject name, appointment time, site contact, etc.)
- Preview merged message before sending
- Character limit based on channel (160 for SMS, unlimited for Email)
- Support for both plain text (SMS) and HTML (Email)

**Acceptance Criteria:**
- Template list filtered by trial and message type
- Variables automatically populated from subject record
- Preview shows exact message as subject will receive
- Warning displayed when SMS exceeds 160 characters

### FR-002: Recipient Selection

**Requirement:** Users must select a valid trial subject and contact method.

**Details:**
- Subject selection from authorized trial list
- Display subject status (Active, Withdrawn, Completed)
- Show available contact methods (SMS, Email)
- Indicate preferred contact method
- Display stop list status

**Acceptance Criteria:**
- Only active subjects shown by default
- Withdrawn subjects require confirmation to message
- Stop list contacts display warning and require override (if permitted)
- Invalid contacts (missing phone/email) disabled

### FR-003: Send Timing Options

**Requirement:** Users must choose immediate or scheduled delivery.

**Details:**
- **Send Now** - Immediate delivery
- **Send Later** - Schedule for future delivery
- Date/time picker for scheduled messages
- Timezone-aware scheduling (user's local time converted to UTC)
- Send window validation (must be within trial operating hours)

**Acceptance Criteria:**
- "Send Now" initiates immediate delivery (transitions to Ready state)
- "Send Later" requires valid future date/time
- Scheduled time stored in UTC
- Warning if scheduled outside typical trial hours

### FR-004: Message States

**Requirement:** System must track message lifecycle through defined states.

**Details:**
Message progression:
1. **Ready** - Prepared for immediate sending (Send Now)
2. **Delayed** - Scheduled for future delivery (Send Later)
3. **Pending** - Queued to messaging provider
4. **Sent** - Successfully delivered
5. **Received** - Recipient confirmed receipt (if supported)
6. **Failed** - Delivery failed
7. **Canceled** - User canceled before delivery

**Acceptance Criteria:**
- State transitions logged with timestamp and user
- Invalid transitions rejected (e.g., cannot cancel sent message)
- Status visible in message history
- Notifications sent on status changes

### FR-005: Stop List Enforcement

**Requirement:** System must prevent messages to opted-out contacts.

**Details:**
- Check Global Stop List before sending
- Block messages to stopped contacts
- Provide override capability for authorized users (emergency communications)
- Log all override attempts with justification

**Acceptance Criteria:**
- Stop list checked at Global Queue
- Stopped contacts return error to Trial Queue
- Error message clearly indicates stop list block
- Override requires specific permission and reason

### FR-006: Activity Tracking

**Requirement:** All message operations must be logged for audit compliance.

**Details:**
Log the following:
- Message creation (user, timestamp, subject, template)
- Send/schedule action
- State transitions
- Delivery confirmations
- Failures with error details
- Cancellations

**Acceptance Criteria:**
- Every action creates activity record
- Activity includes user ID, IP address, timestamp
- Activity viewable in subject communication history
- Audit trail meets 21 CFR Part 11 requirements

## Non-Functional Requirements

### NFR-001: Performance

- Message submission response < 2 seconds
- Queue processing latency < 30 seconds
- Support 1000+ messages per hour per trial

### NFR-002: Security

- Role-based access control (TrialRole attribute)
- Trial-level isolation (users only access their trials)
- Encryption in transit (TLS)
- Encryption at rest (database encryption)
- Audit trail for all operations

### NFR-003: Compliance

- HIPAA compliance for PHI in messages
- 21 CFR Part 11 electronic records
- GDPR right to be forgotten (stop list)
- Audit trail retention per regulatory requirements

### NFR-004: Reliability

- Message delivery guarantee (at-least-once)
- Automatic retry for transient failures
- Dead letter queue for permanent failures
- Transaction consistency across queues

## Technical Architecture

### Queue Flow

```
User → Trial Queue → Global Queue → Gateway Queue → Provider → Subject
  ↓         ↓             ↓              ↓
Thread   Activity    Stop List      Template
                                      Merge
```

### Components

#### Trial Queue (Trial - Local Queue)
- Receives message requests from UI
- Loads Subject, Contact, Template data
- Creates activity records
- Forwards to Global Queue

#### Global Queue (Global - Central Queue)
- Stop list validation
- Send-by-date validation
- Routes to Gateway Queue
- Handles acknowledgements and errors

#### Gateway Queue (Global - Gateway Queue)
- Message Builder - merges template with data
- Provider integration (SMS: Twilio, Email: SendGrid)
- Delivery acknowledgement
- Error handling

### Database Schema

**MessageThread Table:**
```sql
MessageThreadId (PK)
TrialId
SubjectId
ContactId
TemplateId
MessageContent
Status (Delayed, Ready, Pending, Sent, Received, Failed, Canceled)
CreatedBy
CreatedDate
ScheduledSendTime (nullable)
SentTime (nullable)
DeliveredTime (nullable)
FailureReason (nullable)
```

**Activity Table:**
```sql
ActivityId (PK)
TrialId
SubjectId
MessageThreadId (FK, nullable)
Action (enum: MessageCreated, MessageSent, MessageFailed, etc.)
UserId
UserName
IPAddress
Timestamp
BeforeValue (JSON)
AfterValue (JSON)
```

### Service Bus Dialogs

Messages processed using Service Bus transactional dialogs:

```
BEGIN DIALOG
  Send Message Request
  Wait for Acknowledgement
END DIALOG
```

Ensures atomic processing and prevents message loss.

## User Interface

### Message Composition Screen

**Elements:**
- Subject selector (dropdown with search)
- Template selector (filtered by trial/category)
- Message preview panel
- Contact method selector (SMS/Email radio buttons)
- Send timing options (Send Now / Send Later)
- Date/time picker (for Send Later)
- Send button
- Cancel button

**Validation:**
- Subject required
- Template required
- Contact method required
- Scheduled time must be future (for Send Later)

### Message History

**Elements:**
- Table of messages for subject
- Columns: Date/Time, Template, Status, Sent By, Delivery Status
- Filter by status
- Search by content
- Detail view with full message content

## API Specification

### SendMessage Endpoint

**Request:**
```csharp
public class SendMessageRequest
{
    public Guid TrialId { get; set; }
    public Guid SubjectId { get; set; }
    public Guid TemplateId { get; set; }
    public ContactType ContactType { get; set; } // SMS, Email
    public SendOption SendOption { get; set; } // SendNow, SendLater
    public DateTime? ScheduledSendTime { get; set; }
}
```

**Response:**
```csharp
public class SendMessageResponse
{
    public Guid MessageThreadId { get; set; }
    public MessageStatus Status { get; set; }
    public string Message { get; set; }
}
```

**Business Logic:**
1. Validate user has TrialRole for trial
2. Validate subject exists and is active
3. Validate template exists and is approved
4. Validate contact exists and is valid
5. Check stop list (fail if stopped and no override)
6. Create MessageThread record
7. Set state to Ready (Send Now) or Delayed (Send Later)
8. Create activity record
9. If Ready, enqueue to Trial Queue
10. Return MessageThreadId and status

### CancelMessage Endpoint

**Request:**
```csharp
public class CancelMessageRequest
{
    public Guid MessageThreadId { get; set; }
    public string Reason { get; set; }
}
```

**Response:**
```csharp
public class CancelMessageResponse
{
    public bool Success { get; set; }
    public string Message { get; set; }
}
```

**Business Logic:**
1. Validate user has permission
2. Load MessageThread
3. Verify status is Delayed (only delayed messages can be canceled)
4. Update status to Canceled
5. Remove from scheduler
6. Create cancellation activity
7. Return success

## Error Handling

### Client Errors (4xx)

- **400 Bad Request** - Invalid request data
- **401 Unauthorized** - User not authenticated
- **403 Forbidden** - User lacks TrialRole for trial
- **404 Not Found** - Subject/Template not found
- **409 Conflict** - Subject on stop list

### Server Errors (5xx)

- **500 Internal Server Error** - Unexpected error
- **503 Service Unavailable** - Queue or provider unavailable

### Error Messages

**User-Friendly:**
- "This subject has opted out of messages. Override requires manager approval."
- "Message scheduled successfully for [date/time]."
- "Unable to send message. Subject does not have a valid phone number."

**Technical (logged):**
- "Stop list validation failed for ContactId [guid]"
- "Service Bus dialog timeout on queue [name]"
- "Template merge failed: Missing variable [name]"

## Testing Requirements

### Unit Tests

- Template variable substitution
- State transition validation
- Stop list checking logic
- Permission validation (TrialRole)
- Date/time UTC conversion

### Integration Tests

- End-to-end message send (Send Now)
- Scheduled message delivery (Send Later)
- Stop list enforcement at Global Queue
- Retry logic for transient failures
- Activity record creation

### User Acceptance Tests

- Site coordinator sends immediate appointment reminder
- Principal investigator schedules safety notification
- System blocks message to opted-out subject
- User cancels scheduled message
- Message history displays correctly

## Configuration

### Application Settings

```json
{
  "Messaging": {
    "MaxMessagesPerHour": 1000,
    "MaxMessagesPerUser": 100,
    "SMSCharacterLimit": 160,
    "SendWindowHours": 4,
    "DefaultSendHourStart": 8,
    "DefaultSendHourEnd": 20
  }
}
```

### Feature Flags

- `Messaging.Enabled` - Master enable/disable
- `Messaging.AllowStopListOverride` - Permit manager override
- `Messaging.RequireScheduleApproval` - Require approval for scheduled messages

## Security Considerations

### Authorization

**TrialRole Custom Attribute:**
```csharp
[TrialRole("TrialCoordinator")]
public ActionResult SendMessage(SendMessageRequest request)
{
    // User must have TrialCoordinator role for the trial
}
```

**String.IsAuthorized Extension:**
```csharp
if (!"TrialManager".IsAuthorized())
{
    return new HttpUnauthorizedResult();
}
```

### Audit Trail

**UserAuditManager Implementation:**
```csharp
var auditManager = new UserAuditManager();
auditManager.InsertAuditEntry(
    "Messaging.SendMessageController",
    "SendMessage",
    userName,
    ipAddress,
    UserAuditActions.MessageSent,
    UserAuditDetails.Message_Sent_To_Subject
);
```

**Audit Fields:**
- Action - MessageSent, MessageScheduled, MessageCanceled
- User - User ID and username
- Timestamp - UTC timestamp
- IP Address - Client IP address
- Before/After Values - State change details

### Data Protection

- Message content encrypted in database
- PHI (subject name, medical info) limited in messages
- Provider credentials stored in Azure Key Vault
- TLS 1.2+ for all communications

## Compliance Requirements

### 21 CFR Part 11

- Electronic signatures for critical communications
- Audit trail with user/timestamp/action
- System validation documentation
- Change control process

### HIPAA

- Minimum necessary PHI in messages
- Business Associate Agreements with providers
- Breach notification procedures
- Access controls and encryption

### GDPR

- Right to be forgotten (stop list)
- Data minimization in messages
- Consent management
- Data retention policies

## Monitoring and Metrics

### Key Metrics

- **Messages Sent** - Count by channel (SMS, Email)
- **Delivery Success Rate** - Percentage delivered successfully
- **Average Delivery Time** - Queue time to delivery
- **Failed Messages** - Count by reason
- **Stop List Blocks** - Count of blocked attempts

### Alerts

- Delivery success rate < 95%
- Queue depth > 1000 messages
- Provider API errors > 5% of requests
- Stop list override attempts

### Dashboards

- Real-time message status
- Historical trends
- Trial-level statistics
- Provider performance

## Dependencies

### Internal

- User authentication system
- Trial/Subject management
- Template library
- Activity tracking system
- Stop list service

### External

- **SMS Provider** - Twilio, AWS SNS
- **Email Provider** - SendGrid, AWS SES
- **Service Bus** - Azure Service Bus
- **Database** - SQL Server with Service Broker

## Migration and Rollout

### Phase 1 - Pilot (2 weeks)

- Enable for 2 pilot trials
- Monitor performance and errors
- Gather user feedback
- Refine workflows

### Phase 2 - Staged Rollout (4 weeks)

- Enable for 25% of trials
- Monitor scale and performance
- Address issues
- Train additional users

### Phase 3 - Full Rollout (2 weeks)

- Enable for all trials
- Full monitoring and support
- Documentation and training complete

## Support and Training

### User Training

- 30-minute recorded training video
- Quick reference guide
- In-app tooltips and help
- Practice environment

### Administrator Training

- Queue monitoring and troubleshooting
- Stop list management
- Provider configuration
- Audit report generation

## Related Documentation

- [Message Routing](./routing.md) - Queue architecture
- [State Machine](./state-machine.md) - Message lifecycle
- [Scheduled Messages](./scheduled-messages.md) - Reminder series
- [Stop List](./stop-list.md) - Opt-out management
- [Activity Tracking](./activity-tracking.md) - Audit trail

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |

## Approvals

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Product Owner | | | |
| Tech Lead | | | |
| Compliance Officer | | | |
| Security Officer | | | |
