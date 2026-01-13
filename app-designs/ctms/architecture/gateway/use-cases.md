# Gateway Use Cases

This document describes the primary use cases for the OoBDev Gateway application.

## Gateway User Use Cases

The Gateway User represents the base user role with fundamental system access capabilities.

```plantuml
@startuml Gateway Use Cases
title OoBDev Gateway - User Use Cases

actor "Gateway User" as GatewayUser
actor "Trial/Site Manager" as TrialManager

' Gateway User Use Cases
usecase "Login" as UC_Login
usecase "Logout" as UC_Logout
usecase "Change Password" as UC_ChangePassword
usecase "Request Support\n(See support App)" as UC_RequestSupport
usecase "Check Roles" as UC_CheckRoles
usecase "Check Last Logon" as UC_CheckLastLogon
usecase "Lockout on Failed Login" as UC_Lockout
usecase "Self Register" as UC_SelfRegister
usecase "Verify Account contact" as UC_VerifyAccount
usecase "Manage Profile" as UC_ManageProfile
usecase "Password and Unlock\nself service" as UC_PasswordUnlock

' Trial/Site Manager Use Cases
usecase "Assign user to trial/site" as UC_AssignUser
usecase "Enroll User" as UC_EnrollUser

' Associations - Gateway User
GatewayUser --> UC_Login
GatewayUser --> UC_Logout
GatewayUser --> UC_ChangePassword
GatewayUser --> UC_RequestSupport
GatewayUser --> UC_CheckRoles
GatewayUser --> UC_CheckLastLogon
GatewayUser --> UC_Lockout
GatewayUser --> UC_SelfRegister
GatewayUser --> UC_ManageProfile
GatewayUser --> UC_PasswordUnlock

' Dependencies
UC_Logout ..> UC_Login : <<depends>>
UC_CheckLastLogon ..> UC_Login : <<depends>>
UC_SelfRegister --> UC_VerifyAccount : <<include>>
UC_AssignUser ..> GatewayUser : <<depends>>

' Trial/Site Manager extends Gateway User
TrialManager --|> GatewayUser

' Trial/Site Manager associations
TrialManager --> UC_AssignUser
TrialManager --> UC_EnrollUser

' Notes
note right of UC_Lockout
  Number of failed logins
  should be configurable
end note

note right of UC_PasswordUnlock
  Requires secondary
  question(s)
end note

note right of UC_ManageProfile
  Prompt on Login if not exist

  Email, Phone, Name,
  Security Question(s)
end note

@enduml
```

### ASCII Diagram

```
OoBDev Gateway - User Use Cases

┌──────────────────┐
│  Gateway User    │────────┐
│   (Base Role)    │        │
└──────────────────┘        │
         │                  │
         │                  │ inherits from
         │                  │
         │              ┌───▼──────────────────┐
         │              │  Trial/Site Manager  │
         │              └───────────┬──────────┘
         │                          │
         │                          │
         ├──────►( Login )          │
         │                          │
         ├──────►( Logout )◄────────┼───depends on Login
         │                          │
         ├──────►( Change Password )│
         │                          │
         ├──────►( Request Support )│
         │        (See Support App) │
         │                          │
         ├──────►( Check Roles )    │
         │                          │
         ├──────►( Check Last Logon )◄──depends on Login
         │                          │
         ├──────►( Lockout on Failed Login )
         │        [Configurable threshold]
         │                          │
         ├──────►( Self Register )──includes──►( Verify Account Contact )
         │                          │
         ├──────►( Manage Profile ) │
         │        [Prompted on Login if not exists]
         │        - Email, Phone, Name
         │        - Security Questions
         │                          │
         ├──────►( Password and Unlock Self Service )
         │        [Requires Security Questions]
         │                          │
         │                          ├──────►( Assign User to Trial/Site )
         │                          │
         └──────────────────────────┴──────►( Enroll User )


Actor Relationships:
  • Trial/Site Manager extends Gateway User (inherits all Gateway User use cases)

Key Dependencies:
  • Logout depends on Login (must be logged in to log out)
  • Check Last Logon depends on Login (shown during login)
  • Self Register includes Verify Account Contact (email/phone verification)
  • Assign User to Trial/Site depends on Gateway User existing

Notes:
  [1] Lockout threshold should be configurable
  [2] Password/Unlock self service requires security questions
  [3] Profile management prompted on first login if profile doesn't exist
```

## Use Case Descriptions

### Authentication & Session Management

#### Login (UC_Login)
- **Actor**: Gateway User
- **Description**: User authenticates with username and password
- **Work Item**: #570
- **Post-conditions**: User session established, last logon time recorded

#### Logout (UC_Logout)
- **Actor**: Gateway User
- **Description**: User terminates their session
- **Work Item**: #571
- **Dependencies**: Requires active login session

#### Check Last Logon (UC_CheckLastLogon)
- **Actor**: Gateway User
- **Description**: System displays last successful login timestamp
- **Dependencies**: Triggered during login process

#### Lockout on Failed Login (UC_Lockout)
- **Actor**: Gateway User
- **Description**: System locks user account after configurable number of failed login attempts
- **Work Item**: #575
- **Configuration**: Number of failed attempts should be configurable
- **Related**: Password and Unlock self service

### Password Management

#### Change Password (UC_ChangePassword)
- **Actor**: Gateway User
- **Description**: Authenticated user can change their password
- **Work Item**: #569
- **Requirements**: Must meet password complexity requirements

#### Password and Unlock Self Service (UC_PasswordUnlock)
- **Actor**: Gateway User
- **Description**: User can reset password or unlock account without admin assistance
- **Work Item**: #574
- **Requirements**: Requires answering secondary security questions
- **Related**: Manage Profile (for setting security questions)

### User Registration & Profile

#### Self Register (UC_SelfRegister)
- **Actor**: Gateway User
- **Description**: New users can create their own account
- **Work Item**: #577
- **Includes**: Verify Account Contact
- **Post-conditions**: Account created but may require verification

#### Verify Account Contact (UC_VerifyAccount)
- **Actor**: System
- **Description**: Verifies user's email or phone number through confirmation code
- **Included by**: Self Register

#### Manage Profile (UC_ManageProfile)
- **Actor**: Gateway User
- **Description**: User maintains their profile information
- **Work Item**: #573
- **Fields**:
  - Email address
  - Phone number
  - Name
  - Security questions and answers
- **Business Rule**: System prompts for profile completion on login if not complete

### Authorization

#### Check Roles (UC_CheckRoles)
- **Actor**: Gateway User
- **Description**: User can view their assigned roles and permissions
- **Work Item**: #572

### Support

#### Request Support (UC_RequestSupport)
- **Actor**: Gateway User
- **Description**: User can submit support requests
- **Work Item**: #563
- **Note**: See separate Support application for full support workflow

## Trial/Site Manager Use Cases

The Trial/Site Manager role extends Gateway User with additional capabilities for managing trial participants.

### User Management

#### Assign User to Trial/Site (UC_AssignUser)
- **Actor**: Trial/Site Manager
- **Description**: Assign users to specific trials and sites
- **Work Item**: #576
- **Dependencies**: Requires valid Gateway User account

#### Enroll User (UC_EnrollUser)
- **Actor**: Trial/Site Manager
- **Description**: Enroll users into trials
- **Pre-conditions**: User must be assigned to trial/site

## Common System Use Cases

System-level use cases that apply to all server components.

```plantuml
@startuml Common System Use Cases
title OoBDev Architecture - Common System Use Cases

actor "Server" as Server
actor "Email Processor" as EmailProcessor

usecase "All Exceptions Should\nbe logged" as UC_LogExceptions
usecase "All emails should be\nprocessed though a\nmessage queue" as UC_EmailQueue

' Server associations
Server --> UC_LogExceptions

' Email Processor extends Server
EmailProcessor --|> Server

' Email Processor associations
EmailProcessor --> UC_EmailQueue

@enduml
```

### System Requirements

#### All Exceptions Should be Logged (UC_LogExceptions)
- **Actor**: Server
- **Description**: All unhandled exceptions must be logged for troubleshooting
- **Work Item**: #579
- **Applies to**: All server-side components

#### All Emails Processed Through Message Queue (UC_EmailQueue)
- **Actor**: Email Processor
- **Description**: Email sending must be asynchronous through a message queue
- **Work Item**: #578
- **Rationale**: Prevents email delays from blocking user requests
- **Related**: See [Messaging Architecture](../messaging/README.md)

## Work Item References

The use cases reference Team Foundation Server work items for detailed requirements and implementation tracking.

- TFS Server: tfscorp.itrica.com\ITRICA
- Collection ID: 04150b45-2081-4a9f-89f8-b188e6a7a0a4

## Related Documentation

- [SAE Use Cases](./sae-use-cases.md) - Safety Adverse Event management
- [Layering Architecture](./layering.md) - System architecture and dependencies
