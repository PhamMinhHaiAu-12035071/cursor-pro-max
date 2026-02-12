# Generate CLAUDE.md Hierarchy

Generate a hierarchical CLAUDE.md system optimized for Claude Code with hooks, MCP integration, and custom commands. Claude Code treats CLAUDE.md as immutable system rules with strict priority over user prompts.

## Table of Contents

- [Claude Code Unique Capabilities](#claude-code-unique-capabilities)
- [Core Principles](#core-principles)
- [Process Overview](#process-overview)
- [Phase 1: Comprehensive Repository Analysis](#phase-1-comprehensive-repository-analysis)
- [Phase 2: Generate Root CLAUDE.md](#phase-2-generate-root-claudemd)
- [Phase 3: Generate Subdirectory CLAUDE.md](#phase-3-generate-subdirectory-claudemd)
- [Phase 4: Claude Code Configuration](#phase-4-claude-code-configuration)
- [Output Format](#output-format)
- [Quality Checklist](#quality-checklist)
- [Best Practices](#best-practices)
- [Metadata](#metadata)

---

## Claude Code Unique Capabilities

Claude Code differs from generic AGENTS.md with:

1. **Strict Instruction Hierarchy**: CLAUDE.md = immutable system rules (highest priority)
2. **Hierarchical Memory System**: Reads CLAUDE.md files recursively UP from CWD to root, AND discovers them in subdirectories
3. **Hooks System**: Lifecycle hooks (PreToolUse, PostToolUse, UserPromptSubmit, Notification, Stop)
4. **Model Context Protocol (MCP)**: Native integration with external tools, databases, APIs
5. **Custom Slash Commands**: Repeatable workflows in `.claude/commands/`
6. **Subagents**: Specialized agents with isolated context and tool permissions
7. **Extended Thinking**: Long-form reasoning with 1M+ token context windows

### Claude Code Memory Hierarchy (precedence order)

1. **Managed policy** - Organization-wide CLAUDE.md (highest priority)
2. **Project memory** - `./CLAUDE.md` (team-shared, committed to git)
3. **Project rules** - `./.claude/rules/*.md` (modular, topic-specific, loaded on-demand)
4. **User memory** - `~/.claude/CLAUDE.md` (personal preferences, all projects)
5. **Local memory** - `./CLAUDE.local.md` (personal, auto-gitignored, not committed)
6. **Auto memory** - `~/.claude/projects/<project>/memory/` (Claude learns during sessions)

**Reference**: [Claude Code Memory Docs](https://code.claude.com/docs/en/memory)

---

## Core Principles

1. **CLAUDE.md is AUTHORITATIVE** - Treated as system rules, not suggestions
2. **Modular Sections** - Use clear markdown headers to prevent instruction bleeding
3. **Front-load Critical Context** - Important rules at the top
4. **Hierarchical Strategy**: Root = universal rules; Subdirs = specific context
5. **Token Efficiency Through Structure** - Use sections to keep related instructions together
6. **Living Documentation** - Use `#` key during sessions to add memories organically

### Root CLAUDE.md Target Size

- **Size**: 80-130 lines (~2,000-2,500 tokens)
- **Reason**: Research shows CLAUDE.md > 2,500 tokens burns context before work begins
- **Strategy**: Use `.claude/rules/*.md` for detailed guidance (loaded on-demand)

**Reference**: [7 CLAUDE.md Mistakes](https://allahabadi.dev/blogs/ai/7-claude-md-mistakes-developers-make/)

---

## Process Overview

### Pre-Generation Check

Before generating:

- Does CLAUDE.md already exist? → Offer to update vs replace
- Does AGENTS.md exist? → CLAUDE.md should complement (not duplicate)
- Are there `.cursor/rules/*.mdc` files? → Align conventions
- What workflows should be automated? → Plan hooks and commands

### Relationship with AGENTS.md

- If AGENTS.md exists, CLAUDE.md adds Claude-specific features on top
- CLAUDE.md should not duplicate generic guidance from AGENTS.md
- Use `/generate-agents` first for generic, then `/generate-claude` for Claude-specific

---

## Phase 1: Comprehensive Repository Analysis

Analyze the codebase and provide:

**1. Repository Architecture**
- Type: Monorepo, multi-package, or standard single project?
- Tech stack: Primary languages, frameworks, build systems
- Testing infrastructure: Frameworks, where tests live, coverage requirements
- CI/CD: GitHub Actions, GitLab CI, custom pipelines?

**2. Claude Code-Specific Analysis**

Identify opportunities for:
- **Hooks**: What should always run? (formatting, linting, tests after edits)
- **MCP Servers**: External tools needed (GitHub, databases, search, APIs)?
- **Custom Commands**: Repeated workflows (deploy, migrate, review, fix-issue)?
- **Subagents**: Specialized tasks (testing agent, review agent, docs agent)?

**3. Directory Structure for CLAUDE.md Files**

Map where CLAUDE.md files should exist:

```
root/CLAUDE.md                    # Universal project rules
apps/web/CLAUDE.md               # Next.js-specific guidance
apps/api/CLAUDE.md               # API-specific patterns
services/auth/CLAUDE.md          # Auth service specifics
packages/ui/CLAUDE.md            # UI library patterns
tests/CLAUDE.md                  # Testing-specific rules
```

**4. Dangerous Patterns to Block**
- Commands to block via hooks (rm -rf, force push, etc.)
- Files that should never be edited (.env, secrets, prod configs)
- Anti-patterns to warn against

**5. Tool Permissions Strategy**
- What tools should Claude have by default?
- What requires explicit permission?
- Security boundaries

Present this analysis as a **structured map** before generating any files.

---

## Phase 2: Generate Root CLAUDE.md

Create a **concise root CLAUDE.md** (~80-130 lines) that serves as the constitution:

### Required Sections

**1. Project Identity** (5-10 lines)

```markdown
# [Project Name]

## Overview
- **Type**: [Monorepo/Standard project]
- **Stack**: [Primary technologies]
- **Architecture**: [Brief architectural summary]

This CLAUDE.md is the authoritative source for development guidelines.
Subdirectories contain specialized CLAUDE.md files that extend these rules.
```

**2. Universal Rules (MUST/SHOULD/MUST NOT)** (10-20 lines)

Use clear RFC-2119 language:

```markdown
## Universal Development Rules

### Code Quality (MUST)
- **MUST** write TypeScript in strict mode
- **MUST** include tests for all new features
- **MUST** run pre-commit hooks before committing
- **MUST NOT** commit secrets, API keys, or tokens

### Best Practices (SHOULD)
- **SHOULD** prefer functional components over class components
- **SHOULD** keep functions under 50 lines

### Anti-Patterns (MUST NOT)
- **MUST NOT** use `any` type without explicit justification
- **MUST NOT** push directly to main branch
```

**3. Core Commands** (10-15 lines)

Include development, package-specific, and quality gate commands.

**4. Project Structure Map** (15-25 lines)

Link to subdirectory CLAUDE.md files with brief descriptions.

**5. Quick Find Commands (JIT Index)** (10-15 lines)

Provide ripgrep patterns for code navigation.

**6. Security & Secrets** (5-10 lines)

Clear rules about secrets, PII, and safe operations.

**7. Git Workflow** (5-10 lines)

Branch strategy, commit format, PR requirements.

**8. Testing Strategy** (5-10 lines)

Coverage requirements, test locations, when to test.

**9. Available Tools** (5-10 lines)

List tools and permissions (what Claude can/cannot do).

**10. Directory-Specific CLAUDE.md Files** (5-10 lines)

Links to specialized context files.

---

## Phase 3: Generate Subdirectory CLAUDE.md

For EACH major package/directory, create a **detailed CLAUDE.md** (100-150 lines):

### Template Structure

**1. Package Identity** (5 lines)
- What this package does
- Technology/framework
- Parent context reference

**2. Setup & Commands** (10-15 lines)
- Dev, build, test, lint commands
- From package directory and from root
- Pre-PR checklist command

**3. Architecture & Patterns** (20-40 lines) **MOST IMPORTANT**
- Directory structure
- Code organization patterns with ✅ DO / ❌ DON'T examples
- State management, data fetching, styling patterns
- All examples must reference real file paths

**4. Key Files & Touch Points** (10-15 lines)
- Core files to understand first
- Common patterns with file examples

**5. JIT Search Hints** (10-15 lines)
- Package-specific ripgrep commands

**6. Common Gotchas** (5-10 lines)
- Environment variables, imports, framework-specific issues

**7. Package-Specific Testing** (10-15 lines)
- Test locations, frameworks, running tests

**8. Pre-PR Validation** (3-5 lines)
- Single command to run before PR

---

## Phase 4: Claude Code Configuration

### 1. Hooks Configuration (`.claude/settings.json`)

Detect project needs and generate appropriate hooks:

**Formatter Detection**: prettier/eslint/black/rustfmt based on project files
**Tester Detection**: jest/vitest/pytest/cargo test based on package.json/pyproject.toml
**Safety Hooks**: Block dangerous commands (rm -rf, force push, etc.)

Example structure:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "if [[ \"$CLAUDE_TOOL_INPUT\" == *\"rm -rf\"* ]]; then echo 'BLOCKED: Dangerous command' && exit 2; fi"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "[detected formatter command]"
          }
        ]
      }
    ]
  }
}
```

### 2. Custom Slash Commands (`.claude/commands/`)

Generate 3-5 most common workflow commands:

**`.claude/commands/review.md`** - Comprehensive code review checklist
**`.claude/commands/fix-issue.md`** - Analyze and fix GitHub issue workflow
**`.claude/commands/migrate-db.md`** - Database migration workflow (if applicable)

Each command should:
- Use `$ARGUMENTS` for parameters
- Follow established patterns from CLAUDE.md
- Include validation and safety checks
- Reference relevant documentation

### 3. MCP Server Recommendations

Detect project needs and recommend appropriate MCP servers:

```markdown
## MCP Detection
Analyze project and recommend:
- If uses GitHub → recommend GitHub MCP
- If has database → recommend DB MCP
- If needs web search → recommend search MCP
- List detected needs, let user confirm
```

Common recommendations:

```bash
# GitHub integration
claude mcp add --scope user github -- bunx @modelcontextprotocol/server-github

# Web search and documentation
claude mcp add --scope user context7 -- bunx context7-mcp

# Sequential thinking for complex decisions
claude mcp add --scope user sequential-thinking -- bunx @modelcontextprotocol/server-sequential-thinking
```

### 4. Claude Code 2026 Features

Include mentions of:

- **`CLAUDE.local.md`** - Personal preferences, auto-gitignored
- **`.claudeignore`** - Reduce noise, focus context (like .gitignore)
- **`/init` command** - Claude Code's built-in CLAUDE.md bootstrapper
- **`.claude/rules/*.md`** - Topic-specific modular rules (loaded on-demand)
- **`#` key** - Organic memory additions during sessions
- **`/clear`** and **`/compact`** - Context management commands

---

## Output Format

Provide files in this order:

1. **Analysis Summary** (Phase 1)
2. **Root CLAUDE.md** (complete file)
3. **Hooks Configuration** (`.claude/settings.json`)
4. **Custom Commands** (each `.claude/commands/*.md` file)
5. **Each Subdirectory CLAUDE.md** (with full path)
6. **MCP Setup Guide** (commands to run)
7. **Optional: Subagent Configurations** (if complex workflows identified)

Format each file:

```markdown
---
File: `CLAUDE.md` (root)
Purpose: Universal project rules and navigation
---
[full content]

---
File: `apps/web/CLAUDE.md`
Purpose: Next.js-specific development guidance
---
[full content]
```

---

## Quality Checklist

Before finalizing, verify:

- [ ] Root CLAUDE.md under 130 lines (~2,500 tokens)
- [ ] All subdirectory CLAUDE.md files link back to root
- [ ] Every "✅ DO" has a real file example with path
- [ ] Every "❌ DON'T" references actual anti-pattern
- [ ] Commands are copy-paste ready (no placeholders)
- [ ] Hooks target specific patterns (not overly broad)
- [ ] Custom commands use `$ARGUMENTS` correctly
- [ ] JIT search commands use actual file patterns
- [ ] Security rules clearly stated
- [ ] Tool permissions explicitly defined
- [ ] MCP servers appropriate for project needs
- [ ] No duplication between hierarchy levels
- [ ] Hooks detect formatters/testers from project
- [ ] References to CLAUDE.local.md, .claudeignore, /init included

---

## Best Practices

### Memory System
- Use `#` during sessions to add memories organically
- Review and refactor CLAUDE.md monthly
- Keep sections modular to prevent instruction bleeding

### Hooks Strategy
- PreToolUse: Validation and safety checks
- PostToolUse: Formatting, linting, auto-testing
- Start conservative, expand based on needs

### Context Management
- Use `/clear` between unrelated tasks
- Use `/compact` for long sessions
- Reference specific files with `@` rather than reading entire directories

### Custom Commands
- Start with 3-5 most common workflows
- Use descriptive names (e.g., `/fix-issue`, not `/fi`)
- Include validation steps in commands

---

## Metadata

**Version**: 2.0  
**Language**: English  
**Related Commands**: `/generate-agents` - Generate AGENTS.md hierarchy for any codebase  
**References**:
- [Claude Code Memory Docs](https://code.claude.com/docs/en/memory)
- [Claude Code Best Practices](https://code.claude.com/docs/en/best-practices)
- [7 CLAUDE.md Mistakes](https://allahabadi.dev/blogs/ai/7-claude-md-mistakes-developers-make/)
