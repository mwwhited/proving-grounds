# CTS (Clinical Trial Screening) - Entity Relationship Diagram

## Overview

The CTS module manages subject screening, eligibility determination, and enrollment through configurable questionnaires and automated inclusion/exclusion criteria evaluation.

## Database Schema

### Technology Stack
- **Database**: Microsoft SQL Server 2012+
- **ORM**: Entity Framework 6.x / EF Core
- **Business Rules Engine**: Custom rules engine for eligibility criteria
- **Compliance**: GCP ICH E6, HIPAA (PHI protection)

---

## Entity Relationship Diagram (PlantUML)

```plantuml
@startuml CTS ERD
!define Table(name,desc) class name as "desc" << (T,#FFF9C4) >>
!define primary_key(x) <b>x</b>
!define foreign_key(x) <i>x</i>
!define unique(x) <u>x</u>

skinparam class {
  BackgroundColor<<(T,#FFF9C4)>> #FFFDE7
  BorderColor<<(T,#FFF9C4)>> #F57F17
  ArrowColor #696969
}

' Subjects
class Subjects {
  primary_key(SubjectId) : uniqueidentifier
  --
  unique(SubjectNumber) : nvarchar(50)
  foreign_key(TrialId) : uniqueidentifier
  foreign_key(SiteId) : uniqueidentifier
  FirstName : nvarchar(100)
  LastName : nvarchar(100)
  DateOfBirth : date
  Gender : nvarchar(20)
  ContactEmail : nvarchar(256)
  ContactPhone : nvarchar(50)
  Status : nvarchar(50)
  ScreeningDate : datetime
  EnrollmentDate : datetime
  WithdrawalDate : datetime
  WithdrawalReason : nvarchar(MAX)
  IsActive : bit
  foreign_key(CreatedBy) : uniqueidentifier
  CreatedDate : datetime
}

' Subscriptions (Trial Enrollment)
class Subscriptions {
  primary_key(SubscriptionId) : uniqueidentifier
  --
  foreign_key(SubjectId) : uniqueidentifier
  foreign_key(TrialId) : uniqueidentifier
  SubscriptionStatus : nvarchar(50)
  SubscriptionDate : datetime
  CompletionDate : datetime
  IsActive : bit
}

' Screening Questionnaires
class Questionnaires {
  primary_key(QuestionnaireId) : uniqueidentifier
  --
  foreign_key(TrialId) : uniqueidentifier
  QuestionnaireName : nvarchar(200)
  Description : nvarchar(MAX)
  Version : nvarchar(20)
  IsActive : bit
  foreign_key(CreatedBy) : uniqueidentifier
  CreatedDate : datetime
}

class Questions {
  primary_key(QuestionId) : int
  --
  foreign_key(QuestionnaireId) : uniqueidentifier
  QuestionText : nvarchar(MAX)
  QuestionType : nvarchar(50)
  AnswerOptions : nvarchar(MAX)
  IsRequired : bit
  QuestionOrder : int
  Category : nvarchar(100)
}

' Subject Responses
class SubjectResponses {
  primary_key(ResponseId) : bigint
  --
  foreign_key(SubjectId) : uniqueidentifier
  foreign_key(QuestionnaireId) : uniqueidentifier
  foreign_key(QuestionId) : int
  ResponseValue : nvarchar(MAX)
  ResponseDate : datetime
  foreign_key(EnteredBy) : uniqueidentifier
}

' Eligibility Criteria
class EligibilityCriteria {
  primary_key(CriterionId) : int
  --
  foreign_key(TrialId) : uniqueidentifier
  CriterionType : nvarchar(50)
  CriterionText : nvarchar(MAX)
  RuleExpression : nvarchar(MAX)
  CriterionOrder : int
  IsActive : bit
}

class EligibilityEvaluations {
  primary_key(EvaluationId) : uniqueidentifier
  --
  foreign_key(SubjectId) : uniqueidentifier
  foreign_key(CriterionId) : int
  EvaluationResult : bit
  ResultReason : nvarchar(MAX)
  EvaluationDate : datetime
  foreign_key(EvaluatedBy) : uniqueidentifier
}

' Final Eligibility
class SubjectEligibility {
  primary_key(EligibilityId) : uniqueidentifier
  --
  foreign_key(SubjectId) : uniqueidentifier
  IsEligible : bit
  DeterminationDate : datetime
  DeterminationReason : nvarchar(MAX)
  InclusionCriteriaMet : int
  ExclusionCriteriaFailed : int
  foreign_key(DeterminedBy) : uniqueidentifier
}

' Relationships
Subjects "1" -- "0..*" Subscriptions
Subjects "1" -- "0..*" SubjectResponses
Subjects "1" -- "0..*" EligibilityEvaluations
Subjects "1" -- "0..1" SubjectEligibility
Questionnaires "1" -- "0..*" Questions
Questionnaires "1" -- "0..*" SubjectResponses
Questions "1" -- "0..*" SubjectResponses
EligibilityCriteria "1" -- "0..*" EligibilityEvaluations

@enduml
```

---

## Entity Relationship Diagram (ASCII)

```
┌────────────────────────────────────────────────────────────────────────────┐
│                    OoBDev CTS - Data Model                                 │
└────────────────────────────────────────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   SUBJECTS             ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ Subjects                                │
├─────────────────────────────────────────┤
│ PK SubjectId (GUID)                     │
│ UK SubjectNumber                        │
│ FK TrialId (GUID)───────────────────────┼──►Trials
│ FK SiteId (GUID)────────────────────────┼──►Sites
│    FirstName [Encrypted]                │
│    LastName [Encrypted]                 │
│    DateOfBirth [Encrypted]              │
│    Gender                               │
│    ContactEmail [Encrypted]             │
│    ContactPhone [Encrypted]             │
│    Status (Screening/Enrolled/Withdrawn)│
│    ScreeningDate                        │
│    EnrollmentDate                       │
│    WithdrawalDate                       │
│    WithdrawalReason                     │
│    IsActive                             │
│ FK CreatedBy (GUID)                     │
│    CreatedDate                          │
└────────────┬────────────────┬───────────┘
             │                │
             │                │
┌────────────▼───────────┐  ┌─▼────────────────────────────┐
│ Subscriptions          │  │ SubjectEligibility           │
├────────────────────────┤  ├──────────────────────────────┤
│ PK SubscriptionId      │  │ PK EligibilityId (GUID)      │
│ FK SubjectId           │  │ FK SubjectId                 │
│ FK TrialId             │  │    IsEligible (bit)          │
│    SubscriptionStatus  │  │    DeterminationDate         │
│    SubscriptionDate    │  │    DeterminationReason       │
│    CompletionDate      │  │    InclusionCriteriaMet      │
│    IsActive            │  │    ExclusionCriteriaFailed   │
└────────────────────────┘  │ FK DeterminedBy (GUID)       │
                            └──────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   QUESTIONNAIRES       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ Questionnaires                          │
├─────────────────────────────────────────┤
│ PK QuestionnaireId (GUID)               │
│ FK TrialId (GUID)                       │
│    QuestionnaireName                    │
│    Description                          │
│    Version                              │
│    IsActive                             │
│ FK CreatedBy (GUID)                     │
│    CreatedDate                          │
└────────────┬────────────────────────────┘
             │
             │
             ▼
┌─────────────────────────────────────────┐
│ Questions                               │
├─────────────────────────────────────────┤
│ PK QuestionId (int)                     │
│ FK QuestionnaireId (GUID)               │
│    QuestionText                         │
│    QuestionType (Text/Numeric/Choice)   │
│    AnswerOptions (JSON)                 │
│    IsRequired                           │
│    QuestionOrder                        │
│    Category                             │
└────────────┬────────────────────────────┘
             │
             │
             ▼
┌─────────────────────────────────────────┐
│ SubjectResponses                        │
├─────────────────────────────────────────┤
│ PK ResponseId (bigint)                  │
│ FK SubjectId (GUID)─────────────────────┼──►Subjects
│ FK QuestionnaireId (GUID)               │
│ FK QuestionId (int)                     │
│    ResponseValue                        │
│    ResponseDate                         │
│ FK EnteredBy (GUID)                     │
└─────────────────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   ELIGIBILITY          ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ EligibilityCriteria                     │
├─────────────────────────────────────────┤
│ PK CriterionId (int)                    │
│ FK TrialId (GUID)                       │
│    CriterionType (Inclusion/Exclusion)  │
│    CriterionText                        │
│    RuleExpression (business rule)       │
│    CriterionOrder                       │
│    IsActive                             │
└────────────┬────────────────────────────┘
             │
             │
             ▼
┌─────────────────────────────────────────┐
│ EligibilityEvaluations                  │
├─────────────────────────────────────────┤
│ PK EvaluationId (GUID)                  │
│ FK SubjectId (GUID)─────────────────────┼──►Subjects
│ FK CriterionId (int)                    │
│    EvaluationResult (Pass/Fail)         │
│    ResultReason                         │
│    EvaluationDate                       │
│ FK EvaluatedBy (GUID)                   │
└─────────────────────────────────────────┘


Example Eligibility Criteria:

Inclusion Criteria:
  IC-1: Age ≥ 18 years
    Rule: DateDiff(year, DateOfBirth, Today) >= 18

  IC-2: Diagnosed with Type 2 Diabetes
    Rule: Response("Q12") == "Yes"

Exclusion Criteria:
  EC-1: Pregnant or breastfeeding
    Rule: Response("Q25") == "Yes" OR Response("Q26") == "Yes"

  EC-2: HbA1c > 12%
    Rule: ToDecimal(Response("Q30")) > 12.0


Workflow:
  1. Subject Screening → Complete Questionnaire
  2. Questionnaire → Evaluate Eligibility Criteria
  3. All Inclusion MET + No Exclusion FAILED → Eligible
  4. Eligible → Enroll in Trial
  5. Not Eligible → Screen Failure (record reason)
```

---

*CTS ERD Version: 1.0*
*Last Updated: January 2026*
*Compliance: GCP ICH E6, HIPAA (PHI encryption)*
