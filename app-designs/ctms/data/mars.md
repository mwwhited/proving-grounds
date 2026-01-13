# MARS (Medication Adherence Reminder System) - Entity Relationship Diagram

## Overview

The MARS module manages medication adherence tracking through scheduled reminders, subject responses, and compliance analytics for clinical trials.

## Database Schema

### Technology Stack
- **Database**: Microsoft SQL Server 2012+
- **ORM**: Entity Framework 6.x / EF Core
- **Messaging Integration**: Integrates with Messaging module for reminders
- **Analytics**: SQL Server Reporting Services (SSRS)

---

## Entity Relationship Diagram (PlantUML)

```plantuml
@startuml MARS ERD
!define Table(name,desc) class name as "desc" << (T,#C8E6C9) >>
!define primary_key(x) <b>x</b>
!define foreign_key(x) <i>x</i>
!define unique(x) <u>x</u>

skinparam class {
  BackgroundColor<<(T,#C8E6C9)>> #E8F5E9
  BorderColor<<(T,#C8E6C9)>> #2E7D32
  ArrowColor #696969
}

' Medication Schedules
class MedicationSchedules {
  primary_key(ScheduleId) : uniqueidentifier
  --
  foreign_key(SubjectId) : uniqueidentifier
  foreign_key(TrialId) : uniqueidentifier
  MedicationName : nvarchar(200)
  Dosage : nvarchar(100)
  Frequency : nvarchar(100)
  StartDate : date
  EndDate : date
  ReminderTimes : nvarchar(MAX)
  IsActive : bit
  foreign_key(CreatedBy) : uniqueidentifier
  CreatedDate : datetime
}

' Reminder Logs
class ReminderLogs {
  primary_key(ReminderId) : bigint
  --
  foreign_key(ScheduleId) : uniqueidentifier
  foreign_key(SubjectId) : uniqueidentifier
  foreign_key(MessageId) : uniqueidentifier
  ReminderDate : datetime
  ReminderTime : time
  Channel : nvarchar(20)
  Status : nvarchar(50)
  SentDate : datetime
  DeliveryDate : datetime
  ResponseDate : datetime
  ResponseType : nvarchar(50)
}

' Subject Responses
class AdherenceResponses {
  primary_key(ResponseId) : bigint
  --
  foreign_key(ReminderId) : bigint
  foreign_key(SubjectId) : uniqueidentifier
  ResponseDate : datetime
  ResponseValue : nvarchar(50)
  ResponseMethod : nvarchar(50)
  Timestamp : datetime
}

' Adherence Metrics
class AdherenceMetrics {
  primary_key(MetricId) : bigint
  --
  foreign_key(SubjectId) : uniqueidentifier
  foreign_key(ScheduleId) : uniqueidentifier
  CalculationDate : date
  TotalReminders : int
  ResponsesReceived : int
  PositiveResponses : int
  AdherenceRate : decimal
  PeriodStart : date
  PeriodEnd : date
}

' Dashboard Aggregates
class DashboardStats {
  primary_key(StatId) : int
  --
  foreign_key(TrialId) : uniqueidentifier
  StatDate : date
  TotalSubjects : int
  ActiveSubjects : int
  AverageAdherence : decimal
  HighAdherence : int
  MediumAdherence : int
  LowAdherence : int
}

' Relationships
MedicationSchedules "1" -- "0..*" ReminderLogs
ReminderLogs "1" -- "0..1" AdherenceResponses
MedicationSchedules "1" -- "0..*" AdherenceMetrics

@enduml
```

---

## Entity Relationship Diagram (ASCII)

```
┌────────────────────────────────────────────────────────────────────────────┐
│                    OoBDev MARS - Data Model                                │
└────────────────────────────────────────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   MEDICATION SCHEDULES ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ MedicationSchedules                     │
├─────────────────────────────────────────┤
│ PK ScheduleId (GUID)                    │
│ FK SubjectId (GUID)─────────────────────┼──►Subjects (CTS)
│ FK TrialId (GUID)───────────────────────┼──►Trials
│    MedicationName                       │
│    Dosage                               │
│    Frequency (Daily/BID/TID/QID/Weekly) │
│    StartDate                            │
│    EndDate                              │
│    ReminderTimes (JSON) ["09:00","21:00"]
│    IsActive                             │
│ FK CreatedBy (GUID)                     │
│    CreatedDate                          │
└────────────┬────────────────────────────┘
             │
             │
             ▼
┌─────────────────────────────────────────┐
│ ReminderLogs                            │
├─────────────────────────────────────────┤
│ PK ReminderId (bigint)                  │
│ FK ScheduleId (GUID)                    │
│ FK SubjectId (GUID)                     │
│ FK MessageId (GUID)─────────────────────┼──►Messages (Messaging)
│    ReminderDate                         │
│    ReminderTime                         │
│    Channel (SMS/Email/App)              │
│    Status (Pending/Sent/Delivered)      │
│    SentDate                             │
│    DeliveryDate                         │
│    ResponseDate                         │
│    ResponseType (Taken/Missed/Skipped)  │
└────────────┬────────────────────────────┘
             │
             │
             ▼
┌─────────────────────────────────────────┐
│ AdherenceResponses                      │
├─────────────────────────────────────────┤
│ PK ResponseId (bigint)                  │
│ FK ReminderId (bigint)                  │
│ FK SubjectId (GUID)                     │
│    ResponseDate                         │
│    ResponseValue ("Taken"/"Missed")     │
│    ResponseMethod (SMS/Web/App)         │
│    Timestamp                            │
└─────────────────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   ADHERENCE ANALYTICS  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ AdherenceMetrics (Calculated Daily)    │
├─────────────────────────────────────────┤
│ PK MetricId (bigint)                    │
│ FK SubjectId (GUID)                     │
│ FK ScheduleId (GUID)                    │
│    CalculationDate                      │
│    TotalReminders                       │
│    ResponsesReceived                    │
│    PositiveResponses ("Taken" count)    │
│    AdherenceRate (decimal 0.00-1.00)    │
│    PeriodStart                          │
│    PeriodEnd                            │
└─────────────────────────────────────────┘

Adherence Rate Calculation:
  AdherenceRate = PositiveResponses / TotalReminders

  Example: 27 "Taken" / 30 Reminders = 0.90 (90% adherent)


┌─────────────────────────────────────────┐
│ DashboardStats (Trial-Level Aggregates)│
├─────────────────────────────────────────┤
│ PK StatId (int)                         │
│ FK TrialId (GUID)                       │
│    StatDate                             │
│    TotalSubjects                        │
│    ActiveSubjects                       │
│    AverageAdherence (mean rate)         │
│    HighAdherence (≥80%)                 │
│    MediumAdherence (50-79%)             │
│    LowAdherence (<50%)                  │
└─────────────────────────────────────────┘


Adherence Categories:
  • High: ≥ 80% adherence rate
  • Medium: 50-79% adherence rate
  • Low: < 50% adherence rate


Example Reminder Flow:
  1. Schedule: "Metformin 500mg, BID" (09:00, 21:00)
  2. System generates daily reminders at 09:00 and 21:00
  3. Reminder sent via SMS: "Have you taken your Metformin? Reply YES or NO"
  4. Subject replies: "YES"
  5. Response logged as "Taken"
  6. Metrics updated: 1 positive response added to daily total
```

---

*MARS ERD Version: 1.0*
*Last Updated: January 2026*
*Integration: Messaging module for reminder delivery*
