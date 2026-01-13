# Feature Specification: Role-Based Access Control (RBAC)

## Overview

**Feature Name:** Role-Based Access Control
**Feature ID:** SYS-002
**Category:** System / Security
**Priority:** Critical
**Status:** Active

## Description

Trial-scoped role-based access control system that enforces permissions at the controller action level using custom attributes. Implements multi-tenancy with trial-level isolation, ensuring users can only access data for their assigned trials and roles.

## Business Context

Clinical trials require strict data access controls to maintain subject privacy (HIPAA), data integrity (GxP), and role separation. Users must only access trials and data appropriate to their role and site assignments.

## Functional Requirements

### FR-001: TrialRole Custom Attribute

**Requirement:** Declarative authorization at controller/action level.

**Implementation:**
```csharp
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
public class TrialRoleAttribute : AuthorizeAttribute
{
    private readonly string[] _roles;

    public TrialRoleAttribute(params string[] roles)
    {
        _roles = roles;
    }

    protected override bool AuthorizeCore(HttpContextBase httpContext)
    {
        if (!httpContext.User.Identity.IsAuthenticated)
            return false;

        var trialId = GetTrialIdFromRequest(httpContext);
        if (trialId == null)
            return false;

        // Check if user has any of the specified roles for this trial
        foreach (var role in _roles)
        {
            if (HasTrialRole(httpContext.User.Identity.Name, trialId.Value, role))
                return true;
        }

        return false;
    }

    private Guid? GetTrialIdFromRequest(HttpContextBase httpContext)
    {
        // Try route data
        if (httpContext.Request.RequestContext.RouteData.Values.ContainsKey("trialId"))
            return (Guid?)httpContext.Request.RequestContext.RouteData.Values["trialId"];

        // Try query string
        if (httpContext.Request.QueryString["trialId"] != null)
            return Guid.Parse(httpContext.Request.QueryString["trialId"]);

        // Try form data
        if (httpContext.Request.Form["trialId"] != null)
            return Guid.Parse(httpContext.Request.Form["trialId"]);

        return null;
    }

    private bool HasTrialRole(string userName, Guid trialId, string role)
    {
        using (var db = new ApplicationDbContext())
        {
            return db.TrialUserRoles
                .Any(tur => tur.UserName == userName
                         && tur.TrialId == trialId
                         && tur.RoleName == role
                         && tur.IsActive);
        }
    }
}
```

**Usage:**
```csharp
[TrialRole("TrialCoordinator", "PrincipalInvestigator")]
public class MessagingController : Controller
{
    [TrialRole("PrincipalInvestigator")]
    public ActionResult SendEmergencyMessage(Guid trialId)
    {
        // Only PI can send emergency messages
    }

    [TrialRole("TrialCoordinator", "StudyNurse")]
    public ActionResult SendRoutineMessage(Guid trialId)
    {
        // Coordinators and nurses can send routine messages
    }
}
```

### FR-002: String.IsAuthorized() Extension Method

**Requirement:** Inline authorization checks within methods.

**Implementation:**
```csharp
public static class AuthorizationExtensions
{
    public static bool IsAuthorized(this string roles, Guid? trialId = null)
    {
        if (HttpContext.Current?.User?.Identity?.IsAuthenticated != true)
            return false;

        var userName = HttpContext.Current.User.Identity.Name;
        var roleList = roles.Split(',').Select(r => r.Trim()).ToArray();

        using (var db = new ApplicationDbContext())
        {
            var query = db.TrialUserRoles
                .Where(tur => tur.UserName == userName
                           && roleList.Contains(tur.RoleName)
                           && tur.IsActive);

            if (trialId.HasValue)
                query = query.Where(tur => tur.TrialId == trialId.Value);

            return query.Any();
        }
    }
}
```

**Usage (from CODE_REVIEW.md):**
```csharp
public ActionResult Edit(Guid id)
{
    var currentUser = (Guid)Membership.GetUser().ProviderUserKey;

    // Custom inline authorization check
    if (id != currentUser && !"Administrators".IsAuthorized())
        return new HttpUnauthorizedResult();

    // Allow user to edit their own profile, or admin to edit anyone
}
```

### FR-003: Role Definitions

**Standard Roles:**

| Role | Description | Permissions |
|------|-------------|-------------|
| **SystemAdministrator** | System-wide admin | All trials, all actions |
| **TrialManager** | Trial oversight | All trial data, user management |
| **PrincipalInvestigator** | Clinical lead | Subject enrollment, SAE reporting, emergency messages |
| **TrialCoordinator** | Daily operations | Subject management, messaging, scheduling |
| **StudyNurse** | Clinical support | Messaging, data entry |
| **DataManager** | Data oversight | Data review, export, audit reports |
| **Monitor** | Quality assurance | Read-only access, audit trails |
| **Viewer** | Limited access | Read-only subject data |

### FR-004: Trial User Role Assignments

**Database Schema:**
```sql
CREATE TABLE TrialUserRole (
    TrialUserRoleId UNIQUEIDENTIFIER PRIMARY KEY,
    TrialId UNIQUEIDENTIFIER NOT NULL,
    UserId UNIQUEIDENTIFIER NOT NULL,
    UserName VARCHAR(255) NOT NULL,
    RoleName VARCHAR(100) NOT NULL,
    SiteId UNIQUEIDENTIFIER NULL,
    AssignedBy UNIQUEIDENTIFIER NOT NULL,
    AssignedDate DATETIME2 NOT NULL,
    RevokedBy UNIQUEIDENTIFIER NULL,
    RevokedDate DATETIME2 NULL,
    IsActive BIT NOT NULL DEFAULT 1,

    FOREIGN KEY (TrialId) REFERENCES Trials(TrialId),
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (SiteId) REFERENCES Sites(SiteId),
    INDEX IX_User_Trial (UserId, TrialId, IsActive),
    INDEX IX_Trial_Role (TrialId, RoleName, IsActive),
    UNIQUE (TrialId, UserId, RoleName, SiteId) WHERE IsActive = 1
);
```

### FR-005: Multi-Tenancy (Trial Isolation)

**Requirement:** Users only access data from their assigned trials.

**Implementation:**
```csharp
public class TrialScopedController : Controller
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
        return query.Where(e => authorizedTrials.Contains(e.TrialId));
    }
}

public interface ITrialScoped
{
    Guid TrialId { get; set; }
}
```

**Usage:**
```csharp
public class SubjectController : TrialScopedController
{
    public ActionResult Index()
    {
        var subjects = db.Subjects.AsQueryable();

        // Automatically scope to user's trials
        subjects = ScopeToAuthorizedTrials(subjects);

        return View(subjects.ToList());
    }
}
```

## Database Schema

```sql
-- Role definitions
CREATE TABLE Roles (
    RoleId UNIQUEIDENTIFIER PRIMARY KEY,
    RoleName VARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(500),
    IsSystemRole BIT NOT NULL DEFAULT 0,
    CreatedDate DATETIME2 NOT NULL
);

-- Permissions
CREATE TABLE Permissions (
    PermissionId UNIQUEIDENTIFIER PRIMARY KEY,
    PermissionName VARCHAR(100) NOT NULL UNIQUE,
    Resource VARCHAR(100) NOT NULL,
    Action VARCHAR(50) NOT NULL,
    Description NVARCHAR(500)
);

-- Role-Permission mapping
CREATE TABLE RolePermissions (
    RolePermissionId UNIQUEIDENTIFIER PRIMARY KEY,
    RoleId UNIQUEIDENTIFIER NOT NULL,
    PermissionId UNIQUEIDENTIFIER NOT NULL,
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId),
    FOREIGN KEY (PermissionId) REFERENCES Permissions(PermissionId),
    UNIQUE (RoleId, PermissionId)
);
```

## Security Considerations

### Authorization Levels

1. **Controller Level** - TrialRole attribute on class
2. **Action Level** - TrialRole attribute on method (overrides class)
3. **Inline Level** - String.IsAuthorized() within method
4. **Data Level** - ScopeToAuthorizedTrials on queries

### Audit Trail

All authorization decisions logged:
```csharp
auditManager.InsertAuditEntry(
    controllerName,
    actionName,
    userName,
    ipAddress,
    UserAuditActions.Authorization,
    $"Access {(authorized ? "granted" : "denied")} - Required roles: {roles}"
);
```

## Configuration

```json
{
  "Authorization": {
    "EnableTrialScoping": true,
    "CacheRoleAssignments": true,
    "CacheDurationMinutes": 10,
    "LogAuthorizationDecisions": true
  }
}
```

## Related Documentation

- [Audit Trail](./audit-trail.md)
- [Multi-Tenancy](./multi-tenancy.md)

## Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-13 | Architecture Team | Initial specification |
