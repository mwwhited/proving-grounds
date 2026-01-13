# OoBDev CTS (Clinical Trial System) Architecture

The CTS module provides subject screening and enrollment management for the OoBDev clinical trial management system.

## Architecture Diagrams

- [Use Cases](./use-cases.md) - Subject screening and enrollment use cases

## Overview

The Clinical Trial System (CTS) module manages the subject screening and enrollment process for clinical trials, providing:

- **Subject Screening** - Configurable questionnaire-based screening with validation rules
- **Subject Management** - Search, track, and manage subjects throughout their lifecycle
- **Enrollment Workflow** - Enroll or decline subjects based on screening results
- **Site Management** - Manage site relationships and subject associations
- **Reporting** - View designated reports for site subscribers and sponsors
- **Training Materials** - Access to protocol training and documentation
- **Compliance** - 21 CFR Part 11 auditing and configuration management

## Key Components

### Actor Roles

- **User** - Base user role with access to training materials and gateway functions
- **Subscriber** - Site-level user who can screen and manage subjects
- **Primary Subscriber** - Enhanced subscriber role (inherits from Subscriber)
- **Sponsor** - Trial sponsor with access to de-identified aggregate reports

### Core Workflows

#### Subject Screening Process
1. Subscriber initiates subject screening for related site
2. Configurable questionnaire is presented
3. Validation rules are applied in real-time
4. Conditional questions based on gender or previous answers
5. Color-coded responses indicate screening status
6. Eligibility determination based on rules
7. Ineligible reasons are automatically displayed

#### Subject Lifecycle
1. **Screening** - Initial questionnaire and eligibility assessment
2. **Eligible** - Passed screening criteria
3. **Enrolled** - Formally enrolled in trial
4. **Declined** - Did not meet criteria or chose not to participate
5. **Deactivated** - Withdrawn from trial
6. **Completed** - Finished trial participation (read-only status)

## Business Features

### Screening Management
- Screen subjects for site-assigned trials
- Resume incomplete screenings
- Search for subjects within related sites
- Read-only access to completed subjects
- Deactivate subjects as needed

### Enrollment Operations
- Enroll eligible subjects
- Decline ineligible subjects
- Track enrollment status
- Maintain subject history

### Questionnaire Engine
- Configurable questionnaires without recompiling
- Validation rule engine
- Dynamic question flow:
  - Disable questions based on gender
  - Disable questions based on other responses
  - Display ineligible reasons in real-time
- Color-coded answer indication (with accessibility considerations)

### Site Integration
- Users related to specific sites
- Site-scoped subject access
- Multi-site trial support

### Reporting
- Subscriber reports (site-specific, identified data)
- Sponsor reports (aggregate, de-identified data)
- No PHI/PII in sponsor reports

### Training & Documentation
- Protocol training materials
- User guides and SOPs
- Required training tracking

## Compliance & Configuration

### 21 CFR Part 11 Compliance
- **Audit Trail**: All features support comprehensive auditing
- **Electronic Signatures**: Where required by regulation
- **Data Integrity**: Validation and verification
- **Security**: Role-based access control

### Configuration Without Recompilation (R16)
- Questionnaires defined in configuration
- Validation rules externalized
- Business logic in database or config files
- No code changes for trial-specific customization

## Integration Points

- **Gateway** - User authentication, site assignments, role management
- **Audit System** - 21 CFR Part 11 compliant audit trail
- **Reporting Engine** - Report generation and access control

## Functional Requirements

### R1: Screen Subjects for Related Site
Subscribers may screen subjects only for sites they are assigned to

### R2: Resume Screening
Users can resume incomplete screenings for site subjects

### R3: Search Subjects
Search functionality within related site boundaries

### R4: Completed Subjects Read-Only
Subjects who have completed the trial are locked from editing

### R5: Deactivate Subjects
Authorized users can deactivate subjects for related sites

### R6: Enroll/Decline Subjects
Subscribers can enroll eligible subjects or decline ineligible subjects

### R7: Configurable Questionnaires
Questionnaires and validation rules are configurable without code changes

### R8: View Designated Reports
Subscribers can access reports designated for their role and sites

### R9: Sponsor Reports
Sponsors can view aggregate, de-identified reports only

### R10: Training Materials
All users must be able to access and view training materials

### R11: Gender-Based Question Logic
System can disable questions based on subject gender

### R12: Conditional Question Logic
Questions can be enabled/disabled based on other question responses

### R13: Color-Coded Responses
Questions may have color indicators for selected answers (accessibility note: color alone is not 508 compliant)

### R14: Gateway User Integration
All CTS users are also Gateway users with full Gateway functionality

### R15: Audit Trail
All features must support auditing for 21 CFR Part 11 compliance

### R16: Configuration-Driven
System should support configuration without recompiling source code

## Related Documentation

- [Gateway Architecture](../gateway/README.md) - Core authentication and user management
- [CEC Architecture](../cec/README.md) - Clinical Event Committee integration
