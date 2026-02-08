# Optimization Toolkit Reference

## Overview

This document provides a comprehensive catalog of prompt optimization techniques organized into three layers:

1. **Foundation Layer** - Essential techniques for all prompts
2. **Advanced Reasoning Layer** - Sophisticated frameworks and patterns
3. **Meta-Cognitive & Fidelity Layer** - Quality assurance and refinement

Each technique includes implementation patterns, use cases, and examples.

---

## Foundation Layer

### F1: Role Assignment

**What it is:** Assigning the AI a specific expert role to activate relevant knowledge and behavior patterns.

**When to use:**
- Need domain expertise
- Require specific perspective
- Want consistent voice/style

**Implementation:**
```markdown
You are [specific expert role with clear expertise].

[Context about your expertise]

Task: [Clear task description]
```

**Examples:**

**Generic:**
```
Explain machine learning.
```

**Optimized:**
```
You are a senior ML engineer with 10 years of experience teaching beginners.

Explain machine learning concepts using simple analogies and avoid jargon.
```

**Impact:** +20-30% response relevance, +15% accuracy for domain-specific tasks

---

### F2: Task Decomposition

**What it is:** Breaking complex tasks into smaller, manageable subtasks.

**When to use:**
- Complex multi-step problems
- Tasks with dependencies
- Need clear progress tracking

**Implementation:**
```markdown
Task: [Main task]

Break this into subtasks:
1. [Subtask 1]
2. [Subtask 2]
3. [Subtask 3]

For each subtask:
- Input required
- Expected output
- Success criteria
```

**Examples:**

**Vague:**
```
Build a user authentication system.
```

**Decomposed:**
```
Build a user authentication system.

Subtasks:
1. Design database schema (users, sessions, tokens)
2. Implement registration endpoint with validation
3. Implement login with JWT generation
4. Implement middleware for protected routes
5. Add password reset flow

For each subtask, provide:
- Code implementation
- Security considerations
- Test cases
```

**Impact:** +40-60% completion rate, +25% output completeness

---

### F3: Format Specification

**What it is:** Explicitly defining the desired output format, structure, and style.

**When to use:**
- Need consistent output structure
- Integrating with code/systems
- Specific format required (JSON, table, etc.)

**Implementation:**
```markdown
[Task description]

Output format:
- Structure: [JSON/Table/List/Prose]
- Required fields: [List]
- Constraints: [Length, style, etc.]

Example output:
[Show example structure]
```

**Examples:**

**Unformatted:**
```
List Python best practices.
```

**Formatted:**
```
List Python best practices.

Output format:
| Practice | Description | Example |
|----------|-------------|---------|
| [Name] | [1 sentence] | [Code snippet] |

Requirements:
- Exactly 10 practices
- Code examples must be executable
- Order by importance (most important first)
```

**Impact:** +50-80% output usability, +30% consistency

---

### F4: Context Provision

**What it is:** Providing all necessary background information, constraints, and requirements upfront.

**When to use:**
- Domain-specific tasks
- Tasks with constraints
- Need accurate, contextual responses

**Implementation:**
```markdown
Context:
- [Background info]
- [Current state]
- [Constraints]
- [Requirements]

Given this context, [task].
```

**Examples:**

**No context:**
```
Recommend a database.
```

**With context:**
```
Context:
- Building a social media app
- Expected: 1M users, 10M posts
- Read-heavy (90% reads, 10% writes)
- Need real-time features (likes, comments)
- Team expertise: PostgreSQL, Redis
- Budget: $500/month
- Hosting: AWS

Given this context, recommend the best database solution.
Explain your reasoning and include cost estimation.
```

**Impact:** +35-50% answer relevance, +40% actionability

---

### F5: Constraint Definition

**What it is:** Explicitly stating boundaries, limitations, and requirements.

**When to use:**
- Need to avoid certain approaches
- Have technical/business constraints
- Must comply with standards

**Implementation:**
```markdown
[Task description]

Constraints:
- Must: [Required elements]
- Must not: [Forbidden elements]
- Limits: [Boundaries]
- Standards: [Compliance requirements]
```

**Examples:**

**Unconstrained:**
```
Create a REST API for user management.
```

**Constrained:**
```
Create a REST API for user management.

Constraints:
- Must: Use Express.js, follow REST conventions, include OpenAPI docs
- Must not: Use any ORM, store passwords in plain text, use deprecated methods
- Limits: Max 10 endpoints, response time < 200ms, support 1000 req/sec
- Standards: Follow OWASP security guidelines, use JWT (RFC 7519)

Implementation must explain how each constraint is satisfied.
```

**Impact:** +60-80% constraint adherence, +25% solution quality

---

### F6: Example Provision (Few-Shot Learning)

**What it is:** Providing input-output examples to demonstrate desired behavior.

**When to use:**
- Complex or unusual formats
- Specific style required
- Pattern-based tasks

**Implementation:**
```markdown
[Task description]

Examples:

Input 1: [Example input]
Output 1: [Example output]

Input 2: [Example input]
Output 2: [Example output]

Now apply the same pattern to:
Input: [Your actual input]
Output: [Generate this]
```

**Examples:**

**No examples:**
```
Convert function names to snake_case.
```

**With examples:**
```
Convert JavaScript function names to Python snake_case.

Examples:

Input: getUserProfile()
Output: get_user_profile()

Input: calculateTotalPrice()
Output: calculate_total_price()

Input: isValidEmailAddress()
Output: is_valid_email_address()

Now convert:
- handleUserAuthentication()
- fetchDataFromAPI()
- validateFormInput()
```

**Impact:** +45-70% format accuracy, +30% consistency

---

## Advanced Reasoning Layer

### A1: Chain-of-Thought (CoT)

**See:** `reasoning-frameworks.md` for full details

**Quick Summary:** Step-by-step reasoning for linear problems.

**Pattern:**
```markdown
Think step-by-step:
1. [Step 1]
2. [Step 2]
3. [Step 3]
```

---

### A2: Tree-of-Thoughts (ToT)

**See:** `reasoning-frameworks.md` for full details

**Quick Summary:** Explore multiple solution branches, compare, select best.

**Pattern:**
```markdown
Explore these approaches:
- Branch 1: [Approach]
- Branch 2: [Approach]
- Branch 3: [Approach]

Evaluate and select best.
```

---

### A3: Graph-of-Thoughts (GoT)

**See:** `reasoning-frameworks.md` for full details

**Quick Summary:** Network reasoning with interconnections and refinement loops.

**Pattern:**
```markdown
Build thought network:
- Node A ↔ Node B
- Node B → Node C
- Node C → Node A (feedback)

Analyze emergent properties.
```

---

### A4: Self-Consistency

**What it is:** Generating multiple reasoning paths and selecting the most consistent answer.

**When to use:**
- Need high confidence
- Complex reasoning required
- Stakes are high

**Implementation:**
```markdown
[Task description]

Generate 3 independent reasoning paths:

Path 1: [Reason from perspective A]
Path 2: [Reason from perspective B]
Path 3: [Reason from perspective C]

Compare conclusions:
- If all agree: High confidence
- If 2 agree: Moderate confidence, investigate disagreement
- If all differ: Low confidence, re-examine problem

Final answer: Most consistent conclusion with confidence level.
```

**Examples:**

**Basic:**
```
Solve this logic puzzle.
```

**Self-Consistency:**
```
Solve this logic puzzle: [Puzzle description]

Approach 1: Solve by elimination
- [Step-by-step elimination]
- Conclusion: [Answer]

Approach 2: Solve by constraint satisfaction
- [Step-by-step constraints]
- Conclusion: [Answer]

Approach 3: Solve by pattern matching
- [Step-by-step patterns]
- Conclusion: [Answer]

Compare answers from all 3 approaches.
If consistent: Report answer with high confidence.
If inconsistent: Identify error in reasoning.
```

**Impact:** +20-35% accuracy on complex problems, +50-100% token overhead

---

### A5: Multi-Perspective Analysis

**What it is:** Analyzing a problem from multiple viewpoints to achieve comprehensive understanding.

**When to use:**
- Multifaceted problems
- Need to consider stakeholder needs
- Avoiding bias

**Implementation:**
```markdown
[Task description]

Analyze from these perspectives:

Perspective 1: [Role/Viewpoint]
- Concerns: [What matters to this perspective]
- Analysis: [Specific evaluation]

Perspective 2: [Role/Viewpoint]
- Concerns: [What matters to this perspective]
- Analysis: [Specific evaluation]

Perspective 3: [Role/Viewpoint]
- Concerns: [What matters to this perspective]
- Analysis: [Specific evaluation]

Synthesis: Integrate all perspectives into balanced solution.
```

**Examples:**

**Single perspective:**
```
Should we migrate to microservices?
```

**Multi-perspective:**
```
Evaluate migrating to microservices.

Perspective 1: Developer Experience
- Concerns: Code organization, debugging complexity, local development
- Analysis: [Impact on developers]

Perspective 2: Operations/DevOps
- Concerns: Deployment, monitoring, scaling, infrastructure
- Analysis: [Impact on operations]

Perspective 3: Business/Product
- Concerns: Time to market, feature velocity, costs
- Analysis: [Impact on business]

Perspective 4: End Users
- Concerns: Performance, reliability, feature quality
- Analysis: [Impact on users]

Synthesis: Weigh all perspectives and recommend best path forward.
```

**Impact:** +30-50% decision quality, +25% stakeholder satisfaction

---

### A6: Constraint Optimization

**What it is:** Optimizing for specific criteria while respecting hard constraints.

**When to use:**
- Limited resources (tokens, time, cost)
- Must satisfy requirements
- Need trade-off analysis

**Implementation:**
```markdown
[Task description]

Hard Constraints (MUST satisfy):
- [Constraint 1]
- [Constraint 2]

Optimization Criteria (maximize/minimize):
- [Criterion 1]: [Target]
- [Criterion 2]: [Target]

Find optimal solution that:
1. Satisfies all hard constraints
2. Optimizes for criteria in order of priority

Show constraint validation and optimization trade-offs.
```

**Examples:**

**Unconstrained:**
```
Design a caching strategy.
```

**Constraint-Optimized:**
```
Design a caching strategy for our API.

Hard Constraints:
- Must: Support distributed cache (multiple servers)
- Must: Invalidate on data updates (consistency)
- Must: Respect data privacy (no PII in cache)
- Budget: $200/month maximum

Optimization Criteria (in priority order):
1. Maximize cache hit rate (target: >80%)
2. Minimize latency (target: <50ms p95)
3. Minimize complexity (junior devs must maintain)

Propose solution that satisfies constraints and optimizes criteria.
Include trade-off analysis.
```

**Impact:** +40-60% solution fitness, +35% constraint compliance

---

## Meta-Cognitive & Fidelity Layer

### M1: Self-Correction Loop

**What it is:** The model reviews its own output and identifies/corrects errors.

**When to use:**
- High accuracy required
- Complex reasoning prone to errors
- Multi-step processes

**Implementation:**
```markdown
[Task description]

Step 1: Generate initial response

Step 2: Self-review
- Check for logical errors
- Verify calculations
- Validate assumptions
- Identify weak points

Step 3: Correction
- Fix identified errors
- Strengthen weak reasoning
- Verify improvements

Output: Corrected response with change log
```

**Examples:**

**No self-correction:**
```
Calculate the ROI of this project.
```

**With self-correction:**
```
Calculate the ROI of this project.

Given:
- Initial investment: $50,000
- Monthly revenue: $8,000
- Monthly costs: $3,000
- Time period: 12 months

Step 1: Calculate
[Show calculation]

Step 2: Self-review
Check:
- Did I use correct ROI formula?
- Are all costs accounted for?
- Is time period applied correctly?
- Are units consistent?

Step 3: Correction
- [List any errors found]
- [Show corrected calculation]

Final answer: [Verified ROI with confidence level]
```

**Impact:** +15-25% accuracy, +20-40% confidence, +40-60% token overhead

---

### M2: Metacognitive Prompting

**What it is:** Asking the model to think about its own thinking process and confidence levels.

**When to use:**
- Uncertain or ambiguous problems
- Need confidence estimation
- Exploring knowledge boundaries

**Implementation:**
```markdown
[Task description]

Before answering:
1. Assess your confidence in this domain (0-100%)
2. Identify what you know vs. what you're uncertain about
3. Explain your reasoning approach
4. Flag assumptions you're making

Then provide your answer with confidence levels for each part.
```

**Examples:**

**No metacognition:**
```
What's the best way to scale PostgreSQL?
```

**With metacognition:**
```
What's the best way to scale PostgreSQL for 10M concurrent users?

Before answering:
1. Confidence: Rate your PostgreSQL scaling knowledge (0-100%)
2. Known: What are established PostgreSQL scaling patterns?
3. Uncertain: What depends on specific use case details?
4. Assumptions: What are you assuming about the workload?

Then provide recommendations with confidence levels:
- High confidence (80-100%): Well-established practices
- Medium confidence (50-79%): Context-dependent recommendations
- Low confidence (<50%): Educated guesses requiring validation
```

**Impact:** +30-50% answer reliability, +20% user trust

---

### M3: Chain-of-Verification (CoVe)

**What it is:** Generating verifiable claims, then systematically verifying each claim.

**When to use:**
- Factual accuracy critical
- Making claims that can be verified
- Need high reliability

**Implementation:**
```markdown
[Task description]

Step 1: Generate initial response with factual claims

Step 2: Extract verifiable claims
- Claim 1: [Statement]
- Claim 2: [Statement]
- Claim 3: [Statement]

Step 3: Verify each claim
- Claim 1: [Verification method] → [Result]
- Claim 2: [Verification method] → [Result]
- Claim 3: [Verification method] → [Result]

Step 4: Revise response based on verification
- Remove or correct false claims
- Add caveats to uncertain claims

Final: Verified response with confidence annotations
```

**Examples:**

**No verification:**
```
Explain the history of React.
```

**With CoVe:**
```
Explain the history of React framework.

Step 1: Generate historical timeline

Step 2: Extract factual claims
- Claim 1: React was released in [year]
- Claim 2: Created by [person/team]
- Claim 3: First used at [company]
- Claim 4: Hooks introduced in [version]

Step 3: Verify each claim
- For each claim, state confidence level
- Flag any claims with <80% confidence
- Note where verification is needed

Step 4: Final response
- Correct any errors found
- Add "uncertain" markers where appropriate
- Provide sources for high-confidence claims

Output the verified timeline with confidence markers.
```

**Impact:** +25-40% factual accuracy, +20% hallucination reduction

---

### M4: Output Validation

**What it is:** Defining success criteria and validating output against them.

**When to use:**
- Quality standards defined
- Need to meet specifications
- Deliverables have acceptance criteria

**Implementation:**
```markdown
[Task description]

Success criteria:
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

Generate solution, then validate:
For each criterion, check:
- ✓ Met / ✗ Not met
- Evidence
- If not met: Revision needed

Output: Solution + validation report
```

**Examples:**

**No validation:**
```
Write a function to parse JSON.
```

**With validation:**
```
Write a Python function to parse JSON safely.

Success criteria:
- [ ] Handles invalid JSON gracefully (no crashes)
- [ ] Returns meaningful error messages
- [ ] Includes type hints
- [ ] Has docstring
- [ ] Includes example usage
- [ ] Passes these test cases: [List test cases]

After writing the function, validate against each criterion.
Report: ✓ Met or ✗ Not Met with evidence.
If any ✗, revise the function.
```

**Impact:** +50-70% output quality, +40% spec compliance

---

### M5: Reflection Prompting

**What it is:** Asking the model to reflect on its reasoning process and identify improvements.

**When to use:**
- Learning from mistakes
- Iterative improvement
- Quality refinement

**Implementation:**
```markdown
[Task description]

Step 1: Initial attempt

Step 2: Reflection
- What worked well?
- What could be improved?
- What did I miss?
- What assumptions should I reconsider?

Step 3: Improved attempt
Apply insights from reflection.

Step 4: Compare
Show improvements made and why.
```

**Impact:** +20-35% solution quality through iteration

---

## Technique Selection Matrix

### By Task Type

| Task Type | Primary Techniques | Secondary Techniques |
|-----------|-------------------|---------------------|
| **Code Generation** | Role Assignment, Format Spec, Constraints | Self-Correction, CoVe |
| **Analysis** | CoT, Context Provision, Multi-Perspective | Metacognitive, Reflection |
| **Decision Making** | ToT, Constraint Optimization, Context | Multi-Perspective, Self-Consistency |
| **Creative Tasks** | Role Assignment, Example Provision | ToT, Reflection |
| **Debugging** | CoT, Task Decomposition, Self-Correction | CoVe, Metacognitive |
| **System Design** | GoT, Multi-Perspective, Context | ToT, Constraint Optimization |
| **Optimization** | AoT, Constraint Optimization, CoT | Self-Correction, Reflection |
| **Explanation** | CoT, Role Assignment, Format Spec | Example Provision, Self-Consistency |

### By Complexity Level

| Complexity | Foundation | Advanced | Meta-Cognitive |
|-----------|-----------|----------|----------------|
| **Quick Boost** | ✓✓✓ | ✗ | ✗ |
| **Deep Dive** | ✓✓✓ | ✓✓ | ✓ |
| **Revolutionary** | ✓✓✓ | ✓✓✓ | ✓✓✓ |

**Legend:** ✓✓✓ = Essential, ✓✓ = Recommended, ✓ = Optional, ✗ = Usually skip

### By Platform

| Platform | Preferred Techniques | Token Limits | Special Notes |
|----------|---------------------|--------------|---------------|
| **Claude** | All techniques, esp. GoT | 200K input | Use XML tags, long context |
| **ChatGPT** | CoT, ToT, Foundation layer | 128K input | Clear structure, numbered lists |
| **Gemini** | CoT, Self-Consistency | 1M input | Citations, search integration |

---

## Combination Strategies

### Foundation + CoT (Most Common)

**Use for:** Standard complex tasks

**Pattern:**
```markdown
You are [Role Assignment]

Context: [Context Provision]

Constraints: [Constraint Definition]

Think step-by-step: [CoT]
1. [Step 1]
2. [Step 2]
3. [Step 3]

Output format: [Format Specification]
```

**Impact:** Balanced quality-to-token ratio

---

### Foundation + ToT + Self-Consistency

**Use for:** High-stakes decisions

**Pattern:**
```markdown
You are [Role Assignment]

Context: [Context Provision]

Explore 3 approaches: [ToT]

For each approach, generate 2 independent reasoning paths: [Self-Consistency]

Compare all paths and select most consistent solution.

Constraints: [Constraint Definition]
Output: [Format Specification]
```

**Impact:** Maximum confidence in decisions, 3-5x token overhead

---

### Full Stack (Revolutionary)

**Use for:** Most complex problems

**Pattern:**
```markdown
You are [Role Assignment]

Context: [Context Provision]
Constraints: [Constraint Definition]
Examples: [Few-Shot]

Apply Graph-of-Thoughts: [GoT]
- Map system interconnections
- Identify feedback loops

For each subsystem, use Algorithm-of-Thoughts: [AoT]
- Iteratively optimize
- Track improvements

Apply Self-Correction: [M1]
- Review output
- Fix errors

Apply Chain-of-Verification: [M3]
- Verify factual claims
- Correct inaccuracies

Output: [Format Specification]
Validate: [Output Validation]
```

**Impact:** Maximum quality, 5-10x token overhead

---

## Technique Selection Flowchart

```
START
  ↓
Is task simple? ──Yes──→ Foundation Layer only
  ↓ No
  ↓
High stakes? ──Yes──→ Add Meta-Cognitive Layer
  ↓ No
  ↓
Single solution path? ──Yes──→ Use CoT
  ↓ No
  ↓
Need alternatives? ──Yes──→ Use ToT
  ↓ No
  ↓
System-level problem? ──Yes──→ Use GoT
  ↓ No
  ↓
Need optimization? ──Yes──→ Use AoT
  ↓ No
  ↓
Default: Foundation + CoT
```

---

## Token Budget Guidelines

### By Optimization Level

**Quick Boost (Budget: 500-1500 tokens):**
- Foundation Layer: 2-3 techniques
- Advanced Layer: Skip
- Meta-Cognitive: Skip

**Deep Dive (Budget: 1500-4000 tokens):**
- Foundation Layer: 4-5 techniques
- Advanced Layer: 1 framework (CoT or ToT)
- Meta-Cognitive: 1 technique (Self-Correction)

**Revolutionary (Budget: 4000-10000 tokens):**
- Foundation Layer: All 6 techniques
- Advanced Layer: 2+ frameworks (GoT + AoT)
- Meta-Cognitive: 2+ techniques (Self-Correction + CoVe)

### Token Allocation

**Efficient:**
- 40% task description (context, constraints, examples)
- 30% reasoning framework
- 20% output specification
- 10% meta-cognitive (validation, reflection)

**Inefficient (avoid):**
- 70% over-explanation of instructions
- 20% redundant constraints
- 10% actual task

---

## Common Patterns

### Pattern 1: Analytical Task

**Recipe:**
- Role Assignment (domain expert)
- Context Provision
- Chain-of-Thought
- Format Specification
- Output Validation

**Example:** "Analyze this code for security vulnerabilities"

---

### Pattern 2: Decision Task

**Recipe:**
- Role Assignment (decision-maker)
- Context Provision
- Constraint Definition
- Tree-of-Thoughts (explore options)
- Multi-Perspective Analysis
- Self-Consistency (verify decision)

**Example:** "Choose the best architecture for this system"

---

### Pattern 3: Creative Task

**Recipe:**
- Role Assignment (creative expert)
- Context Provision
- Example Provision (style reference)
- Tree-of-Thoughts (explore ideas)
- Reflection Prompting

**Example:** "Design a unique brand identity"

---

### Pattern 4: Optimization Task

**Recipe:**
- Role Assignment (optimizer)
- Context Provision
- Constraint Definition
- Algorithm-of-Thoughts (iterative refinement)
- Output Validation
- Self-Correction

**Example:** "Optimize this database query"

---

### Pattern 5: System Design Task

**Recipe:**
- Role Assignment (architect)
- Context Provision
- Constraint Definition
- Graph-of-Thoughts (map system)
- Multi-Perspective Analysis
- Chain-of-Verification

**Example:** "Design a scalable authentication system"

---

## Layered Application Strategy

### Layer 1: Foundation (Always Apply)

Every optimized prompt should include:
1. Clear role assignment (if domain-specific)
2. Sufficient context
3. Output format specification

**Baseline improvement:** +40-60%

### Layer 2: Add Reasoning (For Complex Tasks)

Add ONE framework based on task:
- CoT for linear problems
- ToT for alternatives
- GoT for systems
- AoT for optimization

**Additional improvement:** +20-40%

### Layer 3: Add Meta-Cognitive (For High Stakes)

Add quality assurance:
- Self-Correction for accuracy
- CoVe for factual claims
- Metacognitive for confidence

**Additional improvement:** +15-30%

**Total improvement potential:** +75-130% with full stack

---

## Vietnamese Explanations

### Foundation Layer (Nền Tảng)

**F1: Role Assignment (Phân Công Vai Trò)**
- **Giải thích:** Cho AI một "chuyên gia" cụ thể để nó trả lời đúng chuyên môn.
- **Ví dụ:** Thay vì "Giải thích AI", dùng "Bạn là giáo sư AI, giải thích cho sinh viên năm 1"

**F2: Task Decomposition (Chia Nhỏ Nhiệm Vụ)**
- **Giải thích:** Chia việc lớn thành nhiều việc nhỏ, dễ xử lý hơn.
- **Mẹo nhớ:** "Muốn ăn cả ngã về không" → Chia nhỏ ra

**F3: Format Specification (Định Dạng Đầu Ra)**
- **Giải thích:** Nói rõ bạn muốn kết quả kiểu gì (JSON, bảng, đoạn văn).
- **Ví dụ:** "Trả lời dạng bảng 3 cột: Vấn đề | Giải pháp | Ví dụ"

**F4: Context Provision (Cung Cấp Ngữ Cảnh)**
- **Giải thích:** Cho AI biết đầy đủ thông tin nền, giống như "brief" dự án.
- **Mẹo nhớ:** Càng nhiều context, câu trả lời càng sát với nhu cầu

**F5: Constraint Definition (Định Nghĩa Ràng Buộc)**
- **Giải thích:** Nói rõ "được làm gì", "không được làm gì", "giới hạn là gì".
- **Ví dụ:** "Không dùng thư viện ngoài, chỉ dùng JavaScript thuần"

**F6: Example Provision (Cung Cấp Ví Dụ)**
- **Giải thích:** Cho AI xem ví dụ mẫu để nó "học" pattern.
- **Mẹo nhớ:** "Few-shot learning" = học từ vài ví dụ

### Advanced Layer (Nâng Cao)

**CoT: Chain-of-Thought (Chuỗi Suy Nghĩ)**
- **Giải thích:** Giống giải toán viết đầy đủ các bước, không chỉ viết đáp án.
- **Khi nào dùng:** Khi cần giải thích logic, làm bài có nhiều bước.

**ToT: Tree-of-Thoughts (Cây Suy Nghĩ)**
- **Giải thích:** Thử nhiều cách giải quyết song song, rồi chọn cách tốt nhất.
- **Khi nào dùng:** Khi có nhiều phương án, cần so sánh ưu nhược điểm.

**GoT: Graph-of-Thoughts (Đồ Thị Suy Nghĩ)**
- **Giải thích:** Suy nghĩ dạng mạng lưới, các ý liên kết và ảnh hưởng lẫn nhau.
- **Khi nào dùng:** Vấn đề phức tạp, nhiều yếu tố liên quan, cần nhìn toàn cảnh hệ thống.

**AoT: Algorithm-of-Thoughts (Thuật Toán Suy Nghĩ)**
- **Giải thích:** Tạo ra giải pháp, đánh giá, cải thiện, lặp lại cho đến khi đủ tốt.
- **Khi nào dùng:** Khi cần tối ưu hóa, cải thiện dần dần đến mức hoàn hảo.

### Meta-Cognitive Layer (Siêu Nhận Thức)

**M1: Self-Correction (Tự Sửa Lỗi)**
- **Giải thích:** AI tự kiểm tra lại câu trả lời của mình và sửa lỗi.
- **Mẹo nhớ:** Giống như bạn làm xong bài, đọc lại và tự sửa sai.

**M2: Metacognitive Prompting (Nhận Thức Về Nhận Thức)**
- **Giải thích:** AI đánh giá "tôi có chắc không?", "tôi biết gì?", "tôi không chắc gì?"
- **Lợi ích:** Biết được AI tự tin hay không, nên tin tưởng mức nào.

**M3: Chain-of-Verification (Chuỗi Kiểm Chứng)**
- **Giải thích:** AI tạo câu trả lời, rồi kiểm tra từng câu trong đó có đúng sự thật không.
- **Lợi ích:** Giảm "hallucination" (AI bịa chuyện).

---

## Anti-Patterns to Avoid

### AP1: Technique Soup

**Problem:** Throwing all techniques into one prompt without coherent structure.

**Example:**
```
You are an expert. Think step-by-step using tree of thoughts with graph analysis.
Apply self-correction and metacognitive verification while exploring branches
and optimizing iteratively...
```

**Fix:** Choose 2-3 compatible techniques that serve the task.

---

### AP2: Over-Specification

**Problem:** Too many instructions, constraints, or examples drowning the actual task.

**Example:**
```
[3000 words of instructions]
Task: What is 2+2?
```

**Fix:** Match instruction complexity to task complexity.

---

### AP3: Conflicting Techniques

**Problem:** Combining techniques that contradict each other.

**Example:**
```
Generate answer in one step [conflicts with CoT]
Explore all possible approaches [conflicts with constraint to single step]
```

**Fix:** Ensure techniques align and support each other.

---

### AP4: No Clear Success Criteria

**Problem:** Using validation/optimization techniques without defining "success".

**Example:**
```
Validate your output. [No criteria provided]
```

**Fix:** Always define concrete success criteria before validation.

---

## Implementation Checklist

### Before Applying Techniques:

- [ ] Understand the task completely
- [ ] Identify task type and complexity
- [ ] Define success criteria
- [ ] Estimate token budget
- [ ] Select appropriate optimization level

### Foundation Layer:

- [ ] Role assignment (if domain-specific)
- [ ] Context provision (always)
- [ ] Constraint definition (if constraints exist)
- [ ] Format specification (always)
- [ ] Example provision (if complex pattern)
- [ ] Task decomposition (if multi-step)

### Advanced Layer (if needed):

- [ ] Select ONE primary framework (CoT/ToT/GoT/AoT)
- [ ] Implement framework pattern correctly
- [ ] Ensure framework matches task type
- [ ] Consider platform capabilities

### Meta-Cognitive Layer (if high stakes):

- [ ] Add self-correction (if accuracy critical)
- [ ] Add metacognitive (if confidence matters)
- [ ] Add CoVe (if factual claims)
- [ ] Add output validation (if specs defined)

### Final Review:

- [ ] No conflicting techniques
- [ ] Instructions are clear and concise
- [ ] Token budget reasonable
- [ ] Success criteria defined
- [ ] Output format specified

---

## Quick Reference: Technique Tags

When documenting or discussing techniques, use these tags:

**Foundation:**
- `[F1-Role]` - Role Assignment
- `[F2-Decompose]` - Task Decomposition
- `[F3-Format]` - Format Specification
- `[F4-Context]` - Context Provision
- `[F5-Constraints]` - Constraint Definition
- `[F6-Examples]` - Example Provision

**Advanced:**
- `[A1-CoT]` - Chain-of-Thought
- `[A2-ToT]` - Tree-of-Thoughts
- `[A3-GoT]` - Graph-of-Thoughts
- `[A4-AoT]` - Algorithm-of-Thoughts
- `[A5-SelfCon]` - Self-Consistency
- `[A6-MultiPersp]` - Multi-Perspective

**Meta-Cognitive:**
- `[M1-SelfCorr]` - Self-Correction
- `[M2-MetaCog]` - Metacognitive Prompting
- `[M3-CoVe]` - Chain-of-Verification
- `[M4-Validate]` - Output Validation
- `[M5-Reflect]` - Reflection Prompting

**Usage:**
```
Optimization applied: [F1-Role] + [F4-Context] + [A1-CoT] + [M1-SelfCorr]
```

---

## Summary

**Key Takeaways:**

1. **Layer your techniques**: Foundation → Advanced → Meta-Cognitive
2. **Match complexity**: Simple task = simple techniques
3. **Choose frameworks wisely**: Use decision tree
4. **Combine strategically**: Ensure compatibility
5. **Validate effectiveness**: Measure impact
6. **Respect token budgets**: Quality vs. cost tradeoff

**Golden Rule:** The best optimization uses the minimum techniques needed to achieve the desired quality level.

**Next Steps:**
- Study individual technique examples in `examples/`
- Review anti-patterns in `anti-patterns.md`
- Practice with progressive complexity (Quick → Deep → Revolutionary)
- Consult `core-concepts.md` for Lyra's 4-phase methodology

---

**Document Version:** 1.0.0  
**Last Updated:** 2026-02-05  
**Related:** `reasoning-frameworks.md`, `anti-patterns.md`, `core-concepts.md`
