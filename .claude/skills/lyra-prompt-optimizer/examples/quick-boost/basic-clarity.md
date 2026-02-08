# Quick Boost Example: Basic Clarity

## Optimization Level: ⚡ Quick Boost

**Time Required:** 5-10 minutes  
**Techniques Applied:** Task clarification, basic structure  
**Expected Impact:** +30-50% clarity

---

## Scenario

User has a vague, unclear prompt that needs basic clarification to be actionable.

---

## Phase 1: Interactive Dialogue (Quick Boost)

**Optimization Level Detected:** Quick Boost (0-2 critical questions only)

### When Questions Are Asked

Quick Boost typically skips dialogue for speed, BUT asks 1-2 critical questions if:
- Core information absolutely missing (e.g., no language specified for code)
- Output format unclear and impacts structure significantly
- Target platform unknown and affects technique selection

### Example Dialogue for "Write some code"

**Initial Prompt:** "Write some code."

**Critical Gaps Identified:**
- No programming language specified ❌
- No functionality described ❌

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "language",
      "prompt": "Which programming language? (Critical for syntax and patterns)",
      "options": [
        {"id": "python", "label": "Python"},
        {"id": "javascript", "label": "JavaScript/TypeScript"},
        {"id": "java", "label": "Java"},
        {"id": "go", "label": "Go"},
        {"id": "rust", "label": "Rust"},
        {"id": "other", "label": "Other"}
      ]
    },
    {
      "id": "functionality",
      "prompt": "What should the code do?",
      "options": [
        {"id": "data-processing", "label": "Data processing/transformation"},
        {"id": "api-integration", "label": "API integration"},
        {"id": "validation", "label": "Validation/verification"},
        {"id": "utility", "label": "Utility function"},
        {"id": "algorithm", "label": "Algorithm implementation"},
        {"id": "other", "label": "Other (please describe)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "language": "python",
  "functionality": "validation"
}
```

**Analysis:**
- Language: Python → Use Pythonic patterns
- Functionality: Validation → Add specific validation type
- Assumed: Email validation (common use case)

**Decision:** Proceed with email validation function (most common validation pattern)

### Vietnamese Example

**Initial Prompt:** "Viết code giúp tôi."

**Dialogue (Vietnamese):**

```json
{
  "questions": [
    {
      "id": "ngon-ngu",
      "prompt": "Bạn cần code bằng ngôn ngữ nào?",
      "options": [
        {"id": "python", "label": "Python"},
        {"id": "javascript", "label": "JavaScript"},
        {"id": "java", "label": "Java"}
      ]
    },
    {
      "id": "chuc-nang",
      "prompt": "Code cần làm gì?",
      "options": [
        {"id": "xu-ly-du-lieu", "label": "Xử lý dữ liệu"},
        {"id": "kiem-tra", "label": "Kiểm tra/validation"},
        {"id": "tinh-toan", "label": "Tính toán"}
      ]
    }
  ]
}
```

**User Response:** `{"ngon-ngu": "python", "chuc-nang": "kiem-tra"}`

**Analysis:** Python validation → Email validation example

---

## Example 1: Code Request

### Before Optimization

```
Write some code.
```

**Problems:**
- No language specified
- No functionality described
- No requirements
- No context

**Quality Scores:**
- Clarity: 10/100
- Specificity: 5/100
- Effectiveness: 15/100

---

### After Optimization (Quick Boost)

```
Write a Python function that validates email addresses.

Requirements:
- Accept string input
- Return True if valid email, False otherwise
- Check for: @ symbol, domain, TLD

Include docstring and example usage.
```

**Improvements Applied:**
1. ✅ Specified language (Python)
2. ✅ Defined functionality (email validation)
3. ✅ Listed requirements (validation rules)
4. ✅ Requested documentation (docstring, example)

**Quality Scores:**
- Clarity: 75/100 (+65)
- Specificity: 70/100 (+65)
- Effectiveness: 75/100 (+60)

**Token Count:**
- Before: 15 tokens
- After: 65 tokens
- Overhead: +50 tokens (justified for clarity)

---

## Example 2: Explanation Request

### Before Optimization

```
Explain React.
```

**Problems:**
- Too broad ("React" covers many concepts)
- No audience specified
- No depth indication
- No format specified

**Quality Scores:**
- Clarity: 20/100
- Specificity: 15/100
- Effectiveness: 25/100

---

### After Optimization (Quick Boost)

```
Explain React hooks to a beginner who knows basic JavaScript.

Cover:
- What hooks are
- Why they exist (vs class components)
- useState and useEffect examples

Format: Simple explanation with code examples
Length: ~300 words
```

**Improvements Applied:**
1. ✅ Narrowed scope (React hooks, not all of React)
2. ✅ Specified audience (beginner with JS knowledge)
3. ✅ Listed topics to cover
4. ✅ Defined format and length

**Quality Scores:**
- Clarity: 80/100 (+60)
- Specificity: 75/100 (+60)
- Effectiveness: 80/100 (+55)

**Token Count:**
- Before: 10 tokens
- After: 80 tokens
- Overhead: +70 tokens (high value per token)

---

## Example 3: Design Request

### Before Optimization

```
Design a database.
```

**Problems:**
- No domain/purpose
- No scale indicators
- No technology preferences
- No requirements

**Quality Scores:**
- Clarity: 15/100
- Specificity: 10/100
- Effectiveness: 20/100

---

### After Optimization (Quick Boost)

```
Design a PostgreSQL database schema for a blog platform.

Features to support:
- Users (authentication, profiles)
- Blog posts (title, content, author, timestamps)
- Comments (nested, user attribution)
- Tags (many-to-many with posts)

Provide: Table definitions with relationships
```

**Improvements Applied:**
1. ✅ Specified technology (PostgreSQL)
2. ✅ Defined purpose (blog platform)
3. ✅ Listed features to support
4. ✅ Requested specific output (table definitions)

**Quality Scores:**
- Clarity: 75/100 (+60)
- Specificity: 80/100 (+70)
- Effectiveness: 75/100 (+55)

**Token Count:**
- Before: 15 tokens
- After: 90 tokens
- Overhead: +75 tokens (necessary for complete specification)

---

## Example 4: Analysis Request

### Before Optimization

```
What's wrong with this code?
```

**Problems:**
- Code not provided
- No specific concerns mentioned
- No context (what should code do?)
- No priority (performance? bugs? style?)

**Quality Scores:**
- Clarity: 25/100
- Specificity: 20/100
- Effectiveness: 20/100

---

### After Optimization (Quick Boost)

```
Review this Python code for bugs and performance issues:

\`\`\`python
def get_users():
    users = []
    for i in range(1000):
        user = db.query(f"SELECT * FROM users WHERE id={i}")
        users.append(user)
    return users
\`\`\`

Expected behavior: Fetch all users from database

Focus on:
- Correctness (does it work?)
- Performance (any bottlenecks?)
- Security (any vulnerabilities?)
```

**Improvements Applied:**
1. ✅ Included the code
2. ✅ Specified review focus areas
3. ✅ Provided expected behavior
4. ✅ Clear review priorities

**Quality Scores:**
- Clarity: 85/100 (+60)
- Specificity: 85/100 (+65)
- Effectiveness: 80/100 (+60)

**Token Count:**
- Before: 20 tokens
- After: 120 tokens
- Overhead: +100 tokens (includes code, so justified)

---

## Example 5: Decision Request

### Before Optimization

```
Which framework should I use?
```

**Problems:**
- No domain (web? mobile? backend?)
- No context (project requirements)
- No constraints (team, time, budget)
- No comparison criteria

**Quality Scores:**
- Clarity: 20/100
- Specificity: 15/100
- Effectiveness: 20/100

---

### After Optimization (Quick Boost)

```
Recommend a frontend framework for a single-page web application.

Context:
- Building a dashboard (lots of data visualization)
- Team knows JavaScript well
- Need good performance and ecosystem

Compare: React, Vue, Angular

Provide: Pros/cons for each, recommendation with reasoning
```

**Improvements Applied:**
1. ✅ Specified domain (frontend, SPA)
2. ✅ Provided context (dashboard, team skills)
3. ✅ Listed frameworks to compare
4. ✅ Defined output format

**Quality Scores:**
- Clarity: 80/100 (+60)
- Specificity: 75/100 (+60)
- Effectiveness: 80/100 (+60)

**Token Count:**
- Before: 20 tokens
- After: 95 tokens
- Overhead: +75 tokens (worthwhile for decision quality)

---

## Pattern Recognition

### Common Vague Patterns

| Vague Prompt | Clarified Version |
|-------------|------------------|
| "Write code" | "Write a Python function that [specific task]" |
| "Explain X" | "Explain X to [audience] covering [topics]" |
| "Design Y" | "Design Y for [purpose] with [requirements]" |
| "Review this" | "Review this for [criteria] with focus on [areas]" |
| "Which should I use?" | "Compare [options] for [use case] given [constraints]" |

### Quick Boost Formula

```
Vague Prompt + [WHO/WHAT/WHY/HOW] = Clear Prompt

WHO: Who is the audience?
WHAT: What specifically do you need?
WHY: What's the purpose/context?
HOW: How should output be formatted?
```

---

## Implementation Steps

### Step 1: Identify Missing Information

Ask yourself:
- [ ] Is the task clear and specific?
- [ ] Is the technology/language specified?
- [ ] Are requirements listed?
- [ ] Is output format defined?

### Step 2: Add Essential Clarifications

Minimum additions for Quick Boost:
- **Language/Technology:** "Python", "React", "PostgreSQL"
- **Specific task:** "validate email" not just "process input"
- **Basic requirements:** 2-3 must-haves
- **Output format:** "code with examples", "explanation with bullets"

### Step 3: Keep It Simple

**Don't add in Quick Boost:**
- ❌ Complex reasoning frameworks
- ❌ Extensive examples
- ❌ Meta-cognitive validation
- ❌ Advanced constraints

**Do add:**
- ✅ Core clarifications only
- ✅ Minimal necessary context
- ✅ 2-3 key requirements
- ✅ Simple output format

### Step 4: Validate Improvement

**Check:**
- [ ] Can someone else understand what's needed?
- [ ] Are the 5 W's answered (Who, What, When, Where, Why)?
- [ ] Is it specific enough to get useful output?
- [ ] Did you stay under 100-150 tokens added?

---

## Time Budget Breakdown

**Total time: 5-10 minutes**

- Read original prompt: 30 seconds
- Identify missing information: 2 minutes
- Add clarifications: 3-5 minutes
- Quick validation: 1-2 minutes

---

## Success Metrics

### Minimum Acceptable (Quick Boost)

- **Clarity:** 70-85
- **Specificity:** 70-80
- **Effectiveness:** 70-85
- **Token Efficiency:** 70-85

### Typical Improvements

- **Clarity:** +50-70 points
- **Specificity:** +55-70 points
- **Effectiveness:** +50-65 points
- **Time investment:** 5-10 minutes
- **Token overhead:** +50-150 tokens

---

## When Quick Boost Is Enough

**Use Quick Boost when:**
- ✅ Task is relatively simple
- ✅ Time is limited
- ✅ Budget is tight
- ✅ "Good enough" quality acceptable

**Upgrade to Deep Dive when:**
- ❌ Task is complex or multi-step
- ❌ Quality is critical
- ❌ Initial clarification insufficient

---

## Vietnamese Quick Reference

### Công Thức Quick Boost

```
Prompt Mơ Hồ + [5W1H] = Prompt Rõ Ràng

WHAT (Cái gì): Làm gì cụ thể?
WHO (Ai): Cho đối tượng nào?
WHY (Tại sao): Mục đích gì?
HOW (Như thế nào): Format đầu ra?
WHEN (Khi nào): Thời gian/điều kiện?
WHERE (Ở đâu): Platform/môi trường?
```

### Checklist Nhanh

- [ ] **Ngôn ngữ/Công nghệ:** Python? React? SQL?
- [ ] **Nhiệm vụ cụ thể:** Làm gì chính xác?
- [ ] **Yêu cầu cơ bản:** 2-3 điều bắt buộc
- [ ] **Format output:** Code? Giải thích? Bảng?

### Ví Dụ

**Trước:** "Viết code"  
**Sau:** "Viết hàm Python kiểm tra email hợp lệ. Yêu cầu: có @, domain, TLD. Kèm docstring."

**Cải thiện:** Rõ ràng +65, Cụ thể +65, Hiệu quả +60

---

## Summary

**Quick Boost Philosophy:** Maximum clarity improvement with minimum effort.

**Core Technique:** Answer the 5 W's (Who, What, Why, Where, When) + How.

**Best For:** Simple tasks, time constraints, iterative refinement.

**Typical Results:**
- **Time:** 5-10 minutes
- **Token Overhead:** +50-150 tokens
- **Quality Gain:** +50-70 points across metrics
- **Cost:** Very low, high ROI

**Next Level:** If Quick Boost results insufficient, upgrade to Deep Dive with reasoning frameworks.

---

**Related Examples:**
- `output-format.md` - Focus on format specification
- `role-assignment.md` - Focus on expert role assignment
- `../deep-dive/` - More comprehensive optimization examples

**Related References:**
- `../../references/optimization-toolkit.md` - Full technique catalog
- `../../references/anti-patterns.md` - Common mistakes to avoid
