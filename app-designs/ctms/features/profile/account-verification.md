# Feature Specification: Account Verification

**Feature Area**: Profile Management
**User Role**: Newly Registered User
**Priority**: High
**Status**: Active

---

## Overview

The Account Verification feature validates user email addresses and phone numbers through one-time verification codes sent via email and SMS. This feature ensures that users have provided valid contact information and can receive important system notifications, meeting security and regulatory compliance requirements.

### Business Context

Account verification is critical for:
- Validating user identity and contact information
- Preventing fake or spam account registrations
- Ensuring reliable communication channels for notifications
- Meeting regulatory requirements for user identification
- Supporting password recovery mechanisms
- Reducing support burden from invalid contact information

---

## User Stories

### Primary User Story

**As a** newly registered user
**I want to** verify my email and phone number
**So that** I can activate my account and receive important notifications

### Secondary User Stories

**As a** System Administrator
**I want to** ensure all users have verified contact information
**So that** we can reliably send critical trial-related notifications

**As a** Security Administrator
**I want to** prevent bot and fake account registrations
**So that** the system is only accessed by legitimate users

**As a** Support Staff
**I want** users to have valid contact information
**So that** we can assist them when they need help

---

## Functional Requirements

### FR-1: Email Verification Code Generation

**Description**: Generate secure, time-limited verification codes for email verification.

**Code Generation**:
- Format: 6-digit numeric code (e.g., 123456)
- Generation: Cryptographically secure random number generator
- Uniqueness: Verified to be unique across active codes
- Case-insensitive: All numeric (no ambiguous characters)

**Code Properties**:
- Valid duration: 24 hours from generation
- One-time use: Code invalidated after successful verification
- Regeneration: User can request new code (invalidates previous)
- Maximum attempts: 5 verification attempts per code

**Storage**:
```sql
VerificationCodeID, UserId, CodeType='Email', Code,
ExpiresAt, CreatedAt, AttemptCount, IsUsed, UsedAt
```

### FR-2: Email Verification Message

**Description**: Send verification code to user's registered email address.

**Email Template**:
```
Subject: Verify Your Email Address - OoBDev Gateway

Dear [FirstName] [LastName],

Thank you for registering with OoBDev Gateway!

To complete your registration and activate your account, please verify your email address by entering the following code:

Verification Code: 123456

This code will expire in 24 hours.

To verify your email:
1. Go to the verification page
2. Enter the code above
3. Click "Verify Email"

If you did not create an account with OoBDev Gateway, please disregard this email.

Need help? Contact support at support@itrica.com or call 1-800-XXX-XXXX.

Thank you,
OoBDev Gateway Team
```

**Delivery**:
- Sent via message queue (asynchronous)
- Target email: User's registered email address
- From address: noreply@itrica.com
- Reply-to: support@itrica.com
- Priority: High
- HTML and plain text versions

**Tracking**:
- Log email sent event
- Track delivery status (if supported by email provider)
- Log delivery failures

### FR-3: Phone Verification Code Generation

**Description**: Generate secure, time-limited verification codes for phone verification.

**Code Generation**:
- Format: 6-digit numeric code (e.g., 789012)
- Generation: Cryptographically secure random number generator
- Uniqueness: Verified to be unique across active codes
- Different from email code (for security)

**Code Properties**:
- Valid duration: 30 minutes from generation
- One-time use: Code invalidated after successful verification
- Regeneration: User can request new code (invalidates previous)
- Maximum attempts: 3 verification attempts per code
- Rate limiting: Maximum 3 code requests per hour per phone number

### FR-4: Phone Verification Message (SMS)

**Description**: Send verification code to user's registered phone number via SMS.

**SMS Template**:
```
OoBDev Gateway verification code: 789012

This code expires in 30 minutes.

Do not share this code with anyone.
```

**SMS Properties**:
- Maximum length: 160 characters (single SMS)
- No special formatting
- Plain text only
- Country code required: +15551234567

**Delivery**:
- Sent via SMS gateway (Twilio, AWS SNS, etc.)
- Target phone: User's registered phone number (E.164 format)
- Sender ID: OoBDev (or shortcode)
- Priority: High

**Rate Limiting**:
- Maximum 3 SMS per phone number per hour
- Maximum 10 SMS per IP address per hour
- Cooldown: 2 minutes between SMS requests

**Cost Considerations**:
- SMS costs money per message
- Implement aggressive rate limiting
- Consider CAPTCHA before SMS resend
- Monitor for abuse

### FR-5: Verification Page

**Description**: Provide interface for users to enter verification codes.

**URL**: `/Account/Verify`

**Access**:
- Registered but unverified users only
- Redirected from registration success page
- Session/cookie with user ID required

**Page Sections**:

1. **Email Verification Section**
   - Input field for 6-digit email code
   - "Verify Email" button
   - "Resend Email Code" link
   - Status indicator (pending/verified)
   - Time remaining until expiration

2. **Phone Verification Section**
   - Input field for 6-digit phone code
   - "Verify Phone" button
   - "Resend SMS Code" link
   - Status indicator (pending/verified)
   - Time remaining until expiration
   - SMS rate limit warning

3. **Progress Indicator**
   - Shows which verifications are complete
   - Shows which are pending
   - Clear instructions

**Validation Behavior**:
- Real-time format validation (6 digits)
- Submit on enter key
- Clear error messages
- Attempt counter display
- Auto-focus on input field

### FR-6: Email Verification Process

**Workflow**:
1. User navigates to verification page
2. User receives email with verification code
3. User enters code from email
4. User clicks "Verify Email"
5. System validates code format
6. System checks code exists and not expired
7. System checks attempt count < 5
8. System verifies code matches user's email code
9. System marks email as verified
10. System invalidates verification code
11. System creates audit log entry
12. System displays success message
13. System checks if account fully verified

**Success**:
- Email marked as verified in database
- Verification code marked as used
- Success message displayed
- Green checkmark shown
- Audit log entry created

**Errors**:
- Invalid format: "Please enter a 6-digit code"
- Code not found: "Invalid verification code"
- Code expired: "This code has expired. Please request a new one."
- Too many attempts: "Too many failed attempts. Please request a new code."
- Code already used: "This code has already been used"

### FR-7: Phone Verification Process

**Workflow**: Same as email verification, but for phone

**Success**:
- Phone marked as verified in database
- Verification code marked as used
- Success message displayed
- Green checkmark shown
- Audit log entry created

**Errors**: Same as email verification

### FR-8: Resend Verification Code

**Email Resend**:
- User clicks "Resend Email Code"
- System invalidates previous email code
- System generates new email code
- System sends new verification email
- System creates audit log entry
- System displays "New code sent to your email"
- No rate limiting (email is cheap)

**SMS Resend**:
- User clicks "Resend SMS Code"
- System checks rate limit (3 per hour)
- If rate limit OK:
  - System invalidates previous phone code
  - System generates new phone code
  - System sends new SMS
  - System creates audit log entry
  - System displays "New code sent to your phone"
- If rate limited:
  - System displays "You can request a new code in X minutes"
  - Show countdown timer

### FR-9: Account Activation

**Description**: Activate user account after successful verification.

**Activation Requirements**:
- Email must be verified (required)
- Phone verification optional (configurable)

**Activation Process**:
1. User completes required verifications
2. System checks all requirements met
3. System updates user account status to "Active"
4. System sets IsVerified = true
5. System creates audit log entry
6. System sends welcome email
7. System redirects to login page with success message

**Partial Verification**:
- If only email required: Activate after email verified
- If both required: Activate only after both verified
- If phone optional: Activate after email, show phone as optional

### FR-10: Verification Reminder Emails

**Description**: Send reminder emails to users who haven't verified.

**Reminder Schedule**:
- 6 hours after registration
- 24 hours after registration
- 3 days after registration
- 7 days after registration
- Then weekly for 4 weeks
- After 30 days: Account marked for deletion (configurable)

**Reminder Email Template**:
```
Subject: Please Verify Your Email - OoBDev Gateway

Dear [FirstName],

You registered for OoBDev Gateway [X] ago, but haven't verified your email address yet.

To activate your account and start using OoBDev Gateway, please verify your email by entering this code:

Verification Code: 123456

This code expires in 24 hours.

Verify now: [Link to verification page]

If you're having trouble, contact support at support@itrica.com.

Thank you,
OoBDev Gateway Team
```

### FR-11: Audit Trail

**Description**: Log all verification events for compliance.

**Logged Events**:

| Event | Audit Action | Audit Details | Additional Info |
|-------|--------------|---------------|-----------------|
| Email code generated | AccountVerification | Email_Code_Generated | Email (hashed), IP, timestamp |
| Phone code generated | AccountVerification | Phone_Code_Generated | Phone (last 4), IP, timestamp |
| Email code sent | AccountVerification | Email_Code_Sent | Email (hashed), timestamp |
| SMS sent | AccountVerification | SMS_Code_Sent | Phone (last 4), timestamp |
| Email verified success | AccountVerification | Email_Verified_Success | IP, timestamp, attempts |
| Phone verified success | AccountVerification | Phone_Verified_Success | IP, timestamp, attempts |
| Verification failed | AccountVerification | Verification_Failed | Failure reason, IP, attempts |
| Code resend requested | AccountVerification | Code_Resend_Requested | Code type, IP, timestamp |
| Account activated | AccountVerification | Account_Activated | Timestamp, IP |

---

## Non-Functional Requirements

### NFR-1: Security

**Code Security**:
- Cryptographically secure random generation
- Sufficient entropy (6 digits = 1 million possibilities)
- Time-limited validity
- One-time use enforcement
- Attempt rate limiting

**Transmission Security**:
- Email sent over TLS
- SMS sent over secure gateway connection
- Codes never logged in plain text
- Verification page requires HTTPS

**Protection Against Attacks**:
- Brute force protection (attempt limiting)
- Rate limiting on code generation
- CAPTCHA on resend (for SMS)
- Session validation on verification page

### NFR-2: Performance

- Code generation: <100ms
- Email queuing: <1 second
- SMS sending: <10 seconds
- Verification check: <200ms
- Page load: <1 second

### NFR-3: Reliability

**Email Delivery**:
- Retry failed emails (3 attempts)
- Log delivery failures
- Provide resend mechanism
- Queue-based delivery (survives restarts)

**SMS Delivery**:
- Retry failed SMS (2 attempts)
- Log delivery failures
- Provide resend mechanism
- Handle gateway timeouts gracefully

**Code Persistence**:
- Codes survive application restart
- Stored in database (not memory)
- Expiration checked on verification

### NFR-4: Compliance (21 CFR Part 11)

**Audit Trail**:
- All verification events logged
- Timestamp all events (UTC)
- Capture IP address
- Tamper-proof logs

**Data Integrity**:
- Verification status accurately tracked
- Account activation only after successful verification
- No manual override (without admin approval)

### NFR-5: Usability

- Clear instructions on verification page
- Time remaining displayed
- Easy code entry (auto-format, auto-submit)
- Clear error messages
- Mobile-friendly interface
- Resend option clearly visible
- Progress indication

### NFR-6: Cost Management

**SMS Cost Control**:
- Aggressive rate limiting
- CAPTCHA before resend
- Monitor for abuse patterns
- Alert on unusual volume
- Consider phone verification optional

---

## User Interface

### Verification Page

```
┌─────────────────────────────────────────────────────────┐
│ Verify Your Account                                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ To complete your registration, please verify your      │
│ email address and phone number.                         │
│                                                         │
│ ┌─────────────────────────────────────────────────┐   │
│ │ Email Verification                          ✓   │   │
│ ├─────────────────────────────────────────────────┤   │
│ │                                                 │   │
│ │ A verification code has been sent to:           │   │
│ │ john.doe@example.com                            │   │
│ │                                                 │   │
│ │ Enter the 6-digit code from your email:         │   │
│ │                                                 │   │
│ │ [1][2][3][4][5][6]                              │   │
│ │                                                 │   │
│ │ Code expires in: 23 hours 45 minutes            │   │
│ │                                                 │   │
│ │                          [Verify Email]         │   │
│ │                                                 │   │
│ │ Didn't receive the email? [Resend Code]         │   │
│ └─────────────────────────────────────────────────┘   │
│                                                         │
│ ┌─────────────────────────────────────────────────┐   │
│ │ Phone Verification                          ⏳  │   │
│ ├─────────────────────────────────────────────────┤   │
│ │                                                 │   │
│ │ An SMS verification code has been sent to:      │   │
│ │ (555) ***-4567                                  │   │
│ │                                                 │   │
│ │ Enter the 6-digit code from your SMS:           │   │
│ │                                                 │   │
│ │ [_][_][_][_][_][_]                              │   │
│ │                                                 │   │
│ │ Code expires in: 28 minutes                     │   │
│ │                                                 │   │
│ │                          [Verify Phone]         │   │
│ │                                                 │   │
│ │ Didn't receive the SMS? [Resend Code]           │   │
│ │ (You can request a new code 2 more times)       │   │
│ └─────────────────────────────────────────────────┘   │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

### Verification Success

```
┌─────────────────────────────────────────────────────────┐
│ ✓ Account Verified Successfully                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Congratulations! Your account has been verified and    │
│ activated.                                              │
│                                                         │
│ ✓ Email verified: john.doe@example.com                  │
│ ✓ Phone verified: (555) 123-4567                        │
│                                                         │
│ You can now log in to OoBDev Gateway with your         │
│ username and password.                                  │
│                                                         │
│                                      [Continue to Login]│
└─────────────────────────────────────────────────────────┘
```

---

## API Endpoints

### GET /Account/Verify
**Description**: Display verification page
**Authorization**: Registered unverified user (session required)
**Returns**: Verification page with current verification status

### POST /Account/VerifyEmail
**Description**: Verify email with code
**Authorization**: Registered unverified user

**Request Body**:
```json
{
  "Code": "123456"
}
```

**Success Response** (200 OK):
```json
{
  "Success": true,
  "Message": "Email verified successfully",
  "EmailVerified": true,
  "PhoneVerified": false,
  "AccountActivated": false
}
```

**Error Response** (400 Bad Request):
```json
{
  "Success": false,
  "Message": "Invalid verification code",
  "AttemptsRemaining": 3
}
```

### POST /Account/VerifyPhone
**Description**: Verify phone with code
**Authorization**: Registered unverified user

**Request/Response**: Same as VerifyEmail

### POST /Account/ResendEmailCode
**Description**: Resend email verification code
**Authorization**: Registered unverified user

**Success Response** (200 OK):
```json
{
  "Success": true,
  "Message": "A new verification code has been sent to your email",
  "ExpiresAt": "2026-01-14T15:30:00Z"
}
```

### POST /Account/ResendPhoneCode
**Description**: Resend SMS verification code
**Authorization**: Registered unverified user

**Success Response** (200 OK):
```json
{
  "Success": true,
  "Message": "A new verification code has been sent to your phone",
  "ExpiresAt": "2026-01-13T16:00:00Z",
  "RemainingResends": 2
}
```

**Rate Limited Response** (429 Too Many Requests):
```json
{
  "Success": false,
  "Message": "Too many requests. Please try again in 45 minutes",
  "RetryAfter": 2700
}
```

---

## Data Model

### VerificationCodes Table

```sql
CREATE TABLE VerificationCodes (
    VerificationCodeID  INT IDENTITY(1,1) PRIMARY KEY,
    UserId             UNIQUEIDENTIFIER NOT NULL,
    CodeType           NVARCHAR(20) NOT NULL, -- 'Email' or 'Phone'
    Code               NVARCHAR(10) NOT NULL,
    ExpiresAt          DATETIME2 NOT NULL,
    CreatedAt          DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    AttemptCount       INT NOT NULL DEFAULT 0,
    MaxAttempts        INT NOT NULL DEFAULT 5,
    IsUsed             BIT NOT NULL DEFAULT 0,
    UsedAt             DATETIME2 NULL,
    IPAddress          NVARCHAR(50) NULL,

    CONSTRAINT FK_VerificationCodes_User
        FOREIGN KEY (UserId) REFERENCES AspNetUsers(UserId),
    CONSTRAINT CK_VerificationCodes_Type
        CHECK (CodeType IN ('Email', 'Phone'))
)

CREATE INDEX IX_VerificationCodes_UserId ON VerificationCodes(UserId)
CREATE INDEX IX_VerificationCodes_Code ON VerificationCodes(Code)
CREATE INDEX IX_VerificationCodes_Expires ON VerificationCodes(ExpiresAt)
CREATE INDEX IX_VerificationCodes_Type ON VerificationCodes(CodeType)
```

### AspNetUsers Updates

```sql
ALTER TABLE AspNetUsers ADD
    EmailVerified       BIT NOT NULL DEFAULT 0,
    EmailVerifiedDate   DATETIME2 NULL,
    PhoneVerified       BIT NOT NULL DEFAULT 0,
    PhoneVerifiedDate   DATETIME2 NULL,
    IsVerified          BIT NOT NULL DEFAULT 0,
    VerifiedDate        DATETIME2 NULL
```

---

## Business Rules

### BR-1: Code Generation
- Codes must be cryptographically random
- Email and phone codes must be different
- Codes must be unique across active codes
- Expired codes can be reused

### BR-2: Code Expiration
- Email codes expire after 24 hours
- Phone codes expire after 30 minutes
- Expired codes cannot be used for verification
- New code invalidates previous code

### BR-3: Attempt Limiting
- Maximum 5 attempts per email code
- Maximum 3 attempts per phone code
- Exceeded attempts requires new code
- Attempts reset on new code generation

### BR-4: Rate Limiting
- Email resend: No limit
- Phone resend: 3 per hour per phone number
- Phone resend: 10 per hour per IP address
- Cooldown: 2 minutes between SMS

### BR-5: Account Activation
- Email verification required
- Phone verification optional (configurable)
- Account activated when requirements met
- Activation date recorded

### BR-6: Unverified Account Cleanup
- Reminder emails sent at intervals
- After 30 days: Account marked for deletion
- Grace period: 7 days before actual deletion
- Final warning email sent

---

## User Workflows

### Workflow: Email and Phone Verification

```
[User] → Completes registration
           ↓
       [System] Sends email verification code
           ↓
       [System] Sends SMS verification code
           ↓
       Redirect to /Account/Verify
           ↓
       [User] Receives email (check inbox)
           ↓
       [User] Receives SMS (check phone)
           ↓
       [User] Enters email code on verify page
           ↓
       [User] Clicks "Verify Email"
           ↓
       [System] Validates email code ✓
           ↓
       [System] Marks email as verified
           ↓
       [System] Shows success for email
           ↓
       [User] Enters phone code
           ↓
       [User] Clicks "Verify Phone"
           ↓
       [System] Validates phone code ✓
           ↓
       [System] Marks phone as verified
           ↓
       [System] Activates account (both verified)
           ↓
       [System] Sends welcome email
           ↓
       [System] Shows success message
           ↓
       Redirect to /Account/Login
           ↓
       [User] Logs in with credentials
```

---

## Testing Requirements

### Unit Tests
- Code generation (uniqueness, format)
- Code validation logic
- Expiration checking
- Attempt counting
- Rate limiting logic

### Integration Tests
- Email sending
- SMS sending
- Code verification workflow
- Account activation
- Resend functionality

### Security Tests
- Brute force protection
- Rate limiting enforcement
- Code reuse prevention
- Session validation
- Timing attack resistance

---

## Acceptance Criteria

### AC-1: Email Verification
- ✅ Email code generated and sent
- ✅ User can verify email with code
- ✅ Email marked as verified
- ✅ Audit log created
- ✅ Success message displayed

### AC-2: Phone Verification
- ✅ SMS code generated and sent
- ✅ User can verify phone with code
- ✅ Phone marked as verified
- ✅ Audit log created
- ✅ Success message displayed

### AC-3: Code Expiration
- ✅ Expired codes rejected
- ✅ Clear expiration message
- ✅ Resend option available

### AC-4: Rate Limiting
- ✅ SMS rate limit enforced
- ✅ Clear rate limit message
- ✅ Countdown timer shown

### AC-5: Account Activation
- ✅ Account activated after verification
- ✅ User can log in
- ✅ Welcome email sent

---

## Dependencies

### Internal Dependencies
- Self Registration feature
- Email service (message queue)
- Audit logging system

### External Dependencies
- SMTP server (email delivery)
- SMS gateway (Twilio, AWS SNS, etc.)
- Database (SQL Server)

---

## Related Features

- [Self Registration](./self-registration.md) - Work Item #577
- [Password Recovery](./password-recovery.md) - Work Item #574 (uses verified email/phone)
- [Manage Profile](./manage-profile.md) - Work Item #573

---

## References

### Architecture Documentation
- [Gateway Use Cases](/current/src/docs/architecture/gateway/use-cases.md)
- [Messaging Architecture](/current/src/docs/architecture/messaging/README.md)

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
