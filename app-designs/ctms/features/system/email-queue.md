# Feature Specification: Async Email Processing Queue

## Overview

**Feature Name:** Async Email Processing (Work Item #578)
**Feature ID:** SYS-003
**Category:** System / Messaging
**Priority:** High
**Status:** Active

## Description

Asynchronous email sending through message queue to prevent email delays from blocking user requests. All system emails (notifications, reports, password resets) are queued and processed by background workers.

## Business Context

Email delivery can be slow or fail, blocking user operations. Queueing emails ensures responsive UI and reliable delivery with retry logic.

## Functional Requirements

### FR-001: Email Queue

**Database Schema:**
```sql
CREATE TABLE EmailQueue (
    EmailQueueId UNIQUEIDENTIFIER PRIMARY KEY,
    ToAddress NVARCHAR(500) NOT NULL,
    FromAddress NVARCHAR(255) NOT NULL,
    Subject NVARCHAR(500) NOT NULL,
    BodyHtml NVARCHAR(MAX) NULL,
    BodyText NVARCHAR(MAX) NULL,
    Priority INT NOT NULL DEFAULT 5,
    Status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    CreatedDate DATETIME2 NOT NULL,
    ProcessedDate DATETIME2 NULL,
    SentDate DATETIME2 NULL,
    FailedDate DATETIME2 NULL,
    RetryCount INT NOT NULL DEFAULT 0,
    ErrorMessage NVARCHAR(MAX) NULL,
    INDEX IX_Status_Priority (Status, Priority, CreatedDate)
);
```

### FR-002: Email Service

```csharp
public class EmailService : IEmailService
{
    public async Task SendAsync(EmailMessage message)
    {
        var queueEntry = new EmailQueue
        {
            EmailQueueId = Guid.NewGuid(),
            ToAddress = message.To,
            FromAddress = message.From ?? _config.DefaultFromAddress,
            Subject = message.Subject,
            BodyHtml = message.BodyHtml,
            BodyText = message.BodyText,
            Priority = message.Priority,
            Status = "Pending",
            CreatedDate = DateTime.UtcNow
        };

        db.EmailQueue.Add(queueEntry);
        await db.SaveChangesAsync();
    }
}
```

### FR-003: Background Processor

```csharp
public class EmailProcessorService : BackgroundService
{
    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            await ProcessPendingEmailsAsync();
            await Task.Delay(TimeSpan.FromSeconds(30), stoppingToken);
        }
    }

    private async Task ProcessPendingEmailsAsync()
    {
        var emails = await db.EmailQueue
            .Where(e => e.Status == "Pending" && e.RetryCount < 5)
            .OrderBy(e => e.Priority)
            .ThenBy(e => e.CreatedDate)
            .Take(100)
            .ToListAsync();

        foreach (var email in emails)
        {
            try
            {
                await SendEmailViaProviderAsync(email);

                email.Status = "Sent";
                email.SentDate = DateTime.UtcNow;
                email.ProcessedDate = DateTime.UtcNow;
            }
            catch (Exception ex)
            {
                email.RetryCount++;
                email.ErrorMessage = ex.Message;

                if (email.RetryCount >= 5)
                {
                    email.Status = "Failed";
                    email.FailedDate = DateTime.UtcNow;
                }

                _logger.LogError(ex, "Failed to send email {EmailId}", email.EmailQueueId);
            }

            await db.SaveChangesAsync();
        }
    }
}
```

## Configuration

```json
{
  "EmailQueue": {
    "ProcessIntervalSeconds": 30,
    "BatchSize": 100,
    "MaxRetries": 5,
    "Provider": "SendGrid",
    "DefaultFromAddress": "noreply@example.com"
  }
}
```

## Related Documentation

- [Message Routing](../messaging/routing.md)
- [Exception Logging](./exception-logging.md)

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
