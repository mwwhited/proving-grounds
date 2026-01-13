# Feature Specification: Create SAE Case

**Feature Area**: SAE Management
**User Roles**: Coordinator (RA1), Manager (RA2)
**Priority**: Critical
**Status**: Active
**Regulatory**: 21 CFR Part 11 Compliant

---

## Overview

The Create SAE Case feature enables research coordinators and managers to initiate safety adverse event cases when adverse events occur during clinical trials. This feature implements comprehensive data capture, validation, and audit trail requirements to meet Good Clinical Practice (GCP) and FDA regulatory compliance standards.

### Business Context

SAE case creation is critical for:
- Timely reporting of adverse events in clinical trials
- Patient safety monitoring and intervention
- Regulatory compliance (FDA, GCP, ICH-GCP)
- Sponsor notification requirements
- Risk assessment and safety signal detection
- Audit trail for regulatory inspections

---

## User Stories

### Primary User Story

**As a** Research Coordinator (RA1)
**I want to** create a new SAE case when an adverse event occurs
**So that** the event is properly documented and can be reviewed according to protocol requirements

### Secondary User Stories

**As a** Manager (RA2)
**I want to** create SAE cases with full data entry capabilities
**So that** I can efficiently document complex adverse events

**As a** Medical Reviewer
**I want to** receive complete SAE cases with all required information
**So that** I can accurately assess the event severity and causality

**As a** Regulatory Affairs Officer
**I want to** ensure all SAE cases have complete audit trails
**So that** we can demonstrate compliance during inspections

**As a** Clinical Trial Sponsor
**I want to** be notified of new SAE cases immediately
**So that** we can meet regulatory reporting timelines

---

## Functional Requirements

### FR-1: Case Creation Form

**Description**: Comprehensive form for capturing adverse event information.

**URL**: `/SAE/CreateCase`

**Authorization**: Coordinator (RA1) or Manager (RA2)

**Form Sections**:

#### 1. Subject Information
| Field Name | Type | Required | Validation | Description |
|------------|------|----------|------------|-------------|
| Trial | Dropdown | Yes | Must be active trial | Clinical trial identifier |
| Site | Dropdown | Yes | Must be active site | Clinical site identifier |
| Subject ID | Text | Yes | Valid subject in trial/site | Subject identifier (anonymized) |
| Initials | Text | Yes | 2-3 letters | Subject initials (e.g., JD) |
| Age | Number | Yes | 0-120 | Subject age at event |
| Gender | Dropdown | Yes | M/F/Other | Subject gender |

#### 2. Event Information
| Field Name | Type | Required | Validation | Description |
|------------|------|----------|------------|-------------|
| Event Term | Text | Yes | Max 500 chars | Adverse event description |
| MedDRA Code | Lookup | No | Valid MedDRA code | Medical coding (preferred term) |
| Event Start Date | Date | Yes | Cannot be future | Date event started |
| Event Start Time | Time | No | 24-hour format | Time event started |
| Event End Date | Date | No | >= Start date | Date event resolved |
| Event End Time | Time | No | 24-hour format | Time event resolved |
| Ongoing | Checkbox | No | Auto if no end date | Event still ongoing |

#### 3. Severity Assessment
| Field Name | Type | Required | Validation | Description |
|------------|------|----------|------------|-------------|
| Severity | Dropdown | Yes | Mild/Moderate/Severe | Clinical severity |
| Seriousness Criteria | Checkboxes | Yes (at least one) | Multiple selection | SAE criteria met |
| SAE Criteria Options | | | | |
| - Death | Checkbox | | | Event resulted in death |
| - Life-threatening | Checkbox | | | Immediate risk of death |
| - Hospitalization | Checkbox | | | Required/prolonged hospitalization |
| - Disability/Incapacity | Checkbox | | | Persistent/significant disability |
| - Congenital Anomaly | Checkbox | | | Birth defect |
| - Medically Important | Checkbox | | | Other medically significant event |

#### 4. Causality Assessment
| Field Name | Type | Required | Validation | Description |
|------------|------|----------|------------|-------------|
| Relationship to Study Drug | Dropdown | Yes | Predefined list | Investigator assessment |
| Causality Options | | | | |
| - Not Related | Option | | | No reasonable possibility |
| - Unlikely | Option | | | Doubtful relationship |
| - Possible | Option | | | Reasonable possibility |
| - Probable | Option | | | Likely relationship |
| - Definite | Option | | | Clear causal relationship |
| Expectedness | Dropdown | Yes | Expected/Unexpected | Per investigator brochure |
| Action Taken | Dropdown | Yes | Predefined list | Action with study drug |

#### 5. Outcome Information
| Field Name | Type | Required | Validation | Description |
|------------|------|----------|------------|-------------|
| Outcome | Dropdown | Yes | Predefined list | Event outcome |
| Outcome Options | | | | |
| - Recovered/Resolved | Option | | | Fully recovered |
| - Recovering/Resolving | Option | | | Improving |
| - Not Recovered | Option | | | No improvement |
| - Recovered with Sequelae | Option | | | Permanent effects |
| - Fatal | Option | | | Death |
| - Unknown | Option | | | Outcome not known |

#### 6. Reporter Information
| Field Name | Type | Required | Validation | Description |
|------------|------|----------|------------|-------------|
| Initial Reporter | Text | Yes | Max 200 chars | Who first reported event |
| Reporter Contact | Text | No | Max 200 chars | Contact information |
| Report Date | Date | Yes | Cannot be future | Date event reported |

#### 7. Additional Information
| Field Name | Type | Required | Validation | Description |
|------------|------|----------|------------|-------------|
| Event Description | Textarea | Yes | Max 4000 chars | Detailed narrative |
| Treatment Given | Textarea | No | Max 2000 chars | Medical treatment provided |
| Concomitant Medications | Textarea | No | Max 2000 chars | Other medications |
| Medical History | Textarea | No | Max 2000 chars | Relevant medical history |

### FR-2: Data Validation

**Description**: Comprehensive validation rules to ensure data quality.

**Client-Side Validation**:
- Required field indicators
- Real-time format validation
- Date range validation
- Character count display
- Field dependency validation

**Server-Side Validation**:
- All client-side rules re-validated
- Database constraint validation
- Business rule validation
- Cross-field validation

**Validation Rules**:

| Rule | Description | Error Message |
|------|-------------|---------------|
| Required Fields | All required fields must have values | "[Field] is required" |
| Subject Exists | Subject ID must exist in trial/site | "Invalid subject ID for selected trial/site" |
| Date Logic | End date >= Start date | "End date cannot be before start date" |
| Future Dates | Event dates cannot be in future | "Event date cannot be in the future" |
| SAE Criteria | At least one seriousness criterion | "Please select at least one seriousness criterion" |
| Event Description | Minimum 20 characters | "Please provide a detailed event description (minimum 20 characters)" |
| Case Number Unique | Auto-generated case number unique | System validates uniqueness |

### FR-3: Case Number Generation

**Description**: Automatic generation of unique case identifiers.

**Format**: `{Site}-{Year}-{Sequence}`
- Site: 3-character site code (e.g., 001)
- Year: 4-digit year (e.g., 2026)
- Sequence: 4-digit sequential number (e.g., 0001)
- Example: `001-2026-0001`

**Generation Logic**:
1. System determines site from selection
2. System uses current year
3. System queries max sequence for site/year
4. System increments sequence
5. System formats case number
6. System validates uniqueness
7. System assigns to case

**Uniqueness**:
- Unique across entire system
- Indexed in database
- Validated before insert
- Retry on collision (unlikely)

### FR-4: Initial Case State

**Description**: New cases created in appropriate initial state.

**Initial State**: `Draft`

**State Properties**:
- Created by: Current user
- Created date: Current timestamp (UTC)
- Modified by: Current user
- Modified date: Current timestamp (UTC)
- Current state: Draft
- Previous state: null
- State transition date: Current timestamp

**Draft State Capabilities**:
- Case can be edited by creator
- Case can be edited by managers
- Case can be deleted (by creator or manager)
- Case not visible to medical reviewers
- Case can be submitted (transitions to Open)

### FR-5: Save Options

**Description**: Multiple save options for case creation.

**Save as Draft**:
- Button: "Save as Draft"
- Validates required fields only
- Saves case in Draft state
- Returns to case list
- Success message: "Case saved as draft"

**Save and Continue Editing**:
- Button: "Save and Continue"
- Validates required fields only
- Saves case in Draft state
- Remains on edit page
- Success message: "Case saved"

**Submit Case**:
- Button: "Submit Case"
- Validates ALL fields (including optional recommended fields)
- Saves case
- Transitions state: Draft → Open
- Creates state transition audit entry
- Sends notifications
- Returns to case list
- Success message: "Case submitted successfully"

**Cancel**:
- Button: "Cancel"
- Prompts for confirmation if form dirty
- Discards unsaved changes
- Returns to case list

### FR-6: Auto-Save (Optional Enhancement)

**Description**: Periodic auto-save to prevent data loss.

**Behavior**:
- Auto-save every 2 minutes (configurable)
- Only if form has changes
- Silent save (no page reload)
- Visual indicator: "Saving..." then "Saved at HH:MM"
- Saves as Draft
- Does not trigger validation
- Continues even if validation errors exist

### FR-7: Subject Lookup

**Description**: Validate and lookup subject information.

**Subject ID Validation**:
1. User enters Subject ID
2. System validates format
3. System looks up subject in selected trial/site
4. If found:
   - Auto-populate initials (if available)
   - Auto-populate age (calculated from DOB)
   - Auto-populate gender
   - Display confirmation
5. If not found:
   - Display error message
   - Prompt to verify trial/site selection
   - Allow manual entry (with warning)

**Privacy Protection**:
- Never display full name or DOB
- Only display initials
- Age calculated but DOB not shown
- Subject ID anonymized per protocol

### FR-8: MedDRA Coding Lookup

**Description**: Search and select MedDRA (Medical Dictionary for Regulatory Activities) codes.

**MedDRA Search**:
- Type-ahead search in Event Term field
- Searches Preferred Terms (PT)
- Displays matches as user types
- Shows code and term
- Allows selection from dropdown
- Updates Event Term and MedDRA Code fields

**Manual Entry**:
- User can type free text in Event Term
- MedDRA coding can be added later
- Medical coder role can add codes post-creation

### FR-9: Notifications

**Description**: Notify appropriate personnel when case is created/submitted.

**Notification Triggers**:
- Case submitted (Draft → Open)

**Notification Recipients**:
- Trial manager
- Site manager
- Safety manager
- Medical reviewer queue (if auto-assigned)

**Notification Content**:
```
Subject: New SAE Case Submitted - {CaseNumber}

A new safety adverse event case has been submitted:

Case Number: 001-2026-0001
Trial: TRIAL-XYZ-123
Site: Site 001 - Memorial Hospital
Subject: JD (123456)
Event Term: Anaphylactic reaction
Severity: Severe
Onset Date: 2026-01-10

View Case: [Link]

Submitted by: Jane Smith (Coordinator)
Submitted on: 2026-01-13 14:30:00 UTC
```

**Notification Delivery**:
- Email via message queue
- In-app notification (if implemented)
- SMS to on-call safety officer (configurable)

### FR-10: Audit Trail

**Description**: Comprehensive audit logging per 21 CFR Part 11.

**Logged Events**:

| Event | Action | Details | Captured Data |
|-------|--------|---------|---------------|
| Case created | SAE_Case_Create | Case_Created | User, IP, timestamp, case number |
| Case saved (draft) | SAE_Case_Update | Case_Saved_Draft | User, IP, timestamp, case number |
| Case submitted | SAE_Case_Submit | Case_Submitted | User, IP, timestamp, case number, state change |
| Field modified | SAE_Case_Update | Field_Changed | User, field name, old value, new value, timestamp |
| Validation error | SAE_Case_Validate | Validation_Failed | User, failed validations, timestamp |

**Audit Information**:
- User ID and username
- IP address
- Timestamp (UTC)
- Action performed
- Before/after values (for updates)
- Case number
- State transitions

### FR-11: 21 CFR Part 11 Compliance

**Description**: Meet FDA electronic records requirements.

**Electronic Signature** (for Submit action):
- User confirms submission
- System captures:
  - User identity
  - Timestamp
  - Meaning of signature (submit case)
  - Electronic signature equivalent to handwritten

**Data Integrity**:
- All field changes tracked
- No deletion of data (soft delete only)
- Audit trail tamper-proof
- Date/time stamps in UTC
- User authentication verified

**Access Controls**:
- Role-based access (RA1, RA2)
- User authentication required
- Authorization checked before any action
- Failed access attempts logged

---

## Non-Functional Requirements

### NFR-1: Performance

- Page load: <2 seconds
- Subject lookup: <500ms
- MedDRA search: <300ms
- Save operation: <2 seconds
- Form validation: <200ms
- Auto-save: <1 second (background)

### NFR-2: Reliability

- Data persistence on save
- Transaction support (all-or-nothing)
- Retry on transient failures
- Graceful error handling
- Data recovery from auto-save

### NFR-3: Security

- HTTPS required
- CSRF protection
- SQL injection prevention
- XSS prevention
- Access control enforcement
- Audit trail for all access

### NFR-4: Compliance

**21 CFR Part 11**:
- Electronic signatures
- Audit trails
- System validation
- Access controls

**GCP (Good Clinical Practice)**:
- Complete data capture
- Source document verification
- Timely reporting
- Quality assurance

**ICH-GCP E2A**:
- SAE definition compliance
- Reporting timeline compliance
- Data elements per guidelines

### NFR-5: Usability

- Intuitive form layout
- Clear field labels
- Helpful tooltips
- Progressive disclosure
- Tab order follows reading order
- Keyboard navigation support
- Mobile-responsive (view only)
- Accessible (WCAG 2.1 AA)

### NFR-6: Availability

- Service available 99.9%
- No data loss on failure
- Auto-save prevents data loss
- Clear error messaging

---

## User Interface

### Create Case Form

```
┌─────────────────────────────────────────────────────────┐
│ Create Safety Adverse Event Case                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│ [Subject Information]                                   │
│                                                         │
│ Trial: *     [▼ Select Trial ▼▼▼▼▼▼▼▼▼▼▼▼▼]            │
│ Site: *      [▼ Select Site ▼▼▼▼▼▼▼▼▼▼▼▼▼▼]            │
│ Subject ID: * [____________] [Lookup]                   │
│ Initials: *  [___] (auto-populated)                     │
│ Age: *       [___] years (auto-populated)               │
│ Gender: *    [▼ Select ▼▼]                              │
│                                                         │
│ [Event Information]                                     │
│                                                         │
│ Event Term: * [____________________________________]    │
│               (Type to search MedDRA codes)             │
│ MedDRA Code:  [____________] (auto-filled or manual)    │
│                                                         │
│ Event Start Date: * [📅 01/10/2026]                     │
│ Event Start Time:   [⏰ 14:30]                          │
│ Event End Date:     [📅 01/12/2026]                     │
│ Event End Time:     [⏰ 10:00]                          │
│ □ Event ongoing                                         │
│                                                         │
│ [Severity Assessment]                                   │
│                                                         │
│ Severity: * ○ Mild  ○ Moderate  ⦿ Severe                │
│                                                         │
│ Seriousness Criteria: * (Select at least one)          │
│ ☑ Death                                                 │
│ ☑ Life-threatening                                      │
│ □ Hospitalization (initial or prolonged)                │
│ □ Persistent or significant disability/incapacity       │
│ □ Congenital anomaly/birth defect                       │
│ □ Other medically important event                       │
│                                                         │
│ [Causality Assessment]                                  │
│                                                         │
│ Relationship to Study Drug: * [▼ Possible ▼▼▼▼▼▼▼]     │
│ Expectedness: * ○ Expected  ⦿ Unexpected                │
│ Action Taken: * [▼ Drug Withdrawn ▼▼▼▼▼▼▼▼▼▼▼]         │
│                                                         │
│ [Outcome]                                               │
│                                                         │
│ Outcome: * [▼ Recovered/Resolved ▼▼▼▼▼▼▼▼▼▼▼]          │
│                                                         │
│ [Event Description]                                     │
│                                                         │
│ Event Narrative: *                                      │
│ [________________________________________________]      │
│ [________________________________________________]      │
│ [________________________________________________]      │
│ [________________________________________________]      │
│                                    (250 / 4000 chars)   │
│                                                         │
│ Treatment Given:                                        │
│ [________________________________________________]      │
│ [________________________________________________]      │
│                                    (0 / 2000 chars)     │
│                                                         │
│                                                         │
│ Last saved: 2 minutes ago              Auto-save: On    │
│                                                         │
│ [Cancel] [Save as Draft] [Save & Continue] [Submit Case]│
└─────────────────────────────────────────────────────────┘

* Required field
```

---

## API Endpoints

### GET /SAE/CreateCase
**Description**: Display create case form
**Authorization**: Coordinator (RA1) or Manager (RA2)
**Returns**: Create case form view

### POST /SAE/CreateCase
**Description**: Save new case
**Authorization**: Coordinator (RA1) or Manager (RA2)

**Request Body**: SAECaseModel (JSON)

**Parameters**:
- `saveAction`: "draft" | "continue" | "submit"

**Success Response** (200 OK):
```json
{
  "Success": true,
  "CaseNumber": "001-2026-0001",
  "CaseId": 12345,
  "State": "Draft",
  "Message": "Case saved successfully",
  "RedirectUrl": "/SAE/List" // or /SAE/Edit/{id} for continue
}
```

**Validation Error** (400 Bad Request):
```json
{
  "Success": false,
  "ModelState": {
    "SubjectID": ["Invalid subject ID for selected trial/site"],
    "EventDescription": ["Event description must be at least 20 characters"]
  }
}
```

### POST /SAE/LookupSubject
**Description**: Validate and lookup subject information
**Authorization**: Coordinator (RA1) or Manager (RA2)

**Request**:
```json
{
  "TrialId": 123,
  "SiteId": 456,
  "SubjectId": "S-001"
}
```

**Response** (200 OK):
```json
{
  "Found": true,
  "Initials": "JD",
  "Age": 45,
  "Gender": "M",
  "EnrolledDate": "2025-06-15"
}
```

### POST /SAE/SearchMedDRA
**Description**: Search MedDRA codes
**Authorization**: Coordinator (RA1) or Manager (RA2)

**Request**:
```json
{
  "SearchTerm": "anaphy",
  "MaxResults": 10
}
```

**Response** (200 OK):
```json
{
  "Results": [
    {
      "Code": "10002198",
      "PreferredTerm": "Anaphylactic reaction"
    },
    {
      "Code": "10002199",
      "PreferredTerm": "Anaphylactic shock"
    }
  ]
}
```

---

## Data Model

### SAECase Table

```sql
CREATE TABLE SAECase (
    CaseID              INT IDENTITY(1,1) PRIMARY KEY,
    CaseNumber          NVARCHAR(50) NOT NULL UNIQUE,
    TrialID             INT NOT NULL,
    SiteID              INT NOT NULL,
    SubjectID           NVARCHAR(50) NOT NULL,

    -- Subject Info
    SubjectInitials     NVARCHAR(10) NOT NULL,
    SubjectAge          INT NOT NULL,
    SubjectGender       NVARCHAR(10) NOT NULL,

    -- Event Info
    EventTerm           NVARCHAR(500) NOT NULL,
    MedDRACode          NVARCHAR(20) NULL,
    EventStartDate      DATE NOT NULL,
    EventStartTime      TIME NULL,
    EventEndDate        DATE NULL,
    EventEndTime        TIME NULL,
    EventOngoing        BIT NOT NULL DEFAULT 0,

    -- Severity
    Severity            NVARCHAR(20) NOT NULL, -- Mild, Moderate, Severe

    -- Seriousness Criteria (flags)
    SAE_Death           BIT NOT NULL DEFAULT 0,
    SAE_LifeThreat      BIT NOT NULL DEFAULT 0,
    SAE_Hospitalization BIT NOT NULL DEFAULT 0,
    SAE_Disability      BIT NOT NULL DEFAULT 0,
    SAE_CongenitalAnomaly BIT NOT NULL DEFAULT 0,
    SAE_MedicallyImportant BIT NOT NULL DEFAULT 0,

    -- Causality
    RelationshipToStudyDrug NVARCHAR(50) NOT NULL,
    Expectedness        NVARCHAR(20) NOT NULL,
    ActionTaken         NVARCHAR(100) NULL,

    -- Outcome
    Outcome             NVARCHAR(50) NOT NULL,

    -- Narratives
    EventDescription    NVARCHAR(MAX) NOT NULL,
    TreatmentGiven      NVARCHAR(MAX) NULL,
    ConcomitantMeds     NVARCHAR(MAX) NULL,
    MedicalHistory      NVARCHAR(MAX) NULL,

    -- Reporter
    InitialReporter     NVARCHAR(200) NOT NULL,
    ReporterContact     NVARCHAR(200) NULL,
    ReportDate          DATE NOT NULL,

    -- State Machine
    CurrentState        NVARCHAR(50) NOT NULL DEFAULT 'Draft',
    PreviousState       NVARCHAR(50) NULL,
    StateTransitionDate DATETIME2 NOT NULL DEFAULT GETUTCDATE(),

    -- Audit Fields
    CreatedBy           UNIQUEIDENTIFIER NOT NULL,
    CreatedDate         DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedBy          UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate        DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    CreatedByIP         NVARCHAR(50) NOT NULL,
    ModifiedByIP        NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_SAECase_Trial FOREIGN KEY (TrialID) REFERENCES Trials(TrialID),
    CONSTRAINT FK_SAECase_Site FOREIGN KEY (SiteID) REFERENCES Sites(SiteID),
    CONSTRAINT FK_SAECase_Creator FOREIGN KEY (CreatedBy) REFERENCES AspNetUsers(UserId),
    CONSTRAINT FK_SAECase_Modifier FOREIGN KEY (ModifiedBy) REFERENCES AspNetUsers(UserId),
    CONSTRAINT CK_SAECase_Severity CHECK (Severity IN ('Mild', 'Moderate', 'Severe')),
    CONSTRAINT CK_SAECase_State CHECK (CurrentState IN ('Draft', 'Open', 'InReview', 'OnHold', 'RequiresChanges', 'Approved', 'Closed', 'Cancelled'))
)

CREATE UNIQUE INDEX UX_SAECase_CaseNumber ON SAECase(CaseNumber)
CREATE INDEX IX_SAECase_Trial ON SAECase(TrialID)
CREATE INDEX IX_SAECase_Site ON SAECase(SiteID)
CREATE INDEX IX_SAECase_Subject ON SAECase(SubjectID)
CREATE INDEX IX_SAECase_State ON SAECase(CurrentState)
CREATE INDEX IX_SAECase_CreatedDate ON SAECase(CreatedDate DESC)
```

### SAEStateHistory Table

```sql
CREATE TABLE SAEStateHistory (
    StateHistoryID      INT IDENTITY(1,1) PRIMARY KEY,
    CaseID              INT NOT NULL,
    FromState           NVARCHAR(50) NULL,
    ToState             NVARCHAR(50) NOT NULL,
    TransitionDate      DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    TransitionBy        UNIQUEIDENTIFIER NOT NULL,
    TransitionReason    NVARCHAR(500) NULL,
    IPAddress           NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_SAEStateHistory_Case FOREIGN KEY (CaseID) REFERENCES SAECase(CaseID),
    CONSTRAINT FK_SAEStateHistory_User FOREIGN KEY (TransitionBy) REFERENCES AspNetUsers(UserId)
)

CREATE INDEX IX_SAEStateHistory_CaseID ON SAEStateHistory(CaseID)
CREATE INDEX IX_SAEStateHistory_Date ON SAEStateHistory(TransitionDate DESC)
```

---

## Business Rules

### BR-1: Case Number
- Auto-generated on first save
- Format: {Site}-{Year}-{Sequence}
- Unique across entire system
- Never reused

### BR-2: Initial State
- All new cases start in Draft state
- Draft cases can be edited by creator
- Draft cases can be edited by managers

### BR-3: Required Fields
- All fields marked with * are required
- At least one seriousness criterion required
- Event description minimum 20 characters

### BR-4: Date Logic
- Event start date required
- Event end date must be >= start date
- Event dates cannot be in future
- Report date cannot be in future

### BR-5: Subject Validation
- Subject must exist in selected trial/site
- Subject must be enrolled (active status)

### BR-6: State Transitions
- Draft → Open: Submit case
- Only valid transitions allowed
- State history tracked

---

## Acceptance Criteria

### AC-1: Case Creation
- ✅ Coordinator can create new case
- ✅ Manager can create new case
- ✅ Case number auto-generated
- ✅ Case saved in Draft state
- ✅ Audit trail created

### AC-2: Validation
- ✅ Required fields enforced
- ✅ Date logic validated
- ✅ Subject validated against trial/site
- ✅ Seriousness criteria required
- ✅ Clear error messages

### AC-3: Save Options
- ✅ Save as Draft works
- ✅ Save and Continue works
- ✅ Submit transitions state
- ✅ Cancel discards changes

### AC-4: Notifications
- ✅ Submission triggers notifications
- ✅ Appropriate recipients notified
- ✅ Notification includes key details

### AC-5: Compliance
- ✅ Audit trail complete
- ✅ 21 CFR Part 11 compliant
- ✅ GCP compliant data capture

---

## Related Features

- [Upload Documents](./upload-documents.md)
- [Medical Review](./medical-review.md)
- [Site Queries](./site-queries.md)
- [SAE Workflow](./workflow.md)

---

## References

- [SAE Use Cases](/current/src/docs/architecture/gateway/sae-use-cases.md)
- [21 CFR Part 11 Compliance](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/part-11-electronic-records-electronic-signatures-scope-and-application)

---

**Document Version**: 1.0
**Last Updated**: 2026-01-13
**Author**: Architecture Team
**Status**: Draft for Review
