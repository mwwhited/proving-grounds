# Feature Specification: Password Recovery

**Work Item**: #574
**Feature Area**: Profile Management
**User Role**: Gateway User (Unauthenticated)
**Priority**: High
**Status**: Active

---

## Overview

The Password Recovery feature enables users to regain access to their accounts when they forget their password through a self-service process using security questions and/or email verification. This feature reduces administrative burden while maintaining security and compliance with audit trail requirements.

### Business Context

Password recovery is critical for:
- Reducing helpdesk burden for password reset requests
- Maintaining user productivity (no waiting for admin assistance)
- Security (self-service with proper identity verification)
- Compliance (audit trail of password reset events)
- User experience (quick recovery process)

---

## User Stories

### Primary User Story

**As a** Gateway User who has forgotten my password
**I want to** reset my password myself
**So that** I can regain access to my account without contacting support

### Secondary User Stories

**As a** System Administrator
**I want to** users to verify their identity before resetting passwords
**So that** accounts are protected from unauthorized access

**As a** Security Officer
**I want to** audit all password reset attempts
**So that** we can detect potential security incidents

**As a** Support Staff
**I want to** reduce password reset tickets
**So that** I can focus on more complex support issues

---

## Functional Requirements

### FR-1: Password Recovery Entry Point

**Description**: Provide accessible entry point for password recovery.

**URL**: `/Account/ForgotPassword`

**Access**: Public (anonymous users)

**Entry Points**:
- Link on login page: "Forgot your password?"
- Direct navigation to URL
- Link from account locked message

**Initial Form**:
- Single field: Username or Email
- Submit button: "Continue"
- CAPTCHA (optional, recommended)

### FR-2: User Identification

**Description**: Identify user account by username or email.

**Input Validation**:
- Required field
- Minimum 3 characters
- Maximum 255 characters
- Accept username OR email address
- Case-insensitive lookup

**Lookup Process**:
1. User enters username or email
2. System attempts to find user account
3. If found: Proceed to identity verification
4. If not found: Display generic message (prevent enumeration)

**Security - Account Enumeration Prevention**:
- Same response time for existing and non-existing accounts
- Generic success message regardless of account existence
- "If an account exists with this username/email, you will receive instructions"
- No indication whether account was found

### FR-3: Identity Verification Method Selection

**Description**: Offer multiple identity verification methods.

**Available Methods**:

1. **Security Questions** (Primary method)
   - Answer security questions from profile
   - Available if user has set security questions
   - Recommended method (no external dependencies)

2. **Email Verification** (Secondary method)
   - Send verification code to registered email
   - Available if user has verified email on file
   - Requires working email access

3. **Phone Verification** (Optional third method)
   - Send SMS code to registered phone
   - Available if user has verified phone on file
   - Requires working phone access
   - May incur SMS costs

**Method Selection Page**:
```
How would you like to verify your identity?

○ Answer Security Questions
  Fastest method - no waiting for codes

○ Email Verification Code
  We'll send a code to j***@example.com

○ SMS Verification Code
  We'll send a code to (555) ***-4567

[Continue]
```

### FR-4: Security Questions Verification

**Description**: Verify user identity through security questions.

**Process**:
1. Display user's security questions (without answers)
2. User enters answers
3. System validates answers (case-insensitive)
4. If correct: Allow password reset
5. If incorrect: Track failed attempt, show error

**Display**:
- Show both security questions (if user has two)
- Require answer to at least one question
- Text input fields (not dropdowns)
- Case-insensitive comparison
- Trim whitespace before comparison

**Validation**:
- Compare hashed answer to stored hash
- Case-insensitive comparison
- Maximum 3 attempts
- Account lockout after failed attempts (configurable)

**Error Handling**:
- Generic error: "The answer provided is incorrect"
- Attempt counter: "X attempts remaining"
- Lockout message: "Too many failed attempts. Account locked for 30 minutes."

### FR-5: Email Verification Code

**Description**: Verify identity via email verification code.

**Process**:
1. System generates 6-digit verification code
2. System sends code to user's registered email
3. User receives email with code
4. User enters code on verification page
5. System validates code
6. If valid: Allow password reset

**Code Properties**:
- Format: 6-digit numeric (123456)
- Validity: 1 hour from generation
- One-time use
- Maximum 5 attempts per code
- Maximum 3 code generations per hour

**Email Template**:
```
Subject: Password Reset Verification Code - OoBDev Gateway

Dear [FirstName],

You requested to reset your password for OoBDev Gateway.

Verification Code: 123456

This code will expire in 1 hour.

To reset your password:
1. Enter the code above on the verification page
2. Create a new password
3. Log in with your new password

If you did not request a password reset, please contact support immediately at support@itrica.com.

For your security, this link will expire in 1 hour.

Thank you,
OoBDev Gateway Security Team
```

### FR-6: SMS Verification Code

**Description**: Verify identity via SMS code.

**Process**: Similar to email verification, but via SMS

**SMS Template**:
```
OoBDev Gateway password reset code: 123456

This code expires in 30 minutes.

Do not share this code.
```

**Rate Limiting**:
- Maximum 3 SMS per phone per hour
- Maximum 5 SMS per IP per hour
- Cooldown: 5 minutes between SMS

### FR-7: Password Reset Form

**Description**: Allow user to create new password after verification.

**URL**: `/Account/ResetPassword`

**Access**: Only after successful identity verification (token-based)

**Form Fields**:

| Field Name | Type | Validation | Description |
|------------|------|------------|-------------|
| New Password | Password | Required, complexity rules | New password |
| Confirm Password | Password | Required, must match | Password confirmation |

**Password Requirements**:
- Same complexity rules as registration/change password
- Minimum 8 characters
- Uppercase, lowercase, digit, special character
- Cannot be same as previous password (if history enabled)
- Cannot contain username

**Security Token**:
- Cryptographically random token generated after verification
- Token valid for 15 minutes
- One-time use
- Token associates user with reset session
- Token invalidated after successful reset

### FR-8: Password Reset Process

**Complete Workflow**:
1. User navigates to Forgot Password
2. User enters username/email
3. System identifies user (or pretends to)
4. System displays verification method selection
5. User selects verification method
6. User completes verification (questions/email/SMS)
7. System generates password reset token
8. System redirects to password reset form
9. User enters new password
10. User confirms new password
11. System validates password
12. System updates password (hashed)
13. System invalidates all active sessions (optional)
14. System sends password change confirmation email
15. System creates audit log entries
16. System displays success message
17. User redirected to login page

### FR-9: Account Lockout Protection

**Description**: Prevent brute force attacks on password recovery.

**Lockout Triggers**:
- 3 failed security question attempts
- 5 failed verification code attempts
- 10 failed recovery attempts from same IP per hour

**Lockout Duration**:
- Account lockout: 30 minutes (configurable)
- IP lockout: 1 hour (configurable)
- Progressive lockout: Increase duration on repeated violations

**Lockout Bypass**:
- Wait for lockout duration to expire
- Contact administrator for manual unlock
- Use alternative verification method (if available)

### FR-10: Password Change Notification

**Description**: Notify user when password is successfully reset.

**Email Template**:
```
Subject: Password Reset Successful - OoBDev Gateway

Dear [FirstName] [LastName],

Your password for OoBDev Gateway was successfully reset on [Date] at [Time] from IP address [IP].

If you did not make this change, please contact support immediately at support@itrica.com or call 1-800-XXX-XXXX.

Your account may have been compromised. We recommend:
- Reviewing your account activity
- Enabling additional security measures
- Changing passwords on other accounts if you used the same password

For your security:
- Never share your password with anyone
- Use a unique password for OoBDev Gateway
- Change your password regularly

Thank you,
OoBDev Gateway Security Team
```

**Delivery**:
- Sent to registered email address
- Sent via message queue (asynchronous)
- Delivery failure logged but doesn't block reset

### FR-11: Session Invalidation

**Description**: Invalidate existing sessions when password is reset.

**Behavior**:
- All active sessions for user invalidated (optional but recommended)
- User must log in again with new password
- Prevents attacker from maintaining access if they had stolen session

**Configuration**: Configurable via system settings

### FR-12: Audit Trail

**Description**: Comprehensive logging of all password recovery events.

**Logged Events**:

| Event | Audit Action | Audit Details | Additional Info |
|-------|--------------|---------------|-----------------|
| Recovery initiated | PasswordRecovery | Recovery_Initiated | Username/email attempted, IP |
| User identified | PasswordRecovery | User_Identified | Username, IP |
| User not found | PasswordRecovery | User_Not_Found | Input (hashed), IP |
| Verification method selected | PasswordRecovery | Verification_Method_Selected | Method, IP |
| Security question answered correctly | PasswordRecovery | Security_Question_Success | Username, IP |
| Security question failed | PasswordRecovery | Security_Question_Failed | Username, IP, attempt count |
| Verification code sent | PasswordRecovery | Verification_Code_Sent | Code type, destination (masked) |
| Verification code validated | PasswordRecovery | Verification_Code_Success | Code type, IP |
| Verification code failed | PasswordRecovery | Verification_Code_Failed | Code type, IP, attempt count |
| Password reset successful | PasswordRecovery | Password_Reset_Success | Username, IP |
| Account locked (too many attempts) | PasswordRecovery | Account_Locked | Username, IP, lockout duration |

---

## Non-Functional Requirements

### NFR-1: Security

**Identity Verification**:
- Multiple verification methods available
- Minimum one method required
- Strong verification before password reset

**Protection Against Attacks**:
- Account enumeration prevention
- Brute force protection (lockout)
- Rate limiting on verification attempts
- Token-based reset (not direct links)
- Short token expiration (15 minutes)
- One-time use tokens

**Password Security**:
- Same strong password requirements
- Password hashing before storage
- Cannot reuse recent passwords
- Session invalidation on reset

### NFR-2: Performance

- Recovery page load: <1 second
- User lookup: <500ms
- Verification code generation: <200ms
- Email queuing: <1 second
- SMS sending: <10 seconds
- Password update: <1 second

### NFR-3: Reliability

**Email Delivery**:
- Queue-based delivery
- Retry on failure (3 attempts)
- Fallback to alternative methods if email fails
- Clear error messaging

**SMS Delivery**:
- Retry on failure (2 attempts)
- Fallback to email if SMS fails
- Rate limiting to control costs

**Service Availability**:
- Recovery service available 99.9%
- Graceful degradation if dependencies fail
- Alternative verification methods if one fails

### NFR-4: Compliance (21 CFR Part 11)

**Audit Trail**:
- All recovery attempts logged
- Success and failure logged
- IP address captured
- Timestamp captured (UTC)
- User identity captured

**Data Integrity**:
- Password changes tracked
- Before/after state tracked (not passwords themselves)
- Tamper-proof audit logs

### NFR-5: Usability

- Clear step-by-step process
- Progress indication
- Clear error messages with remediation steps
- Mobile-responsive design
- Accessible (WCAG 2.1 AA)
- Estimated time for each method
- Help text for each step

---

## User Interface

### Forgot Password - Initial Page

```
┌─────────────────────────────────────────────────────────┐
│ Forgot Your Password?                                   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Enter your username or email address and we'll help    │
│ you reset your password.                                │
│                                                         │
│ Username or Email: [____________________]               │
│                                                         │
│ [reCAPTCHA verification box]                            │
│                                                         │
│                         [Cancel]  [Continue]            │
│                                                         │
│ Remember your password? [Back to Login]                 │
└─────────────────────────────────────────────────────────┘
```

### Verification Method Selection

```
┌─────────────────────────────────────────────────────────┐
│ Verify Your Identity                                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ How would you like to verify your identity?            │
│                                                         │
│ ┌─────────────────────────────────────────────────┐   │
│ │ ○ Answer Security Questions                     │   │
│ │   Fastest method - no waiting for codes          │   │
│ │   Estimated time: 1 minute                       │   │
│ └─────────────────────────────────────────────────┘   │
│                                                         │
│ ┌─────────────────────────────────────────────────┐   │
│ │ ○ Email Verification Code                       │   │
│ │   We'll send a code to j***@example.com          │   │
│ │   Estimated time: 5 minutes                      │   │
│ └─────────────────────────────────────────────────┘   │
│                                                         │
│ ┌─────────────────────────────────────────────────┐   │
│ │ ○ SMS Verification Code                         │   │
│ │   We'll send a code to (555) ***-4567            │   │
│ │   Estimated time: 2 minutes                      │   │
│ └─────────────────────────────────────────────────┘   │
│                                                         │
│                         [Cancel]  [Continue]            │
└─────────────────────────────────────────────────────────┘
```

### Security Questions

```
┌─────────────────────────────────────────────────────────┐
│ Answer Security Questions                               │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Please answer the following security questions to      │
│ verify your identity.                                   │
│                                                         │
│ Question 1: What is your mother's maiden name?          │
│                                                         │
│ Answer: [____________________]                          │
│                                                         │
│ Question 2: What city were you born in?                 │
│                                                         │
│ Answer: [____________________]                          │
│                                                         │
│ Note: Answers are not case-sensitive                    │
│                                                         │
│                         [Cancel]  [Verify]              │
│                                                         │
│ Attempts remaining: 3                                   │
└─────────────────────────────────────────────────────────┘
```

### Reset Password Form

```
┌─────────────────────────────────────────────────────────┐
│ Create New Password                                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Your identity has been verified. Please create a new   │
│ password for your account.                              │
│                                                         │
│ New Password: * [••••••••••••••••••]                    │
│                 Password Strength: [████░░░░] Medium    │
│                                                         │
│ Password Requirements:                                  │
│  ✓ At least 8 characters                                │
│  ✓ At least one uppercase letter                        │
│  ✗ At least one lowercase letter                        │
│  ✓ At least one number                                  │
│  ✗ At least one special character                       │
│                                                         │
│ Confirm Password: * [••••••••••••••••••]                │
│                                                         │
│                         [Cancel]  [Reset Password]      │
│                                                         │
│ This link expires in: 14 minutes                        │
└─────────────────────────────────────────────────────────┘
```

### Success Message

```
┌─────────────────────────────────────────────────────────┐
│ ✓ Password Reset Successful                             │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Your password has been reset successfully.              │
│                                                         │
│ For your security:                                      │
│  • All active sessions have been logged out             │
│  • A confirmation email has been sent to you            │
│  • Please review your account activity                  │
│                                                         │
│ You can now log in with your new password.              │
│                                                         │
│                                  [Continue to Login]    │
└─────────────────────────────────────────────────────────┘
```

---

## API Endpoints

### POST /Account/ForgotPassword
**Description**: Initiate password recovery
**Authorization**: Anonymous

**Request Body**:
```json
{
  "UsernameOrEmail": "string",
  "RecaptchaToken": "string"
}
```

**Response** (200 OK):
```json
{
  "Success": true,
  "Message": "If an account exists, you will receive instructions",
  "SessionToken": "encrypted-token-for-next-step"
}
```

### GET /Account/SelectVerificationMethod
**Description**: Display verification method selection
**Authorization**: Valid session token from previous step
**Returns**: Verification method selection page

### POST /Account/VerifySecurityQuestions
**Description**: Verify user via security questions
**Authorization**: Valid session token

**Request Body**:
```json
{
  "Answer1": "string",
  "Answer2": "string",
  "SessionToken": "string"
}
```

**Success** (200 OK):
```json
{
  "Success": true,
  "ResetToken": "one-time-reset-token",
  "ExpiresAt": "2026-01-13T16:30:00Z"
}
```

**Error** (400 Bad Request):
```json
{
  "Success": false,
  "Message": "Incorrect answer",
  "AttemptsRemaining": 2
}
```

### POST /Account/SendVerificationCode
**Description**: Send verification code via email or SMS
**Authorization**: Valid session token

**Request Body**:
```json
{
  "Method": "Email", // or "SMS"
  "SessionToken": "string"
}
```

**Response** (200 OK):
```json
{
  "Success": true,
  "Message": "Verification code sent",
  "CodeType": "Email",
  "MaskedDestination": "j***@example.com",
  "ExpiresAt": "2026-01-13T16:00:00Z"
}
```

### POST /Account/ValidateVerificationCode
**Description**: Validate verification code
**Authorization**: Valid session token

**Request Body**:
```json
{
  "Code": "123456",
  "SessionToken": "string"
}
```

**Response**: Same as VerifySecurityQuestions

### POST /Account/ResetPassword
**Description**: Set new password
**Authorization**: Valid reset token (from verification step)

**Request Body**:
```json
{
  "ResetToken": "string",
  "NewPassword": "string",
  "ConfirmPassword": "string"
}
```

**Success** (200 OK):
```json
{
  "Success": true,
  "Message": "Password reset successfully"
}
```

---

## Data Model

### PasswordResetTokens Table

```sql
CREATE TABLE PasswordResetTokens (
    TokenID         INT IDENTITY(1,1) PRIMARY KEY,
    UserId          UNIQUEIDENTIFIER NOT NULL,
    Token           NVARCHAR(100) NOT NULL,
    VerificationMethod NVARCHAR(20) NOT NULL, -- 'SecurityQuestions', 'Email', 'SMS'
    CreatedAt       DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ExpiresAt       DATETIME2 NOT NULL,
    IsUsed          BIT NOT NULL DEFAULT 0,
    UsedAt          DATETIME2 NULL,
    IPAddress       NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_PasswordResetTokens_User
        FOREIGN KEY (UserId) REFERENCES AspNetUsers(UserId),
    CONSTRAINT CK_PasswordResetTokens_Method
        CHECK (VerificationMethod IN ('SecurityQuestions', 'Email', 'SMS'))
)

CREATE INDEX IX_PasswordResetTokens_Token ON PasswordResetTokens(Token)
CREATE INDEX IX_PasswordResetTokens_UserId ON PasswordResetTokens(UserId)
CREATE INDEX IX_PasswordResetTokens_Expires ON PasswordResetTokens(ExpiresAt)
```

### RecoveryAttempts Table

```sql
CREATE TABLE RecoveryAttempts (
    AttemptID       INT IDENTITY(1,1) PRIMARY KEY,
    UserId          UNIQUEIDENTIFIER NULL, -- Null if user not found
    AttemptType     NVARCHAR(50) NOT NULL,
    Success         BIT NOT NULL,
    AttemptDate     DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    IPAddress       NVARCHAR(50) NOT NULL,
    UserAgent       NVARCHAR(500) NULL
)

CREATE INDEX IX_RecoveryAttempts_UserId ON RecoveryAttempts(UserId)
CREATE INDEX IX_RecoveryAttempts_IP ON RecoveryAttempts(IPAddress)
CREATE INDEX IX_RecoveryAttempts_Date ON RecoveryAttempts(AttemptDate DESC)
```

---

## Business Rules

### BR-1: User Identification
- Accept username OR email
- Case-insensitive lookup
- Generic response (prevent enumeration)

### BR-2: Verification Methods
- At least one method must be available
- User chooses method
- Multiple attempts allowed per method
- Lockout after excessive failures

### BR-3: Security Questions
- Compare hashed answers
- Case-insensitive comparison
- Trim whitespace
- Maximum 3 attempts

### BR-4: Verification Codes
- Cryptographically random
- Time-limited
- One-time use
- Rate limited

### BR-5: Password Reset Token
- Generated after successful verification
- Valid for 15 minutes
- One-time use
- Cryptographically random

### BR-6: New Password
- Must meet complexity requirements
- Cannot match current password
- Cannot match recent passwords (if history enabled)

### BR-7: Session Invalidation
- All active sessions invalidated (configurable)
- User must log in with new password

---

## Testing Requirements

### Unit Tests
- User lookup logic
- Security question validation
- Verification code validation
- Password validation
- Token generation and validation

### Integration Tests
- Complete recovery workflow (all methods)
- Email sending
- SMS sending
- Account lockout
- Session invalidation

### Security Tests
- Account enumeration prevention
- Brute force protection
- Token expiration
- Token reuse prevention
- Rate limiting

---

## Acceptance Criteria

### AC-1: Recovery via Security Questions
- ✅ User can reset password using security questions
- ✅ Answers validated correctly
- ✅ Failed attempts tracked
- ✅ Account locked after too many failures

### AC-2: Recovery via Email
- ✅ User can reset password using email code
- ✅ Code sent to registered email
- ✅ Code validated correctly
- ✅ Code expires after time limit

### AC-3: Recovery via SMS
- ✅ User can reset password using SMS code
- ✅ Code sent to registered phone
- ✅ Rate limiting enforced

### AC-4: Password Reset
- ✅ User can set new password
- ✅ Password complexity enforced
- ✅ Confirmation email sent
- ✅ Sessions invalidated

### AC-5: Security
- ✅ Account enumeration prevented
- ✅ Brute force protection
- ✅ Audit trail complete

---

## Dependencies

### Internal Dependencies
- Manage Profile (security questions)
- Account Verification (verified email/phone)
- Email service
- SMS service (optional)
- Audit logging system

### External Dependencies
- SMTP server
- SMS gateway (optional)
- Database

---

## Related Features

- [Manage Profile](./manage-profile.md) - Work Item #573 (security questions)
- [Change Password](./change-password.md) - Work Item #569
- [Account Verification](./account-verification.md)

---

## References

### Architecture Documentation
- [Gateway Use Cases](/current/src/docs/architecture/gateway/use-cases.md)
- [Messaging Architecture](/current/src/docs/architecture/messaging/README.md)

### Work Items
- TFS Work Item #574: Password and Unlock Self Service
- TFS Server: tfscorp.itrica.com\ITRICA

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
