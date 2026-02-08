# Question Library for AskUserQuestion Tool

Comprehensive library of ready-to-use questions organized by category, optimization level, and language (English/Vietnamese).

---

## Overview

This library provides **copy-paste ready questions** for Lyra's interactive dialogue across all 5 categories:
1. Goal Clarification
2. Audience Definition
3. Context Exploration
4. Structural Preferences
5. Criticality Assessment

**Usage:**
- Select questions matching your optimization level
- Customize options as needed
- Combine multiple questions in a single AskUserQuestion call
- Use bilingual templates for Vietnamese users

---

## Category 1: Goal Clarification

### Universal Goal Question (All Levels)

**English:**
```json
{
  "id": "primary-goal",
  "prompt": "What is your primary goal?",
  "options": [
    {"id": "learn", "label": "Learn something new"},
    {"id": "build", "label": "Build/create something"},
    {"id": "solve", "label": "Solve a specific problem"},
    {"id": "optimize", "label": "Optimize/improve existing work"},
    {"id": "decide", "label": "Make a decision"},
    {"id": "other", "label": "Other (please specify)"}
  ]
}
```

**Vietnamese:**
```json
{
  "id": "muc-tieu-chinh",
  "prompt": "Mục tiêu chính của bạn là gì?",
  "options": [
    {"id": "learn", "label": "Học điều gì đó mới"},
    {"id": "build", "label": "Xây dựng/tạo ra cái gì đó"},
    {"id": "solve", "label": "Giải quyết vấn đề cụ thể"},
    {"id": "optimize", "label": "Tối ưu/cải thiện công việc hiện tại"},
    {"id": "decide", "label": "Đưa ra quyết định"},
    {"id": "other", "label": "Khác (vui lòng nêu rõ)"}
  ]
}
```

### Code/Programming Goals

**English:**
```json
{
  "id": "code-goal",
  "prompt": "What do you want to accomplish with code?",
  "options": [
    {"id": "new-feature", "label": "Build a new feature"},
    {"id": "fix-bug", "label": "Fix a bug or issue"},
    {"id": "refactor", "label": "Refactor/improve existing code"},
    {"id": "learn-concept", "label": "Learn a programming concept"},
    {"id": "automate", "label": "Automate a task"},
    {"id": "optimize-performance", "label": "Optimize performance"}
  ]
}
```

**Vietnamese:**
```json
{
  "id": "muc-tieu-code",
  "prompt": "Bạn muốn làm gì với code?",
  "options": [
    {"id": "new-feature", "label": "Xây tính năng mới"},
    {"id": "fix-bug", "label": "Sửa lỗi"},
    {"id": "refactor", "label": "Refactor/cải thiện code hiện tại"},
    {"id": "learn-concept", "label": "Học khái niệm lập trình"},
    {"id": "automate", "label": "Tự động hóa tác vụ"},
    {"id": "optimize-performance", "label": "Tối ưu performance"}
  ]
}
```

### Writing Goals

```json
{
  "id": "writing-goal",
  "prompt": "What is the purpose of this writing?",
  "options": [
    {"id": "inform", "label": "Inform/educate readers"},
    {"id": "persuade", "label": "Persuade/convince"},
    {"id": "entertain", "label": "Entertain/engage"},
    {"id": "document", "label": "Document/record information"},
    {"id": "instruct", "label": "Provide instructions/guide"}
  ]
}
```

### Decision Goals

```json
{
  "id": "decision-type",
  "prompt": "What kind of decision are you making?",
  "options": [
    {"id": "technical", "label": "Technical (architecture, tools, patterns)"},
    {"id": "business", "label": "Business (strategy, priorities, investment)"},
    {"id": "process", "label": "Process (workflow, methodology)"},
    {"id": "hiring", "label": "Hiring/team structure"},
    {"id": "product", "label": "Product (features, roadmap)"}
  ]
}
```

---

## Category 2: Audience Definition

### Universal Audience Question

**English:**
```json
{
  "id": "target-audience",
  "prompt": "Who is the target audience?",
  "options": [
    {"id": "myself", "label": "Just me (personal use)"},
    {"id": "team", "label": "My team/colleagues"},
    {"id": "developers", "label": "Other developers"},
    {"id": "end-users", "label": "End users (non-technical)"},
    {"id": "stakeholders", "label": "Business stakeholders/executives"},
    {"id": "general-public", "label": "General public"}
  ]
}
```

**Vietnamese:**
```json
{
  "id": "doi-tuong-muc-tieu",
  "prompt": "Đối tượng mục tiêu là ai?",
  "options": [
    {"id": "myself", "label": "Chỉ tôi (sử dụng cá nhân)"},
    {"id": "team", "label": "Team/đồng nghiệp của tôi"},
    {"id": "developers", "label": "Developers khác"},
    {"id": "end-users", "label": "End users (không chuyên kỹ thuật)"},
    {"id": "stakeholders", "label": "Business stakeholders/lãnh đạo"},
    {"id": "general-public", "label": "Công chúng"}
  ]
}
```

### Technical Audience

```json
{
  "id": "technical-level",
  "prompt": "What is the technical level of your audience?",
  "options": [
    {"id": "expert", "label": "Expert (deep technical knowledge)"},
    {"id": "intermediate", "label": "Intermediate (some technical background)"},
    {"id": "beginner", "label": "Beginner (learning the basics)"},
    {"id": "non-technical", "label": "Non-technical (minimal technical knowledge)"}
  ]
}
```

### Reader Context

```json
{
  "id": "reader-familiarity",
  "prompt": "How familiar is your audience with this topic?",
  "options": [
    {"id": "expert", "label": "Expert (no explanation needed)"},
    {"id": "familiar", "label": "Familiar (understands basics)"},
    {"id": "new", "label": "New (needs introduction)"},
    {"id": "unknown", "label": "Unknown (mixed audience)"}
  ]
}
```

---

## Category 3: Context Exploration

### Project/Platform Context

**English:**
```json
{
  "id": "project-type",
  "prompt": "What type of project is this?",
  "options": [
    {"id": "web-app", "label": "Web application"},
    {"id": "mobile-app", "label": "Mobile application"},
    {"id": "api-backend", "label": "API/Backend service"},
    {"id": "cli-tool", "label": "CLI tool/script"},
    {"id": "library", "label": "Library/package"},
    {"id": "data-pipeline", "label": "Data pipeline/ETL"},
    {"id": "other", "label": "Other"}
  ]
}
```

**Vietnamese:**
```json
{
  "id": "loai-du-an",
  "prompt": "Đây là loại dự án gì?",
  "options": [
    {"id": "web-app", "label": "Web application"},
    {"id": "mobile-app", "label": "Mobile application"},
    {"id": "api-backend", "label": "API/Backend service"},
    {"id": "cli-tool", "label": "CLI tool/script"},
    {"id": "library", "label": "Library/package"},
    {"id": "data-pipeline", "label": "Data pipeline/ETL"},
    {"id": "other", "label": "Khác"}
  ]
}
```

### Technology Stack

```json
{
  "id": "tech-stack",
  "prompt": "What is your technology stack?",
  "options": [
    {"id": "javascript", "label": "JavaScript/TypeScript (Node, React, Vue, Angular)"},
    {"id": "python", "label": "Python (Django, Flask, FastAPI)"},
    {"id": "java", "label": "Java (Spring, Hibernate)"},
    {"id": "dotnet", "label": ".NET (C#, ASP.NET)"},
    {"id": "go", "label": "Go"},
    {"id": "ruby", "label": "Ruby (Rails)"},
    {"id": "php", "label": "PHP (Laravel, Symfony)"},
    {"id": "other", "label": "Other"}
  ]
}
```

### Current State/Baseline

```json
{
  "id": "current-state",
  "prompt": "What is the current state?",
  "options": [
    {"id": "greenfield", "label": "Greenfield (starting from scratch)"},
    {"id": "existing-stable", "label": "Existing and stable"},
    {"id": "existing-issues", "label": "Existing with issues"},
    {"id": "legacy", "label": "Legacy (old, needs modernization)"},
    {"id": "in-progress", "label": "In progress (partially built)"}
  ]
}
```

### Scale/Complexity

**English:**
```json
{
  "id": "scale-complexity",
  "prompt": "What is the scale and complexity?",
  "options": [
    {"id": "small-simple", "label": "Small and simple (single service, < 1K users)"},
    {"id": "medium", "label": "Medium (multiple components, 1K-100K users)"},
    {"id": "large", "label": "Large (distributed system, 100K-1M users)"},
    {"id": "massive", "label": "Massive (enterprise scale, > 1M users)"}
  ]
}
```

**Vietnamese:**
```json
{
  "id": "quy-mo-do-phuc-tap",
  "prompt": "Quy mô và độ phức tạp như thế nào?",
  "options": [
    {"id": "small-simple", "label": "Nhỏ và đơn giản (single service, < 1K users)"},
    {"id": "medium", "label": "Trung bình (nhiều components, 1K-100K users)"},
    {"id": "large", "label": "Lớn (distributed system, 100K-1M users)"},
    {"id": "massive", "label": "Rất lớn (quy mô doanh nghiệp, > 1M users)"}
  ]
}
```

### Constraints

```json
{
  "id": "constraints",
  "prompt": "What constraints do you have?",
  "allow_multiple": true,
  "options": [
    {"id": "budget", "label": "Budget limits"},
    {"id": "timeline", "label": "Tight timeline"},
    {"id": "team-size", "label": "Small team"},
    {"id": "legacy-code", "label": "Legacy code (hard to change)"},
    {"id": "no-breaking-changes", "label": "Cannot introduce breaking changes"},
    {"id": "compliance", "label": "Compliance requirements (GDPR, HIPAA, etc.)"},
    {"id": "none", "label": "No major constraints"}
  ]
}
```

---

## Category 4: Structural Preferences

### Output Format

**English:**
```json
{
  "id": "output-format",
  "prompt": "What output format do you need?",
  "options": [
    {"id": "markdown", "label": "Markdown (documentation, README)"},
    {"id": "code", "label": "Code (implementation)"},
    {"id": "json", "label": "JSON (structured data)"},
    {"id": "list", "label": "Bulleted list (concise)"},
    {"id": "essay", "label": "Essay/paragraph form (detailed)"},
    {"id": "table", "label": "Table/comparison"},
    {"id": "step-by-step", "label": "Step-by-step guide"}
  ]
}
```

**Vietnamese:**
```json
{
  "id": "dinh-dang-output",
  "prompt": "Bạn cần định dạng output như thế nào?",
  "options": [
    {"id": "markdown", "label": "Markdown (documentation, README)"},
    {"id": "code", "label": "Code (implementation)"},
    {"id": "json", "label": "JSON (dữ liệu có cấu trúc)"},
    {"id": "list", "label": "Danh sách dấu đầu dòng (ngắn gọn)"},
    {"id": "essay", "label": "Dạng đoạn văn (chi tiết)"},
    {"id": "table", "label": "Bảng/so sánh"},
    {"id": "step-by-step", "label": "Hướng dẫn từng bước"}
  ]
}
```

### Code Style

```json
{
  "id": "code-style",
  "prompt": "What code style do you prefer?",
  "options": [
    {"id": "functional", "label": "Functional (pure functions, immutable)"},
    {"id": "oop", "label": "Object-Oriented (classes, inheritance)"},
    {"id": "procedural", "label": "Procedural (step-by-step)"},
    {"id": "declarative", "label": "Declarative (React, SQL-like)"},
    {"id": "project-standard", "label": "Match existing project style"}
  ]
}
```

### Level of Detail

```json
{
  "id": "detail-level",
  "prompt": "How much detail do you need?",
  "options": [
    {"id": "high-level", "label": "High-level overview"},
    {"id": "moderate", "label": "Moderate detail"},
    {"id": "comprehensive", "label": "Comprehensive (deep dive)"},
    {"id": "exhaustive", "label": "Exhaustive (every detail)"}
  ]
}
```

### Explanation Style

```json
{
  "id": "explanation-style",
  "prompt": "How should explanations be provided?",
  "options": [
    {"id": "code-comments", "label": "Inline code comments"},
    {"id": "docstrings", "label": "Docstrings/documentation blocks"},
    {"id": "separate-section", "label": "Separate explanation section"},
    {"id": "minimal", "label": "Minimal (self-documenting code)"},
    {"id": "eli5", "label": "ELI5 (explain like I'm 5)"}
  ]
}
```

---

## Category 5: Criticality Assessment

### Urgency/Priority

**English:**
```json
{
  "id": "urgency",
  "prompt": "How urgent is this?",
  "options": [
    {"id": "critical", "label": "Critical (production down, blocking users)"},
    {"id": "high", "label": "High priority (important, soon)"},
    {"id": "medium", "label": "Medium (normal timeline)"},
    {"id": "low", "label": "Low (nice to have, when possible)"}
  ]
}
```

**Vietnamese:**
```json
{
  "id": "do-khan-cap",
  "prompt": "Mức độ khẩn cấp như thế nào?",
  "options": [
    {"id": "critical", "label": "Khẩn cấp (production down, chặn users)"},
    {"id": "high", "label": "Ưu tiên cao (quan trọng, cần sớm)"},
    {"id": "medium", "label": "Trung bình (timeline bình thường)"},
    {"id": "low", "label": "Thấp (có thì tốt, khi nào được)"}
  ]
}
```

### Impact

```json
{
  "id": "impact",
  "prompt": "What is the potential impact?",
  "options": [
    {"id": "user-facing", "label": "User-facing (affects end users directly)"},
    {"id": "revenue", "label": "Revenue impact (business-critical)"},
    {"id": "team-productivity", "label": "Team productivity (developer experience)"},
    {"id": "technical-debt", "label": "Technical debt (long-term health)"},
    {"id": "minor", "label": "Minor (small improvement)"}
  ]
}
```

### Success Metrics

```json
{
  "id": "success-metrics",
  "prompt": "How will you measure success?",
  "allow_multiple": true,
  "options": [
    {"id": "performance", "label": "Performance metrics (speed, latency)"},
    {"id": "user-satisfaction", "label": "User satisfaction (NPS, feedback)"},
    {"id": "code-quality", "label": "Code quality (maintainability, test coverage)"},
    {"id": "adoption", "label": "Adoption rate (usage, engagement)"},
    {"id": "cost", "label": "Cost reduction (infrastructure, efficiency)"},
    {"id": "time-to-market", "label": "Time to market (speed of delivery)"}
  ]
}
```

### Risk Tolerance

```json
{
  "id": "risk-tolerance",
  "prompt": "What is your risk tolerance?",
  "options": [
    {"id": "zero-risk", "label": "Zero risk (cannot afford failure)"},
    {"id": "low-risk", "label": "Low risk (prefer safe, proven solutions)"},
    {"id": "moderate-risk", "label": "Moderate risk (balanced approach)"},
    {"id": "high-risk", "label": "High risk (willing to experiment, innovate)"}
  ]
}
```

---

## Optimization Level Combinations

### Quick Boost (0-2 questions)

**Minimal Combination:**
```json
{
  "questions": [
    {
      "id": "what",
      "prompt": "What do you want to build/create?",
      "options": [...]
    },
    {
      "id": "for-whom",
      "prompt": "Who is this for?",
      "options": [...]
    }
  ]
}
```

### Deep Dive (3-5 questions)

**Recommended Combination (Round 1):**
```json
{
  "questions": [
    {"id": "goal", "prompt": "What is your primary goal?", ...},
    {"id": "audience", "prompt": "Who is the target audience?", ...},
    {"id": "current-state", "prompt": "What is the current state?", ...}
  ]
}
```

**Round 2 (Follow-up):**
```json
{
  "questions": [
    {"id": "format", "prompt": "What output format?", ...},
    {"id": "urgency", "prompt": "How urgent is this?", ...}
  ]
}
```

### Revolutionary (10-15 questions)

**Round 1 (Big Picture - 5 questions):**
- Primary goal
- Target audience
- Current state
- Scale/complexity
- Main challenges

**Round 2 (Technical Depth - 4 questions):**
- Technology stack
- Architecture/structure
- Dependencies/integrations
- Known constraints

**Round 3 (Quality - 3 questions):**
- Urgency/criticality
- Success metrics
- Risk tolerance

**Round 4 (Refinement - 2-3 questions):**
- Output preferences
- Edge cases
- Specific requirements

---

## Domain-Specific Questions

### Web Development

```json
{
  "id": "web-framework",
  "prompt": "Which web framework are you using?",
  "options": [
    {"id": "react", "label": "React"},
    {"id": "vue", "label": "Vue.js"},
    {"id": "angular", "label": "Angular"},
    {"id": "svelte", "label": "Svelte"},
    {"id": "nextjs", "label": "Next.js (React SSR)"},
    {"id": "nuxtjs", "label": "Nuxt.js (Vue SSR)"},
    {"id": "vanilla", "label": "Vanilla JS (no framework)"}
  ]
}
```

### Database Questions

```json
{
  "id": "database-type",
  "prompt": "What database are you using?",
  "options": [
    {"id": "postgresql", "label": "PostgreSQL"},
    {"id": "mysql", "label": "MySQL/MariaDB"},
    {"id": "mongodb", "label": "MongoDB"},
    {"id": "sqlite", "label": "SQLite"},
    {"id": "redis", "label": "Redis"},
    {"id": "dynamodb", "label": "DynamoDB"},
    {"id": "other", "label": "Other"}
  ]
}
```

### API Design

```json
{
  "id": "api-style",
  "prompt": "What API style?",
  "options": [
    {"id": "rest", "label": "REST (resource-oriented)"},
    {"id": "graphql", "label": "GraphQL (query language)"},
    {"id": "grpc", "label": "gRPC (RPC, protocol buffers)"},
    {"id": "websocket", "label": "WebSocket (real-time)"},
    {"id": "webhook", "label": "Webhooks (event-driven)"}
  ]
}
```

### Testing

```json
{
  "id": "testing-needs",
  "prompt": "What type of tests do you need?",
  "allow_multiple": true,
  "options": [
    {"id": "unit", "label": "Unit tests (individual functions)"},
    {"id": "integration", "label": "Integration tests (components together)"},
    {"id": "e2e", "label": "End-to-end tests (user flows)"},
    {"id": "performance", "label": "Performance tests (load, stress)"},
    {"id": "security", "label": "Security tests (vulnerabilities)"}
  ]
}
```

---

## Special Purpose Questions

### Debugging

```json
{
  "id": "error-type",
  "prompt": "What type of error are you experiencing?",
  "options": [
    {"id": "syntax", "label": "Syntax error (code won't compile/run)"},
    {"id": "runtime", "label": "Runtime error (crashes during execution)"},
    {"id": "logic", "label": "Logic error (wrong output)"},
    {"id": "performance", "label": "Performance issue (slow, hanging)"},
    {"id": "intermittent", "label": "Intermittent (sometimes works, sometimes doesn't)"}
  ]
}
```

### Migration

```json
{
  "id": "migration-reason",
  "prompt": "Why are you migrating?",
  "allow_multiple": true,
  "options": [
    {"id": "eol", "label": "End-of-life (old tech no longer supported)"},
    {"id": "performance", "label": "Performance (current solution too slow)"},
    {"id": "features", "label": "Features (need capabilities not available)"},
    {"id": "cost", "label": "Cost (reduce infrastructure costs)"},
    {"id": "modernization", "label": "Modernization (update tech stack)"},
    {"id": "vendor-lock-in", "label": "Vendor lock-in (increase flexibility)"}
  ]
}
```

### Optimization

```json
{
  "id": "optimization-target",
  "prompt": "What do you want to optimize?",
  "allow_multiple": true,
  "options": [
    {"id": "speed", "label": "Speed (faster execution)"},
    {"id": "memory", "label": "Memory (less RAM usage)"},
    {"id": "bandwidth", "label": "Bandwidth (smaller payloads)"},
    {"id": "cost", "label": "Cost (cheaper to run)"},
    {"id": "developer-experience", "label": "Developer experience (easier to use)"},
    {"id": "user-experience", "label": "User experience (better UX)"}
  ]
}
```

---

## Customization Tips

### Adding New Options

```json
{
  "id": "your-question-id",
  "prompt": "Your question here?",
  "options": [
    {"id": "option-1", "label": "Clear, concise label"},
    {"id": "option-2", "label": "Another clear option"},
    {"id": "other", "label": "Other (always include this)"}
  ]
}
```

### Multi-select Pattern

```json
{
  "id": "multiple-choice-question",
  "prompt": "Select all that apply:",
  "allow_multiple": true,  // KEY: Enable multi-select
  "options": [...]
}
```

### Conditional Follow-up

```python
# If user selects "other", ask follow-up
if user_answer["platform"] == "other":
    follow_up = {
        "id": "platform-specify",
        "prompt": "Which platform are you using?",
        "options": [...]
    }
```

---

## Reference

**Complete implementations in:**
- `dialogue-workflows.md` - How to use these questions
- `askquestion-patterns.md` - Common patterns
- `/examples/` - Real examples

**Version:** 1.1.0  
**Last Updated:** Lyra AskUserQuestion Integration Phase
