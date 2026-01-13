# Feature Specification: Auto-Reply and Automated Response Handling

## Overview

**Feature Name:** Auto-Reply and Automated Response Handling
**Feature ID:** MSG-006
**Category:** Messaging System
**Priority:** Medium
**Status:** Active

## Description

Automatically processes and responds to inbound messages from trial subjects based on predefined rules and patterns. Handles opt-out/opt-in requests, common questions, acknowledgements, and routing to appropriate trial staff. Reduces coordinator workload while maintaining timely subject communication.

## Business Context

Trial subjects often send common queries, confirmations, or requests that can be addressed with automated responses. Auto-reply capability improves response time, reduces coordinator burden, and ensures consistent messaging while maintaining audit trails and escalation paths for complex inquiries.

## User Roles

- **Trial Coordinator** - Configures auto-reply rules
- **Trial Manager** - Approves auto-reply templates
- **System Administrator** - Manages global auto-reply patterns

## Functional Requirements

### FR-001: Inbound Message Processing

**Requirement:** System must receive and parse incoming messages from subjects.

**Message Sources:**
- SMS replies via Twilio
- Email replies via SendGrid
- Provider webhooks

**Processing Flow:**
```
Provider Webhook → Gateway Queue → Parse Message → Identify Subject →
Match Auto-Reply Rules → Send Response OR Route to Coordinator
```

**Implementation:**
```csharp
public async Task HandleInboundMessage(IncomingMessage message)
{
    // Parse and identify
    var contact = await IdentifyContactAsync(message.From);
    if (contact == null)
    {
        _logger.LogWarning("Received message from unknown contact {From}", message.From);
        return;
    }

    // Create message thread (incoming)
    var thread = new MessageThread
    {
        MessageThreadId = Guid.NewGuid(),
        TrialId = contact.TrialId,
        SubjectId = contact.SubjectId,
        ContactId = contact.ContactId,
        Status = MessageStatus.Received,
        Direction = MessageDirection.Incoming,
        MessageContent = message.Body,
        ReceivedTime = DateTime.UtcNow
    };

    db.MessageThreads.Add(thread);
    await db.SaveChangesAsync();

    // Check auto-reply rules
    var autoReply = await autoReplyService.MatchRulesAsync(message, contact);

    if (autoReply != null)
    {
        await SendAutoReplyAsync(autoReply, contact);
    }
    else
    {
        // Route to coordinator
        await NotifyCoordinatorAsync(contact, message);
    }
}
```

**Acceptance Criteria:**
- All inbound messages logged in MessageThread
- Contact identified by phone/email
- Auto-reply rules evaluated
- Manual routing if no rule match

### FR-002: Opt-Out/Opt-In Detection

**Requirement:** Automatically detect and process opt-out and opt-in requests.

**Opt-Out Keywords:**
- STOP, UNSUBSCRIBE, OPT OUT, QUIT, CANCEL, END

**Opt-In Keywords:**
- START, SUBSCRIBE, OPT IN, YES, RESTART

**Processing:**
```csharp
public async Task<AutoReplyMatch> MatchRulesAsync(IncomingMessage message, Contact contact)
{
    var messageText = message.Body.ToUpper().Trim();

    // Priority 1: Opt-out detection
    if (OptOutKeywords.Any(k => messageText.Contains(k)))
    {
        return new AutoReplyMatch
        {
            RuleType = AutoReplyRuleType.OptOut,
            ResponseTemplate = "opt-out-confirmation",
            Action = AutoReplyAction.AddToStopList
        };
    }

    // Priority 2: Opt-in detection
    if (OptInKeywords.Any(k => messageText.Contains(k)))
    {
        return new AutoReplyMatch
        {
            RuleType = AutoReplyRuleType.OptIn,
            ResponseTemplate = "opt-in-confirmation",
            Action = AutoReplyAction.RemoveFromStopList
        };
    }

    // Additional rules...
    return await MatchCustomRulesAsync(message, contact);
}
```

**Acceptance Criteria:**
- Case-insensitive keyword matching
- Stop list updated immediately
- Confirmation message sent < 60 seconds
- Compliance officer notified (opt-out only)

### FR-003: Common Question Auto-Replies

**Requirement:** Respond to frequently asked questions automatically.

**Common Patterns:**

#### Appointment Confirmation
**Pattern:** "YES", "CONFIRM", "CONFIRMED", "OK"
**Response:** "Thank you for confirming your appointment on [date] at [time]. See you then!"
**Action:** Update appointment status to Confirmed

#### Appointment Rescheduling Request
**Pattern:** "RESCHEDULE", "CHANGE", "CAN'T MAKE IT"
**Response:** "We've received your request to reschedule. A coordinator will contact you within 24 hours."
**Action:** Create task for coordinator, notify staff

#### General Questions
**Pattern:** "HOURS", "LOCATION", "ADDRESS"
**Response:** Template with site information
**Action:** Log inquiry

**Configuration:**
```csharp
public class AutoReplyRule
{
    public Guid RuleId { get; set; }
    public Guid? TrialId { get; set; } // Null = global rule
    public string RuleName { get; set; }
    public AutoReplyRuleType RuleType { get; set; }
    public string[] TriggerKeywords { get; set; }
    public string TriggerPattern { get; set; } // Regex pattern
    public Guid ResponseTemplateId { get; set; }
    public AutoReplyAction Action { get; set; }
    public int Priority { get; set; } // Lower = higher priority
    public bool IsActive { get; set; }
    public bool RequireExactMatch { get; set; }
}

public enum AutoReplyRuleType
{
    OptOut,
    OptIn,
    AppointmentConfirmation,
    RescheduleRequest,
    GeneralInformation,
    Emergency,
    Custom
}

public enum AutoReplyAction
{
    SendResponse,
    AddToStopList,
    RemoveFromStopList,
    UpdateAppointmentStatus,
    CreateCoordinatorTask,
    NotifyStaff,
    EscalateToPI,
    LogOnly
}
```

**Acceptance Criteria:**
- Rules evaluated by priority order
- First match wins
- Response sent automatically
- Action executed (if defined)
- All interactions logged

### FR-004: Emergency Keyword Detection

**Requirement:** Detect and escalate emergency keywords immediately.

**Emergency Keywords:**
- EMERGENCY, URGENT, HELP, ADVERSE, REACTION, SYMPTOMS, HOSPITAL, ER, 911

**Processing:**
```csharp
public async Task<AutoReplyMatch> DetectEmergency(IncomingMessage message)
{
    var messageText = message.Body.ToUpper();

    if (EmergencyKeywords.Any(k => messageText.Contains(k)))
    {
        // Immediate escalation
        await notificationService.SendUrgentNotificationAsync(
            message.TrialId,
            $"URGENT: Potential emergency message from {message.Subject.Name}",
            message.Body,
            NotificationPriority.Critical
        );

        return new AutoReplyMatch
        {
            RuleType = AutoReplyRuleType.Emergency,
            ResponseTemplate = "emergency-response",
            Action = AutoReplyAction.EscalateToPI
        };
    }

    return null;
}
```

**Emergency Response Template:**
"We've received your message. If this is a medical emergency, please call 911 or go to the nearest emergency room immediately. A member of our trial team will contact you shortly. For urgent trial-related questions, call [site emergency number]."

**Acceptance Criteria:**
- Emergency detection highest priority
- PI and on-call coordinator notified immediately (SMS + email)
- Auto-reply sent with emergency instructions
- Message flagged in system
- Follow-up required within 1 hour

### FR-005: Business Hours Routing

**Requirement:** Route messages differently based on business hours.

**During Business Hours:**
- Evaluate auto-reply rules
- If no match, notify on-duty coordinator immediately
- Response expected within 2 hours

**After Business Hours:**
- Send acknowledgement: "Thank you for your message. We will respond within one business day. For emergencies, call [emergency number]."
- Queue for next business day
- Emergency keywords still trigger immediate escalation

**Implementation:**
```csharp
public async Task RouteMessage(IncomingMessage message, Contact contact)
{
    var trial = await db.Trials.FindAsync(contact.TrialId);
    var isBusinessHours = IsBusinessHours(trial);

    var autoReply = await autoReplyService.MatchRulesAsync(message, contact);

    if (autoReply != null)
    {
        await SendAutoReplyAsync(autoReply, contact);
    }
    else if (isBusinessHours)
    {
        await NotifyCoordinatorAsync(contact, message, immediate: true);
    }
    else
    {
        await SendAfterHoursAcknowledgementAsync(contact);
        await QueueForNextBusinessDayAsync(contact, message);
    }
}

private bool IsBusinessHours(Trial trial)
{
    var now = DateTime.UtcNow;
    var localTime = TimeZoneInfo.ConvertTimeFromUtc(now, trial.TimeZone);

    // Check weekend
    if (localTime.DayOfWeek is DayOfWeek.Saturday or DayOfWeek.Sunday)
        return false;

    // Check hours
    return localTime.Hour >= trial.BusinessHourStart
        && localTime.Hour < trial.BusinessHourEnd;
}
```

**Acceptance Criteria:**
- Business hours configurable per trial
- Timezone-aware routing
- After-hours acknowledgement sent < 5 minutes
- Emergency keywords override business hours

### FR-006: Auto-Reply Configuration UI

**Requirement:** Trial managers must be able to configure auto-reply rules.

**UI Features:**
- List of active rules for trial
- Create/edit/delete rules
- Test rule matching
- Enable/disable rules
- Set priority order
- Define response templates

**Rule Editor:**
```typescript
interface AutoReplyRuleForm {
  ruleName: string;
  ruleType: AutoReplyRuleType;
  triggerKeywords: string[];
  triggerPattern?: string; // Regex
  responseTemplateId: string;
  actions: AutoReplyAction[];
  priority: number;
  isActive: boolean;
  requireExactMatch: boolean;
}
```

**Test Function:**
```csharp
[HttpPost("auto-reply/test")]
public async Task<IActionResult> TestRule([FromBody] TestRuleRequest request)
{
    var rule = await db.AutoReplyRules.FindAsync(request.RuleId);
    var testMessage = new IncomingMessage
    {
        Body = request.TestMessageBody
    };

    var match = await autoReplyService.EvaluateRuleAsync(rule, testMessage);

    return Ok(new {
        matched = match != null,
        response = match?.ResponseTemplate,
        actions = match?.Action
    });
}
```

**Acceptance Criteria:**
- Drag-and-drop priority ordering
- Real-time rule testing
- Template preview
- Validation prevents conflicts

### FR-007: Machine Learning Suggestions (Future Enhancement)

**Requirement:** Suggest auto-reply rules based on historical message patterns.

**Analysis:**
- Identify frequently asked questions
- Detect common response patterns
- Suggest new auto-reply rules
- Learn from coordinator responses

**Note:** This is a future enhancement, not required for MVP.

## Non-Functional Requirements

### NFR-001: Performance

- Inbound message processing < 5 seconds
- Auto-reply sent < 30 seconds after receipt
- Rule evaluation < 100ms
- Support 1000+ inbound messages per hour

### NFR-002: Accuracy

- False positive rate < 1% (emergency detection)
- Rule match accuracy > 95%
- No missed opt-out requests
- Correct timezone handling

### NFR-003: Availability

- Webhook endpoint 99.9% uptime
- Retry mechanism for failed responses
- Queue messages during outages
- Graceful degradation

## Technical Implementation

### Webhook Endpoint

**Provider Webhooks:**
```csharp
[HttpPost("webhook/sms/twilio")]
[AllowAnonymous]
public async Task<IActionResult> TwilioWebhook([FromForm] TwilioInboundSMS sms)
{
    // Validate Twilio signature
    if (!twilioService.ValidateSignature(Request))
        return Unauthorized();

    var message = new IncomingMessage
    {
        MessageId = sms.MessageSid,
        From = sms.From,
        To = sms.To,
        Body = sms.Body,
        ReceivedTime = DateTime.UtcNow,
        ContactType = ContactType.SMS,
        ProviderData = JsonSerializer.Serialize(sms)
    };

    await messageProcessor.ProcessInboundAsync(message);

    // Return TwiML response (optional)
    return Content("<Response></Response>", "application/xml");
}

[HttpPost("webhook/email/sendgrid")]
[AllowAnonymous]
public async Task<IActionResult> SendGridWebhook([FromBody] SendGridInboundEmail email)
{
    // Validate SendGrid signature
    if (!sendGridService.ValidateSignature(Request))
        return Unauthorized();

    var message = new IncomingMessage
    {
        MessageId = email.MessageId,
        From = email.From,
        To = email.To,
        Body = email.Text,
        ReceivedTime = DateTime.UtcNow,
        ContactType = ContactType.Email,
        ProviderData = JsonSerializer.Serialize(email)
    };

    await messageProcessor.ProcessInboundAsync(message);

    return Ok();
}
```

### Auto-Reply Engine

```csharp
public class AutoReplyService : IAutoReplyService
{
    public async Task<AutoReplyMatch> MatchRulesAsync(IncomingMessage message, Contact contact)
    {
        // Get rules for trial (and global rules)
        var rules = await db.AutoReplyRules
            .Where(r => r.IsActive && (r.TrialId == null || r.TrialId == contact.TrialId))
            .OrderBy(r => r.Priority)
            .ToListAsync();

        foreach (var rule in rules)
        {
            if (await EvaluateRuleAsync(rule, message))
            {
                return new AutoReplyMatch
                {
                    Rule = rule,
                    RuleType = rule.RuleType,
                    ResponseTemplate = rule.ResponseTemplateId,
                    Action = rule.Action
                };
            }
        }

        return null;
    }

    private async Task<bool> EvaluateRuleAsync(AutoReplyRule rule, IncomingMessage message)
    {
        var messageText = message.Body.Trim();

        if (rule.RequireExactMatch)
        {
            return rule.TriggerKeywords.Any(k =>
                messageText.Equals(k, StringComparison.OrdinalIgnoreCase));
        }

        // Keyword match
        if (rule.TriggerKeywords?.Any() == true)
        {
            if (rule.TriggerKeywords.Any(k =>
                messageText.Contains(k, StringComparison.OrdinalIgnoreCase)))
                return true;
        }

        // Regex pattern match
        if (!string.IsNullOrEmpty(rule.TriggerPattern))
        {
            var regex = new Regex(rule.TriggerPattern, RegexOptions.IgnoreCase);
            if (regex.IsMatch(messageText))
                return true;
        }

        return false;
    }
}
```

### Database Schema

```sql
CREATE TABLE AutoReplyRule (
    RuleId UNIQUEIDENTIFIER PRIMARY KEY,
    TrialId UNIQUEIDENTIFIER NULL, -- Null = global
    RuleName VARCHAR(200) NOT NULL,
    RuleType VARCHAR(50) NOT NULL,
    TriggerKeywords NVARCHAR(MAX) NULL, -- JSON array
    TriggerPattern NVARCHAR(500) NULL, -- Regex
    ResponseTemplateId UNIQUEIDENTIFIER NOT NULL,
    Action VARCHAR(50) NOT NULL,
    Priority INT NOT NULL DEFAULT 100,
    IsActive BIT NOT NULL DEFAULT 1,
    RequireExactMatch BIT NOT NULL DEFAULT 0,
    CreatedBy UNIQUEIDENTIFIER NOT NULL,
    CreatedDate DATETIME2 NOT NULL,
    ModifiedBy UNIQUEIDENTIFIER NULL,
    ModifiedDate DATETIME2 NULL,

    INDEX IX_Trial_Priority (TrialId, Priority, IsActive),
    FOREIGN KEY (ResponseTemplateId) REFERENCES MessageTemplate(TemplateId)
);

CREATE TABLE InboundMessage (
    InboundMessageId UNIQUEIDENTIFIER PRIMARY KEY,
    MessageThreadId UNIQUEIDENTIFIER NOT NULL,
    ProviderMessageId VARCHAR(100) NOT NULL,
    ContactId UNIQUEIDENTIFIER NOT NULL,
    MessageBody NVARCHAR(MAX) NOT NULL,
    ReceivedDate DATETIME2 NOT NULL,
    ProcessedDate DATETIME2 NULL,
    AutoReplyRuleId UNIQUEIDENTIFIER NULL,
    AutoReplySent BIT NOT NULL DEFAULT 0,
    ManualReplyRequired BIT NOT NULL DEFAULT 0,
    ProviderData NVARCHAR(MAX) NULL, -- JSON

    FOREIGN KEY (MessageThreadId) REFERENCES MessageThread(MessageThreadId),
    FOREIGN KEY (AutoReplyRuleId) REFERENCES AutoReplyRule(RuleId),
    INDEX IX_Contact (ContactId, ReceivedDate),
    INDEX IX_Processed (ProcessedDate, ManualReplyRequired)
);
```

## Monitoring and Metrics

### Metrics

- **Inbound Messages** - Count per hour/day
- **Auto-Reply Rate** - % messages with auto-reply
- **Manual Routing Rate** - % requiring coordinator
- **Emergency Detections** - Count and response time
- **Rule Match Distribution** - Which rules match most

### Alerts

- Emergency keyword detected
- After-hours message requiring attention
- Auto-reply send failure
- Webhook endpoint down
- High manual routing rate (> 50%)

## Testing Requirements

### Unit Tests

- Keyword matching logic
- Regex pattern evaluation
- Priority ordering
- Timezone calculations

### Integration Tests

- End-to-end inbound message flow
- Auto-reply delivery
- Stop list integration
- Emergency escalation

### Load Tests

- 1000 inbound messages per hour
- Concurrent webhook processing
- Rule evaluation performance

## Configuration

```json
{
  "AutoReply": {
    "Enabled": true,
    "OptOutKeywords": ["STOP", "UNSUBSCRIBE", "OPT OUT", "QUIT", "CANCEL", "END"],
    "OptInKeywords": ["START", "SUBSCRIBE", "OPT IN", "YES", "RESTART"],
    "EmergencyKeywords": ["EMERGENCY", "URGENT", "HELP", "ADVERSE", "REACTION"],
    "SendAfterHoursAcknowledgement": true,
    "MaxAutoReplyPerContact": 5, // Per day
    "ResponseDelaySeconds": 2 // Humanize timing
  },
  "Webhooks": {
    "Twilio": {
      "ValidateSignature": true,
      "TimeoutSeconds": 30
    },
    "SendGrid": {
      "ValidateSignature": true,
      "TimeoutSeconds": 30
    }
  }
}
```

## Related Documentation

- [Send Message](./send-message.md) - Outbound messaging
- [Stop List](./stop-list.md) - Opt-out processing
- [Activity Tracking](./activity-tracking.md) - Audit trail

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
