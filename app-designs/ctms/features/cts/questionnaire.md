# CTS Feature Specification: Configurable Screening Questionnaire

## Overview

The Configurable Screening Questionnaire enables flexible, protocol-specific subject screening with dynamic question flow, real-time validation, and automatic eligibility determination.

## Feature Details

**Feature Name**: Configurable Screening Questionnaire
**Module**: Clinical Trial System (CTS)
**Actors**: Subscriber (Site User), System Administrator
**Priority**: High
**Status**: Implementation Ready

## User Stories

1. **As a Subscriber**, I want to screen subjects using a questionnaire so I can determine eligibility
2. **As a Subscriber**, I want to see real-time eligibility status so I know if subject qualifies
3. **As an Administrator**, I want to configure questionnaires without code changes so I can adapt to protocols
4. **As a Subject**, I want clear questions and feedback so I understand the process
5. **As a Subscriber**, I want conditional logic so irrelevant questions are skipped

## Functional Requirements

### FR-1: Question Display
- Present questions in configured order
- Display question text clearly
- Show help text/tooltips
- Support multiple question types
- Indicate required vs optional

### FR-2: Answer Capture
- Support multiple answer types (yes/no, multiple choice, numeric, date, text)
- Validate answers in real-time
- Provide immediate feedback
- Allow answer modification
- Auto-save progress

### FR-3: Conditional Logic
- Skip questions based on previous answers
- Gender-specific question filtering
- Dependency-based question flow
- Complex rule evaluation
- Dynamic questionnaire adaptation

### FR-4: Eligibility Determination
- Evaluate inclusion criteria real-time
- Evaluate exclusion criteria real-time
- Display ineligibility reasons immediately
- Calculate overall eligibility status
- Support complex eligibility rules

### FR-5: Visual Feedback
- Color-code answers (green/yellow/red)
- Progress indicator
- Completion percentage
- Error highlighting
- Success confirmation

## ASCII Art Mockups

### Screening Questionnaire - Start

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Clinical Trial Screening                    Site 101 - Memorial Hospital    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Subject Screening - Protocol ABC-2026-001                                  │
│  Cardiovascular Outcomes Trial                                              │
│                                                                              │
│  Subject Information                                                        │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Subject Initials: * [___] . [___] .  (First, Middle, Last)             │ │
│  │                                                                         │ │
│  │ Date of Birth: *    [__/__/____]  Age: [Auto-calculated]               │ │
│  │                                                                         │ │
│  │ Gender: *           ● Male   ○ Female   ○ Other                         │ │
│  │                                                                         │ │
│  │ Screening Date: *   [01/13/2026]  📅                                    │ │
│  │                                                                         │ │
│  │ Site Screen ID:     [SITE101-SCR-0234_____]                             │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Instructions                                                               │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ This questionnaire will determine if the subject meets eligibility      │ │
│  │ criteria for the study. Please answer all questions accurately.        │ │
│  │                                                                         │ │
│  │ • Questions marked with * are required                                 │ │
│  │ • Answers will be color-coded:                                         │ │
│  │   - Green: Eligible response                                           │ │
│  │   - Yellow: Caution/requires attention                                 │ │
│  │   - Red: Ineligible response                                           │ │
│  │ • You can save and resume screening at any time                        │ │
│  │ • Eligibility will be determined automatically as you progress         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  ☑ I have explained the screening process to the subject                    │
│  ☑ Subject has provided verbal consent for screening                        │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [Cancel]  [Save for Later]  [Begin Screening >]                            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Questionnaire - In Progress

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Subject Screening - Protocol ABC-2026-001                    [Save] [Exit]  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Subject: J.D. (Male, 68 years)  │  Site Screen ID: SITE101-SCR-0234        │
│                                                                              │
│  Progress: ████████████░░░░░░░░░░ 12 of 20 questions (60%)                  │
│                                                                              │
│  Current Eligibility Status: ✓ ELIGIBLE (so far)                            │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Inclusion Criteria (4 of 5 met)                                            │
│  ✓ Age ≥ 18 years         ✓ History of CV disease                           │
│  ✓ Willing to participate ⏹ LDL cholesterol > 70 mg/dL (pending lab)       │
│  ✓ Able to provide consent                                                  │
│                                                                              │
│  Exclusion Criteria (0 violations)                                          │
│  ✓ No pregnancy  ✓ No recent MI  ✓ No severe hepatic impairment             │
│                                                                              │
│  ═════════════════════════════════════════════════════════════════════     │
│                                                                              │
│  Question 13 of 20                                                          │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Does the subject have a history of diabetes mellitus? *               │ │
│  │                                                                         │ │
│  │  ● Yes   ○ No   ○ Unknown                                               │ │
│  │                                                                         │ │
│  │  ℹ This is an inclusion criterion. Either answer is acceptable.        │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│  ✓ Answered - Eligible response                                             │
│                                                                              │
│  ↓ Additional questions based on your answer:                               │
│                                                                              │
│  Question 14 of 20 (Conditional)                                            │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  What is the subject's most recent HbA1c value? *                      │ │
│  │                                                                         │ │
│  │  [_______] %     Date of test: [__/__/____]                            │ │
│  │                                                                         │ │
│  │  Valid range: 4.0% - 15.0%                                             │ │
│  │  ⚠ Values > 9.0% may require medical review                            │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Question 15 of 20 (Conditional)                                            │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Is the subject currently taking any diabetes medications? *           │ │
│  │                                                                         │ │
│  │  ● Yes   ○ No                                                           │ │
│  │                                                                         │ │
│  │  If Yes, please list medications: (Optional)                           │ │
│  │  ┌──────────────────────────────────────────────────────────────┐      │ │
│  │  │ Metformin 1000mg BID                                         │      │ │
│  │  │                                                              │      │ │
│  │  └──────────────────────────────────────────────────────────────┘      │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│  ✓ Answered - Eligible response                                             │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [< Previous]  [Save Progress]  [Next >]                                    │
│                                                                              │
│  Auto-save: Last saved 30 seconds ago                                       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Ineligibility Detected

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Subject Screening - Protocol ABC-2026-001                    [Save] [Exit]  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Subject: M.T. (Female, 45 years)  │  Site Screen ID: SITE101-SCR-0235      │
│                                                                              │
│  Progress: ████████░░░░░░░░░░░░░░░░ 8 of 20 questions (40%)                 │
│                                                                              │
│  Current Eligibility Status: ✗ INELIGIBLE                                   │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  ⚠ Subject Does Not Meet Eligibility Criteria                               │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ⚠ EXCLUSION CRITERIA VIOLATED (1)                                       │ │
│  │                                                                         │ │
│  │ ✗ Currently pregnant or breastfeeding                                  │ │
│  │   Response: Yes (Pregnant - 12 weeks)                                  │ │
│  │   Reason: Study drug is contraindicated in pregnancy                   │ │
│  │   Protocol Section: Exclusion Criterion #5                             │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Question 8 of 20                                                           │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Is the subject currently pregnant or breastfeeding? *                 │ │
│  │                                                                         │ │
│  │  ● Yes - Pregnant   ○ Yes - Breastfeeding   ○ No   ○ N/A (Male)        │ │
│  │                                                                         │ │
│  │  If pregnant, gestational age: [12] weeks                              │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│  ✗ Answered - INELIGIBLE response (Exclusion criterion)                     │
│                                                                              │
│  Options for Ineligible Subject:                                            │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ ○ Complete screening for documentation purposes                        │ │
│  │ ● Stop screening and record as screen failure                          │ │
│  │ ○ Save as draft for later review                                       │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Screen Failure Reason: [Pregnant - Protocol Exclusion Criterion #5______] │
│                                                                              │
│  Notes to Subject:                                                          │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ "Thank you for your interest in participating. Unfortunately, the study│ │
│  │  medication has not been tested in pregnant women and you do not       │ │
│  │  qualify for participation at this time. We wish you the best with     │ │
│  │  your pregnancy. You may be eligible for future studies."              │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [Continue Screening]  [Record Screen Failure]  [Save as Draft]             │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Screening Complete - Eligible

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Screening Complete                                                          │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Subject: J.D. (Male, 68 years)  │  Site Screen ID: SITE101-SCR-0234        │
│  Screening Date: 01/13/2026      │  Completed: 01/13/2026 3:45 PM           │
│                                                                              │
│  ✓ SUBJECT IS ELIGIBLE FOR ENROLLMENT                                       │
│                                                                              │
│  ═════════════════════════════════════════════════════════════════════     │
│                                                                              │
│  Eligibility Summary                                                        │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Inclusion Criteria: ALL MET (5/5)                                      │ │
│  │  ✓ Age ≥ 18 years (68 years old)                                        │ │
│  │  ✓ History of cardiovascular disease (Yes - MI 2023)                   │ │
│  │  ✓ LDL cholesterol > 70 mg/dL (105 mg/dL on 01/10/2026)                 │ │
│  │  ✓ Willing to participate (Confirmed)                                  │ │
│  │  ✓ Able to provide informed consent (Confirmed)                        │ │
│  │                                                                         │ │
│  │  Exclusion Criteria: NONE VIOLATED (0/8)                                │ │
│  │  ✓ No pregnancy or breastfeeding (Male - N/A)                          │ │
│  │  ✓ No MI within last 30 days (Last MI: 2023)                           │ │
│  │  ✓ No severe hepatic impairment (AST/ALT normal)                       │ │
│  │  ✓ No severe renal impairment (eGFR 72 mL/min)                         │ │
│  │  ✓ No active cancer requiring treatment                                │ │
│  │  ✓ No uncontrolled hypertension (BP 128/82)                            │ │
│  │  ✓ No current participation in other trials                            │ │
│  │  ✓ No known allergy to study medication                                │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Additional Findings                                                        │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ • Subject has type 2 diabetes (HbA1c: 7.2%)                            │ │
│  │ • Currently on metformin therapy                                       │ │
│  │ • History of smoking (quit 5 years ago)                                │ │
│  │ • On stable statin therapy                                             │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Next Steps                                                                 │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ 1. Proceed with informed consent process                               │ │
│  │ 2. Schedule baseline visit                                             │ │
│  │ 3. Complete enrollment procedures                                      │ │
│  │ 4. Assign subject number                                               │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Screened By: Sarah Martinez                                                │
│  Reviewed By: [To be assigned]                                              │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [Print Summary]  [Email to PI]  [Proceed to Enrollment >]                  │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Configuration Interface (Admin)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Questionnaire Configuration - Protocol ABC-2026-001          [Save] [Exit]  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Configure Screening Questionnaire                                          │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Question List │ Eligibility Rules │ Display Settings │ Preview │ Publish  │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  Questions (20)                                        [+ Add Question]     │
│                                                                              │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ #  Question Text                          Type        Required  Actions│ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ 1  What is the subject's age?             Numeric     Yes       [Edit] │ │
│  │    Rule: Age >= 18                                              [↑][↓] │ │
│  │                                                                        │ │
│  │ 2  Subject gender                         Choice      Yes       [Edit] │ │
│  │    Options: Male, Female, Other                                 [↑][↓] │ │
│  │                                                                        │ │
│  │ 3  History of CV disease?                 Yes/No      Yes       [Edit] │ │
│  │    Eligibility: Must be Yes (Inclusion)                         [↑][↓] │ │
│  │                                                                        │ │
│  │ 4  Currently pregnant/breastfeeding?      Choice      Yes       [Edit] │ │
│  │    Gender filter: Female only                                   [↑][↓] │ │
│  │    Eligibility: Must be No (Exclusion)                                 │ │
│  │    Color: Red if Yes                                                   │ │
│  │                                                                        │ │
│  │ 5  History of diabetes?                   Yes/No      Yes       [Edit] │ │
│  │    Triggers: Q6-Q8 if Yes                                       [↑][↓] │ │
│  │                                                                        │ │
│  │ 6  Most recent HbA1c value?              Numeric     Yes*      [Edit] │ │
│  │    Condition: Show if Q5 = Yes                                  [↑][↓] │ │
│  │    Validation: Range 4.0-15.0                                          │ │
│  │    Warning: If > 9.0                                                   │ │
│  │                                                                        │ │
│  │ ... 14 more questions                                   [Show All]     │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Eligibility Rules Summary                                                  │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Inclusion Criteria: 5 defined    │  Exclusion Criteria: 8 defined      │ │
│  │ Conditional Questions: 8         │  Gender-Specific: 4                 │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  [Test Questionnaire]  [Preview Subject View]  [Publish Changes]            │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Business Rules

### BR-1: Question Flow
- Questions presented in configured order
- Conditional questions shown only when conditions met
- Gender-specific questions filtered automatically
- Previous answers can be modified (recalculates eligibility)

### BR-2: Eligibility Determination
- Real-time evaluation as answers provided
- Inclusion criteria must ALL be met
- ANY exclusion criterion violation = ineligible
- Ineligibility reasons displayed immediately

### BR-3: Data Validation
- Required questions must be answered
- Numeric ranges enforced
- Date validations applied
- Format validations (e.g., phone, email)

### BR-4: Configuration
- Changes require administrator role
- Published versions versioned
- Active screenings use version at start
- Cannot modify published questionnaires (create new version)

## Data Model

```
Questionnaire {
  QuestionnaireID: string (PK)
  ProtocolID: string (FK)
  Version: string
  Title: string
  Instructions: text
  Status: string
  PublishedDate: datetime
  CreatedBy: string (FK)
}

Question {
  QuestionID: string (PK)
  QuestionnaireID: string (FK)
  OrderNumber: integer
  QuestionText: text
  HelpText: text
  QuestionType: string
  Required: boolean
  ValidationRules: json
  ConditionalLogic: json
  GenderFilter: string
  ColorCoding: json
}

ScreeningSession {
  SessionID: string (PK)
  QuestionnaireID: string (FK)
  SiteID: string (FK)
  ScreeningDate: date
  SubjectInitials: string
  SubjectDOB: date
  Gender: string
  Status: string
  EligibilityStatus: string
  IneligibilityReasons: json
  CompletedBy: string (FK)
  CompletedDate: datetime
}

Answer {
  AnswerID: string (PK)
  SessionID: string (FK)
  QuestionID: string (FK)
  AnswerValue: text
  AnsweredDate: datetime
  ModifiedDate: datetime
}
```

## Future Enhancements

1. Multi-language support
2. Voice input for answers
3. Electronic signature integration
4. Photo/document upload for verification
5. AI-assisted eligibility prediction
6. Mobile responsive design
7. Offline mode with sync
8. Patient self-screening portal
9. Advanced branching logic builder
10. Integration with EHR systems
