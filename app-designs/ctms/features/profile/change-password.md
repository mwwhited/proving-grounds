# Feature Specification: Change Password

**Work Item**: #569
**Feature Area**: Profile Management
**User Role**: Gateway User
**Priority**: High
**Status**: Active

---

## Overview

The Change Password feature allows authenticated users to update their account password. This feature implements password complexity requirements, validates the current password before allowing changes, and maintains an audit trail of password change events for security and compliance.

### Business Context

Password management is critical for:
- Account security and protection
- Regulatory compliance (password rotation policies)
- User control over account access
- Security incident response (forced password changes)
- Audit trail requirements (21 CFR Part 11)

---

## User Stories

### Primary User Story

**As a** Gateway User
**I want to** change my password
**So that** I can maintain my account security and comply with password policies

### Secondary User Stories

**As a** Security Administrator
**I want to** enforce password complexity requirements
**So that** user accounts are protected from unauthorized access

**As a** Compliance Officer
**I want to** audit all password changes
**So that** we can demonstrate security compliance during regulatory reviews

**As a** Gateway User
**I want to** receive confirmation when my password is changed
**So that** I'm aware of any unauthorized changes to my account

---

## Functional Requirements

### FR-1: Change Password Form

**Description**: Provide a secure form for users to change their password.

**URL**: `/Account/ChangePassword`

**Form Fields**:

| Field Name | Type | Validation | Max Length | Description |
|------------|------|------------|------------|-------------|
| Current Password | Password | Required, not whitespace | 100 | User's existing password |
| New Password | Password | Required, complexity rules | 100 | Desired new password |
| Confirm New Password | Password | Required, must match new | 100 | Confirmation of new password |

**Field Behavior**:
- All fields masked (password input type)
- No autocomplete on password fields
- Copy/paste allowed (for password managers)
- Show/hide password toggle (optional enhancement)

### FR-2: Password Validation

**Description**: Enforce password complexity requirements.

**Current Password Validation**:
- Must match user's current password
- Case-sensitive comparison
- Failed attempts increment failed login counter

**New Password Complexity Requirements**:

| Rule | Requirement | Error Message |
|------|-------------|---------------|
| Minimum Length | 8 characters | "Password must be at least 8 characters long" |
| Maximum Length | 100 characters | "Password cannot exceed 100 characters" |
| Uppercase | At least 1 uppercase letter (A-Z) | "Password must contain at least one uppercase letter" |
| Lowercase | At least 1 lowercase letter (a-z) | "Password must contain at least one lowercase letter" |
| Digit | At least 1 number (0-9) | "Password must contain at least one number" |
| Special Character | At least 1 special character (!@#$%^&*) | "Password must contain at least one special character" |
| Not Same as Current | Cannot match current password | "New password must be different from current password" |
| Not Recently Used | Cannot match last 3 passwords (if implemented) | "Password was recently used. Please choose a different password" |

**Special Characters**: `!@#$%^&*()_+-=[]{}|;:,.<>?`

**Password Confirmation**:
- Must exactly match new password
- Case-sensitive comparison
- Validated on client and server side

### FR-3: Password Change Process

**Workflow**:
1. User navigates to Change Password page
2. System displays change password form
3. User enters current password
4. User enters new password
5. User confirms new password
6. User clicks "Change Password" button
7. System validates current password
8. System validates new password complexity
9. System validates password confirmation match
10. System updates password in database
11. System creates audit log entry
12. System sends confirmation email (optional)
13. System displays success message
14. User redirected to profile or dashboard

**Success Criteria**:
- Password updated in database (hashed)
- Audit log entry created
- User remains authenticated (session preserved)
- Confirmation email sent (if configured)

**Failure Scenarios**:
- Invalid current password: Error displayed, attempt logged
- New password fails complexity: Specific error displayed
- Passwords don't match: Error displayed
- Database error: Generic error, technical details logged

### FR-4: Authentication State

**Description**: Maintain user authentication during password change.

**Behavior**:
- User must be authenticated to access change password
- User session remains valid after password change
- User is NOT logged out after successful password change
- Authentication cookie updated with new password hash signature (if applicable)

**Security Consideration**:
- Consider invalidating other sessions (if multi-session tracking enabled)
- Consider sending email notification of password change to registered email

### FR-5: Audit Trail

**Description**: Log all password change attempts for compliance and security.

**Logged Events**:

| Event | Audit Action | Audit Details | Additional Info |
|-------|--------------|---------------|-----------------|
| Successful change | PasswordManagement | Password_Changed_Success | IP address, timestamp |
| Failed - wrong current password | Authentication | Password_Change_Failed_Invalid_Current | IP address, timestamp, attempt count |
| Failed - complexity violation | PasswordManagement | Password_Change_Failed_Complexity | IP address, timestamp, violated rules |
| Failed - passwords don't match | PasswordManagement | Password_Change_Failed_Mismatch | IP address, timestamp |
| Failed - system error | PasswordManagement | Password_Change_Failed_System_Error | IP address, timestamp, error details |

**Audit Information Captured**:
- User identity (username, user ID)
- Timestamp (UTC)
- IP address
- Action result (success/failure)
- Failure reason (if applicable)
- Controller/action name

### FR-6: Email Notification

**Description**: Send confirmation email when password is changed.

**Email Trigger**: Successful password change

**Email Template**:
```
Subject: Password Changed - OoBDev Gateway

Dear [FirstName] [LastName],

Your password for OoBDev Gateway was successfully changed on [Date] at [Time] from IP address [IP].

If you did not make this change, please contact support immediately at support@itrica.com or call 1-800-XXX-XXXX.

For your security:
- Never share your password with anyone
- Use a unique password for OoBDev Gateway
- Change your password regularly

Thank you,
OoBDev Gateway Security Team
```

**Email Processing**:
- Sent via message queue (asynchronous)
- Sent to email address in user profile
- Delivery failures logged but don't block password change
- See: [Messaging Architecture](/current/src/docs/architecture/messaging/README.md)

### FR-7: Password Policy Configuration

**Description**: Password complexity rules should be configurable.

**Configuration Settings**:
- Minimum length (default: 8)
- Maximum length (default: 100)
- Require uppercase (default: true)
- Require lowercase (default: true)
- Require digit (default: true)
- Require special character (default: true)
- Password history count (default: 3)
- Password expiration days (default: 90, 0 = never)

**Configuration Location**: Web.config or database configuration table

---

## Non-Functional Requirements

### NFR-1: Security

**Password Storage**:
- Passwords must be hashed using secure algorithm (bcrypt, PBKDF2, or Argon2)
- Salted hashes (unique salt per password)
- Never store passwords in plain text
- Never log passwords in any form

**Transmission**:
- All password data transmitted over HTTPS only
- TLS 1.2 or higher required
- No password data in URLs or query strings

**Protection Against Attacks**:
- Rate limiting on password change attempts
- CSRF token required on all POST operations
- Protection against timing attacks during password comparison
- Account lockout after repeated failed attempts (configurable)

### NFR-2: Performance

- Password validation must complete within 100ms
- Password hash generation within 500ms
- Total password change operation within 2 seconds
- Email notification queued within 1 second

### NFR-3: Compliance (21 CFR Part 11)

**Electronic Records**:
- Audit trail of all password changes
- Tamper-proof audit logs
- Audit logs retained per regulatory requirements

**Access Controls**:
- User authentication required
- User can only change their own password (except admin reset)
- Password complexity enforced

**Security**:
- Regular password changes enforced (if policy configured)
- Strong password requirements
- Protection against brute force attacks

### NFR-4: Usability

- Clear password requirements displayed on form
- Real-time feedback on password strength (optional)
- Specific error messages for each validation failure
- Success confirmation message
- Accessible form (WCAG 2.1 AA)
- Mobile-responsive design

### NFR-5: Availability

- Password change must be available 99.9% of time
- Graceful error handling if service unavailable
- Clear error messages for users

---

## User Interface

### Change Password Form

```
┌─────────────────────────────────────────────────────────┐
│ Change Password                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ For your security, please enter your current password  │
│ and choose a strong new password.                      │
│                                                         │
│ Current Password: * [••••••••••••••••••]                │
│                                                         │
│ New Password:     * [••••••••••••••••••]                │
│                                                         │
│ Password Requirements:                                  │
│  • At least 8 characters                                │
│  • At least one uppercase letter (A-Z)                  │
│  • At least one lowercase letter (a-z)                  │
│  • At least one number (0-9)                            │
│  • At least one special character (!@#$%^&*)            │
│                                                         │
│ Confirm New Password: * [••••••••••••••••••]            │
│                                                         │
│                                                         │
│                              [Cancel]  [Change Password]│
└─────────────────────────────────────────────────────────┘

* Required field
```

### Success Message

```
┌─────────────────────────────────────────────────────────┐
│ ✓ Password Changed Successfully                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Your password has been changed successfully.            │
│                                                         │
│ A confirmation email has been sent to:                  │
│ john.doe@example.com                                    │
│                                                         │
│ For your security, please use your new password the     │
│ next time you log in.                                   │
│                                                         │
│                                            [Continue]   │
└─────────────────────────────────────────────────────────┘
```

### Error Message Example

```
┌─────────────────────────────────────────────────────────┐
│ ✗ Unable to Change Password                             │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Please correct the following errors:                    │
│                                                         │
│  • Current password is incorrect                        │
│  • New password must contain at least one uppercase     │
│    letter                                               │
│  • New password must contain at least one special       │
│    character                                            │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## API Endpoints

### GET /Account/ChangePassword
**Description**: Display change password form
**Authorization**: Authenticated user
**Returns**: Change password form view

### POST /Account/ChangePassword
**Description**: Process password change request
**Authorization**: Authenticated user

**Request Body**: ChangePasswordModel
```json
{
  "CurrentPassword": "string",
  "NewPassword": "string",
  "ConfirmPassword": "string"
}
```

**Success Response** (200 OK):
- Redirect to success page or profile
- Success message in TempData

**Error Response** (400 Bad Request):
```json
{
  "ModelState": {
    "CurrentPassword": ["Current password is incorrect"],
    "NewPassword": ["Password must contain at least one uppercase letter"],
    "ConfirmPassword": ["Passwords do not match"]
  }
}
```

---

## Data Model

### AspNetUsers Table (Membership)

```sql
-- Standard ASP.NET Membership schema
-- Password stored in hashed format
-- LastPasswordChangedDate updated on change
```

### PasswordHistory Table (Optional)

```sql
CREATE TABLE PasswordHistory (
    PasswordHistoryID   INT IDENTITY(1,1) PRIMARY KEY,
    UserId             UNIQUEIDENTIFIER NOT NULL,
    PasswordHash       NVARCHAR(500) NOT NULL,
    ChangedDate        DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ChangedByIP        NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_PasswordHistory_User
        FOREIGN KEY (UserId) REFERENCES AspNetUsers(UserId)
)

CREATE INDEX IX_PasswordHistory_UserId ON PasswordHistory(UserId)
CREATE INDEX IX_PasswordHistory_ChangedDate ON PasswordHistory(ChangedDate DESC)
```

**Purpose**: Prevent password reuse by storing hash of previous passwords

### Configuration Table

```sql
CREATE TABLE SystemConfiguration (
    ConfigKey      NVARCHAR(100) PRIMARY KEY,
    ConfigValue    NVARCHAR(500) NOT NULL,
    Description    NVARCHAR(500) NULL
)

-- Password policy configuration
INSERT INTO SystemConfiguration VALUES
    ('Password.MinLength', '8', 'Minimum password length'),
    ('Password.RequireUppercase', 'true', 'Require uppercase letter'),
    ('Password.RequireLowercase', 'true', 'Require lowercase letter'),
    ('Password.RequireDigit', 'true', 'Require number'),
    ('Password.RequireSpecialChar', 'true', 'Require special character'),
    ('Password.HistoryCount', '3', 'Number of previous passwords to check'),
    ('Password.ExpirationDays', '90', 'Days before password expires (0=never)')
```

---

## Business Rules

### BR-1: Current Password Verification
- User must provide correct current password
- Failed attempts count toward account lockout
- After configurable failed attempts, account locked

### BR-2: Password Complexity
- All complexity rules must be satisfied
- Rules enforced on client and server
- Specific error messages for each violated rule

### BR-3: Password Confirmation
- New password and confirmation must match exactly
- Case-sensitive comparison

### BR-4: Password History
- New password cannot match current password
- New password cannot match last N passwords (configurable)
- Comparison done using hash comparison

### BR-5: Session Preservation
- User session remains valid after password change
- User not forced to re-login
- Authentication cookie updated if needed

### BR-6: Notification
- Confirmation email sent to registered email address
- Email sent asynchronously (doesn't block password change)
- Email failure logged but doesn't fail password change

---

## User Workflows

### Workflow 1: Successful Password Change

```
[User] → Navigate to Change Password
           ↓
       [System] Display change password form
           ↓
       [User] Enter current password
           ↓
       [User] Enter new password (meets requirements)
           ↓
       [User] Confirm new password (matches)
           ↓
       [User] Click "Change Password"
           ↓
       [System] Validate current password ✓
           ↓
       [System] Validate new password complexity ✓
           ↓
       [System] Validate password confirmation ✓
           ↓
       [System] Check password history ✓
           ↓
       [System] Update password (hashed)
           ↓
       [System] Create audit log entry
           ↓
       [System] Queue confirmation email
           ↓
       [System] Display success message
           ↓
       [User] Continues using system
```

### Workflow 2: Failed Password Change (Wrong Current Password)

```
[User] → Navigate to Change Password
           ↓
       [System] Display change password form
           ↓
       [User] Enter incorrect current password
           ↓
       [User] Enter new password
           ↓
       [User] Confirm new password
           ↓
       [User] Click "Change Password"
           ↓
       [System] Validate current password ✗
           ↓
       [System] Create audit log (failed attempt)
           ↓
       [System] Increment failed password change counter
           ↓
       [System] Display error: "Current password is incorrect"
           ↓
       Form redisplayed (new password fields cleared)
           ↓
       [User] Tries again or cancels
```

### Workflow 3: Failed Password Change (Complexity Violation)

```
[User] → Navigate to Change Password
           ↓
       [System] Display change password form
           ↓
       [User] Enter current password (correct)
           ↓
       [User] Enter new password (weak - no uppercase)
           ↓
       [User] Confirm new password
           ↓
       [User] Click "Change Password"
           ↓
       [System] Validate current password ✓
           ↓
       [System] Validate new password complexity ✗
           ↓
       [System] Create audit log (complexity failure)
           ↓
       [System] Display error: "Password must contain at least one uppercase letter"
           ↓
       Form redisplayed with error messages
           ↓
       [User] Corrects password and tries again
```

---

## Error Handling

### Validation Errors

| Error Condition | Error Message | HTTP Status |
|----------------|---------------|-------------|
| Current password empty | "Current password is required" | 400 |
| Current password incorrect | "Current password is incorrect" | 400 |
| New password empty | "New password is required" | 400 |
| New password too short | "Password must be at least 8 characters long" | 400 |
| New password no uppercase | "Password must contain at least one uppercase letter" | 400 |
| New password no lowercase | "Password must contain at least one lowercase letter" | 400 |
| New password no digit | "Password must contain at least one number" | 400 |
| New password no special char | "Password must contain at least one special character" | 400 |
| New password same as current | "New password must be different from current password" | 400 |
| New password recently used | "Password was recently used. Please choose a different password" | 400 |
| Confirm password empty | "Please confirm your new password" | 400 |
| Passwords don't match | "New password and confirmation do not match" | 400 |

### System Errors

| Error Condition | User Message | Technical Action |
|----------------|--------------|------------------|
| Database unavailable | "Unable to change password. Please try again later." | Log error, alert operations |
| Membership provider error | "Unable to change password. Please try again later." | Log error, alert operations |
| Email queue failure | "Password changed, but confirmation email could not be sent" | Log warning, queue retry |
| Audit log failure | "Unable to change password. Please try again later." | Log critical error, fail operation |

---

## Security Considerations

### Password Hashing
- Use bcrypt, PBKDF2, or Argon2
- Minimum iteration count: 10,000 (PBKDF2)
- Unique salt per password
- Salt stored with hash

### Brute Force Protection
- Rate limiting on password change attempts
- Account lockout after N failed current password attempts
- CAPTCHA after repeated failures (optional)
- IP-based rate limiting

### Session Security
- Require HTTPS for all password operations
- CSRF token on POST operations
- Secure authentication cookies (HttpOnly, Secure flags)
- Consider invalidating other sessions after password change

### Password Requirements
- Enforce strong passwords
- Prevent common passwords (optional: check against breach database)
- Prevent username in password
- Prevent keyboard patterns (optional: qwerty123, etc.)

### Audit Trail
- Log all password change attempts
- Log both success and failures
- Include IP address, timestamp, user identity
- Protect audit logs from tampering

---

## Testing Requirements

### Unit Tests
- Password complexity validation logic
- Current password verification
- Password confirmation matching
- Password history checking
- Hash generation and comparison

### Integration Tests
- End-to-end password change workflow
- Audit log creation
- Email notification queueing
- Session preservation after change
- Password history enforcement

### Security Tests
- Brute force protection
- CSRF protection
- SQL injection attempts
- XSS attempts in error messages
- Timing attack resistance
- Password hash strength

### UI Tests
- Form validation (client and server)
- Error message display
- Success message display
- Field masking
- Navigation flows

---

## Acceptance Criteria

### AC-1: Password Change Success
- ✅ User can change password with valid inputs
- ✅ Password updated in database (hashed)
- ✅ User session remains valid
- ✅ Audit log entry created
- ✅ Confirmation email sent

### AC-2: Current Password Validation
- ✅ Incorrect current password rejected
- ✅ Failed attempt logged
- ✅ Specific error message displayed
- ✅ Failed attempts count toward lockout

### AC-3: Password Complexity
- ✅ All complexity rules enforced
- ✅ Specific error for each violation
- ✅ Client-side and server-side validation
- ✅ Configuration-driven rules

### AC-4: Password Confirmation
- ✅ Passwords must match exactly
- ✅ Mismatch error displayed
- ✅ Case-sensitive comparison

### AC-5: Password History
- ✅ Cannot reuse current password
- ✅ Cannot reuse last N passwords
- ✅ Appropriate error message

### AC-6: Security
- ✅ HTTPS required
- ✅ CSRF protection
- ✅ Secure password hashing
- ✅ No passwords in logs
- ✅ Brute force protection

### AC-7: Audit Trail
- ✅ Success logged
- ✅ Failures logged
- ✅ IP address captured
- ✅ Timestamp captured
- ✅ User identity captured

---

## Dependencies

### Internal Dependencies
- ASP.NET Membership Provider
- Authentication system
- Audit logging system
- Email notification system (message queue)
- Configuration system

### External Dependencies
- Database (SQL Server)
- SMTP server (for email notifications)
- Message queue (for async email)

---

## Related Features

- [Manage Profile](./manage-profile.md) - Work Item #573
- [Password Recovery](./password-recovery.md) - Work Item #574
- [Account Verification](./account-verification.md)

---

## References

### Architecture Documentation
- [Gateway Use Cases](/current/src/docs/architecture/gateway/use-cases.md)
- [Messaging Architecture](/current/src/docs/architecture/messaging/README.md)

### Source Code
- Controller: `/current/src/CORE/Gateway/OoBDev.Web.Controllers/AccountController.cs`
- Service: `/current/src/CORE/Gateway/OoBDev.Gateway.Access/AccountMembershipService.cs`

### Work Items
- TFS Work Item #569: Change Password
- TFS Server: tfscorp.itrica.com\ITRICA
- Collection ID: 04150b45-2081-4a9f-89f8-b188e6a7a0a4

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
