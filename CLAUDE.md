# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**cursor-pro-max** là một meta-project tập hợp best practices từ "Vibe Coding Cursor" - bao gồm commands, rules, skills và agents. Đây không phải là một ứng dụng code mà là một knowledge base và toolkit để tối ưu workflow với Cursor IDE.

### Migration History

**February 2026**: Skills moved from `.cursor/skills/` to `.claude/skills/` for improved Claude Code (claude.ai/code) compatibility and multi-IDE support. This aligns with the Claude ecosystem conventions as documented in [Cursor Skills Documentation](https://cursor.com/docs/context/skills).

## Project Structure

```
.cursor/
├── commands/           # Cursor slash commands (plain .md files)
│   ├── interview.md    # Phỏng vấn thu thập requirements
│   ├── phase-plan.md   # Tổ chức công việc theo phases
│   ├── council.md      # Multi-agent coordination
│   ├── create-rule.md  # Hướng dẫn tạo Cursor rules
│   ├── create-command.md # Meta-command generator
│   ├── check-grammar.md  # Grammar checking
│   ├── generate-agents.md # Generate AGENTS.md hierarchy
│   └── generate-claude.md # Generate CLAUDE.md hierarchy
│
└── rules/              # Cursor rules (.mdc files)
    └── optimization-principles.mdc # LEVER framework for code optimization

.claude/
└── skills/             # AI Skills với YAML frontmatter
    ├── claudeception/          # Continuous learning & skill extraction
    │   ├── SKILL.md
    │   ├── references/
    │   ├── examples/
    │   └── scripts/
    ├── grammar-learning/       # Grammar correction skill
    │   ├── SKILL.md
    │   ├── references/
    │   └── examples/
    ├── lyra-prompt-optimizer/  # AI prompt optimization skill
    │   ├── SKILL.md
    │   ├── references/
    │   ├── examples/
    │   └── scripts/
    ├── matrix-test-suite/      # Matrix-based test case generation
    │   ├── SKILL.md
    │   ├── references/
    │   ├── examples/
    │   ├── scripts/
    │   └── templates/
    ├── uat-test-suite/         # User Acceptance Testing documentation
    │   ├── SKILL.md
    │   ├── references/
    │   ├── examples/
    │   ├── scripts/
    │   └── templates/
GLOBAL_RULE.md          # System prompt chính (~5600 lines) cho AI agents
```

## Key Concepts

### Task Classification System
- 🟢 **Lightweight**: Max 500 tokens, <5s - Simple queries, minor fixes
- 🟡 **Standard**: Max 2000 tokens, <30s - Feature implementation, debugging
- 🔴 **Critical**: Max 5000 tokens, <2min - Architecture, security, complex changes

### Conflict Resolution Hierarchy (precedence order)
1. Security (highest)
2. Correctness
3. User Safety
4. Scope Discipline
5. Simplicity
6. Performance (lowest)

### File Conventions
- **Commands** (`.cursor/commands/`): Plain markdown files, no YAML frontmatter
- **Skills** (`.claude/skills/`): SKILL.md with YAML frontmatter (name, description)
- **Rules** (`.cursor/rules/`): `.mdc` files with YAML frontmatter (title, description, globs, alwaysApply)

## No Build System

Đây là documentation/configuration project - không có build, test, hay lint commands.

## Extending the Project

### Add new command
Create `.cursor/commands/<command-name>.md` với plain markdown describing the command's purpose and workflow.

### Add new skill
Create `.claude/skills/<skill-name>/SKILL.md` với YAML frontmatter:
```yaml
---
name: skill-name
description: "When to use this skill..."
---
```

### Add new rule
Create `.cursor/rules/<rule-name>.mdc` với YAML frontmatter:
```yaml
---
title: Rule Title
description: What this rule does
globs: ["**/*.ts", "src/**/*"]
alwaysApply: false
---
```

## Language

Project documentation sử dụng tiếng Việt. Commands và skills có thể viết bằng tiếng Việt hoặc tiếng Anh tùy theo target audience.
