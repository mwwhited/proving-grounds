# Feature Specification: SAE Medical Review

**Feature Area**: SAE Management
**User Role**: Manager (RA2), Medical Reviewer
**Priority**: Critical
**Status**: Active
**Regulatory**: 21 CFR Part 11 Compliant

---

## Overview

The Medical Review feature enables managers to submit completed SAE cases for medical review and allows medical reviewers to assess causality, severity, and expectedness. This critical workflow ensures qualified medical oversight of adverse events per GCP and regulatory requirements.

---

## User Stories

**As a** Manager (RA2)
**I want to** submit SAE cases for medical review
**So that** qualified medical personnel can assess the event

**As a** Medical Reviewer
**I want to** review SAE cases and provide medical assessment
**So that** the sponsor has accurate causality and severity determinations

**As a** Regulatory Affairs Officer
**I want to** ensure all SAEs have medical review before sponsor submission
**So that** we meet regulatory reporting requirements

---

## Functional Requirements

### FR-1: Submit for Medical Review

**Trigger**: Manager clicks "Send to Medical Review" button on case

**Preconditions**:
- Case in "Open" state
- All required fields completed
- All required documents uploaded
- No open queries outstanding

**Completeness Check**:
- Subject information complete
- Event information complete
- Severity assessment complete
- Causality assessment complete
- Event narrative minimum 50 characters
- At least one supporting document (configurable)

**Submission Workflow**:
1. Manager clicks "Send to Medical Review"
2. System validates case completeness
3. System displays confirmation dialog with checklist
4. Manager confirms submission
5. System transitions state: Open → InReview
6. System assigns to medical reviewer queue
7. System sends notification to reviewers
8. System locks case from editing (except by reviewers)
9. System creates audit log entry
10. System displays success message

**Confirmation Dialog**:
```
Submit Case for Medical Review?

Case: 001-2026-0001
Subject: JD (S-123)
Event: Anaphylactic reaction

Completeness Check:
✓ Subject information complete
✓ Event details complete
✓ Severity assessment complete
✓ Causality assessment complete
✓ Event narrative sufficient
✓ Supporting documents attached (2)
✓ No open queries

This case will be locked from editing and assigned
to the medical reviewer queue.

[Cancel] [Confirm Submission]
```

### FR-2: Medical Reviewer Queue

**URL**: `/SAE/ReviewQueue`

**Authorization**: Medical Reviewer role

**Queue Display**:
- Cases in "InReview" state
- Sorted by submission date (oldest first)
- Filter by priority/severity
- Search by case number or subject

**Queue Columns**:
- Case Number
- Trial
- Site
- Subject ID (anonymized)
- Event Term
- Severity
- Submitted Date
- Days in Queue
- Assigned Reviewer (if assigned)
- Actions (Claim, View)

**Case Assignment**:
- Auto-assignment: Next available reviewer
- Manual claim: Reviewer claims case from queue
- Re-assignment: Administrator can reassign

### FR-3: Medical Review Form

**URL**: `/SAE/Review/{caseId}`

**Authorization**: Medical Reviewer assigned to case

**Review Sections**:

#### 1. Case Summary (Read-Only)
- Subject demographics
- Event description
- Current severity/causality assessments
- Timeline of events
- Supporting documents

#### 2. Medical Reviewer Assessment

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Reviewer Assessment - Severity | Dropdown | Yes | Medical reviewer's severity assessment |
| Reviewer Assessment - Causality | Dropdown | Yes | Medical reviewer's causality assessment |
| Reviewer Assessment - Expectedness | Radio | Yes | Expected vs. Unexpected |
| SAE Criteria Confirmation | Checkboxes | Yes | Confirm seriousness criteria |
| Medical Reviewer Comments | Textarea | Yes | Detailed medical assessment |
| Action Taken with Study Drug | Dropdown | Yes | Confirm/update action |
| Recommendation | Dropdown | Yes | Review outcome |

**Severity Options**:
- Grade 1: Mild
- Grade 2: Moderate
- Grade 3: Severe
- Grade 4: Life-threatening
- Grade 5: Death

**Causality Options**:
- Unrelated
- Unlikely
- Possible
- Probable
- Definite

**Recommendation Options**:
- Approve - Case Complete
- Requires Changes - Return to Manager
- Requires Additional Information - Query Site
- Escalate to Safety Board

#### 3. Required Documents Review
- Checklist of required documents
- Mark each document as reviewed
- Flag missing documents

#### 4. Additional Assessments (Optional)
- CTCAE Grade (if applicable)
- WHO Toxicity Grade
- Coding verification (MedDRA)
- Protocol deviation assessment

### FR-4: Review Actions

**Approve Case**:
- Transitions state: InReview → Approved
- Case locked from further editing
- Notification sent to manager and sponsor
- Case ready for regulatory reporting

**Require Changes**:
- Transitions state: InReview → RequiresChanges
- Case returned to manager
- Reviewer specifies required changes
- Manager receives notification with change requests
- Manager can edit and resubmit

**Request Additional Information (Query)**:
- Transitions state: InReview → OnHold
- System creates site query
- Case held pending query response
- See: Site Queries feature

**Escalate to Safety Board**:
- Maintains InReview state
- Flags case for safety board review
- Notification sent to safety board
- Holds regulatory reporting

### FR-5: Review Timeline

**Configurable SLAs**:
- Standard review: 2 business days
- Expedited review: 24 hours (for serious/unexpected)
- Extended review: 5 business days (for complex cases)

**Escalation**:
- Email notification at 50% of SLA
- Escalation notification at 100% of SLA
- Management notification at 150% of SLA

**Timeline Display**:
- Submitted date/time
- SLA deadline
- Current reviewer
- Days in queue
- SLA status (on time, approaching, overdue)

### FR-6: Reviewer Dashboard

**URL**: `/SAE/ReviewerDashboard`

**Metrics**:
- Cases assigned to me
- Cases in queue
- Cases reviewed (last 30 days)
- Average review time
- SLA compliance rate
- Cases overdue

**Quick Actions**:
- Claim next case
- View my cases
- View queue
- Generate review report

### FR-7: Electronic Signature

**Requirement**: Medical review requires electronic signature per 21 CFR Part 11

**Signature Process**:
1. Reviewer completes assessment
2. Reviewer clicks "Sign and Approve" (or other action)
3. System displays signature confirmation
4. Reviewer re-enters password (or PIN)
5. System verifies credentials
6. System captures signature details
7. System completes review action

**Signature Captured**:
- Reviewer name and ID
- Timestamp (UTC)
- Meaning of signature ("Approve SAE Case Medical Review")
- Password verification
- IP address
- Browser/device information

**Signature Display** (on reports):
```
Electronically Signed:
Dr. Jane Smith, MD
Medical Reviewer
2026-01-13 15:45:00 UTC
Meaning: Medical review approval per protocol
```

### FR-8: Audit Trail

**Logged Events**:

| Event | Action | Details |
|-------|--------|---------|
| Submitted for review | SAE_Review_Submit | Case submitted |
| Assigned to reviewer | SAE_Review_Assign | Reviewer assigned |
| Review claimed | SAE_Review_Claim | Reviewer claimed case |
| Review started | SAE_Review_Start | Reviewer opened case |
| Review approved | SAE_Review_Approve | Case approved with signature |
| Changes requested | SAE_Review_Require_Changes | Case returned |
| Query created | SAE_Review_Query | Additional info requested |
| Review escalated | SAE_Review_Escalate | Escalated to safety board |

**Audit Information**:
- Reviewer ID and name
- Timestamp (UTC)
- IP address
- Action performed
- Review assessments (before/after)
- Electronic signature details
- Case state transitions

### FR-9: Notifications

**Email Notifications**:

**To Manager on Case Returned**:
```
Subject: SAE Case Requires Changes - 001-2026-0001

Your SAE case requires changes before approval:

Case: 001-2026-0001
Event: Anaphylactic reaction
Reviewed by: Dr. Jane Smith

Required Changes:
- Please provide more details on treatment given
- Upload ECG results mentioned in narrative
- Clarify timing of symptom onset

View Case: [Link]
```

**To Manager on Case Approved**:
```
Subject: SAE Case Approved - 001-2026-0001

Medical review complete. Case approved:

Case: 001-2026-0001
Event: Anaphylactic reaction
Reviewed by: Dr. Jane Smith
Causality: Probable
Severity: Severe
Approved: 2026-01-13 15:45 UTC

Next Steps:
- Case will be included in next sponsor report
- No further action required

View Case: [Link]
```

### FR-10: Review Reports

**Individual Case Report**:
- Complete case details
- Medical review assessment
- Reviewer signature
- Timeline
- All supporting documents
- PDF generation for archival

**Batch Review Report**:
- All cases reviewed in date range
- Summary statistics
- Causality distribution
- Severity distribution
- Average review time
- SLA compliance

---

## Non-Functional Requirements

### NFR-1: Performance
- Queue load: <2 seconds
- Case review page load: <3 seconds
- Save review: <1 second
- Report generation: <5 seconds

### NFR-2: Security
- Role-based access (medical reviewer role)
- Case assignment enforced
- Electronic signature required
- Audit trail complete

### NFR-3: Compliance
- 21 CFR Part 11 electronic signatures
- GCP medical review requirements
- Qualified reviewer credentials verified
- Complete audit trail

### NFR-4: Availability
- Service available 99.9%
- Review queue accessible 24/7
- Email notifications reliable

---

## User Interface

### Medical Review Form

```
┌─────────────────────────────────────────────────────────┐
│ Medical Review - Case 001-2026-0001              [Print]│
├─────────────────────────────────────────────────────────┤
│                                                         │
│ [Case Summary] [Medical Assessment] [Documents]         │
│                                                         │
│ MEDICAL REVIEWER ASSESSMENT                             │
│                                                         │
│ Reviewer Severity Assessment: *                         │
│ ⦿ Grade 3: Severe                                       │
│ ○ Grade 4: Life-threatening                             │
│ ○ Grade 5: Death                                        │
│                                                         │
│ Reviewer Causality Assessment: *                        │
│ [▼ Probable ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼]                  │
│                                                         │
│ Expectedness: * ○ Expected  ⦿ Unexpected                │
│                                                         │
│ SAE Criteria Confirmation: * (Check all that apply)    │
│ □ Death                                                 │
│ ☑ Life-threatening                                      │
│ □ Hospitalization                                       │
│ □ Disability                                            │
│ □ Congenital Anomaly                                    │
│ □ Other Medically Important                             │
│                                                         │
│ Medical Reviewer Comments: *                            │
│ [________________________________________________]      │
│ [________________________________________________]      │
│ [________________________________________________]      │
│ [________________________________________________]      │
│                                    (125 / 2000 chars)   │
│                                                         │
│ Recommendation: *                                       │
│ [▼ Approve - Case Complete ▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼]          │
│                                                         │
│ Required Documents Review:                              │
│ ✓ Lab Results                                           │
│ ✓ Medical Records                                       │
│ ✗ ECG (Missing - noted in comments)                     │
│                                                         │
│                                                         │
│ [Cancel] [Save Draft] [Require Changes] [Sign & Approve]│
└─────────────────────────────────────────────────────────┘
```

---

## Data Model

### SAEReview Table

```sql
CREATE TABLE SAEReview (
    ReviewID                INT IDENTITY(1,1) PRIMARY KEY,
    CaseID                  INT NOT NULL,
    ReviewerID              UNIQUEIDENTIFIER NOT NULL,

    -- Review Assessment
    ReviewerSeverity        NVARCHAR(50) NOT NULL,
    ReviewerCausality       NVARCHAR(50) NOT NULL,
    ReviewerExpectedness    NVARCHAR(20) NOT NULL,
    ReviewerComments        NVARCHAR(MAX) NOT NULL,
    Recommendation          NVARCHAR(100) NOT NULL,

    -- SAE Criteria Confirmation
    Confirmed_Death         BIT NOT NULL DEFAULT 0,
    Confirmed_LifeThreat    BIT NOT NULL DEFAULT 0,
    Confirmed_Hospitalization BIT NOT NULL DEFAULT 0,
    Confirmed_Disability    BIT NOT NULL DEFAULT 0,
    Confirmed_CongenitalAnomaly BIT NOT NULL DEFAULT 0,
    Confirmed_MedicallyImportant BIT NOT NULL DEFAULT 0,

    -- Review Timeline
    AssignedDate            DATETIME2 NULL,
    ReviewStartedDate       DATETIME2 NULL,
    ReviewCompletedDate     DATETIME2 NULL,
    SLADeadline             DATETIME2 NULL,

    -- Electronic Signature
    SignedBy                UNIQUEIDENTIFIER NULL,
    SignedDate              DATETIME2 NULL,
    SignatureMeaning        NVARCHAR(500) NULL,
    SignedByIP              NVARCHAR(50) NULL,

    -- Audit
    CreatedDate             DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedDate            DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    CONSTRAINT FK_SAEReview_Case FOREIGN KEY (CaseID) REFERENCES SAECase(CaseID),
    CONSTRAINT FK_SAEReview_Reviewer FOREIGN KEY (ReviewerID) REFERENCES AspNetUsers(UserId),
    CONSTRAINT FK_SAEReview_Signer FOREIGN KEY (SignedBy) REFERENCES AspNetUsers(UserId)
)
```

---

## Business Rules

### BR-1: Submission Requirements
- Case must be in Open state
- All required fields completed
- Minimum documentation threshold met

### BR-2: Reviewer Qualifications
- Medical reviewer role required
- Medical license verified
- Training completed

### BR-3: Review Actions
- Only assigned reviewer can review case
- Electronic signature required for approval
- Changes must be specified when returning case

### BR-4: SLA Management
- Review SLA starts on submission
- Escalation notifications automated
- SLA tracking for compliance

---

## Acceptance Criteria

### AC-1: Submission
- ✅ Manager can submit complete cases
- ✅ Incomplete cases blocked
- ✅ State transitions correctly
- ✅ Notifications sent

### AC-2: Review
- ✅ Reviewer can claim cases
- ✅ Review form displays correctly
- ✅ All assessments required
- ✅ Electronic signature works

### AC-3: Actions
- ✅ Approve works correctly
- ✅ Require changes works
- ✅ Query creation works
- ✅ State transitions correct

### AC-4: Compliance
- ✅ Electronic signatures captured
- ✅ Audit trail complete
- ✅ 21 CFR Part 11 compliant

---

## Related Features

- [Create SAE Case](./create-case.md)
- [Upload Documents](./upload-documents.md)
- [Site Queries](./site-queries.md)
- [SAE Workflow](./workflow.md)

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
