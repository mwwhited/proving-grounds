# CTS Feature Specification: Trial Enrollment & Subscriptions

## Overview
Manages site subscriptions to trials, enabling sites to participate in multiple trials with appropriate access control and data segregation.

**Actors**: Subscriber, Trial Administrator
**Priority**: Medium

## Key Features
- Site-to-trial subscriptions
- Multi-site user assignments
- Trial-specific permissions
- Site selection interface
- Cross-trial reporting restrictions

## ASCII Mockups

### Site Selection (Multi-Site User)
```
┌──────────────────────────────────────────────────────────────────┐
│ Select Trial Site                               Sarah Martinez   │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│  You have access to multiple sites. Please select which site     │
│  you want to work with:                                          │
│                                                                   │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │                                                             │  │
│  │  ○  Site 101 - Memorial Hospital                           │  │
│  │     Cardiovascular Outcomes Trial                          │  │
│  │     Active Subjects: 23  │  Screening: 5                   │  │
│  │                                                             │  │
│  │  ○  Site 105 - Regional Medical Center                     │  │
│  │     Diabetes Prevention Study                              │  │
│  │     Active Subjects: 15  │  Screening: 2                   │  │
│  │                                                             │  │
│  │  ○  Site 103 - University Hospital                         │  │
│  │     Heart Failure Trial                                    │  │
│  │     Active Subjects: 18  │  Screening: 3                   │  │
│  │                                                             │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ☑ Remember my selection                                         │
│                                                                   │
│                                              [Cancel]  [Continue] │
└──────────────────────────────────────────────────────────────────┘
```

### Site Subscription Management (Admin)
```
┌──────────────────────────────────────────────────────────────────────────┐
│ Trial Subscriptions - Protocol ABC-2026-001                 [+ Add Site]  │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  Participating Sites (12)                                                │
│                                                                           │
│  ┌────────────────────────────────────────────────────────────────────┐  │
│  │ Site ID  Site Name                Status    Activated   Subjects  │  │
│  ├────────────────────────────────────────────────────────────────────┤  │
│  │ 101      Memorial Hospital        Active    01/05/2025  23        │  │
│  │          [Edit] [Deactivate] [Manage Users]                       │  │
│  │                                                                    │  │
│  │ 102      City General Hospital    Active    01/10/2025  19        │  │
│  │          [Edit] [Deactivate] [Manage Users]                       │  │
│  │                                                                    │  │
│  │ 103      University Hospital      Active    01/15/2025  18        │  │
│  │          [Edit] [Deactivate] [Manage Users]                       │  │
│  │                                                                    │  │
│  │ 104      Regional Med Center      Pending   -           0         │  │
│  │          [Edit] [Activate] [Manage Users]                         │  │
│  │                                                                    │  │
│  │ 105      Suburban Clinic          Inactive  02/01/2025  15        │  │
│  │          [Edit] [Reactivate] [Manage Users]                       │  │
│  │                                                                    │  │
│  │ ... 7 more sites                                    [Show All]    │  │
│  └────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  Total Active Sites: 11  │  Total Subjects Enrolled: 217                 │
│                                                                           │
│  [Export Site List]  [Site Performance Report]  [Bulk Operations]        │
└──────────────────────────────────────────────────────────────────────────┘
```

## Data Model
```
TrialSubscription {
  SubscriptionID: string (PK)
  TrialID: string (FK)
  SiteID: string (FK)
  Status: string
  ActivationDate: date
  DeactivationDate: date
  EnrollmentCap: integer
  CurrentEnrollment: integer
}

UserSiteAssignment {
  AssignmentID: string (PK)
  UserID: string (FK)
  SiteID: string (FK)
  TrialID: string (FK)
  Role: string
  AssignedDate: date
  Active: boolean
}
```
