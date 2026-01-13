# Site Library - Entity Relationship Diagram

## Overview

The Site Library module provides document management with version control, full-text search, publishing workflows, and role-based access control for trial documentation.

## Database Schema

### Technology Stack
- **Database**: Microsoft SQL Server 2012+
- **File Storage**: SQL Server FileStream for large documents
- **Search**: SQL Server Full-Text Search
- **ORM**: Entity Framework 6.x / EF Core

---

## Entity Relationship Diagram (PlantUML)

```plantuml
@startuml Site Library ERD
!define Table(name,desc) class name as "desc" << (T,#FCE4EC) >>
!define primary_key(x) <b>x</b>
!define foreign_key(x) <i>x</i>
!define unique(x) <u>x</u>

skinparam class {
  BackgroundColor<<(T,#FCE4EC)>> #F8BBD0
  BorderColor<<(T,#FCE4EC)>> #880E4F
  ArrowColor #696969
}

' Folders
class Folders {
  primary_key(FolderId) : uniqueidentifier
  --
  foreign_key(TrialId) : uniqueidentifier
  foreign_key(ParentFolderId) : uniqueidentifier
  FolderName : nvarchar(200)
  FolderPath : nvarchar(4000)
  Description : nvarchar(MAX)
  DisplayOrder : int
  IsActive : bit
  foreign_key(CreatedBy) : uniqueidentifier
  CreatedDate : datetime
}

' Documents
class Documents {
  primary_key(DocumentId) : uniqueidentifier
  --
  foreign_key(FolderId) : uniqueidentifier
  foreign_key(TrialId) : uniqueidentifier
  DocumentTitle : nvarchar(500)
  FileName : nvarchar(500)
  FileExtension : nvarchar(10)
  FileSizeBytes : bigint
  MimeType : nvarchar(200)
  Description : nvarchar(MAX)
  Keywords : nvarchar(MAX)
  CurrentVersion : int
  Status : nvarchar(50)
  PublishStatus : nvarchar(50)
  PublishedDate : datetime
  foreign_key(UploadedBy) : uniqueidentifier
  UploadedDate : datetime
  foreign_key(ModifiedBy) : uniqueidentifier
  ModifiedDate : datetime
  IsActive : bit
}

' Document Versions
class DocumentVersions {
  primary_key(VersionId) : uniqueidentifier
  --
  foreign_key(DocumentId) : uniqueidentifier
  VersionNumber : int
  FileName : nvarchar(500)
  FileContent : varbinary(MAX)
  FileStreamPath : nvarchar(500)
  FileSizeBytes : bigint
  VersionNotes : nvarchar(MAX)
  foreign_key(UploadedBy) : uniqueidentifier
  UploadedDate : datetime
  IsCurrentVersion : bit
}

' Publishing Workflow
class PublishingWorkflow {
  primary_key(WorkflowId) : uniqueidentifier
  --
  foreign_key(DocumentId) : uniqueidentifier
  foreign_key(SubmittedBy) : uniqueidentifier
  SubmittedDate : datetime
  foreign_key(ReviewerId) : uniqueidentifier
  ReviewStatus : nvarchar(50)
  ReviewComments : nvarchar(MAX)
  ReviewDate : datetime
  foreign_key(ApprovedBy) : uniqueidentifier
  ApprovalDate : datetime
}

' Permissions
class DocumentPermissions {
  primary_key(PermissionId) : int
  --
  foreign_key(DocumentId) : uniqueidentifier
  foreign_key(FolderId) : uniqueidentifier
  foreign_key(RoleId) : uniqueidentifier
  foreign_key(UserId) : uniqueidentifier
  PermissionType : nvarchar(50)
  CanRead : bit
  CanWrite : bit
  CanDelete : bit
  CanPublish : bit
  foreign_key(GrantedBy) : uniqueidentifier
  GrantedDate : datetime
}

' Full-Text Index
class DocumentSearchIndex {
  primary_key(IndexId) : bigint
  --
  foreign_key(DocumentId) : uniqueidentifier
  foreign_key(VersionId) : uniqueidentifier
  IndexedText : nvarchar(MAX)
  DocumentPath : nvarchar(4000)
  IndexedDate : datetime
}

' Relationships
Folders "0..1" -- "0..*" Folders : parent/child
Folders "1" -- "0..*" Documents : contains
Documents "1" -- "0..*" DocumentVersions : has versions
Documents "1" -- "0..1" PublishingWorkflow : published via
Documents "1" -- "0..*" DocumentPermissions : secured by
Folders "1" -- "0..*" DocumentPermissions : secured by
Documents "1" -- "0..1" DocumentSearchIndex : indexed in

@enduml
```

---

## Entity Relationship Diagram (ASCII)

```
┌────────────────────────────────────────────────────────────────────────────┐
│                 OoBDev Site Library - Data Model                           │
└────────────────────────────────────────────────────────────────────────────┘

┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   FOLDER STRUCTURE     ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ Folders (Hierarchical Tree)            │
├─────────────────────────────────────────┤
│ PK FolderId (GUID)                      │
│ FK TrialId (GUID)───────────────────────┼──►Trials
│ FK ParentFolderId (GUID) [Self-ref]     │
│    FolderName                           │
│    FolderPath (/Root/Parent/Child)      │
│    Description                          │
│    DisplayOrder                         │
│    IsActive                             │
│ FK CreatedBy (GUID)                     │
│    CreatedDate                          │
└────────────┬────────────────────────────┘
             │
             │ contains
             ▼
┌─────────────────────────────────────────┐
│ Documents                               │
├─────────────────────────────────────────┤
│ PK DocumentId (GUID)                    │
│ FK FolderId (GUID)                      │
│ FK TrialId (GUID)                       │
│    DocumentTitle                        │
│    FileName                             │
│    FileExtension                        │
│    FileSizeBytes                        │
│    MimeType                             │
│    Description                          │
│    Keywords (comma-separated)           │
│    CurrentVersion (int)                 │
│    Status (Draft/Active/Archived)       │
│    PublishStatus (Pending/Published)    │
│    PublishedDate                        │
│ FK UploadedBy (GUID)                    │
│    UploadedDate                         │
│ FK ModifiedBy (GUID)                    │
│    ModifiedDate                         │
│    IsActive                             │
└────────────┬────────────────────────────┘
             │
             │ has versions
             ▼
┌─────────────────────────────────────────┐
│ DocumentVersions                        │
├─────────────────────────────────────────┤
│ PK VersionId (GUID)                     │
│ FK DocumentId (GUID)                    │
│    VersionNumber (1, 2, 3...)           │
│    FileName                             │
│    FileContent (varbinary for < 1MB)    │
│    FileStreamPath (for >= 1MB)          │
│    FileSizeBytes                        │
│    VersionNotes                         │
│ FK UploadedBy (GUID)                    │
│    UploadedDate                         │
│    IsCurrentVersion (bit)               │
└─────────────────────────────────────────┘


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   PUBLISHING WORKFLOW  ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ PublishingWorkflow                      │
├─────────────────────────────────────────┤
│ PK WorkflowId (GUID)                    │
│ FK DocumentId (GUID)────────────────────┼──►Documents
│ FK SubmittedBy (GUID)───────────────────┼──►AspNetUsers
│    SubmittedDate                        │
│ FK ReviewerId (GUID)────────────────────┼──►AspNetUsers (Librarian)
│    ReviewStatus (Pending/Approved/Reject)│
│    ReviewComments                       │
│    ReviewDate                           │
│ FK ApprovedBy (GUID)────────────────────┼──►AspNetUsers
│    ApprovalDate                         │
└─────────────────────────────────────────┘

Workflow States:
  1. Writer uploads document → Draft
  2. Writer submits for review → Pending
  3. Librarian reviews → Approved/Rejected
  4. If Approved → Published (visible to all)
  5. If Rejected → Back to Draft (with comments)


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   ACCESS CONTROL       ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ DocumentPermissions                     │
├─────────────────────────────────────────┤
│ PK PermissionId (int)                   │
│ FK DocumentId (GUID)                    │
│ FK FolderId (GUID)                      │
│ FK RoleId (GUID)────────────────────────┼──►AspNetRoles
│ FK UserId (GUID)────────────────────────┼──►AspNetUsers
│    PermissionType (Role/User)           │
│    CanRead (bit)                        │
│    CanWrite (bit)                       │
│    CanDelete (bit)                      │
│    CanPublish (bit)                     │
│ FK GrantedBy (GUID)                     │
│    GrantedDate                          │
└─────────────────────────────────────────┘

Permission Types:
  • Role-based (e.g., all "Investigators" can read)
  • User-specific (e.g., John Smith can write)
  • Inherited from folder

Permission Hierarchy:
  Folder permissions cascade to child folders and documents


┏━━━━━━━━━━━━━━━━━━━━━━━━┓
┃   FULL-TEXT SEARCH     ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━┛

┌─────────────────────────────────────────┐
│ DocumentSearchIndex                     │
├─────────────────────────────────────────┤
│ PK IndexId (bigint)                     │
│ FK DocumentId (GUID)                    │
│ FK VersionId (GUID)                     │
│    IndexedText (extracted from file)    │
│    DocumentPath                         │
│    IndexedDate                          │
└─────────────────────────────────────────┘

Full-Text Search Engine:
  • Indexes: Title, Description, Keywords, File Content
  • File Types: PDF, Word, Excel, PowerPoint, HTML, Text
  • Features: Stemming, thesaurus, ranking by relevance


Example Folder Structure:
  /Trial Protocol
  /Trial Protocol/Amendments
  /Trial Protocol/Amendments/Amendment 1
  /ICF (Informed Consent Forms)
  /ICF/Version 1.0
  /ICF/Version 2.0
  /Site Documents
  /Site Documents/Training Materials
  /Site Documents/Regulatory
```

---

*Site Library ERD Version: 1.0*
*Last Updated: January 2026*
*Features: Version Control, Full-Text Search, Publishing Workflow, RBAC*
