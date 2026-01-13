# Global Queue Operations

## Overview

The Global Queue (Central Queue) serves as the central orchestration layer for all messaging operations. It coordinates between Trial Queues and the Gateway Queue, manages the stop list, and handles system-level message routing.

## Components

- **Global - Central Queue** - Central service bus queue
- **Global - Stop List** - Database of contacts who should not receive messages
- **Trial - Local Queue** - Trial-specific message queues
- **Global - Gateway Queue** - External messaging gateway
- **Message Provider** - External messaging services

## Operations

### GlobalQueueHandleMessageRequest

Routes message requests from Trial Queues to the Gateway Queue, with stop list checking.

```plantuml
@startuml
participant "Global - Central Queue" as GCQ
participant "Global - Stop List" as SL
participant "Trial - Local Queue" as TLQ
participant "Global - Gateway Queue" as GGQ

GCQ -> GCQ: Dequeue Message Request
activate GCQ

opt Contact in Stop List
    GCQ -> SL: Check Stop List
    activate SL
    SL -> SL: Lookup Contact
    SL --> GCQ: Return Status
    deactivate SL

    alt Contact is Stopped
        GCQ -> TLQ: Send Error - Contact Stopped
        activate TLQ
        TLQ -> TLQ: Handle Error
        deactivate TLQ
    end
end

opt Contact Not Stopped
    GCQ -> GGQ: Forward Message Request
    activate GGQ

    alt Send By Date Check
        GGQ -> GGQ: Validate Send Date
        alt Too Late
            GGQ -> TLQ: Send Error - Too Late
            activate TLQ
            TLQ -> TLQ: Mark Failed
            deactivate TLQ
        else On Time
            GGQ -> GGQ: Process Message
        end
    end

    deactivate GGQ
end

deactivate GCQ
@enduml
```

**Description:**
This operation manages the routing of message requests:

1. **Dequeue Request** - Retrieves message request from the Global Queue
2. **Stop List Check (Optional)** - If contact verification is needed:
   - Query the stop list
   - If contact is on stop list, send error back to Trial Queue
   - If contact is clear, proceed
3. **Forward to Gateway** - Route message to Gateway Queue for delivery
4. **Send By Date Validation** - Verify message timing:
   - If past send-by date, return "Too Late" error to Trial Queue
   - Otherwise, proceed with delivery

**Critical Section:** Ensures atomic stop list checking and routing decisions.

---

### GlobalQueueHandleMessageReceived

Processes incoming messages from the Gateway Queue.

```plantuml
@startuml
participant "Message Provider" as MP
participant "Global - Central Queue" as GCQ
participant "Trial - Local Queue" as TLQ

MP -> GCQ: Message Received
activate GCQ

GCQ -> GCQ: Begin Dialog
GCQ -> GCQ: Parse Message Content
GCQ -> GCQ: Identify Trial & Subject

GCQ -> TLQ: Forward to Trial Queue
activate TLQ
TLQ -> TLQ: Process Received Message
TLQ --> GCQ: Acknowledgement
deactivate TLQ

GCQ -> GCQ: End Dialog
deactivate GCQ
@enduml
```

**Description:**
Handles messages received from external sources:

1. **Receive Message** - Incoming message from Message Provider
2. **Begin Dialog** - Start transaction
3. **Parse & Route** - Identify destination trial and subject
4. **Forward to Trial Queue** - Route to appropriate trial-specific queue
5. **End Dialog** - Complete transaction

---

### GlobalQueueHandleAcknowledgement

Processes delivery acknowledgements from the Gateway Queue.

```plantuml
@startuml
participant "Global - Gateway Queue" as GGQ
participant "Global - Central Queue" as GCQ
participant "Trial - Local Queue" as TLQ

GGQ -> GCQ: Delivery Acknowledgement
activate GCQ

GCQ -> GCQ: Begin Dialog
GCQ -> GCQ: Record Delivery Status

GCQ -> TLQ: Forward Acknowledgement
activate TLQ
TLQ -> TLQ: Update Message Status to Sent
TLQ --> GCQ: Confirm Update
deactivate TLQ

GCQ -> GCQ: End Dialog
deactivate GCQ
@enduml
```

**Description:**
Handles acknowledgements of successful message delivery:

1. **Receive Acknowledgement** - From Gateway Queue
2. **Begin Dialog** - Transaction start
3. **Record Status** - Log delivery confirmation
4. **Forward to Trial** - Notify Trial Queue of successful delivery
5. **Update Status** - Trial Queue updates message to "Sent" state
6. **End Dialog** - Commit transaction

---

### GlobalQueueHandleAcknowledgeReceived

Confirms receipt acknowledgement from recipients.

```plantuml
@startuml
participant "Message Provider" as MP
participant "Global - Central Queue" as GCQ
participant "Trial - Local Queue" as TLQ

MP -> GCQ: Receipt Acknowledgement
activate GCQ

GCQ -> GCQ: Parse Acknowledgement
GCQ -> GCQ: Identify Message Thread

GCQ -> TLQ: Forward Receipt Confirmation
activate TLQ
TLQ -> TLQ: Update to Received Status
TLQ -> TLQ: Record Receipt Time
TLQ --> GCQ: Confirm
deactivate TLQ

deactivate GCQ
@enduml
```

**Description:**
Processes confirmations that a recipient has actually received/read the message:

1. **Receipt Notification** - From messaging provider
2. **Parse** - Extract message thread identification
3. **Forward** - Send to Trial Queue
4. **Update Status** - Mark message as "Received"
5. **Record Timestamp** - Log receipt time

---

### GlobalQueueHandleError

Handles error conditions from Gateway Queue or messaging providers.

```plantuml
@startuml
participant "Global - Gateway Queue" as GGQ
participant "Global - Central Queue" as GCQ
participant "Trial - Local Queue" as TLQ

GGQ -> GCQ: Error Notification
activate GCQ

GCQ -> GCQ: Begin Dialog
GCQ -> GCQ: Parse Error Details
GCQ -> GCQ: Classify Error Type

alt Temporary Error
    GCQ -> GCQ: Schedule Retry
    GCQ -> TLQ: Update to Pending Retry
else Permanent Error
    GCQ -> TLQ: Forward Error
    activate TLQ
    TLQ -> TLQ: Update to Failed
    TLQ -> TLQ: Log Error Details
    deactivate TLQ
end

GCQ -> GCQ: End Dialog
deactivate GCQ
@enduml
```

**Description:**
Manages error scenarios from message delivery attempts:

1. **Error Notification** - Receive error from Gateway
2. **Begin Dialog** - Start error handling transaction
3. **Parse & Classify** - Determine error type and severity
4. **Handle Based on Type**:
   - **Temporary/Transient** - Schedule retry, update to "Pending Retry"
   - **Permanent** - Mark as "Failed", forward to Trial Queue with details
5. **End Dialog** - Complete transaction

---

### GlobalQueueHandleSystemMessage

Processes system-generated messages (notifications, alerts, automated communications).

```plantuml
@startuml
participant "Global - Central Queue" as GCQ
participant "Trial - Local Queue" as TLQ
participant "Global - Gateway Queue" as GGQ

GCQ -> GCQ: Generate System Message
activate GCQ

GCQ -> GCQ: Determine Message Type
GCQ -> GCQ: Load Template
GCQ -> GCQ: Build Message Content

alt Trial-Specific
    GCQ -> TLQ: Route to Trial Queue
    activate TLQ
    TLQ -> TLQ: Process System Message
    deactivate TLQ
else Broadcast
    GCQ -> GGQ: Send via Gateway
    activate GGQ
    GGQ -> GGQ: Deliver System Message
    deactivate GGQ
end

deactivate GCQ
@enduml
```

**Description:**
Handles automated system messages:

1. **Generate** - Create system message based on trigger
2. **Determine Type** - Classify message (alert, notification, etc.)
3. **Build Content** - Load template and populate data
4. **Route**:
   - **Trial-Specific** - Send to specific Trial Queue
   - **Broadcast** - Send directly via Gateway to multiple recipients

---

## Message Routing Rules

### Stop List Priority
The stop list check is the first validation step. Messages to stopped contacts are immediately rejected.

### Trial Identification
Incoming messages are routed to Trial Queues based on:
- Contact information
- Subject identifier
- Trial context in message metadata

### Error Classification
Errors are classified as:
- **Transient** - Network issues, temporary provider unavailability → Retry
- **Permanent** - Invalid contact, unsubscribed, blocked → Failed
- **Validation** - Missing data, invalid format → Failed

## Data Flow

```
Trial Queue ──→ Global Queue ──→ Gateway Queue ──→ Message Provider
     ↑               ↓
     │         Stop List Check
     │               │
     └───────────────┘
       Error/Ack Feedback Loop
```

## Critical Sections

All Global Queue operations use critical sections to ensure:
- Atomic stop list checking
- Consistent message routing
- Reliable state updates
- Transactional dialog management
