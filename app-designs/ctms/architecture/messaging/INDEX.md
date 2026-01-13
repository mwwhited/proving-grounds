# OoBDev Messaging Architecture Documentation Index

## Overview

This directory contains comprehensive documentation for the OoBDev Messaging Architecture, converted from Visual Studio sequence and activity diagrams to PlantUML-based markdown documentation.

## Documentation Files

### 1. [README.md](./README.md)
**Main architecture overview**
- Architecture components and hierarchy
- Message flow patterns
- Message states
- Key design patterns
- Technology stack
- Compliance and audit considerations

### 2. [gateway-queue.md](./gateway-queue.md)
**Gateway Queue Operations** (2 diagrams)
- GatewayReceiveMessage
- GatewayQueueHandleMessageRequest
- External provider integration (SMS/Email)
- Message building and template merging
- Dialog management patterns

### 3. [global-queue.md](./global-queue.md)
**Global Queue Operations** (6 diagrams)
- GlobalQueueHandleMessageRequest
- GlobalQueueHandleMessageReceived
- GlobalQueueHandleAcknowledgement
- GlobalQueueHandleAcknowledgeReceived
- GlobalQueueHandleError
- GlobalQueueHandleSystemMessage
- Central routing and coordination
- Stop list management
- Error classification and handling

### 4. [trial-queue.md](./trial-queue.md)
**Trial Queue Operations** (7 diagrams)
- TrialQueueHandleMessageRequest
- TrialQueueHandleMessageReceived
- TrialQueueHandleAcknowledgement
- TrialQueueHandleError
- TrialQueueHandleSystemMessage
- TrialTriggerMessageReady
- TrialSchedulerMessages
- Trial-specific processing
- Activity tracking
- Subject/contact/template management

### 5. [state-machine.md](./state-machine.md)
**Message Thread State Machine** (1 diagram)
- Complete state diagram with all transitions
- State definitions (Delayed, Ready, Pending, Sent, Received, Failed, Canceled)
- Transition triggers (User, Scheduler, System)
- Concurrent state management
- Error handling and recovery

### 6. [workflows.md](./workflows.md)
**User Workflows and Scheduler** (3 diagrams)
- UserRequestSendMessage
- User message cancellation
- TrialSchedulerMessages
- TrialTriggerMessageReady
- Bulk messaging
- Auto-reply patterns
- Reminder series

### 7. [DIAGRAM_MAPPING.md](./DIAGRAM_MAPPING.md)
**Diagram Mapping Reference**
- Maps original Visual Studio diagrams to documentation sections
- Complete coverage of all 18 sequence diagrams + 1 activity diagram
- PlantUML rendering instructions

### 8. [QUICK_REFERENCE.md](./QUICK_REFERENCE.md)
**Quick Reference Guide**
- Message flow overview
- Queue hierarchy
- State transition table
- Operations by queue
- Common patterns
- Error handling strategy
- Configuration settings
- Troubleshooting guide

## Source Information

**Original Location:** `/current/src/CORE/Gateway/OoBDev.Messaging/OoBDev.Messaging.Architecture/`

**Original Format:** Visual Studio .sequencediagram and .activitydiagram XML files

**Conversion Date:** 2026-01-13

## Diagram Statistics

- **Total Diagrams:** 19 (18 sequence + 1 activity)
- **Gateway Diagrams:** 2
- **Global Queue Diagrams:** 6
- **Trial Queue Diagrams:** 7
- **Workflow Diagrams:** 3
- **State Machine Diagrams:** 1

## Documentation Statistics

- **Total Files:** 8 markdown files
- **Total Lines:** ~2,300 lines
- **Total Size:** 72KB
- **PlantUML Diagrams:** 20+ diagrams
- **Coverage:** 100% of original diagrams

## How to Use This Documentation

### For New Team Members
1. Start with [README.md](./README.md) for architecture overview
2. Review [state-machine.md](./state-machine.md) to understand message lifecycle
3. Read [workflows.md](./workflows.md) for user-facing behavior
4. Use [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) for daily reference

### For Developers
1. Review [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) for API and patterns
2. Dive into specific queue documentation:
   - [trial-queue.md](./trial-queue.md) for trial-level operations
   - [global-queue.md](./global-queue.md) for routing logic
   - [gateway-queue.md](./gateway-queue.md) for provider integration
3. Use [DIAGRAM_MAPPING.md](./DIAGRAM_MAPPING.md) to find specific diagrams

### For Architects
1. Read [README.md](./README.md) for design patterns
2. Review all queue documentation for detailed flows
3. Study [state-machine.md](./state-machine.md) for state management
4. Reference original diagrams for additional details

## Rendering PlantUML Diagrams

### Online
- PlantUML Editor: http://www.plantuml.com/plantuml/

### VS Code
Install the PlantUML extension:
```bash
code --install-extension jebbs.plantuml
```

### Command Line
```bash
# Install PlantUML
sudo apt-get install plantuml

# Render diagram
plantuml diagram.puml
```

### In Documentation Sites
- **Sphinx:** Use `sphinxcontrib-plantuml`
- **MkDocs:** Use `mkdocs-plantuml`
- **Docusaurus:** Use `@docusaurus/remark-plugin-diagrams`

## Maintenance

### Updating Diagrams
1. Edit the PlantUML code in the markdown file
2. Test rendering with PlantUML tool
3. Update the description if behavior changes
4. Update [DIAGRAM_MAPPING.md](./DIAGRAM_MAPPING.md) if structure changes

### Adding New Diagrams
1. Create PlantUML diagram following existing patterns
2. Add to appropriate queue documentation file
3. Update [DIAGRAM_MAPPING.md](./DIAGRAM_MAPPING.md)
4. Update this INDEX.md

### Consistency Guidelines
- Use consistent participant names across diagrams
- Follow the established naming conventions
- Include activation/deactivation in sequence diagrams
- Add descriptive text after each diagram
- Keep diagrams focused on essential flows

## Related Documentation

- **Implementation:** `/current/src/CORE/Gateway/OoBDev.Messaging/`
- **API Documentation:** (link to API docs)
- **Deployment Guide:** (link to deployment docs)
- **Runbook:** (link to operational docs)

## Support

For questions about this documentation:
- Review [QUICK_REFERENCE.md](./QUICK_REFERENCE.md) for common questions
- Check [DIAGRAM_MAPPING.md](./DIAGRAM_MAPPING.md) for diagram locations
- Consult original Visual Studio diagrams for additional details
- Contact the architecture team for clarifications
