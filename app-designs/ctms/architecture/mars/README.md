# OoBDev MARS (Medication Adherence Reminder System) Architecture

The MARS module provides medication adherence monitoring and subject engagement capabilities for clinical trials.

## Architecture Diagrams

- [Use Cases](./use-cases.md) - MARS system use cases for managers, site members, and sponsors

## Overview

The Medication Adherence Reminder System (MARS) provides comprehensive subject engagement and adherence monitoring:

- **Site Management** - Create and manage trial sites with contact information
- **Subject Management** - Track subjects, appointments, and communication
- **Messaging** - Inbound and outbound message tracking for each subject
- **Appointment Reminders** - Automated reminder system for subject appointments
- **Member Management** - Assign and manage site members with portal access
- **Notes & Journaling** - Maintain detailed subject interaction logs
- **Sponsor Dashboard** - Real-time statistics and windowed analytics
- **Management Logging** - Active management log with privacy considerations

## Key Components

### Actor Roles

- **Mars Manager** - Administrative role for site creation and user management
- **Mars Site Member** - Site personnel managing subjects and daily operations
- **Mars Sponsor** - Trial sponsor with dashboard access to aggregate statistics

### Core Workflows

#### Site Management (Manager)
1. Manager creates new trial sites
2. Site contact information is configured
3. Portal users are assigned as site members
4. Site members are added to appropriate portal roles
5. Ongoing site information updates

#### Subject Management (Site Member)
1. Site member selects site from assigned sites
2. Automatic redirect if only one site assigned
3. Subject selection for management
4. Access to subject's complete information:
   - Contact details
   - Message history
   - Appointment schedule
   - Interaction notes

#### Message Management
1. Scheduled outbound messages are configured
2. Message delivery tracking
3. Inbound messages are received and logged
4. Complete message thread view per subject
5. Bi-directional communication history

#### Appointment Workflow
1. Site member creates appointments
2. Appointment details captured (date, time, type)
3. Reminder messages are scheduled
4. Reminders are sent automatically
5. Site-wide appointment calendar view

## Business Features

### Site Administration
- **Create Sites**: Mars managers create and configure trial sites
- **Edit Contact Information**: Update phone, fax, email, and address
- **Member Assignment**: Assign portal users to sites
- **Role Management**: Site members automatically added to correct portal roles

### Subject Engagement
- **Contact Management**: Edit primary contact details (phone, email, address)
- **Message Thread**: View complete inbound and outbound message history
- **Scheduled Messages**: Review upcoming automated messages
- **Notes & Journal**: Maintain detailed chronological notes on subject interactions
- **Appointment Management**: Create, update, and track subject appointments
- **Appointment Reminders**: Automated reminder delivery before appointments

### Site Operations
- **Site Selection**: Select from list of assigned sites
- **Single-Site Redirect**: Auto-redirect to site management if only one site assigned
- **Member List**: View all members assigned to current site
- **Appointment Calendar**: See all upcoming appointments for the site
- **Contact Management**: Update limited site contact information (phone, fax, email)

### Sponsor Oversight
- **Real-Time Statistics**: Live dashboard with key metrics
- **Windowed Statistics**: Historical trends and time-period analysis
- **Aggregate Views**: Cross-site analytics and comparisons
- **De-identified Data**: No subject-identifying information visible

### Compliance & Logging
- **Active Management Log**: High-level activity tracking without detailed subject information
- **Passive Audit Log**: Complete audit trail with full subject details
- **Privacy Protection**: Active logs generalized to prevent inadvertent PHI disclosure
- **Regulatory Compliance**: Full audit trail for inspection

## Integration Points

- **Gateway** - User authentication and portal role management
- **Messaging Service** - SMS and email delivery platform
- **Notification Engine** - Automated reminder scheduling and delivery
- **Audit System** - Comprehensive activity logging

## Architecture Considerations

### Privacy by Design
Active management logs are intentionally limited to prevent detailed subject information from being displayed in operational logs. The passive audit system captures full details for regulatory compliance and investigation purposes.

### Role-Based Access
- **Mars Manager**: Full administrative access, site creation, user management
- **Mars Site Member**: Operational access, subject management, limited site editing
- **Mars Sponsor**: Read-only access, aggregated statistics only

### Scalability
- Site-to-member relationship is typically one-to-one but supports one-to-many
- Multi-site member support for coordinators managing multiple locations
- Efficient message queuing for high-volume reminder delivery

## Related Documentation

- [Gateway Architecture](../gateway/README.md) - Portal user management and roles
- [Messaging Architecture](../messaging/README.md) - Message delivery infrastructure
