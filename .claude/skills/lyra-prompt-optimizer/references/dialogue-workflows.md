# Dialogue Workflows with AskUserQuestion Tool

Complete workflow patterns for implementing Lyra's interactive dialogue using the AskUserQuestion tool across all optimization levels.

---

## Overview

This reference provides **ready-to-use workflow templates** for conducting interactive dialogues at each optimization level.

**Key Components:**
- Decision trees (when to ask, what to ask)
- Question flow diagrams
- Iteration patterns
- Error handling workflows
- Bilingual support patterns

---

## Core Workflow Pattern

```
START
  ↓
Detect Language (EN/VN)
  ↓
Analyze Initial Prompt
  ↓
Determine Optimization Level
  ↓
Generate Questions (based on level)
  ↓
Call AskUserQuestion Tool
  ↓
User Provides Answers
  ↓
Process & Analyze Answers
  ↓
[Decision Point]
  ├→ Sufficient Info? → Proceed to Phase 2 (Blueprint)
  └→ Gaps Exist? → Generate Follow-up Questions (loop back)
```

---

## Optimization Level Workflows

### Quick Boost Workflow (0-2 questions)

**Decision Tree:**

```
Initial Prompt Received
  ↓
Is prompt COMPLETELY clear?
  ├→ YES: Skip questions, go to Phase 2
  └→ NO: Continue
      ↓
      Identify 1-2 CRITICAL gaps
      ↓
      Generate AskUserQuestion (single round)
      ↓
      User answers
      ↓
      Go to Phase 2
```

**When to Ask 0 Questions:**
- Prompt includes role, context, format, constraints
- All critical information present
- No ambiguity

**Example (0 questions):**
```
User: "Write a Python function to validate email addresses using regex. 
       Return True if valid, False otherwise. Include docstring and type hints."

Analysis: ✅ Clear language, clear task, clear output
Decision: NO QUESTIONS → Phase 2
```

**When to Ask 1-2 Questions:**
- Missing ONE critical element (e.g., language, format, audience)
- Vague goal (e.g., "write code", "help me")

**Example (1 question):**
```
User: "Write some code."

Question 1: "Which programming language?"
Options: Python, JavaScript, Java, PHP, Other

User Response: Python

→ Phase 2
```

**Example (2 questions):**
```
User: "Summarize this article."

Question 1: "What length summary?"
Options: 1-sentence, 1-paragraph, Detailed (5+ paragraphs)

Question 2: "What is the target audience?"
Options: General public, Technical experts, Students, Business executives

User Responses: {length: "1-paragraph", audience: "general-public"}

→ Phase 2
```

**Implementation Pattern:**

```python
def quick_boost_dialogue(prompt: str, language: str):
    gaps = identify_critical_gaps(prompt)
    
    if len(gaps) == 0:
        # Prompt is clear
        return {"questions": [], "proceed": True}
    
    # Generate 1-2 questions for most critical gaps
    questions = generate_questions(gaps[:2], language)
    
    return {"questions": questions, "proceed": False}
```

---

### Deep Dive Workflow (3-5 questions, 2 rounds)

**Decision Tree:**

```
Initial Prompt Received
  ↓
Analyze complexity
  ↓
Is it a complex problem?
  └→ YES: Continue
      ↓
      Round 1: Ask 3 questions (Goal, Audience, Context)
      ↓
      User answers Round 1
      ↓
      Analyze completeness
      ↓
      [Decision Point]
        ├→ Complete? → Phase 2
        └→ Gaps remain?
            ↓
            Round 2: Ask 2 follow-up questions (Structure, Criticality)
            ↓
            User answers Round 2
            ↓
            → Phase 2
```

**Round 1: Foundation (3 questions)**

Categories to cover:
1. **Goal Clarification**: What is the ultimate objective?
2. **Audience Definition**: Who will use/read/interact with this?
3. **Context Exploration**: What's the current state/environment?

**Example (Deep Dive - Technical Decision):**

**Round 1:**
```json
{
  "questions": [
    {
      "id": "goal",
      "prompt": "What is the primary goal of this API redesign?",
      "options": [
        {"id": "performance", "label": "Performance improvement"},
        {"id": "maintainability", "label": "Easier to maintain"},
        {"id": "developer-experience", "label": "Better developer experience"},
        {"id": "scalability", "label": "Scalability for growth"}
      ]
    },
    {
      "id": "current-pain",
      "prompt": "What is the main pain point with the current API?",
      "options": [
        {"id": "slow", "label": "Too slow (performance)"},
        {"id": "confusing", "label": "Confusing to use (DX)"},
        {"id": "inconsistent", "label": "Inconsistent patterns"},
        {"id": "hard-to-extend", "label": "Hard to add features"}
      ]
    },
    {
      "id": "api-consumers",
      "prompt": "Who are the API consumers?",
      "options": [
        {"id": "internal", "label": "Internal teams only"},
        {"id": "partners", "label": "Partner integrations"},
        {"id": "public", "label": "Public third-party developers"},
        {"id": "mixed", "label": "Mix of internal and external"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "goal": "developer-experience",
  "current-pain": "confusing",
  "api-consumers": "public"
}
```

**Analysis:**
- Goal: Developer experience (DX focus)
- Pain: Confusing API (clarity priority)
- Consumers: Public developers (need excellent docs)

**Round 2 Decision:** Need to ask about design preferences and breaking changes

**Round 2:**
```json
{
  "questions": [
    {
      "id": "design-style",
      "prompt": "What API design style do you prefer?",
      "options": [
        {"id": "rest", "label": "REST (resource-oriented)"},
        {"id": "graphql", "label": "GraphQL (query language)"},
        {"id": "rpc", "label": "RPC (action-oriented, gRPC)"},
        {"id": "undecided", "label": "Undecided (need recommendation)"}
      ]
    },
    {
      "id": "breaking-changes",
      "prompt": "Can we introduce breaking changes?",
      "options": [
        {"id": "yes", "label": "Yes (major version bump acceptable)"},
        {"id": "no", "label": "No (must maintain compatibility)"},
        {"id": "gradual", "label": "Gradual (deprecation path)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "design-style": "rest",
  "breaking-changes": "gradual"
}
```

**Final Context:**
- Goal: DX improvement for public developers
- Pain: Confusing API patterns
- Style: REST (stick with current paradigm)
- Approach: Gradual migration (deprecation strategy)

→ **Phase 2 (Blueprint)**: Design REST API v2 with improved DX, clear patterns, comprehensive docs, gradual deprecation path for v1

**Implementation Pattern:**

```python
def deep_dive_dialogue(prompt: str, language: str):
    # Round 1: Foundation
    round1_questions = [
        generate_goal_question(language),
        generate_audience_question(language),
        generate_context_question(language)
    ]
    
    round1_answers = await ask_questions(round1_questions)
    
    # Analyze completeness
    gaps = identify_remaining_gaps(round1_answers)
    
    if len(gaps) == 0:
        return {"complete": True, "context": round1_answers}
    
    # Round 2: Follow-up (2 questions)
    round2_questions = generate_followup_questions(gaps[:2], language)
    round2_answers = await ask_questions(round2_questions)
    
    complete_context = {**round1_answers, **round2_answers}
    
    return {"complete": True, "context": complete_context}
```

---

### Revolutionary Workflow (10-15 questions, 3-4 rounds)

**Decision Tree:**

```
Initial Prompt Received
  ↓
Extremely complex problem?
  └→ YES: Continue
      ↓
      Round 1: Big Picture (5 questions - Goal, Audience, Context, Complexity, Current State)
      ↓
      User answers Round 1
      ↓
      Round 2: Technical Depth (4 questions - Architecture, Dependencies, Constraints, Platform)
      ↓
      User answers Round 2
      ↓
      Round 3: Quality Assurance (3 questions - Criticality, Success Metrics, Timeline)
      ↓
      User answers Round 3
      ↓
      Analyze completeness
      ↓
      [Decision Point]
        ├→ Complete? → Phase 2
        └→ Need refinement?
            ↓
            Round 4: Refinement (2-3 questions - Edge cases, Specific requirements)
            ↓
            User answers Round 4
            ↓
            → Phase 2
```

**Round Structure:**

**Round 1: Big Picture (5 questions)**
- Primary goal/objective
- Current state/baseline
- Target state/vision
- Audience/stakeholders
- Complexity/scale

**Round 2: Technical Depth (4 questions)**
- Technical stack/platform
- Architecture/structure
- Dependencies/integrations
- Known constraints

**Round 3: Quality Assurance (3 questions)**
- Criticality/urgency
- Success metrics
- Timeline/resources

**Round 4: Refinement (2-3 questions)**
- Edge cases
- Specific requirements
- Output format preferences

**Example (Revolutionary - System Migration):**

See complete example in `/examples/revolutionary/multi-framework.md` → Phase 1 section

**Implementation Pattern:**

```python
def revolutionary_dialogue(prompt: str, language: str):
    context = {}
    
    # Round 1: Big Picture
    round1 = generate_big_picture_questions(5, language)
    context['round1'] = await ask_questions(round1)
    
    # Round 2: Technical Depth (based on Round 1 answers)
    round2 = generate_technical_questions(4, context['round1'], language)
    context['round2'] = await ask_questions(round2)
    
    # Round 3: Quality Assurance
    round3 = generate_quality_questions(3, context, language)
    context['round3'] = await ask_questions(round3)
    
    # Check if refinement needed
    gaps = identify_edge_cases(context)
    
    if len(gaps) > 0:
        # Round 4: Refinement
        round4 = generate_refinement_questions(gaps[:3], language)
        context['round4'] = await ask_questions(round4)
    
    return {"complete": True, "context": flatten(context)}
```

---

## Iteration Pattern (WHILE Loop)

**Concept:**
Keep asking follow-up questions UNTIL all critical information is gathered.

**Pattern:**

```
is_complete = False
round_number = 1
max_rounds = 4  # Safety limit

WHILE NOT is_complete AND round_number <= max_rounds:
    # Generate questions based on gaps
    questions = generate_questions_for_gaps(current_gaps, round_number)
    
    # Ask user
    answers = AskUserQuestion(questions)
    
    # Update context
    context.update(answers)
    
    # Check completeness
    current_gaps = identify_gaps(context)
    
    IF len(current_gaps) == 0:
        is_complete = True
    ELSE:
        round_number += 1

IF is_complete:
    → Proceed to Phase 2
ELSE:
    → Proceed with best available context (after max_rounds)
```

**Example:**

```python
def iterative_dialogue(prompt: str, optimization_level: str, language: str):
    context = {}
    round_number = 1
    max_rounds = get_max_rounds(optimization_level)  # Quick: 1, Deep: 2, Revolutionary: 4
    
    while round_number <= max_rounds:
        # Identify what's missing
        gaps = identify_gaps(context, optimization_level)
        
        if len(gaps) == 0:
            # We have everything we need
            break
        
        # Generate questions for current gaps
        questions = generate_questions(gaps, round_number, language)
        
        # Ask user
        answers = ask_questions(questions)
        
        # Update context
        context.update(answers)
        
        round_number += 1
    
    return context
```

---

## Error Handling Workflows

### Pattern 1: No Response from User

**Scenario:** User doesn't answer AskUserQuestion

**Workflow:**

```
AskUserQuestion Called
  ↓
Timeout (30-60 seconds)
  ↓
[Decision]
  ├→ Required question? → Remind user, re-ask once
  └→ Optional question? → Proceed with defaults or skip
```

**Implementation:**

```python
try:
    response = await ask_question_with_timeout(questions, timeout=60)
except TimeoutError:
    if is_required_question(questions):
        # Remind and retry once
        response = await ask_question_with_timeout(
            questions, 
            reminder="These questions help me understand your needs better.",
            timeout=60
        )
    else:
        # Use defaults
        response = apply_defaults(questions)
```

### Pattern 2: Unclear Answer

**Scenario:** User provides answer that doesn't make sense or is contradictory

**Workflow:**

```
User provides answer
  ↓
Validate answer
  ↓
Is answer clear?
  ├→ YES: Continue
  └→ NO: 
      ↓
      Generate clarification question
      ↓
      "I want to make sure I understand correctly..."
      ↓
      Re-ask with examples
```

**Example:**

```
User initially said: "goal" = "performance"
Later said: "I don't care about speed"

→ Contradiction detected

Clarification question:
"I notice you mentioned performance as a goal, but also said speed isn't important. 
Could you clarify what aspect of performance matters most?
- Response time (speed)
- Throughput (handle more requests)
- Resource efficiency (use less memory/CPU)
- Reliability (consistent performance)"
```

### Pattern 3: Follow-up Needed

**Scenario:** Answer reveals more complexity than expected

**Workflow:**

```
User answers Question 1
  ↓
Analyze answer
  ↓
Does answer reveal MORE complexity?
  └→ YES:
      ↓
      Generate follow-up question(s)
      ↓
      "Based on your answer, I need to understand..."
      ↓
      Ask follow-up
      ↓
      Continue
```

**Example:**

```
Question: "What's your current backend setup?"
User: "We have a monolith but also some microservices"

→ Complexity revealed: Hybrid architecture

Follow-up:
"You mentioned a hybrid setup. Could you clarify:
- What percentage is still in the monolith? (0-25%, 25-50%, 50-75%, 75-100%)
- Are you migrating to full microservices? (Yes, No, Undecided)
- Do the monolith and microservices share a database? (Yes, No, Partially)"
```

---

## Bilingual Support Workflow

### Language Detection

**Pattern:**

```
User message received
  ↓
Detect language
  ├→ English detected: Use English questions
  ├→ Vietnamese detected: Use Vietnamese questions
  └→ Mixed/Unclear: Default to English, but support both
```

**Implementation:**

```python
def detect_language(prompt: str) -> str:
    # Simple heuristic
    vietnamese_chars = ['ă', 'â', 'đ', 'ê', 'ô', 'ơ', 'ư', 'ạ', 'ả', 'ã', 'á', 'à']
    
    vn_char_count = sum(1 for char in prompt.lower() if char in vietnamese_chars)
    
    if vn_char_count > 3:
        return "vi"  # Vietnamese
    else:
        return "en"  # English (default)
```

### Bilingual Question Templates

**Pattern:** Maintain parallel question templates for EN and VN

**Example:**

```python
GOAL_QUESTION = {
    "en": {
        "id": "goal",
        "prompt": "What is your primary goal?",
        "options": [
            {"id": "learn", "label": "Learn a new skill"},
            {"id": "build", "label": "Build a project"},
            {"id": "solve", "label": "Solve a problem"}
        ]
    },
    "vi": {
        "id": "goal",
        "prompt": "Mục tiêu chính của bạn là gì?",
        "options": [
            {"id": "learn", "label": "Học kỹ năng mới"},
            {"id": "build", "label": "Xây dựng dự án"},
            {"id": "solve", "label": "Giải quyết vấn đề"}
        ]
    }
}

def get_goal_question(language: str):
    return GOAL_QUESTION.get(language, GOAL_QUESTION["en"])
```

---

## Best Practices

### DO:
- ✅ Ask the MINIMUM questions needed (don't over-ask)
- ✅ Group related questions in a single round
- ✅ Use clear, simple language
- ✅ Provide concrete options (not vague)
- ✅ Match user's language (EN/VN)
- ✅ Explain WHY you're asking (context helps)
- ✅ Use `allow_multiple` when multiple answers make sense
- ✅ Validate answers and ask for clarification if needed
- ✅ Show progress (Round 1/2/3) in longer dialogues

### DON'T:
- ❌ Ask obvious questions (if context is clear)
- ❌ Ask everything upfront (iterate based on answers)
- ❌ Use technical jargon without explanation
- ❌ Provide too many options (4-6 is ideal)
- ❌ Mix languages in a single question
- ❌ Ask redundant questions (if already answered)
- ❌ Assume - when in doubt, ask
- ❌ Skip validation (always check answer quality)

---

## Troubleshooting

### Issue: User frustrated with too many questions

**Solution:**
- Reduce question count (Quick Boost: 0-2, Deep Dive: 3-5 max)
- Ask only CRITICAL questions
- Explain value: "These questions ensure I give you exactly what you need"

### Issue: Questions feel robotic

**Solution:**
- Add natural language intro: "To tailor this perfectly for you, I need to understand..."
- Use conversational prompts: "What would work best for you?" vs "Select option"
- Show empathy: "I know you're busy - just 2 quick questions..."

### Issue: Answers don't fit options

**Solution:**
- Always include "Other (please specify)" option
- Use `allow_multiple` when appropriate
- Add follow-up for "Other" selections

### Issue: Lost context across rounds

**Solution:**
- Reference previous answers: "You mentioned X, so now I need to know Y..."
- Show progress: "Round 2 of 3: Based on your goals, let's clarify..."
- Summarize: "So far we have: [summary]. Now let's determine..."

---

## Reference

**For complete examples, see:**
- Quick Boost: `/examples/quick-boost/*.md`
- Deep Dive: `/examples/deep-dive/*.md`
- Revolutionary: `/examples/revolutionary/*.md`
- Vietnamese: `/examples/vietnamese/*.md`

**For question templates, see:**
- `question-library.md` - Complete question bank
- `askquestion-patterns.md` - Common patterns
- `vietnamese-guide.md` - Bilingual support

---

**Version:** 1.1.0  
**Last Updated:** Lyra AskUserQuestion Integration Phase
