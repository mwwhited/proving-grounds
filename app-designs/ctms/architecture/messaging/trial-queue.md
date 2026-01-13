# Trial Queue Operations

## Overview

The Trial Queue (Local Queue) handles trial-specific message processing, including:
- Managing message threads with trial subjects
- Coordinating with trial entities (Subject, Contact, Template, Activity)
- Processing message state transitions
- Handling acknowledgements and errors at the trial level

## Components

- **Trial - Local Queue** - Trial-specific service bus queue
- **Trial - Subject** - Clinical trial participant
- **Trial - Contact** - Subject contact information (phone, email)
- **Trial - Message Template** - Pre-defined message templates
- **Trial - Message Thread** - Conversation thread with a subject
- **Trial - Activity** - Activity tracking for audit and compliance
- **Global - Central Queue** - Upstream global queue

## Operations

### TrialQueueHandleMessageRequest

Processes new message requests from message threads, preparing messages for delivery.

```plantuml
@startuml
participant "Trial - Local Queue" as TLQ
participant "Trial - Subject" as SUB
participant "Trial - Contact" as CON
participant "Trial - Message Template" as TMP
participant "Trial - Activity" as ACT
participant "Global - Central Queue" as GCQ

TLQ -> TLQ: Dequeue Message Request
activate TLQ

opt Subject
    TLQ -> SUB: Load Subject
    activate SUB
    SUB -> SUB: Get Subject Data
    SUB --> TLQ: Return Subject Info
    deactivate SUB

    TLQ -> CON: Load Contact
    activate CON
    CON -> CON: Get Contact Details
    CON --> TLQ: Return Contact Info
    deactivate CON
end

opt Email, SMS
    TLQ -> TMP: Load Message Template
    activate TMP
    TMP -> TMP: Get Template
    TMP -> TMP: Merge Template Data
    TMP --> TLQ: Return Message Content
    deactivate TMP
end

TLQ -> ACT: Create Activity Record
activate ACT
ACT -> ACT: Log Message Request
ACT --> TLQ: Return Activity ID
deactivate ACT

TLQ -> GCQ: Forward to Global Queue
activate GCQ
GCQ -> GCQ: Queue for Delivery
GCQ --> TLQ: Acknowledge
deactivate GCQ

deactivate TLQ
@enduml
```

**Description:**
Handles the preparation and forwarding of message requests:

1. **Dequeue Request** - Retrieve message request from trial queue
2. **Load Subject Data (Consider: Subject)** - If subject-related:
   - Load subject information
   - Load associated contact details
3. **Load Template (Consider: Email, SMS)** - Based on message type:
   - Retrieve appropriate template
   - Merge template with subject/trial data
4. **Create Activity** - Log the message request for audit trail
5. **Forward to Global Queue** - Send prepared message to Global Queue for routing

**Critical Section:** Ensures atomic processing of message data and activity logging.

---

### TrialQueueHandleMessageReceived

Processes incoming messages received from subjects (replies, responses).

```plantuml
@startuml
participant "Global - Central Queue" as GCQ
participant "Trial - Local Queue" as TLQ
participant "Trial - Message Thread" as MT
participant "Trial - Activity" as ACT

GCQ -> TLQ: Message Received
activate TLQ

TLQ -> TLQ: Parse Message Content
TLQ -> TLQ: Identify Message Thread

TLQ -> MT: Update Thread
activate MT
MT -> MT: Add Message to Thread
MT -> MT: Update Status to Received
MT --> TLQ: Confirm
deactivate MT

TLQ -> ACT: Log Received Message
activate ACT
ACT -> ACT: Create Activity Record
ACT -> ACT: Store Message Content
ACT --> TLQ: Activity ID
deactivate ACT

TLQ --> GCQ: Acknowledgement
deactivate TLQ
@enduml
```

**Description:**
Handles messages received from trial subjects:

1. **Receive Message** - From Global Queue
2. **Parse Content** - Extract message data and identify thread
3. **Update Thread** - Add message to conversation thread
4. **Update Status** - Mark message as "Received"
5. **Log Activity** - Create activity record with message content
6. **Acknowledge** - Confirm processing to Global Queue

---

### TrialQueueHandleAcknowledgement

Processes delivery acknowledgements for messages sent to subjects.

```plantuml
@startuml
participant "Global - Central Queue" as GCQ
participant "Trial - Local Queue" as TLQ
participant "Trial - Message Thread" as MT
participant "Trial - Activity" as ACT

GCQ -> TLQ: Delivery Acknowledgement
activate TLQ

TLQ -> TLQ: Parse Acknowledgement
TLQ -> TLQ: Find Message Thread

TLQ -> MT: Update Message Status
activate MT
MT -> MT: Set Status to Sent
MT -> MT: Record Delivery Time
MT --> TLQ: Confirm
deactivate MT

TLQ -> ACT: Log Acknowledgement
activate ACT
ACT -> ACT: Update Activity Status
ACT -> ACT: Record Delivery Timestamp
ACT --> TLQ: Confirm
deactivate ACT

TLQ --> GCQ: Acknowledge
deactivate TLQ
@enduml
```

**Description:**
Handles confirmation of successful message delivery:

1. **Receive Acknowledgement** - From Global Queue
2. **Parse** - Extract message identifier
3. **Find Thread** - Locate corresponding message thread
4. **Update Status** - Change message status to "Sent"
5. **Record Time** - Log delivery timestamp
6. **Update Activity** - Update activity record with delivery confirmation
7. **Confirm** - Acknowledge processing

---

### TrialQueueHandleError

Manages error conditions from message delivery attempts.

```plantuml
@startuml
participant "Global - Central Queue" as GCQ
participant "Trial - Local Queue" as TLQ
participant "Trial - Message Thread" as MT
participant "Trial - Activity" as ACT

GCQ -> TLQ: Error Notification
activate TLQ

TLQ -> TLQ: Parse Error Details
TLQ -> TLQ: Classify Error Severity

TLQ -> MT: Update Message Status
activate MT
MT -> MT: Set Status to Failed
MT -> MT: Store Error Details
MT --> TLQ: Confirm
deactivate MT

TLQ -> ACT: Log Error
activate ACT
ACT -> ACT: Create Error Activity
ACT -> ACT: Record Error Details
ACT -> ACT: Set Activity Status to Failed
ACT --> TLQ: Activity ID
deactivate ACT

alt Retryable Error
    TLQ -> TLQ: Schedule Retry
    TLQ -> TLQ: Increment Retry Count
else Permanent Error
    TLQ -> MT: Mark as Permanently Failed
    activate MT
    MT -> MT: Close Message Thread
    deactivate MT
end

TLQ --> GCQ: Error Handled
deactivate TLQ
@enduml
```

**Description:**
Handles errors from delivery attempts:

1. **Error Notification** - Receive error from Global Queue
2. **Parse & Classify** - Determine error type and severity
3. **Update Message Status** - Set to "Failed"
4. **Store Error Details** - Record error information in thread
5. **Log Error Activity** - Create error activity record
6. **Determine Action**:
   - **Retryable** - Schedule retry, increment retry counter
   - **Permanent** - Mark permanently failed, close thread

---

### TrialQueueHandleSystemMessage

Processes system-generated messages for the trial.

```plantuml
@startuml
participant "Trial - Local Queue" as TLQ
participant "Trial - Subject" as SUB
participant "Trial - Message Thread" as MT
participant "Trial - Activity" as ACT
participant "Global - Central Queue" as GCQ

TLQ -> TLQ: Receive System Message
activate TLQ

TLQ -> TLQ: Parse Message Type
TLQ -> TLQ: Load Message Data

alt Subject-Specific
    TLQ -> SUB: Get Subject Info
    activate SUB
    SUB --> TLQ: Subject Data
    deactivate SUB

    TLQ -> MT: Find or Create Thread
    activate MT
    MT -> MT: Add System Message
    MT --> TLQ: Confirm
    deactivate MT
end

TLQ -> ACT: Log System Message
activate ACT
ACT -> ACT: Create System Activity
ACT --> TLQ: Activity ID
deactivate ACT

alt Requires Delivery
    TLQ -> GCQ: Forward to Global Queue
    activate GCQ
    GCQ --> TLQ: Queued
    deactivate GCQ
end

deactivate TLQ
@enduml
```

**Description:**
Handles system-generated notifications and alerts:

1. **Receive** - System message from scheduler or automated process
2. **Parse Type** - Determine message category
3. **Load Data** - Retrieve necessary context
4. **Subject Processing** - If subject-specific:
   - Get subject information
   - Find or create message thread
   - Add message to thread
5. **Log Activity** - Record system message activity
6. **Optional Delivery** - If message requires external delivery, forward to Global Queue

---

### TrialTriggerMessageReady

Handles the trigger when a delayed message becomes ready for delivery.

```plantuml
@startuml
participant "Trial - Scheduler" as SCH
participant "Trial - Message Thread" as MT
participant "Trial - Local Queue" as TLQ
participant "Global - Central Queue" as GCQ

SCH -> MT: Trigger: Message Ready
activate MT

MT -> MT: Check Message Status
MT -> MT: Validate Send Conditions

alt Conditions Met
    MT -> MT: Update Status to Ready
    MT -> TLQ: Queue Message Request
    activate TLQ

    TLQ -> TLQ: Prepare Message
    TLQ -> GCQ: Forward to Global Queue
    activate GCQ
    GCQ --> TLQ: Queued
    deactivate GCQ

    TLQ --> MT: Queued
    deactivate TLQ

    MT -> MT: Update Status to Pending
else Conditions Not Met
    MT -> MT: Update Status to Failed
    MT -> MT: Record Reason
end

deactivate MT
@enduml
```

**Description:**
Triggered by the scheduler when a delayed message's send time arrives:

1. **Trigger** - Scheduler fires message ready event
2. **Check Status** - Verify message is still in "Ready" state
3. **Validate Conditions** - Ensure send conditions are still valid
4. **Process**:
   - **Conditions Met** - Update to "Ready", queue to Trial Queue, forward to Global Queue, update to "Pending"
   - **Conditions Not Met** - Mark as "Failed" with reason (e.g., too late, subject withdrawn)

---

### TrialSchedulerMessages

Manages scheduled messages and delayed delivery.

```plantuml
@startuml
participant "Trial - Scheduler" as SCH
participant "Trial - Message Thread" as MT

SCH -> SCH: Poll Delayed Messages
activate SCH

loop For Each Delayed Message
    SCH -> MT: Check Message Status
    activate MT

    opt Message Now Ready
        MT -> MT: Update to Ready
        MT -> MT: Trigger Message Ready Event
    end

    opt Message Now Late
        MT -> MT: Update to Failed
        MT -> MT: Record "Too Late" Reason
    end

    MT --> SCH: Status Updated
    deactivate MT
end

deactivate SCH
@enduml
```

**Description:**
The scheduler continuously monitors delayed messages:

1. **Poll** - Regular polling of delayed messages
2. **Check Each Message**:
   - **Message Delayed** - Check if send time has arrived
   - **Message Now Ready** - Update to "Ready" state, trigger ready event
   - **Message Now Late** - If past valid send window, mark as "Failed"

---

## Message Thread Lifecycle

Messages in the Trial Queue follow this lifecycle:

```
Create → Delayed → Ready → Pending → Sent → Received
                    ↓         ↓        ↓
                 Failed    Failed   Failed
                    ↓         ↓        ↓
                 Canceled  Canceled Canceled
```

## Activity Tracking

Every message operation creates an activity record for:
- **Compliance** - Regulatory audit trail
- **Debugging** - Troubleshooting delivery issues
- **Analytics** - Message engagement metrics
- **Reporting** - Trial communication reports

## Error Retry Strategy

The Trial Queue implements a retry strategy:

1. **First Failure** - Wait 1 minute, retry
2. **Second Failure** - Wait 5 minutes, retry
3. **Third Failure** - Wait 15 minutes, retry
4. **Fourth Failure** - Mark as permanently failed

## Performance Considerations

- **Batching** - Multiple message requests can be batched to Global Queue
- **Caching** - Subject, Contact, and Template data are cached to reduce database load
- **Parallel Processing** - Multiple trial queues process independently
- **Priority** - Urgent messages can be prioritized in the queue
