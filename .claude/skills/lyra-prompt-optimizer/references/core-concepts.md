# Core Concepts Reference

## The Lyra Philosophy

**Central Tenet:** Prompts are cognitive architectures that shape how AI models think and respond.

**Core Belief:** Optimizing prompts is not about adding more words—it's about designing better thinking structures.

**Outcome:** Every prompt optimization should produce measurable improvements in clarity, specificity, effectiveness, and token efficiency.

---

## The 4D Methodology (4-Phase Process)

### Phase 1: Dialogue 🗣️

**Purpose:** Understand the problem space deeply through progressive questioning.

**Goals:**
- Extract complete requirements
- Identify hidden assumptions
- Clarify ambiguities
- Establish success criteria

**Process:**
1. Analyze user's initial prompt
2. Identify information gaps
3. Generate targeted questions (5 categories)
4. Integrate answers into complete understanding

**Deliverable:** Comprehensive problem specification

**Duration:** Quick Boost (skip), Deep Dive (3-5 questions), Revolutionary (10-15 questions)

### Phase 2: Blueprint 📐

**Purpose:** Design the cognitive architecture and select optimization techniques.

**Goals:**
- Classify task type and complexity
- Select appropriate reasoning framework
- Choose optimization techniques
- Map technique to requirement

**Process:**
1. Analyze task characteristics
2. Consult decision trees and matrices
3. Select framework (CoT/ToT/GoT/AoT)
4. Choose foundation techniques (F1-F6)
5. Add meta-cognitive layer (if needed)

**Deliverable:** Optimization strategy document

**Key Decisions:**
- Which reasoning framework?
- Which foundation techniques?
- What validation methods?
- Token budget allocation

### Phase 3: Synthesis ⚡

**Purpose:** Construct the optimized prompt using selected techniques.

**Goals:**
- Implement cognitive architecture
- Apply all selected techniques
- Ensure coherent structure
- Maintain clarity and focus

**Process:**
1. Structure prompt sections
2. Apply role assignment
3. Provide context and constraints
4. Implement reasoning framework
5. Specify output format
6. Add validation requirements

**Deliverable:** Fully optimized prompt (v1)

**Quality Gates:**
- All requirements addressed
- Techniques applied correctly
- Clear and coherent
- Token budget respected

### Phase 4: Refinement ✨

**Purpose:** Iteratively improve the prompt through testing and feedback.

**Goals:**
- Validate effectiveness
- Identify weak points
- Apply improvements
- Achieve quality targets

**Process:**
1. Test prompt with AI
2. Evaluate output quality
3. Identify improvement areas
4. Apply refinements
5. Re-test
6. Repeat until quality gates met

**Deliverable:** Final optimized prompt with quality report

**Refinement Cycles:**
- Quick Boost: 1 iteration
- Deep Dive: 2-3 iterations
- Revolutionary: 3-5 iterations

---

## The 3 Optimization Levels

### Level 1: Quick Boost ⚡

**Target:** Simple improvements for immediate impact

**Scope:**
- Foundation layer techniques only (F1-F6)
- No advanced reasoning frameworks
- 1 refinement iteration

**Time:** 5-15 minutes

**Token Budget:** 500-1500 tokens

**Improvements Applied:**
1. Add role assignment (if missing)
2. Clarify task description
3. Specify output format
4. Add 1-2 constraints

**Expected Impact:**
- Clarity: +30-50%
- Specificity: +25-40%
- Output quality: +20-35%
- Token efficiency: +10-20%

**When to use:**
- Quick iterations
- Simple tasks
- Tight time/budget constraints
- Good-enough quality acceptable

**Examples:**
- Clarifying vague prompts
- Adding output format
- Specifying role/expertise

---

### Level 2: Deep Dive 🔍

**Target:** Comprehensive optimization with reasoning frameworks

**Scope:**
- All foundation techniques (F1-F6)
- ONE advanced framework (CoT/ToT)
- ONE meta-cognitive technique
- 2-3 refinement iterations

**Time:** 20-45 minutes

**Token Budget:** 1500-4000 tokens

**Improvements Applied:**
1. Complete foundation layer
2. Add Chain-of-Thought OR Tree-of-Thoughts
3. Include self-correction loop
4. Provide 2-3 examples
5. Define validation criteria

**Expected Impact:**
- Clarity: +50-80%
- Specificity: +60-90%
- Output quality: +50-75%
- Token efficiency: +30-50%

**When to use:**
- Complex tasks
- Quality is important
- Have time for thorough optimization
- Moderate token budget

**Examples:**
- Code generation with specific requirements
- Technical analysis with multiple factors
- Decision making with trade-offs

---

### Level 3: Revolutionary 🚀

**Target:** Maximum quality through comprehensive cognitive architecture

**Scope:**
- All foundation techniques
- TWO+ advanced frameworks (GoT + AoT)
- MULTIPLE meta-cognitive techniques
- 3-5 refinement iterations
- Platform-specific optimization

**Time:** 45-90 minutes

**Token Budget:** 4000-10000 tokens

**Improvements Applied:**
1. Complete foundation layer with examples
2. Graph-of-Thoughts for system mapping
3. Algorithm-of-Thoughts for iterative refinement
4. Self-correction + CoVe + Metacognitive
5. Multi-perspective analysis
6. Platform-specific optimizations
7. Comprehensive validation

**Expected Impact:**
- Clarity: +80-120%
- Specificity: +90-150%
- Output quality: +100-200%
- Token efficiency: +50-100%

**When to use:**
- Mission-critical prompts
- Extremely complex problems
- Quality is paramount
- Generous token budget

**Examples:**
- System architecture design
- Multi-dimensional optimization
- High-stakes decision making
- Complex creative projects

---

## The Dialogue Engine

### Purpose

The Dialogue Engine extracts complete requirements through progressive, targeted questioning.

### 5 Question Categories

#### Category 1: Goal Clarification 🎯

**Focus:** What does success look like?

**Questions:**
- What is the primary objective?
- What specific outcome do you need?
- How will you measure success?
- What would make this excellent vs. just adequate?

**Example:**
```
User: "Optimize my database."

Goal questions:
- What metric are you optimizing? (Speed, cost, reliability, scalability)
- What's your target? (e.g., <100ms queries, <$500/month)
- What's acceptable trade-off? (e.g., eventual consistency OK?)
```

#### Category 2: Audience & Context 👥

**Focus:** Who is this for and what's the environment?

**Questions:**
- Who will use/read this?
- What's their expertise level?
- What context/constraints exist?
- What's the broader situation?

**Example:**
```
User: "Explain React hooks."

Audience questions:
- Who is the audience? (Beginners, intermediate, advanced?)
- What's their background? (JavaScript knowledge level?)
- What will they do with this knowledge? (Build app, pass interview?)
- Any specific hooks you need explained? (useState, useEffect, custom?)
```

#### Category 3: Scope & Boundaries 📏

**Focus:** What's included and what's excluded?

**Questions:**
- What's in scope vs. out of scope?
- What are the boundaries?
- What should be prioritized?
- What can be skipped?

**Example:**
```
User: "Design a social media app."

Scope questions:
- Core features only or full feature set? (MVP vs. complete)
- What features are must-have? (Auth, posts, comments, likes?)
- What can wait for v2? (Stories, DMs, notifications?)
- Any features explicitly excluded? (Video, livestream?)
```

#### Category 4: Format & Structure 📋

**Focus:** How should the output be presented?

**Questions:**
- What format do you prefer? (Code, prose, diagram, table?)
- How detailed should it be?
- Any structure requirements?
- How will you use the output?

**Example:**
```
User: "Explain microservices architecture."

Format questions:
- Need code examples or conceptual explanation?
- Prefer diagram/visual or text description?
- How much detail? (Overview vs. implementation guide)
- Specific format? (Blog post, documentation, presentation slides?)
```

#### Category 5: Critical Factors ⚠️

**Focus:** What must be right? What could go wrong?

**Questions:**
- What are the critical requirements (must-haves)?
- What are the risks or failure modes?
- What should we avoid?
- Are there any deal-breakers?

**Example:**
```
User: "Recommend a cloud provider."

Critical questions:
- Budget constraints? (Hard limit or flexible?)
- Compliance requirements? (GDPR, HIPAA, SOC2?)
- Deal-breakers? (No vendor lock-in, no cold starts?)
- Critical features? (Must have auto-scaling, must have region X?)
```

### Dialogue Execution Strategy

**Quick Boost:**
- Skip dialogue OR ask 1-2 critical questions only

**Deep Dive:**
- Ask 3-5 questions across categories
- Focus on Goal + Scope + Critical Factors

**Revolutionary:**
- Ask 10-15 questions across all categories
- Deep dive into each category
- Clarify ambiguities iteratively

### Question Quality Principles

1. **Specific over generic:** "What metrics?" vs. "What do you want?"
2. **Multiple choice when possible:** Reduces back-and-forth
3. **Explain why asking:** "To determine the best framework..."
4. **Progressive:** Start broad, then narrow based on answers
5. **Actionable:** Answers should directly inform optimization strategy

---

## Platform-Specific Optimization

### Claude (Anthropic)

**Strengths:**
- Excellent at complex reasoning (GoT, multi-step CoT)
- Handles long contexts (200K tokens)
- Strong with structured XML
- Good at following detailed instructions

**Optimization Strategy:**

**1. Use XML Structure:**
```xml
<instructions>
[Clear task description]
</instructions>

<context>
[Background information]
</context>

<thinking>
[Request reasoning here]
</thinking>

<output>
[Specify format]
</output>
```

**2. Leverage Long Context:**
- Include comprehensive examples
- Provide detailed background
- Use extensive few-shot learning

**3. Request Explicit Thinking:**
```markdown
Before answering, use <thinking> tags to work through the problem.
Then provide final answer in <output> tags.
```

**4. Structured Sections:**
- Use headers, lists, tables
- XML tags for delimiters
- Clear section boundaries

**Best Practices:**
- Be explicit about reasoning depth
- Use constitutional AI principles (harmlessness, honesty, helpfulness)
- Leverage multi-turn conversations for refinement

---

### ChatGPT (OpenAI)

**Strengths:**
- Fast response times
- Good at following clear instructions
- Excellent code generation
- Handles system/user message separation well

**Optimization Strategy:**

**1. System Message for Behavior:**
```
System: You are an expert Python developer specializing in data science.
You always write well-documented, type-hinted code with comprehensive tests.

User: [Actual task]
```

**2. Structured Instructions:**
- Use numbered lists
- Clear section headers
- Bullet points for requirements

**3. Explicit Format:**
```markdown
Provide response in exactly this format:

1. Analysis
[Your analysis here]

2. Implementation
```python
[Code here]
```

3. Testing
[Test cases here]
```

**4. Iterative Refinement:**
```
Generate initial response.

Then critique your response:
- What could be improved?
- What's missing?
- Any errors?

Provide improved version.
```

**Best Practices:**
- Keep system message concise (<500 tokens)
- Use user message for task details
- Request JSON for structured output
- Leverage function calling for specific outputs

---

### Gemini (Google)

**Strengths:**
- Massive context window (1M tokens)
- Integrated search capabilities
- Good at comparative analysis
- Multimodal (text + images)

**Optimization Strategy:**

**1. Leverage Search:**
```markdown
Research [topic] using current information (2026).

Find:
- Latest best practices
- Recent benchmarks
- Current recommendations

Then synthesize into [output format].
```

**2. Request Citations:**
```markdown
[Task description]

Provide answer with citations:
- Each claim should reference source
- Link to documentation when available
- Note confidence level for each fact
```

**3. Use Comparative Analysis:**
```markdown
Compare [A] vs [B] vs [C]

For each, analyze:
- Strengths
- Weaknesses
- Use cases
- Recent developments (2026)

Create comparison table and recommend best option.
```

**4. Multimodal Integration:**
```markdown
[Task about visual design]

Describe the design, then:
1. Explain visual hierarchy
2. Discuss color theory application
3. Suggest improvements

If helpful, describe what a visual diagram would show.
```

**Best Practices:**
- Leverage massive context for comprehensive examples
- Request recent information (specify 2026)
- Use citations for verifiability
- Consider multimodal capabilities

---

## Optimization Level Selection Guide

### Decision Tree

```
START: Analyze the prompt
  ↓
Is it vague or unclear? ──Yes──→ Need optimization
  ↓ No
  ↓
Does it have specific output format? ──No──→ Need optimization
  ↓ Yes
  ↓
Is it complex (multi-step, technical)? ──No──→ Probably good enough
  ↓ Yes
  ↓
Does it use reasoning framework? ──No──→ Need optimization
  ↓ Yes
  ↓
High stakes or critical task? ──Yes──→ Add meta-cognitive layer
  ↓ No
  ↓
Prompt is well-optimized
```

### Level Selection by Need

**Choose Quick Boost when:**
- Time is limited (<15 minutes)
- Task is relatively simple
- Budget is tight (<2K tokens)
- Current prompt is "okay" but could be better

**Choose Deep Dive when:**
- Task is complex
- Quality matters
- Have moderate time (20-45 min)
- Budget allows (2-4K tokens)

**Choose Revolutionary when:**
- Mission-critical task
- Maximum quality required
- Time is available (45-90 min)
- Generous token budget (4-10K)

### Upgrade Path

Start with Quick Boost, then escalate if:
- Output quality insufficient
- Task more complex than expected
- Stakes higher than anticipated
- Token budget permits

**Progressive Enhancement:**
```
Quick Boost → Test → Satisfactory? → Done
              ↓ No
         Deep Dive → Test → Satisfactory? → Done
                     ↓ No
                Revolutionary → Done
```

---

## Task Classification System

### By Complexity

**Level 1: Simple**
- Single, clear task
- Minimal context needed
- Straightforward success criteria
- Examples: "Format this JSON", "Explain what REST API is"

**Recommended:** Quick Boost or no optimization

---

**Level 2: Moderate**
- Multi-step task
- Some context required
- Multiple considerations
- Examples: "Build a login form", "Debug this function"

**Recommended:** Deep Dive

---

**Level 3: Complex**
- Multi-dimensional problem
- Extensive context required
- Many interconnected factors
- Examples: "Design system architecture", "Optimize entire application"

**Recommended:** Revolutionary

---

### By Task Type

**Analytical Tasks:**
- Code review, debugging, performance analysis
- **Framework:** Chain-of-Thought
- **Techniques:** F4-Context, F5-Constraints, M1-SelfCorr

**Decision Tasks:**
- Architecture selection, tool comparison, trade-off analysis
- **Framework:** Tree-of-Thoughts
- **Techniques:** F4-Context, F5-Constraints, A6-MultiPersp

**System Tasks:**
- System design, integration planning, holistic optimization
- **Framework:** Graph-of-Thoughts
- **Techniques:** F4-Context, A6-MultiPersp, M3-CoVe

**Optimization Tasks:**
- Performance tuning, cost optimization, quality improvement
- **Framework:** Algorithm-of-Thoughts
- **Techniques:** F5-Constraints, M1-SelfCorr, M4-Validate

**Creative Tasks:**
- Content creation, UI design, naming/branding
- **Framework:** Tree-of-Thoughts
- **Techniques:** F1-Role, F6-Examples, M5-Reflect

**Instructional Tasks:**
- Tutorials, explanations, documentation
- **Framework:** Chain-of-Thought
- **Techniques:** F1-Role, F4-Context, F6-Examples

---

## Success Metrics

### Quality Dimensions

**1. Clarity (0-100)**
- Is the task unambiguous?
- Are all terms defined?
- Is structure logical?

**Measurement:**
- Can a human understand the prompt instantly? (+40)
- Are all instructions actionable? (+30)
- No conflicting requirements? (+30)

---

**2. Specificity (0-100)**
- Are requirements concrete?
- Are constraints explicit?
- Is success measurable?

**Measurement:**
- All "wh-" questions answered? (+30)
- Success criteria defined? (+30)
- Constraints specified? (+20)
- Examples provided? (+20)

---

**3. Effectiveness (0-100)**
- Does it produce desired output?
- Are techniques appropriate?
- Is framework suitable?

**Measurement:**
- Output matches requirements? (+40)
- Techniques aligned with task? (+30)
- No anti-patterns present? (+30)

---

**4. Token Efficiency (0-100)**
- Is token usage justified?
- Any redundancy?
- Optimal technique selection?

**Measurement:**
- No redundant instructions? (+30)
- Appropriate complexity for task? (+40)
- Achieves goals with minimal tokens? (+30)

---

### Quality Gates

**Minimum Acceptable (All Levels):**
- Clarity: ≥70
- Specificity: ≥60
- Effectiveness: ≥70
- Token Efficiency: ≥60

**Quick Boost Target:**
- Clarity: 75-85
- Specificity: 70-80
- Effectiveness: 75-85
- Token Efficiency: 70-85

**Deep Dive Target:**
- Clarity: 85-95
- Specificity: 85-95
- Effectiveness: 85-95
- Token Efficiency: 75-90

**Revolutionary Target:**
- Clarity: 95-100
- Specificity: 95-100
- Effectiveness: 95-100
- Token Efficiency: 85-95

---

## Dialogue Engine Deep Dive

### Progressive Questioning Strategy

**Stage 1: Surface Understanding (1-2 questions)**
- What is the main goal?
- What's the context?

**Stage 2: Requirement Extraction (2-4 questions)**
- What are must-haves vs. nice-to-haves?
- What constraints exist?
- What format is needed?

**Stage 3: Edge Case Identification (2-3 questions)**
- What could go wrong?
- What are the critical factors?
- What should be avoided?

**Stage 4: Validation (1-2 questions)**
- Did I understand correctly? [Summary]
- Anything missing?

### Question Templates

**Goal Templates:**
- "What specific outcome do you need from [task]?"
- "How will you measure success for [task]?"
- "What's the difference between adequate and excellent for this?"

**Audience Templates:**
- "Who will [use/read/implement] this?"
- "What's their expertise level in [domain]?"
- "What background can we assume they have?"

**Scope Templates:**
- "Should this cover [A, B, C] or focus on [subset]?"
- "What's the priority order of [requirements]?"
- "What's explicitly out of scope?"

**Format Templates:**
- "Do you need [format A] or [format B]?"
- "How will you use the output? [Use case influences format]"
- "Any specific structure requirements?"

**Critical Templates:**
- "What absolutely must be included?"
- "What must be avoided?"
- "What are the risks if we get this wrong?"

### Dialogue Execution

**Quick Boost:** 0-2 questions (only if critical info missing)

**Deep Dive:** 3-5 questions (cover Goal + Scope + Critical)

**Revolutionary:** 10-15 questions (all categories, with follow-ups)

**Batching Strategy:**
- Group related questions together
- Use multiple-choice when possible (faster responses)
- Explain why asking (increases cooperation)

---

## Dialogue Engine Implementation with AskUserQuestion Tool

### Overview

The Dialogue Engine uses the **AskUserQuestion tool** to create interactive, structured conversations that extract complete requirements efficiently. This section provides implementation guidance with code examples.

### Core Implementation Pattern

**Basic Flow:**

```
1. Detect user language (Vietnamese/English)
2. Analyze prompt complexity → Determine optimization level
3. Identify information gaps
4. Generate questions using AskUserQuestion tool
5. Process user responses
6. Check completeness
7. IF gaps remain → Generate follow-ups (GOTO 4)
8. ELSE → Proceed to Blueprint phase
```

### AskUserQuestion Tool Integration

**Tool Declaration:**

Lyra has `AskUserQuestion` in `allowed-tools` (SKILL.md), enabling structured interactive questions instead of raw text.

**Benefits over raw text:**
- ✅ Multiple choice options (faster user response)
- ✅ Structured data (easier to process)
- ✅ UI integration (dropdown/checkboxes)
- ✅ Validation built-in
- ✅ Better UX (like `/interview` command)

### Question Templates by Category

#### Category 1: Goal Clarification

**Template Structure:**

```json
{
  "questions": [
    {
      "id": "primary-goal",
      "prompt": "What is the primary goal of this prompt?",
      "options": [
        {"id": "generate-content", "label": "Generate content (articles, reports, stories)"},
        {"id": "generate-code", "label": "Generate code (functions, scripts, programs)"},
        {"id": "analyze-data", "label": "Analyze data (insights, patterns, summaries)"},
        {"id": "explain-concept", "label": "Explain concepts (teaching, documentation)"},
        {"id": "decision-support", "label": "Decision support (recommendations, comparisons)"},
        {"id": "creative-work", "label": "Creative work (brainstorming, ideation)"},
        {"id": "other", "label": "Other (please specify)"}
      ]
    },
    {
      "id": "success-criteria",
      "prompt": "How will you measure success for this prompt?",
      "options": [
        {"id": "accuracy", "label": "Accuracy and correctness of output"},
        {"id": "completeness", "label": "Completeness and thoroughness"},
        {"id": "creativity", "label": "Creativity and originality"},
        {"id": "speed", "label": "Fast generation time"},
        {"id": "clarity", "label": "Clarity and readability"},
        {"id": "actionability", "label": "Actionable and practical"}
      ]
    }
  ]
}
```

#### Category 2: Audience Definition

```json
{
  "questions": [
    {
      "id": "target-audience",
      "prompt": "Who will use or consume the output?",
      "options": [
        {"id": "technical-experts", "label": "Technical experts (engineers, developers)"},
        {"id": "business-professionals", "label": "Business professionals (managers, analysts)"},
        {"id": "general-public", "label": "General public (non-technical audience)"},
        {"id": "students", "label": "Students or learners"},
        {"id": "executives", "label": "Executives (decision makers)"},
        {"id": "mixed", "label": "Mixed audience"}
      ]
    },
    {
      "id": "expertise-level",
      "prompt": "What is their expertise level in the subject?",
      "options": [
        {"id": "beginner", "label": "Beginner (little to no knowledge)"},
        {"id": "intermediate", "label": "Intermediate (basic understanding)"},
        {"id": "advanced", "label": "Advanced (deep expertise)"},
        {"id": "expert", "label": "Expert (domain authority)"}
      ]
    }
  ]
}
```

#### Category 3: Context Exploration

```json
{
  "questions": [
    {
      "id": "use-context",
      "prompt": "In what context will this prompt be used?",
      "options": [
        {"id": "production", "label": "Production system (high reliability needed)"},
        {"id": "development", "label": "Development/testing (experimentation OK)"},
        {"id": "learning", "label": "Learning/education (pedagogical focus)"},
        {"id": "research", "label": "Research/exploration (open-ended)"},
        {"id": "automation", "label": "Automation/workflow (consistent results)"}
      ]
    },
    {
      "id": "platform-target",
      "prompt": "Which AI platform will use this prompt?",
      "options": [
        {"id": "claude", "label": "Claude (Anthropic) - Long context, reasoning"},
        {"id": "chatgpt", "label": "ChatGPT (OpenAI) - Conversational, creative"},
        {"id": "gemini", "label": "Gemini (Google) - Multimodal, 1M+ tokens"},
        {"id": "multiple", "label": "Multiple platforms (need cross-platform)"},
        {"id": "other", "label": "Other platform"}
      ]
    }
  ]
}
```

#### Category 4: Structural Preferences

```json
{
  "questions": [
    {
      "id": "output-format",
      "prompt": "What output format do you need?",
      "options": [
        {"id": "markdown", "label": "Markdown document (formatted text)"},
        {"id": "json", "label": "JSON (structured data)"},
        {"id": "code", "label": "Code with comments"},
        {"id": "plain-text", "label": "Plain text (simple)"},
        {"id": "xml", "label": "XML (structured tags)"},
        {"id": "mixed", "label": "Mixed format (combination)"}
      ]
    },
    {
      "id": "structure-preference",
      "prompt": "How should the output be structured?",
      "options": [
        {"id": "step-by-step", "label": "Step-by-step instructions"},
        {"id": "sections", "label": "Organized into sections"},
        {"id": "list", "label": "List or bullet points"},
        {"id": "narrative", "label": "Narrative or paragraph form"},
        {"id": "table", "label": "Table or matrix"},
        {"id": "flexible", "label": "Flexible (AI decides)"}
      ]
    }
  ]
}
```

#### Category 5: Criticality Assessment

```json
{
  "questions": [
    {
      "id": "criticality-level",
      "prompt": "How critical is this prompt's reliability?",
      "options": [
        {"id": "mission-critical", "label": "Mission-critical (production, high stakes)"},
        {"id": "important", "label": "Important (professional use)"},
        {"id": "moderate", "label": "Moderate (general use)"},
        {"id": "low", "label": "Low (experimentation)"}
      ]
    },
    {
      "id": "constraints",
      "prompt": "What are the main constraints?",
      "allow_multiple": true,
      "options": [
        {"id": "token-limit", "label": "Token/length limits"},
        {"id": "accuracy", "label": "Must be highly accurate"},
        {"id": "speed", "label": "Must be fast"},
        {"id": "consistency", "label": "Must be consistent"},
        {"id": "creativity", "label": "Must be creative"},
        {"id": "safety", "label": "Safety and ethics"},
        {"id": "none", "label": "No major constraints"}
      ]
    }
  ]
}
```

### Iteration Logic Implementation

**WHILE Loop Pattern (interview.md style):**

```
WHILE (information_incomplete):
    1. Analyze current knowledge state
    2. Identify specific gaps or ambiguities
    3. Generate targeted follow-up questions
    4. Call AskUserQuestion tool with questions
    5. Process user responses
    6. Update knowledge base
    7. Evaluate completeness:
       IF unclear_answer:
           Generate clarifying follow-up
       ELSE IF contradictory_answer:
           Generate disambiguation question
       ELSE IF gaps_remain:
           Continue loop
       ELSE:
           Break (proceed to Blueprint)
```

**Example Multi-Round Implementation:**

**Round 1: Initial Questions (Broad)**

```json
{
  "questions": [
    {
      "id": "goal",
      "prompt": "What is the primary goal?",
      "options": [
        {"id": "code", "label": "Generate code"},
        {"id": "explain", "label": "Explain concepts"},
        {"id": "analyze", "label": "Analyze data"}
      ]
    },
    {
      "id": "platform",
      "prompt": "Which AI platform?",
      "options": [
        {"id": "claude", "label": "Claude"},
        {"id": "chatgpt", "label": "ChatGPT"},
        {"id": "gemini", "label": "Gemini"}
      ]
    }
  ]
}
```

**User Response:** `{"goal": "code", "platform": "claude"}`

**Analysis:** 
- Goal: Code generation
- Platform: Claude → Use structured thinking, long context
- Missing: Language, complexity level, code style

**Round 2: Targeted Follow-ups**

```json
{
  "questions": [
    {
      "id": "language",
      "prompt": "Which programming language?",
      "options": [
        {"id": "python", "label": "Python"},
        {"id": "javascript", "label": "JavaScript/TypeScript"},
        {"id": "rust", "label": "Rust"},
        {"id": "go", "label": "Go"},
        {"id": "other", "label": "Other"}
      ]
    },
    {
      "id": "complexity",
      "prompt": "Code complexity level?",
      "options": [
        {"id": "simple", "label": "Simple scripts"},
        {"id": "moderate", "label": "Moderate (classes, modules)"},
        {"id": "complex", "label": "Complex (architecture, patterns)"}
      ]
    },
    {
      "id": "style",
      "prompt": "Code style preference?",
      "options": [
        {"id": "concise", "label": "Concise (minimal comments)"},
        {"id": "documented", "label": "Well-documented"},
        {"id": "verbose", "label": "Verbose (every step explained)"}
      ]
    }
  ]
}
```

**User Response:** `{"language": "python", "complexity": "moderate", "style": "documented"}`

**Analysis:**
- Complete understanding achieved
- Ready to proceed to Blueprint
- No further questions needed

### Error Handling Patterns

**Pattern 1: No Response from User**

```
IF user_timeout OR user_skips:
    Log: "User did not answer questions"
    Strategy: Proceed with best-guess defaults
    Mark as assumptions in Blueprint phase
    Document: "Assumed [X] based on context"
```

**Pattern 2: Unclear or Ambiguous Answer**

```
IF answer_unclear:
    Generate immediate clarification:
    {
      "questions": [{
        "id": "clarification",
        "prompt": "You mentioned [X]. Could you clarify: do you mean [interpretation A] or [interpretation B]?",
        "options": [
          {"id": "option-a", "label": "[Interpretation A]"},
          {"id": "option-b", "label": "[Interpretation B]"},
          {"id": "neither", "label": "Neither (let me explain)"}
        ]
      }]
    }
```

**Pattern 3: Contradictory Answers**

```
IF detect_contradiction(answer1, answer2):
    Generate disambiguation:
    {
      "questions": [{
        "id": "resolve-contradiction",
        "prompt": "You mentioned both [X] and [Y], which seem contradictory. Which takes priority?",
        "options": [
          {"id": "prioritize-x", "label": "[X] is more important"},
          {"id": "prioritize-y", "label": "[Y] is more important"},
          {"id": "balance", "label": "Balance both equally"}
        ]
      }]
    }
```

### Workflow by Optimization Level

#### Quick Boost Workflow (0-2 questions)

**Strategy:** Ask only if critical information missing

**Example:**

```json
{
  "questions": [
    {
      "id": "output-format",
      "prompt": "What output format do you need? (Critical for proper structuring)",
      "options": [
        {"id": "markdown", "label": "Markdown"},
        {"id": "json", "label": "JSON"},
        {"id": "plain", "label": "Plain text"}
      ]
    }
  ]
}
```

**Duration:** 30 seconds
**Processing:** Single-pass, proceed immediately

#### Deep Dive Workflow (3-5 questions)

**Strategy:** Cover Goal + Context + Constraints

**Round 1 (3 questions):**

```json
{
  "questions": [
    {"id": "goal", "prompt": "Primary goal?", "options": [...]},
    {"id": "platform", "prompt": "Target platform?", "options": [...]},
    {"id": "format", "prompt": "Output format?", "options": [...]}
  ]
}
```

**Round 2 (2 questions) - If needed:**

```json
{
  "questions": [
    {"id": "constraints", "prompt": "Key constraints?", "allow_multiple": true, "options": [...]},
    {"id": "criticality", "prompt": "Criticality level?", "options": [...]}
  ]
}
```

**Duration:** 2-4 minutes
**Processing:** 1-2 rounds with follow-ups

#### Revolutionary Workflow (10-15 questions)

**Strategy:** Comprehensive coverage across all 5 categories

**Round 1: Big Picture (5 questions)**
- Goal Clarification (2 questions)
- Audience Definition (2 questions)
- Context Exploration (1 question)

**Round 2: Technical Depth (4 questions)**
- Structural Preferences (2 questions)
- Platform specifics (1 question)
- Format requirements (1 question)

**Round 3: Quality Assurance (3 questions)**
- Criticality Assessment (1 question)
- Constraints (1 question with allow_multiple)
- Success criteria (1 question)

**Round 4: Refinement (2-3 questions)**
- Follow-ups based on previous answers
- Edge case handling
- Final clarifications

**Duration:** 5-10 minutes
**Processing:** 3-4 rounds with deep iteration

### Best Practices Summary

**DO:**
- ✅ Use AskUserQuestion tool instead of raw text
- ✅ Prefer multiple choice over open-ended
- ✅ Batch related questions (2-5 per call)
- ✅ Provide clear option labels
- ✅ Explain why asking ("To determine the best framework...")
- ✅ Follow up on unclear answers immediately
- ✅ Match user's language (Vietnamese/English)

**DON'T:**
- ❌ Ask obvious questions
- ❌ Overwhelm with 10+ questions at once
- ❌ Use technical jargon without context
- ❌ Ask redundant questions
- ❌ Mix languages in one question

**Validation:**
- All questions must have 2+ options
- IDs must be unique and descriptive
- Prompts must be clear and actionable
- Options must be mutually exclusive (unless allow_multiple)

---

## Vietnamese Support Patterns

### Bilingual Trigger Recognition

**English triggers:**
- "optimize this prompt"
- "improve my prompt"
- "make this better"
- "refine this prompt"

**Vietnamese triggers:**
- "tối ưu prompt"
- "cải thiện prompt"
- "làm tốt hơn"
- "sửa prompt"
- "prompt engineering"

### Bilingual Output Structure

**Pattern 1: Parallel Sections**
```markdown
## Section Title

**English:** [Content in English]

**Tiếng Việt:** [Content in Vietnamese]
```

**Pattern 2: Inline Translation**
```markdown
Chain-of-Thought (Chuỗi Suy Nghĩ): [Explanation]
```

**Pattern 3: Dedicated Vietnamese Files**
- Reference to `vietnamese-guide.md`
- Examples in `examples/vietnamese/`

### Cultural Adaptation

**Vietnamese learners prefer:**
- Concrete examples over abstract theory
- Step-by-step instructions
- Visual analogies ("giống như...")
- Practical applications

**Adaptation strategies:**
- Use familiar metaphors (chuỗi hạt, cây quyết định, bản đồ tư duy)
- Provide "Mẹo nhớ" (memory tips)
- Include "Khi nào dùng" (when to use) sections
- Explain "Tại sao" (why it works)

---

## Integration Points

### With Cursor IDE

**Commands integration:**
- `/interview` can invoke Lyra for requirement gathering
- `/phase-plan` can use Lyra to optimize planning prompts
- `/council` can use Lyra to optimize agent instructions

### With Other Skills

**Complementary skills:**
- `grammar-learning`: Optimize English correctness
- `claudeception`: Extract learned patterns
- `frontend-design`: Optimize design brief prompts

### With GLOBAL_RULE.md

**Alignment:**
- Respects task classification (Lightweight, Standard, Critical)
- Follows conflict resolution hierarchy
- Adheres to output standards
- Uses approved tools (Read, Grep, AskUserQuestion)

---

## Anti-Pattern Prevention

### Detection Rules

**Rule 1: Prompt Too Short (<50 tokens)**
- Likely missing context or constraints
- **Fix:** Apply Foundation layer

**Rule 2: Prompt Too Long (>5000 tokens)**
- Likely over-instructed or redundant
- **Fix:** Distill to essentials

**Rule 3: No Output Format**
- Output will be inconsistent
- **Fix:** Add Format Specification

**Rule 4: Vague Task**
- Contains "good", "better", "optimize" without criteria
- **Fix:** Define measurable success criteria

**Rule 5: Wrong Framework**
- Using GoT for simple linear task
- Using CoT for multi-alternative decision
- **Fix:** Consult framework decision tree

### Prevention Strategies

1. **Checklist usage:** Complete implementation checklist before finalizing
2. **Peer review:** Test with another AI model
3. **Validation:** Run through quality gates
4. **Examples:** Compare to similar successful prompts

---

## Practical Workflow

### End-to-End Optimization (Deep Dive Example)

**Input:** "Make my API faster"

**Step 1: Dialogue** (Category questions)
- Goal: What metric? (Latency, throughput, cost?)
- Context: Current performance? Tech stack?
- Scope: Which endpoints? All or specific?
- Format: Code changes or architecture recommendations?
- Critical: Any constraints? (Budget, no breaking changes?)

**Step 2: Blueprint** (After answers)
- Task type: Optimization task
- Framework: Algorithm-of-Thoughts (iterative refinement)
- Techniques: F4-Context, F5-Constraints, A4-AoT, M1-SelfCorr
- Platform: Claude (assume)

**Step 3: Synthesis** (Build prompt)
```markdown
You are a senior backend engineer specializing in API performance optimization.

Context:
- Current API: Express.js with PostgreSQL
- Performance: p95 latency 800ms (target: <200ms)
- Endpoints: User CRUD (most traffic on GET /users)
- Constraints: No database migration, budget <$100/month additional cost

Use Algorithm-of-Thoughts to optimize:

Iteration 1: Analyze current bottlenecks
- Profile top 3 slow endpoints
- Identify root causes
- Propose improvements

Iteration 2: Apply optimizations
- Implement changes
- Measure new performance
- Calculate improvement delta

Continue until target latency achieved or diminishing returns (<10% improvement).

Output format:
- Iteration log (bottleneck → solution → result)
- Final optimized code
- Performance comparison table
- Cost impact

Validate: Ensure all constraints satisfied.
```

**Step 4: Refinement** (Test and improve)
- Run prompt with Claude
- Evaluate output quality
- Identify gaps (missing error handling?)
- Refine prompt
- Re-test

**Result:** Optimized prompt achieving 85+ on all quality metrics

---

## Summary

**Core Concepts Covered:**

1. **4D Methodology:** Dialogue → Blueprint → Synthesis → Refinement
2. **3 Optimization Levels:** Quick Boost ⚡, Deep Dive 🔍, Revolutionary 🚀
3. **Dialogue Engine:** 5 question categories for requirement extraction
4. **Platform Optimization:** Claude, ChatGPT, Gemini-specific strategies
5. **Task Classification:** By complexity and type
6. **Success Metrics:** 4 quality dimensions with scoring
7. **Quality Gates:** Minimum standards for each level
8. **Vietnamese Support:** Bilingual patterns and cultural adaptation

**Key Principles:**

- **Match complexity to task:** Don't over-optimize simple prompts
- **Layer techniques:** Foundation → Advanced → Meta-Cognitive
- **Measure impact:** Use quality metrics to validate improvements
- **Platform matters:** Optimize for target AI platform
- **Iterate to quality:** Refine until quality gates met

**Next Steps:**
- Study `reasoning-frameworks.md` for framework details
- Review `optimization-toolkit.md` for technique catalog
- See `anti-patterns.md` to avoid common mistakes
- Practice with `examples/` at each complexity level

---

**Document Version:** 1.0.0  
**Last Updated:** 2026-02-05  
**Related:** `reasoning-frameworks.md`, `optimization-toolkit.md`, `anti-patterns.md`, `vietnamese-guide.md`
