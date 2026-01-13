# CEC Feature Specification: Medical Review

## Overview

The Medical Review feature enables Medical Reviewers to conduct clinical assessment of reported events, review source documentation, complete checklists, and approve events for adjudication committee meetings.

## Feature Details

**Feature Name**: Clinical Medical Review
**Module**: Clinical Event Committee (CEC)
**Actors**: Medical Reviewer
**Priority**: High
**Status**: Implementation Ready

## User Stories

1. **As a Medical Reviewer**, I want to review assigned events so that I can assess them for adjudication
2. **As a Medical Reviewer**, I want to view source documents so that I can validate the reported event
3. **As a Medical Reviewer**, I want to complete review checklists so that I ensure thorough assessment
4. **As a Medical Reviewer**, I want to approve events for meetings so they can be adjudicated
5. **As a Medical Reviewer**, I want to request additional information so I can complete my review

## Functional Requirements

### FR-1: Event Assignment and Queue
- System shall display events assigned to medical reviewer
- System shall show events pending medical review
- System shall allow filtering by status, date, site, event type
- System shall prioritize events by urgency/date

### FR-2: Event Review Interface
- System shall display complete event details
- System shall display subject demographics (de-identified as needed)
- System shall display event timeline
- System shall display all source documents
- System shall display coordinator notes and annotations

### FR-3: Source Document Review
- System shall provide document viewer with zoom and navigation
- System shall support document annotations (private and public)
- System shall highlight HIPAA violations flagged by system
- System shall allow classification of documents by type
- System shall allow requesting additional documentation

### FR-4: Review Checklist
- System shall present configurable review checklist
- System shall track completion of checklist items
- System shall require completion of mandatory items
- System shall allow reviewer comments on checklist items
- System shall save checklist progress

### FR-5: Medical Assessment
- System shall capture medical reviewer's assessment
- System shall allow selection of preliminary event classification
- System shall capture clinical summary
- System shall allow identification of additional issues
- System shall support differential diagnosis notation

### FR-6: Approval Actions
- System shall allow approval for adjudication meeting
- System shall allow request for additional information
- System shall allow return to coordinator for clarification
- System shall require review completion before approval
- System shall update event status based on action

### FR-7: Information Requests
- System shall allow creation of information request queries
- System shall specify questions for site/coordinator
- System shall track query status
- System shall notify appropriate personnel
- System shall link responses to original query

## ASCII Art Mockups

### Medical Review Queue

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                     Dr. Sarah Chen (Reviewer) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Medical Review                                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Medical Review Queue                                                       │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  My Assignments (8) │ All Pending (23) │ Completed (145) │ Statistics       │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Filter: [All Types ▼] [All Sites ▼] [Last 30 Days ▼]  [Apply]  [Clear]    │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Priority Event ID      Subject     Site    Type      Rcvd      Status │ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ ⚠ HIGH   EVT-2025-0152 SUBJ-001234 Site101 MI        01/10/26 New     │ │
│  │          EVT-2025-0151 SUBJ-002341 Site105 Stroke    01/09/26 In Rev  │◄│
│  │ ⚠ HIGH   EVT-2025-0150 SUBJ-001877 Site101 Heart Fl  01/08/26 New     │ │
│  │          EVT-2025-0148 SUBJ-001098 Site101 CV Event  01/06/26 In Rev  │ │
│  │          EVT-2025-0147 SUBJ-002789 Site102 MI        01/05/26 Query   │ │
│  │          EVT-2025-0144 SUBJ-001456 Site101 Stroke    01/02/26 In Rev  │ │
│  │          EVT-2025-0143 SUBJ-003908 Site104 Other     01/01/26 New     │ │
│  │          EVT-2025-0141 SUBJ-002145 Site103 Death     12/30/25 Query   │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Status Legend: New=Not Started | In Rev=In Progress | Query=Info Requested │
│                                                                              │
│  Showing 8 events                                [< Prev] Page 1/1 [Next >] │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Event Review Screen - Overview Tab

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                     Dr. Sarah Chen (Reviewer) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Medical Review > EVT-2025-0152                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Event EVT-2025-0152: Myocardial Infarction                [Save] [Actions▼]│
│  Status: Medical Review    Assigned to: Dr. Sarah Chen    Priority: HIGH    │
│                                                                              │
│  ┌─ Overview ─┬─ Documents ─┬─ Checklist ─┬─ Assessment ─┬─ History ─┐    │
│  │            │             │             │              │            │    │
│  └────────────┴─────────────┴─────────────┴──────────────┴────────────┘    │
│                                                                              │
│  Subject Information                                                        │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Subject ID: SUBJ-001234          Initials: J.D.                        │ │
│  │ Age: 67    Gender: Male           Site: Site 101 - Memorial Hospital   │ │
│  │ Enrollment Date: 01/15/2025       Trial Arm: Treatment                 │ │
│  │ Days on Study: 364                Status: Active                       │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Event Details                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Event Date: 01/10/2026 14:30      Event Type: Myocardial Infarction    │ │
│  │ Category: Serious Adverse Event    Reported By: Site Investigator      │ │
│  │ Reporter: Dr. James Wilson         Contact: jwilson@memorial.org       │ │
│  │                                                                         │ │
│  │ Description:                                                            │ │
│  │ 67-year-old male presented to ER with severe chest pain radiating to   │ │
│  │ left arm, onset at approximately 2:30 PM. Patient reported substernal  │ │
│  │ pressure 8/10 severity. Arrived via ambulance. Initial ECG showed ST   │ │
│  │ elevation in leads II, III, aVF consistent with inferior STEMI.        │ │
│  │ Troponin elevated at 2.5 ng/mL. Patient taken for emergent cardiac     │ │
│  │ catheterization showing 100% occlusion of RCA. PCI performed with      │ │
│  │ stent placement. Post-procedure stable.                                │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Source Documents                                      (12 documents total) │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ✓ ECG Report (01/10/2026)               [View] [Annotate]              │ │
│  │ ✓ Lab Results - Troponin (01/10/2026)   [View] [Annotate]              │ │
│  │ ✓ Cardiac Cath Report (01/10/2026)      [View] [Annotate]              │ │
│  │ ✓ Hospital Admission Record             [View] [Annotate]              │ │
│  │   ... 8 more documents                  [View All Documents]           │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Coordinator Notes                                                          │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ 01/11/2026 10:15 AM - John Smith (Coordinator)                         │ │
│  │ All source documents received. ECG confirms STEMI. Cath report shows   │ │
│  │ successful intervention. Patient recovering well per discharge summary.│ │
│  │ Ready for medical review.                                              │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│  [< Previous Event]        [Request Information]        [Next Event >]      │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Event Review Screen - Documents Tab

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                     Dr. Sarah Chen (Reviewer) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Medical Review > EVT-2025-0152                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Event EVT-2025-0152: Myocardial Infarction                [Save] [Actions▼]│
│  Status: Medical Review    Assigned to: Dr. Sarah Chen    Priority: HIGH    │
│                                                                              │
│  ┌─ Overview ─┬─ Documents ─┬─ Checklist ─┬─ Assessment ─┬─ History ─┐    │
│  │            │░░░░░░░░░░░░░│             │              │            │    │
│  └────────────┴─────────────┴─────────────┴──────────────┴────────────┘    │
│                                                                              │
│  ┌──────────────────────────┬────────────────────────────────────────────┐ │
│  │ Document List            │ Document Viewer                            │ │
│  │ (12 documents)           │                                            │ │
│  │                          │  ┌──────────────────────────────────────┐ │ │
│  ├──────────────────────────┤  │                                      │ │ │
│  │ ► ECG Reports (2)        │  │         ECG Report                   │ │ │
│  │   • 12-Lead ECG          │◄ │    Memorial Hospital                 │ │ │
│  │     01/10/2026 14:35     │  │    Date: 01/10/2026 14:35            │ │ │
│  │   • Follow-up ECG        │  │                                      │ │ │
│  │     01/11/2026 08:00     │  │    Patient: J.D. (SUBJ-001234)       │ │ │
│  │                          │  │                                      │ │ │
│  │ ► Lab Results (4)        │  │    INTERPRETATION:                   │ │ │
│  │   • Troponin Panel       │  │    Acute ST elevation myocardial     │ │ │
│  │     01/10/2026 14:45     │  │    infarction (STEMI). Inferior wall │ │ │
│  │   • CBC                  │  │    involvement with ST elevation in  │ │ │
│  │     01/10/2026 15:00     │  │    leads II, III, aVF.              │ │ │
│  │   • CMP                  │  │                                      │ │ │
│  │     01/10/2026 15:00     │  │    Reciprocal ST depression in      │ │ │
│  │   • Lipid Panel          │  │    anterior leads.                   │ │ │
│  │     01/11/2026 06:00     │  │                                      │ │ │
│  │                          │  │    __________________________        │ │ │
│  │ ► Cardiac Cath (1)       │  │    Dr. Emma Rodriguez, Cardiology   │ │ │
│  │   • Cath Report          │  │                                      │ │ │
│  │     01/10/2026 16:00     │  │                                      │ │ │
│  │                          │  └──────────────────────────────────────┘ │ │
│  │ ► Hospital Records (3)   │                                            │ │
│  │   • Admission            │  [Zoom: 100% ▼] [Rotate] [Print]          │ │
│  │   • Progress Notes       │                                            │ │
│  │   • Discharge Summary    │  [+ Add Annotation] [Flag HIPAA] [Classify]│ │
│  │                          │                                            │ │
│  │ ► Other (2)              │  My Annotations (2)  Public (1)            │ │
│  │   • Ambulance Report     │  ┌──────────────────────────────────────┐ │ │
│  │   • Consent Form         │  │ 🔒 Confirms STEMI diagnosis          │ │ │
│  └──────────────────────────┘  │ 🔒 Consistent with reported symptoms │ │ │
│                                 │ 📢 Key diagnostic finding            │ │ │
│                                 └──────────────────────────────────────┘ │ │
│                                                                          │ │
│  [Request Additional Documents]                     Page 1 of 3 [< | >]  │ │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Event Review Screen - Checklist Tab

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                     Dr. Sarah Chen (Reviewer) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Medical Review > EVT-2025-0152                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Event EVT-2025-0152: Myocardial Infarction                [Save] [Actions▼]│
│  Status: Medical Review    Assigned to: Dr. Sarah Chen    Priority: HIGH    │
│                                                                              │
│  ┌─ Overview ─┬─ Documents ─┬─ Checklist ─┬─ Assessment ─┬─ History ─┐    │
│  │            │             │░░░░░░░░░░░░░│              │            │    │
│  └────────────┴─────────────┴─────────────┴──────────────┴────────────┘    │
│                                                                              │
│  Medical Review Checklist - Myocardial Infarction                           │
│  Progress: 8/12 items complete (67%)         [Expand All] [Collapse All]    │
│                                                                              │
│  ▼ 1. Clinical Presentation (4/4 complete)                                  │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ☑ Chest pain or equivalent symptoms documented        [View Source]    │ │
│  │   Comment: Severe substernal chest pain 8/10, left arm radiation       │ │
│  │                                                                         │ │
│  │ ☑ Symptom onset time recorded                          [View Source]    │ │
│  │   Comment: 14:30, consistent with ambulance arrival time               │ │
│  │                                                                         │ │
│  │ ☑ Risk factors documented                              [View Source]    │ │
│  │   Comment: 67 yo male, hypertension, hyperlipidemia                    │ │
│  │                                                                         │ │
│  │ ☑ Prior cardiac history reviewed                       [View Source]    │ │
│  │   Comment: No prior MI, no known CAD                                   │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  ▼ 2. Diagnostic Criteria (3/4 complete) * Required                         │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ☑ ECG evidence of MI                                   [View Source]    │ │
│  │   Comment: ST elevation II, III, aVF - inferior STEMI                  │ │
│  │                                                                         │ │
│  │ ☑ Cardiac biomarkers elevated                          [View Source]    │ │
│  │   Comment: Troponin 2.5 ng/mL (normal <0.04)                          │ │
│  │                                                                         │ │
│  │ ☑ Imaging evidence (if applicable)                     [View Source]    │ │
│  │   Comment: Cath shows 100% RCA occlusion                               │ │
│  │                                                                         │ │
│  │ ☐ Timeline supports diagnosis *                        [Add Comment]    │ │
│  │   (This item is required)                                              │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  ▶ 3. Treatment and Intervention (1/3 complete)                             │
│                                                                              │
│  ▶ 4. Outcome and Follow-up (0/1 complete)                                  │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│  [Save Progress]                                    [Mark All Complete]     │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Event Review Screen - Assessment Tab

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                     Dr. Sarah Chen (Reviewer) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Medical Review > EVT-2025-0152                                  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Event EVT-2025-0152: Myocardial Infarction                [Save] [Actions▼]│
│  Status: Medical Review    Assigned to: Dr. Sarah Chen    Priority: HIGH    │
│                                                                              │
│  ┌─ Overview ─┬─ Documents ─┬─ Checklist ─┬─ Assessment ─┬─ History ─┐    │
│  │            │             │             │░░░░░░░░░░░░░░│            │    │
│  └────────────┴─────────────┴─────────────┴──────────────┴────────────┘    │
│                                                                              │
│  Medical Assessment                                                         │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Preliminary Classification *                                               │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Event Type:      ● Confirmed MI                                         │ │
│  │                  ○ Probable MI                                          │ │
│  │                  ○ Possible MI                                          │ │
│  │                  ○ Not MI                                               │ │
│  │                  ○ Indeterminate - need more information                │ │
│  │                                                                         │ │
│  │ MI Subtype:      [▼ Select Subtype                    ]                │ │
│  │                   ├─ STEMI - ST Elevation MI                           │ │
│  │                   ├─ NSTEMI - Non-ST Elevation MI                      │ │
│  │                   ├─ Type 1 MI (Spontaneous)                           │ │
│  │                   ├─ Type 2 MI (Secondary)                             │ │
│  │                   ├─ Type 3 MI (Sudden Death)                          │ │
│  │                   ├─ Type 4a MI (PCI-related)                          │ │
│  │                   ├─ Type 4b MI (Stent Thrombosis)                     │ │
│  │                   └─ Type 5 MI (CABG-related)                          │ │
│  │                                                                         │ │
│  │ Location:        ☑ Inferior  ☐ Anterior  ☐ Lateral                     │ │
│  │                  ☐ Posterior  ☐ Septal   ☐ Right Ventricle             │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Clinical Summary *                                                         │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ 67 yo male with acute inferior STEMI. Presented with classic substernal│ │
│  │ chest pain radiating to left arm. ECG confirms ST elevation in inferior│ │
│  │ leads (II, III, aVF). Troponin significantly elevated at 2.5 ng/mL.    │ │
│  │ Emergent cardiac catheterization revealed 100% occlusion of RCA.       │ │
│  │ Successful PCI with stent placement. Clinical presentation, ECG        │ │
│  │ findings, biomarkers, and angiography all consistent with Type 1 STEMI.│ │
│  │ Documentation complete and supports diagnosis. Recommend approval for  │ │
│  │ adjudication as confirmed STEMI, inferior wall.                        │ │
│  │                                                                         │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│  (Maximum 4000 characters)                                                  │
│                                                                              │
│  Additional Findings                                                        │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ☐ Protocol Deviation Noted                                             │ │
│  │ ☐ Causality Assessment Required                                        │ │
│  │ ☑ Related to Study Drug         Relationship: ○ Possible ● Unlikely    │ │
│  │ ☐ Requires Safety Reporting                                            │ │
│  │ ☐ Other Concerns (specify below)                                       │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Reviewer Comments                                                          │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Clear case of inferior STEMI with prompt intervention. All documentation│ │
│  │ supports diagnosis. Ready for adjudication committee review.           │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│  [Save Draft]                                    [Approve for Adjudication] │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Information Request Dialog

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Request Additional Information                                         [X]  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Event: EVT-2025-0152 - Myocardial Infarction                               │
│  Subject: SUBJ-001234                                                       │
│  Site: Site 101 - Memorial Hospital                                         │
│                                                                              │
│  Request Information From:                                                  │
│  ● Site Coordinator   ○ Site Investigator   ○ Both                          │
│                                                                              │
│  Request Type:                                                              │
│  ☑ Missing Documentation                                                    │
│  ☐ Clarification Needed                                                     │
│  ☐ Additional Clinical Information                                          │
│  ☐ Query Specific Document                                                  │
│                                                                              │
│  Question/Request: *                                                        │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │ Please provide the following additional documentation:               │  │
│  │                                                                       │  │
│  │ 1. Complete lipid panel results from admission (referenced but not   │  │
│  │    included in uploaded documents)                                   │  │
│  │                                                                       │  │
│  │ 2. Discharge medications list                                        │  │
│  │                                                                       │  │
│  │ 3. Follow-up appointment documentation                               │  │
│  │                                                                       │  │
│  │ These documents are needed to complete the medical review.           │  │
│  │                                                                       │  │
│  │                                                                       │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│  (Maximum 2000 characters)                                                  │
│                                                                              │
│  Priority:  ○ Routine (5 business days)  ● Urgent (2 business days)         │
│                                                                              │
│  Notifications:                                                             │
│  ☑ Email site coordinator (coordinator@memorial.org)                        │
│  ☑ Email site investigator (jwilson@memorial.org)                           │
│  ☑ Send me notification when response received                             │
│                                                                              │
│  Event Status After Request:                                                │
│  ● Pending Information (event remains with me)                              │
│  ○ Return to Coordinator (event moved back to coordinator queue)            │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│                                              [Cancel]  [Send Request]       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Approval Confirmation Dialog

```
┌─────────────────────────────────────────────────────────────┐
│ Approve Event for Adjudication Meeting                 [X] │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Event: EVT-2025-0152 - Myocardial Infarction               │
│  Subject: SUBJ-001234                                       │
│                                                              │
│  Review Completion Status:                                  │
│  ✓ All required checklist items completed (12/12)           │
│  ✓ Medical assessment completed                             │
│  ✓ Clinical summary provided                                │
│  ✓ No pending information requests                          │
│                                                              │
│  Preliminary Classification:                                │
│  • Type: Confirmed MI                                       │
│  • Subtype: STEMI - ST Elevation MI                         │
│  • Location: Inferior                                       │
│                                                              │
│  By approving this event, you confirm that:                 │
│  ☑ I have reviewed all source documentation                 │
│  ☑ Medical review is complete and accurate                  │
│  ☑ Event is ready for adjudication committee                │
│  ☑ No additional information is needed at this time         │
│                                                              │
│  The event will be moved to "Approved for Meeting" status   │
│  and will be included in the next scheduled CEC meeting.    │
│                                                              │
│  ─────────────────────────────────────────────────          │
│                                                              │
│                                  [Cancel]  [Confirm Approval]│
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### Medical Review Statistics Dashboard

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ OoBDev Clinical Trials                     Dr. Sarah Chen (Reviewer) [Logout]│
├─────────────────────────────────────────────────────────────────────────────┤
│ Home > CEC > Medical Review > Statistics                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Medical Review Statistics - Dr. Sarah Chen                                 │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Current Month (January 2026)                                               │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │  Events Assigned: 23    Events Completed: 18    In Progress: 5       │  │
│  │  Avg Review Time: 2.3 days    Pending Info Requests: 3               │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  My Current Queue                                                           │
│  ┌─────────────────────────┬──────────────────────────┬──────────────────┐ │
│  │  Status                 │  Count                   │  Oldest          │ │
│  ├─────────────────────────┼──────────────────────────┼──────────────────┤ │
│  │  New (Not Started)      │    3                     │  2 days ago      │ │
│  │  In Review              │    2                     │  1 day ago       │ │
│  │  Pending Information    │    3                     │  5 days ago      │ │
│  ├─────────────────────────┼──────────────────────────┼──────────────────┤ │
│  │  Total Assigned         │    8                     │                  │ │
│  └─────────────────────────┴──────────────────────────┴──────────────────┘ │
│                                                                              │
│  Review History (Last 6 Months)                                             │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │   Events                                                              │  │
│  │   25 ┤                                                                │  │
│  │   20 ┤     ▓▓                ▓▓        ▓▓                            │  │
│  │   15 ┤  ▓▓ ▓▓ ▓▓     ▓▓     ▓▓ ▓▓     ▓▓                            │  │
│  │   10 ┤  ▓▓ ▓▓ ▓▓ ▓▓  ▓▓ ▓▓  ▓▓ ▓▓ ▓▓  ▓▓                            │  │
│  │    5 ┤  ▓▓ ▓▓ ▓▓ ▓▓  ▓▓ ▓▓  ▓▓ ▓▓ ▓▓  ▓▓                            │  │
│  │    0 └──────────────────────────────────────────                     │  │
│  │       Aug Sep Oct Nov Dec Jan                                        │  │
│  │                                                                       │  │
│  │   Legend: ▓▓ Completed    Avg/month: 18.5                           │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  Event Types Reviewed (YTD)                                                 │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │  Myocardial Infarction    ████████████░░░░░░░░░  62 (34%)            │  │
│  │  Stroke                   ██████████░░░░░░░░░░░░  48 (27%)            │  │
│  │  Heart Failure            ████████░░░░░░░░░░░░░░  38 (21%)            │  │
│  │  Death                    ████░░░░░░░░░░░░░░░░░░  18 (10%)            │  │
│  │  Other CV Event           ███░░░░░░░░░░░░░░░░░░░  14 (8%)             │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│  Performance Metrics                                                        │
│  ┌──────────────────────────────────────────────────────────────────────┐  │
│  │  Average Review Time:        2.3 days                                 │  │
│  │  Approval Rate:              89%                                      │  │
│  │  Info Request Rate:          11%                                      │  │
│  │  On-Time Completion:         94%                                      │  │
│  └──────────────────────────────────────────────────────────────────────┘  │
│                                                                              │
│                                                         [Export Report]     │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Non-Functional Requirements

### Performance
- Event list shall load within 2 seconds
- Document viewer shall render documents within 3 seconds
- Checklist auto-save shall occur every 30 seconds
- Search and filter operations shall complete within 1 second

### Usability
- Interface shall support keyboard shortcuts for common actions
- Document viewer shall remember zoom and position per user
- Checklist progress shall be visually indicated
- Required fields shall be clearly marked

### Security
- Only assigned medical reviewers can access events
- All document access shall be logged
- Annotations shall be attributed to user
- PHI shall be protected according to HIPAA

### Accessibility
- WCAG 2.1 Level AA compliant
- Screen reader compatible
- Keyboard navigation for all functions
- High contrast mode support

## Business Rules

### BR-1: Assignment Rules
- Events must be assigned to medical reviewer
- Reviewer can only approve events assigned to them
- Coordinator can reassign events
- High priority events flagged for urgent review

### BR-2: Review Completion
- All required checklist items must be completed before approval
- Medical assessment must be provided
- Clinical summary required for approval
- No pending information requests for approval

### BR-3: Information Requests
- Information requests must specify questions
- Requests sent to site coordinator and/or investigator
- Event status updated to reflect pending request
- Timeout for responses (configurable)

### BR-4: Document Classification
- Documents must be classified by type
- HIPAA violations must be flagged
- Annotations preserved across sessions
- Version history maintained

## Data Model

### Medical Review
```
MedicalReview {
  ReviewID: string (PK)
  EventID: string (FK)
  ReviewerID: string (FK)
  AssignedDate: datetime
  StartedDate: datetime
  CompletedDate: datetime
  Status: string
  PreliminaryClassification: string
  EventSubtype: string
  EventLocation: string
  ClinicalSummary: text
  AdditionalFindings: json
  ReviewerComments: text
  ChecklistCompleted: boolean
  ApprovedForMeeting: boolean
  ApprovalDate: datetime
}

ReviewChecklist {
  ChecklistID: string (PK)
  ReviewID: string (FK)
  ItemID: string (FK)
  Completed: boolean
  Comments: text
  SourceDocumentRef: string
  CompletedBy: string (FK)
  CompletedDate: datetime
}

InformationRequest {
  RequestID: string (PK)
  EventID: string (FK)
  RequestedBy: string (FK)
  RequestDate: datetime
  RequestType: string
  Questions: text
  Priority: string
  DueDate: date
  Status: string
  ResponseDate: datetime
  Response: text
}
```

## Integration Points

- **Event Management**: Retrieve event details
- **Document Management**: Access and annotate source documents
- **Checklist Engine**: Load and save checklist configurations
- **User Management**: User authentication and reviewer assignments
- **Notification Service**: Send information requests
- **Audit Trail**: Log all review actions

## Testing Scenarios

### Test Case 1: Complete Medical Review
1. Login as Medical Reviewer
2. View assigned events queue
3. Select event to review
4. Review all source documents
5. Complete all checklist items
6. Enter medical assessment
7. Approve for adjudication
8. Verify event status updated
9. Verify event appears in meeting queue

### Test Case 2: Request Additional Information
1. Login as Medical Reviewer
2. Open event for review
3. Identify missing documentation
4. Click Request Information
5. Specify questions and priority
6. Submit request
7. Verify notification sent to site
8. Verify event status updated
9. Receive response notification
10. Review additional documentation
11. Complete review

### Test Case 3: Document Annotation
1. Open event documents tab
2. Select document to review
3. Add private annotation
4. Add public annotation
5. Save annotations
6. Navigate away and return
7. Verify annotations preserved
8. Verify public annotation visible to others
9. Verify private annotation only visible to reviewer

## Future Enhancements

1. AI-assisted document review and information extraction
2. Voice-to-text for clinical summaries
3. Automatic preliminary classification suggestions
4. Peer review workflow
5. Mobile app for document review
6. Integration with medical terminology databases
7. Comparison view for similar historical events
8. Real-time collaboration features
9. Video conference integration for complex cases
10. Automated checklist pre-population from documents
