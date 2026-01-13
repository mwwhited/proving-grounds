# CTS Feature Specification: Subject Lifecycle Management

## Overview
Comprehensive subject management from screening through completion, including enrollment, status tracking, and lifecycle state management.

**Actors**: Subscriber
**Priority**: High

## Key Features
- Subject search and filtering
- Status workflow management
- Enrollment/decline operations
- Subject deactivation
- Read-only for completed subjects
- Resume incomplete screenings

## ASCII Mockups

### Subject List
```
┌──────────────────────────────────────────────────────────────────────────┐
│ Subject Management - Site 101                          [+ New Screening]  │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  Filter: [All Status ▼]  Search: [___________] 🔍  [Apply]  [Clear]      │
│                                                                           │
│  Active Subjects (23) │ Enrolled (18) │ Screening (5) │ Completed (12)   │
│                                                                           │
│  ┌────────────────────────────────────────────────────────────────────┐  │
│  │ Subject ID   Initials  Status      Screen Date  Enrolled    Actions│  │
│  ├────────────────────────────────────────────────────────────────────┤  │
│  │ SUBJ-001234  J.D.      Enrolled    01/13/2026   01/15/2026 [View] │  │
│  │                        Active                              [Edit] │  │
│  │                                                                    │  │
│  │ SCR-0235     M.T.      Screen Fail 01/13/2026   -          [View] │  │
│  │                        Ineligible                          [Delete]│  │
│  │                                                                    │  │
│  │ SCR-0236     R.K.      Screening   01/14/2026   -          [View] │  │
│  │                        In Progress                         [Resume]│  │
│  │                                                                    │  │
│  │ SUBJ-001235  L.M.      Enrolled    01/10/2026   01/12/2026 [View] │  │
│  │                        Active                              [Edit] │  │
│  │                                                                    │  │
│  │ SUBJ-001236  T.W.      Withdrawn   12/15/2025   12/20/2025 [View] │  │
│  │                        Deactivated                         [Notes]│  │
│  │                                                                    │  │
│  │ SUBJ-001237  P.H.      Completed   11/05/2025   11/10/2025 [View] │  │
│  │                        Read-only                                  │  │
│  │                                                                    │  │
│  │ ... 17 more subjects                            [Show More]      │  │
│  └────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  [Export List]  [Generate Report]  [Bulk Actions]                         │
└──────────────────────────────────────────────────────────────────────────┘
```

### Subject Detail View
```
┌──────────────────────────────────────────────────────────────────────────┐
│ Subject Details - SUBJ-001234                        [Edit] [Actions ▼]  │
├──────────────────────────────────────────────────────────────────────────┤
│                                                                           │
│  Overview │ Screening │ Enrollment │ Visits │ Documents │ History        │
│  ────────────────────────────────────────────────────────────────        │
│                                                                           │
│  Subject Information                                                     │
│  ┌────────────────────────────────────────────────────────────────────┐  │
│  │ Subject ID: SUBJ-001234        Initials: J.D.                      │  │
│  │ Date of Birth: **/**/1958      Age: 68 years                       │  │
│  │ Gender: Male                    Site: 101 - Memorial Hospital      │  │
│  │ Status: Enrolled - Active       Trial Arm: Treatment Group A       │  │
│  └────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  Screening Summary                                                       │
│  ┌────────────────────────────────────────────────────────────────────┐  │
│  │ Screen Date: 01/13/2026         Screened By: S. Martinez           │  │
│  │ Screen ID: SITE101-SCR-0234     Result: ✓ Eligible                 │  │
│  │ Eligibility: All criteria met   [View Full Screening]              │  │
│  └────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  Enrollment Details                                                      │
│  ┌────────────────────────────────────────────────────────────────────┐  │
│  │ Enrolled: 01/15/2026            By: Dr. J. Wilson                  │  │
│  │ Consent Date: 01/15/2026        Randomization: 01/15/2026          │  │
│  │ Days on Study: 363              Last Visit: 01/10/2026             │  │
│  └────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  Quick Actions                                                           │
│  ┌────────────────────────────────────────────────────────────────────┐  │
│  │ [Schedule Visit]  [Upload Document]  [Record Adverse Event]        │  │
│  │ [Send Message]    [View Calendar]    [Generate Report]             │  │
│  └────────────────────────────────────────────────────────────────────┘  │
│                                                                           │
│  Status Actions: [Deactivate Subject]  [Mark as Completed]               │
│                                                                           │
└──────────────────────────────────────────────────────────────────────────┘
```

### Enroll Subject
```
┌──────────────────────────────────────────────────────────────────┐
│ Enroll Subject - SCR-0234                              [Cancel]  │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│  Subject: J.D. (Male, 68 years)                                  │
│  Screening: SITE101-SCR-0234 (01/13/2026)                        │
│  Status: Eligible for enrollment                                │
│                                                                   │
│  Pre-Enrollment Checklist                                        │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │ ☑ Eligibility confirmed                                    │  │
│  │ ☑ Informed consent obtained                                │  │
│  │ ☑ Baseline assessments completed                           │  │
│  │ ☑ Protocol deviations reviewed (0 found)                   │  │
│  │ ☑ Investigator approval received                           │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                   │
│  Enrollment Details                                              │
│  Enrollment Date: * [01/15/2026] 📅                              │
│  Consent Date: *    [01/15/2026] 📅                              │
│  Subject Number: *  [Auto-assigned: SUBJ-001234]                 │
│                                                                   │
│  Randomization:                                                  │
│  ● Randomize now   ○ Randomize later                             │
│  Treatment Arm: [Auto-assigned based on randomization schedule]  │
│                                                                   │
│  Notes:                                                          │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │                                                             │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ☑ I confirm eligibility and enrollment criteria are met         │
│                                                                   │
│  [Cancel]                             [Enroll Subject]           │
└──────────────────────────────────────────────────────────────────┘
```

### Deactivate Subject
```
┌──────────────────────────────────────────────────────────────────┐
│ Deactivate Subject - SUBJ-001236                       [Cancel]  │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│  Subject: T.W. (Female, 72 years)                                │
│  Current Status: Enrolled - Active                               │
│  Enrollment Date: 12/20/2025 (25 days ago)                       │
│                                                                   │
│  Deactivation Reason: *                                          │
│  ● Subject withdrew consent                                      │
│  ○ Lost to follow-up                                             │
│  ○ Protocol violation                                            │
│  ○ Adverse event requiring discontinuation                       │
│  ○ Investigator decision                                         │
│  ○ Death                                                         │
│  ○ Completed study                                               │
│  ○ Other (specify below)                                         │
│                                                                   │
│  Deactivation Date: * [01/14/2026] 📅                            │
│                                                                   │
│  Details/Notes: *                                                │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │ Subject requested withdrawal due to personal reasons.      │  │
│  │ Exit interview completed. No safety concerns.              │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                   │
│  Post-Deactivation:                                              │
│  ☑ Schedule closeout visit (if applicable)                       │
│  ☑ Collect remaining study materials                             │
│  ☑ Complete case report forms                                    │
│  ☐ Report to sponsor                                             │
│                                                                   │
│  ⚠ This action cannot be undone. Subject will be marked as       │
│     withdrawn and removed from active study population.          │
│                                                                   │
│  [Cancel]                             [Confirm Deactivation]     │
└──────────────────────────────────────────────────────────────────┘
```

## State Workflow
```
[New] → [Screening] → [Eligible] → [Enrolled] → [Completed]
            ↓             ↓            ↓
        [Declined]   [Withdrawn]   [Deactivated]
```

## Data Model
```
Subject {
  SubjectID: string (PK)
  SiteID: string (FK)
  ScreeningID: string (FK)
  Initials: string
  DateOfBirth: date (encrypted)
  Gender: string
  Status: string
  EnrollmentDate: date
  CompletedDate: date
  DeactivationDate: date
  DeactivationReason: string
  IsReadOnly: boolean
}
```
