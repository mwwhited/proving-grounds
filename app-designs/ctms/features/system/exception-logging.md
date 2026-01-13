# Feature Specification: Exception Logging (Work Item #579)

## Overview

**Feature Name:** All Exceptions Should Be Logged
**Feature ID:** SYS-004
**Category:** System / Monitoring
**Priority:** High
**Status:** Active

## Description

Comprehensive exception logging system that captures all unhandled exceptions across the application for troubleshooting, debugging, and operational monitoring. Implements structured logging with correlation IDs and integration with monitoring systems.

## Business Context

Production issues require complete exception data for diagnosis. Centralized exception logging enables rapid troubleshooting, trend analysis, and proactive issue detection.

## Functional Requirements

### FR-001: Global Exception Handler

```csharp
public class GlobalExceptionFilter : IExceptionFilter
{
    private readonly ILogger<GlobalExceptionFilter> _logger;
    private readonly IExceptionLogger _exceptionLogger;

    public void OnException(ExceptionContext context)
    {
        var exception = context.Exception;

        // Log to structured logging
        _logger.LogError(exception,
            "Unhandled exception in {Controller}.{Action}",
            context.RouteData.Values["controller"],
            context.RouteData.Values["action"]);

        // Log to database
        _exceptionLogger.LogExceptionAsync(new ExceptionLog
        {
            ExceptionId = Guid.NewGuid(),
            ExceptionType = exception.GetType().FullName,
            Message = exception.Message,
            StackTrace = exception.StackTrace,
            InnerException = exception.InnerException?.ToString(),
            RequestUrl = context.HttpContext.Request.Path,
            HttpMethod = context.HttpContext.Request.Method,
            UserName = context.HttpContext.User?.Identity?.Name,
            IPAddress = context.HttpContext.Connection.RemoteIpAddress?.ToString(),
            Timestamp = DateTime.UtcNow,
            CorrelationId = Activity.Current?.Id,
            Severity = GetSeverity(exception)
        });

        // Return appropriate error response
        context.Result = new ObjectResult(new
        {
            error = "An error occurred processing your request",
            correlationId = Activity.Current?.Id
        })
        {
            StatusCode = 500
        };
    }

    private string GetSeverity(Exception ex)
    {
        return ex switch
        {
            ArgumentException => "Warning",
            InvalidOperationException => "Warning",
            UnauthorizedAccessException => "Warning",
            _ => "Error"
        };
    }
}
```

### FR-002: Exception Database Schema

```sql
CREATE TABLE ExceptionLog (
    ExceptionId UNIQUEIDENTIFIER PRIMARY KEY,
    ExceptionType VARCHAR(500) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    StackTrace NVARCHAR(MAX) NULL,
    InnerException NVARCHAR(MAX) NULL,
    RequestUrl NVARCHAR(1000) NULL,
    HttpMethod VARCHAR(10) NULL,
    UserName VARCHAR(255) NULL,
    IPAddress VARCHAR(45) NULL,
    Timestamp DATETIME2 NOT NULL,
    CorrelationId VARCHAR(100) NULL,
    Severity VARCHAR(20) NOT NULL,
    TrialId UNIQUEIDENTIFIER NULL,
    ServerName VARCHAR(255) NULL,
    ApplicationVersion VARCHAR(50) NULL,
    AdditionalData NVARCHAR(MAX) NULL, -- JSON

    INDEX IX_Timestamp (Timestamp DESC),
    INDEX IX_ExceptionType (ExceptionType, Timestamp DESC),
    INDEX IX_CorrelationId (CorrelationId),
    INDEX IX_Severity (Severity, Timestamp DESC)
);
```

### FR-003: Exception Logging Service

```csharp
public class ExceptionLogger : IExceptionLogger
{
    public async Task LogExceptionAsync(ExceptionLog log)
    {
        log.ServerName = Environment.MachineName;
        log.ApplicationVersion = Assembly.GetExecutingAssembly()
            .GetName().Version.ToString();

        await _db.ExceptionLog.AddAsync(log);
        await _db.SaveChangesAsync();

        // Also send to Application Insights
        _telemetryClient.TrackException(new ExceptionTelemetry
        {
            Exception = new Exception(log.Message),
            SeverityLevel = GetSeverityLevel(log.Severity),
            Timestamp = log.Timestamp
        });

        // Alert on critical exceptions
        if (log.Severity == "Critical")
        {
            await _alertService.SendAlertAsync(
                "Critical Exception",
                $"{log.ExceptionType}: {log.Message}",
                AlertPriority.Critical
            );
        }
    }
}
```

### FR-004: Exception Dashboard

**Metrics:**
- Exception count by type (last 24 hours)
- Exception rate trend
- Top failing endpoints
- Correlation ID search
- Exception details view

## Monitoring and Alerts

### Alerts

- Exception rate > 100/hour (Warning)
- Exception rate > 500/hour (Critical)
- Critical exception logged (Immediate)
- New exception type detected (Info)

## Configuration

```json
{
  "ExceptionLogging": {
    "Enabled": true,
    "LogToDatabase": true,
    "LogToApplicationInsights": true,
    "SendAlertsOnCritical": true,
    "IncludeStackTrace": true,
    "RetentionDays": 90
  }
}
```

## Related Documentation

- [Audit Trail](./audit-trail.md)
- [Email Queue](./email-queue.md)

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
