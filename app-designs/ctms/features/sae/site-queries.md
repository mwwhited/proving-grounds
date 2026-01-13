# Feature Specification: SAE Site Queries

**Feature Area**: SAE Management
**User Role**: Manager (RA2), Medical Reviewer, Site Staff
**Priority**: High
**Status**: Active
**Regulatory**: 21 CFR Part 11 Compliant

---

## Overview

The Site Queries feature enables managers and medical reviewers to request additional information or clarification from clinical sites regarding SAE cases. This bidirectional communication ensures complete and accurate case documentation while maintaining an audit trail of all communications.

---

## User Stories

**As a** Manager (RA2)
**I want to** send queries to sites for additional information
**So that** cases have complete documentation for review and reporting

**As a** Medical Reviewer
**I want to** query sites for clarification during review
**So that** I can accurately assess causality and severity

**As a** Site Coordinator
**I want to** receive and respond to queries about SAE cases
**So that** I can provide additional information needed

**As a** Regulatory Affairs Officer
**I want to** maintain audit trail of all site communications
**So that** we can demonstrate due diligence during inspections

---

## Functional Requirements

### FR-1: Create Query

**Trigger Points**:
- Manager reviewing draft case
- Medical reviewer during review
- Quality assurance review
- Sponsor request for clarification

**URL**: `/SAE/Case/{caseId}/Queries/Create`

**Authorization**: Manager (RA2), Medical Reviewer

**Query Form Fields**:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Query Type | Dropdown | Yes | Category of query |
| Query Subject | Text | Yes | Brief subject line (max 200) |
| Query Question | Textarea | Yes | Detailed question (max 2000) |
| Priority | Dropdown | Yes | Urgency level |
| Due Date | Date | Yes | Response due date |
| Addressed To | Dropdown | Yes | Recipient at site |
| Related Documents | Checkboxes | No | Reference specific documents |

**Query Types**:
- Missing Information
- Clarification Needed
- Document Request
- Timeline Verification
- Treatment Details
- Causality Assessment
- Protocol Compliance
- Other (specify)

**Priority Levels**:
- Low: Response within 10 business days
- Medium: Response within 5 business days
- High: Response within 2 business days
- Urgent: Response within 24 hours

**Recipients**:
- Site Principal Investigator
- Site Coordinator
- Site Manager
- Other (specify)

### FR-2: Query Workflow

**Create Query Process**:
1. User navigates to case queries tab
2. User clicks "Create Query" button
3. System displays query creation form
4. User fills out query details
5. User clicks "Send Query"
6. System validates query
7. System creates query record
8. System transitions case state: (Current) → OnHold
9. System sends notification to site contact
10. System sends copy to manager and reviewer
11. System creates audit log entry
12. System displays confirmation

**Case State During Query**:
- State: OnHold
- Query status: Open
- Case locked from editing (except query responses)
- Medical review paused
- SLA clock stopped

**Query States**:
- Open: Query sent, awaiting response
- Responded: Site has provided response
- Resolved: Response accepted, query closed
- Cancelled: Query withdrawn/no longer needed
- Escalated: No response, escalated to PI

### FR-3: Site Notification

**Email Notification to Site**:
```
Subject: SAE Query - Action Required - Case 001-2026-0001

An SAE case requires additional information:

Case Number: 001-2026-0001
Subject: JD (S-123)
Event: Anaphylactic reaction

Query Type: Missing Information
Priority: High
Due Date: 2026-01-15

Question:
Please provide the complete set of vital signs taken
during the event, including blood pressure, heart rate,
respiratory rate, and oxygen saturation. The narrative
mentions "unstable vitals" but specific values are not
documented.

Please also upload the ICU flow sheet if available.

Respond Online: [Secure Link]
Or contact: study-coordinator@example.com

This query requires a response by 2026-01-15.

Sent by: Jane Smith, Study Manager
Query ID: Q-2026-0042
```

**Notification Methods**:
- Email to site contact (primary)
- In-app notification (if site has portal access)
- SMS to on-call contact (urgent queries only)
- Escalation email to PI if no response

### FR-4: Site Response

**URL**: `/SAE/Queries/{queryId}/Respond` (public, token-based)

**Authorization**: Site staff (via secure link) or authenticated site user

**Response Form**:

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Response Text | Textarea | Yes | Detailed response (max 2000) |
| Supporting Documents | File Upload | No | Additional documents |
| Responder Name | Text | Yes | Name of person responding |
| Responder Role | Text | Yes | Role at site |
| Response Date | Date | Auto | Date of response |

**Response Process**:
1. Site staff receives email with secure link
2. Clicks link to open response form
3. Reads original query
4. Enters response
5. Uploads any supporting documents
6. Enters name and role
7. Clicks "Submit Response"
8. System validates response
9. System updates query status: Open → Responded
10. System sends notification to query creator
11. System creates audit log entry
12. System displays confirmation

**Security**:
- Secure token-based access (no login required)
- Token expires after 30 days
- One-time use token (optional)
- HTTPS required
- IP address logged

### FR-5: Review Response

**Notification to Query Creator**:
```
Subject: SAE Query Response Received - Case 001-2026-0001

A response has been received for your query:

Case: 001-2026-0001
Query: Missing Information
Responded by: Dr. Michael Chen, Site PI
Response Date: 2026-01-14 10:30 UTC

Response Summary:
Vital signs during event:
- BP: 80/50 mmHg
- HR: 120 bpm
- RR: 28/min
- SpO2: 88% on room air

ICU flow sheet attached.

Review Response: [Link]
```

**Response Review Actions**:
- **Accept Response**: Query resolved, case can proceed
- **Request Additional Information**: Follow-up query
- **Reject Response**: Insufficient, re-open query

**Accept Response**:
- Query status: Responded → Resolved
- Case state: OnHold → (Previous state before query)
- Resume medical review (if applicable)
- Resume SLA clock
- Case unlocked for editing (if returned from review)

### FR-6: Query List View

**URL**: `/SAE/Case/{caseId}/Queries`

**Display**:
- All queries for the case
- Sorted by creation date (newest first)
- Status indicator (Open, Responded, Resolved)
- Priority indicator
- Overdue indicator

**Query Card**:
```
┌─────────────────────────────────────────────────────┐
│ Q-2026-0042  [High Priority]  [Overdue]            │
├─────────────────────────────────────────────────────┤
│ Type: Missing Information                           │
│ Subject: Need complete vital signs                  │
│ Created: 2026-01-13 14:00 by Jane Smith             │
│ Due: 2026-01-15                                     │
│ Status: Responded (awaiting review)                 │
│                                                     │
│ Response by: Dr. Michael Chen, 2026-01-14 10:30    │
│                                                     │
│ [View Details] [Review Response] [Send Follow-up]   │
└─────────────────────────────────────────────────────┘
```

### FR-7: Query Dashboard

**URL**: `/SAE/Queries/Dashboard`

**Authorization**: Manager, Medical Reviewer, Administrator

**Metrics**:
- Open queries count
- Queries by priority
- Overdue queries
- Average response time
- Queries by site
- Queries by case

**Filters**:
- By status (Open, Responded, Resolved)
- By priority
- By site
- By date range
- By creator

**Actions**:
- Bulk escalation (for overdue)
- Export to Excel
- Generate report

### FR-8: Automated Escalation

**Escalation Rules**:
- 50% of due date: Reminder email to site
- 100% of due date: Overdue notification to site and manager
- 150% of due date: Escalation to site PI
- 200% of due date: Escalation to sponsor

**Escalation Email** (200% overdue):
```
Subject: URGENT: Overdue SAE Query - Case 001-2026-0001

This SAE query is significantly overdue:

Case: 001-2026-0001
Query: Missing Information
Due Date: 2026-01-15 (10 days overdue)
Priority: High

This query must be answered to complete the SAE case
and meet regulatory reporting timelines.

Immediate action required.

Contact study manager: Jane Smith
Phone: 1-800-XXX-XXXX
Email: study-manager@example.com
```

### FR-9: Query Templates

**Description**: Pre-defined query templates for common scenarios

**Common Templates**:
1. **Missing Vital Signs**
   - Type: Missing Information
   - Standard question about vital signs needed
   - Priority: Medium

2. **Treatment Details**
   - Type: Treatment Details
   - Request for medication details
   - Priority: Medium

3. **Timeline Clarification**
   - Type: Timeline Verification
   - Request for specific dates/times
   - Priority: Low

4. **Document Upload Request**
   - Type: Document Request
   - Request for specific documents
   - Priority: Medium

**Template Usage**:
- Select template from dropdown
- Template pre-fills query fields
- User can customize before sending
- Saves time and ensures consistency

### FR-10: Query Analytics

**Reports**:
- Query volume over time
- Average response time by site
- Most common query types
- Escalation frequency
- Resolution rate

**Insights**:
- Sites needing additional training
- Common documentation gaps
- Process improvement opportunities

### FR-11: Audit Trail

**Logged Events**:

| Event | Action | Details |
|-------|--------|---------|
| Query created | SAE_Query_Create | Query_Created |
| Query sent | SAE_Query_Send | Query_Sent_To_Site |
| Response received | SAE_Query_Respond | Response_Received |
| Response reviewed | SAE_Query_Review | Response_Accepted/Rejected |
| Query resolved | SAE_Query_Resolve | Query_Closed |
| Query escalated | SAE_Query_Escalate | Escalation_Sent |
| Query cancelled | SAE_Query_Cancel | Query_Cancelled |

**Audit Information**:
- User ID and name
- Site contact
- Timestamp (UTC)
- IP address
- Query content (question and response)
- State transitions
- Documents attached

---

## Non-Functional Requirements

### NFR-1: Performance
- Query creation: <1 second
- Query list load: <2 seconds
- Email notification sent: <30 seconds
- Dashboard load: <3 seconds

### NFR-2: Security
- Secure token-based site access
- HTTPS required
- Email encryption (TLS)
- Access logging

### NFR-3: Reliability
- Email delivery guaranteed (retry)
- Escalation automated
- No lost queries
- Audit trail complete

### NFR-4: Usability
- Simple response interface for sites
- Clear due dates and priorities
- Email notifications clear
- Mobile-responsive

---

## User Interface

### Create Query Form

```
┌─────────────────────────────────────────────────────────┐
│ Create Query - Case 001-2026-0001                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Use Template: [▼ Select template (optional) ▼▼▼▼▼▼]    │
│                                                         │
│ Query Type: * [▼ Missing Information ▼▼▼▼▼▼▼▼▼▼▼]      │
│                                                         │
│ Priority: *   ○ Low  ⦿ Medium  ○ High  ○ Urgent         │
│                                                         │
│ Subject: * [___________________________________]        │
│                                                         │
│ Question: *                                             │
│ [________________________________________________]      │
│ [________________________________________________]      │
│ [________________________________________________]      │
│ [________________________________________________]      │
│                                    (125 / 2000 chars)   │
│                                                         │
│ Addressed To: * [▼ Site Coordinator ▼▼▼▼▼▼▼▼▼▼▼]       │
│                                                         │
│ Due Date: * [📅 01/20/2026]  (7 days from now)          │
│                                                         │
│ Related Documents: (Optional)                           │
│ □ Lab Results - CBC with differential                   │
│ □ Chest X-ray                                           │
│                                                         │
│ Preview Email: [Show Preview]                           │
│                                                         │
│                              [Cancel]  [Send Query]     │
└─────────────────────────────────────────────────────────┘
```

### Site Response Form (Public)

```
┌─────────────────────────────────────────────────────────┐
│ Respond to SAE Query                                    │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Case: 001-2026-0001                                     │
│ Query ID: Q-2026-0042                                   │
│ Due Date: 2026-01-15 (2 days remaining)                 │
│                                                         │
│ ┌─────────────────────────────────────────────────┐   │
│ │ Original Question:                              │   │
│ │                                                 │   │
│ │ Please provide the complete set of vital signs  │   │
│ │ taken during the event, including blood         │   │
│ │ pressure, heart rate, respiratory rate, and     │   │
│ │ oxygen saturation.                              │   │
│ └─────────────────────────────────────────────────┘   │
│                                                         │
│ Your Response: *                                        │
│ [________________________________________________]      │
│ [________________________________________________]      │
│ [________________________________________________]      │
│                                    (0 / 2000 chars)     │
│                                                         │
│ Supporting Documents: (Optional)                        │
│ [Drag files here or click to browse]                   │
│                                                         │
│ Your Name: * [_________________]                        │
│ Your Role: * [_________________]                        │
│                                                         │
│                              [Cancel]  [Submit Response]│
└─────────────────────────────────────────────────────────┘
```

---

## Data Model

### SAEQuery Table

```sql
CREATE TABLE SAEQuery (
    QueryID             INT IDENTITY(1,1) PRIMARY KEY,
    QueryNumber         NVARCHAR(50) NOT NULL UNIQUE, -- Q-YYYY-NNNN
    CaseID              INT NOT NULL,

    -- Query Details
    QueryType           NVARCHAR(100) NOT NULL,
    QuerySubject        NVARCHAR(200) NOT NULL,
    QueryQuestion       NVARCHAR(MAX) NOT NULL,
    Priority            NVARCHAR(20) NOT NULL,
    DueDate             DATE NOT NULL,
    AddressedTo         NVARCHAR(200) NOT NULL,

    -- Status
    Status              NVARCHAR(50) NOT NULL DEFAULT 'Open',

    -- Response
    ResponseText        NVARCHAR(MAX) NULL,
    ResponseDate        DATETIME2 NULL,
    ResponderName       NVARCHAR(200) NULL,
    ResponderRole       NVARCHAR(100) NULL,
    ResponderIP         NVARCHAR(50) NULL,

    -- Resolution
    ResolvedBy          UNIQUEIDENTIFIER NULL,
    ResolvedDate        DATETIME2 NULL,
    Resolution          NVARCHAR(50) NULL, -- Accepted, FollowUp, Rejected

    -- Escalation
    EscalationLevel     INT NOT NULL DEFAULT 0,
    LastEscalationDate  DATETIME2 NULL,

    -- Audit
    CreatedBy           UNIQUEIDENTIFIER NOT NULL,
    CreatedDate         DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    CreatedByIP         NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_SAEQuery_Case FOREIGN KEY (CaseID) REFERENCES SAECase(CaseID),
    CONSTRAINT FK_SAEQuery_Creator FOREIGN KEY (CreatedBy) REFERENCES AspNetUsers(UserId),
    CONSTRAINT FK_SAEQuery_Resolver FOREIGN KEY (ResolvedBy) REFERENCES AspNetUsers(UserId),
    CONSTRAINT CK_SAEQuery_Status CHECK (Status IN ('Open', 'Responded', 'Resolved', 'Cancelled', 'Escalated')),
    CONSTRAINT CK_SAEQuery_Priority CHECK (Priority IN ('Low', 'Medium', 'High', 'Urgent'))
)

CREATE INDEX IX_SAEQuery_CaseID ON SAEQuery(CaseID)
CREATE INDEX IX_SAEQuery_Status ON SAEQuery(Status)
CREATE INDEX IX_SAEQuery_DueDate ON SAEQuery(DueDate)
CREATE INDEX IX_SAEQuery_Priority ON SAEQuery(Priority)
```

---

## Business Rules

### BR-1: Query Creation
- Only managers and reviewers can create queries
- Case transitions to OnHold when query created
- Due date must be in future

### BR-2: Response Requirements
- Response text required (minimum 20 characters)
- Responder name and role required
- Supporting documents optional

### BR-3: Query Resolution
- Only query creator can resolve queries
- Resolution within 48 hours of response
- Case state restored when query resolved

### BR-4: Escalation
- Automated escalation based on overdue time
- Manual escalation available
- Escalation notifications to PI and sponsor

---

## Acceptance Criteria

### AC-1: Create Query
- ✅ Manager can create query
- ✅ Reviewer can create query
- ✅ Case transitions to OnHold
- ✅ Notification sent to site

### AC-2: Site Response
- ✅ Site can respond via secure link
- ✅ Response recorded correctly
- ✅ Notification sent to creator

### AC-3: Resolution
- ✅ Creator can review response
- ✅ Accept/reject response works
- ✅ Case state restored on resolution

### AC-4: Escalation
- ✅ Automated reminders sent
- ✅ Escalation triggered on schedule
- ✅ Manual escalation works

### AC-5: Audit
- ✅ All query events logged
- ✅ Complete audit trail
- ✅ 21 CFR Part 11 compliant

---

## Related Features

- [Create SAE Case](./create-case.md)
- [Medical Review](./medical-review.md)
- [SAE Workflow](./workflow.md)

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
