# Feature Specification: SAE Workflow State Machine

**Feature Area**: SAE Management
**User Roles**: All SAE Roles
**Priority**: Critical
**Status**: Active
**Regulatory**: 21 CFR Part 11 Compliant

---

## Overview

The SAE Workflow feature implements a state machine that governs SAE case lifecycle from creation through closure. This workflow ensures proper review procedures, maintains audit trails, and enforces business rules while supporting regulatory compliance requirements.

### Business Context

Workflow state management is critical for:
- Enforcing sequential review processes
- Preventing unauthorized state transitions
- Maintaining case integrity during review
- Supporting regulatory compliance (GCP, 21 CFR Part 11)
- Tracking case lifecycle for reporting
- Audit trail of all case state changes

---

## State Machine Diagram

```
                    ┌─────────────────┐
                    │  Case Created   │
                    └────────┬────────┘
                             ↓
                    ┌────────────────┐
              ┌─────┤     Draft      ├─────┐
              │     └────────┬───────┘     │
              │              ↓             │
    Cancel    │     ┌────────────────┐    │ Submit
              │     │      Open      ├────┘
              │     └────┬───┬───┬───┘
              │          │   │   │
              │  Query   │   │   │ Submit for Review
              │    ┌─────┘   │   └──────┐
              │    ↓         │          ↓
              │ ┌────────┐   │    ┌──────────┐
              │ │OnHold  │   │    │ InReview │
              │ └───┬────┘   │    └─────┬────┘
              │     │        │          │
              │     │Resolved│          │ Requires
              │     └────────┘          │ Changes
              │                         ↓
              │              ┌─────────────────┐
              │              │RequiresChanges  │
              │              └────────┬────────┘
              │                       │
              │                       │ Resubmit
              │                       ↓
              │              ┌────────────────┐
              │              │    InReview    │
              │              └────────┬───────┘
              │                       │
              │                       │ Approve
              │                       ↓
              │              ┌────────────────┐
              │              │    Approved    │
              │              └────────┬───────┘
              │                       │
              │                       │ Close
              │                       ↓
              │              ┌────────────────┐
              └──────────────►    Closed      │
                             └────────────────┘
                                      ↓
                             ┌────────────────┐
                             │  Cancelled     │
                             └────────────────┘
```

---

## States

### Draft

**Description**: Initial state for newly created cases. Case is being prepared for submission.

**Characteristics**:
- Case can be edited freely
- Case can be deleted
- Not visible to medical reviewers
- No regulatory reporting obligations
- No timeline enforcement

**Allowed Actions**:
- Edit case
- Add/remove documents
- Delete case
- Submit case
- Cancel case

**Permissions**:
- Creator: Full edit access
- Managers (RA2): Full edit access
- Coordinators (RA1): Read-only access

**Exit Transitions**:
- Submit → Open
- Cancel → Cancelled

---

### Open

**Description**: Case submitted and awaiting medical review or additional documentation.

**Characteristics**:
- Case is active and visible
- Can be edited by managers
- Documents can be added
- Queries can be created
- Timeline tracking begins

**Allowed Actions**:
- Edit case (managers only)
- Upload documents
- Create queries
- Submit for medical review
- Cancel case (with reason)

**Permissions**:
- Managers (RA2): Full edit access
- Coordinators (RA1): Read-only access
- Medical Reviewers: Read-only access (for assessment)

**Exit Transitions**:
- Submit for Review → InReview
- Create Query → OnHold
- Cancel → Cancelled

**Business Rules**:
- Minimum documentation required before review submission
- All required fields must be complete
- No open queries when submitting for review

---

### OnHold

**Description**: Case is on hold pending response to site query.

**Characteristics**:
- Case locked from editing (except query responses)
- Medical review paused
- SLA clock stopped
- Query response required
- Timeline extends based on query resolution

**Allowed Actions**:
- View case
- Respond to query
- View documents
- Cancel query
- Cancel case (with reason)

**Permissions**:
- All roles: Read-only access
- Site staff: Can respond to queries
- Query creator: Can resolve queries

**Exit Transitions**:
- Query Resolved → Open (returns to previous state before query)
- Cancel → Cancelled

**Business Rules**:
- Only query creator can resolve query
- Case automatically returns to previous state when all queries resolved
- Multiple queries can be open simultaneously
- Case remains OnHold until all queries resolved

---

### InReview

**Description**: Case is under medical review by qualified medical reviewer.

**Characteristics**:
- Case locked from editing (manager/coordinator cannot edit)
- Medical reviewer can add assessments
- SLA tracking for review timeline
- Notifications sent on SLA milestones

**Allowed Actions** (Medical Reviewer only):
- View case and documents
- Add medical review assessment
- Request changes (return to manager)
- Create site query
- Approve case
- Escalate to safety board

**Permissions**:
- Medical Reviewer: Full review access
- Managers/Coordinators: Read-only access
- Administrators: Full access

**Exit Transitions**:
- Approve → Approved
- Require Changes → RequiresChanges
- Create Query → OnHold
- Escalate → InReview (with escalation flag)

**Business Rules**:
- Only assigned medical reviewer can perform review actions
- Electronic signature required for approval
- Review must be completed within SLA (2 business days default)
- All required assessments must be completed before approval

**SLA Milestones**:
- 50% (1 day): Reminder notification
- 100% (2 days): Overdue notification
- 150% (3 days): Escalation notification to manager

---

### RequiresChanges

**Description**: Medical reviewer has identified issues requiring manager to make corrections.

**Characteristics**:
- Case returned to manager
- Specific change requests documented
- Manager can edit case
- Timeline tracking for corrections
- Must be resubmitted after changes

**Allowed Actions**:
- View case and documents
- Edit case (address change requests)
- Upload additional documents
- Resubmit for review
- Create clarification queries

**Permissions**:
- Managers (RA2): Full edit access
- Medical Reviewer: Read-only access (to monitor changes)
- Coordinators (RA1): Read-only access

**Exit Transitions**:
- Resubmit → InReview
- Cancel → Cancelled

**Business Rules**:
- Change requests from reviewer must be documented
- Manager must address all change requests
- Attestation required that changes made
- Case re-enters review queue on resubmission

**Change Request Tracking**:
- Each change request tracked individually
- Manager marks each as "Addressed"
- System validates all marked before resubmission

---

### Approved

**Description**: Medical review complete, case approved for regulatory reporting.

**Characteristics**:
- Case locked from editing
- Medical review assessment final
- Electronic signature captured
- Ready for sponsor submission
- Audit trail complete

**Allowed Actions**:
- View case (read-only)
- Generate reports
- Export case data
- Close case
- Reopen for correction (administrator only)

**Permissions**:
- All roles: Read-only access
- Administrator: Can reopen if needed
- No editing allowed (maintains regulatory integrity)

**Exit Transitions**:
- Close → Closed
- Reopen → RequiresChanges (administrator only, rare)

**Business Rules**:
- Electronic signature required for approval state
- Approved cases included in next sponsor report
- No edits allowed without formal amendment process
- Audit trail locked and tamper-proof

**Notifications**:
- Manager notified of approval
- Sponsor notified for reporting
- Regulatory affairs notified
- Case added to reporting queue

---

### Closed

**Description**: Final state - case complete and archived.

**Characteristics**:
- Case locked permanently (read-only)
- Included in completed case archives
- No further actions allowed
- Retained per regulatory requirements
- Audit trail complete and locked

**Allowed Actions**:
- View case (read-only)
- Generate reports
- Export case data
- Archive to long-term storage

**Permissions**:
- All roles: Read-only access
- No modification permissions

**Exit Transitions**:
- None (terminal state)
- Reopen to Approved (administrator only, very rare, requires justification)

**Business Rules**:
- No edits ever allowed in closed state
- Case retained for trial duration + regulatory period
- Automated archival after retention period
- Complete audit trail preserved

**Retention**:
- Minimum retention: Duration of trial + 2 years
- Extended retention: Per sponsor requirements
- Automated retention alerts
- Compliance with regulatory requirements (FDA, ICH-GCP)

---

### Cancelled

**Description**: Case cancelled/withdrawn before completion.

**Characteristics**:
- Case withdrawn from workflow
- Cancellation reason required
- Audit trail preserved
- Not included in sponsor reports
- Retained for audit purposes

**Allowed Actions**:
- View case (read-only)
- View cancellation reason
- Export case data (audit purposes)

**Permissions**:
- All roles: Read-only access
- No modification permissions

**Exit Transitions**:
- Reopen → Open (administrator only, with justification)

**Business Rules**:
- Cancellation reason required (minimum 50 characters)
- Administrator approval required for cancellation from certain states
- Audit trail indicates who cancelled and why
- Case data preserved (not deleted)

**Cancellation Reasons** (examples):
- Duplicate case entry
- Non-reportable event (upon further review)
- Data entry error
- Subject withdrawn from trial
- Protocol deviation
- Other (specify)

---

## State Transitions

### Transition Matrix

| From State | To State | Action | Role Required | Validation |
|------------|----------|--------|---------------|------------|
| Draft | Open | Submit | Coordinator, Manager | Required fields complete |
| Draft | Cancelled | Cancel | Creator, Manager | Reason required |
| Open | InReview | Submit for Review | Manager | Completeness check, no open queries |
| Open | OnHold | Create Query | Manager, Reviewer | Query details required |
| Open | Cancelled | Cancel | Manager | Reason required |
| OnHold | Open | Resolve Query | Query creator | Response provided |
| OnHold | Cancelled | Cancel | Manager | Reason required |
| InReview | Approved | Approve | Medical Reviewer | All assessments complete, e-signature |
| InReview | RequiresChanges | Require Changes | Medical Reviewer | Change requests specified |
| InReview | OnHold | Create Query | Medical Reviewer | Query details required |
| RequiresChanges | InReview | Resubmit | Manager | Change requests addressed |
| RequiresChanges | Cancelled | Cancel | Manager | Reason required |
| Approved | Closed | Close | Manager, Administrator | None |
| Closed | Approved | Reopen | Administrator only | Justification required |
| Cancelled | Open | Reopen | Administrator only | Justification required |

---

## State Transition Rules

### Automatic Transitions

**Query Resolution**:
- When query resolved: OnHold → (previous state)
- System automatically detects query resolution
- State restored to pre-query state
- Audit log records state restoration

**Multiple Queries**:
- Case remains OnHold until ALL queries resolved
- Partial query resolution does not transition state
- Dashboard shows query count and status

### Prevented Transitions

**Cannot transition IF**:
- Required fields incomplete (Draft → Open)
- Open queries exist (Open → InReview)
- Review incomplete (InReview → Approved)
- Change requests not addressed (RequiresChanges → InReview)

**Error Messages**:
- "Cannot submit: Required fields missing" (list fields)
- "Cannot submit for review: 2 open queries must be resolved"
- "Cannot approve: Medical assessment incomplete"
- "Cannot resubmit: 3 change requests not addressed"

---

## Audit Trail

### State Transition Logging

**Information Captured**:
- Case ID and case number
- From State
- To State
- Transition trigger (user action or system)
- User ID and name
- Timestamp (UTC)
- IP address
- Reason/comment (if required)
- Electronic signature (if applicable)

**Audit Table Structure**:
```sql
CREATE TABLE SAEStateHistory (
    StateHistoryID      INT IDENTITY(1,1) PRIMARY KEY,
    CaseID              INT NOT NULL,
    FromState           NVARCHAR(50) NULL,
    ToState             NVARCHAR(50) NOT NULL,
    TransitionAction    NVARCHAR(100) NOT NULL,
    TransitionDate      DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    TransitionBy        UNIQUEIDENTIFIER NOT NULL,
    TransitionReason    NVARCHAR(500) NULL,
    ElectronicSignature BIT NOT NULL DEFAULT 0,
    SignatureDetails    NVARCHAR(MAX) NULL,
    IPAddress           NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_SAEStateHistory_Case FOREIGN KEY (CaseID) REFERENCES SAECase(CaseID)
)
```

---

## Business Rules

### BR-1: State Integrity
- Only valid transitions allowed
- State must always be one of defined states
- No manual state override (except administrator with audit)
- State changes atomic (all-or-nothing)

### BR-2: Role-Based Transitions
- State transitions restricted by role
- Permissions enforced before transition
- Authorization logged in audit trail

### BR-3: Required Validations
- Validation performed before transition
- Failed validation prevents transition
- Specific error messages for each validation

### BR-4: Electronic Signatures
- Required for critical transitions (Approve)
- Captured per 21 CFR Part 11
- Audit trail includes signature details

### BR-5: Timeline Tracking
- SLA starts on specific state entries
- SLA paused in OnHold state
- SLA tracking per state

### BR-6: Notifications
- Automated notifications on state transitions
- Configurable recipients per transition
- Email and in-app notifications

---

## Performance Requirements

### NFR-1: State Transition Performance
- State transition execution: <500ms
- Validation checks: <200ms
- Notification queuing: <1 second
- Audit log write: <100ms

### NFR-2: State Query Performance
- Current state lookup: <50ms (indexed)
- State history retrieval: <200ms
- State-based case filtering: <1 second

---

## User Interface

### Case Header (State Display)

```
┌─────────────────────────────────────────────────────────┐
│ Case: 001-2026-0001                    Status: InReview │
│                                                         │
│ ●─────●─────●─────●─────○                              │
│ Draft Open OnHold InReview Approved                     │
│                                                         │
│ Current: Under Medical Review                           │
│ Assigned: Dr. Jane Smith                                │
│ SLA: 1 day remaining                                    │
└─────────────────────────────────────────────────────────┘
```

### State History View

```
┌─────────────────────────────────────────────────────────┐
│ State History - Case 001-2026-0001                      │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ ● InReview                                              │
│   Submitted for medical review                          │
│   By: Jane Smith (Manager)                              │
│   Date: 2026-01-13 14:30:00 UTC                         │
│                                                         │
│ ● Open                                                  │
│   Query resolved - returned to open                     │
│   By: System (auto)                                     │
│   Date: 2026-01-13 10:15:00 UTC                         │
│                                                         │
│ ● OnHold                                                │
│   Query created - missing vital signs                   │
│   By: Jane Smith (Manager)                              │
│   Date: 2026-01-12 16:00:00 UTC                         │
│                                                         │
│ ● Open                                                  │
│   Case submitted                                        │
│   By: John Doe (Coordinator)                            │
│   Date: 2026-01-10 09:00:00 UTC                         │
│                                                         │
│ ● Draft                                                 │
│   Case created                                          │
│   By: John Doe (Coordinator)                            │
│   Date: 2026-01-10 08:45:00 UTC                         │
└─────────────────────────────────────────────────────────┘
```

---

## Testing Requirements

### Unit Tests
- State transition validation logic
- Permission checking for transitions
- Required field validation
- Electronic signature capture

### Integration Tests
- Complete workflow paths (Draft → Closed)
- Alternative paths (queries, changes required)
- Notification triggers
- Audit log creation

### Security Tests
- Unauthorized state transition attempts
- Role permission enforcement
- Audit trail integrity
- Electronic signature validation

---

## Acceptance Criteria

### AC-1: State Management
- ✅ Only valid transitions allowed
- ✅ Invalid transitions blocked with clear errors
- ✅ State always consistent
- ✅ Audit trail complete

### AC-2: Permissions
- ✅ Role-based access enforced
- ✅ Unauthorized actions blocked
- ✅ Permission checks logged

### AC-3: Validation
- ✅ Completeness checks work
- ✅ Required fields enforced
- ✅ Business rules validated

### AC-4: Audit Trail
- ✅ All transitions logged
- ✅ Complete audit information captured
- ✅ 21 CFR Part 11 compliant
- ✅ Tamper-proof audit trail

### AC-5: Workflow
- ✅ Complete lifecycle supported
- ✅ Query workflow works
- ✅ Review workflow works
- ✅ Closure workflow works

---

## Related Features

- [Create SAE Case](./create-case.md)
- [Upload Documents](./upload-documents.md)
- [Medical Review](./medical-review.md)
- [Site Queries](./site-queries.md)

---

## References

### Architecture Documentation
- [SAE Use Cases](/current/src/docs/architecture/gateway/sae-use-cases.md)
- [21 CFR Part 11 Compliance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/part-11-electronic-records-electronic-signatures-scope-and-application)

### Regulatory Standards
- FDA 21 CFR Part 11 - Electronic Records
- ICH-GCP E2A - Clinical Safety Data Management
- ICH-GCP E6 - Good Clinical Practice

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
