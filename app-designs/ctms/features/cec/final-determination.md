# CEC Feature Specification: Final Determination & Consensus Reporting

## Overview

The Final Determination feature manages the recording, reporting, and distribution of CEC consensus decisions to stakeholders, ensuring accurate communication of adjudicated event classifications.

## Feature Details

**Feature Name**: Final Determination and Consensus Reporting
**Module**: Clinical Event Committee (CEC)
**Actors**: Meeting Manager, Sponsor, Primary Researcher
**Priority**: High
**Status**: Implementation Ready

## User Stories

1. **As a Meeting Manager**, I want to finalize meeting decisions so they can be communicated to stakeholders
2. **As a Sponsor**, I want to view adjudicated events so I can track trial safety
3. **As a Primary Researcher**, I want to generate reports so I can analyze event patterns
4. **As a Coordinator**, I want to notify sites of decisions so they can update records
5. **As a System**, I want to lock finalized decisions so they cannot be altered

## Functional Requirements

### FR-1: Decision Finalization
- Record all adjudication outcomes
- Lock finalized decisions from editing
- Generate decision summaries
- Capture dissenting opinions
- Track decision metadata

### FR-2: Consensus Reporting
- List all adjudicated events
- Filter by classification, site, date
- Display consensus levels
- Show decision details
- Export reports in multiple formats

### FR-3: Stakeholder Notifications
- Notify sites of event decisions
- Notify sponsors of safety events
- Distribute meeting minutes
- Send regulatory notifications
- Track notification delivery

### FR-4: Reporting and Analytics
- Generate summary statistics
- Analyze event trends
- Compare sites/regions
- Track processing timelines
- Create regulatory reports

## ASCII Art Mockups

### Final Determination Dashboard

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                   Lisa Johnson (Meeting Mgr) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Final Determinations                                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Adjudicated Events - Final Determinations                [Export] [Reports]│
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Summary Statistics (Last 30 Days)                                          │
│  ┌──────────────┬──────────────┬──────────────┬──────────────────────────┐ │
│  │ Total Events │ Confirmed MI │ Confirmed    │ Consensus               │ │
│  │ Adjudicated  │              │ Stroke       │ Distribution            │ │
│  │             │             │              │                         │ │
│  │     45       │     18       │      12      │ Unanimous: 62%          │ │
│  │              │              │              │ Strong: 31%             │ │
│  │              │              │              │ Moderate: 7%            │ │
│  └──────────────┴──────────────┴──────────────┴──────────────────────────┘ │
│                                                                              │
│  Filter By:                                                                 │
│  Meeting: [Last 3 Months ▼]  Classification: [All ▼]  Site: [All ▼]        │
│  Consensus: [All ▼]  Date Range: [01/01/2026 - 01/31/2026]  [Apply]        │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Event ID      Subject    Meeting     Decision          Consensus  Site │ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ EVT-2025-0148 SUBJ-001098 MTG-015    Confirmed STEMI   Unanimous   101 │ │
│  │               72M         01/20/26    Type 1, Anterior  7/7 (100%)     │ │
│  │               [View Details] [Generate Report] [Notify Site]           │ │
│  │                                                                        │ │
│  │ EVT-2025-0150 SUBJ-001877 MTG-015    Confirmed CHF     Strong      101 │ │
│  │               68F         01/20/26    Hospitalization   6/7 (86%)      │ │
│  │               [View Details] [Generate Report] [Notify Site]           │ │
│  │                                                                        │ │
│  │ EVT-2025-0149 SUBJ-003124 MTG-015    CV Death - MI     Unanimous   103 │ │
│  │               75M         01/20/26    Definite          7/7 (100%)     │ │
│  │               [View Details] [Generate Report] [Notify Site]           │ │
│  │                                                                        │ │
│  │ EVT-2025-0151 SUBJ-002341 MTG-015    Confirmed Stroke  Strong      105 │ │
│  │               63F         01/20/26    Ischemic          6/7 (86%)      │ │
│  │               [View Details] [Generate Report] [Notify Site]           │ │
│  │                                                                        │ │
│  │ ... 41 more events                                    [Show More]      │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Pending Notifications: 12 events     [Send All Pending Notifications]      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Event Determination Detail View

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                   Lisa Johnson (Meeting Mgr) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Final Determinations > EVT-2025-0148                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Final Determination - EVT-2025-0148                     [Print] [Export]   │
│  Status: ✓ Adjudicated (LOCKED)                                             │
│                                                                              │
│  Subject Information                                                        │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Subject ID: SUBJ-001098          Initials: J.R.                        │ │
│  │ Age/Gender: 72M                   Site: 101 - Memorial Hospital        │ │
│  │ Event Date: 01/06/2026            Reported: 01/07/2026                 │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Adjudication Details                                                       │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Meeting: MTG-2026-015 (01/20/2026)                                     │ │
│  │ Committee Chair: Dr. Robert Martinez                                    │ │
│  │ Adjudicators Present: 7 of 8                                           │ │
│  │ Voting Date/Time: 01/20/2026 at 2:25 PM EST                            │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Final Classification                                                       │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  CONFIRMED MYOCARDIAL INFARCTION                                        │ │
│  │                                                                         │ │
│  │  Classification Details:                                                │ │
│  │  • Type: STEMI (ST-Elevation Myocardial Infarction)                    │ │
│  │  • Universal Definition: Type 1 - Spontaneous MI                       │ │
│  │  • Location: Anterior Wall                                             │ │
│  │  • Certainty: High (>90%)                                              │ │
│  │                                                                         │ │
│  │  Consensus: UNANIMOUS (7/7 votes - 100%)                                │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Committee Summary                                                          │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ 72-year-old male with classic presentation of acute anterior STEMI.    │ │
│  │ ECG demonstrated ST elevation in V2-V4. Cardiac biomarkers significantly│ │
│  │ elevated (Troponin 3.8 ng/mL). Emergent cardiac catheterization revealed│ │
│  │ 95% occlusion of LAD with successful PCI and DES placement. All        │ │
│  │ Universal Definition criteria for Type 1 STEMI met. Documentation      │ │
│  │ complete and diagnosis confirmed unanimously by committee.              │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Individual Adjudicator Votes                                               │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ All 7 adjudicators voted: Confirmed MI - Type 1 STEMI, Anterior        │ │
│  │ Consensus achieved on first vote. No dissenting opinions.              │ │
│  │ [View Detailed Voting Record]                                          │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Timeline                                                                   │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Event Occurred:        01/06/2026                                      │ │
│  │ Reported to CEC:       01/07/2026 (1 day)                              │ │
│  │ Coordinator Review:    01/08/2026 - 01/10/2026 (2 days)                │ │
│  │ Medical Review:        01/11/2026 - 01/12/2026 (1 day)                 │ │
│  │ Approved for Meeting:  01/13/2026                                      │ │
│  │ Committee Adjudication: 01/20/2026                                      │ │
│  │ Total Processing Time: 14 days                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Notifications                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ✓ Site Notification Sent: 01/21/2026 9:00 AM (Delivered)               │ │
│  │ ✓ Sponsor Notification Sent: 01/21/2026 9:00 AM (Delivered)            │ │
│  │ ✓ Regulatory Report Generated: 01/21/2026 (Available)                  │ │
│  │ [Resend Notifications]  [View Notification History]                    │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Actions                                                                    │
│  [Generate Final Report]  [Send to Site]  [Download Decision Letter]        │
│                                                                              │
│  ⓘ This decision is LOCKED and cannot be modified. Contact CEC Chair for   │
│     questions or appeals.                                                   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Consensus Reports

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                   Primary Researcher View    [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Reports                                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  CEC Consensus Reports                                    [Export] [Schedule]│
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Report Type Selection                                                      │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ● Event Classification Summary                                          │ │
│  │ ○ Adjudication Status by Site/Region                                   │ │
│  │ ○ Event Processing Timeline Analysis                                   │ │
│  │ ○ Consensus Quality Metrics                                            │ │
│  │ ○ Adjudicator Participation Report                                     │ │
│  │ ○ HIPAA Violations Report                                              │ │
│  │ ○ Events Without Source Documents                                      │ │
│  │ ○ Custom Report Builder                                                │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Event Classification Summary                                               │
│  Date Range: [01/01/2025 - 01/31/2026]  [Apply]                             │
│                                                                              │
│  Total Events Adjudicated: 287                                              │
│                                                                              │
│  Classification Distribution                                                │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Confirmed MI              ██████████████████░░ 98 (34%)                │ │
│  │    • STEMI                 ████████████░░░░░░░░ 62 (22%)                │ │
│  │    • NSTEMI                ██████░░░░░░░░░░░░░░ 36 (13%)                │ │
│  │                                                                         │ │
│  │  Confirmed Stroke          ████████████░░░░░░░░ 67 (23%)                │ │
│  │    • Ischemic              ██████████░░░░░░░░░░ 54 (19%)                │ │
│  │    • Hemorrhagic           ███░░░░░░░░░░░░░░░░░ 13 (5%)                 │ │
│  │                                                                         │ │
│  │  Heart Failure Events      ███████░░░░░░░░░░░░░ 45 (16%)                │ │
│  │                                                                         │ │
│  │  Cardiovascular Death      ████░░░░░░░░░░░░░░░░ 28 (10%)                │ │
│  │                                                                         │ │
│  │  Other CV Events           ██████░░░░░░░░░░░░░░ 35 (12%)                │ │
│  │                                                                         │ │
│  │  Not an Event              ███░░░░░░░░░░░░░░░░░ 14 (5%)                 │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Consensus Quality                                                          │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Unanimous Decisions (100%)        178 events (62%)                      │ │
│  │ Strong Consensus (86-99%)          89 events (31%)                      │ │
│  │ Moderate Consensus (71-85%)        20 events (7%)                       │ │
│  │ Split Decisions (<71%)              0 events (0%)                       │ │
│  │                                                                         │ │
│  │ Average Consensus Level: 94.3%                                          │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Processing Timeline                                                        │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Average Time from Event to Adjudication: 18.5 days                     │ │
│  │   - Event to CEC Report:        1.2 days                               │ │
│  │   - Coordinator Review:         3.5 days                               │ │
│  │   - Medical Review:             2.8 days                               │ │
│  │   - Queue to Meeting:          11.0 days                               │ │
│  │                                                                         │ │
│  │ Fastest Processing: 7 days  │  Slowest: 45 days                        │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Regional Breakdown                                                         │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Region        Events  Confirmed MI  Confirmed Stroke  Avg Time         │ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ North America  156    52 (33%)      38 (24%)          17 days          │ │
│  │ Europe          87    31 (36%)      19 (22%)          19 days          │ │
│  │ Asia Pacific    44    15 (34%)      10 (23%)          21 days          │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  [Generate Full Report PDF]  [Export to Excel]  [Email Report]  [Print]     │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Site Notification

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Send Final Determination to Site                                       [X]  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Event: EVT-2025-0148 - Myocardial Infarction                               │
│  Subject: SUBJ-001098 (J.R.)                                                │
│  Site: Site 101 - Memorial Hospital                                         │
│                                                                              │
│  Recipients:                                                                │
│  ☑ Site Principal Investigator (Dr. James Wilson)                           │
│  ☑ Site Coordinator (Sarah Martinez)                                        │
│  ☑ Site CEC Liaison (if designated)                                         │
│  ☐ Additional Recipients: [Add email addresses...]                          │
│                                                                              │
│  Notification Content:                                                      │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │ Subject: CEC Final Determination - EVT-2025-0148                     │  │
│  │                                                                       │  │
│  │ Dear Dr. Wilson and Site Team,                                       │  │
│  │                                                                       │  │
│  │ The Clinical Event Committee has completed adjudication of the       │  │
│  │ following event:                                                     │  │
│  │                                                                       │  │
│  │ Event ID: EVT-2025-0148                                              │  │
│  │ Subject: SUBJ-001098 (J.R., 72M)                                     │  │
│  │ Event Date: January 6, 2026                                          │  │
│  │                                                                       │  │
│  │ FINAL CLASSIFICATION:                                                │  │
│  │ Confirmed Myocardial Infarction                                      │  │
│  │ Type: STEMI (ST-Elevation MI) - Type 1, Anterior Wall                │  │
│  │                                                                       │  │
│  │ Committee Decision: Unanimous (7/7 adjudicators)                     │  │
│  │ Adjudication Date: January 20, 2026                                  │  │
│  │ Meeting: MTG-2026-015                                                │  │
│  │                                                                       │  │
│  │ This determination is final and should be recorded in the subject's  │  │
│  │ study records. Please ensure all site documentation reflects this    │  │
│  │ adjudicated classification.                                          │  │
│  │                                                                       │  │
│  │ Attached:                                                            │  │
│  │ - Final Determination Letter                                         │  │
│  │ - Adjudication Summary                                               │  │
│  │                                                                       │  │
│  │ If you have questions, please contact the CEC Coordinator...         │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  Attachments:                                                               │
│  ☑ Final Determination Letter (PDF)                                         │
│  ☑ Event Adjudication Summary                                               │
│  ☐ Meeting Minutes (Confidential - do not include)                          │
│  ☐ Detailed Voting Record (Confidential - do not include)                   │
│                                                                              │
│  Delivery Options:                                                          │
│  ● Send immediately                                                         │
│  ○ Schedule for: [__/__/____] at [__:__ __]                                │
│                                                                              │
│  ☑ Request read receipt                                                     │
│  ☑ Send copy to CEC Coordinator                                             │
│  ☑ Log in notification history                                              │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│                                               [Cancel]  [Send Notification] │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Business Rules

### BR-1: Decision Locking
- Final decisions locked after meeting completion
- Only CEC Chair can request decision modification
- Modification requires formal amendment process
- All changes fully audited

### BR-2: Notification Requirements
- Sites notified within 2 business days
- Sponsors notified of all safety events
- Regulatory reporting per protocol requirements
- All notifications tracked and confirmed

### BR-3: Reporting Access
- Sponsors: De-identified aggregate data only
- Primary Researchers: Full access to all reports
- Sites: Access to own events only
- Adjudicators: Meeting-specific data

### BR-4: Data Retention
- Final determinations retained for duration of trial + 7 years
- Meeting materials archived
- Voting records maintained for audit
- Reports available on demand

## Data Model

```
FinalDetermination {
  DeterminationID: string (PK)
  EventID: string (FK)
  AdjudicationID: string (FK)
  MeetingID: string (FK)
  FinalClassification: json
  CommitteeSummary: text
  ConsensusLevel: string
  ConsensusPercentage: decimal
  DissentingOpinions: json
  ProcessingTimeline: json
  FinalizedBy: string (FK)
  FinalizedDate: datetime
  Locked: boolean
  LockDate: datetime
}

Notification {
  NotificationID: string (PK)
  DeterminationID: string (FK)
  NotificationType: string
  Recipients: json
  Subject: string
  MessageBody: text
  Attachments: json
  SentDate: datetime
  DeliveryStatus: json
  ReadReceipts: json
}

Report {
  ReportID: string (PK)
  ReportType: string
  Parameters: json
  GeneratedBy: string (FK)
  GeneratedDate: datetime
  ReportData: json
  Format: string
  FilePath: string
}
```

## Testing Scenarios

### Test Case 1: Finalize and Notify
1. Complete meeting adjudications
2. Finalize all decisions
3. Generate site notifications
4. Send notifications to all sites
5. Verify delivery confirmations
6. Verify decisions locked

### Test Case 2: Generate Classification Report
1. Access reports interface
2. Select classification summary report
3. Set date range and filters
4. Generate report
5. Review statistics and charts
6. Export to PDF and Excel
7. Verify data accuracy

### Test Case 3: View Decision Detail
1. Search for adjudicated event
2. View final determination
3. Review all voting details
4. Check notification history
5. Download decision letter
6. Verify locked status

## Future Enhancements

1. Automated regulatory report generation
2. Dashboard analytics with drill-down
3. Machine learning trend predictions
4. Integration with EDC systems
5. Mobile app for site notifications
6. Real-time sponsor dashboards
7. API for external system integration
8. Blockchain for immutable decisions
9. Natural language processing for summaries
10. Automated quality control checks
