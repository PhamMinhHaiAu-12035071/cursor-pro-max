# Anti-Patterns Reference

## What Are Anti-Patterns?

**Definition:** Common but ineffective prompt patterns that decrease quality, waste tokens, or produce unreliable outputs.

**Philosophy:** Knowing what NOT to do is as important as knowing what to do.

**Purpose:** Detect and fix anti-patterns to achieve better prompts faster.

---

## The 5 Anti-Pattern Categories

1. **Over-Instruction** - Too many words, redundant instructions
2. **Under-Specification** - Too vague, missing critical information
3. **Conflicting Requirements** - Contradictory instructions
4. **Platform-Inappropriate** - Wrong techniques for target AI platform
5. **Token Waste** - Inefficient use of context window

---

## Category 1: Over-Instruction

### Definition

Providing excessive, redundant, or unnecessarily detailed instructions that confuse rather than clarify.

### Common Manifestations

**AP1.1: Instruction Soup**

**Pattern:**
```
You are an expert. Please help me. Make sure to think carefully. 
Be thorough. Be accurate. Be helpful. Don't make mistakes. 
Double-check everything. Provide high-quality output. Be detailed...
```

**Problem:** Generic platitudes add no value, waste tokens, dilute actual requirements.

**Detection:**
- Instructions contain vague adjectives ("good", "thorough", "quality")
- No specific, actionable guidance
- >30% of prompt is meta-instruction

**Fix:**
```
You are a senior Python developer.

Task: Refactor this function for readability.

Specific requirements:
- Extract magic numbers to constants
- Add type hints
- Split into smaller functions if >20 lines
```

**Token Savings:** 60-80% reduction in instruction overhead

---

**AP1.2: Redundant Constraints**

**Pattern:**
```
Requirements:
- Use Python 3.10+
- Must use Python version 3.10 or higher
- Ensure Python version is at least 3.10
- Do not use Python versions below 3.10
```

**Problem:** Same constraint repeated 4 times wastes tokens and clutters prompt.

**Detection:**
- Same requirement stated multiple ways
- Overlap between constraints and examples

**Fix:**
```
Requirements:
- Python 3.10+
```

**Token Savings:** 75% reduction for this section

---

**AP1.3: Over-Explained Framework**

**Pattern:**
```
Use Chain-of-Thought reasoning. This means you should think step-by-step.
Breaking things into steps means you should not jump to conclusions.
Instead, reason through each part sequentially. Sequential reasoning means
one step follows another. This helps because...
[500 words explaining CoT]
```

**Problem:** Over-explaining the framework itself wastes tokens that should be spent on the actual task.

**Detection:**
- Framework explanation >200 tokens
- Explaining "how to think" rather than "what to think about"

**Fix:**
```
Think step-by-step:
1. Analyze the problem
2. Identify potential solutions
3. Evaluate trade-offs
4. Recommend best approach
```

**Token Savings:** 80-90% reduction in framework overhead

---

### Over-Instruction Summary

**Symptoms:**
- Prompt >3000 tokens for simple task
- Lots of adjectives, little substance
- Repeating the same point
- Explaining obvious things

**Quick Fixes:**
1. Remove vague adjectives ("good", "thorough", "quality")
2. State each requirement once
3. Use framework pattern, not framework explanation
4. Focus on WHAT to do, not HOW to think

---

## Category 2: Under-Specification

### Definition

Insufficient detail, missing context, or vague requirements that leave AI guessing.

### Common Manifestations

**AP2.1: Vague Goals**

**Pattern:**
```
Make this code better.
```

**Problem:** "Better" is undefined. Better how? Performance? Readability? Maintainability?

**Detection:**
- Vague verbs: "improve", "optimize", "enhance", "fix"
- No success criteria
- No constraints

**Fix:**
```
Refactor this code to improve readability.

Specific improvements:
- Extract magic numbers to named constants
- Add descriptive variable names
- Split long functions (>30 lines)
- Add docstrings

Success criteria: Junior developer can understand without asking questions
```

**Impact:** +60% output quality through clear criteria

---

**AP2.2: Missing Context**

**Pattern:**
```
Design a database schema for users.
```

**Problem:** No scale, no use cases, no constraints - infinite valid answers, likely none fitting actual needs.

**Detection:**
- No scale indicators (100 users? 1M users?)
- No use case description
- No technical constraints
- No existing system context

**Fix:**
```
Design a database schema for user management.

Context:
- E-commerce app, expected 100K users
- Need: Authentication, profiles, order history, wishlist
- Read-heavy (90% reads, 10% writes)
- Using PostgreSQL on AWS RDS
- Must support GDPR (data export, deletion)

Provide: Schema, indexes, justification
```

**Impact:** +70% answer relevance through complete context

---

**AP2.3: No Output Format**

**Pattern:**
```
Explain microservices architecture.
```

**Problem:** Format unclear - essay? bullet points? code examples? Comparison table?

**Detection:**
- No format specification
- No structure guidance
- No length indication

**Fix:**
```
Explain microservices architecture.

Output format:
1. Definition (2-3 sentences)
2. Key characteristics (bullet list)
3. Pros vs Cons (comparison table)
4. When to use / when not to use
5. Example architecture diagram (describe in text)

Length: ~500 words
Audience: Junior developers
```

**Impact:** +80% output usability through clear format

---

**AP2.4: Ambiguous Requirements**

**Pattern:**
```
Build a login system. Make it secure.
```

**Problem:** "Secure" is vague. Which security measures? What threat model?

**Detection:**
- Generic adjectives without definition
- No specific requirements
- No acceptance criteria

**Fix:**
```
Build a login system with these security features:

Must have:
- Password hashing (bcrypt, cost factor 12)
- JWT tokens (15min access, 7day refresh)
- Rate limiting (5 attempts per 15min)
- HTTPS only
- CSRF protection

Must not:
- Store passwords in plain text
- Use deprecated algorithms (MD5, SHA1)
- Allow unlimited login attempts

Acceptance criteria:
- Passes OWASP Top 10 security checks
- No security warnings from linter
```

**Impact:** +90% security compliance through explicit requirements

---

### Under-Specification Summary

**Symptoms:**
- AI output is generic or off-target
- Requires multiple clarifying questions
- Output unusable without major revision

**Quick Fixes:**
1. Define vague terms ("better" = "more readable")
2. Provide complete context (scale, constraints, tech stack)
3. Specify output format explicitly
4. List concrete requirements, not adjectives

---

## Category 3: Conflicting Requirements

### Definition

Instructions that contradict each other, making it impossible to satisfy all requirements simultaneously.

### Common Manifestations

**AP3.1: Contradictory Constraints**

**Pattern:**
```
Create a detailed, comprehensive analysis. Keep it brief and concise.
```

**Problem:** Cannot be both comprehensive and brief. AI will guess which to prioritize.

**Detection:**
- "Detailed AND brief"
- "Fast AND thorough"
- "Simple AND feature-rich"
- "Innovative AND follow standards"

**Fix:**
```
Create an analysis that is:
- Comprehensive in coverage (all key points)
- Concise in expression (no fluff)
- Target length: 500-700 words
```

**Impact:** +50% consistency by resolving contradiction

---

**AP3.2: Conflicting Frameworks**

**Pattern:**
```
Provide answer immediately in one step. Also, use step-by-step reasoning
with Chain-of-Thought to show your work.
```

**Problem:** Cannot do both single-step and multi-step reasoning.

**Detection:**
- "Quickly AND show work"
- "Direct answer AND step-by-step"
- Multiple frameworks requested without integration strategy

**Fix:**
```
Use Chain-of-Thought reasoning:
1. Analyze the problem
2. Break into steps
3. Solve each step
4. Combine into final answer

Then provide: (1) Final answer, (2) Reasoning steps
```

**Impact:** +40% output coherence

---

**AP3.3: Scope Conflicts**

**Pattern:**
```
Design complete e-commerce platform. Include only user authentication.
```

**Problem:** "Complete platform" conflicts with "only authentication".

**Detection:**
- "Complete/full/comprehensive" followed by "only/just"
- Broad scope with narrow requirements

**Fix:**
```
Design user authentication system for e-commerce platform.

Scope:
- IN SCOPE: Registration, login, logout, password reset, session management
- OUT OF SCOPE: Product catalog, cart, checkout, payments

This will integrate with existing platform (provide integration points).
```

**Impact:** +60% scope clarity

---

**AP3.4: Priority Conflicts**

**Pattern:**
```
Priorities:
1. Security (highest)
2. Performance (highest)
3. Simplicity (highest)
```

**Problem:** Everything cannot be highest priority.

**Detection:**
- All priorities marked "highest/critical/must-have"
- No clear ordering

**Fix:**
```
Priorities (in order):
1. Security (non-negotiable)
2. Correctness (must be bug-free)
3. Performance (optimize if time permits)
4. Simplicity (nice-to-have)

Trade-off guidance: Sacrifice simplicity for security if needed.
```

**Impact:** +70% decision quality through clear priorities

---

### Conflicting Requirements Summary

**Symptoms:**
- AI output cherry-picks some requirements, ignores others
- Inconsistent results across runs
- Requires clarification to resolve conflicts

**Quick Fixes:**
1. Choose ONE direction for contradictions
2. Prioritize requirements clearly (1, 2, 3...)
3. Specify trade-off guidance
4. Remove absolute language ("all", "only") when inappropriate

---

## Category 4: Platform-Inappropriate Techniques

### Definition

Using techniques or formats that don't work well with the target AI platform.

### Common Manifestations

**AP4.1: XML Tags on Non-Claude Platforms**

**Pattern (ChatGPT or Gemini):**
```
<thinking>
Apply reasoning here
</thinking>

<output>
Provide answer here
</output>
```

**Problem:** XML tags are Claude-specific. Other platforms treat them as literal text.

**Detection:**
- Using `<thinking>`, `<answer>`, `<context>` tags
- Target platform is NOT Claude

**Fix (for ChatGPT):**
```
# Thinking

Apply reasoning here

# Answer

Provide answer here
```

**Fix (for Gemini):**
```
## Reasoning Process

Apply reasoning here

## Final Answer

Provide answer here
```

**Impact:** +30% platform compatibility

---

**AP4.2: Excessive Context on Short-Context Platforms**

**Pattern (ChatGPT with 128K limit):**
```
[Providing 100K tokens of context + examples for simple task]
```

**Problem:** Wastes limited context window, increases cost, may hit limits.

**Detection:**
- Context size > 50% of platform limit
- Task complexity doesn't justify context size
- Platform: ChatGPT/Gemini (not Claude's 200K)

**Fix:**
```
[Distill context to essential 5-10K tokens]
[Reference external docs rather than embedding]
```

**Impact:** 80% token efficiency gain

---

**AP4.3: Complex Framework on Simple Platform**

**Pattern (using basic chatbot):**
```
Apply Graph-of-Thoughts with Algorithm-of-Thoughts iterative refinement...
[Complex multi-framework approach]
```

**Problem:** Simple platforms may not handle complex reasoning well.

**Detection:**
- GoT/AoT on platforms with limited reasoning
- Multi-framework on basic models

**Fix:**
```
Use simple Chain-of-Thought:
1. Step 1
2. Step 2
3. Step 3
```

**Impact:** Better results through platform-appropriate complexity

---

**AP4.4: Ignoring Platform Strengths**

**Pattern (Claude):**
```
[Short, basic prompt with no structured reasoning]
```

**Problem:** Underutilizing Claude's strong reasoning capabilities.

**Detection:**
- Not using XML structure on Claude
- Not requesting explicit thinking
- Not leveraging long context

**Fix (for Claude):**
```xml
<context>
[Leverage 200K context window with comprehensive background]
</context>

<task>
[Clear task description]
</task>

<thinking>
Apply detailed reasoning here. Show your work.
</thinking>

<output>
[Structured output]
</output>
```

**Impact:** +40% output quality by leveraging platform strengths

---

### Platform-Inappropriate Summary

**Symptoms:**
- Techniques don't work as expected
- Output ignores structural elements
- Poor platform-specific performance

**Quick Fixes:**
1. Match structure to platform (XML for Claude, markdown for others)
2. Respect context limits (Claude 200K, ChatGPT 128K, Gemini 1M)
3. Choose complexity appropriate to platform capabilities
4. Leverage platform-specific features (Claude reasoning, Gemini search)

---

## Category 5: Token Waste

### Definition

Inefficient use of tokens that could be reduced without losing effectiveness.

### Common Manifestations

**AP5.1: Verbose Preambles**

**Pattern:**
```
Hello! I hope you're doing well today. I have a question that I'd like to ask
you about. I was wondering if you could help me with something. I've been
thinking about this problem and I'm not sure how to proceed. The question is
about Python programming. Here's what I need help with...
```

**Problem:** 50+ tokens of fluff before actual request.

**Detection:**
- Social pleasantries
- Meta-commentary about asking questions
- Rambling before getting to point

**Fix:**
```
How do I reverse a list in Python?
```

**Token Savings:** 85-95% reduction in preamble

---

**AP5.2: Repeated Examples**

**Pattern:**
```
Examples:
[Example 1 - 500 tokens]
[Example 2 - very similar to 1, 500 tokens]
[Example 3 - very similar to 1, 500 tokens]
[Example 4 - very similar to 1, 500 tokens]
```

**Problem:** Redundant examples waste tokens without adding new information.

**Detection:**
- More than 3-4 examples
- Examples very similar to each other
- Each example >200 tokens

**Fix:**
```
Examples:
[Example 1: Basic case - 200 tokens]
[Example 2: Edge case - 200 tokens]
[Example 3: Complex case - 200 tokens]
```

**Token Savings:** 60-75% reduction through selective examples

---

**AP5.3: Narrative Padding**

**Pattern:**
```
In the modern world of software development, it has become increasingly
apparent that the importance of testing cannot be overstated. Many experts
in the field agree that comprehensive test coverage is essential for
maintaining code quality. Therefore, considering all of these factors...
```

**Problem:** Essay-style writing wastes tokens. Prompts should be direct.

**Detection:**
- Introductory paragraphs
- Transition phrases ("therefore", "in conclusion")
- Justifications for why you're asking

**Fix:**
```
Write unit tests for this function:
[function code]

Requirements:
- Test happy path
- Test edge cases
- Test error conditions
```

**Token Savings:** 70-85% reduction by removing narrative

---

**AP5.4: Redundant Validations**

**Pattern:**
```
After generating the code, validate it. Then check if it's valid.
Then verify correctness. Then review for errors. Then test it.
Then check again. Then double-check. Then triple-check...
```

**Problem:** Multiple ways of saying "validate" waste tokens.

**Detection:**
- 3+ similar validation instructions
- Synonyms used redundantly

**Fix:**
```
After generating code:
1. Validate syntax
2. Check logic correctness
3. Test with example inputs
```

**Token Savings:** 60-80% reduction in validation instructions

---

**AP5.5: Template Boilerplate**

**Pattern:**
```
[Same 1000-token instruction block pasted into every prompt]
```

**Problem:** If instructions don't change, use system message or persistent context instead.

**Detection:**
- Same instruction block across prompts
- Generic instructions not specific to task

**Fix:**
- Move to system message (ChatGPT)
- Use persistent context (Claude Projects)
- Reference external document

**Token Savings:** Can reduce recurring cost by 50-80%

---

### Token Waste Summary

**Symptoms:**
- Prompts consistently >2000 tokens for simple tasks
- Lots of "filler" words
- Repeated similar content

**Quick Fixes:**
1. Remove pleasantries and preambles
2. Get to the point immediately
3. Use 2-3 diverse examples, not 10 similar ones
4. Remove narrative padding
5. State each instruction once
6. Move persistent instructions to system message

---

## Anti-Pattern Detection Checklist

Run this checklist before finalizing any prompt:

### Over-Instruction

- [ ] No vague adjectives ("good", "thorough", "quality") without definition
- [ ] Each requirement stated once, not repeated
- [ ] Framework pattern used, not framework explanation
- [ ] <30% of prompt is meta-instruction

### Under-Specification

- [ ] Vague terms defined ("better" = "more readable")
- [ ] Complete context provided (scale, constraints, tech)
- [ ] Output format specified
- [ ] Concrete requirements, not just adjectives

### Conflicting Requirements

- [ ] No contradictory instructions
- [ ] Clear priority ordering
- [ ] Trade-off guidance provided
- [ ] Scope clearly defined (in-scope vs out-scope)

### Platform-Inappropriate

- [ ] Structure matches platform (XML for Claude, markdown for others)
- [ ] Context size appropriate for platform limits
- [ ] Technique complexity matches platform capabilities
- [ ] Leveraging platform-specific strengths

### Token Waste

- [ ] No preambles or pleasantries
- [ ] Direct, to-the-point instructions
- [ ] 2-3 diverse examples max
- [ ] No narrative padding
- [ ] No redundant validations

---

## Refactoring Anti-Patterns: Before/After

### Example 1: Over-Instruction + Token Waste

**Before (850 tokens):**
```
Hello! I hope you can help me with this. I've been working on a project and
I need some assistance. I'm trying to write a function in Python. It should
be good quality code. Please make sure it's well-written. The function should
be robust and handle errors properly. Make sure to follow best practices.
Use good naming conventions. Write clean code. Make it maintainable. Ensure
it's properly structured. Add appropriate comments. Make sure variables have
descriptive names. The function should reverse a string. Please help me write
this function. Thank you so much for your help!
```

**After (45 tokens):**
```
Write a Python function to reverse a string.

Requirements:
- Handle empty strings
- Add docstring
- Include example usage
```

**Improvements:**
- Token reduction: 95% (850 → 45)
- Removed pleasantries
- Removed vague requests ("good quality")
- Specific requirements only

---

### Example 2: Under-Specification

**Before (30 tokens):**
```
Design a caching strategy for my app.
```

**After (180 tokens):**
```
Design a caching strategy for REST API.

Context:
- Node.js/Express backend
- PostgreSQL database
- Expected load: 1000 req/sec
- Read-heavy (85% reads, 15% writes)
- Data: User profiles, product catalog, order history
- Budget: $200/month for cache infrastructure

Requirements:
- Cache hit rate >75%
- Invalidation on data updates
- Distributed (3 servers)

Provide:
1. Cache layer architecture
2. What to cache (with TTL)
3. Invalidation strategy
4. Cost breakdown
```

**Improvements:**
- Specificity: +85%
- Complete context provided
- Clear requirements and constraints
- Output format specified

---

### Example 3: Conflicting Requirements

**Before (120 tokens):**
```
Create a comprehensive, detailed analysis of the entire system architecture.
Keep it brief and to the point. Cover everything in depth. Make it short and
concise. Be thorough but don't write too much.
```

**After (90 tokens):**
```
Create a system architecture analysis.

Scope:
- Cover all major components
- Focus on critical integration points
- Omit implementation details

Format:
- Architecture diagram (text description)
- Component table (name, purpose, tech)
- Critical integration points
- Target length: 600-800 words
```

**Improvements:**
- Removed contradictions
- Clear scope definition
- Balanced "comprehensive yet concise"
- Specific length target

---

### Example 4: Platform-Inappropriate

**Before (for ChatGPT, 200 tokens):**
```xml
<instructions>
Use detailed reasoning
</instructions>

<context>
[Content]
</context>

<thinking>
Show your work here
</thinking>

<output>
Final answer
</output>
```

**After (for ChatGPT, 150 tokens):**
```
# Instructions
Use detailed reasoning

# Context
[Content]

# Thinking Process
Show your work here

# Final Answer
Answer here
```

**Improvements:**
- Platform-appropriate structure
- Removed Claude-specific XML
- Clearer for ChatGPT parsing

---

## Token Savings Calculator

### Formula

```
Token Savings % = (Before Tokens - After Tokens) / Before Tokens × 100
```

### Typical Savings by Anti-Pattern

| Anti-Pattern | Typical Savings | Range |
|-------------|----------------|-------|
| Instruction Soup | 70% | 60-85% |
| Redundant Constraints | 65% | 50-80% |
| Over-Explained Framework | 85% | 75-95% |
| Verbose Preambles | 90% | 80-98% |
| Repeated Examples | 70% | 60-80% |
| Narrative Padding | 75% | 65-85% |
| Redundant Validations | 70% | 60-80% |

### Cost Impact

**Example:**
- Original prompt: 2000 tokens
- Anti-patterns fixed: -60% average
- Optimized prompt: 800 tokens
- **Token savings per run:** 1200 tokens
- **If run 100 times/month:** 120,000 tokens saved
- **Cost savings (at $3/1M tokens input):** $0.36/month
- **Annual savings:** $4.32

**Scale impact:**
- Large organization (10,000 prompts/day)
- Average savings: 1000 tokens/prompt
- Daily: 10M tokens saved
- Monthly: 300M tokens saved
- **Monthly cost savings (at $3/1M):** $900
- **Annual savings:** $10,800

---

## Common Questions

### Q: "Can I use multiple examples?"

**A:** Yes, but follow these guidelines:

**Good use of multiple examples:**
- Show diverse cases (simple, edge case, complex)
- Each example teaches something new
- 2-4 examples maximum

**Bad use:**
- 10+ similar examples
- Each example >500 tokens
- Redundant information

### Q: "Is being polite considered token waste?"

**A:** Minimal politeness is fine, excessive is wasteful.

**Acceptable:**
```
Please help me debug this code.
```

**Wasteful:**
```
Hello! I hope you're having a wonderful day! I was wondering if you might
possibly be able to help me with a small question I have about code...
```

**Optimal:**
```
Debug this code: [code]
```

### Q: "Should I always minimize tokens?"

**A:** No. Optimize for *effectiveness per token*, not absolute minimum tokens.

**Good optimization:**
- Removed fluff, kept essential context
- Clear and concise
- All necessary information present

**Over-optimization:**
- So brief it's ambiguous
- Missing critical context
- Requires clarifying questions

**Balance:** Every token should add value. Remove tokens that don't.

---

## Vietnamese Explanations

### Anti-Pattern Categories (5 Loại Lỗi Thường Gặp)

1. **Over-Instruction (Hướng Dẫn Thừa):** Viết quá dài, lặp lại, không cần thiết
2. **Under-Specification (Thiếu Chi Tiết):** Quá mơ hồ, thiếu thông tin quan trọng
3. **Conflicting Requirements (Yêu Cầu Mâu Thuẫn):** Các yêu cầu trái ngược nhau
4. **Platform-Inappropriate (Không Phù Hợp Platform):** Dùng sai kỹ thuật cho AI platform
5. **Token Waste (Lãng Phí Token):** Dùng token không hiệu quả

### Common Anti-Patterns (Lỗi Hay Gặp)

**Lỗi 1: Quá dài dòng**
```
❌ "Xin chào! Tôi cần giúp đỡ. Tôi đang làm dự án và cần hỗ trợ..."
✅ "Viết hàm Python đảo ngược chuỗi."
```

**Lỗi 2: Quá mơ hồ**
```
❌ "Làm code tốt hơn."
✅ "Refactor code để dễ đọc hơn: tách magic numbers, đổi tên biến rõ ràng."
```

**Lỗi 3: Mâu thuẫn**
```
❌ "Viết chi tiết. Viết ngắn gọn." (Mâu thuẫn!)
✅ "Viết đầy đủ nội dung nhưng súc tích (600-800 từ)."
```

**Lỗi 4: Lặp lại**
```
❌ "Kiểm tra code. Rồi kiểm tra lại. Rồi test. Rồi verify..."
✅ "Sau khi viết code: (1) Kiểm tra syntax, (2) Test với example"
```

---

## Summary

**Key Principles:**

1. **Every token should add value** - Remove fluff, keep essentials
2. **Clarity over brevity** - Better to be clear than cryptic
3. **Specificity over generality** - Concrete requirements over vague adjectives
4. **Consistency over contradiction** - Resolve conflicts explicitly
5. **Platform-appropriate** - Match techniques to AI capabilities

**Detection Strategy:**

1. Run through checklist before finalizing prompt
2. Calculate token efficiency (value per token)
3. Test prompt and observe output quality
4. Iterate: Fix anti-patterns, re-test

**Next Steps:**

- Study examples in `examples/` folders
- Practice refactoring prompts with anti-patterns
- Measure token savings and quality improvements
- Consult `optimization-toolkit.md` for proper patterns

---

**Document Version:** 1.0.0  
**Last Updated:** 2026-02-05  
**Related:** `optimization-toolkit.md`, `core-concepts.md`, `reasoning-frameworks.md`
