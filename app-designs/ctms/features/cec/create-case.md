# CEC Feature Specification: Event Case Creation

## Overview

The Event Case Creation feature allows Site Users, Coordinators, and Adjudicators to report clinical events for review and adjudication through the Clinical Event Committee (CEC) process.

## Feature Details

**Feature Name**: Event Case Creation
**Module**: Clinical Event Committee (CEC)
**Actors**: Site User, Coordinator, Adjudicator
**Priority**: High
**Status**: Implementation Ready

## User Stories

1. **As a Site User**, I want to report a clinical event so that it can be reviewed by the CEC
2. **As a Coordinator**, I want to create event cases for events reported by sites so I can manage the review workflow
3. **As an Adjudicator**, I want to report events I identify during review so they can be formally evaluated

## Functional Requirements

### FR-1: Event Identification
- System shall allow users to identify the subject experiencing the event
- System shall support subject search by ID, name, or site
- System shall validate that subject exists in the trial database
- System shall display subject demographics for verification

### FR-2: Event Details Capture
- System shall capture event date and time
- System shall capture event type/category
- System shall capture event description
- System shall capture reporter information
- System shall capture site information
- System shall provide free-text fields for additional details

### FR-3: Save Options
- System shall support "Save Draft" to preserve incomplete cases
- System shall support "Submit" to enter cases into review workflow
- System shall support "Cancel" to discard changes

### FR-4: Validation
- System shall require subject ID
- System shall require event date
- System shall require event description
- System shall validate date formats
- System shall validate date is not in future (configurable)

### FR-5: Status Management
- Draft cases shall have status "Draft"
- Submitted cases shall have status "Pending Coordinator Review"
- System shall track creation date, time, and user
- System shall track submission date, time, and user

## ASCII Art Mockups

### Main Event Case Creation Form

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    John Smith (Coordinator) [Logout] │
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Events > Create New Event Case                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Create New Event Case                                                      │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Subject Information                                                        │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Subject ID: [_____________________] [Search Subject]                       │
│                                                                              │
│  Selected Subject:                                                          │
│  ┌──────────────────────────────────────────────────────────────┐          │
│  │ ID: SUBJ-001234                                               │          │
│  │ Initials: J.D.                                                │          │
│  │ Site: Site 101 - Memorial Hospital                            │          │
│  │ Enrollment Date: 01/15/2025                                   │          │
│  │ Status: Active                                                │          │
│  └──────────────────────────────────────────────────────────────┘          │
│                                                                              │
│  Event Details                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Event Date: [MM/DD/YYYY] ⓘ                Event Time: [HH:MM] (optional)  │
│                                                                              │
│  Event Type: [▼ Select Event Type                              ]           │
│               ├─ Cardiovascular Event                                       │
│               ├─ Death                                                      │
│               ├─ Stroke                                                     │
│               ├─ Myocardial Infarction                                      │
│               ├─ Heart Failure                                              │
│               └─ Other (specify below)                                      │
│                                                                              │
│  Event Category: [▼ Select Category                            ]           │
│                   ├─ Adverse Event                                          │
│                   ├─ Serious Adverse Event                                  │
│                   ├─ Protocol-Specified Event                               │
│                   └─ Other                                                  │
│                                                                              │
│  Event Description: *                                                       │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │                                                                     │    │
│  │                                                                     │    │
│  │                                                                     │    │
│  │                                                                     │    │
│  │                                                                     │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│  (Maximum 2000 characters)                                                  │
│                                                                              │
│  Reporter Information                                                       │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Reported By: [▼ Select Reporter                               ]           │
│                ├─ Site Investigator                                         │
│                ├─ Study Coordinator                                         │
│                ├─ Research Assistant                                        │
│                └─ Other                                                     │
│                                                                              │
│  Reporter Name: [_____________________________]                             │
│                                                                              │
│  Contact Email: [_____________________________]                             │
│                                                                              │
│  Contact Phone: [_____________________________]                             │
│                                                                              │
│  Additional Notes (optional):                                               │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │                                                                     │    │
│  │                                                                     │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [Cancel]  [Save Draft]  [Submit for Review]                                │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘

ⓘ Event date must not be in the future
* Required field
```

### Subject Search Dialog

```
┌─────────────────────────────────────────────────────────────┐
│ Search for Subject                                      [X] │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Search By:                                                 │
│  ○ Subject ID   ● Subject Initials   ○ Site                 │
│                                                              │
│  Search: [J.D._______________] [Search]                     │
│                                                              │
│  Search Results:                                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │ ID          Initials  Site         Status    Enroll  │  │
│  ├──────────────────────────────────────────────────────┤  │
│  │ SUBJ-001234 J.D.      Site 101     Active    01/2025 │◄ │
│  │ SUBJ-002145 J.D.      Site 105     Active    02/2025 │  │
│  │ SUBJ-003021 J.D.      Site 101     Complete  11/2024 │  │
│  │                                                       │  │
│  │                                                       │  │
│  └──────────────────────────────────────────────────────┘  │
│                                                              │
│  Showing 3 results                                          │
│                                                              │
│                                    [Cancel]  [Select]       │
└─────────────────────────────────────────────────────────────┘
```

### Validation Error Display

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    John Smith (Coordinator) [Logout] │
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Events > Create New Event Case                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │ ⚠ Please correct the following errors:                             │    │
│  │   • Subject ID is required                                          │    │
│  │   • Event date is required                                          │    │
│  │   • Event description is required                                   │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  Create New Event Case                                                      │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Subject Information                                                        │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Subject ID: [_____________________] [Search Subject]                       │
│  ⚠ This field is required                                                   │
│                                                                              │
│  Event Details                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Event Date: [__/__/____]    Event Time: [__:__] (optional)                │
│  ⚠ This field is required                                                   │
│                                                                              │
│  Event Type: [▼ Select Event Type                              ]           │
│                                                                              │
│  Event Description: *                                                       │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │                                                                     │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│  ⚠ This field is required                                                   │
│                                                                              │
│  [Cancel]  [Save Draft]  [Submit for Review]                                │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Success Confirmation

```
┌─────────────────────────────────────────────────────────────┐
│ Event Case Created Successfully                        [X] │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ✓ Event case has been successfully created                │
│                                                              │
│  Event ID: EVT-2025-00152                                   │
│  Subject ID: SUBJ-001234                                    │
│  Status: Pending Coordinator Review                         │
│  Created: 01/13/2026 2:45 PM                                │
│                                                              │
│  Next Steps:                                                │
│  • Upload source documents                                  │
│  • Add additional details if available                      │
│  • Coordinator will review and approve for medical review   │
│                                                              │
│  ─────────────────────────────────────────────────          │
│                                                              │
│  [Upload Documents]  [View Event]  [Create Another]  [Done] │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Draft Save Confirmation

```
┌─────────────────────────────────────────────────────────────┐
│ Draft Saved                                             [X] │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ✓ Event case draft has been saved                         │
│                                                              │
│  Draft ID: DRAFT-2025-00089                                 │
│  Last Saved: 01/13/2026 2:45 PM                             │
│                                                              │
│  You can continue editing this draft later from the         │
│  "My Drafts" section.                                       │
│                                                              │
│  ─────────────────────────────────────────────────          │
│                                                              │
│                            [Continue Editing]  [Close]      │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Event List View

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    John Smith (Coordinator) [Logout] │
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Events                                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Event Cases                                           [+ Create New Event] │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Filter By:  [All Status ▼]  [All Sites ▼]  [Date Range ▼]  [Apply]        │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Event ID      Subject     Site    Event Date  Type         Status     │ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ EVT-2025-0152 SUBJ-001234 Site101 01/10/2026  MI           Pending    │ │
│  │ EVT-2025-0151 SUBJ-002341 Site105 01/09/2026  Stroke       Medical Rv │ │
│  │ EVT-2025-0150 SUBJ-001877 Site101 01/08/2026  Heart Fail   Meeting    │ │
│  │ EVT-2025-0149 SUBJ-003124 Site103 01/07/2026  Death        Adjudicated│ │
│  │ EVT-2025-0148 SUBJ-001098 Site101 01/06/2026  CV Event     Adjudicated│ │
│  │ EVT-2025-0147 SUBJ-002789 Site102 01/05/2026  MI           Medical Rv │ │
│  │ EVT-2025-0146 SUBJ-001456 Site101 01/04/2026  Stroke       Info Req   │ │
│  │ EVT-2025-0145 SUBJ-003908 Site104 01/03/2026  Other        Pending    │ │
│  │                                                                        │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Showing 8 of 152 events                          [< Prev]  [Next >]        │
│                                                                              │
│  My Drafts (3)                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ DRAFT-2025-089 SUBJ-001234         01/13/2026  CV Event    [Continue] │ │
│  │ DRAFT-2025-087 SUBJ-002145         01/12/2026  MI          [Continue] │ │
│  │ DRAFT-2025-083 SUBJ-001098         01/11/2026  Stroke      [Continue] │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Non-Functional Requirements

### Performance
- Event creation form shall load within 2 seconds
- Subject search shall return results within 1 second
- Form submission shall complete within 3 seconds

### Usability
- Form shall use clear labels and help text
- Required fields shall be clearly marked with asterisk (*)
- Validation errors shall be displayed inline and in summary
- Date picker shall be provided for date fields
- Tab order shall follow logical field progression

### Security
- User must be authenticated
- User must have CEC Reporter role or higher
- All actions shall be logged in audit trail
- PHI shall be protected according to HIPAA requirements

### Accessibility
- Form shall be keyboard navigable
- Screen reader compatible
- WCAG 2.1 Level AA compliant
- Color shall not be sole indicator of validation status

## Business Rules

### BR-1: Subject Validation
- Subject must exist in trial database
- Subject must be active or completed
- Withdrawn subjects cannot have new events created

### BR-2: Date Validation
- Event date cannot be in the future (configurable)
- Event date must be after subject enrollment date
- Event date must be valid calendar date

### BR-3: Draft Management
- Drafts shall be automatically saved every 2 minutes
- Drafts older than 90 days shall be archived
- Users can only see their own drafts
- Coordinators can see all drafts

### BR-4: Status Workflow
- New events start as "Pending Coordinator Review"
- Draft events have status "Draft"
- Status changes must follow defined workflow

## Data Model

### Event Case
```
EventCase {
  EventID: string (PK)
  SubjectID: string (FK)
  SiteID: string (FK)
  EventDate: date
  EventTime: time (optional)
  EventType: string
  EventCategory: string
  EventDescription: text
  ReporterType: string
  ReporterName: string
  ReporterEmail: string
  ReporterPhone: string
  AdditionalNotes: text
  Status: string
  CreatedBy: string (FK)
  CreatedDate: datetime
  SubmittedBy: string (FK)
  SubmittedDate: datetime
  IsDraft: boolean
  LastModifiedBy: string (FK)
  LastModifiedDate: datetime
}
```

## Integration Points

- **Subject Management**: Retrieve subject information
- **Site Management**: Retrieve site information
- **User Management**: User authentication and authorization
- **Audit Trail**: Log all create/update/submit actions
- **Notification Service**: Notify coordinators of new events

## Testing Scenarios

### Test Case 1: Successful Event Creation
1. Login as Site User
2. Navigate to Create Event Case
3. Search and select subject
4. Enter all required fields
5. Submit event
6. Verify success message
7. Verify event appears in list with correct status

### Test Case 2: Draft Save
1. Login as Coordinator
2. Start creating event
3. Enter partial information
4. Click Save Draft
5. Verify draft saved
6. Navigate away and return
7. Verify draft appears in My Drafts
8. Continue editing draft
9. Complete and submit

### Test Case 3: Validation Errors
1. Login as Site User
2. Navigate to Create Event Case
3. Click Submit without entering data
4. Verify validation errors displayed
5. Verify required fields highlighted
6. Fix errors one by one
7. Verify errors clear as fields are completed
8. Submit successfully

### Test Case 4: Subject Search
1. Navigate to Create Event Case
2. Click Search Subject
3. Enter subject ID
4. Verify correct subject returned
5. Select subject
6. Verify subject details populated
7. Search by initials
8. Verify multiple results
9. Select correct subject

### Test Case 5: Future Date Validation
1. Navigate to Create Event Case
2. Enter future event date
3. Verify validation error
4. Enter past date
5. Verify validation clears
6. Submit successfully

## Open Questions

1. Should system allow multiple events for same subject on same date?
2. Should coordinators be able to create events on behalf of sites?
3. What should happen to drafts when user account is deactivated?
4. Should there be a limit on number of drafts per user?
5. Should system auto-populate reporter information from logged-in user?

## Future Enhancements

1. Bulk event import from CSV/Excel
2. Event templates for common event types
3. Auto-save draft functionality
4. Email notification to coordinators on new events
5. Mobile-responsive design for tablet use at sites
6. Integration with EDC systems for automatic event detection
7. Duplicate event detection
8. Event cloning for similar events
