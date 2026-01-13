# Gateway (Core) - Entity Relationship Diagram

## Overview

The Gateway module provides the core authentication, authorization, user management, and multi-tenancy infrastructure for the OoBDev Clinical Trial Management System.

## Database Schema

### Technology Stack
- **Database**: Microsoft SQL Server 2012+
- **ORM**: Entity Framework 6.x / EF Core
- **Authentication**: ASP.NET Identity / ASP.NET Membership
- **Audit Compliance**: 21 CFR Part 11

---

## Entity Relationship Diagram (PlantUML)

```plantuml
@startuml Gateway ERD
!define Table(name,desc) class name as "desc" << (T,#FFAAAA) >>
!define primary_key(x) <b>x</b>
!define foreign_key(x) <i>x</i>
!define unique(x) <u>x</u>

skinparam class {
  BackgroundColor<<(T,#FFAAAA)>> #FFE4E1
  BorderColor<<(T,#FFAAAA)>> #8B0000
  ArrowColor #696969
}

' ============================================================
' AUTHENTICATION & USERS
' ============================================================

class AspNetUsers {
  primary_key(Id) : uniqueidentifier
  --
  unique(UserName) : nvarchar(256)
  unique(Email) : nvarchar(256)
  EmailConfirmed : bit
  PasswordHash : nvarchar(MAX)
  SecurityStamp : nvarchar(MAX)
  PhoneNumber : nvarchar(50)
  PhoneNumberConfirmed : bit
  TwoFactorEnabled : bit
  LockoutEndDateUtc : datetime
  LockoutEnabled : bit
  AccessFailedCount : int
  CreatedDate : datetime
  LastLoginDate : datetime
  LastPasswordChangedDate : datetime
  LastLockoutDate : datetime
  IsApproved : bit
  IsLockedOut : bit
  Comment : nvarchar(MAX)
}

class AspNetRoles {
  primary_key(Id) : uniqueidentifier
  --
  unique(Name) : nvarchar(256)
  Description : nvarchar(500)
  IsSystemRole : bit
  CreatedDate : datetime
}

class AspNetUserRoles {
  primary_key(UserId, RoleId)
  --
  foreign_key(UserId) : uniqueidentifier
  foreign_key(RoleId) : uniqueidentifier
  AssignedDate : datetime
  foreign_key(AssignedBy) : uniqueidentifier
}

class AspNetUserClaims {
  primary_key(Id) : int
  --
  foreign_key(UserId) : uniqueidentifier
  ClaimType : nvarchar(MAX)
  ClaimValue : nvarchar(MAX)
}

class AspNetUserLogins {
  primary_key(LoginProvider, ProviderKey, UserId)
  --
  LoginProvider : nvarchar(128)
  ProviderKey : nvarchar(128)
  foreign_key(UserId) : uniqueidentifier
}

' ============================================================
' USER PROFILE
' ============================================================

class UserProfile {
  primary_key(UserId) : uniqueidentifier
  --
  foreign_key(UserId) : uniqueidentifier
  FirstName : nvarchar(100)
  LastName : nvarchar(100)
  MiddleName : nvarchar(100)
  PreferredName : nvarchar(100)
  JobTitle : nvarchar(200)
  Department : nvarchar(200)
  PhoneExtension : nvarchar(20)
  MobilePhone : nvarchar(50)
  AlternateEmail : nvarchar(256)
  TimeZone : nvarchar(100)
  Language : nvarchar(10)
  DateFormat : nvarchar(20)
  CreatedDate : datetime
  ModifiedDate : datetime
  foreign_key(ModifiedBy) : uniqueidentifier
}

class SecurityQuestions {
  primary_key(QuestionId) : int
  --
  QuestionText : nvarchar(500)
  IsActive : bit
  DisplayOrder : int
}

class UserSecurityAnswers {
  primary_key(AnswerId) : int
  --
  foreign_key(UserId) : uniqueidentifier
  foreign_key(QuestionId) : int
  AnswerHash : nvarchar(MAX)
  CreatedDate : datetime
  ModifiedDate : datetime
}

' ============================================================
' MULTI-TENANCY (TRIALS)
' ============================================================

class Trials {
  primary_key(TrialId) : uniqueidentifier
  --
  unique(TrialCode) : nvarchar(50)
  TrialName : nvarchar(500)
  Description : nvarchar(MAX)
  Title : nvarchar(500)
  Subtitle : nvarchar(500)
  LogoUrl : nvarchar(500)
  LinkUrl : nvarchar(500)
  StartDate : datetime
  EndDate : datetime
  Status : nvarchar(50)
  IsActive : bit
  CreatedDate : datetime
  foreign_key(CreatedBy) : uniqueidentifier
  ModifiedDate : datetime
  foreign_key(ModifiedBy) : uniqueidentifier
}

class TrialUserAssignments {
  primary_key(AssignmentId) : int
  --
  foreign_key(TrialId) : uniqueidentifier
  foreign_key(UserId) : uniqueidentifier
  foreign_key(RoleId) : uniqueidentifier
  AssignedDate : datetime
  foreign_key(AssignedBy) : uniqueidentifier
  ExpirationDate : datetime
  IsActive : bit
}

class TrialRoles {
  primary_key(TrialRoleId) : int
  --
  foreign_key(TrialId) : uniqueidentifier
  RoleName : nvarchar(256)
  Description : nvarchar(500)
  Permissions : nvarchar(MAX)
  IsActive : bit
  CreatedDate : datetime
}

' ============================================================
' AUDIT TRAIL (21 CFR Part 11)
' ============================================================

class AuditLog {
  primary_key(AuditId) : bigint
  --
  foreign_key(UserId) : uniqueidentifier
  UserName : nvarchar(256)
  IPAddress : nvarchar(50)
  SessionId : nvarchar(100)
  Controller : nvarchar(200)
  Action : nvarchar(200)
  AuditAction : nvarchar(100)
  AuditDetail : nvarchar(500)
  EntityType : nvarchar(200)
  EntityId : nvarchar(100)
  OldValue : nvarchar(MAX)
  NewValue : nvarchar(MAX)
  Timestamp : datetime2
  Success : bit
  ErrorMessage : nvarchar(MAX)
}

class LoginHistory {
  primary_key(LoginId) : bigint
  --
  foreign_key(UserId) : uniqueidentifier
  UserName : nvarchar(256)
  LoginTimestamp : datetime2
  LogoutTimestamp : datetime2
  IPAddress : nvarchar(50)
  UserAgent : nvarchar(500)
  SessionId : nvarchar(100)
  LoginSuccessful : bit
  FailureReason : nvarchar(500)
  LocationInfo : nvarchar(500)
}

' ============================================================
' PASSWORD HISTORY & SECURITY
' ============================================================

class PasswordHistory {
  primary_key(HistoryId) : int
  --
  foreign_key(UserId) : uniqueidentifier
  PasswordHash : nvarchar(MAX)
  CreatedDate : datetime
}

class AccountLockouts {
  primary_key(LockoutId) : int
  --
  foreign_key(UserId) : uniqueidentifier
  LockoutReason : nvarchar(500)
  LockoutStartDate : datetime
  LockoutEndDate : datetime
  FailedLoginAttempts : int
  foreign_key(LockedBy) : uniqueidentifier
  foreign_key(UnlockedBy) : uniqueidentifier
  UnlockedDate : datetime
  IsActive : bit
}

class PasswordResetTokens {
  primary_key(TokenId) : int
  --
  foreign_key(UserId) : uniqueidentifier
  Token : nvarchar(500)
  ExpirationDate : datetime
  IsUsed : bit
  UsedDate : datetime
  CreatedDate : datetime
}

' ============================================================
' EMAIL VERIFICATION
' ============================================================

class EmailVerificationTokens {
  primary_key(TokenId) : int
  --
  foreign_key(UserId) : uniqueidentifier
  Email : nvarchar(256)
  Token : nvarchar(500)
  ExpirationDate : datetime
  IsVerified : bit
  VerifiedDate : datetime
  CreatedDate : datetime
}

class PhoneVerificationTokens {
  primary_key(TokenId) : int
  --
  foreign_key(UserId) : uniqueidentifier
  PhoneNumber : nvarchar(50)
  VerificationCode : nvarchar(10)
  ExpirationDate : datetime
  IsVerified : bit
  VerifiedDate : datetime
  CreatedDate : datetime
}

' ============================================================
' CONFIGURATION
' ============================================================

class SystemConfiguration {
  primary_key(ConfigId) : int
  --
  ConfigKey : nvarchar(200)
  ConfigValue : nvarchar(MAX)
  Category : nvarchar(100)
  Description : nvarchar(500)
  DataType : nvarchar(50)
  IsEncrypted : bit
  ModifiedDate : datetime
  foreign_key(ModifiedBy) : uniqueidentifier
}

' ============================================================
' RELATIONSHIPS
' ============================================================

' User Authentication
AspNetUsers "1" -- "0..*" AspNetUserRoles : has
AspNetRoles "1" -- "0..*" AspNetUserRoles : assigned to
AspNetUsers "1" -- "0..*" AspNetUserClaims : has
AspNetUsers "1" -- "0..*" AspNetUserLogins : has

' User Profile
AspNetUsers "1" -- "0..1" UserProfile : has
AspNetUsers "1" -- "0..*" UserSecurityAnswers : answers
SecurityQuestions "1" -- "0..*" UserSecurityAnswers : used in

' Multi-Tenancy
Trials "1" -- "0..*" TrialUserAssignments : has
AspNetUsers "1" -- "0..*" TrialUserAssignments : assigned to
AspNetRoles "1" -- "0..*" TrialUserAssignments : with role
Trials "1" -- "0..*" TrialRoles : defines

' Audit & Security
AspNetUsers "1" -- "0..*" AuditLog : performs
AspNetUsers "1" -- "0..*" LoginHistory : has
AspNetUsers "1" -- "0..*" PasswordHistory : has
AspNetUsers "1" -- "0..*" AccountLockouts : may have
AspNetUsers "1" -- "0..*" PasswordResetTokens : requests
AspNetUsers "1" -- "0..*" EmailVerificationTokens : verifies with
AspNetUsers "1" -- "0..*" PhoneVerificationTokens : verifies with

' Self-references
AspNetUserRoles --> AspNetUsers : assigned by
UserProfile --> AspNetUsers : modified by
Trials --> AspNetUsers : created/modified by
TrialUserAssignments --> AspNetUsers : assigned by
AccountLockouts --> AspNetUsers : locked/unlocked by
SystemConfiguration --> AspNetUsers : modified by

@enduml
```

---

## Entity Relationship Diagram (ASCII)

```
┌────────────────────────────────────────────────────────────────────────────┐
│                      OoBDev Gateway - Data Model                           │
└────────────────────────────────────────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   AUTHENTICATION       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────┐         ┌──────────────────────────────┐
│ AspNetUsers                 │         │ AspNetRoles                  │
├─────────────────────────────┤         ├──────────────────────────────┤
│ PK Id (GUID)                │         │ PK Id (GUID)                 │
│ UK UserName                 │         │ UK Name                      │
│ UK Email                    │         │    Description               │
│    PasswordHash             │         │    IsSystemRole              │
│    SecurityStamp            │         │    CreatedDate               │
│    PhoneNumber              │         └──────────────┬───────────────┘
│    EmailConfirmed           │                        │
│    LockoutEndDateUtc        │                        │
│    AccessFailedCount        │                        │
│    LastLoginDate            │         ┌──────────────▼───────────────┐
│    IsLockedOut              │         │ AspNetUserRoles              │
│    CreatedDate              │◄────────┤──────────────────────────────┤
└────────────┬────────────────┘         │ PK UserId (GUID) FK          │
             │                          │ PK RoleId (GUID) FK          │
             │                          │    AssignedDate              │
             │                          │ FK AssignedBy (GUID)         │
             │                          └──────────────────────────────┘
             │
             ├────────────────────────────────────────────────────────┐
             │                                                        │
┌────────────▼────────────────┐         ┌──────────────────────────────▼─────┐
│ AspNetUserClaims            │         │ AspNetUserLogins                   │
├─────────────────────────────┤         ├────────────────────────────────────┤
│ PK Id (int)                 │         │ PK LoginProvider, ProviderKey      │
│ FK UserId (GUID)            │         │ FK UserId (GUID)                   │
│    ClaimType                │         └────────────────────────────────────┘
│    ClaimValue               │
└─────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   USER PROFILE         ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────┐         ┌──────────────────────────────┐
│ UserProfile                 │         │ SecurityQuestions            │
├─────────────────────────────┤         ├──────────────────────────────┤
│ PK FK UserId (GUID)         │         │ PK QuestionId (int)          │
│    FirstName                │         │    QuestionText              │
│    LastName                 │         │    IsActive                  │
│    MiddleName               │         │    DisplayOrder              │
│    PreferredName            │         └───────────┬──────────────────┘
│    JobTitle                 │                     │
│    Department               │                     │
│    PhoneExtension           │         ┌───────────▼──────────────────┐
│    MobilePhone              │         │ UserSecurityAnswers          │
│    TimeZone                 │         ├──────────────────────────────┤
│    Language                 │◄────────┤ PK AnswerId (int)            │
│    CreatedDate              │         │ FK UserId (GUID)             │
│ FK ModifiedBy (GUID)        │         │ FK QuestionId (int)          │
└─────────────────────────────┘         │    AnswerHash                │
                                        │    CreatedDate               │
                                        └──────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   MULTI-TENANCY        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────┐
│ Trials                      │
├─────────────────────────────┤         ┌──────────────────────────────┐
│ PK TrialId (GUID)           │         │ TrialUserAssignments         │
│ UK TrialCode                │◄────────┤──────────────────────────────┤
│    TrialName                │         │ PK AssignmentId (int)        │
│    Description              │         │ FK TrialId (GUID)            │
│    Title                    │         │ FK UserId (GUID)─────────────┼──►AspNetUsers
│    Subtitle                 │         │ FK RoleId (GUID)─────────────┼──►AspNetRoles
│    LogoUrl                  │         │    AssignedDate              │
│    LinkUrl                  │         │ FK AssignedBy (GUID)         │
│    StartDate                │         │    ExpirationDate            │
│    EndDate                  │         │    IsActive                  │
│    Status                   │         └──────────────────────────────┘
│    IsActive                 │
│    CreatedDate              │         ┌──────────────────────────────┐
│ FK CreatedBy (GUID)         │         │ TrialRoles                   │
│    ModifiedDate             │◄────────┤──────────────────────────────┤
│ FK ModifiedBy (GUID)        │         │ PK TrialRoleId (int)         │
└─────────────────────────────┘         │ FK TrialId (GUID)            │
                                        │    RoleName                  │
                                        │    Description               │
                                        │    Permissions (JSON)        │
                                        │    IsActive                  │
                                        └──────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   AUDIT TRAIL          ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────┐         ┌──────────────────────────────┐
│ AuditLog                    │         │ LoginHistory                 │
├─────────────────────────────┤         ├──────────────────────────────┤
│ PK AuditId (bigint)         │         │ PK LoginId (bigint)          │
│ FK UserId (GUID)────────────┼───┐     │ FK UserId (GUID)─────────────┼──►AspNetUsers
│    UserName                 │   │     │    UserName                  │
│    IPAddress                │   │     │    LoginTimestamp            │
│    SessionId                │   │     │    LogoutTimestamp           │
│    Controller               │   │     │    IPAddress                 │
│    Action                   │   │     │    UserAgent                 │
│    AuditAction              │   │     │    SessionId                 │
│    AuditDetail              │   │     │    LoginSuccessful           │
│    EntityType               │   │     │    FailureReason             │
│    EntityId                 │   │     │    LocationInfo              │
│    OldValue                 │   │     └──────────────────────────────┘
│    NewValue                 │   │
│    Timestamp                │   │
│    Success                  │   └─────►AspNetUsers
│    ErrorMessage             │
└─────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   SECURITY             ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────┐         ┌──────────────────────────────┐
│ PasswordHistory             │         │ AccountLockouts              │
├─────────────────────────────┤         ├──────────────────────────────┤
│ PK HistoryId (int)          │         │ PK LockoutId (int)           │
│ FK UserId (GUID)────────────┼───┐     │ FK UserId (GUID)─────────────┼──►AspNetUsers
│    PasswordHash             │   │     │    LockoutReason             │
│    CreatedDate              │   │     │    LockoutStartDate          │
└─────────────────────────────┘   │     │    LockoutEndDate            │
                                  │     │    FailedLoginAttempts       │
┌─────────────────────────────┐   │     │ FK LockedBy (GUID)           │
│ PasswordResetTokens         │   │     │ FK UnlockedBy (GUID)         │
├─────────────────────────────┤   │     │    UnlockedDate              │
│ PK TokenId (int)            │   │     │    IsActive                  │
│ FK UserId (GUID)────────────┼───┤     └──────────────────────────────┘
│    Token                    │   │
│    ExpirationDate           │   │
│    IsUsed                   │   │
│    UsedDate                 │   │
│    CreatedDate              │   │
└─────────────────────────────┘   └─────►AspNetUsers

┌─────────────────────────────┐         ┌──────────────────────────────┐
│ EmailVerificationTokens     │         │ PhoneVerificationTokens      │
├─────────────────────────────┤         ├──────────────────────────────┤
│ PK TokenId (int)            │         │ PK TokenId (int)             │
│ FK UserId (GUID)────────────┼───┐     │ FK UserId (GUID)─────────────┼──►AspNetUsers
│    Email                    │   │     │    PhoneNumber               │
│    Token                    │   │     │    VerificationCode          │
│    ExpirationDate           │   │     │    ExpirationDate            │
│    IsVerified               │   │     │    IsVerified                │
│    VerifiedDate             │   │     │    VerifiedDate              │
│    CreatedDate              │   │     │    CreatedDate               │
└─────────────────────────────┘   └─────►AspNetUsers


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   CONFIGURATION        ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────┐
│ SystemConfiguration         │
├─────────────────────────────┤
│ PK ConfigId (int)           │
│ UK ConfigKey                │
│    ConfigValue              │
│    Category                 │
│    Description              │
│    DataType                 │
│    IsEncrypted              │
│    ModifiedDate             │
│ FK ModifiedBy (GUID)────────┼──►AspNetUsers
└─────────────────────────────┘


Key:
  PK = Primary Key
  FK = Foreign Key
  UK = Unique Key
  ──► = One-to-Many relationship
  ◄── = Many-to-One relationship
```

---

## Table Descriptions

### Authentication & Authorization

#### AspNetUsers
**Purpose**: Core user account table for ASP.NET Identity

**Key Features**:
- Email and phone number verification support
- Account lockout tracking
- Password hash storage with security stamp
- Last login date tracking (for session management feature)
- Two-factor authentication support

**Indexes**:
- Clustered index on `Id` (PK)
- Non-clustered unique index on `UserName`
- Non-clustered unique index on `Email`
- Non-clustered index on `IsLockedOut, LockoutEndDateUtc` (for lockout queries)

**Compliance**: 21 CFR Part 11 - User identification

#### AspNetRoles
**Purpose**: Role definitions for role-based access control (RBAC)

**Key Features**:
- System roles (non-deletable administrative roles)
- Custom trial-specific roles
- Role descriptions for audit trail

**Indexes**:
- Clustered index on `Id` (PK)
- Non-clustered unique index on `Name`

#### AspNetUserRoles
**Purpose**: Many-to-many relationship between users and roles

**Key Features**:
- Tracks who assigned the role (audit trail)
- Assignment date tracking
- Supports role revocation audit

**Indexes**:
- Clustered index on `UserId, RoleId` (composite PK)
- Non-clustered index on `RoleId` (for reverse lookup)
- Non-clustered index on `AssignedBy` (for audit queries)

### User Profile

#### UserProfile
**Purpose**: Extended user profile information beyond authentication

**Key Features**:
- Full name components
- Contact information
- Localization preferences (timezone, language, date format)
- Modification tracking

**Business Rules**:
- Profile must be completed before user can access system (MyInfoCheck pattern)
- Prompted on first login if profile doesn't exist

**Indexes**:
- Clustered index on `UserId` (PK/FK)
- Non-clustered index on `LastName, FirstName` (for directory searches)

#### SecurityQuestions / UserSecurityAnswers
**Purpose**: Security question-based account recovery

**Key Features**:
- Predefined security questions
- Hashed answers (never stored in plain text)
- Supports multiple questions per user
- Used for password reset and account unlock

**Security**: Answers are hashed using same algorithm as passwords

### Multi-Tenancy

#### Trials
**Purpose**: Trial/study definitions for multi-tenant data isolation

**Key Features**:
- Unique trial code for identification
- Trial metadata (name, description, title, subtitle)
- Custom branding (logo URL, link URL)
- Trial lifecycle dates
- Soft delete support (IsActive flag)

**Indexes**:
- Clustered index on `TrialId` (PK)
- Non-clustered unique index on `TrialCode`
- Non-clustered index on `IsActive, Status` (for active trial queries)

#### TrialUserAssignments
**Purpose**: Assign users to specific trials with trial-specific roles

**Key Features**:
- Many-to-many between Users, Trials, and Roles
- Time-limited assignments (expiration date)
- Assignment audit trail (who assigned, when)
- Supports access revocation

**Business Rules**:
- User can be assigned to multiple trials
- User can have different roles in different trials
- Expired assignments are automatically deactivated

**Indexes**:
- Clustered index on `AssignmentId` (PK)
- Non-clustered index on `TrialId, UserId, IsActive` (most common query)
- Non-clustered index on `UserId, IsActive` (user's active trials)
- Non-clustered index on `ExpirationDate` (for cleanup jobs)

#### TrialRoles
**Purpose**: Trial-specific role definitions

**Key Features**:
- Extends system roles with trial-specific permissions
- JSON permissions field for flexible authorization
- Trial-scoped roles

### Audit Trail

#### AuditLog
**Purpose**: Comprehensive audit trail for 21 CFR Part 11 compliance

**Key Features**:
- Who (UserId, UserName)
- What (Controller, Action, AuditAction, AuditDetail)
- When (Timestamp with datetime2 precision)
- Where (IPAddress, SessionId)
- Data changes (OldValue, NewValue)
- Entity tracking (EntityType, EntityId)
- Success/failure tracking

**Retention**: Permanent retention required for regulatory compliance

**Indexes**:
- Clustered index on `AuditId` (PK, identity)
- Non-clustered index on `Timestamp DESC` (for recent audit queries)
- Non-clustered index on `UserId, Timestamp` (user activity queries)
- Non-clustered index on `EntityType, EntityId` (entity audit history)

**Performance**: Partitioned by month for large-scale deployments

#### LoginHistory
**Purpose**: Detailed login/logout tracking

**Key Features**:
- Login timestamp and logout timestamp
- IP address and user agent tracking
- Session correlation
- Success/failure tracking with reasons
- Geographic location info

**Indexes**:
- Clustered index on `LoginId` (PK)
- Non-clustered index on `UserId, LoginTimestamp DESC` (user login history)
- Non-clustered index on `LoginTimestamp DESC` (recent logins)

### Security

#### PasswordHistory
**Purpose**: Prevent password reuse (compliance requirement)

**Key Features**:
- Stores hashed passwords (never plain text)
- Enforces "cannot reuse last N passwords" policy
- Timestamp tracking for password age policies

**Retention**: Typically last 12 passwords per user

**Indexes**:
- Clustered index on `HistoryId` (PK)
- Non-clustered index on `UserId, CreatedDate DESC` (password history lookup)

#### AccountLockouts
**Purpose**: Track account lockout events for security and compliance

**Key Features**:
- Lockout reason tracking
- Failed login attempt counting
- Manual lockout support (admin-initiated)
- Unlock tracking (who unlocked, when)

**Indexes**:
- Clustered index on `LockoutId` (PK)
- Non-clustered index on `UserId, IsActive` (active lockouts)
- Non-clustered index on `LockoutEndDate` (for automatic unlock processing)

#### PasswordResetTokens
**Purpose**: Secure password reset workflow

**Key Features**:
- Time-limited tokens (typically 24-hour expiration)
- One-time use tokens
- Token usage tracking

**Security**: Tokens are cryptographically random, stored hashed

**Cleanup**: Expired/used tokens purged after 90 days

#### EmailVerificationTokens / PhoneVerificationTokens
**Purpose**: Email and phone number verification for account security

**Key Features**:
- Time-limited verification codes
- Verification status tracking
- Support for re-verification

**Expiration**: Typically 24 hours for email, 15 minutes for SMS

### Configuration

#### SystemConfiguration
**Purpose**: Application configuration settings

**Key Features**:
- Key-value configuration storage
- Category-based organization
- Type metadata for proper deserialization
- Encryption support for sensitive values
- Audit trail (who modified, when)

**Examples**:
- `Auth.PasswordComplexity.MinLength = 8`
- `Auth.Lockout.FailedAttemptThreshold = 5`
- `Email.SmtpServer = smtp.example.com`

---

## Relationships

### One-to-Many Relationships

1. **AspNetUsers → AspNetUserRoles** (1:N)
   - One user can have multiple roles

2. **AspNetRoles → AspNetUserRoles** (1:N)
   - One role can be assigned to multiple users

3. **AspNetUsers → UserProfile** (1:1)
   - One user has exactly one profile

4. **AspNetUsers → AuditLog** (1:N)
   - One user performs many audited actions

5. **Trials → TrialUserAssignments** (1:N)
   - One trial has many user assignments

6. **AspNetUsers → TrialUserAssignments** (1:N)
   - One user can be assigned to many trials

### Self-Referencing Relationships

1. **AspNetUserRoles.AssignedBy → AspNetUsers**
   - Tracks which user assigned the role

2. **UserProfile.ModifiedBy → AspNetUsers**
   - Tracks which user modified the profile

3. **Trials.CreatedBy / ModifiedBy → AspNetUsers**
   - Tracks who created/modified the trial

4. **TrialUserAssignments.AssignedBy → AspNetUsers**
   - Tracks who made the assignment

---

## Data Integrity Rules

### Constraints

1. **Password Complexity**
   - Minimum 8 characters
   - Must contain uppercase, lowercase, number, special character
   - Enforced at application layer and database trigger

2. **Email Format**
   - Must be valid email format
   - Enforced via CHECK constraint and application validation

3. **Username Uniqueness**
   - Case-insensitive unique constraint

4. **Lockout Rules**
   - `AccessFailedCount` auto-increments on failed login
   - `LockoutEndDateUtc` set when threshold reached
   - Auto-reset `AccessFailedCount` on successful login

### Cascade Rules

1. **User Deletion** (soft delete only)
   - Set `IsApproved = 0` instead of DELETE
   - Preserve audit trail integrity
   - Retain historical data for compliance

2. **Trial Deletion** (soft delete only)
   - Set `IsActive = 0`
   - Preserve trial assignments for audit

---

## Indexes and Performance

### Critical Indexes

1. **Login Performance**
   ```sql
   CREATE NONCLUSTERED INDEX IX_AspNetUsers_UserName_Active
   ON AspNetUsers(UserName, IsLockedOut, IsApproved)
   INCLUDE (Id, PasswordHash, SecurityStamp, AccessFailedCount)
   ```

2. **Audit Queries**
   ```sql
   CREATE NONCLUSTERED INDEX IX_AuditLog_TimeUser
   ON AuditLog(Timestamp DESC, UserId)
   INCLUDE (Controller, Action, AuditAction)
   ```

3. **Trial Access**
   ```sql
   CREATE NONCLUSTERED INDEX IX_TrialUserAssignments_UserTrial
   ON TrialUserAssignments(UserId, TrialId, IsActive, ExpirationDate)
   INCLUDE (RoleId)
   ```

### Query Optimization

- **Connection Pooling**: Enabled with min 10, max 100 connections
- **Compiled Queries**: Used for frequently-executed queries
- **Read-Only Queries**: Use `AsNoTracking()` for performance
- **Pagination**: Implement Skip/Take for large result sets

---

## Security Considerations

### Data Encryption

1. **At Rest**
   - Transparent Data Encryption (TDE) for entire database
   - Column-level encryption for `PasswordHash`, `SecurityStamp`
   - Encrypted configuration values in `SystemConfiguration`

2. **In Transit**
   - TLS 1.2+ for all database connections
   - Connection string encryption in web.config

### Access Control

1. **Database Users**
   - Application uses least-privilege service account
   - No direct user access to database (application-tier authentication only)
   - DBAs have separate admin accounts with audit logging

2. **Row-Level Security**
   - Implemented via Entity Framework filters
   - Users can only access trials they're assigned to
   - Audit log is append-only (no UPDATE or DELETE permissions)

---

## Migration Strategy

### Initial Deployment

```sql
-- Run migrations in order:
1. 001_CreateIdentitySchema.sql
2. 002_CreateProfileSchema.sql
3. 003_CreateTrialSchema.sql
4. 004_CreateAuditSchema.sql
5. 005_CreateSecuritySchema.sql
6. 006_CreateConfigSchema.sql
7. 007_CreateIndexes.sql
8. 008_CreateConstraints.sql
9. 009_InsertSeedData.sql
```

### Seed Data

- Default system roles (Administrator, User, Guest)
- Default security questions
- Default system configuration
- Initial admin user

### Version Control

- All schema changes tracked in Entity Framework migrations
- Migration scripts stored in source control
- Rollback scripts maintained for each migration

---

## Compliance Mapping

### 21 CFR Part 11

| Requirement | Implementation |
|-------------|----------------|
| User Authentication | AspNetUsers with secure password hashing |
| User Authorization | AspNetRoles + AspNetUserRoles RBAC |
| Audit Trail | AuditLog with immutable records |
| Electronic Signatures | Audit trail includes UserId + IPAddress + Timestamp |
| Record Integrity | Checksums, foreign key constraints, triggers |
| Archive/Retention | Permanent audit log retention, no deletion |

### HIPAA (if PHI present)

- Encrypted database (TDE)
- Encrypted connections (TLS 1.2+)
- Access logging (LoginHistory, AuditLog)
- PHI masking in audit logs (configurable)

### GCP (Good Clinical Practice)

- Trial assignments tracked
- Data modification audit trail
- Version history for key entities
- Investigator accountability (trial role assignments)

---

*Gateway ERD Version: 1.0*
*Last Updated: January 2026*
*Database Schema Version: 2.5.0*
