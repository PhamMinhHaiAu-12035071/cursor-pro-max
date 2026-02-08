# AskUserQuestion Tool Patterns

Common patterns, best practices, and reusable templates for effective interactive dialogue with the AskUserQuestion tool.

---

## Overview

This reference provides **proven patterns** for:
- Question structuring
- Multi-round dialogues
- Error handling
- Bilingual support
- Conditional logic
- User experience optimization

---

## Pattern 1: Single-Round Quick Clarification

**Use When:** Missing ONE critical piece of information

**Structure:**
```
User prompt → Identify gap → Ask 1 question → Proceed
```

**Example:**

```json
{
  "questions": [
    {
      "id": "missing-info",
      "prompt": "Quick clarification needed - [specific gap]?",
      "options": [
        {"id": "option-1", "label": "..."},
        {"id": "option-2", "label": "..."},
        {"id": "option-3", "label": "..."}
      ]
    }
  ]
}
```

**Real Example:**

```
User: "Write a function to sort data."

Gap: What data structure?

AskUserQuestion:
{
  "questions": [{
    "id": "data-structure",
    "prompt": "What type of data structure should the function sort?",
    "options": [
      {"id": "array", "label": "Array/List"},
      {"id": "object", "label": "Object/Dictionary (by value)"},
      {"id": "custom", "label": "Custom data structure"}
    ]
  }]
}
```

---

## Pattern 2: Parallel Information Gathering

**Use When:** Need multiple independent pieces of information

**Structure:**
```
Ask 2-5 unrelated questions simultaneously → Process all answers together
```

**Key:** Questions don't depend on each other

**Example:**

```json
{
  "questions": [
    {
      "id": "language",
      "prompt": "Which programming language?",
      "options": [...]
    },
    {
      "id": "output-format",
      "prompt": "What output format?",
      "options": [...]
    },
    {
      "id": "audience",
      "prompt": "Who is this for?",
      "options": [...]
    }
  ]
}
```

**Advantage:** Efficient - get multiple answers in one interaction

---

## Pattern 3: Sequential Deep Dive

**Use When:** Later questions depend on earlier answers

**Structure:**
```
Round 1 → Analyze → Round 2 (based on Round 1) → Analyze → Proceed
```

**Example:**

```
Round 1:
Q: "What is your goal?" 
A: "Optimize performance"

Round 2 (based on "performance"):
Q: "Which performance metric matters most?"
Options: Speed, Memory, Bandwidth, Cost
```

**Implementation:**

```python
# Round 1
round1_answer = ask_question({"id": "goal", ...})

# Round 2 (conditional based on Round 1)
if round1_answer["goal"] == "optimize-performance":
    round2_question = {
        "id": "performance-metric",
        "prompt": "Which performance metric matters most?",
        "options": [...]
    }
    round2_answer = ask_question(round2_question)
```

---

## Pattern 4: Exploration Tree

**Use When:** Different answer paths lead to different question sets

**Structure:**
```
Question 1
  ├→ Answer A → Questions X, Y
  └→ Answer B → Questions W, Z
```

**Example:**

```
Q1: "What are you building?"
  ├→ "Web app" → Q2: "Frontend or backend?" Q3: "Framework?"
  └→ "CLI tool" → Q2: "Language?" Q3: "Package manager?"
```

**Decision Tree:**

```python
initial_answer = ask_question({"id": "project-type", ...})

if initial_answer == "web-app":
    follow_ups = [
        {"id": "stack", "prompt": "Frontend or backend?", ...},
        {"id": "framework", "prompt": "Framework?", ...}
    ]
elif initial_answer == "cli-tool":
    follow_ups = [
        {"id": "language", "prompt": "Programming language?", ...},
        {"id": "package", "prompt": "Package manager?", ...}
    ]

ask_questions(follow_ups)
```

---

## Pattern 5: Iterative Refinement

**Use When:** Keep asking until all information is gathered

**Structure:**
```
WHILE gaps exist AND round < max_rounds:
    Ask questions for current gaps
    Update context
    Re-evaluate gaps
```

**Example:**

```python
max_rounds = 3
round = 1
context = {}

while round <= max_rounds:
    gaps = identify_gaps(context)
    
    if len(gaps) == 0:
        break  # All info gathered
    
    questions = generate_questions_for_gaps(gaps)
    answers = ask_questions(questions)
    context.update(answers)
    
    round += 1
```

**Real Scenario:**

```
Round 1: "What's your goal?" → "Build a web app"
Gaps remaining: Framework, scale, hosting

Round 2: "Which framework?" → "React"
Gaps remaining: Scale, hosting, state management

Round 3: "What scale?" → "Medium (1K-100K users)"
Gaps remaining: Hosting, state management

Round 4: "Hosting preference?" → "Vercel"
Gaps remaining: State management

Continue until no critical gaps OR hit max_rounds
```

---

## Pattern 6: Validation & Clarification

**Use When:** User's answer is unclear or contradictory

**Structure:**
```
User answers → Validate → If unclear, ask clarification → Proceed
```

**Example:**

```
User initial: "I want it to be fast but don't care about performance."

Contradiction detected!

Clarification question:
{
  "id": "clarify-performance",
  "prompt": "I want to make sure I understand - you mentioned both 'fast' and 'don't care about performance'. Could you clarify what aspect matters?",
  "options": [
    {"id": "user-perceived-speed", "label": "User-perceived speed (feels responsive)"},
    {"id": "actual-processing", "label": "Actual processing speed (execution time)"},
    {"id": "not-priority", "label": "Speed is not the priority"}
  ]
}
```

**Pattern:**

```python
def validate_answer(answer):
    if is_contradictory(answer):
        return ask_clarification(answer)
    if is_vague(answer):
        return ask_for_specifics(answer)
    return answer  # Valid
```

---

## Pattern 7: Progressive Disclosure

**Use When:** Don't overwhelm user with all questions upfront

**Structure:**
```
Start simple → If needed, ask more → Reveal complexity gradually
```

**Example:**

```
Level 1 (Simple):
Q: "What do you want to build?"
A: "A website"

Level 2 (More specific):
Q: "What type of website?"
A: "E-commerce"

Level 3 (Technical):
Q: "Which e-commerce platform?"
A: "Custom (not Shopify/WooCommerce)"

Level 4 (Very specific):
Q: "Payment gateway? Inventory system? Shipping integration?"
```

**Principle:** Only ask detailed questions if user needs that level of customization

---

## Pattern 8: Multi-Select for Related Options

**Use When:** User might have multiple valid answers

**Structure:**
```json
{
  "id": "multi-choice",
  "prompt": "Select all that apply:",
  "allow_multiple": true,  // KEY
  "options": [...]
}
```

**Example:**

```json
{
  "id": "optimization-goals",
  "prompt": "Which aspects do you want to optimize?",
  "allow_multiple": true,
  "options": [
    {"id": "speed", "label": "Speed"},
    {"id": "memory", "label": "Memory usage"},
    {"id": "cost", "label": "Infrastructure cost"},
    {"id": "developer-experience", "label": "Developer experience"}
  ]
}
```

**When to Use:**
- Priorities (multiple things can be important)
- Tech stack (polyglot is common)
- Constraints (multiple constraints exist)
- Success metrics (multiple metrics matter)

**When NOT to Use:**
- Mutually exclusive choices (e.g., "Are you a beginner or expert?")
- Single critical decision (e.g., "Which language?")

---

## Pattern 9: Bilingual Language Matching

**Use When:** Supporting multiple languages

**Structure:**
```
Detect user language → Use matching question template
```

**Implementation:**

```python
def detect_language(user_prompt):
    vietnamese_indicators = ['tôi', 'bạn', 'là', 'của', 'có']
    if any(word in user_prompt.lower() for word in vietnamese_indicators):
        return "vi"
    return "en"

def get_question(question_id, language):
    templates = {
        "goal": {
            "en": {"prompt": "What is your goal?", ...},
            "vi": {"prompt": "Mục tiêu của bạn là gì?", ...}
        }
    }
    return templates[question_id][language]

# Usage
language = detect_language(user_prompt)
question = get_question("goal", language)
```

**Best Practice:**
- Maintain parallel EN/VN templates
- Consistent option IDs across languages
- Natural translations (not literal)

---

## Pattern 10: Contextual Option Generation

**Use When:** Options should be dynamically generated based on context

**Structure:**
```
Analyze context → Generate relevant options → Ask question
```

**Example:**

```python
def generate_framework_options(language, project_type):
    if language == "javascript":
        if project_type == "web":
            return [
                {"id": "react", "label": "React"},
                {"id": "vue", "label": "Vue.js"},
                {"id": "angular", "label": "Angular"},
                {"id": "svelte", "label": "Svelte"}
            ]
        elif project_type == "mobile":
            return [
                {"id": "react-native", "label": "React Native"},
                {"id": "ionic", "label": "Ionic"},
                {"id": "nativescript", "label": "NativeScript"}
            ]
    elif language == "python":
        if project_type == "web":
            return [
                {"id": "django", "label": "Django"},
                {"id": "flask", "label": "Flask"},
                {"id": "fastapi", "label": "FastAPI"}
            ]

# Usage
language_answer = ask_question({"id": "language", ...})
project_answer = ask_question({"id": "project-type", ...})

framework_options = generate_framework_options(
    language_answer["language"],
    project_answer["project-type"]
)

framework_question = {
    "id": "framework",
    "prompt": "Which framework?",
    "options": framework_options
}
```

---

## Pattern 11: Default Values with Override

**Use When:** You have a good default but want to confirm

**Structure:**
```
Make intelligent default assumption → Confirm with user → Override if needed
```

**Example:**

```
Context: User's codebase is 90% Python

Default assumption: Python for new code

Confirmation question:
{
  "id": "confirm-language",
  "prompt": "I see your project is primarily Python. Continue with Python?",
  "options": [
    {"id": "yes", "label": "Yes, use Python"},
    {"id": "no-other", "label": "No, use a different language"}
  ]
}

If "no-other" → Ask follow-up: "Which language?"
```

**Pattern:**

```python
def get_language_with_default(codebase):
    dominant_language = analyze_codebase_languages(codebase)
    
    confirmation = ask_question({
        "id": "confirm-language",
        "prompt": f"I see your project uses {dominant_language}. Continue with {dominant_language}?",
        "options": [
            {"id": "yes", "label": f"Yes, {dominant_language}"},
            {"id": "no", "label": "No, different language"}
        ]
    })
    
    if confirmation == "yes":
        return dominant_language
    else:
        return ask_question({"id": "language", "prompt": "Which language?", ...})
```

---

## Pattern 12: Error Recovery

**Use When:** User provides invalid/empty/unclear answer

**Structure:**
```
Ask question → Validate → If invalid, retry with clarification → If still invalid, use default
```

**Example:**

```python
def ask_with_retry(question, max_retries=2):
    for attempt in range(max_retries):
        answer = ask_question(question)
        
        if is_valid(answer):
            return answer
        
        if attempt < max_retries - 1:
            # Retry with clarification
            question["prompt"] = f"Could you clarify: {question['prompt']}"
        else:
            # Use default
            return get_default_answer(question)
```

**Retry Strategies:**
1. **First attempt:** Normal question
2. **Second attempt:** Add clarification/examples
3. **Third attempt:** Use intelligent default + note to user

---

## Best Practices Summary

### DO:

✅ **Start simple, add complexity only if needed**
```
Basic question → If answer reveals complexity → Ask follow-ups
```

✅ **Batch independent questions together**
```json
{
  "questions": [
    {"id": "q1", ...},  // Independent
    {"id": "q2", ...},  // Independent
    {"id": "q3", ...}   // Independent
  ]
}
```

✅ **Provide clear, concrete options**
```
Good: "React (component-based, popular)"
Bad: "Modern framework"
```

✅ **Always include "Other" option**
```json
{
  "options": [
    ...,
    {"id": "other", "label": "Other (please specify)"}
  ]
}
```

✅ **Match user's language**
```
User speaks Vietnamese → Ask in Vietnamese
```

✅ **Explain WHY you're asking**
```
"To tailor the solution for your use case, I need to understand..."
```

✅ **Use allow_multiple when appropriate**
```json
{
  "id": "priorities",
  "allow_multiple": true,  // Multiple priorities OK
  ...
}
```

### DON'T:

❌ **Don't ask if context is already clear**
```
User: "Write a Python function to parse JSON"
Context is clear → Don't ask "Which language?"
```

❌ **Don't overwhelm with too many options**
```
Bad: 15 options
Good: 4-6 options + "Other"
```

❌ **Don't ask redundant questions**
```
Already asked "What framework?" → Don't ask "React or Vue?"
```

❌ **Don't use technical jargon without explanation**
```
Bad: "REST, GraphQL, or gRPC?"
Good: "REST (traditional), GraphQL (flexible queries), or gRPC (high performance)?"
```

❌ **Don't mix languages in a single question**
```
Bad: "Bạn muốn use React or Vue?"
Good: "Bạn muốn dùng React hay Vue?" (all Vietnamese)
```

❌ **Don't ask questions you won't use**
```
Only ask if the answer will actually change the output
```

---

## Common Anti-Patterns to Avoid

### Anti-Pattern 1: Question Overload

**Problem:**
```json
{
  "questions": [
    // 20 questions at once
  ]
}
```

**Solution:** Break into rounds (max 5 questions per round)

### Anti-Pattern 2: Vague Options

**Problem:**
```json
{
  "options": [
    {"id": "fast", "label": "Fast"},
    {"id": "good", "label": "Good"},
    {"id": "cheap", "label": "Cheap"}
  ]
}
```

**Solution:** Be specific and provide context
```json
{
  "options": [
    {"id": "fast", "label": "Speed (< 100ms response time)"},
    {"id": "good", "label": "Quality (robust, well-tested)"},
    {"id": "cheap", "label": "Cost-effective (minimize infrastructure)"}
  ]
}
```

### Anti-Pattern 3: False Binary

**Problem:**
```json
{
  "prompt": "Do you want it fast or cheap?",  // False dichotomy
  "options": [
    {"id": "fast", "label": "Fast"},
    {"id": "cheap", "label": "Cheap"}
  ]
}
```

**Solution:** Allow for nuance
```json
{
  "prompt": "What's the priority?",
  "options": [
    {"id": "speed", "label": "Speed (optimize for performance)"},
    {"id": "cost", "label": "Cost (optimize for budget)"},
    {"id": "balanced", "label": "Balanced (both important)"}
  ]
}
```

### Anti-Pattern 4: Leading Questions

**Problem:**
```json
{
  "prompt": "You want clean, maintainable code, right?",  // Leading
  "options": [...]
}
```

**Solution:** Neutral phrasing
```json
{
  "prompt": "What's your priority for this code?",
  "options": [
    {"id": "clean", "label": "Clean and maintainable"},
    {"id": "fast", "label": "Fast to write (prototype)"},
    {"id": "performant", "label": "Highly performant"}
  ]
}
```

### Anti-Pattern 5: Assuming Context

**Problem:**
```
User: "Help me with my API"
Assistant: *Proceeds without asking what kind of API, what help is needed*
```

**Solution:** Ask clarifying questions first

---

## Testing Your Questions

### Checklist:

- [ ] Does the question have a clear, specific prompt?
- [ ] Are there 4-6 options (not too many, not too few)?
- [ ] Is there an "Other" option for unexpected answers?
- [ ] Are option labels clear and unambiguous?
- [ ] Would a non-expert understand the question?
- [ ] Will the answer actually change the output?
- [ ] Is the language consistent (all EN or all VN)?
- [ ] Are options mutually exclusive (if single-select)?
- [ ] Or do options allow overlap (if multi-select)?

---

## Quick Reference

| Pattern | Use When | Structure |
|---------|----------|-----------|
| Single-Round | One missing piece | Ask 1 → Proceed |
| Parallel Gathering | Multiple independent gaps | Ask 2-5 simultaneously |
| Sequential Deep Dive | Questions depend on previous answers | Round 1 → Round 2 → ... |
| Exploration Tree | Different paths need different questions | Branch based on answers |
| Iterative Refinement | Keep going until complete | WHILE gaps exist |
| Validation | Answer is unclear | Ask → Validate → Clarify |
| Progressive Disclosure | Don't overwhelm | Simple → Detailed gradually |
| Multi-Select | Multiple valid answers | `allow_multiple: true` |
| Bilingual | Support EN/VN | Detect language → Match |
| Contextual Options | Dynamic based on context | Generate options on the fly |
| Default with Override | Good default available | Assume → Confirm → Override |
| Error Recovery | Invalid answer | Retry → Default |

---

## Examples by Optimization Level

### Quick Boost Examples
- See `/examples/quick-boost/basic-clarity.md`
- Pattern: Single-Round or Parallel Gathering (0-2 questions)

### Deep Dive Examples
- See `/examples/deep-dive/chain-of-thought.md`
- Pattern: Sequential Deep Dive (3-5 questions, 2 rounds)

### Revolutionary Examples
- See `/examples/revolutionary/graph-of-thoughts.md`
- Pattern: Iterative Refinement (10-15 questions, 3-4 rounds)

---

## Reference

**Related Documentation:**
- `dialogue-workflows.md` - Complete workflow patterns
- `question-library.md` - Ready-to-use question templates
- `core-concepts.md` - Lyra's Dialogue Engine fundamentals
- `vietnamese-guide.md` - Bilingual support patterns

**Version:** 1.1.0  
**Last Updated:** Lyra AskUserQuestion Integration Phase
