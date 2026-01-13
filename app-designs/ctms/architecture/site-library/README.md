# OoBDev Site Library Architecture

The Site Library provides document management and knowledge sharing capabilities for clinical trial sites.

## Architecture Diagrams

- [Use Cases](./use-cases.md) - Document management and publishing use cases
- [Layering](./layering.md) - Application layered architecture

## Overview

The Site Library module provides comprehensive document management for clinical trial sites:

- **Document Repository** - Centralized storage for trial documents, protocols, and resources
- **Version Control** - Track document versions and changes over time
- **Role-Based Access** - User, Writer, and Librarian roles with appropriate permissions
- **Search Capabilities** - Full-text search across titles, descriptions, and content
- **Publishing Workflow** - Review and approval process for document activation
- **RSS/Atom Feeds** - Syndication for queries and resource lists
- **Tree Navigation** - Hierarchical folder structure for document organization

## Key Components

### Actor Roles

- **User** - Basic read access to view and search documents
- **Writer** - Content contributor who can update documents and descriptions
- **Librarian** - Administrative role that extends Writer with permission management
- **System** - Automated processes for validation and search indexing

### Core Workflows

#### Document Publishing Workflow
1. Writer creates or updates document
2. Content type validation (System)
3. Virus scanning (System)
4. Resource is deactivated (requires Librarian approval)
5. Librarian reviews changes
6. Librarian activates resource
7. Document available to all users

#### Search Workflow
1. User enters search query
2. System provides spelling-corrected suggestions
3. Search executes across:
   - Title
   - Description
   - Document content
   - Previous versions (optional)
4. Results displayed with relevance ranking
5. Query and corrected query are stored for analytics

## Business Features

### Document Management
- **View Documents**: All users can view active documents
- **Update Content**: Writers update document files
- **Update Descriptions**: Writers update metadata
- **Move Documents**: Writers reorganize into folders (with permissions)
- **Version History**: Track all versions with content and metadata changes
- **Delete/Undelete**: Soft delete with recovery capability

### Search & Discovery
- **Search by Title**: Keyword search in document titles
- **Search by Description**: Keyword search in descriptions
- **Search by Content**: Full-text search within document body
- **Search Previous Versions**: Include historical versions in search
- **Spelling Correction**: Automatic query correction suggestions
- **Query Storage**: Analytics on search patterns

### Access Control
- **User Assignments**: Librarians assign specific users to resources
- **Role Assignments**: Librarians assign roles to resources
- **Permission Evaluation**: System returns permissions based on current user
- **Folder Permissions**: Inherit or override at folder level

### Publishing & Syndication
- **Activation Control**: Librarians activate/deactivate resources
- **Deactivation on Edit**: Writer edits trigger automatic deactivation
- **RSS Queries**: Search results available as RSS feed
- **Atom Resource Lists**: Folder contents available as Atom feed

### Tree Navigation
- **Hierarchical Folders**: Organize documents in folder tree
- **Folder Browsing**: Navigate through folder structure
- **Visual Tree View**: Expandable/collapsible tree interface

### Content Validation
- **Content Type Checking**: Verify file matches declared type
- **Virus Scanning**: All uploads scanned for malware
- **File Size Limits**: Enforce maximum upload sizes
- **Format Support**: PDF, Word, Excel, images, videos

## Architecture Layers

The Site Library follows a strict layered architecture:

1. **Presentation Layer** - HTML and RSS/Atom views
2. **Services Layer** - Controllers, Providers, Repositories
3. **Models Layer** - Domain entities and DTOs
4. **Data Access Layer** - Entity Store with EF
5. **Data Storage Layer** - SQL with FileStream and Full-Text Index
6. **Entities Layer** - Shared entity definitions

See [Layering Architecture](./layering.md) for detailed diagram and descriptions.

## Integration Points

- **Gateway** - User authentication and role management
- **File Storage** - SQL Server FileStream for large documents
- **Search Engine** - SQL Server Full-Text Index for content search
- **Audit System** - Change tracking and version history

## Compliance Features

### Version Control
- Every document change creates new version
- Complete version history maintained
- Ability to search previous versions
- Version comparison capabilities

### Audit Trail
- All user actions logged
- Document access tracking
- Permission changes recorded
- Version history with user attribution

### Access Control
- Role-based permissions
- User-specific permissions
- Folder-level inheritance
- Permission auditing

## Related Documentation

- [Gateway Architecture](../gateway/README.md) - User authentication and roles
