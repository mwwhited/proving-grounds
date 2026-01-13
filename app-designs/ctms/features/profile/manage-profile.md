# Feature Specification: Manage Profile

**Work Item**: #573
**Feature Area**: Profile Management
**User Role**: Gateway User
**Priority**: High
**Status**: Active

---

## Overview

The Manage Profile feature enables authenticated users to maintain their personal profile information including contact details, name, and security questions. This feature implements mandatory profile enforcement to ensure all users have complete profiles before accessing the system.

### Business Context

User profiles are critical for:
- Contact information for notifications and communications
- Security question setup for password recovery
- Regulatory compliance and audit trail requirements
- User identification in clinical trial workflows

---

## User Stories

### Primary User Story

**As a** Gateway User
**I want to** manage my profile information
**So that** the system has current contact details and I can recover my account if needed

### Secondary User Stories

**As a** System Administrator
**I want to** ensure all users have complete profiles
**So that** we can reliably communicate with users and meet compliance requirements

**As a** Gateway User
**I want to** be prompted to complete my profile on first login
**So that** I don't forget to provide required information

---

## Functional Requirements

### FR-1: Profile Information Management

**Description**: Users must be able to view and edit their profile information.

**Profile Fields** (All Required):

| Field Name | Type | Validation | Max Length | Description |
|------------|------|------------|------------|-------------|
| First Name | Text | Required, not whitespace | 100 | User's first name |
| Last Name | Text | Required, not whitespace | 100 | User's last name |
| Email Address | Email | Required, valid email format | 255 | Primary email for notifications |
| Primary Phone | Phone | Required, not whitespace | 20 | Primary contact phone number |
| Security Question 1 | Text | Required | 500 | First security question |
| Security Answer 1 | Text | Required, not whitespace | 200 | Answer to first security question |
| Security Question 2 | Text | Optional | 500 | Second security question |
| Security Answer 2 | Text | Optional | 200 | Answer to second security question |

**Business Rules**:
- Email address must be unique across all users
- Phone number should accept various formats (will be normalized)
- Security answers are case-insensitive during recovery
- Security answers must be stored encrypted/hashed
- At least one security question is required
- If Security Question 2 is provided, Security Answer 2 is required

### FR-2: Profile Enforcement on Login

**Description**: System automatically redirects users without complete profiles to the profile edit page.

**Pattern**: "Prompt on Login if not exist"

**Behavior**:
1. User successfully authenticates (login)
2. System checks if profile exists for user
3. If profile is incomplete or missing:
   - System redirects to `/MyInfo/Edit/{userId}`
   - Original destination URL preserved in `ReturnUrl` parameter
   - User cannot access other system features until profile is complete
4. If profile exists:
   - User proceeds to original destination

**Whitelist** (Routes that bypass enforcement):
- `/MyInfo/*` - Profile management routes
- `/Shared/PortalHeaderLinks` - Layout components
- `/Account/Logout` - Allow logout without profile

**Technical Implementation**:
- Implemented via `MyInfoController.MyInfoCheck()` interceptor
- Executes at routing level before controller instantiation
- See: `/current/src/CORE/Gateway/OoBDev.Web.Controllers/MyInfoController.cs:90-128`

### FR-3: Profile Viewing

**Description**: Users can view their current profile information.

**URL**: `/MyInfo/Index`

**Display**:
- Read-only view of all profile fields
- Edit button to navigate to edit mode
- Audit log link (if authorized)
- Last modified timestamp (if available)

### FR-4: Profile Editing

**Description**: Users can update their profile information.

**URL**: `/MyInfo/Edit/{userId}`

**Form Behavior**:
- Pre-populated with existing values (if profile exists)
- Empty form for new profiles
- Client-side validation for required fields
- Server-side validation with error messages
- Save button to submit changes
- Cancel button to return without saving

**Validation**:
- Required field validation
- Email format validation
- Duplicate email detection
- Phone number format validation (flexible)
- Security answer minimum length (if implemented)

**Success**:
- Profile saved to database
- Audit log entry created
- User redirected to ReturnUrl (if provided) or profile detail view
- Success message displayed

**Errors**:
- Validation errors displayed inline
- Form remains populated with user input
- Specific error messages for each validation failure

### FR-5: Authorization

**Description**: Control who can view and edit profiles.

**Rules**:

| Action | Current User | Administrator | Other Users |
|--------|--------------|---------------|-------------|
| View Own Profile | ✅ Allowed | ✅ Allowed | ❌ Denied |
| Edit Own Profile | ✅ Allowed | ✅ Allowed | ❌ Denied |
| View Other Profiles | ❌ Denied | ✅ Allowed | ❌ Denied |
| Edit Other Profiles | ❌ Denied | ✅ Allowed | ❌ Denied |
| List All Profiles | ❌ Denied | ✅ Allowed | ❌ Denied |

**Implementation**:
```csharp
// Check if user is editing their own profile or is administrator
if (id != currentUser && !"Administrators".IsAuthorized())
    return new HttpUnauthorizedResult();
```

### FR-6: Profile List (Administrators Only)

**Description**: Administrators can view list of all user profiles.

**URL**: `/MyInfo/List`

**Authorization**: `[TrialRole("Administrators")]`

**Display**:
- Searchable/filterable table of all profiles
- Columns: Name, Email, Phone, Last Updated
- Links to view/edit individual profiles
- Indicators for incomplete profiles

---

## Non-Functional Requirements

### NFR-1: Performance

- Profile lookup must complete within 500ms
- Profile save must complete within 1 second
- Profile enforcement check must add <100ms to page load

### NFR-2: Security

- All profile data transmitted over HTTPS
- Security answers must be stored hashed (not plain text)
- Email addresses must be validated and sanitized
- Protection against XSS in all text fields
- CSRF protection on all POST operations

### NFR-3: Compliance (21 CFR Part 11)

**Audit Trail Requirements**:
- Log all profile view operations
- Log all profile create/update operations
- Capture: User ID, timestamp, IP address, fields changed
- Store before/after values for modified fields
- Audit logs must be tamper-proof

**Data Integrity**:
- Validation at all layers (client, server, database)
- Referential integrity enforced in database
- Transaction support for profile updates

### NFR-4: Usability

- Form must be accessible (WCAG 2.1 AA)
- Clear error messages with resolution instructions
- Tab order follows logical field sequence
- Mobile-responsive design
- Support for browser autofill

### NFR-5: Availability

- Profile service must be available 99.9% of time
- Graceful degradation if profile service unavailable
- Clear error message if profile cannot be loaded

---

## User Interface

### Profile Detail View

```
┌─────────────────────────────────────────────────────────┐
│ My Profile                                    [Edit]    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Name:              John Doe                             │
│ Email:             john.doe@example.com                 │
│ Phone:             (555) 123-4567                       │
│                                                         │
│ Security Questions:                                     │
│   Question 1:      What is your mother's maiden name?   │
│   Question 2:      What city were you born in?          │
│                                                         │
│ Last Updated:      2026-01-10 14:30:00                  │
│                                                         │
│                                        [View Audit Log] │
└─────────────────────────────────────────────────────────┘
```

### Profile Edit Form

```
┌─────────────────────────────────────────────────────────┐
│ Edit Profile                                            │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Personal Information                                    │
│                                                         │
│ First Name: * [____________________]                    │
│                                                         │
│ Last Name:  * [____________________]                    │
│                                                         │
│ Contact Information                                     │
│                                                         │
│ Email:      * [____________________]                    │
│                 (Used for notifications)                │
│                                                         │
│ Phone:      * [____________________]                    │
│                 (Primary contact number)                │
│                                                         │
│ Security Questions (for password recovery)              │
│                                                         │
│ Question 1: * [▼ Select a question ▼▼▼▼▼▼▼]            │
│ Answer 1:   * [____________________]                    │
│                                                         │
│ Question 2:   [▼ Select a question ▼▼▼▼▼▼▼]            │
│ Answer 2:     [____________________]                    │
│                                                         │
│                                                         │
│                              [Cancel]  [Save Profile]   │
└─────────────────────────────────────────────────────────┘

* Required field
```

### Security Question Dropdown Options

1. What is your mother's maiden name?
2. What city were you born in?
3. What is the name of your first pet?
4. What is your favorite color?
5. What is the name of the street you grew up on?
6. What is your father's middle name?
7. What was the make of your first car?
8. What is your favorite food?

---

## API Endpoints

### GET /MyInfo/Index
**Description**: View current user's profile
**Authorization**: Authenticated user
**Returns**: Profile detail view

### GET /MyInfo/Edit/{userId}
**Description**: Display profile edit form
**Authorization**: Own profile or Administrator
**Parameters**:
- `userId` (Guid): User ID to edit
- `ReturnUrl` (string, optional): URL to redirect after save

**Returns**: Profile edit form

### POST /MyInfo/Edit
**Description**: Save profile changes
**Authorization**: Own profile or Administrator
**Request Body**: MyInfoModel
```json
{
  "MyInfoID": -1,
  "AspNetID": "guid",
  "FirstName": "string",
  "LastName": "string",
  "EmailAddress": "string",
  "PrimaryPhone": "string",
  "SecurityQuestion1": "string",
  "SecurityAnswer1": "string",
  "SecurityQuestion2": "string",
  "SecurityAnswer2": "string"
}
```
**Returns**: Redirect to ReturnUrl or profile detail view

### GET /MyInfo/List
**Description**: List all user profiles (Admin only)
**Authorization**: Administrators
**Returns**: Table view of all profiles

### GET /MyInfo/Audit/{userId}
**Description**: View audit log for user profile
**Authorization**: Own profile or Administrator
**Parameters**:
- `userId` (Guid): User ID

**Returns**: Audit log view

---

## Data Model

### MyInfo Table

```sql
CREATE TABLE MyInfo (
    MyInfoID        INT IDENTITY(1,1) PRIMARY KEY,
    AspNetID        UNIQUEIDENTIFIER NOT NULL,
    FirstName       NVARCHAR(100) NOT NULL,
    LastName        NVARCHAR(100) NOT NULL,
    EmailAddress    NVARCHAR(255) NOT NULL,
    PrimaryPhone    NVARCHAR(20) NOT NULL,
    SecurityQuestion1 NVARCHAR(500) NOT NULL,
    SecurityAnswer1Hash NVARCHAR(500) NOT NULL,
    SecurityQuestion2 NVARCHAR(500) NULL,
    SecurityAnswer2Hash NVARCHAR(500) NULL,
    CreatedDate     DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedDate    DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    CreatedBy       UNIQUEIDENTIFIER NOT NULL,
    ModifiedBy      UNIQUEIDENTIFIER NOT NULL,

    CONSTRAINT FK_MyInfo_AspNetUsers
        FOREIGN KEY (AspNetID) REFERENCES AspNetUsers(UserId),
    CONSTRAINT UQ_MyInfo_AspNetID
        UNIQUE (AspNetID),
    CONSTRAINT UQ_MyInfo_Email
        UNIQUE (EmailAddress)
)
```

### Indexes

```sql
CREATE INDEX IX_MyInfo_AspNetID ON MyInfo(AspNetID)
CREATE INDEX IX_MyInfo_Email ON MyInfo(EmailAddress)
```

---

## Business Rules

### BR-1: Profile Completeness
A profile is considered complete when:
- All required fields have non-whitespace values
- Email address is in valid format
- At least one security question/answer pair is provided

### BR-2: Email Uniqueness
- Email addresses must be unique across all users
- Case-insensitive comparison
- Validation occurs on save

### BR-3: Security Answers
- Security answers are case-insensitive during recovery
- Security answers must be hashed using secure algorithm
- Minimum answer length: 3 characters (configurable)

### BR-4: Profile Enforcement Timing
- Enforcement occurs immediately after successful login
- Enforcement bypassed for whitelisted routes
- ReturnUrl preserved through enforcement redirect

### BR-5: Concurrent Updates
- Last write wins (no optimistic concurrency)
- ModifiedDate updated on every save
- Audit trail captures all changes

---

## User Workflows

### Workflow 1: First-Time User Login (Profile Required)

```
[User] → Login → [System]
                   ↓
         Check profile exists?
                   ↓
              [No] Profile missing
                   ↓
         Redirect: /MyInfo/Edit/{userId}?ReturnUrl=/Dashboard
                   ↓
         [User] Fills out profile form
                   ↓
         [User] Clicks "Save Profile"
                   ↓
         [System] Validates data
                   ↓
         [System] Saves profile
                   ↓
         [System] Creates audit log entry
                   ↓
         Redirect: /Dashboard (from ReturnUrl)
                   ↓
         [User] Accesses requested page
```

### Workflow 2: Existing User Updates Profile

```
[User] → Navigate to My Profile
           ↓
       [System] Shows profile detail view
           ↓
       [User] Clicks "Edit"
           ↓
       [System] Shows edit form with current values
           ↓
       [User] Updates fields
           ↓
       [User] Clicks "Save Profile"
           ↓
       [System] Validates changes
           ↓
       [System] Saves changes
           ↓
       [System] Logs changes to audit trail
           ↓
       [System] Shows profile detail view
           ↓
       Success message displayed
```

### Workflow 3: Administrator Edits User Profile

```
[Admin] → Navigate to /MyInfo/List
            ↓
        [System] Shows all user profiles
            ↓
        [Admin] Searches for user
            ↓
        [Admin] Clicks "Edit" on user row
            ↓
        [System] Shows edit form for selected user
            ↓
        [Admin] Updates fields
            ↓
        [Admin] Clicks "Save Profile"
            ↓
        [System] Validates changes
            ↓
        [System] Saves changes
            ↓
        [System] Logs changes (including admin identity)
            ↓
        Success message displayed
```

---

## Error Handling

### Validation Errors

| Error Condition | Error Message | Action |
|----------------|---------------|--------|
| First Name empty | "First Name is required" | Highlight field, display message |
| Last Name empty | "Last Name is required" | Highlight field, display message |
| Email empty | "Email Address is required" | Highlight field, display message |
| Email invalid format | "Please enter a valid email address" | Highlight field, display message |
| Email already exists | "This email address is already in use" | Highlight field, display message |
| Phone empty | "Primary Phone is required" | Highlight field, display message |
| Security Q1 empty | "Security Question 1 is required" | Highlight field, display message |
| Security A1 empty | "Security Answer 1 is required" | Highlight field, display message |
| Q2 provided, A2 empty | "Answer is required when question is provided" | Highlight field, display message |

### System Errors

| Error Condition | User Message | Technical Action |
|----------------|--------------|------------------|
| Database unavailable | "Unable to save profile. Please try again." | Log error, alert operations |
| User not found | "User not found" | Return 404 |
| Unauthorized access | "You are not authorized to access this page" | Return 401 |
| Concurrent update | "Profile was modified by another user. Please refresh." | Show current data |

---

## Security Considerations

### Authentication
- All endpoints require `[Authorize]` attribute
- Profile enforcement occurs post-authentication

### Authorization
- Users can only edit their own profile
- Administrators can edit any profile
- Authorization checked in controller and service layer

### Data Protection
- Security answers must be hashed (bcrypt or PBKDF2)
- Email addresses sanitized to prevent XSS
- Phone numbers sanitized to prevent injection

### Audit Trail
- All profile access logged
- All profile modifications logged
- IP address captured for all operations
- User identity captured (even for admin edits)

### Privacy
- Profile data not exposed in URLs (except user ID)
- Email addresses not displayed in lists (admin view only)
- Security questions visible, answers never displayed

---

## Testing Requirements

### Unit Tests
- Profile validation logic
- Authorization checks (own vs. other profiles)
- Email uniqueness validation
- Security answer hashing
- Profile enforcement logic

### Integration Tests
- Profile create workflow
- Profile update workflow
- Profile enforcement redirect
- Administrator edit workflow
- Email uniqueness across database

### UI Tests
- Form validation (client and server)
- Required field enforcement
- Error message display
- Success message display
- Navigation flows

### Security Tests
- Unauthorized access attempts
- XSS injection attempts
- SQL injection attempts
- CSRF protection validation
- Security answer hash verification

---

## Acceptance Criteria

### AC-1: Profile Creation
- ✅ New user can create profile on first login
- ✅ All required fields enforced
- ✅ Email uniqueness validated
- ✅ Security questions/answers saved encrypted
- ✅ Audit log entry created

### AC-2: Profile Enforcement
- ✅ User without profile redirected to profile edit
- ✅ ReturnUrl preserved through redirect
- ✅ User can access system after profile complete
- ✅ Whitelisted routes bypass enforcement

### AC-3: Profile Viewing
- ✅ User can view their own profile
- ✅ Administrator can view any profile
- ✅ Security answers not displayed
- ✅ Last modified date displayed

### AC-4: Profile Editing
- ✅ User can edit their own profile
- ✅ Administrator can edit any profile
- ✅ Validation errors displayed clearly
- ✅ Success message displayed on save
- ✅ Changes reflected immediately

### AC-5: Authorization
- ✅ Unauthorized users cannot access other profiles
- ✅ Unauthorized access returns 401
- ✅ Administrator role grants full access
- ✅ Profile list restricted to administrators

### AC-6: Audit Trail
- ✅ All profile operations logged
- ✅ User identity captured
- ✅ IP address captured
- ✅ Timestamp captured
- ✅ Before/after values logged

---

## Dependencies

### Internal Dependencies
- ASP.NET Membership Provider (authentication)
- Authorization system (role checking)
- Audit logging system
- Email validation service

### External Dependencies
- Database (SQL Server)
- SMTP server (for email validation, if implemented)

---

## Migration Considerations

### Data Migration
If migrating from legacy system:
1. Map legacy user fields to MyInfo table
2. Generate default security questions if not available
3. Prompt users to update security answers on next login
4. Migrate audit history if available

### Version Compatibility
- Profile enforcement introduced: Version 1.0
- Security questions required: Version 1.0
- Email uniqueness enforced: Version 1.0

---

## Performance Considerations

### Database Optimization
- Index on AspNetID for fast profile lookup
- Index on EmailAddress for uniqueness checks
- Consider caching profile data in session

### Profile Enforcement
- Efficient EXISTS query for profile check
- Minimize database calls in routing pipeline
- Consider caching profile existence flag

### Scalability
- Profile service stateless (supports horizontal scaling)
- Database supports connection pooling
- Consider read replicas for profile lookups

---

## Monitoring and Metrics

### Key Metrics
- Profile completion rate (new users)
- Time to complete profile (avg, p95)
- Profile update frequency
- Failed validation attempts
- Unauthorized access attempts

### Alerts
- Profile service availability < 99.9%
- Profile save latency > 2 seconds
- Spike in unauthorized access attempts
- Email uniqueness violation rate > 1%

### Logging
- Log all profile access (INFO level)
- Log all profile modifications (INFO level)
- Log validation failures (WARN level)
- Log authorization failures (WARN level)
- Log system errors (ERROR level)

---

## Related Features

- [Change Password](./change-password.md) - Work Item #569
- [Password Recovery](./password-recovery.md) - Work Item #574 (uses security questions)
- [Self Registration](./self-registration.md) - Work Item #577
- [Account Verification](./account-verification.md) - Email/phone verification

---

## References

### Architecture Documentation
- [Gateway Use Cases](/current/src/docs/architecture/gateway/use-cases.md)
- [Code Review](/current/src/docs/architecture/CODE_REVIEW.md)

### Source Code
- Controller: `/current/src/CORE/Gateway/OoBDev.Web.Controllers/MyInfoController.cs`
- Service: `/current/src/CORE/Gateway/OoBDev.Gateway.Access/MyInfoService.cs`
- Model: `/current/src/CORE/Gateway/OoBDev.Web.Models/MyInfoModel.cs`

### Work Items
- TFS Work Item #573: Manage Profile
- TFS Server: tfscorp.itrica.com\ITRICA
- Collection ID: 04150b45-2081-4a9f-89f8-b188e6a7a0a4

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
