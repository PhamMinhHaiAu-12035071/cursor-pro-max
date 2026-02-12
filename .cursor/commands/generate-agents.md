# Generate AGENTS.md Hierarchy

Generate a hierarchical AGENTS.md structure for any codebase following the [agents.md open standard](https://github.com/agents-md/agents.md). This command creates lightweight, token-efficient guidance files optimized for AI coding agents.

## Table of Contents

- [Core Principles](#core-principles)
- [Process Overview](#process-overview)
- [Phase 1: Repository Analysis](#phase-1-repository-analysis)
- [Phase 2: Generate Root AGENTS.md](#phase-2-generate-root-agentsmd)
- [Phase 3: Generate Sub-Folder AGENTS.md](#phase-3-generate-sub-folder-agentsmd)
- [Phase 4: Special Considerations](#phase-4-special-considerations)
- [Output Format](#output-format)
- [Quality Checklist](#quality-checklist)
- [Metadata](#metadata)

---

## Core Principles

1. **Root AGENTS.md is LIGHTWEIGHT** - Only universal guidance, links to sub-files
2. **Nearest-wins hierarchy** - Agents read the closest AGENTS.md to the file being edited
3. **JIT (Just-In-Time) indexing** - Provide paths/globs/commands, NOT full content
4. **Token efficiency** - Small, actionable guidance over encyclopedic documentation
5. **Sub-folder AGENTS.md files have MORE detail** - Specific patterns, examples, commands

### Token Budget

- Root AGENTS.md: max 100-150 lines (~3,000-5,000 tokens)
- Sub-folder AGENTS.md: max 80-120 lines
- Total token budget per file: under 5,000 tokens

**Research basis**: Files > 150 lines see diminishing returns as agents ignore buried instructions ([GitHub Blog analysis of 2,500+ repos](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)).

---

## Process Overview

### Project Type Detection

Before generating, determine project structure:

- **Simple project**: Generate 1 root AGENTS.md only (no sub-files)
- **Multi-package**: Generate root + sub-folder AGENTS.md per package
- **Monorepo**: Generate root + per-app + per-package AGENTS.md

### Pre-Generation Check

Before generating, verify:

- Does AGENTS.md already exist? → Offer to update vs replace
- Does CLAUDE.md exist? → Reference it, avoid duplication
- Are there `.cursor/rules/*.mdc` files? → Align conventions
- What's the build system? (pnpm/npm/yarn workspaces, Turborepo, Lerna, or simple)

### Progressive Disclosure Strategy

Use a 3-layer approach for optimal token efficiency:

- **Layer 1 (Root)**: Lightweight index, links to sub-files
- **Layer 2 (Sub-folders)**: Detailed patterns and conventions
- **Layer 3 (Code examples)**: Inline only, never encyclopedic

---

## Phase 1: Repository Analysis

First, analyze the codebase structure and provide:

**1. Repository type**: Monorepo, multi-package, or simple single project?

**2. Primary technology stack**: Languages, frameworks, key tools

**3. Major directories/packages** that should have their own AGENTS.md:
   - Apps (e.g., `apps/web`, `apps/api`, `apps/mobile`)
   - Services (e.g., `services/auth`, `services/transcribe`)
   - Packages/libs (e.g., `packages/ui`, `packages/shared`)
   - Workers/jobs (e.g., `workers/queue`, `workers/cron`)

**4. Build system**: pnpm/npm/yarn workspaces? Turborepo? Lerna? Or simple?

**5. Testing setup**: Jest, Vitest, Playwright, pytest? Where are tests?

**6. Key patterns to document**:
   - Code organization patterns
   - Important conventions (naming, styling, commits)
   - Critical files that serve as good examples
   - Anti-patterns to avoid

Present this as a **structured map** before generating any AGENTS.md files.

---

## Phase 2: Generate Root AGENTS.md

Create a **lightweight root AGENTS.md** (~100-150 lines max) that includes:

### Required Sections

**1. Project Snapshot** (3-5 lines)
- Repo type (monorepo/simple)
- Primary tech stack
- Note that sub-packages have their own AGENTS.md files

**2. Root Setup Commands** (5-10 lines)
- Install dependencies (root level)
- Build all
- Typecheck all
- Test all

**3. Universal Conventions** (5-10 lines)
- Code style (TypeScript strict? Prettier? ESLint?)
- Commit format (Conventional Commits?)
- Branch strategy
- PR requirements

**4. Security & Secrets** (3-5 lines)
- Never commit tokens
- Where secrets go (.env patterns)
- PII handling if applicable

**5. JIT Index - Directory Map** (10-20 lines)

Structure like:

```markdown
## JIT Index (what to open, not what to paste)

### Package Structure
- Web UI: `apps/web/` → [see apps/web/AGENTS.md](apps/web/AGENTS.md)
- API: `apps/api/` → [see apps/api/AGENTS.md](apps/api/AGENTS.md)
- Auth service: `services/auth/` → [see services/auth/AGENTS.md](services/auth/AGENTS.md)
- Shared packages: `packages/**/` → [see packages/README.md for details]

### Quick Find Commands
- Search for a function: `rg -n "functionName" apps/** packages/**`
- Find a component: `rg -n "export.*ComponentName" apps/web/src`
- Find API routes: `rg -n "export const (GET|POST)" apps/api`
```

**6. Definition of Done** (3-5 lines)
- What must pass before a PR is ready
- Minimal checklist

### Required Coverage (6 Core Areas)

Every generated AGENTS.md MUST cover these areas ([proven formula from GitHub Blog research](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)):

1. **Commands** (with specific flags and examples)
2. **Testing practices** (frameworks, locations, coverage requirements)
3. **Project structure** (directory organization, file locations)
4. **Code style** (linting, formatting, conventions)
5. **Git workflow** (branching, commits, PR process)
6. **Clear boundaries** (what agents MUST NOT touch: secrets, prod configs, etc.)

---

## Phase 3: Generate Sub-Folder AGENTS.md

For EACH major package/directory identified in Phase 1, create a **detailed AGENTS.md** that includes:

### Required Sections

**1. Package Identity** (2-3 lines)
- What this package/app/service does
- Primary tech/framework for THIS package

**2. Setup & Run** (5-10 lines)
- Install command (if different from root)
- Dev server command
- Build command
- Test command
- Lint/typecheck commands

**3. Patterns & Conventions** (10-20 lines)

**THIS IS THE MOST IMPORTANT SECTION**

- File organization rules (where things go)
- Naming conventions specific to this package
- Preferred patterns with **file examples**:

```markdown
- ✅ DO: Use functional components like `src/components/Button.tsx`
- ❌ DON'T: Use class components like `src/legacy/OldButton.tsx`
- ✅ Forms: Copy pattern from `src/components/forms/ContactForm.tsx`
- ✅ API calls: Use `src/lib/api/client.ts` wrapper, see example in `src/hooks/useUser.ts`
```

**4. Touch Points / Key Files** (5-10 lines)

Point to the most important files to understand this package:

```markdown
- Auth logic: `src/auth/provider.tsx`
- API client: `src/lib/api.ts`
- Types: `src/types/index.ts`
- Config: `src/config.ts`
```

**5. JIT Index Hints** (5-10 lines)

Specific search commands for this package:

```markdown
- Find a React component: `rg -n "export function .*" src/components`
- Find a hook: `rg -n "export const use" src/hooks`
- Find route handlers: `rg -n "export async function (GET|POST)" src/app`
- Find tests: `find . -name "*.test.ts"`
```

**6. Common Gotchas** (3-5 lines, if applicable)
- "Auth requires `NEXT_PUBLIC_` prefix for client-side use"
- "Always use `@/` imports for absolute paths"
- "Database migrations must be run before tests: `pnpm db:migrate`"

**7. Pre-PR Checks** (2-3 lines)

Package-specific command to run before creating a PR:

```bash
pnpm --filter @repo/web typecheck && pnpm --filter @repo/web test && pnpm --filter @repo/web build
```

---

## Phase 4: Special Considerations

For each AGENTS.md file, also consider:

### A. Design System / UI Package

If there's a design system or UI library:

```markdown
## Design System
- Components: `packages/ui/src/components/**`
- Use design tokens from `packages/ui/src/tokens.ts` (never hardcode colors)
- See component gallery: `pnpm --filter @repo/ui storybook`
- Examples:
  - Buttons: Copy `packages/ui/src/components/Button/Button.tsx`
  - Forms: Copy `packages/ui/src/components/Input/Input.tsx`
```

### B. Database / Data Layer

If there's a database service:

```markdown
## Database
- ORM: Prisma / Drizzle / TypeORM
- Schema: `prisma/schema.prisma`
- Migrations: `pnpm db:migrate`
- Seed: `pnpm db:seed`
- **NEVER** run migrations in tests; use `test-db` script
- Connection: via `src/lib/db.ts` singleton
```

### C. API / Backend Service

```markdown
## API Patterns
- REST routes: `src/routes/**/*.ts`
- Auth middleware: `src/middleware/auth.ts` (apply to protected routes)
- Validation: Use Zod schemas in `src/schemas/**`
- Error handling: All errors thrown as `ApiError` from `src/lib/errors.ts`
- Example endpoint: See `src/routes/users/get.ts` for full pattern
```

### D. Testing Package

```markdown
## Testing
- Unit tests: `*.test.ts` colocated with source
- Integration tests: `tests/integration/**`
- E2E tests: `tests/e2e/**` (Playwright)
- Run single test: `pnpm test -- path/to/file.test.ts`
- Coverage: `pnpm test:coverage` (aim for >80%)
- Mock external APIs using `src/test/mocks/**`
```

---

## Output Format

Provide the files in this order:

1. **Analysis Summary** (from Phase 1)
2. **Root AGENTS.md** (complete, ready to copy)
3. **Each Sub-Folder AGENTS.md** (one at a time, with file path)

For each file, use this format:

```markdown
---
File: `AGENTS.md` (root)
---
[full content here]

---
File: `apps/web/AGENTS.md`
---
[full content here]

---
File: `services/auth/AGENTS.md`
---
[full content here]
```

---

## Quality Checklist

Before generating, verify:

- [ ] Root AGENTS.md is under 150 lines
- [ ] Root links to all sub-AGENTS.md files
- [ ] Each sub-file has concrete examples (actual file paths)
- [ ] Commands are copy-paste ready (no placeholders unless unavoidable)
- [ ] No duplication between root and sub-files
- [ ] JIT hints use actual patterns from the codebase (ripgrep, find, glob)
- [ ] Every "✅ DO" has a real file example
- [ ] Every "❌ DON'T" references a real anti-pattern or legacy file
- [ ] Pre-PR checks are single copy-paste commands
- [ ] All 6 Core Areas are covered (commands, testing, structure, code style, git, boundaries)
- [ ] Token budget respected (root <150 lines, sub-files <120 lines)
- [ ] Progressive disclosure applied (lightweight root, detailed sub-files)

---

## Metadata

**Version**: 2.0  
**Language**: English  
**Related Commands**: `/generate-claude` - Generate CLAUDE.md hierarchy for Claude Code  
**Reference**: [agents.md open standard](https://github.com/agents-md/agents.md)  
**Research**: [GitHub Blog - How to write a great AGENTS.md](https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/)
