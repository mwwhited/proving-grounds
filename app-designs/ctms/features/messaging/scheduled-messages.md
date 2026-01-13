# Feature Specification: Scheduled Messages and Reminder Series

## Overview

**Feature Name:** Scheduled Messages and Reminder Series
**Feature ID:** MSG-004
**Category:** Messaging System
**Priority:** High
**Status:** Active

## Description

Enables users to schedule messages for future delivery and create automated reminder series for trial events. Provides a scheduler service that monitors delayed messages, validates send conditions, and triggers delivery at appropriate times. Supports appointment reminders, protocol compliance reminders, and multi-message sequences.

## Business Context

Clinical trials require timely communication with subjects for appointments, protocol adherence, safety follow-ups, and visit reminders. Automated reminder series reduce coordinator workload, improve subject compliance, and ensure consistent communication timing. Scheduled messages allow coordinators to prepare communications in advance and ensure delivery at optimal times.

## User Roles

- **Site Coordinator** - Schedules individual messages and reminder series
- **Principal Investigator** - Approves reminder protocols
- **Trial Manager** - Configures reminder templates and schedules
- **System Administrator** - Monitors scheduler health

## Functional Requirements

### FR-001: Schedule Individual Message

**Requirement:** Users must be able to schedule messages for future delivery.

**Details:**
- Select future date and time for delivery
- Timezone-aware scheduling (user's local time)
- Visual calendar/time picker interface
- Preview scheduled message
- Edit scheduled time before delivery
- Cancel scheduled message

**Send Window:**
- Messages have valid send window (default: 4 hours after scheduled time)
- If window expires, message transitions to Failed state
- Send window configurable per trial

**Acceptance Criteria:**
- Scheduled time stored in UTC
- User sees time in their local timezone
- Warning if scheduling outside trial operating hours
- Confirmation shows scheduled time in user's timezone

### FR-002: Reminder Series Definition

**Requirement:** System must support multi-message reminder sequences.

**Details:**

**Reminder Series Components:**
1. **Anchor Date** - Event date (appointment, visit, procedure)
2. **Reminder Schedule** - Relative timing for each reminder
3. **Message Templates** - Template for each reminder in series
4. **Contact Preference** - SMS, Email, or subject's preference

**Example: Appointment Reminder Series**
- 7 days before: "Your appointment is in one week on [date] at [time]"
- 1 day before: "Reminder: Your appointment is tomorrow at [time]"
- 2 hours before: "Your appointment is in 2 hours at [site]"

**Acceptance Criteria:**
- Series defined with relative timing (days/hours before event)
- Each reminder uses appropriate template
- All reminders scheduled when series created
- Canceling event cancels all pending reminders
- Rescheduling event reschedules all reminders

### FR-003: Scheduler Service

**Requirement:** Background service must monitor and trigger delayed messages.

**Details:**

**Scheduler Operations:**
1. Poll delayed messages every 60 seconds (configurable)
2. Check send conditions for each message
3. Transition to Ready if conditions met
4. Transition to Failed if send window expired
5. Handle retries for transient errors

**Validation Checks:**
- Current time >= ScheduledSendTime
- Current time <= ScheduledSendTime + SendWindow
- Subject still active in trial
- Contact still valid
- Stop list status (not opted out)

**Acceptance Criteria:**
- Scheduler runs continuously as background service
- Messages triggered within 60 seconds of scheduled time
- Failed messages logged with reason
- Scheduler state persisted (survives restarts)

### FR-004: Delayed Message Management

**Requirement:** Users must be able to view and manage scheduled messages.

**Details:**

**Scheduled Message List:**
- View all scheduled messages for trial/subject
- Filter by date range, subject, template
- Sort by scheduled time
- Show status (Scheduled, Sending, Sent, Canceled, Failed)
- Bulk operations (cancel multiple)

**Message Actions:**
- View message details
- Edit scheduled time (if not too close to send time)
- Cancel scheduled message
- Send immediately (convert to Send Now)

**Acceptance Criteria:**
- List shows all Delayed status messages
- Edit locked within 15 minutes of send time
- Cancel available until message enters Pending state
- All actions logged in audit trail

### FR-005: Send Time Validation

**Requirement:** System must validate scheduled send times against business rules.

**Business Rules:**
1. **Trial Operating Hours** - Default 8 AM - 8 PM local time
2. **Minimum Lead Time** - Schedule at least 5 minutes in future
3. **Maximum Lead Time** - Schedule up to 1 year in advance
4. **Weekend/Holiday Rules** - Configurable per trial
5. **Subject Preferences** - Respect preferred contact times

**Validation:**
```csharp
public class SendTimeValidator
{
    public ValidationResult Validate(DateTime scheduledTime, Trial trial, Subject subject)
    {
        // Convert to local time
        var localTime = scheduledTime.ToLocalTime(trial.TimeZone);

        // Check minimum lead time
        if (scheduledTime < DateTime.UtcNow.AddMinutes(5))
            return ValidationResult.Error("Schedule at least 5 minutes in future");

        // Check maximum lead time
        if (scheduledTime > DateTime.UtcNow.AddYears(1))
            return ValidationResult.Error("Cannot schedule more than 1 year ahead");

        // Check trial operating hours
        if (localTime.Hour < trial.OperatingHourStart || localTime.Hour >= trial.OperatingHourEnd)
            return ValidationResult.Warning($"Outside typical hours ({trial.OperatingHourStart}:00 - {trial.OperatingHourEnd}:00)");

        // Check weekend
        if (localTime.DayOfWeek is DayOfWeek.Saturday or DayOfWeek.Sunday)
            if (!trial.AllowWeekenMessages)
                return ValidationResult.Warning("Scheduled for weekend");

        // Check subject preferences
        if (subject.PreferredContactHourStart.HasValue)
            if (localTime.Hour < subject.PreferredContactHourStart || localTime.Hour >= subject.PreferredContactHourEnd)
                return ValidationResult.Warning("Outside subject's preferred hours");

        return ValidationResult.Success();
    }
}
```

**Acceptance Criteria:**
- Validation errors prevent scheduling
- Validation warnings require confirmation
- Business rules configurable per trial

### FR-006: Reminder Series Templates

**Requirement:** Pre-configured reminder series for common trial events.

**Built-in Series:**

#### Appointment Reminder Series
```json
{
  "seriesId": "appointment-standard",
  "name": "Standard Appointment Reminders",
  "reminders": [
    {
      "timing": "7 days before",
      "templateId": "appointment-1week",
      "contactType": "Email"
    },
    {
      "timing": "1 day before",
      "templateId": "appointment-1day",
      "contactType": "SMS"
    },
    {
      "timing": "2 hours before",
      "templateId": "appointment-2hours",
      "contactType": "SMS"
    }
  ]
}
```

#### Medication Reminder Series
```json
{
  "seriesId": "medication-weekly",
  "name": "Weekly Medication Reminder",
  "reminders": [
    {
      "timing": "Every Monday at 9:00 AM",
      "templateId": "medication-reminder",
      "contactType": "SMS",
      "recurring": true,
      "endDate": "trial completion"
    }
  ]
}
```

#### Study Visit Reminder Series
```json
{
  "seriesId": "study-visit-comprehensive",
  "name": "Comprehensive Study Visit Reminders",
  "reminders": [
    {
      "timing": "14 days before",
      "templateId": "visit-preparation",
      "contactType": "Email"
    },
    {
      "timing": "3 days before",
      "templateId": "visit-instructions",
      "contactType": "Email"
    },
    {
      "timing": "1 day before",
      "templateId": "visit-reminder",
      "contactType": "SMS"
    }
  ]
}
```

**Acceptance Criteria:**
- Series templates configurable by trial
- Templates support variable substitution
- Series can be customized per subject
- Default series provided for common events

### FR-007: Recurring Messages

**Requirement:** Support periodic recurring messages (weekly, monthly).

**Use Cases:**
- Weekly medication reminders
- Monthly check-in messages
- Daily diary completion reminders
- Periodic safety check-ins

**Configuration:**
```csharp
public class RecurringMessageConfig
{
    public RecurrencePattern Pattern { get; set; } // Daily, Weekly, Monthly
    public DayOfWeek? DayOfWeek { get; set; } // For weekly
    public int? DayOfMonth { get; set; } // For monthly
    public TimeSpan TimeOfDay { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime? EndDate { get; set; } // Null = until trial end
    public Guid TemplateId { get; set; }
}
```

**Scheduler Behavior:**
- Generate next occurrence after each delivery
- Stop at EndDate or trial completion
- Pause if subject withdraws
- Resume if subject re-enrolled

**Acceptance Criteria:**
- Recurring messages generated automatically
- Stop conditions respected
- Subject status checked before each occurrence
- Audit trail shows series relationship

## Non-Functional Requirements

### NFR-001: Performance

- Scheduler poll interval: 60 seconds
- Process 1000+ delayed messages per poll
- Trigger delivery within 60 seconds of scheduled time
- Support 100,000+ scheduled messages system-wide

### NFR-002: Reliability

- Scheduler survives process restarts
- No missed messages during downtime
- Catch-up processing after outage
- At-most-once delivery per scheduled instance

### NFR-003: Accuracy

- Timezone conversion accuracy
- No drift in recurring message timing
- Precise trigger within ±60 seconds of scheduled time
- Correct handling of DST transitions

### NFR-004: Scalability

- Horizontal scaling of scheduler instances
- Partition by trial for load distribution
- Efficient database queries (indexed)
- Minimize database load

## Technical Architecture

### Scheduler Service

**Implementation:**
```csharp
public class MessageSchedulerService : BackgroundService
{
    private readonly IServiceProvider _serviceProvider;
    private readonly ILogger<MessageSchedulerService> _logger;
    private readonly SchedulerConfig _config;

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _logger.LogInformation("Message Scheduler started");

        while (!stoppingToken.IsCancellationRequested)
        {
            try
            {
                await ProcessDelayedMessagesAsync();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error processing delayed messages");
            }

            await Task.Delay(_config.PollIntervalSeconds * 1000, stoppingToken);
        }

        _logger.LogInformation("Message Scheduler stopped");
    }

    private async Task ProcessDelayedMessagesAsync()
    {
        using var scope = _serviceProvider.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
        var queue = scope.ServiceProvider.GetRequiredService<ITrialQueue>();

        var now = DateTime.UtcNow;
        var sendWindowEnd = now.AddHours(-_config.SendWindowHours);

        var messages = await db.MessageThreads
            .Where(m => m.Status == MessageStatus.Delayed
                     && m.ScheduledSendTime <= now)
            .Take(_config.BatchSize)
            .ToListAsync();

        foreach (var message in messages)
        {
            await ProcessDelayedMessageAsync(message, now, sendWindowEnd, queue);
        }

        _logger.LogInformation(
            "Processed {Count} delayed messages",
            messages.Count
        );
    }

    private async Task ProcessDelayedMessageAsync(
        MessageThread message,
        DateTime now,
        DateTime sendWindowEnd,
        ITrialQueue queue)
    {
        // Check if too late
        if (message.ScheduledSendTime < sendWindowEnd)
        {
            message.Status = MessageStatus.Failed;
            message.FailureReason = "Send window expired";
            message.FailedTime = now;

            _logger.LogWarning(
                "Message {MessageId} send window expired. Scheduled: {Scheduled}, Now: {Now}",
                message.MessageThreadId,
                message.ScheduledSendTime,
                now
            );
        }
        // Check if ready to send
        else if (await ValidateSendConditionsAsync(message))
        {
            message.Status = MessageStatus.Ready;

            await queue.EnqueueAsync(new MessageRequest
            {
                MessageThreadId = message.MessageThreadId
            });

            _logger.LogInformation(
                "Message {MessageId} transitioned to Ready and queued",
                message.MessageThreadId
            );
        }
        // Conditions not met, keep delayed
        else
        {
            message.Status = MessageStatus.Failed;
            message.FailureReason = "Send conditions no longer valid";
            message.FailedTime = now;

            _logger.LogWarning(
                "Message {MessageId} failed validation",
                message.MessageThreadId
            );
        }

        await db.SaveChangesAsync();
    }

    private async Task<bool> ValidateSendConditionsAsync(MessageThread message)
    {
        using var scope = _serviceProvider.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();

        // Check subject status
        var subject = await db.Subjects.FindAsync(message.SubjectId);
        if (subject == null || !subject.IsActive)
            return false;

        // Check contact validity
        var contact = await db.Contacts.FindAsync(message.ContactId);
        if (contact == null || !contact.IsValid)
            return false;

        // Check stop list
        var stopList = scope.ServiceProvider.GetRequiredService<IStopListService>();
        if (await stopList.IsStoppedAsync(message.ContactId))
            return false;

        return true;
    }
}
```

### Database Schema

**ReminderSeries Table:**
```sql
CREATE TABLE ReminderSeries (
    ReminderSeriesId UNIQUEIDENTIFIER PRIMARY KEY,
    TrialId UNIQUEIDENTIFIER NOT NULL,
    SubjectId UNIQUEIDENTIFIER NOT NULL,
    SeriesName VARCHAR(200) NOT NULL,
    AnchorDate DATETIME2 NOT NULL, -- Event date
    AnchorType VARCHAR(50) NOT NULL, -- Appointment, Visit, Procedure
    Status VARCHAR(20) NOT NULL, -- Active, Completed, Canceled
    CreatedBy UNIQUEIDENTIFIER NOT NULL,
    CreatedDate DATETIME2 NOT NULL,
    CanceledDate DATETIME2 NULL,
    CanceledReason NVARCHAR(500) NULL,

    INDEX IX_Subject (SubjectId, Status),
    INDEX IX_Trial (TrialId, AnchorDate)
);
```

**ReminderSeriesItem Table:**
```sql
CREATE TABLE ReminderSeriesItem (
    ReminderSeriesItemId UNIQUEIDENTIFIER PRIMARY KEY,
    ReminderSeriesId UNIQUEIDENTIFIER NOT NULL,
    MessageThreadId UNIQUEIDENTIFIER NULL, -- Created when scheduled
    SequenceNumber INT NOT NULL,
    RelativeTiming VARCHAR(50) NOT NULL, -- "7 days before", "2 hours before"
    TimingOffsetMinutes INT NOT NULL, -- Calculated offset
    TemplateId UNIQUEIDENTIFIER NOT NULL,
    ContactType VARCHAR(10) NOT NULL,
    Status VARCHAR(20) NOT NULL, -- Pending, Scheduled, Sent, Failed, Canceled

    FOREIGN KEY (ReminderSeriesId) REFERENCES ReminderSeries(ReminderSeriesId),
    FOREIGN KEY (MessageThreadId) REFERENCES MessageThread(MessageThreadId),
    INDEX IX_Series (ReminderSeriesId, SequenceNumber)
);
```

**RecurringMessage Table:**
```sql
CREATE TABLE RecurringMessage (
    RecurringMessageId UNIQUEIDENTIFIER PRIMARY KEY,
    TrialId UNIQUEIDENTIFIER NOT NULL,
    SubjectId UNIQUEIDENTIFIER NOT NULL,
    TemplateId UNIQUEIDENTIFIER NOT NULL,
    ContactType VARCHAR(10) NOT NULL,
    RecurrencePattern VARCHAR(20) NOT NULL, -- Daily, Weekly, Monthly
    DayOfWeek INT NULL, -- 0=Sunday, 6=Saturday
    DayOfMonth INT NULL, -- 1-31
    TimeOfDay TIME NOT NULL,
    StartDate DATETIME2 NOT NULL,
    EndDate DATETIME2 NULL,
    Status VARCHAR(20) NOT NULL, -- Active, Paused, Completed, Canceled
    LastOccurrenceDate DATETIME2 NULL,
    NextOccurrenceDate DATETIME2 NULL,

    INDEX IX_NextOccurrence (Status, NextOccurrenceDate),
    INDEX IX_Subject (SubjectId, Status)
);
```

### API Endpoints

#### Schedule Message
```csharp
[HttpPost("schedule")]
[TrialRole("TrialCoordinator")]
public async Task<IActionResult> ScheduleMessage([FromBody] ScheduleMessageRequest request)
{
    var validator = new SendTimeValidator();
    var validationResult = validator.Validate(
        request.ScheduledSendTime,
        await GetTrialAsync(request.TrialId),
        await GetSubjectAsync(request.SubjectId)
    );

    if (validationResult.IsError)
        return BadRequest(validationResult.Message);

    var message = new MessageThread
    {
        MessageThreadId = Guid.NewGuid(),
        TrialId = request.TrialId,
        SubjectId = request.SubjectId,
        ContactId = request.ContactId,
        TemplateId = request.TemplateId,
        Status = MessageStatus.Delayed,
        ScheduledSendTime = request.ScheduledSendTime,
        CreatedBy = CurrentUserId,
        CreatedDate = DateTime.UtcNow
    };

    db.MessageThreads.Add(message);
    await db.SaveChangesAsync();

    return Ok(new { messageThreadId = message.MessageThreadId });
}
```

#### Create Reminder Series
```csharp
[HttpPost("reminder-series")]
[TrialRole("TrialCoordinator")]
public async Task<IActionResult> CreateReminderSeries([FromBody] CreateReminderSeriesRequest request)
{
    var series = new ReminderSeries
    {
        ReminderSeriesId = Guid.NewGuid(),
        TrialId = request.TrialId,
        SubjectId = request.SubjectId,
        SeriesName = request.SeriesName,
        AnchorDate = request.AnchorDate,
        AnchorType = request.AnchorType,
        Status = "Active",
        CreatedBy = CurrentUserId,
        CreatedDate = DateTime.UtcNow
    };

    db.ReminderSeries.Add(series);

    // Create each reminder in series
    foreach (var reminder in request.Reminders)
    {
        var scheduledTime = CalculateScheduledTime(request.AnchorDate, reminder.Timing);

        var messageThread = new MessageThread
        {
            MessageThreadId = Guid.NewGuid(),
            TrialId = request.TrialId,
            SubjectId = request.SubjectId,
            ContactId = request.ContactId,
            TemplateId = reminder.TemplateId,
            Status = MessageStatus.Delayed,
            ScheduledSendTime = scheduledTime,
            CreatedBy = CurrentUserId,
            CreatedDate = DateTime.UtcNow
        };

        db.MessageThreads.Add(messageThread);

        var seriesItem = new ReminderSeriesItem
        {
            ReminderSeriesItemId = Guid.NewGuid(),
            ReminderSeriesId = series.ReminderSeriesId,
            MessageThreadId = messageThread.MessageThreadId,
            SequenceNumber = reminder.SequenceNumber,
            RelativeTiming = reminder.Timing,
            TimingOffsetMinutes = reminder.OffsetMinutes,
            TemplateId = reminder.TemplateId,
            ContactType = reminder.ContactType,
            Status = "Scheduled"
        };

        db.ReminderSeriesItems.Add(seriesItem);
    }

    await db.SaveChangesAsync();

    return Ok(new { reminderSeriesId = series.ReminderSeriesId });
}

private DateTime CalculateScheduledTime(DateTime anchorDate, string timing)
{
    // Parse timing string: "7 days before", "2 hours before", etc.
    var match = Regex.Match(timing, @"(\d+)\s+(days?|hours?|minutes?)\s+before");
    if (!match.Success)
        throw new ArgumentException($"Invalid timing format: {timing}");

    var amount = int.Parse(match.Groups[1].Value);
    var unit = match.Groups[2].Value.ToLower();

    return unit switch
    {
        "day" or "days" => anchorDate.AddDays(-amount),
        "hour" or "hours" => anchorDate.AddHours(-amount),
        "minute" or "minutes" => anchorDate.AddMinutes(-amount),
        _ => throw new ArgumentException($"Unknown time unit: {unit}")
    };
}
```

#### Cancel Reminder Series
```csharp
[HttpPost("reminder-series/{seriesId}/cancel")]
[TrialRole("TrialCoordinator")]
public async Task<IActionResult> CancelReminderSeries(Guid seriesId, [FromBody] CancelReason reason)
{
    var series = await db.ReminderSeries.FindAsync(seriesId);
    if (series == null)
        return NotFound();

    // Cancel all pending messages in series
    var items = await db.ReminderSeriesItems
        .Where(i => i.ReminderSeriesId == seriesId && i.Status == "Scheduled")
        .Include(i => i.MessageThread)
        .ToListAsync();

    foreach (var item in items)
    {
        if (item.MessageThread?.Status == MessageStatus.Delayed)
        {
            item.MessageThread.Status = MessageStatus.Canceled;
            item.MessageThread.CanceledBy = CurrentUserId;
            item.MessageThread.CanceledDate = DateTime.UtcNow;
            item.MessageThread.CancelReason = $"Series canceled: {reason.Reason}";
        }

        item.Status = "Canceled";
    }

    series.Status = "Canceled";
    series.CanceledDate = DateTime.UtcNow;
    series.CanceledReason = reason.Reason;

    await db.SaveChangesAsync();

    return Ok();
}
```

## Error Handling

### Scheduler Errors

**Transient Errors:**
- Database connection timeout
- Temporary service unavailability
- Log and retry next poll cycle

**Permanent Errors:**
- Subject withdrawn (mark Failed)
- Contact invalid (mark Failed)
- Stop list block (mark Failed)
- Send window expired (mark Failed)

**Recovery:**
- Scheduler restart processes all overdue messages
- Catch-up logic handles messages during downtime
- Messages past send window marked Failed

## Monitoring and Metrics

### Scheduler Health

- **Scheduled Messages** - Count of Delayed messages
- **Overdue Messages** - Scheduled time passed but still Delayed
- **Scheduler Lag** - Time between scheduled and actual trigger
- **Failed Validations** - Messages that failed send condition checks

### Alerts

- Scheduler not running (no heartbeat for 5 minutes)
- Overdue messages > 100
- Scheduler lag > 5 minutes
- Failed validation rate > 10%

### Dashboards

- Scheduled messages by trial (24 hours, 7 days, 30 days)
- Reminder series status
- Recurring message health
- Scheduler performance trends

## Testing Requirements

### Unit Tests

- Send time validation logic
- Timing calculation (relative to anchor)
- Timezone conversions
- Recurrence pattern generation

### Integration Tests

- Scheduled message delivery
- Reminder series creation and cancellation
- Recurring message generation
- Scheduler catch-up after downtime

### Load Tests

- 10,000 scheduled messages
- 1,000 reminder series
- Scheduler performance with high load

## Configuration

```json
{
  "Scheduler": {
    "PollIntervalSeconds": 60,
    "BatchSize": 100,
    "SendWindowHours": 4,
    "MaxConcurrentProcessing": 10,
    "EnabledOnStartup": true
  },
  "ReminderSeries": {
    "DefaultAppointmentSeries": "appointment-standard",
    "DefaultVisitSeries": "study-visit-comprehensive",
    "AllowCustomSeries": true
  },
  "SendTimeValidation": {
    "MinimumLeadTimeMinutes": 5,
    "MaximumLeadTimeDays": 365,
    "DefaultOperatingHourStart": 8,
    "DefaultOperatingHourEnd": 20
  }
}
```

## Related Documentation

- [Send Message](./send-message.md) - User-initiated messaging
- [State Machine](./state-machine.md) - Message lifecycle
- [Routing](./routing.md) - Queue architecture
- [Activity Tracking](./activity-tracking.md) - Audit trail

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
