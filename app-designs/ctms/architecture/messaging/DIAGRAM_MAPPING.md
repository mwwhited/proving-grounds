# Diagram to Documentation Mapping

This document maps the original Visual Studio sequence and activity diagrams to the corresponding sections in the markdown documentation.

## Source Directory

Original diagrams: `/current/src/CORE/Gateway/OoBDev.Messaging/OoBDev.Messaging.Architecture/`

## Documentation Structure

### README.md
Main overview of the messaging architecture.

**Covers:**
- Architecture overview
- Component descriptions
- Message flow patterns
- Message states
- Design patterns

---

### gateway-queue.md
Gateway Queue operations and external provider integration.

**Diagrams Included:**

| Original Diagram File | Section |
|----------------------|---------|
| `GatewayReceiveMessage.sequencediagram` | GatewayReceiveMessage |
| `GatewayQueueHandleMessageRequest.sequencediagram` | GatewayQueueHandleMessageRequest |

**Operations:**
- Receiving messages from external providers
- Processing outbound message requests
- Building messages from templates
- Managing provider integrations

---

### global-queue.md
Global Queue (Central Queue) operations and message routing.

**Diagrams Included:**

| Original Diagram File | Section |
|----------------------|---------|
| `GlobalQueueHandleMessageRequest.sequencediagram` | GlobalQueueHandleMessageRequest |
| `GlobalQueueHandleMessageReceived.sequencediagram` | GlobalQueueHandleMessageReceived |
| `GlobalQueueHandleAcknowledgement.sequencediagram` | GlobalQueueHandleAcknowledgement |
| `GlobalQueueHandleAcknowledgeReceived.sequencediagram` | GlobalQueueHandleAcknowledgeReceived |
| `GlobalQueueHandleError.sequencediagram` | GlobalQueueHandleError |
| `GlobalQueueHandleSystemMessage.sequencediagram` | GlobalQueueHandleSystemMessage |

**Operations:**
- Routing message requests from Trial to Gateway
- Stop list checking
- Processing incoming messages
- Handling acknowledgements
- Error management
- System message distribution

---

### trial-queue.md
Trial Queue (Local Queue) operations and trial-specific processing.

**Diagrams Included:**

| Original Diagram File | Section |
|----------------------|---------|
| `TrialQueueHandleMessageRequest.sequencediagram` | TrialQueueHandleMessageRequest |
| `TrialQueueHandleMessageReceived.sequencediagram` | TrialQueueHandleMessageReceived |
| `TrialQueueHandleAcknowledgement.sequencediagram` | TrialQueueHandleAcknowledgement |
| `TrialQueueHandleError.sequencediagram` | TrialQueueHandleError |
| `TrialQueueHandleSystemMessage.sequencediagram` | TrialQueueHandleSystemMessage |
| `TrialTriggerMessageReady.sequencediagram` | TrialTriggerMessageReady |
| `TrialSchedulerMessages.sequencediagram` | TrialSchedulerMessages |

**Operations:**
- Processing message requests from message threads
- Handling received messages from subjects
- Managing delivery acknowledgements
- Error handling at trial level
- System message processing
- Scheduler integration
- Message ready triggers

---

### state-machine.md
Message Thread State Machine and lifecycle management.

**Diagrams Included:**

| Original Diagram File | Section |
|----------------------|---------|
| `MessageThreadStateMachine.activitydiagram` | Complete State Machine |

**States:**
- Delayed
- Ready
- Pending
- Sent
- Received
- Failed
- Canceled

**Transitions:**
- User-initiated (Send Now, Send Later, Cancel)
- Scheduler-initiated (Now Ready, Now Late)
- System-initiated (Fire Trigger, Acknowledged, Failed Send)

---

### workflows.md
User workflows and scheduler operations.

**Diagrams Included:**

| Original Diagram File | Section |
|----------------------|---------|
| `UserRequestSendMessage.sequencediagram` | UserRequestSendMessage |
| `TrialSchedulerMessages.sequencediagram` | TrialSchedulerMessages |
| `TrialTriggerMessageReady.sequencediagram` | TrialTriggerMessageReady |

**Workflows:**
- User send message workflow
- Message cancellation
- Scheduler polling
- Message ready trigger
- Bulk messaging
- Auto-reply
- Reminder series

---

## Generic Queue Diagram

**Diagram:**
| Original Diagram File | Coverage |
|----------------------|----------|
| `GenericQueueHandleEnd.sequencediagram` | Pattern used throughout all queue operations |

This diagram shows the generic "End Dialog" pattern used across all queue operations. The pattern is incorporated into all queue operation diagrams in the documentation.

---

## PlantUML Diagram Format

All diagrams in the documentation use PlantUML sequence diagram or state diagram syntax, which can be rendered using:

- PlantUML online editor: http://www.plantuml.com/plantuml/
- VS Code PlantUML extension
- Markdown preview with PlantUML support
- Documentation generators (Sphinx, MkDocs with PlantUML plugin)

## Diagram Enhancement

The PlantUML diagrams in the documentation are:

1. **Simplified** - Focus on the essential message flows
2. **Readable** - Clear participant names and message labels
3. **Consistent** - Uniform styling across all diagrams
4. **Annotated** - Accompanied by detailed descriptions

The original Visual Studio diagrams contained additional metadata and layout information that is not relevant to understanding the architecture, so it has been omitted in favor of clarity.

## Total Coverage

- **18 Sequence Diagrams** - All converted and documented
- **1 Activity Diagram** - Converted to state diagram
- **6 Documentation Files** - Organized by functional area
- **1730 Lines** - Of comprehensive documentation

## How to Use This Documentation

1. **Start with README.md** - Get the big picture
2. **Review state-machine.md** - Understand message lifecycle
3. **Read workflows.md** - Learn user interactions
4. **Dive into queue docs** - Understand implementation details
   - trial-queue.md for trial-level operations
   - global-queue.md for routing and coordination
   - gateway-queue.md for provider integration

## Maintenance

When updating diagrams:

1. Update the corresponding PlantUML diagram in the markdown file
2. Update the description text if behavior changes
3. Ensure consistency with related diagrams
4. Test PlantUML rendering
5. Update this mapping document if new diagrams are added
