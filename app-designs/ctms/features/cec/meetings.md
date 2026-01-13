# CEC Feature Specification: Committee Meetings

## Overview

The Committee Meetings feature enables Meeting Managers to schedule CEC meetings, assign adjudicators, collect approved events, and manage the overall meeting lifecycle from planning through completion.

## Feature Details

**Feature Name**: Committee Meeting Management
**Module**: Clinical Event Committee (CEC)
**Actors**: Meeting Manager
**Priority**: High
**Status**: Implementation Ready

## User Stories

1. **As a Meeting Manager**, I want to schedule CEC meetings so that adjudicators know when to attend
2. **As a Meeting Manager**, I want to assign adjudicators to meetings so that we have appropriate expertise
3. **As a Meeting Manager**, I want to collect approved events so I can prepare the meeting agenda
4. **As a Meeting Manager**, I want to notify members so they receive meeting details and materials
5. **As a Meeting Manager**, I want to track meeting attendance so I can confirm quorum

## Functional Requirements

### FR-1: Meeting Scheduling
- System shall allow creation of new meetings
- System shall capture meeting date, time, and duration
- System shall capture meeting location (physical or virtual)
- System shall capture dial-in/video conference information
- System shall support recurring meeting schedules

### FR-2: Adjudicator Assignment
- System shall display list of available adjudicators
- System shall allow selection of adjudicators for meeting
- System shall check for conflicts of interest
- System shall validate quorum requirements
- System shall track adjudicator specialties/expertise

### FR-3: Event Collection
- System shall identify events approved for adjudication
- System shall allow selection of events for specific meeting
- System shall organize events by priority/type
- System shall prevent duplicate event assignments
- System shall generate meeting packet materials

### FR-4: Meeting Notifications
- System shall send calendar invitations to assigned adjudicators
- System shall send reminder notifications
- System shall include meeting agenda and materials
- System shall track notification delivery status
- System shall allow manual notification resend

### FR-5: Meeting Materials
- System shall generate meeting agenda
- System shall compile event summaries
- System shall package source documents
- System shall include medical review summaries
- System shall create adjudicator worksheets

### FR-6: Attendance Tracking
- System shall record adjudicator attendance
- System shall validate quorum at meeting start
- System shall track partial attendance
- System shall record attendance timestamps
- System shall allow late arrivals/early departures

### FR-7: Meeting Status Management
- System shall track meeting status (Scheduled, In Progress, Completed, Cancelled)
- System shall prevent changes to completed meetings
- System shall allow meeting postponement
- System shall handle meeting cancellations
- System shall track status change history

## ASCII Art Mockups

### Meeting List View

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    Lisa Johnson (Meeting Mgr) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Meetings                                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  CEC Meetings                                            [+ Schedule Meeting]│
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Upcoming │ Past │ Cancelled                                                │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Meeting ID    Date/Time           Location      Events  Members Status │ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ MTG-2026-015  01/20/2026 2:00 PM  Virtual        12      8      Ready  │◄│
│  │               Duration: 3 hours    Zoom Room A                          │ │
│  │               [View Details] [Edit] [Send Reminders] [Start Meeting]   │ │
│  │                                                                         │ │
│  │ MTG-2026-016  01/27/2026 2:00 PM  Virtual         8      7      Draft  │ │
│  │               Duration: 2 hours    Zoom Room A                          │ │
│  │               [View Details] [Edit] [Send Invitations]                 │ │
│  │                                                                         │ │
│  │ MTG-2026-017  02/03/2026 2:00 PM  Virtual         0      0      Draft  │ │
│  │               Duration: 2 hours    Zoom Room A                          │ │
│  │               [View Details] [Edit] [Add Events] [Assign Members]      │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Status Legend:                                                             │
│  • Draft = Meeting created, incomplete setup                                │
│  • Ready = Events and members assigned, ready to start                      │
│  • In Progress = Meeting currently underway                                 │
│  • Completed = Meeting finished, decisions recorded                         │
│                                                                              │
│  Recent Meetings (Last 3)                                                   │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ MTG-2026-014  01/13/2026 2:00 PM  Completed  15 events,  8 adjudicators│ │
│  │ MTG-2026-013  01/06/2026 2:00 PM  Completed  18 events,  9 adjudicators│ │
│  │ MTG-2025-012  12/16/2025 2:00 PM  Completed  12 events,  8 adjudicators│ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Create/Edit Meeting Screen

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    Lisa Johnson (Meeting Mgr) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Meetings > Schedule New Meeting                                 │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Schedule CEC Meeting                                        [Save] [Cancel]│
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Meeting Information                                                        │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Meeting ID: [Auto-generated upon save]                                    │
│                                                                              │
│  Meeting Date: * [01/20/2026] 📅    Time: * [02:00 PM ▼]  Timezone: EST    │
│                                                                              │
│  Duration: * [3 hours ▼]                                                    │
│             ├─ 1 hour                                                       │
│             ├─ 2 hours                                                      │
│             ├─ 3 hours                                                      │
│             ├─ 4 hours                                                      │
│             └─ Custom (specify)                                             │
│                                                                              │
│  Meeting Type:                                                              │
│  ● Regular Meeting   ○ Emergency Meeting   ○ Special Review                 │
│                                                                              │
│  Location Type:                                                             │
│  ● Virtual Meeting   ○ In-Person   ○ Hybrid                                 │
│                                                                              │
│  ┌─ Virtual Meeting Details ──────────────────────────────────────────┐    │
│  │                                                                     │    │
│  │  Platform: [▼ Select Platform          ]                           │    │
│  │             ├─ Zoom                                                 │    │
│  │             ├─ Microsoft Teams                                      │    │
│  │             ├─ WebEx                                                │    │
│  │             └─ Other                                                │    │
│  │                                                                     │    │
│  │  Meeting Room: [Zoom Room A_________]                               │    │
│  │                                                                     │    │
│  │  Meeting Link: [https://zoom.us/j/123456789_________________]      │    │
│  │                                                                     │    │
│  │  Meeting ID: [123 456 789_______]  Passcode: [abc123______]        │    │
│  │                                                                     │    │
│  │  Dial-In Number: [(555) 123-4567_______]                            │    │
│  │                                                                     │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  Meeting Notes/Agenda Overview (optional):                                  │
│  ┌────────────────────────────────────────────────────────────────────┐    │
│  │ Regular monthly CEC meeting to review cardiovascular events.       │    │
│  │                                                                     │    │
│  └────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  Recurring Meeting:                                                         │
│  ☐ This is a recurring meeting                                              │
│     Frequency: [▼ Select      ]  Every: [1 ▼] [Weeks ▼]  On: ☐ M ☐ T ☑ W  │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [Cancel]  [Save Draft]  [Save and Assign Members >]                        │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Assign Adjudicators Screen

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    Lisa Johnson (Meeting Mgr) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Meetings > MTG-2026-015 > Assign Members                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Assign Adjudicators - MTG-2026-015                      [Save] [Cancel]    │
│  Meeting: January 20, 2026 at 2:00 PM EST                                   │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Quorum Requirements:                                                       │
│  Minimum Required: 5 adjudicators    Currently Assigned: 8    ✓ Met        │
│                                                                              │
│  ┌─────────────────────────────────────┬────────────────────────────────┐  │
│  │ Available Adjudicators              │ Assigned to This Meeting (8)   │  │
│  │ (15 total)                          │                                │  │
│  ├─────────────────────────────────────┼────────────────────────────────┤  │
│  │                                     │                                │  │
│  │ Search: [____________] 🔍           │ ☑ Dr. Robert Martinez          │  │
│  │                                     │   Cardiology - Interventional  │  │
│  │ Filter by Specialty:                │   Available  [Remove]          │  │
│  │ [All Specialties ▼]                 │                                │  │
│  │                                     │ ☑ Dr. Emily Thompson           │  │
│  │ ☐ Dr. James Anderson                │   Cardiology - Heart Failure   │  │
│  │   Cardiology - Electrophysiology    │   Available  [Remove]          │  │
│  │   Unavailable (Conflict: Site 101)  │                                │  │
│  │                                     │ ☑ Dr. Michael Chang            │  │
│  │ ☐ Dr. Patricia Brown                │   Neurology - Stroke           │  │
│  │   Neurology - Vascular              │   Available  [Remove]          │  │
│  │   Available        [+ Assign]       │                                │  │
│  │                                     │ ☑ Dr. Lisa Anderson            │  │
│  │ ☐ Dr. William Davis                 │   Cardiology - General         │  │
│  │   Cardiology - Imaging              │   Available  [Remove]          │  │
│  │   Available        [+ Assign]       │                                │  │
│  │                                     │ ☑ Dr. David Kim                │  │
│  │ ☐ Dr. Jennifer Garcia               │   Emergency Medicine           │  │
│  │   Critical Care                     │   Available  [Remove]          │  │
│  │   Available        [+ Assign]       │                                │  │
│  │                                     │ ☑ Dr. Sarah Williams           │  │
│  │ ☐ Dr. Christopher Lee               │   Cardiology - Preventive      │  │
│  │   Cardiology - General              │   Available  [Remove]          │  │
│  │   Tentative (Check calendar)        │                                │  │
│  │                            [+ Assign]│ ☑ Dr. James Wilson             │  │
│  │                                     │   Internal Medicine            │  │
│  │ ... 9 more adjudicators             │   Available  [Remove]          │  │
│  │ [Show All]                          │                                │  │
│  │                                     │ ☑ Dr. Amanda Rodriguez         │  │
│  │                                     │   Cardiology - Interventional  │  │
│  │                                     │   Tentative  [Remove]          │  │
│  │                                     │                                │  │
│  └─────────────────────────────────────┴────────────────────────────────┘  │
│                                                                              │
│  Role Assignments:                                                          │
│  Committee Chair: [Dr. Robert Martinez ▼]                                   │
│  Vice Chair:      [Dr. Emily Thompson ▼]                                    │
│  Secretary:       [Dr. Michael Chang ▼]                                     │
│                                                                              │
│  Conflicts of Interest Detected:                                            │
│  ⚠ Dr. James Anderson - Has involvement with Site 101 (2 events in agenda)  │
│                                                                              │
│  Specialty Coverage:                                                        │
│  Cardiology: ████████░ 6    Neurology: ██░░░░░░░ 1    Other: ██░░░░░░░ 1    │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [< Back to Meeting Details]  [Cancel]  [Save and Send Invitations >]       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Collect Events for Meeting

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    Lisa Johnson (Meeting Mgr) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Meetings > MTG-2026-015 > Collect Events                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Collect Events for Meeting - MTG-2026-015               [Save] [Cancel]    │
│  Meeting: January 20, 2026 at 2:00 PM EST                                   │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Meeting Capacity: 12 events selected / 15 maximum (estimated 20 min each)  │
│  ████████████████████░░░░░░ 80%                                             │
│                                                                              │
│  ┌─────────────────────────────────────┬────────────────────────────────┐  │
│  │ Available Events (28)               │ Selected for Meeting (12)      │  │
│  │ Approved for Adjudication           │                                │  │
│  ├─────────────────────────────────────┼────────────────────────────────┤  │
│  │                                     │                                │  │
│  │ Filter: [All Types ▼] [All Sites ▼]│ Sort by: [Priority ▼]          │  │
│  │                                     │                                │  │
│  │ ☐ EVT-2025-0152  SUBJ-001234        │ 1. EVT-2025-0148 (High)        │  │
│  │   Type: MI    Site: 101   HIGH      │    MI - SUBJ-001098            │  │
│  │   Approved: 01/12/26   [+ Add]      │    Medical Rv: Dr. Chen        │  │
│  │                                     │    [↑] [↓] [Remove] [Details]  │  │
│  │ ☐ EVT-2025-0151  SUBJ-002341        │                                │  │
│  │   Type: Stroke  Site: 105  HIGH     │ 2. EVT-2025-0150 (High)        │  │
│  │   Approved: 01/12/26   [+ Add]      │    Heart Failure - SUBJ-001877 │  │
│  │                                     │    Medical Rv: Dr. Chen        │  │
│  │ ☐ EVT-2025-0147  SUBJ-002789        │    [↑] [↓] [Remove] [Details]  │  │
│  │   Type: MI    Site: 102   NORMAL    │                                │  │
│  │   Approved: 01/11/26   [+ Add]      │ 3. EVT-2025-0149 (High)        │  │
│  │                                     │    Death - SUBJ-003124         │  │
│  │ ☐ EVT-2025-0146  SUBJ-001456        │    Medical Rv: Dr. Lee         │  │
│  │   Type: Stroke  Site: 101  NORMAL   │    [↑] [↓] [Remove] [Details]  │  │
│  │   Approved: 01/11/26   [+ Add]      │                                │  │
│  │                                     │ 4. EVT-2025-0145 (Normal)      │  │
│  │ ☐ EVT-2025-0144  SUBJ-003908        │    CV Event - SUBJ-002341      │  │
│  │   Type: Other   Site: 104  NORMAL   │    Medical Rv: Dr. Patel       │  │
│  │   Approved: 01/10/26   [+ Add]      │    [↑] [↓] [Remove] [Details]  │  │
│  │                                     │                                │  │
│  │ ... 23 more events                  │ ... 8 more events              │  │
│  │ [Show All]                          │ [View Full Agenda]             │  │
│  │                                     │                                │  │
│  └─────────────────────────────────────┴────────────────────────────────┘  │
│                                                                              │
│  Event Type Distribution:                                                   │
│  MI: 5  Stroke: 3  Heart Failure: 2  Death: 1  Other: 1                    │
│                                                                              │
│  Auto-Select Options:                                                       │
│  [Add All High Priority]  [Add by Date (Oldest First)]  [Clear Selection]   │
│                                                                              │
│  Meeting Materials:                                                         │
│  ☑ Generate meeting agenda                                                  │
│  ☑ Generate event summaries for adjudicators                                │
│  ☑ Include source documents in packet                                       │
│  ☑ Include medical review summaries                                         │
│  ☐ Include adjudication worksheets                                          │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [< Back]  [Cancel]  [Save Event Selection]  [Generate Materials >]         │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Send Meeting Notifications

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Send Meeting Notifications                                             [X]  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Meeting: MTG-2026-015                                                      │
│  Date/Time: January 20, 2026 at 2:00 PM EST                                │
│  Location: Virtual (Zoom Room A)                                            │
│  Assigned Adjudicators: 8                                                   │
│  Events: 12                                                                 │
│                                                                              │
│  Notification Type:                                                         │
│  ● Initial Meeting Invitation                                               │
│  ○ Reminder Notification (1 week before)                                    │
│  ○ Reminder Notification (1 day before)                                     │
│  ○ Meeting Update/Change                                                    │
│                                                                              │
│  Recipients: (8 adjudicators)                                               │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │ ☑ Dr. Robert Martinez (Chair)     - rmartinez@hospital.org           │  │
│  │ ☑ Dr. Emily Thompson (Vice Chair) - ethompson@clinic.edu             │  │
│  │ ☑ Dr. Michael Chang (Secretary)   - mchang@medical.org               │  │
│  │ ☑ Dr. Lisa Anderson               - landerson@hospital.org           │  │
│  │ ☑ Dr. David Kim                   - dkim@health.org                  │  │
│  │ ☑ Dr. Sarah Williams              - swilliams@medical.edu            │  │
│  │ ☑ Dr. James Wilson                - jwilson@clinic.org               │  │
│  │ ☑ Dr. Amanda Rodriguez            - arodriguez@hospital.org          │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  Notification Content:                                                      │
│  ☑ Calendar invitation (.ics file)                                          │
│  ☑ Meeting agenda                                                           │
│  ☑ Event summary list (de-identified)                                       │
│  ☑ Zoom/dial-in details                                                     │
│  ☑ Pre-reading materials package                                            │
│  ☐ Individual event packets (sent 3 days before)                            │
│                                                                              │
│  Email Preview:                                                             │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │ Subject: CEC Meeting Invitation - January 20, 2026                   │  │
│  │                                                                       │  │
│  │ Dear Dr. Martinez,                                                   │  │
│  │                                                                       │  │
│  │ You are invited to attend the Clinical Event Committee meeting:     │  │
│  │                                                                       │  │
│  │ Date: Monday, January 20, 2026                                       │  │
│  │ Time: 2:00 PM - 5:00 PM EST                                          │  │
│  │ Location: Virtual Meeting (Zoom)                                     │  │
│  │                                                                       │  │
│  │ Meeting Link: https://zoom.us/j/123456789                            │  │
│  │ Meeting ID: 123 456 789                                              │  │
│  │ Passcode: abc123                                                     │  │
│  │                                                                       │  │
│  │ This meeting will review 12 events. Please review the attached      │  │
│  │ agenda and materials prior to the meeting.                           │  │
│  │                                                                       │  │
│  │ Attachments:                                                         │  │
│  │ - Meeting Agenda                                                     │  │
│  │ - Event Summary List                                                 │  │
│  │ - Pre-Reading Materials                                              │  │
│  │ - Calendar Invitation                                                │  │
│  │                                                                       │  │
│  │ Please confirm your attendance...                                    │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  Schedule:                                                                  │
│  ● Send immediately                                                         │
│  ○ Schedule for: [__/__/____] at [__:__ __]                                │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│                                     [Cancel]  [Send Notifications]          │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Meeting Dashboard/Details View

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    Lisa Johnson (Meeting Mgr) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Meetings > MTG-2026-015                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Meeting MTG-2026-015                                        [Edit] [Actions▼]│
│  Status: Ready                                                               │
│                                                                              │
│  ┌─ Details ─┬─ Members ─┬─ Events ─┬─ Materials ─┬─ Attendance ─┐        │
│  │           │           │          │             │              │        │
│  └───────────┴───────────┴──────────┴─────────────┴──────────────┘        │
│                                                                              │
│  Meeting Information                                                        │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Meeting ID:        MTG-2026-015                                         │ │
│  │ Date/Time:         Monday, January 20, 2026 at 2:00 PM EST             │ │
│  │ Duration:          3 hours (2:00 PM - 5:00 PM)                          │ │
│  │ Type:              Regular Meeting                                      │ │
│  │ Location:          Virtual Meeting                                      │ │
│  │ Platform:          Zoom                                                 │ │
│  │ Meeting Link:      https://zoom.us/j/123456789                          │ │
│  │ Meeting ID:        123 456 789                                          │ │
│  │ Passcode:          abc123                                               │ │
│  │ Dial-In:           (555) 123-4567                                       │ │
│  │                                                                         │ │
│  │ Created By:        Lisa Johnson on 01/05/2026                           │ │
│  │ Last Modified:     01/13/2026 3:45 PM                                   │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Quick Stats                                                                │
│  ┌───────────────┬───────────────┬───────────────┬───────────────────────┐ │
│  │ Adjudicators  │ Events        │ Confirmed     │ Materials             │ │
│  │               │               │ Attendance    │                       │ │
│  │      8        │      12       │      7        │ ✓ Generated           │ │
│  │               │               │               │   01/13/2026          │ │
│  └───────────────┴───────────────┴───────────────┴───────────────────────┘ │
│                                                                              │
│  Quorum Status                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Required: 5 adjudicators    Confirmed: 7    Tentative: 1               │ │
│  │ ████████████████░░░░ Quorum Met ✓                                      │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Notifications Sent                                                         │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ✓ Initial Invitations    01/06/2026  8/8 delivered                     │ │
│  │ ✓ 1-Week Reminder         01/13/2026  8/8 delivered                     │ │
│  │ ⏱ 1-Day Reminder          Scheduled for 01/19/2026 2:00 PM             │ │
│  │ ⏱ Day-Of Reminder         Scheduled for 01/20/2026 9:00 AM             │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Actions                                                                    │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ [View Agenda]  [Download Materials]  [Send Reminder]  [Start Meeting]  │ │
│  │ [Edit Meeting]  [Add Events]  [Manage Members]  [Cancel Meeting]       │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Meeting Agenda View

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                    Lisa Johnson (Meeting Mgr) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Meetings > MTG-2026-015 > Agenda                                │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  CEC Meeting Agenda                                    [Print] [Export PDF] │
│  MTG-2026-015 - January 20, 2026                                            │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Meeting Details                                                            │
│  Date: Monday, January 20, 2026                                             │
│  Time: 2:00 PM - 5:00 PM EST (3 hours)                                      │
│  Location: Virtual Meeting via Zoom                                         │
│  Zoom Link: https://zoom.us/j/123456789                                     │
│                                                                              │
│  Committee Members (8)                                                      │
│  Chair: Dr. Robert Martinez                                                 │
│  Vice Chair: Dr. Emily Thompson                                             │
│  Secretary: Dr. Michael Chang                                               │
│  Members: Dr. Lisa Anderson, Dr. David Kim, Dr. Sarah Williams,             │
│           Dr. James Wilson, Dr. Amanda Rodriguez                            │
│                                                                              │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  I. Call to Order (2:00 PM - 2:05 PM)                                       │
│     - Welcome and attendance                                                │
│     - Quorum verification                                                   │
│     - Review of agenda                                                      │
│                                                                              │
│  II. Review of Previous Meeting Minutes (2:05 PM - 2:10 PM)                 │
│     - Approval of MTG-2026-014 minutes (01/13/2026)                         │
│                                                                              │
│  III. Event Adjudications (2:10 PM - 4:45 PM)                               │
│       12 events for review (approx. 20 minutes each)                        │
│                                                                              │
│     HIGH PRIORITY EVENTS (3)                                                │
│                                                                              │
│     1. EVT-2025-0148 - Myocardial Infarction (2:10 PM - 2:30 PM)            │
│        Subject: SUBJ-001098 (J.R., 72M)                                     │
│        Site: Site 101 - Memorial Hospital                                   │
│        Event Date: 01/06/2026                                               │
│        Medical Reviewer: Dr. Sarah Chen                                     │
│        Preliminary: Confirmed STEMI, Anterior Wall                          │
│                                                                              │
│     2. EVT-2025-0150 - Heart Failure Hospitalization (2:30 PM - 2:50 PM)    │
│        Subject: SUBJ-001877 (M.T., 68F)                                     │
│        Site: Site 101 - Memorial Hospital                                   │
│        Event Date: 01/08/2026                                               │
│        Medical Reviewer: Dr. Sarah Chen                                     │
│        Preliminary: Confirmed Acute Decompensated HF                        │
│                                                                              │
│     3. EVT-2025-0149 - Death (2:50 PM - 3:10 PM)                            │
│        Subject: SUBJ-003124 (R.K., 75M)                                     │
│        Site: Site 103 - Regional Medical Center                             │
│        Event Date: 01/07/2026                                               │
│        Medical Reviewer: Dr. Michael Lee                                    │
│        Preliminary: Cardiovascular Death - MI                               │
│                                                                              │
│     BREAK (3:10 PM - 3:20 PM)                                               │
│                                                                              │
│     REGULAR PRIORITY EVENTS (9)                                             │
│                                                                              │
│     4. EVT-2025-0145 - CV Event (3:20 PM - 3:40 PM)                         │
│        Subject: SUBJ-002341, Site 105, Date: 01/01/2026                     │
│        Reviewer: Dr. Patel, Preliminary: Confirmed Unstable Angina          │
│                                                                              │
│     5-12. [Additional events listed with same format...]                    │
│                                                                              │
│  IV. New Business (4:45 PM - 4:55 PM)                                       │
│      - Upcoming meeting schedule                                            │
│      - Process improvements                                                 │
│                                                                              │
│  V. Adjournment (4:55 PM - 5:00 PM)                                         │
│                                                                              │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Attachments:                                                               │
│  - Event Detail Packets (12)                                                │
│  - Medical Review Summaries                                                 │
│  - Source Documents (available electronically)                              │
│  - Adjudication Worksheets                                                  │
│  - Previous Meeting Minutes                                                 │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Attendance Tracking

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Meeting Attendance - MTG-2026-015                                       [X] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Meeting: January 20, 2026 at 2:00 PM EST                                  │
│  Current Time: 2:05 PM                                                      │
│                                                                              │
│  Quorum Status: ✓ MET (7 of 8 present, 5 required)                          │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Member Name              Status      Arrival    Departure  Present     │ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ Dr. Robert Martinez      ✓ Present  2:00 PM    -          Yes         │ │
│  │ (Chair)                                                                │ │
│  │                                                                        │ │
│  │ Dr. Emily Thompson       ✓ Present  2:00 PM    -          Yes         │ │
│  │ (Vice Chair)                                                           │ │
│  │                                                                        │ │
│  │ Dr. Michael Chang        ✓ Present  2:00 PM    -          Yes         │ │
│  │ (Secretary)                                                            │ │
│  │                                                                        │ │
│  │ Dr. Lisa Anderson        ✓ Present  2:02 PM    -          Yes         │ │
│  │                                                                        │ │
│  │ Dr. David Kim            ✓ Present  2:00 PM    -          Yes         │ │
│  │                                                                        │ │
│  │ Dr. Sarah Williams       ✓ Present  2:01 PM    -          Yes         │ │
│  │                                                                        │ │
│  │ Dr. James Wilson         ✓ Present  2:00 PM    -          Yes         │ │
│  │                                                                        │ │
│  │ Dr. Amanda Rodriguez     ✗ Absent   -          -          No          │ │
│  │                          Excused: Prior commitment                     │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Mark Attendance:                                                           │
│  Select Member: [Dr. Amanda Rodriguez ▼]                                    │
│                                                                              │
│  Action: ● Mark Present   ○ Mark Absent (Excused)   ○ Mark Absent (Unexcused)│
│                                                                              │
│  Arrival Time: [02:__ PM]     (Leave blank if marking absent)               │
│                                                                              │
│  Notes: [_________________________________________________]                 │
│                                                                              │
│  [Update Attendance]                                                        │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Meeting Actions:                                                           │
│  [Confirm Quorum]  [Generate Attendance Report]  [Close Attendance]         │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Non-Functional Requirements

### Performance
- Meeting list shall load within 2 seconds
- Agenda generation shall complete within 10 seconds
- Material package creation shall complete within 30 seconds
- Notification sending shall process within 1 minute

### Usability
- Calendar integration for meeting scheduling
- Drag-and-drop event reordering in agenda
- One-click reminder sending
- Auto-save of meeting edits

### Security
- Only authorized meeting managers can create meetings
- Adjudicator assignments logged in audit trail
- Meeting materials access controlled
- Attendance records immutable after meeting completion

### Accessibility
- WCAG 2.1 Level AA compliant
- Screen reader compatible
- Keyboard navigation
- High contrast support

## Business Rules

### BR-1: Quorum Requirements
- Minimum 5 adjudicators required for valid meeting
- Quorum must be met at meeting start
- If quorum lost during meeting, remaining decisions deferred

### BR-2: Conflict of Interest
- Adjudicators with COI for specific events flagged
- Adjudicators must recuse from events with COI
- System prevents voting on COI events

### BR-3: Meeting Scheduling
- Meetings cannot be scheduled in past
- Minimum 7 days notice for regular meetings
- Emergency meetings allowed with 24 hours notice
- No more than one meeting per day

### BR-4: Event Assignment
- Events must be approved for adjudication before adding to meeting
- Events cannot be in multiple active meetings
- Maximum 20 events per meeting (configurable)
- High priority events should be scheduled first

### BR-5: Notifications
- Initial invitation sent immediately after member assignment
- 1-week reminder automatic
- 1-day reminder automatic
- Day-of reminder 3 hours before meeting

## Data Model

```
Meeting {
  MeetingID: string (PK)
  MeetingDate: date
  MeetingTime: time
  Duration: integer (minutes)
  MeetingType: string
  LocationType: string
  VirtualPlatform: string
  MeetingLink: string
  MeetingPasscode: string
  DialInNumber: string
  Status: string
  QuorumRequired: integer
  QuorumMet: boolean
  CreatedBy: string (FK)
  CreatedDate: datetime
  LastModified: datetime
}

MeetingMember {
  MemberID: string (PK)
  MeetingID: string (FK)
  AdjudicatorID: string (FK)
  Role: string (Chair, Vice Chair, Secretary, Member)
  InvitationSent: boolean
  InvitationDate: datetime
  ConfirmationStatus: string
  AttendanceStatus: string
  ArrivalTime: datetime
  DepartureTime: datetime
  COIEvents: json
}

MeetingEvent {
  MeetingEventID: string (PK)
  MeetingID: string (FK)
  EventID: string (FK)
  AgendaOrder: integer
  EstimatedDuration: integer
  Priority: string
  Presenter: string (FK)
}

MeetingNotification {
  NotificationID: string (PK)
  MeetingID: string (FK)
  NotificationType: string
  SentDate: datetime
  Recipients: json
  DeliveryStatus: json
}
```

## Integration Points

- **Calendar Systems**: Integration with Outlook/Google Calendar
- **Video Conferencing**: Zoom/Teams API for meeting creation
- **Email Service**: Notification delivery
- **Event Management**: Retrieve approved events
- **User Management**: Adjudicator availability and roles
- **Document Generation**: Agenda and materials creation

## Testing Scenarios

### Test Case 1: Schedule Complete Meeting
1. Login as Meeting Manager
2. Create new meeting
3. Set date, time, location
4. Assign 8 adjudicators
5. Verify quorum met
6. Collect 12 events
7. Generate materials
8. Send invitations
9. Verify all notifications delivered
10. Verify meeting status "Ready"

### Test Case 2: Conflict of Interest Detection
1. Create meeting
2. Assign adjudicators
3. Add events
4. System detects COI
5. Verify warning displayed
6. Review COI details
7. Remove adjudicator or event
8. Verify COI cleared

### Test Case 3: Meeting Cancellation
1. Create scheduled meeting
2. Send invitations
3. Cancel meeting
4. Specify cancellation reason
5. Send cancellation notices
6. Verify events returned to available pool
7. Verify members notified
8. Verify meeting status "Cancelled"

## Future Enhancements

1. Automated meeting scheduling based on event backlog
2. AI-suggested adjudicator assignments based on expertise
3. Real-time quorum tracking during virtual meetings
4. Automated meeting minutes generation
5. Integration with institutional calendars
6. Mobile app for adjudicators
7. Post-meeting survey/feedback
8. Recurring meeting templates
9. Multi-site coordinated meeting scheduling
10. Analytics on meeting efficiency and patterns
