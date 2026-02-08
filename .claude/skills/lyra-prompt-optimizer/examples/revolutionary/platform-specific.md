# Revolutionary Example: Platform-Specific Optimization

## Optimization Level: 🚀 Revolutionary

**Focus:** Platform-specific optimization for Claude, ChatGPT, Gemini  
**Time Required:** 45-90 minutes per platform  
**Expected Impact:** +40-80% platform utilization, leveraging unique strengths

---

## Why Platform-Specific Optimization Matters

**Each AI platform has:**
- Different context limits (Claude 200K, ChatGPT 128K, Gemini 1M)
- Different strengths (Claude reasoning, ChatGPT code, Gemini search)
- Different syntax preferences (XML vs markdown vs structured)
- Different capabilities (thinking blocks, function calling, multimodal)

**Generic prompts waste platform potential.**  
**Platform-optimized prompts leverage unique capabilities.**

---

## Phase 1: Comprehensive Interactive Dialogue (Revolutionary)

**Optimization Level:** Revolutionary (13-15 questions across 4 rounds)

**Strategy for Platform-Specific:**
- Round 1: Platform & Task Context (Platform, Goal, Complexity) - 5 questions
- Round 2: Platform Capabilities (Features, Constraints, Preferences) - 4 questions
- Round 3: Optimization Targets (What to leverage, What to avoid) - 3 questions
- Round 4: Output Format (Platform-specific delivery) - 2 questions

### Round 1: Platform & Task Context (5 questions)

**Initial Prompt:** "Analyze this 5,000-line legacy codebase and provide refactoring strategy."

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "target-platform",
      "prompt": "Which AI platform will you use for this task?",
      "options": [
        {"id": "claude", "label": "Claude (Anthropic) - Best for reasoning & analysis"},
        {"id": "chatgpt", "label": "ChatGPT (OpenAI) - Best for code generation"},
        {"id": "gemini", "label": "Gemini (Google) - Best for search & multimodal"},
        {"id": "multiple", "label": "Multiple platforms (need optimization for each)"},
        {"id": "undecided", "label": "Undecided (need recommendation)"}
      ]
    },
    {
      "id": "task-type",
      "prompt": "What type of code analysis task is this?",
      "options": [
        {"id": "refactoring-strategy", "label": "Refactoring strategy (high-level approach)"},
        {"id": "code-review", "label": "Code review (detailed analysis)"},
        {"id": "bug-hunting", "label": "Bug hunting (find issues)"},
        {"id": "modernization", "label": "Modernization (upgrade tech stack)"},
        {"id": "comprehensive", "label": "Comprehensive (all of the above)"}
      ]
    },
    {
      "id": "codebase-size",
      "prompt": "How large is the codebase to analyze?",
      "options": [
        {"id": "small", "label": "Small (< 1K lines, fits in one context)"},
        {"id": "medium", "label": "Medium (1K-5K lines, single context)"},
        {"id": "large", "label": "Large (5K-20K lines, needs chunking)"},
        {"id": "massive", "label": "Massive (20K+ lines, strategic analysis)"}
      ]
    },
    {
      "id": "code-quality",
      "prompt": "What is the current code quality?",
      "options": [
        {"id": "well-structured", "label": "Well-structured (clear, documented)"},
        {"id": "acceptable", "label": "Acceptable (some tech debt)"},
        {"id": "poor", "label": "Poor (spaghetti code, no docs)"},
        {"id": "critical", "label": "Critical (unmaintainable, risky)"}
      ]
    },
    {
      "id": "language-stack",
      "prompt": "What programming language and stack?",
      "options": [
        {"id": "python", "label": "Python (Django, Flask, FastAPI)"},
        {"id": "javascript", "label": "JavaScript/TypeScript (Node, React, Vue)"},
        {"id": "java", "label": "Java (Spring, Hibernate)"},
        {"id": "csharp", "label": "C# (.NET, ASP.NET)"},
        {"id": "php", "label": "PHP (Laravel, Symfony, Legacy)"},
        {"id": "other", "label": "Other (specify in follow-up)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "target-platform": "claude",
  "task-type": "comprehensive",
  "codebase-size": "large",
  "code-quality": "poor",
  "language-stack": "php"
}
```

**Analysis:**
- Platform: Claude → Leverage reasoning, XML tags, thinking blocks
- Task: Comprehensive analysis (all aspects)
- Size: Large (5K-20K lines) → Need chunking strategy
- Quality: Poor → Needs systematic analysis
- Stack: PHP (legacy) → Modernization opportunity

### Round 2: Platform Capabilities (4 questions)

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "claude-features",
      "prompt": "Which Claude-specific features should we leverage?",
      "allow_multiple": true,
      "options": [
        {"id": "extended-thinking", "label": "Extended thinking blocks (reasoning chains)"},
        {"id": "xml-structure", "label": "XML tags (structured analysis)"},
        {"id": "large-context", "label": "Large context (200K tokens)"},
        {"id": "artifacts", "label": "Artifacts (structured outputs)"},
        {"id": "system-prompts", "label": "System prompts (role-based)"},
        {"id": "all", "label": "All capabilities (maximum optimization)"}
      ]
    },
    {
      "id": "analysis-depth",
      "prompt": "How deep should the analysis be?",
      "options": [
        {"id": "surface", "label": "Surface level (quick overview)"},
        {"id": "moderate", "label": "Moderate (main issues and recommendations)"},
        {"id": "deep", "label": "Deep (detailed analysis with examples)"},
        {"id": "exhaustive", "label": "Exhaustive (comprehensive, file-by-file)"}
      ]
    },
    {
      "id": "chunking-strategy",
      "prompt": "How should we handle the large codebase?",
      "options": [
        {"id": "full-context", "label": "Full context (send all 5K-20K lines)"},
        {"id": "strategic-chunks", "label": "Strategic chunks (key files first)"},
        {"id": "iterative", "label": "Iterative (multiple passes)"},
        {"id": "summary-first", "label": "Summary first (overview, then deep dives)"}
      ]
    },
    {
      "id": "output-structure",
      "prompt": "What output structure works best for your workflow?",
      "options": [
        {"id": "markdown-report", "label": "Markdown report (readable documentation)"},
        {"id": "xml-structured", "label": "XML structured (machine-parseable)"},
        {"id": "artifact", "label": "Claude Artifact (interactive)"},
        {"id": "mixed", "label": "Mixed (report + structured data)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "claude-features": ["all"],
  "analysis-depth": "exhaustive",
  "chunking-strategy": "summary-first",
  "output-structure": "mixed"
}
```

**Analysis:**
- Features: All (maximum optimization) → Use thinking, XML, artifacts
- Depth: Exhaustive → Comprehensive analysis required
- Chunking: Summary first → Strategic approach for large codebase
- Output: Mixed → Report + structured data for actionability

### Round 3: Optimization Targets (3 questions)

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "refactoring-priorities",
      "prompt": "What are the refactoring priorities?",
      "allow_multiple": true,
      "options": [
        {"id": "security", "label": "Security (vulnerabilities, best practices)"},
        {"id": "performance", "label": "Performance (speed, efficiency)"},
        {"id": "maintainability", "label": "Maintainability (readability, structure)"},
        {"id": "testability", "label": "Testability (test coverage, design)"},
        {"id": "scalability", "label": "Scalability (architecture, patterns)"},
        {"id": "modernization", "label": "Modernization (upgrade stack)"}
      ]
    },
    {
      "id": "constraints",
      "prompt": "What constraints exist for this refactoring?",
      "allow_multiple": true,
      "options": [
        {"id": "no-breaking-changes", "label": "No breaking changes (maintain compatibility)"},
        {"id": "limited-time", "label": "Limited time (quick wins)"},
        {"id": "small-team", "label": "Small team (limited resources)"},
        {"id": "production-system", "label": "Production system (zero downtime)"},
        {"id": "budget", "label": "Budget constraints (cost-effective)"},
        {"id": "none", "label": "No major constraints"}
      ]
    },
    {
      "id": "success-criteria",
      "prompt": "How will you measure refactoring success?",
      "allow_multiple": true,
      "options": [
        {"id": "code-metrics", "label": "Code metrics (complexity, coverage)"},
        {"id": "team-velocity", "label": "Team velocity (faster development)"},
        {"id": "bug-reduction", "label": "Bug reduction (fewer issues)"},
        {"id": "performance-gain", "label": "Performance gain (faster execution)"},
        {"id": "maintainability", "label": "Maintainability (easier changes)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "refactoring-priorities": ["security", "maintainability", "modernization"],
  "constraints": ["production-system", "small-team"],
  "success-criteria": ["code-metrics", "team-velocity", "maintainability"]
}
```

**Analysis:**
- Priorities: Security, Maintainability, Modernization (not performance)
- Constraints: Production system (zero downtime), Small team (limited capacity)
- Success: Metrics, Velocity, Maintainability → Measurable improvements

### Round 4: Output Format (2 questions)

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "deliverable-format",
      "prompt": "What deliverables do you need from the analysis?",
      "allow_multiple": true,
      "options": [
        {"id": "executive-summary", "label": "Executive summary (high-level overview)"},
        {"id": "detailed-report", "label": "Detailed report (full analysis)"},
        {"id": "action-plan", "label": "Action plan (prioritized tasks)"},
        {"id": "code-examples", "label": "Code examples (before/after)"},
        {"id": "risk-assessment", "label": "Risk assessment (what could go wrong)"},
        {"id": "timeline", "label": "Timeline (phased approach)"}
      ]
    },
    {
      "id": "claude-optimization",
      "prompt": "Should the prompt be optimized specifically for Claude's strengths?",
      "options": [
        {"id": "yes-maximum", "label": "Yes - Maximum optimization (leverage all Claude features)"},
        {"id": "yes-moderate", "label": "Yes - Moderate (use key features)"},
        {"id": "generic", "label": "No - Keep generic (platform-agnostic)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "deliverable-format": ["executive-summary", "detailed-report", "action-plan", "risk-assessment"],
  "claude-optimization": "yes-maximum"
}
```

### Final Understanding (15 questions total)

**Platform-Specific Optimization for Claude:**

**Context:**
- Platform: Claude (Anthropic)
- Task: Comprehensive code analysis (refactoring, review, modernization)
- Codebase: Large (5K-20K lines), Poor quality, PHP (legacy)

**Claude-Specific Leverage:**
- Features: All capabilities (thinking blocks, XML, large context, artifacts)
- Depth: Exhaustive analysis
- Chunking: Summary-first approach (overview → deep dives)
- Output: Mixed (markdown report + structured XML/artifacts)

**Refactoring Focus:**
- Priorities: Security, Maintainability, Modernization
- Constraints: Production system (zero downtime), Small team
- Success Metrics: Code metrics, Team velocity, Maintainability

**Deliverables:**
- Executive Summary (for stakeholders)
- Detailed Report (for engineers)
- Action Plan (prioritized tasks)
- Risk Assessment (what could go wrong)

**Optimization Strategy:**
Create Revolutionary-level prompt optimized specifically for Claude:
- Use `<thinking>` blocks for reasoning chains
- Structure analysis with XML tags (`<security>`, `<maintainability>`, etc.)
- Leverage 200K context for full codebase analysis
- Generate artifacts for interactive reports
- Include system prompt for role-based expertise

**Result:** Platform-optimized prompt that leverages Claude's unique capabilities for maximum analysis quality.

---

## Example Task: Complex Code Refactoring Analysis

**Generic Task:** Analyze this 5,000-line legacy codebase and provide refactoring strategy.

We'll optimize this for **each platform separately**.

---

## Platform 1: Claude (Anthropic) Optimization

### Claude's Unique Strengths

1. **Long context (200K tokens)** - Can handle entire codebases
2. **Excellent reasoning** - Best for complex analysis
3. **XML structure** - Explicit thinking tags
4. **Thinking blocks** - Shows reasoning process
5. **Constitutional AI** - Strong safety/ethics
6. **Multi-turn refinement** - Great for iterative work

### Generic Prompt (Underutilized)

```
Analyze this codebase and suggest refactorings:

[5000 lines of code]
```

**Problems:**
- No explicit reasoning requested
- No structure leveraging XML
- Doesn't use thinking blocks
- Wastes long context capability

---

### Claude-Optimized Prompt (Revolutionary)

```xml
<instructions>
You are a senior software architect specializing in legacy code modernization.

Analyze the complete codebase below using systematic reasoning.
Show your thinking process explicitly.

Use these thinking blocks:
- <analysis> for code examination
- <patterns> for anti-pattern identification
- <strategy> for refactoring approach
- <priorities> for ranking interventions
</instructions>

<context>
**Project Context:**
- 10-year-old PHP application
- 5,000 lines of code
- Symptoms: Hard to maintain, slow feature velocity
- Goal: Modernize without rewrite
- Constraints: Must stay PHP, 3-month timeline
</context>

<codebase>
[Full 5,000 lines of code - Claude can handle it]
</codebase>

<task>
Perform comprehensive refactoring analysis:

Phase 1: <analysis>
- Read through entire codebase
- Identify structural patterns
- Note coupling hotspots
- List code smells
- Quantify technical debt

Phase 2: <patterns>
- Categorize anti-patterns found
- Assess severity (critical/high/medium/low)
- Estimate impact of each

Phase 3: <strategy>
- Design refactoring roadmap
- Group related changes
- Identify dependencies
- Plan incremental approach

Phase 4: <priorities>
- Rank interventions by impact/effort
- Suggest month-by-month plan
- Include testing strategy
- Provide success metrics
</task>

<output_format>
# Refactoring Analysis

## Executive Summary
[High-level findings and recommendation]

## Detailed Analysis
[From <analysis> thinking block]

## Anti-Patterns Identified
[From <patterns> thinking block]

## Refactoring Strategy
[From <strategy> thinking block]

## Prioritized Roadmap
[From <priorities> thinking block]

## Appendix: Code Examples
[Specific examples with before/after]
</output_format>

<thinking_instructions>
Use explicit thinking blocks to show your reasoning:

<analysis>
[Your detailed code analysis here]
</analysis>

<patterns>
[Anti-pattern identification with examples]
</patterns>

<strategy>
[Strategic refactoring approach]
</strategy>

<priorities>
[Prioritization with justification]
</priorities>

Then provide final output in the specified format.
</thinking_instructions>
```

**Claude-Specific Optimizations:**

1. ✅ **XML Tags:** Explicit structure (`<instructions>`, `<context>`, `<task>`)
2. ✅ **Full Context:** Entire 5K LOC (Claude handles 200K easily)
3. ✅ **Thinking Blocks:** Requests explicit reasoning with named blocks
4. ✅ **Phased Analysis:** Leverages Claude's strong reasoning
5. ✅ **Long-Form Output:** Claude excels at comprehensive analysis

**Expected Output:**
- Complete analysis with visible reasoning
- 3,000-5,000 word comprehensive report
- Explicit thinking process shown
- High-quality strategic recommendations

**Token Usage:** ~25K tokens (prompt + response)  
**Quality:** 95/100 (maximizes Claude's strengths)

---

## Platform 2: ChatGPT (OpenAI) Optimization

### ChatGPT's Unique Strengths

1. **Fast response** - Quick iterations
2. **Excellent code generation** - Best for implementation
3. **Function calling** - Structured outputs
4. **System/User separation** - Clear role assignment
5. **JSON mode** - Structured data
6. **Good at following formats** - Consistent outputs

### Generic Prompt (Underutilized)

```
Analyze this code and suggest refactorings:
[code]
```

**Problems:**
- No system message (misses role context)
- No structured output
- Doesn't leverage function calling
- Too vague

---

### ChatGPT-Optimized Prompt (Revolutionary)

**System Message:**
```
You are a senior software architect and refactoring expert with 15 years
of experience modernizing legacy PHP applications.

Your analysis style:
- Systematic and thorough
- Actionable recommendations
- Prioritized by impact/effort
- Includes code examples

You always provide structured output in JSON format when requested.
```

**User Message:**
```
Analyze the following PHP codebase for refactoring opportunities.

**Code:**
[Paste 5,000 lines - or split into chunks if >128K context]

**Context:**
- Age: 10 years old
- Size: 5,000 lines
- Problem: Hard to maintain, slow feature velocity
- Goal: Modernize without full rewrite
- Constraints: Stay in PHP, 3-month timeline

**Analysis Required:**

1. **Code Quality Assessment**
   - Identify anti-patterns
   - Rate overall quality (1-10)
   - List top 5 issues by severity

2. **Refactoring Opportunities**
   - Extract classes from god objects
   - Reduce coupling
   - Improve naming
   - Add type hints
   - Modernize patterns

3. **Implementation Plan**
   - Month 1 priorities
   - Month 2 priorities
   - Month 3 priorities
   - Estimated effort for each

**Output Format:**

Provide response as JSON:

{
  "executive_summary": {
    "quality_score": "1-10",
    "overall_assessment": "string",
    "top_priority": "string"
  },
  "anti_patterns": [
    {
      "name": "string",
      "severity": "critical|high|medium|low",
      "locations": ["file:line"],
      "impact": "string",
      "fix_effort": "hours"
    }
  ],
  "refactoring_roadmap": [
    {
      "month": 1,
      "priority": "high|medium|low",
      "task": "string",
      "effort_hours": number,
      "expected_impact": "string",
      "before_code": "string",
      "after_code": "string"
    }
  ],
  "success_metrics": ["string"]
}

Provide complete, valid JSON. No additional text outside JSON.
```

**ChatGPT-Specific Optimizations:**

1. ✅ **System Message:** Clear role and style
2. ✅ **JSON Output:** Structured, parseable data
3. ✅ **Numbered Lists:** ChatGPT follows these well
4. ✅ **Code Examples:** Before/after in JSON (ChatGPT excels at code)
5. ✅ **Action-Oriented:** Implementation focus (ChatGPT's strength)

**Expected Output:**
```json
{
  "executive_summary": {
    "quality_score": "4/10",
    "overall_assessment": "Legacy codebase with significant technical debt...",
    "top_priority": "Extract UserController god object (affects 60% of features)"
  },
  "anti_patterns": [
    {
      "name": "God Object (UserController)",
      "severity": "critical",
      "locations": ["UserController.php:1-850"],
      "impact": "Blocks parallel development, causes merge conflicts",
      "fix_effort": "40 hours"
    },
    ...
  ],
  "refactoring_roadmap": [
    {
      "month": 1,
      "priority": "high",
      "task": "Extract UserController into 5 smaller controllers",
      "effort_hours": 40,
      "expected_impact": "Enable parallel work, reduce conflicts by 80%",
      "before_code": "class UserController { // 850 lines...",
      "after_code": "class UserProfileController { // 150 lines..."
    },
    ...
  ],
  "success_metrics": [
    "Average class size < 200 lines",
    "Cyclomatic complexity < 10",
    "Test coverage > 70%"
  ]
}
```

**Token Usage:** ~15K tokens (more concise than Claude)  
**Quality:** 88/100 (great for structured output)

---

## Platform 3: Gemini (Google) Optimization

### Gemini's Unique Strengths

1. **Massive context (1M tokens)** - Largest context window
2. **Integrated search** - Can look up current info
3. **Multimodal** - Handles images/diagrams
4. **Strong at comparison** - Side-by-side analysis
5. **Recent info** - Knows 2026 best practices
6. **Citation support** - Can link sources

### Generic Prompt (Underutilized)

```
Analyze code and suggest refactorings.
[code]
```

**Problems:**
- Doesn't leverage search
- Misses multimodal (could include architecture diagrams)
- No request for citations/sources
- Doesn't ask for 2026 best practices

---

### Gemini-Optimized Prompt (Revolutionary)

```
You are a senior software architect specializing in PHP modernization.

**Task:** Analyze this 5,000-line legacy PHP codebase and provide
comprehensive refactoring strategy aligned with 2026 best practices.

**Code:**
[Full 5,000 lines - Gemini handles 1M tokens easily]

**Analysis Approach:**

**Part 1: Research Current Best Practices (Use Search)**
Search for and summarize:
- "PHP 8.3 refactoring best practices 2026"
- "Legacy PHP modernization strategies 2026"
- "PHP design patterns 2026"

Cite sources for recommendations.

**Part 2: Code Quality Assessment**
Analyze the codebase against 2026 standards:
- Compare to modern PHP 8.3+ patterns
- Identify outdated practices
- Rate quality (1-10) with justification

**Part 3: Anti-Pattern Identification**
For each anti-pattern found:
- Name and describe
- Show code example
- Cite modern alternative from research
- Link to documentation/articles

**Part 4: Refactoring Strategy**
Create visual representation (describe as text-based diagram):
- Current architecture (boxes and arrows)
- Target architecture (boxes and arrows)
- Migration path (steps with timelines)

**Part 5: Prioritized Roadmap**
Create comparison table:

| Priority | Task | Current State | Target State | Effort | Impact | 2026 Std? |
|----------|------|---------------|--------------|--------|--------|-----------|
| High     | ... | ... | ... | ... | ... | Yes/No |

**Part 6: Implementation Examples**
For top 3 priorities:
- Show current code
- Show refactored code (PHP 8.3+)
- Cite PHP documentation
- Include type hints, attributes, etc.

**Output Format:**
Structured markdown with:
- Headers for each section
- Tables for comparisons
- Code blocks with syntax highlighting
- Citations as footnotes
- Text-based diagrams

**Success Criteria:**
- All recommendations cite 2026 sources
- Refactored code uses PHP 8.3+ features
- Migration path is realistic (3 months)
- Aligns with industry best practices
```

**Gemini-Specific Optimizations:**

1. ✅ **Search Integration:** Explicitly requests current research
2. ✅ **Massive Context:** Full codebase + research results (1M tokens)
3. ✅ **Citations:** Requests sources for credibility
4. ✅ **2026 Context:** Explicitly mentions current year
5. ✅ **Comparison Tables:** Gemini excels at structured comparisons
6. ✅ **Visual Descriptions:** Requests text-based diagrams (multimodal-friendly)

**Expected Output:**
```markdown
# PHP Codebase Refactoring Analysis (2026)

## Part 1: Current Best Practices Research

Based on search results from:
- "PHP 8.3 Refactoring Guide" (php.net, 2026)¹
- "Modern PHP Architecture Patterns" (Laravel News, 2026)²
- "Legacy PHP Migration Strategy" (Symfony Blog, 2025)³

Key findings:
- PHP 8.3 introduces promoted properties and readonly classes
- Attributes are now standard for metadata (replacing annotations)
- Union types and intersection types improve type safety
- ...

## Part 2: Code Quality Assessment

**Quality Score: 3/10**

Justification:
- Uses PHP 5.6 patterns (deprecated since 2018)
- No type hints (introduced in PHP 7.0)
- No attributes (available since PHP 8.0)
- Not leveraging readonly/promoted properties (PHP 8.1+)

## Part 3: Anti-Patterns Identified

### Anti-Pattern 1: Global State (Singleton Abuse)

**Current Code:**
\`\`\`php
class Database {
    private static $instance;
    public static function getInstance() { ... }
}
\`\`\`

**Modern Alternative (2026):**
\`\`\`php
// Use dependency injection with readonly properties (PHP 8.1+)
class UserService {
    public function __construct(
        private readonly Database $db
    ) {}
}
\`\`\`

**Reference:** PHP 8.1 Readonly Properties⁴, DI Best Practices 2026⁵

[Continues with detailed analysis, citations, tables, etc.]

---

**Citations:**
¹ https://www.php.net/releases/8.3/
² https://laravel-news.com/modern-php-2026
³ https://symfony.com/blog/legacy-migration
⁴ https://www.php.net/manual/en/language.oop5.properties.php
⁵ https://example.com/di-best-practices-2026
```

**Token Usage:** ~40K tokens (includes search results)  
**Quality:** 92/100 (most current, well-researched)

---

## Platform Comparison Summary

| Feature | Claude | ChatGPT | Gemini |
|---------|--------|---------|--------|
| **Context** | 200K (Large) | 128K (Medium) | 1M (Massive) |
| **Reasoning** | Excellent | Good | Good |
| **Code Gen** | Good | Excellent | Good |
| **Structure** | XML tags | System/User | Markdown |
| **Thinking** | Explicit blocks | Implicit | Implicit |
| **Search** | No | No | Yes |
| **Multimodal** | No | Yes (limited) | Yes |
| **Citations** | No | No | Yes |
| **JSON** | Manual | Native | Manual |
| **Best For** | Complex reasoning | Code generation | Research + comparison |

---

## Platform Selection Decision Tree

```
Is the task primarily code generation?
  → YES: ChatGPT (fastest, best code quality)
  → NO: Continue

Does it require complex multi-step reasoning?
  → YES: Claude (best reasoning, thinking blocks)
  → NO: Continue

Do you need current information (2026)?
  → YES: Gemini (search integration, citations)
  → NO: Continue

Is context > 200K tokens?
  → YES: Gemini (1M context)
  → NO: Claude or ChatGPT

Need structured JSON output?
  → YES: ChatGPT (native JSON mode)
  → NO: Any platform

Default: Claude (most versatile)
```

---

## Multi-Platform Strategy

**For maximum quality, use ALL platforms:**

1. **Claude:** Deep reasoning and strategy (refactoring approach)
2. **ChatGPT:** Implementation code (actual refactored code)
3. **Gemini:** Research and validation (2026 best practices check)

**Example Workflow:**
1. Claude: Analyze codebase → Strategic refactoring plan
2. Gemini: Research 2026 PHP best practices → Validate Claude's recommendations
3. ChatGPT: Generate actual refactored code → Implement plan

**Combined Quality:** 97/100 (leverages all strengths)

---

## Summary

**Platform-Specific Optimization Philosophy:** Match prompt structure to platform capabilities.

**Key Optimizations:**

**Claude:**
- XML structure
- Explicit thinking blocks
- Long-form analysis
- Multi-phase reasoning

**ChatGPT:**
- System message separation
- JSON mode for structured output
- Code-focused tasks
- Fast iterations

**Gemini:**
- Search integration
- Citations for credibility
- Massive context (1M)
- Comparison tables
- 2026 context awareness

**Impact:**
- **Platform Utilization:** +40-80%
- **Output Quality:** +30-60%
- **Appropriate Tool:** Always using best platform for task

**Key Takeaway:** Generic prompts waste platform potential. Platform-optimized prompts leverage unique strengths for superior results.

---

**Related Examples:**
- `multi-framework.md` - Combining frameworks
- `graph-of-thoughts.md` - Complex reasoning
- `../deep-dive/chain-of-thought.md` - Reasoning structure

**Related References:**
- `../../references/core-concepts.md` - Platform-specific section
- `../../references/optimization-toolkit.md` - Platform recommendations
- `../../references/reasoning-frameworks.md` - Framework platform fit
