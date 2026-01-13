# Feature Specification: Multi-Tenancy (Trial-Level Isolation)

## Overview

**Feature Name:** Multi-Tenancy with Trial-Level Isolation
**Feature ID:** SYS-005
**Category:** System / Architecture
**Priority:** Critical
**Status:** Active

## Description

Trial-scoped data isolation ensuring users can only access data from their assigned trials. Implements row-level security, trial-scoped queries, and tenant isolation for regulatory compliance and data privacy.

## Business Context

Clinical trial data must remain isolated between trials for regulatory compliance, competitive confidentiality, and data integrity. Users should only access trials they are authorized for, with no cross-trial data leakage.

## Functional Requirements

### FR-001: Trial-Scoped Entities

**Requirement:** All major entities include TrialId for scoping.

**Interface:**
```csharp
public interface ITrialScoped
{
    Guid TrialId { get; set; }
}
```

**Implementation:**
```csharp
public class Subject : ITrialScoped
{
    public Guid SubjectId { get; set; }
    public Guid TrialId { get; set; }
    public string SubjectNumber { get; set; }
    // ... other properties
}

public class MessageThread : ITrialScoped
{
    public Guid MessageThreadId { get; set; }
    public Guid TrialId { get; set; }
    public Guid SubjectId { get; set; }
    // ... other properties
}
```

### FR-002: Automatic Trial Scoping

**Requirement:** All queries automatically filtered by user's authorized trials.

**Base Controller:**
```csharp
public abstract class TrialScopedController : Controller
{
    protected Guid[] GetAuthorizedTrialIds()
    {
        var userName = User.Identity.Name;

        using (var db = new ApplicationDbContext())
        {
            return db.TrialUserRoles
                .Where(tur => tur.UserName == userName && tur.IsActive)
                .Select(tur => tur.TrialId)
                .Distinct()
                .ToArray();
        }
    }

    protected IQueryable<T> ScopeToAuthorizedTrials<T>(IQueryable<T> query)
        where T : ITrialScoped
    {
        var authorizedTrials = GetAuthorizedTrialIds();

        if (!authorizedTrials.Any())
            return query.Where(e => false); // No trials = no data

        return query.Where(e => authorizedTrials.Contains(e.TrialId));
    }

    protected async Task<T> FindAsync<T>(Guid id) where T : class, ITrialScoped
    {
        var entity = await db.Set<T>().FindAsync(id);

        if (entity == null)
            return null;

        // Verify user has access to this trial
        var authorizedTrials = GetAuthorizedTrialIds();
        if (!authorizedTrials.Contains(entity.TrialId))
            return null; // Entity exists but user not authorized

        return entity;
    }
}
```

**Usage:**
```csharp
public class SubjectController : TrialScopedController
{
    public async Task<IActionResult> Index()
    {
        var subjects = db.Subjects.AsQueryable();

        // Automatically scope to authorized trials
        subjects = ScopeToAuthorizedTrials(subjects);

        return View(await subjects.ToListAsync());
    }

    public async Task<IActionResult> Details(Guid id)
    {
        // FindAsync includes authorization check
        var subject = await FindAsync<Subject>(id);

        if (subject == null)
            return NotFound(); // Or unauthorized

        return View(subject);
    }
}
```

### FR-003: Database-Level Isolation (Optional)

**Row-Level Security (SQL Server):**
```sql
CREATE FUNCTION dbo.fn_TrialSecurityPredicate(@TrialId UNIQUEIDENTIFIER)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN
    SELECT 1 AS AccessGranted
    WHERE @TrialId IN (
        SELECT TrialId
        FROM dbo.TrialUserRole
        WHERE UserName = USER_NAME()
          AND IsActive = 1
    );
GO

CREATE SECURITY POLICY TrialSecurityPolicy
ADD FILTER PREDICATE dbo.fn_TrialSecurityPredicate(TrialId)
ON dbo.Subject,
ADD FILTER PREDICATE dbo.fn_TrialSecurityPredicate(TrialId)
ON dbo.MessageThread,
ADD FILTER PREDICATE dbo.fn_TrialSecurityPredicate(TrialId)
ON dbo.Activity
WITH (STATE = ON);
```

### FR-004: Cross-Trial Data Prevention

**Validation:**
```csharp
public async Task<IActionResult> Create([FromBody] CreateSubjectRequest request)
{
    // Verify user has access to the trial
    var authorizedTrials = GetAuthorizedTrialIds();

    if (!authorizedTrials.Contains(request.TrialId))
        return Forbid("You do not have access to this trial");

    var subject = new Subject
    {
        TrialId = request.TrialId,
        // ... other properties
    };

    db.Subjects.Add(subject);
    await db.SaveChangesAsync();

    return Ok(subject);
}
```

### FR-005: Trial Context Middleware

**Requirement:** Capture current trial context from request.

```csharp
public class TrialContextMiddleware
{
    public async Task InvokeAsync(HttpContext context, RequestDelegate next)
    {
        Guid? trialId = null;

        // Extract from route
        if (context.Request.RouteValues.ContainsKey("trialId"))
            trialId = (Guid?)context.Request.RouteValues["trialId"];

        // Extract from query
        else if (context.Request.Query.ContainsKey("trialId"))
            trialId = Guid.Parse(context.Request.Query["trialId"]);

        // Extract from claims
        else
        {
            var trialClaim = context.User.Claims
                .FirstOrDefault(c => c.Type == "CurrentTrialId");
            if (trialClaim != null)
                trialId = Guid.Parse(trialClaim.Value);
        }

        if (trialId.HasValue)
        {
            context.Items["CurrentTrialId"] = trialId.Value;
        }

        await next(context);
    }
}
```

### FR-006: Audit Trail by Trial

**Requirement:** All audit entries include TrialId.

```csharp
auditManager.InsertAuditEntry(
    controllerName,
    actionName,
    userName,
    ipAddress,
    action,
    details,
    beforeValue,
    afterValue,
    entityId,
    entity,
    trialId: GetCurrentTrialId() // Always include
);
```

## Database Schema Patterns

**Standard Pattern:**
```sql
CREATE TABLE [Entity] (
    [Entity]Id UNIQUEIDENTIFIER PRIMARY KEY,
    TrialId UNIQUEIDENTIFIER NOT NULL,
    -- ... other fields

    FOREIGN KEY (TrialId) REFERENCES Trials(TrialId),
    INDEX IX_Trial ([Entity]Id, TrialId) -- Include TrialId in indexes
);
```

## Security Considerations

### Authorization Layers

1. **Authentication** - User must be logged in
2. **Trial Assignment** - User must be assigned to trial
3. **Role Check** - User must have appropriate role in trial
4. **Entity Access** - Verify TrialId matches authorized trials

### Data Leakage Prevention

- All list/index endpoints scoped to trials
- All get/details endpoints verify trial access
- All create/update endpoints validate trial access
- Foreign keys enforce trial consistency

## Testing Requirements

### Unit Tests

- Trial scoping query generation
- Authorized trial ID retrieval
- Find with authorization check

### Integration Tests

- User cannot see other trial's data
- Create operation validates trial access
- Update operation prevents cross-trial moves
- Delete operation respects trial scoping

### Security Tests

- Attempt to access unauthorized trial data
- Attempt to create entity in unauthorized trial
- Attempt SQL injection to bypass scoping
- Verify row-level security (if enabled)

## Performance Considerations

### Caching

Cache user's authorized trial IDs (10-minute TTL):
```csharp
var cacheKey = $"authorizedtrials:{userName}";
var authorizedTrials = _cache.GetOrCreate(cacheKey, entry =>
{
    entry.SlidingExpiration = TimeSpan.FromMinutes(10);
    return GetAuthorizedTrialIdsFromDatabase(userName);
});
```

### Indexing

All tables with TrialId include composite indexes:
```sql
CREATE INDEX IX_EntityName_TrialId_Key
ON EntityName (TrialId, [OtherKeyFields])
INCLUDE ([FrequentlyAccessedFields]);
```

## Configuration

```json
{
  "MultiTenancy": {
    "EnforcementLevel": "Application", // Application, Database, Both
    "CacheAuthorizedTrials": true,
    "CacheDurationMinutes": 10,
    "LogCrossTrialAttempts": true,
    "EnableRowLevelSecurity": false
  }
}
```

## Related Documentation

- [RBAC](./rbac.md) - Role-based access control
- [Audit Trail](./audit-trail.md) - Compliance logging

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
