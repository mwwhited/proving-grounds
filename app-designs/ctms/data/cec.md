# CEC (Clinical Event Committee) - Entity Relationship Diagram

## Overview

The CEC module manages clinical event adjudication through committee meetings, independent medical review, and voting workflows. This ensures objective, independent evaluation of clinical endpoints in trials.

## Database Schema

### Technology Stack
- **Database**: Microsoft SQL Server 2012+
- **ORM**: Entity Framework 6.x / EF Core
- **File Storage**: SQL Server FileStream for case documents
- **Compliance**: GCP ICH E6, 21 CFR Part 11

---

## Entity Relationship Diagram (PlantUML)

```plantuml
@startuml CEC ERD
!define Table(name,desc) class name as "desc" << (T,#E8EAF6) >>
!define primary_key(x) <b>x</b>
!define foreign_key(x) <i>x</i>
!define unique(x) <u>u</u>

skinparam class {
  BackgroundColor<<(T,#E8EAF6)>> #F3E5F5
  BorderColor<<(T,#E8EAF6)>> #4A148C
  ArrowColor #696969
}

' Event Cases
class CECCases {
  primary_key(CaseId) : uniqueidentifier
  --
  unique(CaseNumber) : nvarchar(50)
  foreign_key(TrialId) : uniqueidentifier
  foreign_key(SubjectId) : uniqueidentifier
  foreign_key(SiteId) : uniqueidentifier
  CaseTitle : nvarchar(500)
  EventType : nvarchar(100)
  EventDate : datetime
  CaseStatus : nvarchar(50)
  AdjudicationStatus : nvarchar(50)
  Priority : nvarchar(20)
  foreign_key(CreatedBy) : uniqueidentifier
  CreatedDate : datetime
  ModifiedDate : datetime
}

' Medical Reviews
class MedicalReviews {
  primary_key(ReviewId) : uniqueidentifier
  --
  foreign_key(CaseId) : uniqueidentifier
  foreign_key(ReviewerId) : uniqueidentifier
  ReviewType : nvarchar(100)
  ClinicalOpinion : nvarchar(MAX)
  RecommendedEndpoint : nvarchar(200)
  Rationale : nvarchar(MAX)
  ReviewDate : datetime
  Status : nvarchar(50)
}

' Committee Meetings
class Meetings {
  primary_key(MeetingId) : uniqueidentifier
  --
  foreign_key(TrialId) : uniqueidentifier
  unique(MeetingNumber) : nvarchar(50)
  MeetingDate : datetime
  MeetingType : nvarchar(100)
  Status : nvarchar(50)
  AgendaDocument : varbinary(MAX)
  MinutesDocument : varbinary(MAX)
  foreign_key(ChairpersonId) : uniqueidentifier
  foreign_key(CreatedBy) : uniqueidentifier
  CreatedDate : datetime
}

class MeetingAttendees {
  primary_key(AttendeeId) : int
  --
  foreign_key(MeetingId) : uniqueidentifier
  foreign_key(MemberId) : uniqueidentifier
  AttendanceStatus : nvarchar(50)
  Role : nvarchar(100)
}

class MeetingAgenda {
  primary_key(AgendaItemId) : int
  --
  foreign_key(MeetingId) : uniqueidentifier
  foreign_key(CaseId) : uniqueidentifier
  ItemOrder : int
  PresenterId : uniqueidentifier
  DiscussionNotes : nvarchar(MAX)
}

' Adjudication & Voting
class Adjudications {
  primary_key(AdjudicationId) : uniqueidentifier
  --
  foreign_key(CaseId) : uniqueidentifier
  foreign_key(MeetingId) : uniqueidentifier
  AdjudicationDate : datetime
  FinalEndpoint : nvarchar(200)
  Consensus : bit
  ConsensusMethod : nvarchar(100)
  Rationale : nvarchar(MAX)
  IsApproved : bit
  foreign_key(ApprovedBy) : uniqueidentifier
  ApprovalDate : datetime
}

class AdjudicationVotes {
  primary_key(VoteId) : int
  --
  foreign_key(AdjudicationId) : uniqueidentifier
  foreign_key(MemberId) : uniqueidentifier
  VotedEndpoint : nvarchar(200)
  VoteDate : datetime
  Comments : nvarchar(MAX)
  IsBlinded : bit
}

' Committee Members
class CommitteeMembers {
  primary_key(MemberId) : uniqueidentifier
  --
  foreign_key(UserId) : uniqueidentifier
  foreign_key(TrialId) : uniqueidentifier
  MemberRole : nvarchar(100)
  Specialty : nvarchar(200)
  IsActive : bit
  AppointmentDate : datetime
  TermEndDate : datetime
}

' Case Documents
class CaseDocuments {
  primary_key(DocumentId) : uniqueidentifier
  --
  foreign_key(CaseId) : uniqueidentifier
  DocumentType : nvarchar(100)
  FileName : nvarchar(500)
  FileContent : varbinary(MAX)
  FileStreamPath : nvarchar(500)
  foreign_key(UploadedBy) : uniqueidentifier
  UploadedDate : datetime
}

' Relationships
CECCases "1" -- "0..*" MedicalReviews
CECCases "1" -- "0..*" Adjudications
CECCases "1" -- "0..*" MeetingAgenda
CECCases "1" -- "0..*" CaseDocuments
Meetings "1" -- "0..*" MeetingAttendees
Meetings "1" -- "0..*" MeetingAgenda
Meetings "1" -- "0..*" Adjudications
Adjudications "1" -- "0..*" AdjudicationVotes
CommitteeMembers "1" -- "0..*" MeetingAttendees
CommitteeMembers "1" -- "0..*" AdjudicationVotes
CommitteeMembers "1" -- "0..*" MedicalReviews

@enduml
```

---

## Entity Relationship Diagram (ASCII)

```
┌────────────────────────────────────────────────────────────────────────────┐
│                    OoBDev CEC - Data Model                                 │
└────────────────────────────────────────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   EVENT CASES          ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ CECCases                                │
├─────────────────────────────────────────┤
│ PK CaseId (GUID)                        │
│ UK CaseNumber                           │
│ FK TrialId (GUID)───────────────────────┼──►Trials
│ FK SubjectId (GUID)─────────────────────┼──►Subjects
│ FK SiteId (GUID)────────────────────────┼──►Sites
│    CaseTitle                            │
│    EventType                            │
│    EventDate                            │
│    CaseStatus                           │
│    AdjudicationStatus                   │
│    Priority                             │
│ FK CreatedBy (GUID)─────────────────────┼──►AspNetUsers
│    CreatedDate                          │
└────────────┬────────────────┬───────────┘
             │                │
             │                │
┌────────────▼───────────┐  ┌─▼────────────────────────────┐
│ MedicalReviews         │  │ CaseDocuments                │
├────────────────────────┤  ├──────────────────────────────┤
│ PK ReviewId (GUID)     │  │ PK DocumentId (GUID)         │
│ FK CaseId              │  │ FK CaseId                    │
│ FK ReviewerId──────────┼──┼─►CommitteeMembers            │
│    ReviewType          │  │    DocumentType              │
│    ClinicalOpinion     │  │    FileName                  │
│    RecommendedEndpoint │  │    FileContent (varbinary)   │
│    Rationale           │  │    FileStreamPath            │
│    ReviewDate          │  │ FK UploadedBy (GUID)         │
│    Status              │  │    UploadedDate              │
└────────────────────────┘  └──────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   COMMITTEE MEETINGS   ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ Meetings                                │
├─────────────────────────────────────────┤
│ PK MeetingId (GUID)                     │
│ FK TrialId (GUID)                       │
│ UK MeetingNumber                        │
│    MeetingDate                          │
│    MeetingType                          │
│    Status                               │
│    AgendaDocument (varbinary)           │
│    MinutesDocument (varbinary)          │
│ FK ChairpersonId (GUID)─────────────────┼──►CommitteeMembers
│ FK CreatedBy (GUID)                     │
│    CreatedDate                          │
└────────────┬────────────────┬───────────┘
             │                │
             │                │
┌────────────▼───────────┐  ┌─▼────────────────────────────┐
│ MeetingAttendees       │  │ MeetingAgenda                │
├────────────────────────┤  ├──────────────────────────────┤
│ PK AttendeeId (int)    │  │ PK AgendaItemId (int)        │
│ FK MeetingId           │  │ FK MeetingId                 │
│ FK MemberId────────────┼──┼─►CommitteeMembers            │
│    AttendanceStatus    │  │ FK CaseId (GUID)─────────────┼──►CECCases
│    Role                │  │    ItemOrder                 │
└────────────────────────┘  │ FK PresenterId (GUID)        │
                            │    DiscussionNotes           │
                            └──────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   ADJUDICATION         ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ Adjudications                           │
├─────────────────────────────────────────┤
│ PK AdjudicationId (GUID)                │
│ FK CaseId (GUID)────────────────────────┼──►CECCases
│ FK MeetingId (GUID)─────────────────────┼──►Meetings
│    AdjudicationDate                     │
│    FinalEndpoint                        │
│    Consensus (bit)                      │
│    ConsensusMethod                      │
│    Rationale                            │
│    IsApproved                           │
│ FK ApprovedBy (GUID)────────────────────┼──►CommitteeMembers
│    ApprovalDate                         │
└────────────┬────────────────────────────┘
             │
             │
             ▼
┌─────────────────────────────────────────┐
│ AdjudicationVotes                       │
├─────────────────────────────────────────┤
│ PK VoteId (int)                         │
│ FK AdjudicationId (GUID)                │
│ FK MemberId (GUID)──────────────────────┼──►CommitteeMembers
│    VotedEndpoint                        │
│    VoteDate                             │
│    Comments                             │
│    IsBlinded                            │
└─────────────────────────────────────────┘

Consensus Methods:
  • Unanimous (all members agree)
  • Majority (>50% agreement)
  • Super-majority (≥66% agreement)
  • Weighted (chairperson breaks tie)


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   COMMITTEE MEMBERS    ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ CommitteeMembers                        │
├─────────────────────────────────────────┤
│ PK MemberId (GUID)                      │
│ FK UserId (GUID)────────────────────────┼──►AspNetUsers
│ FK TrialId (GUID)───────────────────────┼──►Trials
│    MemberRole                           │
│    Specialty                            │
│    IsActive                             │
│    AppointmentDate                      │
│    TermEndDate                          │
└─────────────────────────────────────────┘

Member Roles:
  • Chairperson
  • Voting Member
  • Non-Voting Consultant
  • Medical Expert
  • Statistician


Workflow:
  1. Case Created → Medical Review
  2. Medical Review → Schedule Meeting
  3. Meeting → Present Case → Vote
  4. Votes Tallied → Determine Consensus
  5. Consensus → Final Determination
  6. Final Determination → Approved → Closed
```

---

*CEC ERD Version: 1.0*
*Last Updated: January 2026*
*Compliance: GCP ICH E6, 21 CFR Part 11*
