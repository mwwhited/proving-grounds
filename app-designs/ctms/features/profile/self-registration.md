# Feature Specification: Self Registration

**Work Item**: #577
**Feature Area**: Profile Management
**User Role**: Anonymous User (Pre-Authentication)
**Priority**: High
**Status**: Active

---

## Overview

The Self Registration feature enables new users to create their own accounts without requiring administrator intervention. This feature implements a multi-step registration process including account creation, email/phone verification, and initial profile setup to ensure valid user identities while maintaining security and compliance requirements.

### Business Context

Self-service registration is critical for:
- Reducing administrative burden for user onboarding
- Enabling rapid trial site staff enrollment
- Ensuring valid contact information through verification
- Meeting regulatory requirements for user identification
- Providing audit trail for account creation

---

## User Stories

### Primary User Story

**As a** new clinical trial staff member
**I want to** create my own account
**So that** I can access the OoBDev Gateway system without waiting for administrator provisioning

### Secondary User Stories

**As a** System Administrator
**I want to** new users to verify their email and phone
**So that** we have valid contact information for all users

**As a** Compliance Officer
**I want to** audit all account creation events
**So that** we can demonstrate proper user onboarding procedures

**As a** Security Administrator
**I want to** require strong passwords during registration
**So that** accounts are protected from the moment of creation

---

## Functional Requirements

### FR-1: Registration Form

**Description**: Provide a public registration form for new users.

**URL**: `/Account/Register`

**Access**: Public (anonymous users)

**Form Fields**:

| Field Name | Type | Validation | Max Length | Description |
|------------|------|------------|------------|-------------|
| Username | Text | Required, unique, alphanumeric | 50 | Unique username for login |
| Email Address | Email | Required, valid format, unique | 255 | Primary email for notifications |
| Phone Number | Phone | Required, valid format | 20 | Primary contact phone |
| First Name | Text | Required, not whitespace | 100 | User's first name |
| Last Name | Text | Required, not whitespace | 100 | User's last name |
| Password | Password | Required, complexity rules | 100 | Account password |
| Confirm Password | Password | Required, must match password | 100 | Password confirmation |
| Security Question 1 | Dropdown | Required | 500 | First security question |
| Security Answer 1 | Text | Required, not whitespace | 200 | Answer to first question |
| Security Question 2 | Dropdown | Optional | 500 | Second security question |
| Security Answer 2 | Text | Required if Q2 selected | 200 | Answer to second question |
| Terms of Service | Checkbox | Must be checked | N/A | Acceptance of terms |

### FR-2: Username Validation

**Description**: Ensure usernames are valid and unique.

**Validation Rules**:
- Required (not empty or whitespace)
- Minimum length: 3 characters
- Maximum length: 50 characters
- Allowed characters: letters, numbers, underscore, hyphen, period
- Must start with letter or number
- Case-insensitive uniqueness check
- Cannot be reserved word (admin, system, root, etc.)

**Reserved Usernames**:
- admin, administrator, root, system
- support, helpdesk, webmaster
- guest, test, demo

**Error Messages**:
- Empty: "Username is required"
- Too short: "Username must be at least 3 characters"
- Invalid characters: "Username can only contain letters, numbers, underscore, hyphen, and period"
- Already exists: "This username is already taken"
- Reserved: "This username is not available"

### FR-3: Email Validation and Uniqueness

**Description**: Validate email format and ensure uniqueness.

**Validation Rules**:
- Required (not empty)
- Valid email format (RFC 5322)
- Maximum length: 255 characters
- Case-insensitive uniqueness check
- Cannot be from disposable email domain (optional)

**Email Format Validation**:
- Must contain single @ symbol
- Domain must have at least one period
- Valid characters before @: letters, numbers, .-_+
- Valid domain characters: letters, numbers, .-

**Disposable Email Blocking** (Optional):
Block known disposable email providers:
- mailinator.com, guerrillamail.com, 10minutemail.com, etc.
- Configurable blocklist

**Error Messages**:
- Empty: "Email address is required"
- Invalid format: "Please enter a valid email address"
- Already exists: "An account with this email address already exists"
- Disposable: "Please use a permanent email address"

### FR-4: Phone Validation

**Description**: Validate phone number format.

**Validation Rules**:
- Required (not empty)
- Minimum length: 10 digits (after removing formatting)
- Maximum length: 20 characters
- Allowed characters: digits, spaces, parentheses, hyphens, plus sign
- Normalized before storage: +1234567890 format

**Accepted Formats**:
- (555) 123-4567
- 555-123-4567
- 5551234567
- +1 555 123 4567
- +15551234567

**Normalization**:
- Remove all formatting characters
- Prepend country code if missing (default: +1 for US)
- Store in E.164 format: +15551234567

**Error Messages**:
- Empty: "Phone number is required"
- Invalid format: "Please enter a valid phone number"
- Too short: "Phone number must be at least 10 digits"

### FR-5: Password Requirements

**Description**: Enforce strong password during registration.

**Password Complexity** (Same as Change Password):
- Minimum length: 8 characters
- Maximum length: 100 characters
- At least one uppercase letter (A-Z)
- At least one lowercase letter (a-z)
- At least one digit (0-9)
- At least one special character (!@#$%^&*)
- Cannot contain username
- Cannot be common password (optional)

**Password Confirmation**:
- Must exactly match password
- Case-sensitive comparison

**Common Password Check** (Optional):
Block passwords from breach databases:
- password, 123456, qwerty, etc.
- Configurable list or API integration

### FR-6: Security Questions

**Description**: Require security questions for password recovery.

**Requirements**:
- At least one security question required
- Question 1 and Answer 1 mandatory
- Question 2 and Answer 2 optional (but both or neither)
- Same question cannot be selected twice
- Answers stored hashed (not plain text)

**Available Questions**:
1. What is your mother's maiden name?
2. What city were you born in?
3. What is the name of your first pet?
4. What is your favorite color?
5. What is the name of the street you grew up on?
6. What is your father's middle name?
7. What was the make of your first car?
8. What is your favorite food?

### FR-7: Terms of Service Acceptance

**Description**: Require acceptance of terms before registration.

**Requirements**:
- Checkbox must be checked to submit form
- Link to full terms of service document
- Timestamp of acceptance recorded
- Version of terms accepted recorded
- Cannot proceed without acceptance

**Error Message**: "You must accept the Terms of Service to register"

### FR-8: Registration Process

**Workflow**:
1. User navigates to registration page
2. User fills out registration form
3. User accepts terms of service
4. User submits form
5. System validates all fields (server-side)
6. System checks username uniqueness
7. System checks email uniqueness
8. System creates user account (inactive status)
9. System creates MyInfo profile record
10. System generates email verification code
11. System generates phone verification code
12. System sends verification email
13. System sends verification SMS (optional)
14. System creates audit log entry
15. System redirects to verification page
16. User enters verification codes
17. System activates account
18. User redirected to login page

**Account States**:
- **Registered**: Account created, awaiting verification
- **Verified**: Email/phone verified, account active
- **Active**: Fully activated and usable

### FR-9: Email Verification

**Description**: Verify user's email address before account activation.

**See**: [Account Verification](./account-verification.md) for detailed specification

**Summary**:
- Verification code sent to registered email
- Code valid for 24 hours
- User must enter code to activate account
- Resend option available
- Account remains inactive until verified

### FR-10: Phone Verification (Optional)

**Description**: Verify user's phone number via SMS.

**See**: [Account Verification](./account-verification.md) for detailed specification

**Summary**:
- SMS with verification code sent to phone
- Code valid for 30 minutes
- User must enter code to complete verification
- Resend option available (with rate limiting)

### FR-11: Duplicate Account Prevention

**Description**: Prevent duplicate accounts for same person.

**Detection Methods**:
- Username uniqueness (case-insensitive)
- Email uniqueness (case-insensitive)
- Phone number uniqueness (after normalization)

**Behavior**:
- Check during form validation
- Clear error message indicating which field is duplicate
- Do NOT reveal if email/phone is already registered (security)
- Alternative message: "If this email is already registered, please use password recovery"

### FR-12: Audit Trail

**Description**: Log all registration attempts for compliance.

**Logged Events**:

| Event | Audit Action | Audit Details | Additional Info |
|-------|--------------|---------------|-----------------|
| Registration started | UserManagement | Registration_Initiated | IP address, timestamp |
| Registration successful | UserManagement | Registration_Success | Username, email, IP, timestamp |
| Registration failed - duplicate username | UserManagement | Registration_Failed_Duplicate_Username | Username attempted, IP |
| Registration failed - duplicate email | UserManagement | Registration_Failed_Duplicate_Email | Email attempted (hashed), IP |
| Registration failed - validation | UserManagement | Registration_Failed_Validation | Validation errors, IP |
| Email verification sent | UserManagement | Verification_Email_Sent | Email address, timestamp |
| Phone verification sent | UserManagement | Verification_SMS_Sent | Phone (last 4 digits), timestamp |
| Account verified | UserManagement | Account_Verified | Username, verification method |

### FR-13: CAPTCHA Protection (Optional)

**Description**: Prevent automated bot registrations.

**Implementation Options**:
- Google reCAPTCHA v2 or v3
- hCaptcha
- Custom CAPTCHA

**Behavior**:
- CAPTCHA required on registration form
- Verification before processing registration
- Failed CAPTCHA blocks registration
- Configurable difficulty level

---

## Non-Functional Requirements

### NFR-1: Security

**Data Protection**:
- All data transmitted over HTTPS
- Password hashed before storage (bcrypt/PBKDF2)
- Security answers hashed before storage
- Email verification codes cryptographically random
- Phone verification codes cryptographically random

**Rate Limiting**:
- Maximum 5 registration attempts per IP per hour
- Maximum 3 verification code requests per email per hour
- CAPTCHA after failed attempts

**Protection Against Attacks**:
- SQL injection prevention (parameterized queries)
- XSS prevention (output encoding)
- CSRF protection on form submission
- Email enumeration prevention
- Account enumeration prevention

### NFR-2: Performance

- Registration form load within 1 second
- Form validation within 100ms
- Account creation within 2 seconds
- Verification email sent within 5 seconds
- Verification SMS sent within 10 seconds

### NFR-3: Compliance (21 CFR Part 11)

**Electronic Records**:
- Complete audit trail of registration events
- Timestamp all actions (UTC)
- Capture user identity (IP, email, username)
- Terms of service acceptance recorded

**Data Integrity**:
- Validation at all layers
- Transaction support for multi-table operations
- Referential integrity enforced

### NFR-4: Usability

- Mobile-responsive design
- Clear field labels and help text
- Real-time validation feedback
- Password strength indicator
- Clear error messages
- Progress indication for multi-step process
- Accessible (WCAG 2.1 AA)

### NFR-5: Availability

- Registration service available 99.9%
- Graceful degradation if email service down
- Clear error messages for service failures
- Retry mechanism for transient failures

---

## User Interface

### Registration Form

```
┌─────────────────────────────────────────────────────────┐
│ Create Your Account                                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Account Information                                     │
│                                                         │
│ Username:       * [____________________]                │
│                   (3-50 characters, letters and numbers)│
│                                                         │
│ Email Address:  * [____________________]                │
│                   (Used for notifications and recovery) │
│                                                         │
│ Phone Number:   * [____________________]                │
│                   (Primary contact number)              │
│                                                         │
│ Personal Information                                    │
│                                                         │
│ First Name:     * [____________________]                │
│                                                         │
│ Last Name:      * [____________________]                │
│                                                         │
│ Password                                                │
│                                                         │
│ Password:       * [••••••••••••••••••]                  │
│                   Password Strength: [████░░░░] Medium  │
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
│ Security Questions (for password recovery)              │
│                                                         │
│ Question 1:     * [▼ Select a question ▼▼▼▼▼▼▼]        │
│ Answer 1:       * [____________________]                │
│                                                         │
│ Question 2:       [▼ Select a question (optional) ▼▼▼]  │
│ Answer 2:         [____________________]                │
│                                                         │
│ Terms of Service                                        │
│                                                         │
│ □ I agree to the [Terms of Service] and [Privacy       │
│   Policy]                                               │
│                                                         │
│ [reCAPTCHA verification box]                            │
│                                                         │
│                              [Cancel]  [Create Account] │
└─────────────────────────────────────────────────────────┘

* Required field
```

### Registration Success Page

```
┌─────────────────────────────────────────────────────────┐
│ ✓ Registration Successful                                │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Welcome, John!                                          │
│                                                         │
│ Your account has been created successfully.             │
│                                                         │
│ Before you can log in, you need to verify your email   │
│ address and phone number.                               │
│                                                         │
│ Verification Steps:                                     │
│                                                         │
│ 1. Check your email                                     │
│    We sent a verification code to:                      │
│    john.doe@example.com                                 │
│                                                         │
│ 2. Check your phone                                     │
│    We sent an SMS verification code to:                 │
│    (555) ***-4567                                       │
│                                                         │
│ 3. Enter the verification codes on the next page        │
│                                                         │
│ Didn't receive the codes? They should arrive within    │
│ a few minutes. You can request new codes on the         │
│ verification page.                                      │
│                                                         │
│                                     [Continue to Verify]│
└─────────────────────────────────────────────────────────┘
```

---

## API Endpoints

### GET /Account/Register
**Description**: Display registration form
**Authorization**: Anonymous (public)
**Returns**: Registration form view

### POST /Account/Register
**Description**: Process registration request
**Authorization**: Anonymous (public)

**Request Body**: RegisterModel
```json
{
  "Username": "string",
  "EmailAddress": "string",
  "PhoneNumber": "string",
  "FirstName": "string",
  "LastName": "string",
  "Password": "string",
  "ConfirmPassword": "string",
  "SecurityQuestion1": "string",
  "SecurityAnswer1": "string",
  "SecurityQuestion2": "string",
  "SecurityAnswer2": "string",
  "AcceptTerms": true,
  "RecaptchaToken": "string"
}
```

**Success Response** (302 Redirect):
- Redirect to `/Account/Verify`
- User ID in session/cookie for verification

**Error Response** (400 Bad Request):
```json
{
  "ModelState": {
    "Username": ["This username is already taken"],
    "EmailAddress": ["Please enter a valid email address"],
    "Password": ["Password must contain at least one special character"]
  }
}
```

### POST /Account/CheckUsernameAvailability
**Description**: AJAX endpoint to check username availability
**Authorization**: Anonymous
**Request**: `{ "username": "string" }`
**Response**: `{ "available": true/false }`

### POST /Account/CheckEmailAvailability
**Description**: AJAX endpoint to check email availability
**Authorization**: Anonymous
**Request**: `{ "email": "string" }`
**Response**: `{ "available": true/false, "message": "string" }`

---

## Data Model

### AspNetUsers Table (Membership)

```sql
-- Standard ASP.NET Membership table
-- Additional fields:
ALTER TABLE AspNetUsers ADD
    IsVerified       BIT NOT NULL DEFAULT 0,
    EmailVerified    BIT NOT NULL DEFAULT 0,
    PhoneVerified    BIT NOT NULL DEFAULT 0,
    RegistrationDate DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    RegistrationIP   NVARCHAR(50) NULL
```

### MyInfo Table

```sql
-- Profile information created during registration
-- See: manage-profile.md for full schema
```

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
    IsUsed             BIT NOT NULL DEFAULT 0,
    UsedAt             DATETIME2 NULL,

    CONSTRAINT FK_VerificationCodes_User
        FOREIGN KEY (UserId) REFERENCES AspNetUsers(UserId)
)

CREATE INDEX IX_VerificationCodes_UserId ON VerificationCodes(UserId)
CREATE INDEX IX_VerificationCodes_Code ON VerificationCodes(Code)
CREATE INDEX IX_VerificationCodes_Expires ON VerificationCodes(ExpiresAt)
```

### TermsAcceptance Table

```sql
CREATE TABLE TermsAcceptance (
    TermsAcceptanceID  INT IDENTITY(1,1) PRIMARY KEY,
    UserId            UNIQUEIDENTIFIER NOT NULL,
    TermsVersion      NVARCHAR(20) NOT NULL,
    AcceptedDate      DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    IPAddress         NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_TermsAcceptance_User
        FOREIGN KEY (UserId) REFERENCES AspNetUsers(UserId)
)

CREATE INDEX IX_TermsAcceptance_UserId ON TermsAcceptance(UserId)
```

---

## Business Rules

### BR-1: Account Creation
- All required fields must be provided
- Email and username must be unique (case-insensitive)
- Password must meet complexity requirements
- Terms of service must be accepted

### BR-2: Verification Requirement
- Account created in inactive state
- Email must be verified before login
- Phone verification optional but recommended
- Verification codes expire after time limit

### BR-3: Username Rules
- Must be unique (case-insensitive)
- 3-50 characters
- Alphanumeric plus underscore, hyphen, period
- Must start with letter or number
- Cannot be reserved word

### BR-4: Email Rules
- Must be unique (case-insensitive)
- Valid email format
- Maximum 255 characters
- Disposable emails blocked (if configured)

### BR-5: Profile Initialization
- MyInfo profile created during registration
- All profile fields populated from registration form
- Security answers stored hashed
- Profile marked as complete (no enforcement needed)

---

## User Workflows

### Workflow: Complete Self Registration

```
[User] → Navigate to /Account/Register
           ↓
       [System] Display registration form
           ↓
       [User] Fills out form
           ↓
       [User] Checks "Accept Terms"
           ↓
       [User] Completes CAPTCHA
           ↓
       [User] Clicks "Create Account"
           ↓
       [System] Validates all fields
           ↓
       [System] Checks username uniqueness ✓
           ↓
       [System] Checks email uniqueness ✓
           ↓
       [System] Creates user account (inactive)
           ↓
       [System] Creates MyInfo profile
           ↓
       [System] Records terms acceptance
           ↓
       [System] Generates email verification code
           ↓
       [System] Generates phone verification code
           ↓
       [System] Sends verification email
           ↓
       [System] Sends verification SMS
           ↓
       [System] Creates audit log entries
           ↓
       Redirect to /Account/Verify
           ↓
       [User] Enters verification codes
           ↓
       [System] Validates codes
           ↓
       [System] Activates account
           ↓
       [System] Creates audit log (verified)
           ↓
       Redirect to /Account/Login
           ↓
       [User] Logs in with new account
```

---

## Error Handling

### Validation Errors

See individual field requirements above for specific error messages.

### System Errors

| Error Condition | User Message | Technical Action |
|----------------|--------------|------------------|
| Database unavailable | "Unable to create account. Please try again later." | Log error, alert operations |
| Email service down | "Account created but verification email could not be sent. Click here to resend." | Log warning, allow resend |
| SMS service down | "Account created but verification SMS could not be sent. Click here to resend." | Log warning, allow resend |
| Duplicate key error | "This username or email is already in use." | Log warning, show appropriate error |

---

## Security Considerations

### Account Enumeration Prevention
- Don't reveal if email already exists
- Use generic message: "If this email is registered, you'll receive a password reset link"
- Same timing for success/failure responses

### Bot Protection
- CAPTCHA on registration form
- Rate limiting per IP address
- Honeypot fields (hidden fields that bots fill)

### Verification Security
- Cryptographically random verification codes
- Time-limited codes
- One-time use codes
- Rate limiting on verification attempts

### Data Protection
- Password hashed immediately
- Security answers hashed
- Sensitive data transmitted over HTTPS only
- PII logged in hashed form only

---

## Testing Requirements

### Unit Tests
- All validation rules
- Username uniqueness check
- Email uniqueness check
- Password complexity validation
- Security question validation
- Terms acceptance validation

### Integration Tests
- Complete registration workflow
- Verification code generation
- Email sending
- SMS sending (if implemented)
- Account creation in database
- Profile creation in database

### Security Tests
- SQL injection attempts
- XSS attempts
- CSRF protection
- Rate limiting enforcement
- CAPTCHA bypass attempts
- Account enumeration attempts

### UI Tests
- Form validation
- Error message display
- Success flow
- Real-time username availability check
- Password strength indicator

---

## Acceptance Criteria

### AC-1: Account Creation
- ✅ User can create account with valid information
- ✅ Account created in database (inactive state)
- ✅ Profile created in database
- ✅ Terms acceptance recorded
- ✅ Audit log entries created

### AC-2: Validation
- ✅ All required fields enforced
- ✅ Username uniqueness enforced
- ✅ Email uniqueness enforced
- ✅ Password complexity enforced
- ✅ Security questions required
- ✅ Terms acceptance required

### AC-3: Verification
- ✅ Verification email sent
- ✅ Verification SMS sent (if configured)
- ✅ Account remains inactive until verified
- ✅ User cannot login until verified

### AC-4: Security
- ✅ HTTPS required
- ✅ CAPTCHA protection
- ✅ Password hashed
- ✅ Security answers hashed
- ✅ Rate limiting enforced

### AC-5: Audit Trail
- ✅ Registration logged
- ✅ Verification events logged
- ✅ IP address captured
- ✅ Timestamp captured

---

## Dependencies

### Internal Dependencies
- ASP.NET Membership Provider
- MyInfo service
- Email service (message queue)
- SMS service (if implemented)
- Audit logging system

### External Dependencies
- Database (SQL Server)
- SMTP server
- SMS gateway (Twilio, AWS SNS, etc.)
- CAPTCHA service (Google reCAPTCHA, hCaptcha)

---

## Related Features

- [Account Verification](./account-verification.md) - Email/phone verification
- [Manage Profile](./manage-profile.md) - Work Item #573
- [Password Recovery](./password-recovery.md) - Work Item #574

---

## References

### Architecture Documentation
- [Gateway Use Cases](/current/src/docs/architecture/gateway/use-cases.md)
- [Messaging Architecture](/current/src/docs/architecture/messaging/README.md)

### Work Items
- TFS Work Item #577: Self Register
- TFS Server: tfscorp.itrica.com\ITRICA
- Collection ID: 04150b45-2081-4a9f-89f8-b188e6a7a0a4

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
