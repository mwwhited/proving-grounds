# Feature Specification: Upload SAE Case Documents

**Feature Area**: SAE Management
**User Role**: Manager (RA2)
**Priority**: High
**Status**: Active
**Regulatory**: 21 CFR Part 11 Compliant

---

## Overview

The Upload Documents feature enables managers to attach supporting documentation to SAE case items, such as lab results, medical records, imaging reports, and correspondence. This feature ensures complete case documentation for regulatory compliance and medical review.

### Business Context

Document management is critical for:
- Complete case documentation per GCP requirements
- Medical reviewer access to source documents
- Regulatory inspection readiness
- Sponsor reporting requirements
- Audit trail for document handling
- Version control and document lifecycle management

---

## User Stories

**As a** Manager (RA2)
**I want to** upload supporting documents to SAE cases
**So that** medical reviewers have all necessary information for assessment

**As a** Medical Reviewer
**I want to** access all supporting documents
**So that** I can accurately assess event causality and severity

**As a** Regulatory Affairs Officer
**I want to** ensure all documents are properly versioned and tracked
**So that** we can demonstrate compliance during inspections

---

## Functional Requirements

### FR-1: Document Upload Interface

**URL**: `/SAE/Case/{caseId}/Documents`

**Authorization**: Manager (RA2) only

**Upload Methods**:
1. **Drag and Drop**: Drag files onto upload area
2. **File Selector**: Click to browse and select files
3. **Multiple Selection**: Select multiple files at once
4. **Folder Upload**: Upload entire folders (browser permitting)

**Supported File Types**:
- PDF (`.pdf`) - Preferred format
- Microsoft Word (`.doc`, `.docx`)
- Images: JPEG (`.jpg`, `.jpeg`), PNG (`.png`), TIFF (`.tif`, `.tiff`)

**File Size Limits**:
- Maximum per file: 10MB
- Maximum total upload: 50MB per batch
- Maximum files per case: 100 files

### FR-2: Document Metadata

**Required Metadata** (collected during upload):

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| Document Type | Dropdown | Yes | Category of document |
| Description | Text | Yes | Brief description (max 500 chars) |
| Document Date | Date | Yes | Date of document creation |
| Uploaded File | File | Yes | The actual file |

**Document Types**:
- Lab Results
- Medical Records
- Imaging Reports (X-ray, CT, MRI, etc.)
- Progress Notes
- Discharge Summary
- Consent Form
- Correspondence
- Protocol Document
- Other (with required description)

**Auto-Generated Metadata**:
- Upload date/time (UTC)
- Uploaded by (user ID and name)
- IP address
- File size
- File name (original)
- File hash (SHA-256 for integrity)
- Version number
- Document ID (unique identifier)

### FR-3: Upload Process

**Workflow**:
1. Manager navigates to case documents tab
2. Manager clicks "Upload Documents" button
3. System displays upload dialog
4. Manager selects file(s) via drag-drop or file selector
5. System validates file type and size
6. Manager enters metadata for each file
7. Manager clicks "Upload" button
8. System uploads files to server
9. System validates file integrity
10. System stores files in secure storage
11. System associates files with case
12. System creates audit log entries
13. System displays success confirmation
14. System updates document list view

**Validation**:
- File type allowed
- File size within limits
- Total upload size within limits
- Required metadata provided
- Document date not in future
- File not corrupted

**Progress Indication**:
- Upload progress bar per file
- Overall progress for multiple files
- Estimated time remaining
- Success/error status per file

### FR-4: Document Storage

**Storage Architecture**:
- Files stored in SQL Server FILESTREAM
- Binary data stored outside main tables
- Metadata in database tables
- Full-text indexing enabled for searchable content

**File Organization**:
```
/SAEDocuments
  /{TrialID}
    /{CaseID}
      /{DocumentID}_{Version}_{OriginalFilename}
```

**Security**:
- Files encrypted at rest
- Access controlled via database permissions
- No direct file system access
- All access via application API

### FR-5: Document Viewing

**View Options**:
- **Inline Preview**: PDF and images displayed in browser
- **Download**: Download original file
- **Print**: Print preview (PDF only)

**Viewer Features**:
- Zoom in/out
- Page navigation (for multi-page PDFs)
- Rotate (for images)
- Annotation (optional future enhancement)

**Access Control**:
- Managers: View, download, upload, delete
- Coordinators: View and download only
- Medical Reviewers: View and download only
- Auditors: View and download only (read-only access)

### FR-6: Document List View

**Display Information**:
- Document type icon
- Document description
- Document date
- Upload date
- Uploaded by
- File size
- File type
- Version number
- Actions (View, Download, Delete)

**Sorting**:
- By upload date (default, newest first)
- By document date
- By document type
- By file name

**Filtering**:
- By document type
- By date range
- By uploader

### FR-7: Document Version Control

**Versioning Behavior**:
- Uploading same document type creates new version
- Previous versions retained
- Version history tracked
- Only latest version shown by default
- "View Version History" link shows all versions

**Version Naming**:
- Format: `DocumentType_v{N}_{Date}`
- Example: `LabResults_v2_20260113.pdf`

**Version Operations**:
- View any version
- Download any version
- Compare versions (optional)
- Revert to previous version (creates new version)

### FR-8: Document Deletion

**Soft Delete**:
- Documents never physically deleted
- Marked as deleted in database
- Deleted by user and timestamp recorded
- Deletion reason captured
- Still visible in audit trail
- Can be restored by administrator

**Delete Permissions**:
- Manager can delete own uploads (within 24 hours)
- Administrator can delete any document
- Deletion requires confirmation
- Deletion creates audit log entry

### FR-9: Document Search

**Search Capabilities**:
- Full-text search within PDF content
- Search by document description
- Search by document type
- Search by date range
- Search by uploader

**Search Results**:
- Highlighted search terms
- Document preview with context
- Relevance ranking
- Filter results by type/date

### FR-10: Audit Trail

**Logged Events**:

| Event | Action | Details |
|-------|--------|---------|
| Document uploaded | SAE_Document_Upload | Document_Uploaded |
| Document viewed | SAE_Document_Access | Document_Viewed |
| Document downloaded | SAE_Document_Access | Document_Downloaded |
| Document deleted | SAE_Document_Delete | Document_Deleted |
| Document restored | SAE_Document_Restore | Document_Restored |
| Version created | SAE_Document_Version | New_Version_Created |

**Audit Information Captured**:
- User ID and name
- IP address
- Timestamp (UTC)
- Case ID and case number
- Document ID and description
- Action performed
- File hash (for integrity verification)

### FR-11: Compliance Requirements

**21 CFR Part 11**:
- Electronic signatures for critical documents
- Complete audit trail
- Document integrity verification (file hash)
- Access controls enforced
- Document lifecycle tracked

**GCP Requirements**:
- Source document verification
- Version control
- Audit trail
- Secure storage
- Retrieval on demand

**Document Retention**:
- Documents retained for duration of trial + 2 years (configurable)
- Retention period enforced by policy
- Automated retention alerts

---

## Non-Functional Requirements

### NFR-1: Performance
- Upload speed: Dependent on network (1MB/second minimum)
- File validation: <1 second per file
- Document list load: <2 seconds
- Document preview: <3 seconds
- Search results: <2 seconds

### NFR-2: Security
- HTTPS required for all uploads
- Virus scanning on upload
- File type validation (not just extension)
- Content type validation
- File integrity verification (hash)

### NFR-3: Reliability
- Upload retry on network failure
- Resume capability for large files
- Transaction support (all-or-nothing)
- Backup and recovery procedures

### NFR-4: Scalability
- Support 100+ documents per case
- Support 10,000+ cases
- Efficient storage (FILESTREAM)
- Indexed searches

---

## User Interface

### Upload Dialog

```
┌─────────────────────────────────────────────────────────┐
│ Upload Documents to Case 001-2026-0001                  │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌───────────────────────────────────────────────┐     │
│  │                                               │     │
│  │    Drag files here or click to browse         │     │
│  │                                               │     │
│  │    📁  [Select Files]                          │     │
│  │                                               │     │
│  │    Supported: PDF, DOCX, JPG, PNG, TIFF       │     │
│  │    Max size: 10MB per file                    │     │
│  │                                               │     │
│  └───────────────────────────────────────────────┘     │
│                                                         │
│  Files to Upload:                                       │
│  ┌───────────────────────────────────────────────┐     │
│  │ 📄 LabResults_20260110.pdf (2.3 MB)            │     │
│  │    Type: [▼ Lab Results ▼▼▼▼▼]                │     │
│  │    Description: [CBC with diff, elevated WBC]  │     │
│  │    Document Date: [📅 01/10/2026]              │     │
│  │    [✓] Ready to upload                         │     │
│  ├───────────────────────────────────────────────┤     │
│  │ 🖼️ ChestXray.jpg (1.8 MB)                      │     │
│  │    Type: [▼ Imaging Reports ▼▼▼]              │     │
│  │    Description: [Chest X-ray showing...]       │     │
│  │    Document Date: [📅 01/11/2026]              │     │
│  │    [✓] Ready to upload                         │     │
│  └───────────────────────────────────────────────┘     │
│                                                         │
│  Total: 2 files, 4.1 MB                                 │
│                                                         │
│                           [Cancel]  [Upload Documents]  │
└─────────────────────────────────────────────────────────┘
```

### Document List

```
┌─────────────────────────────────────────────────────────┐
│ Case Documents - 001-2026-0001                    [Upload]│
├─────────────────────────────────────────────────────────┤
│                                                         │
│ Filter: [All Types ▼] [Last 30 days ▼] [Search____]    │
│                                                         │
│ ┌───────────────────────────────────────────────┐     │
│ │ 📄 Lab Results - CBC with differential         │     │
│ │    Document Date: 01/10/2026                   │     │
│ │    Uploaded: 01/13/2026 14:30 by Jane Smith    │     │
│ │    Size: 2.3 MB (PDF) • Version 1              │     │
│ │    [View] [Download] [Delete]                  │     │
│ ├───────────────────────────────────────────────┤     │
│ │ 🖼️ Imaging - Chest X-ray                       │     │
│ │    Document Date: 01/11/2026                   │     │
│ │    Uploaded: 01/13/2026 14:32 by Jane Smith    │     │
│ │    Size: 1.8 MB (JPEG) • Version 1             │     │
│ │    [View] [Download] [Delete]                  │     │
│ ├───────────────────────────────────────────────┤     │
│ │ 📄 Medical Records - Discharge Summary         │     │
│ │    Document Date: 01/12/2026                   │     │
│ │    Uploaded: 01/13/2026 15:00 by John Doe      │     │
│ │    Size: 456 KB (PDF) • Version 2              │     │
│ │    [View] [Download] [Delete] [View History]   │     │
│ └───────────────────────────────────────────────┘     │
│                                                         │
│ Showing 3 of 3 documents                                │
└─────────────────────────────────────────────────────────┘
```

---

## Data Model

### SAEDocument Table

```sql
CREATE TABLE SAEDocument (
    DocumentID          INT IDENTITY(1,1) PRIMARY KEY,
    CaseID              INT NOT NULL,
    DocumentType        NVARCHAR(100) NOT NULL,
    Description         NVARCHAR(500) NOT NULL,
    DocumentDate        DATE NOT NULL,

    -- File Info
    OriginalFileName    NVARCHAR(255) NOT NULL,
    StoredFileName      NVARCHAR(255) NOT NULL,
    FileSize            BIGINT NOT NULL,
    FileType            NVARCHAR(50) NOT NULL,
    FileHash            NVARCHAR(64) NOT NULL, -- SHA-256

    -- Version Control
    VersionNumber       INT NOT NULL DEFAULT 1,
    ParentDocumentID    INT NULL, -- Reference to previous version
    IsCurrentVersion    BIT NOT NULL DEFAULT 1,

    -- Binary Storage (FILESTREAM)
    FileContent         VARBINARY(MAX) FILESTREAM NOT NULL,
    FileStreamGUID      UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE DEFAULT NEWID(),

    -- Soft Delete
    IsDeleted           BIT NOT NULL DEFAULT 0,
    DeletedBy           UNIQUEIDENTIFIER NULL,
    DeletedDate         DATETIME2 NULL,
    DeletionReason      NVARCHAR(500) NULL,

    -- Audit
    UploadedBy          UNIQUEIDENTIFIER NOT NULL,
    UploadedDate        DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    UploadedByIP        NVARCHAR(50) NOT NULL,

    CONSTRAINT FK_SAEDocument_Case FOREIGN KEY (CaseID) REFERENCES SAECase(CaseID),
    CONSTRAINT FK_SAEDocument_Parent FOREIGN KEY (ParentDocumentID) REFERENCES SAEDocument(DocumentID),
    CONSTRAINT FK_SAEDocument_Uploader FOREIGN KEY (UploadedBy) REFERENCES AspNetUsers(UserId),
    CONSTRAINT CK_SAEDocument_FileSize CHECK (FileSize > 0 AND FileSize <= 10485760) -- 10MB
)

CREATE INDEX IX_SAEDocument_CaseID ON SAEDocument(CaseID)
CREATE INDEX IX_SAEDocument_Type ON SAEDocument(DocumentType)
CREATE INDEX IX_SAEDocument_Date ON SAEDocument(DocumentDate DESC)
CREATE FULLTEXT INDEX ON SAEDocument(Description) KEY INDEX PK_SAEDocument
```

---

## API Endpoints

### POST /SAE/Case/{caseId}/Documents/Upload
**Description**: Upload document(s)
**Authorization**: Manager (RA2)
**Content-Type**: multipart/form-data

**Request**: Form data with files and metadata

**Response** (200 OK):
```json
{
  "Success": true,
  "UploadedDocuments": [
    {
      "DocumentId": 123,
      "FileName": "LabResults.pdf",
      "FileSize": 2400000
    }
  ]
}
```

### GET /SAE/Case/{caseId}/Documents
**Description**: List documents for case
**Authorization**: Coordinator (RA1), Manager (RA2), Medical Reviewer

**Response**: Document list view

### GET /SAE/Documents/{documentId}/View
**Description**: View document inline
**Authorization**: Authorized users

### GET /SAE/Documents/{documentId}/Download
**Description**: Download document
**Authorization**: Authorized users

### DELETE /SAE/Documents/{documentId}
**Description**: Soft delete document
**Authorization**: Manager (RA2), Administrator

---

## Business Rules

### BR-1: Upload Permissions
- Only Managers (RA2) can upload documents
- Coordinators (RA1) can view but not upload

### BR-2: File Type Restrictions
- Only approved file types accepted
- File type validated by content, not extension
- Virus scanning performed on upload

### BR-3: File Size Limits
- Maximum 10MB per file
- Maximum 50MB per batch upload
- Maximum 100 files per case

### BR-4: Version Control
- Same document type creates new version
- All versions retained
- Latest version is default view

### BR-5: Deletion
- Soft delete only (never physical delete)
- Deletion reason required
- Audit trail maintained

---

## Acceptance Criteria

### AC-1: Upload
- ✅ Manager can upload documents
- ✅ Multiple files supported
- ✅ Drag-and-drop works
- ✅ File validation enforced
- ✅ Progress indication shown

### AC-2: Viewing
- ✅ Documents listed correctly
- ✅ PDF preview works
- ✅ Image preview works
- ✅ Download works

### AC-3: Version Control
- ✅ Versions tracked
- ✅ Version history accessible
- ✅ Latest version is default

### AC-4: Security
- ✅ Access control enforced
- ✅ File integrity verified
- ✅ Audit trail complete

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
