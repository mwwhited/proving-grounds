# CEC Feature Specification: Adjudication & Voting

## Overview

The Adjudication feature enables committee members to review events during meetings, conduct discussions, vote on event classifications, and reach consensus decisions.

## Feature Details

**Feature Name**: Event Adjudication and Voting
**Module**: Clinical Event Committee (CEC)
**Actors**: Adjudicator, Meeting Manager
**Priority**: High
**Status**: Implementation Ready

## User Stories

1. **As an Adjudicator**, I want to review event details during the meeting so I can make informed decisions
2. **As an Adjudicator**, I want to vote on event classification so the committee can reach consensus
3. **As a Meeting Manager**, I want to facilitate the voting process so decisions are recorded accurately
4. **As an Adjudicator**, I want to see other members' votes so we can discuss discrepancies
5. **As an Adjudicator**, I want to add comments to my vote so I can explain my rationale

## Functional Requirements

### FR-1: Event Presentation
- Display complete event details during meeting
- Show medical review summary
- Provide access to source documents
- Display subject demographics (de-identified)
- Show event timeline

### FR-2: Voting Interface
- Allow each adjudicator to submit independent vote
- Support multiple classification options
- Capture vote rationale/comments
- Record vote timestamp and voter
- Prevent duplicate voting

### FR-3: Consensus Tracking
- Calculate voting results in real-time
- Display vote distribution
- Identify consensus vs. split decisions
- Flag conflicts for discussion
- Support revoting if needed

### FR-4: Discussion Management
- Allow adjudicators to request discussion
- Track discussion points
- Record key discussion notes
- Time discussion periods
- Support deferrals for more information

### FR-5: Final Classification
- Record committee's final decision
- Capture consensus level
- Document dissenting opinions
- Assign final event classification
- Update event status

## ASCII Art Mockups

### Meeting In Progress - Event Review

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ CEC Meeting MTG-2026-015 - IN PROGRESS                Dr. Martinez [Chair]  │
├─────────────────────────────────────────────────────────────────────────────┤
│ Event 3 of 12 │ Current Time: 2:35 PM │ Quorum: 7/8 Present          [End]  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Event EVT-2025-0148 - Myocardial Infarction                                │
│  Subject: SUBJ-001098 (J.R., 72M) │ Site: 101 │ Event Date: 01/06/2026      │
│                                                                              │
│  ┌─ Overview ─┬─ Medical Review ─┬─ Documents ─┬─ Vote ─┬─ Discussion ─┐  │
│  │░░░░░░░░░░░░│                  │             │        │              │  │
│  └────────────┴──────────────────┴─────────────┴────────┴──────────────┘  │
│                                                                              │
│  Clinical Summary                                                           │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ 72 yo male with acute anterior STEMI. Presented with severe chest pain │ │
│  │ radiating to jaw and left arm. ECG shows ST elevation in V2-V4. Troponin│ │
│  │ significantly elevated at 3.8 ng/mL. Emergent cardiac catheterization  │ │
│  │ revealed 95% occlusion of LAD. Successful PCI with DES placement.      │ │
│  │                                                                         │ │
│  │ Medical Reviewer Assessment (Dr. Sarah Chen):                          │ │
│  │ Classic presentation of Type 1 STEMI with prompt intervention. All     │ │
│  │ diagnostic criteria met. Documentation complete. Recommend approval as │ │
│  │ Confirmed MI - STEMI, Anterior Wall.                                   │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Key Findings                                                               │
│  ┌─────────────────────────┬─────────────────────────┬───────────────────┐ │
│  │ ECG                     │ Biomarkers              │ Imaging           │ │
│  ├─────────────────────────┼─────────────────────────┼───────────────────┤ │
│  │ ✓ ST Elevation V2-V4    │ ✓ Troponin: 3.8 ng/mL   │ ✓ Cath: LAD 95%   │ │
│  │ ✓ Q waves developing    │ ✓ CK-MB: Elevated       │ ✓ Successful PCI  │ │
│  │ ✓ Reciprocal changes    │ ✓ Serial trending       │ ✓ TIMI 3 flow     │ │
│  └─────────────────────────┴─────────────────────────┴───────────────────┘ │
│                                                                              │
│  Source Documents (8)                                    [View All Documents]│
│  • 12-Lead ECG (01/06/2026)  • Cardiac Cath Report  • Lab Results  • More.. │
│                                                                              │
│  Presenter Notes                                                            │
│  Dr. Chen: Clear case of anterior STEMI. Patient had classic presentation   │
│  and rapid intervention. All Universal Definition criteria met.             │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [< Previous Event]  [Open Discussion]  [Proceed to Vote >]                 │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Voting Interface

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ CEC Meeting MTG-2026-015 - VOTING                      Dr. Martinez [Chair]  │
├─────────────────────────────────────────────────────────────────────────────┤
│ Event 3 of 12: EVT-2025-0148 │ Votes: 5/7 │ Time Remaining: 2:45      [End] │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Vote on Event Classification - EVT-2025-0148                               │
│  Subject: SUBJ-001098 (J.R., 72M) │ Proposed: Confirmed MI - STEMI          │
│                                                                              │
│  Your Vote (Dr. Robert Martinez)                                            │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Event Classification: *                                                │ │
│  │                                                                         │ │
│  │  Primary Classification:                                                │ │
│  │  ● Confirmed Myocardial Infarction                                      │ │
│  │  ○ Probable Myocardial Infarction                                       │ │
│  │  ○ Possible Myocardial Infarction                                       │ │
│  │  ○ Not Myocardial Infarction                                            │ │
│  │  ○ Indeterminate - Request More Information                             │ │
│  │                                                                         │ │
│  │  MI Type/Subtype: *                                                     │ │
│  │  ☑ STEMI (ST-Elevation MI)                                              │ │
│  │  ☐ NSTEMI (Non-ST-Elevation MI)                                         │ │
│  │                                                                         │ │
│  │  Universal Definition Type:                                             │ │
│  │  ● Type 1 - Spontaneous MI                                              │ │
│  │  ○ Type 2 - Secondary to ischemic imbalance                             │ │
│  │  ○ Type 3 - Sudden cardiac death                                        │ │
│  │  ○ Type 4a - Related to PCI                                             │ │
│  │  ○ Type 4b - Stent thrombosis                                           │ │
│  │  ○ Type 5 - Related to CABG                                             │ │
│  │                                                                         │ │
│  │  Location:                                                              │ │
│  │  ☐ Inferior  ☑ Anterior  ☐ Lateral  ☐ Posterior  ☐ Septal  ☐ RV        │ │
│  │                                                                         │ │
│  │  Certainty Level: *                                                     │ │
│  │  ● High (>90%)   ○ Moderate (70-90%)   ○ Low (<70%)                     │ │
│  │                                                                         │ │
│  │  Rationale/Comments:                                                    │ │
│  │  ┌──────────────────────────────────────────────────────────────┐      │ │
│  │  │ Clear anterior STEMI with all diagnostic criteria met. ECG,  │      │ │
│  │  │ biomarkers, and angiography all support Type 1 STEMI.        │      │ │
│  │  │ Excellent documentation. Concur with medical reviewer.       │      │ │
│  │  └──────────────────────────────────────────────────────────────┘      │ │
│  │                                                                         │ │
│  │  Additional Findings:                                                   │ │
│  │  ☐ Protocol Deviation    ☐ Safety Concern    ☑ Study Drug Unrelated    │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  ☑ I have reviewed all source documents                                     │
│  ☑ I have no conflict of interest regarding this event                      │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [Save Draft]                                           [Submit Vote]       │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Real-Time Vote Tally

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Vote Tally - EVT-2025-0148                                             [X]  │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Voting Status: 7 of 7 votes received                    ✓ Voting Complete  │
│  Consensus Threshold: 5/7 (71%)                          ✓ Consensus Reached│
│                                                                              │
│  Primary Classification Results                                             │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Confirmed MI               ███████████████████████████ 7 (100%)       │ │
│  │  Probable MI                ░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0 (0%)         │ │
│  │  Possible MI                ░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0 (0%)         │ │
│  │  Not MI                     ░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0 (0%)         │ │
│  │  Indeterminate              ░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0 (0%)         │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  MI Subtype Results                                                         │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │  STEMI                      ███████████████████████████ 7 (100%)       │ │
│  │  Type 1 - Spontaneous       ███████████████████████████ 7 (100%)       │ │
│  │  Anterior Location          ███████████████████████████ 7 (100%)       │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Individual Votes                                                           │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Adjudicator            Vote             Type      Location  Certainty  │ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ Dr. Martinez (Chair)   Confirmed MI     Type 1    Anterior  High       │ │
│  │ Dr. Thompson           Confirmed MI     Type 1    Anterior  High       │ │
│  │ Dr. Chang              Confirmed MI     Type 1    Anterior  High       │ │
│  │ Dr. Anderson           Confirmed MI     Type 1    Anterior  High       │ │
│  │ Dr. Kim                Confirmed MI     Type 1    Anterior  Moderate   │ │
│  │ Dr. Williams           Confirmed MI     Type 1    Anterior  High       │ │
│  │ Dr. Wilson             Confirmed MI     Type 1    Anterior  High       │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Consensus: UNANIMOUS (7/7 - 100%)                                          │
│                                                                              │
│  Final Classification:                                                      │
│  Confirmed Myocardial Infarction - Type 1 STEMI, Anterior Wall              │
│                                                                              │
│  ─────────────────────────────────────────────────────────────────          │
│                                                                              │
│  [View Comments]  [Reopen Discussion]  [Record Final Decision]              │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Split Decision - Discussion Required

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ Vote Tally - EVT-2025-0151 - DISCUSSION REQUIRED                            │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Voting Status: 7 of 7 votes received                    ⚠ No Clear Consensus│
│  Consensus Threshold: 5/7 (71%)                          Discussion Needed  │
│                                                                              │
│  Primary Classification Results                                             │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │                                                                         │ │
│  │  Confirmed Stroke           ████████████████░░░░░░░░░░ 4 (57%)         │ │
│  │  Probable Stroke            ████████░░░░░░░░░░░░░░░░░░ 2 (29%)         │ │
│  │  TIA (Not Stroke)           ████░░░░░░░░░░░░░░░░░░░░░░ 1 (14%)         │ │
│  │                                                                         │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  ⚠ No classification achieved required 71% consensus                        │
│                                                                              │
│  Individual Votes                                                           │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ Dr. Martinez          Confirmed Stroke    - "Clear infarct on imaging" │ │
│  │ Dr. Thompson          Confirmed Stroke    - "Meets all criteria"       │ │
│  │ Dr. Chang             Probable Stroke     - "Small size, query TIA"    │ │
│  │ Dr. Anderson          Confirmed Stroke    - "Residual deficit present" │ │
│  │ Dr. Kim               TIA (Not Stroke)    - "Symptoms <24hr, minimal"  │ │
│  │ Dr. Williams          Probable Stroke     - "Borderline case"          │ │
│  │ Dr. Wilson            Confirmed Stroke    - "Imaging confirms stroke"  │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Key Discussion Points:                                                     │
│  • Duration of symptoms (22 hours vs. 24 hour threshold)                    │
│  • Size of infarct on MRI                                                   │
│  • Presence/absence of residual neurological deficit                        │
│                                                                              │
│  Discussion Notes:                                                          │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ [2:45 PM] Chair opened discussion                                      │ │
│  │ [2:46 PM] Dr. Kim: Symptoms resolved in 22 hours, very small lesion    │ │
│  │ [2:48 PM] Dr. Wilson: Imaging shows definite infarction                │ │
│  │ [2:49 PM] Dr. Thompson: Residual weakness documented at 24hr           │ │
│  │ [Add Note...]                                                          │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Chair Actions:                                                             │
│  [Continue Discussion]  [Request Re-Vote]  [Request More Information]       │
│  [Defer to Next Meeting]  [Record Split Decision]                           │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Meeting Progress Dashboard

```
┌─────────────────────────────────────────────────────────────────────────────┐
│ CEC Meeting MTG-2026-015 - Progress                    Dr. Martinez [Chair]  │
├─────────────────────────────────────────────────────────────────────────────┤
│ Meeting Started: 2:00 PM │ Current Time: 3:15 PM │ Quorum: 7/8 Present      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│  Meeting Progress                                              [End Meeting] │
│  ═══════════════════════════════════════════════════════════════════       │
│                                                                              │
│  Overall Status: On Schedule                                                │
│  Time Elapsed: 1 hour 15 minutes  │  Estimated Completion: 4:45 PM          │
│  ████████░░░░░░░░░░ 42% Complete                                            │
│                                                                              │
│  Event Adjudication Progress                                                │
│  ┌────────────────────────────────────────────────────────────────────────┐ │
│  │ #  Event ID      Subject     Type         Status        Time     Vote  │ │
│  ├────────────────────────────────────────────────────────────────────────┤ │
│  │ 1  EVT-2025-0148 SUBJ-001098 MI           ✓ Adjudicated 20 min  7/7   │ │
│  │    Decision: Confirmed MI - STEMI, Anterior (Unanimous)                │ │
│  │                                                                        │ │
│  │ 2  EVT-2025-0150 SUBJ-001877 Heart Fail   ✓ Adjudicated 18 min  6/7   │ │
│  │    Decision: Confirmed CHF Hospitalization (86% consensus)             │ │
│  │                                                                        │ │
│  │ 3  EVT-2025-0149 SUBJ-003124 Death        ✓ Adjudicated 22 min  7/7   │ │
│  │    Decision: Cardiovascular Death - MI (Unanimous)                     │ │
│  │                                                                        │ │
│  │ 4  EVT-2025-0151 SUBJ-002341 Stroke       ⚠ Discussion  15 min  4/7   │ │
│  │    Status: Re-voting after discussion                                  │ │
│  │                                                                        │ │
│  │ 5  EVT-2025-0145 SUBJ-003021 CV Event     ► In Progress  --      5/7   │ │
│  │    Status: Voting in progress                                          │ │
│  │                                                                        │ │
│  │ 6-12 ... 7 more events                    Pending                      │ │
│  └────────────────────────────────────────────────────────────────────────┘ │
│                                                                              │
│  Decisions Summary                                                          │
│  Adjudicated: 3  │  In Progress: 2  │  Pending: 7  │  Total: 12             │
│                                                                              │
│  Consensus Distribution                                                     │
│  Unanimous (100%):     2 events                                             │
│  Strong (>85%):        1 event                                              │
│  Moderate (71-85%):    0 events                                             │
│  Split (<71%):         1 event (requires discussion)                        │
│                                                                              │
│  Time Analysis                                                              │
│  Average per event: 18.75 minutes  │  Remaining: ~2 hours 20 minutes        │
│                                                                              │
│  Break Scheduled: 3:20 PM (5 minutes)                                       │
│                                                                              │
│  Quick Actions:                                                             │
│  [Take Break]  [Resume Event 5]  [Skip to Event]  [View Detailed Results]   │
│                                                                              │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Business Rules

### BR-1: Voting Requirements
- All assigned adjudicators must vote on each event
- Votes cannot be changed after submission (unless re-vote)
- COI adjudicators must abstain from relevant events
- Minimum quorum must be present for valid votes

### BR-2: Consensus Determination
- Consensus requires ≥71% agreement (configurable)
- Unanimous = 100% agreement
- Strong consensus = 86-99% agreement
- Moderate consensus = 71-85% agreement
- Split decision = <71% agreement (requires discussion)

### BR-3: Discussion Protocol
- Chair can open discussion at any time
- Any adjudicator can request discussion
- Discussion notes recorded in real-time
- Re-voting allowed after discussion
- Maximum 2 re-votes per event

### BR-4: Final Decision
- Final decision recorded only when consensus met
- Split decisions can be:
  - Deferred for more information
  - Carried to next meeting
  - Recorded as split with majority opinion
- Chair has tiebreaker authority (if enabled)

## Data Model

```
Adjudication {
  AdjudicationID: string (PK)
  EventID: string (FK)
  MeetingID: string (FK)
  PresentationStartTime: datetime
  VotingStartTime: datetime
  VotingEndTime: datetime
  DiscussionRequired: boolean
  DiscussionNotes: text
  RevoteCount: integer
  FinalDecisionTime: datetime
  ConsensusLevel: string
  Status: string
}

Vote {
  VoteID: string (PK)
  AdjudicationID: string (FK)
  AdjudicatorID: string (FK)
  VoteRound: integer
  PrimaryClassification: string
  SubClassification: json
  CertaintyLevel: string
  Rationale: text
  AdditionalFindings: json
  VoteTime: datetime
  Abstained: boolean
  AbstractionReason: string
}

FinalDecision {
  DecisionID: string (PK)
  AdjudicationID: string (FK)
  EventID: string (FK)
  FinalClassification: string
  SubClassification: json
  ConsensusType: string
  ConsensusPercentage: decimal
  DissentingOpinions: json
  DecisionRationale: text
  RecordedBy: string (FK)
  RecordedTime: datetime
}
```

## Testing Scenarios

### Test Case 1: Unanimous Vote
1. Start meeting with quorum
2. Present event
3. All adjudicators vote same classification
4. Verify unanimous consensus
5. Record final decision
6. Verify event status updated

### Test Case 2: Split Decision Requiring Discussion
1. Present event
2. Adjudicators submit varied votes
3. System detects no consensus
4. Chair opens discussion
5. Discussion notes recorded
6. Re-vote conducted
7. Consensus achieved
8. Final decision recorded

### Test Case 3: Abstention Due to COI
1. Event assigned to meeting
2. COI detected for adjudicator
3. Adjudicator marked to abstain
4. Voting proceeds without COI adjudicator
5. Quorum still met with remaining voters
6. Decision recorded with note of abstention

## Future Enhancements

1. Real-time voting with live updates
2. Anonymous voting option
3. AI-assisted classification suggestions
4. Historical similar case comparisons
5. Integrated video conferencing
6. Mobile voting app
7. Post-meeting vote analytics
8. Adjudicator performance metrics
9. Automated meeting minutes generation
10. Voice-to-text for discussion capture
