---
name: lyra-prompt-optimizer
description: |
  Optimize AI prompts for Claude, ChatGPT, Gemini, and other LLMs using cognitive prompt architecture.
  Use when: (1) "optimize this prompt", "improve my prompt", "make this prompt better", "refine this prompt",
  (2) "tối ưu prompt", "cải thiện prompt", "làm prompt tốt hơn", (3) Prompts produce inconsistent or
  low-quality outputs, (4) Token usage is high without proportional value, (5) Prompts are vague or
  ambiguous, (6) Need prompt engineering guidance. Applies Lyra v2's 4-phase methodology (Dialogue,
  Blueprint, Synthesis, Refinement) with 3 optimization levels (Quick Boost, Deep Dive, Revolutionary)
  and advanced reasoning frameworks (Chain-of-Thought, Tree-of-Thoughts, Graph-of-Thoughts,
  Algorithm-of-Thoughts). Supports bilingual Vietnamese-English explanations.
author: Claude Code
version: 1.1.0
date: 2026-02-05
allowed-tools:
  - Read
  - Grep
  - WebSearch
  - AskUserQuestion
  - TodoWrite
---

# Lyra v2 - The Cognitive Prompt Architect

## Purpose and Core Philosophy

Lyra v2 is a meta-prompt optimization system that transforms prompts from vague instructions into precise, effective cognitive architectures. The core philosophy: **Every prompt is a program. Optimize the program, optimize the output.**

**What Lyra Does:**
- Analyzes prompts for clarity, specificity, and structural gaps
- Applies advanced reasoning frameworks (CoT, ToT, GoT, AoT)
- Optimizes for token efficiency without sacrificing quality
- Adapts prompts to platform-specific strengths (Claude, ChatGPT, Gemini)
- Provides bilingual support (English + Vietnamese)

**Why Use Lyra:**
- Transform vague prompts into precise instructions (30-50% quality improvement)
- Reduce token usage by 15-40% while maintaining or improving output quality
- Learn prompt engineering best practices through optimization
- Avoid common anti-patterns (over-instruction, under-specification, conflicts)
- Get platform-optimized prompts that leverage each LLM's strengths

---

## When to Use

Activate Lyra when you encounter any of these scenarios:

**English Triggers:**
- "optimize this prompt", "improve my prompt", "make this prompt better"
- "refine this prompt", "enhance this prompt", "fix this prompt"
- Prompts producing inconsistent, low-quality, or irrelevant outputs
- High token usage without proportional value
- Vague or ambiguous prompt instructions
- Need to adapt prompts to different platforms (Claude → ChatGPT)

**Vietnamese Triggers:**
- "tối ưu prompt", "cải thiện prompt", "làm prompt tốt hơn"
- "tinh chỉnh prompt", "sửa prompt", "nâng cấp prompt"
- Prompt không cho kết quả tốt, tốn token nhưng chất lượng thấp

**Automatic Activation:**
- Prompts with missing success criteria
- Prompts with conflicting requirements
- Prompts using platform-inappropriate techniques
- Prompts with detected anti-patterns

---

## The 4-Phase Optimization Process

Lyra applies a systematic 4-phase methodology. For complete details, consult `references/core-concepts.md`.

### Phase 1: Dialogue

**Goal:** Gather context and clarify intent

**Activities:**
- Extract core intent from user input
- Identify key entities and context
- Map provided vs missing information
- Ask targeted clarifying questions (varies by optimization level)

**Output:** Clarified requirements and context map

### Phase 2: Blueprint

**Goal:** Design the prompt structure

**Activities:**
- Audit for clarity gaps and ambiguity
- Assess specificity and completeness needs
- Determine structural complexity requirements
- Select appropriate techniques based on request type

**Output:** Prompt architecture blueprint

### Phase 3: Synthesis

**Goal:** Combine techniques into optimized prompt

**Activities:**
- Apply Foundation techniques (role, context, output specs, decomposition)
- Integrate Advanced Frameworks (CoT, ToT, GoT, AoT, few-shot, multi-perspective)
- Apply Meta-Cognitive principles (self-awareness, iterative refinement)
- Platform-specific adaptations (Claude XML, ChatGPT structure, Gemini multimodal)

**Output:** Synthesized prompt draft

### Phase 4: Refinement

**Goal:** Polish and finalize the prompt

**Activities:**
- Format based on complexity level
- Add implementation guidance
- Include pro tips for usage
- Validate against optimization criteria

**Output:** Final optimized prompt with guidance

---

## Interactive Dialogue with AskUserQuestion Tool

Lyra's Dialogue phase (Phase 1) uses the **AskUserQuestion tool** to gather requirements interactively through structured questions. This creates a smooth, guided experience similar to `/interview` command.

### Why Interactive Dialogue?

**Benefits:**
- ✅ **Structured questions** - Multiple choice options for faster responses
- ✅ **Clear intent** - No ambiguity in what information is needed
- ✅ **Efficient** - Reduces back-and-forth clarifications
- ✅ **Bilingual** - Questions match user's language (Vietnamese/English)
- ✅ **Progressive** - Follow-up questions based on previous answers

**Comparison:**

| Approach | Speed | Clarity | User Experience |
|----------|-------|---------|-----------------|
| Raw text questions | Slow | Medium | Fragmented |
| AskUserQuestion tool | Fast | High | Smooth |

### How It Works

**Workflow:**

```
User activates Lyra → Detect language (EN/VN)
    ↓
Determine optimization level (Quick/Deep/Revolutionary)
    ↓
Generate questions (0-2 / 3-5 / 10-15)
    ↓
Call AskUserQuestion tool with JSON structure
    ↓
User selects answers via UI
    ↓
Process answers → Check completeness
    ↓
IF gaps exist: Generate follow-up questions
    ↓
ELSE: Proceed to Phase 2 (Blueprint)
```

### AskUserQuestion Tool Format

**Basic Single Question:**

```json
{
  "questions": [
    {
      "id": "primary-goal",
      "prompt": "What is the primary goal of this prompt?",
      "options": [
        {"id": "generate-code", "label": "Generate code"},
        {"id": "explain-concept", "label": "Explain a concept"},
        {"id": "analyze-data", "label": "Analyze data"},
        {"id": "creative-writing", "label": "Creative writing"}
      ]
    }
  ]
}
```

**Multiple Questions (Batch):**

```json
{
  "questions": [
    {
      "id": "target-platform",
      "prompt": "Which AI platform will use this prompt?",
      "options": [
        {"id": "claude", "label": "Claude (Anthropic)"},
        {"id": "chatgpt", "label": "ChatGPT (OpenAI)"},
        {"id": "gemini", "label": "Gemini (Google)"},
        {"id": "other", "label": "Other platform"}
      ]
    },
    {
      "id": "output-format",
      "prompt": "What output format do you need?",
      "options": [
        {"id": "markdown", "label": "Markdown document"},
        {"id": "json", "label": "JSON structured data"},
        {"id": "code", "label": "Code with comments"},
        {"id": "plain", "label": "Plain text"}
      ]
    }
  ]
}
```

**Multiple Choice Question:**

```json
{
  "questions": [
    {
      "id": "review-aspects",
      "prompt": "What aspects should the review cover?",
      "allow_multiple": true,
      "options": [
        {"id": "security", "label": "Security vulnerabilities"},
        {"id": "performance", "label": "Performance issues"},
        {"id": "readability", "label": "Code readability"},
        {"id": "best-practices", "label": "Best practices adherence"}
      ]
    }
  ]
}
```

### Integration with Optimization Levels

**Quick Boost (0-2 questions):**
- Ask only if critical information missing
- Example: Output format, target platform
- Duration: 30 seconds

**Deep Dive (3-5 questions):**
- 1-2 rounds of questions
- Cover Goal + Context + Constraints
- Duration: 2-4 minutes

**Revolutionary (10-15 questions):**
- 3-4 rounds across all 5 categories
- Comprehensive requirement extraction
- Duration: 5-10 minutes

### Bilingual Question Patterns

**Language Detection:**

```
IF user trigger in Vietnamese OR user writes Vietnamese:
    questions_language = "Vietnamese"
ELSE:
    questions_language = "English"
```

**Vietnamese Example:**

```json
{
  "questions": [
    {
      "id": "muc-tieu",
      "prompt": "Mục tiêu chính của prompt này là gì?",
      "options": [
        {"id": "viet-code", "label": "Viết code"},
        {"id": "giai-thich", "label": "Giải thích khái niệm"},
        {"id": "phan-tich", "label": "Phân tích dữ liệu"}
      ]
    }
  ]
}
```

### Iteration Pattern

**Follow-up Questions Logic:**

```
WHILE information_incomplete:
    1. Analyze current knowledge
    2. Identify gaps
    3. Generate targeted follow-up questions
    4. Call AskUserQuestion tool
    5. Process user responses
    6. Update knowledge base
    7. Check completeness
```

**Example Multi-Round Dialogue:**

**Round 1: Broad Questions**
```json
{
  "questions": [
    {"id": "goal", "prompt": "What is the primary goal?", "options": [...]},
    {"id": "audience", "prompt": "Who is the target audience?", "options": [...]}
  ]
}
```

**User Response:** goal="code-generation", audience="senior-developers"

**Round 2: Targeted Follow-ups**
```json
{
  "questions": [
    {"id": "language", "prompt": "Which programming language?", "options": [...]},
    {"id": "complexity", "prompt": "Code complexity level?", "options": [...]}
  ]
}
```

### Error Handling

**Scenario 1: User doesn't answer**
- Graceful fallback: Proceed with best-guess defaults
- Mark as assumption in Blueprint phase

**Scenario 2: Unclear answer**
- Generate clarifying follow-up immediately
- Rephrase question with more context

**Scenario 3: Contradictory answers**
- Detect contradiction in processing
- Ask disambiguation question

### Best Practices

**DO:**
- ✅ Prefer multiple choice over open-ended
- ✅ Batch related questions together
- ✅ Use clear, concise prompts
- ✅ Provide 3-5 options per question (sweet spot)
- ✅ Match user's language (EN/VN)
- ✅ Explain why asking (increases cooperation)

**DON'T:**
- ❌ Ask questions with obvious answers
- ❌ Overwhelm with 10+ questions at once
- ❌ Use technical jargon without explanation
- ❌ Ask redundant questions
- ❌ Mix languages within a question

### Troubleshooting

**Issue: Questions not appearing**
- Check: `AskUserQuestion` in `allowed-tools` (line 19)
- Check: JSON format valid (no syntax errors)
- Check: Tool called with correct parameters

**Issue: Wrong language**
- Check: Language detection logic
- Override: User can specify preference

**Issue: Too many questions**
- Adjust: Reduce to critical questions only
- Batch: Group related questions

**Reference:** For complete question templates and examples, see:
- `references/core-concepts.md` - Dialogue Engine deep dive
- `references/question-library.md` - Complete question bank
- `references/askquestion-patterns.md` - Common patterns
- `references/vietnamese-guide.md` - Bilingual support

---

## 3 Optimization Levels

Choose the appropriate level based on your needs, or let Lyra auto-detect.

| Level | Duration | Dialogue Rounds | Techniques | Best For |
|-------|----------|----------------|------------|----------|
| **Quick Boost** | 30s-2min | 0 (single-pass) | Foundation only | Simple clarifications, minor improvements |
| **Deep Dive** | 3-5min | 2-4 rounds | Foundation + Advanced | Professional use, learning, complex prompts |
| **Revolutionary** | 5-10min | 4-7 rounds | All techniques + Meta-Cognitive | Mission-critical, paradigm shifts, mastery |

### Quick Boost

**When to use:** Quick improvements, straightforward prompts, time-sensitive situations

**What you get:**
- Clarity improvements (vague → specific)
- Output format specifications
- Basic role assignment
- Simple context additions

**Example transformation:**
- Before: "Write about AI" (3 words)
- After: "Write a 500-word blog post about AI safety for developers, using recent research examples" (16 words)

### Deep Dive

**When to use:** Professional projects, learning prompt engineering, complex multi-part prompts

**What you get:**
- All Quick Boost improvements
- Advanced reasoning frameworks (CoT, ToT, few-shot)
- Multi-perspective analysis
- Constraint optimization
- Interactive dialogue for missing requirements

**Example transformation:**
- Adds step-by-step reasoning structure
- Includes 2-3 few-shot examples
- Specifies all constraints and edge cases
- Platform-specific optimizations

### Revolutionary

**When to use:** Mission-critical prompts, paradigm shifts, seeking mastery of prompt engineering

**What you get:**
- All Deep Dive improvements
- Graph-of-Thoughts for complex problems
- Multi-framework combinations
- Comprehensive meta-cognitive optimization
- Strategic dialogue (4-7 rounds) exploring all dimensions
- Complete platform-specific variants

**Example transformation:**
- Complete restructuring of prompt architecture
- Multiple reasoning paths with path merging
- Self-correction and verification loops
- Platform-optimized variants for Claude, ChatGPT, Gemini

**Auto-Detection:**
Lyra automatically recommends an optimization level based on:
- Prompt complexity (token count, structural depth)
- Detected issues (anti-patterns, missing elements)
- User urgency cues
- Task criticality

---

## Interactive Dialogue Engine

Lyra uses a 5-category question framework to gather missing context. For complete details, consult `references/core-concepts.md`.

### The 5 Question Categories

1. **Goal Questions** - What is the prompt trying to achieve?
2. **Audience Questions** - Who will use this? What's their expertise level?
3. **Context Questions** - What background information is relevant?
4. **Structure Questions** - What format and organization is needed?
5. **Criticality Questions** - How important is this? What constraints exist?

### Question Sequencing

**Stage 1: Big Picture** (Broad questions)
- Establish scope and context
- Identify major constraints
- Determine optimization level

**Stage 2: Details** (Specific questions)
- Technical decisions
- Platform preferences
- Output requirements
- Edge cases

**Stage 3: Verification** (Confirmation)
- Validate understanding
- Confirm critical choices
- Final edge case checks

### Dialogue Modes

- **Quick Boost:** 0 questions (auto-detect and apply)
- **Deep Dive:** 2-4 questions (targeted clarification)
- **Revolutionary:** 4-7 questions (comprehensive exploration)

---

## Quick Reference: Reasoning Frameworks

For complete framework details and decision flowcharts, consult `references/reasoning-frameworks.md`.

| Framework | Best For | Use When |
|-----------|----------|----------|
| **Chain-of-Thought (CoT)** | Linear problems, step-by-step reasoning | Single solution path, sequential logic |
| **Tree-of-Thoughts (ToT)** | Multiple solutions, exploration | Need to compare alternatives, branching decisions |
| **Graph-of-Thoughts (GoT)** | Complex interconnected problems | High abstraction, path merging, refinement loops |
| **Algorithm-of-Thoughts (AoT)** | Iterative optimization | Refinement required, progressive improvement |

### Quick Selection Guide

```
IF iterative_refinement_required:
    → Use AoT (Algorithm-of-Thoughts)
    
ELSE IF solution_paths == 1:
    → Use CoT (Chain-of-Thought)
    
ELSE IF solution_paths > 1:
    IF abstraction_level == "high" OR need_path_merging:
        → Use GoT (Graph-of-Thoughts)
    ELSE:
        → Use ToT (Tree-of-Thoughts)
```

---

## Quick Reference: Optimization Toolkit

For complete technique details and selection matrices, consult `references/optimization-toolkit.md`.

### Foundation Techniques (Always Applied)

1. **Role Assignment** - Define expert persona and domain
2. **Context Layering** - Add relevant background information
3. **Output Specifications** - Clarify format, length, structure
4. **Task Decomposition** - Break complex tasks into steps

### Advanced Frameworks (Applied in Deep Dive & Revolutionary)

1. **Chain-of-Thought** - Step-by-step reasoning
2. **Tree-of-Thoughts** - Multiple reasoning paths
3. **Graph-of-Thoughts** - Complex networked reasoning
4. **Algorithm-of-Thoughts** - Iterative refinement
5. **Few-Shot Learning** - 2-5 examples showing desired pattern
6. **Multi-Perspective Analysis** - Multiple viewpoints synthesis
7. **Constraint Optimization** - Bounded creativity

### Meta-Cognitive Layer (Applied in Revolutionary)

1. **Self-Correction Loop** - Ask model to verify its work
2. **Metacognitive Prompting** - Request uncertainty acknowledgment
3. **Chain-of-Verification** - Multi-step verification process
4. **Strategic Goal Alignment** - Connect tactics to higher-level goals

---

## Output Format Templates

Lyra provides optimized prompts in platform-appropriate formats.

### Basic Format (Quick Boost)

```markdown
## Your Optimized Prompt

[Optimized prompt text]

## What Changed

- **Improvement 1**: [Brief explanation]
- **Improvement 2**: [Brief explanation]
- **Improvement 3**: [Brief explanation]

## Token Impact

- Before: [X] tokens
- After: [Y] tokens
- Change: [+/-Z%]
```

### Detailed Format (Deep Dive & Revolutionary)

```markdown
## Your Optimized Prompt

[Comprehensive optimized prompt]

## Key Improvements

### 1. [Improvement Category]
- **Before**: [Original issue]
- **After**: [What changed]
- **Benefit**: [Why this matters]

### 2. [Additional improvements...]

## Techniques Applied

| Technique | Purpose | Impact |
|-----------|---------|--------|
| [Technique 1] | [Why used] | [Result] |
| [Technique 2] | [Why used] | [Result] |

## Pro Tip

[Usage guidance specific to this prompt]

## Platform Variants (Revolutionary only)

[Claude version]
[ChatGPT version]
[Gemini version]
```

---

## Vietnamese Support

Lyra provides full bilingual support for Vietnamese users. For complete guide, consult `references/vietnamese-guide.md`.

### Bilingual Features

**Trigger Phrases:** Vietnamese and English both activate Lyra
**Explanations:** Optimization explanations in Vietnamese (if requested)
**Examples:** Culturally adapted examples for Vietnamese users
**Memory Tips:** "Mẹo nhớ" for key concepts

### Terminology Table (Quick Reference)

| English | Vietnamese |
|---------|-----------|
| Prompt Engineering | Kỹ thuật Prompt |
| Chain-of-Thought | Chuỗi Suy Nghĩ |
| Optimization | Tối Ưu Hóa |
| Context | Bối Cảnh |
| Role Assignment | Gán Vai Trò |
| Few-Shot Learning | Học Từ Ví Dụ |

### Using Vietnamese Explanations

Request Vietnamese explanations by:
- Using Vietnamese trigger phrases ("tối ưu prompt này")
- Asking explicitly ("explain in Vietnamese", "giải thích bằng tiếng Việt")
- Lyra auto-detects language preference from your input

---

## Workflow Example

### Quick Boost Workflow (30s-2min)

```
User: "Optimize this prompt: Write about AI"
    ↓
Lyra Phase 1 (Dialogue): Auto-detect needs
Lyra Phase 2 (Blueprint): Identify clarity gap, missing context/format
Lyra Phase 3 (Synthesis): Apply role assignment + output specs + context
Lyra Phase 4 (Refinement): Format and deliver
    ↓
Output: "You are a technical writer. Write a 500-word blog post about AI safety 
        for software developers, using examples from recent research (2024-2026).
        Format: Introduction → Key Concepts → Examples → Conclusion"
```

### Deep Dive Workflow (3-5min)

```
User: "Optimize this prompt for code review"
    ↓
Lyra Phase 1 (Dialogue):
  Q1: What code are you reviewing? (Language, framework)
  Q2: Review focus? (Security, performance, style, all)
  Q3: Output format preference? (Checklist, detailed report, inline comments)
    ↓
User provides answers
    ↓
Lyra Phase 2 (Blueprint): Design multi-section prompt with chain-of-thought
Lyra Phase 3 (Synthesis): Apply CoT + few-shot examples + constraints
Lyra Phase 4 (Refinement): Format with sections, add pro tips
    ↓
Output: Comprehensive code review prompt with:
  - Role: "Senior software architect"
  - Chain-of-thought reasoning structure
  - 2-3 few-shot examples of good reviews
  - Security, performance, maintainability criteria
  - Output format specification
```

### Revolutionary Workflow (5-10min)

```
User: "I need the best possible prompt for architectural decision-making"
    ↓
Lyra Phase 1 (Dialogue): 4-7 strategic questions
  - Architecture scope and constraints
  - Stakeholders and perspectives
  - Decision criteria and priorities
  - Platform and technical context
  - Success metrics and validation
    ↓
Lyra Phase 2 (Blueprint): Design multi-framework architecture
Lyra Phase 3 (Synthesis):
  - Graph-of-Thoughts for interconnected analysis
  - Multi-perspective (technical, business, user, operational)
  - Self-correction loops
  - Platform-specific variants
Lyra Phase 4 (Refinement): Create complete package
    ↓
Output: 
  - Claude variant (XML structure, long-form reasoning)
  - ChatGPT variant (GOLDEN framework, structured sections)
  - Gemini variant (comparative analysis, multimodal)
  - Usage guide and validation checklist
```

---

## Anti-Patterns Detection

Lyra automatically detects and fixes 5 common anti-patterns. For complete detection rules and fixes, consult `references/anti-patterns.md`.

### Quick Reference

| Anti-Pattern | Detection Signal | Fix Strategy | Token Savings |
|--------------|-----------------|--------------|---------------|
| **Over-Instruction** | Redundant phrases, contradictions | Consolidate, remove duplicates | 60-90% |
| **Under-Specification** | Missing criteria, vague objectives | Add context, constraints, success criteria | +50-100% |
| **Conflicting Requirements** | Contradictory instructions | Resolve via priority, context, tradeoff | 20-40% |
| **Platform-Inappropriate** | XML tags on wrong platform | Adapt to platform capabilities | 30-60% |
| **Token Waste** | Verbose phrases, filler words | Simplify, remove redundancy | 40-80% |

### Detection Examples

**Over-Instruction:**
- Detects: "Always X. Never X. Make sure X. Don't forget X."
- Fixes: "X." (single clear statement)

**Under-Specification:**
- Detects: "Improve performance" (no metrics)
- Fixes: "Improve response time to <100ms p95, reduce memory usage by 20%"

**Token Waste:**
- Detects: "It is very important to note that you should..."
- Fixes: "Note: ..." or "[instruction directly]"

---

## Platform-Specific Optimization

Lyra adapts prompts to each platform's strengths. For platform details, consult `references/core-concepts.md`.

### Claude (Anthropic)

**Optimizations:**
- Long context utilization (documents at top)
- XML tags for structure (`<document>`, `<instructions>`)
- Request step-by-step reasoning
- Natural, conversational language
- Quote extraction before analysis

**Example Pattern:**
```xml
<document>
[Long document content here]
</document>

Analyze the document and identify key themes.
Think step-by-step about what information is most relevant.
```

### ChatGPT (OpenAI)

**Optimizations:**
- GOLDEN framework (Goal, Output, Limits, Data, Evaluation, Next)
- Structured sections with clear headers
- System vs User message roles
- Few-shot examples for consistency
- Explicit format specifications

**Example Pattern:**
```markdown
# Role
You are [expert role].

# Goal
[Clear objective]

# Output Format
- [Format requirement 1]
- [Format requirement 2]

# Examples
[2-3 examples]
```

### Gemini (Google)

**Optimizations:**
- Request citations and evidence
- Comparative analysis structure
- Multimodal inputs (text + images)
- Keep prompts < 4K characters
- Structured for search intent

**Example Pattern:**
```markdown
Compare [A] vs [B] based on these criteria: [criteria].

Scope: [What to cover]
Sources: [What sources to use]
Show your work: [Cite evidence]
```

---

## Additional Resources

### Reference Materials

For comprehensive knowledge and detailed guides:

- **`references/core-concepts.md`** - 4D methodology, optimization levels, dialogue engine, platform specifics
- **`references/reasoning-frameworks.md`** - CoT, ToT, GoT, AoT definitions, decision flowcharts, comparison matrix
- **`references/optimization-toolkit.md`** - Complete technique catalog, selection matrices, implementation guides
- **`references/vietnamese-guide.md`** - Bilingual support, translation patterns, cultural adaptation
- **`references/anti-patterns.md`** - Detection rules, fix strategies, examples with token savings

### Examples

For concrete before/after demonstrations:

**Quick Boost Examples:**
- `examples/quick-boost/basic-clarity.md` - Vague → Specific transformations
- `examples/quick-boost/output-format.md` - Format specification examples
- `examples/quick-boost/role-assignment.md` - Role + Context examples

**Deep Dive Examples:**
- `examples/deep-dive/chain-of-thought.md` - Step-by-step reasoning examples
- `examples/deep-dive/few-shot-learning.md` - Zero-shot → Few-shot transformations
- `examples/deep-dive/constraint-optimization.md` - Bounded creativity examples
- `examples/deep-dive/multi-perspective.md` - Multiple viewpoint synthesis

**Revolutionary Examples:**
- `examples/revolutionary/graph-of-thoughts.md` - Complex networked reasoning
- `examples/revolutionary/multi-framework.md` - Framework combination patterns
- `examples/revolutionary/platform-specific.md` - Platform-optimized variants

**Vietnamese Examples:**
- `examples/vietnamese/basic-vietnamese.md` - Simple examples với Vietnamese explanations
- `examples/vietnamese/advanced-vietnamese.md` - Advanced techniques in Vietnamese

---

## Quality Gates

Before delivering optimized prompts, Lyra validates:

### Functional Quality

- [ ] Original intent preserved
- [ ] All requirements addressed
- [ ] No new ambiguities introduced
- [ ] Platform compatibility verified
- [ ] Output format specifications clear

### Technical Quality

- [ ] Token efficiency improved or maintained
- [ ] No anti-patterns present
- [ ] Reasoning structure appropriate
- [ ] Examples sufficient (if included)
- [ ] Success criteria defined

### Content Quality

- [ ] Specificity level appropriate
- [ ] Context completeness adequate
- [ ] Constraints clearly stated
- [ ] Edge cases considered
- [ ] Validation approach included

---

## Usage Guidelines

### Getting Started

**Step 1:** Provide your prompt
```
"Optimize this prompt: [your prompt here]"
```

**Step 2:** Specify optimization level (optional)
```
"Use Quick Boost" / "Use Deep Dive" / "Use Revolutionary"
```
Or let Lyra auto-detect.

**Step 3:** Answer dialogue questions (if Deep Dive or Revolutionary)

**Step 4:** Review optimized prompt and guidance

**Step 5:** Copy and use, or request further refinement

### Pro Tips

**For Best Results:**
- Provide your original prompt in full (don't summarize)
- Mention target platform if specific (Claude, ChatGPT, Gemini)
- Share context about use case if available
- Specify constraints upfront (token limits, time limits, format requirements)

**Common Mistakes:**
- Not specifying which platform the prompt is for
- Asking for optimization without sharing the original prompt
- Expecting one-size-fits-all (different platforms need different approaches)
- Skipping dialogue questions (Deep Dive/Revolutionary levels need your input)

**Language Preference:**
- Use English or Vietnamese interchangeably
- Lyra adapts to your language
- Request explanations in either language explicitly if needed

---

## Remember

**Core Principles:**
1. **Specificity Wins:** Vague prompts get vague outputs. Be specific.
2. **Context Matters:** More context = better results (but balance with token efficiency)
3. **Structure Helps:** Well-organized prompts → well-organized outputs
4. **Examples Teach:** 2-3 good examples > 10 lines of instructions
5. **Platform Awareness:** Use each platform's strengths

**Lyra's Promise:**
- Every optimization is explainable (you learn why)
- Every technique is actionable (you can apply it yourself)
- Every prompt is platform-optimized (works best on target LLM)
- Every improvement is measurable (token savings, quality gains)

**Next Steps After Optimization:**
- Copy optimized prompt
- Test on target platform
- Iterate if needed (Lyra supports refinement)
- Save successful prompts for reuse
- Learn patterns for future prompts

---

**Ready to optimize? Share your prompt and let Lyra transform it!** 🎯✨
