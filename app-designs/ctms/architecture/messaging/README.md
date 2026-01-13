# OoBDev Messaging Architecture

## Overview

The OoBDev Messaging Architecture provides a comprehensive message handling system for clinical trial communications. The architecture is built around a queue-based message processing system with multiple layers handling different aspects of message delivery.

## Architecture Components

### Queue Hierarchy

The messaging system consists of three primary queue layers:

1. **Gateway Queue** - Handles message reception from external providers and initial message routing
2. **Global Queue** - Central message coordination, routing, and system-wide message management
3. **Trial Queue** - Trial-specific message processing, including subject-specific message handling

### Key Components

- **Message Provider** - External messaging service integration (Email, SMS providers)
- **Message Builder** - Constructs messages from templates and trial data
- **Message Thread** - Represents a conversation thread with a trial subject
- **Stop List** - Manages contacts who have opted out or should not receive messages
- **Scheduler** - Handles delayed message delivery based on timing rules
- **Activity Tracking** - Records message-related activities for audit and compliance

## Message Flow

The typical message flow follows this pattern:

```
User Request → Trial Queue → Global Queue → Gateway Queue → Message Provider → Recipient
                     ↓              ↓              ↓
                 Activity      Stop List      Message Builder
                 Tracking      Check
```

## Message States

Messages progress through various states as tracked by the Message Thread State Machine:

- **Delayed** - Scheduled for future delivery
- **Ready** - Prepared and ready to send
- **Pending** - Queued for delivery
- **Sent** - Successfully delivered
- **Received** - Confirmed receipt
- **Failed** - Delivery failed
- **Canceled** - User-canceled message

## Documentation Structure

This documentation is organized into the following sections:

- **[Gateway Queue Operations](./gateway-queue.md)** - Message reception and provider integration
- **[Global Queue Operations](./global-queue.md)** - Central message routing and coordination
- **[Trial Queue Operations](./trial-queue.md)** - Trial-specific message processing
- **[Message Thread State Machine](./state-machine.md)** - Message lifecycle state transitions
- **[User Workflows and Scheduler](./workflows.md)** - User interactions and scheduled messaging

## Message Types

The system handles multiple message types:

- **Message Request** - Request to send a new message
- **Message Received** - Notification that a message was received
- **Acknowledgement** - Confirmation of message delivery
- **System Message** - System-generated notifications
- **Error** - Error notifications and handling

## Key Design Patterns

### Critical Sections
Many operations use critical sections to ensure data consistency during message processing.

### Optional Processing
The architecture uses optional (opt) fragments to handle conditional processing based on message type, contact status, and other factors.

### Consider Fragments
Some operations specifically consider certain message properties (Subject, Contact, Template) for specialized processing.

## Technology Stack

- **Service Bus** - Azure Service Bus for reliable message queuing
- **Dialogs** - Conversation dialogs for transactional messaging
- **Database** - Persistent storage for message state and history
- **External Providers** - SMS and Email service integrations

## Compliance and Audit

The system maintains comprehensive audit trails through:

- Activity tracking for all message operations
- Stop list management for compliance with opt-out requests
- Message state history
- Delivery confirmation tracking
