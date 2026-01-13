# CTS Feature Specification: Inclusion/Exclusion Criteria Management

## Overview
Manages complex eligibility rules, real-time evaluation, and maintains audit trail of eligibility decisions.

**Actors**: Administrator, Subscriber
**Priority**: High

## Key Features
- Configurable inclusion/exclusion criteria
- Real-time eligibility evaluation
- Multiple criteria combinations (AND/OR logic)
- Lab value thresholds
- Medication restrictions
- Medical history requirements

## ASCII Mockups

### Criteria Configuration
```
┌──────────────────────────────────────────────────────────────────┐
│ Eligibility Criteria - Protocol ABC-2026-001      [Save] [Test]  │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│  Inclusion Criteria (5)                        [+ Add Criterion] │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │ 1. Age Requirement                                  [Edit]  │  │
│  │    Age >= 18 years AND Age <= 80 years                     │  │
│  │    Mapped to: Question #1                                  │  │
│  │                                                             │  │
│  │ 2. Cardiovascular Disease History               [Edit]  │  │
│  │    Must have documented CV disease                         │  │
│  │    Mapped to: Question #3                                  │  │
│  │                                                             │  │
│  │ 3. LDL Cholesterol Level                            [Edit]  │  │
│  │    LDL > 70 mg/dL (fasting)                                │  │
│  │    Mapped to: Lab value or Question #7                     │  │
│  │                                                             │  │
│  │ 4. Informed Consent                                 [Edit]  │  │
│  │    Willing and able to provide written consent             │  │
│  │    Mapped to: Question #18                                 │  │
│  │                                                             │  │
│  │ 5. Protocol Compliance                              [Edit]  │  │
│  │    Able to comply with protocol requirements               │  │
│  │    Mapped to: Question #19                                 │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                   │
│  Exclusion Criteria (8)                        [+ Add Criterion] │
│  ┌────────────────────────────────────────────────────────────┐  │
│  │ 1. Pregnancy/Breastfeeding                          [Edit]  │  │
│  │    Currently pregnant OR breastfeeding                     │  │
│  │    Gender Filter: Female only                              │  │
│  │    Mapped to: Question #4                                  │  │
│  │                                                             │  │
│  │ 2. Recent MI                                        [Edit]  │  │
│  │    MI within past 30 days                                  │  │
│  │    Mapped to: Question #8-9                                │  │
│  │                                                             │  │
│  │ ... 6 more exclusion criteria               [Show All]     │  │
│  └────────────────────────────────────────────────────────────┘  │
│                                                                   │
│  Logic: ALL inclusion criteria must be met                       │
│         ANY exclusion criterion violation = ineligible           │
│                                                                   │
│  [Preview Rules]  [Test with Sample Data]  [Publish]             │
└──────────────────────────────────────────────────────────────────┘
```

### Real-Time Evaluation Display
```
┌──────────────────────────────────────────────────────────────────┐
│ Eligibility Evaluation - Live Status                             │
├──────────────────────────────────────────────────────────────────┤
│  Subject: J.D. (Male, 68)  │  Screen ID: SITE101-SCR-0234        │
│                                                                   │
│  Overall Status: ✓ ELIGIBLE                                      │
│                                                                   │
│  Inclusion Criteria (5/5 met)                                    │
│  ✓ Age: 68 years (18-80 required)                                │
│  ✓ CV Disease: Yes - MI history (2023)                           │
│  ✓ LDL: 105 mg/dL (>70 required)                                 │
│  ✓ Consent: Willing to participate                               │
│  ✓ Compliance: Able to comply                                    │
│                                                                   │
│  Exclusion Criteria (0/8 violated)                               │
│  ✓ Not pregnant (Male - N/A)                                     │
│  ✓ No recent MI (last MI >30 days ago)                           │
│  ✓ Liver function normal                                         │
│  ✓ Kidney function adequate (eGFR 72)                            │
│  ✓ No active cancer                                              │
│  ✓ BP controlled (128/82)                                        │
│  ✓ Not in other trials                                           │
│  ✓ No drug allergies                                             │
│                                                                   │
│  [View Detailed Evaluation]  [Print Certificate]                 │
└──────────────────────────────────────────────────────────────────┘
```

## Data Model
```
EligibilityCriterion {
  CriterionID: string (PK)
  QuestionnaireID: string (FK)
  Type: string (Inclusion/Exclusion)
  Description: text
  EvaluationRule: json
  MappedQuestions: json
  GenderSpecific: boolean
  OrderNumber: integer
}

EligibilityEvaluation {
  EvaluationID: string (PK)
  SessionID: string (FK)
  EligibilityStatus: string
  InclusionMet: integer
  InclusionTotal: integer
  ExclusionViolations: integer
  ViolationDetails: json
  EvaluatedDate: datetime
}
```
