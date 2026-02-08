# Interview - Structured Discovery for Implementation and Migration Work

A structured interview command that gathers the right context before implementation, migration, or major refactoring.

## Table of Contents

- [Purpose](#purpose)
- [When to Use](#when-to-use)
- [How It Works](#how-it-works)
- [Question Coverage](#question-coverage)
- [Interview Principles](#interview-principles)
- [Output and Deliverables](#output-and-deliverables)
- [Examples](#examples)
- [Command Usage](#command-usage)
- [Tips and Best Practices](#tips-and-best-practices)
- [Advanced Options](#advanced-options)
- [Troubleshooting](#troubleshooting)
- [Metadata](#metadata)

---

## Purpose

Use this command to reduce guesswork before coding. It helps you:

- Collect complete and concrete requirements
- Avoid missing hidden constraints
- Clarify tradeoffs early
- Define clear deliverables and acceptance criteria
- Think through edge cases and failure paths
- Leave with an implementation plan you can execute

Guiding idea: measure twice, cut once.

---

## When to Use

Run `/interview` when you are:

- Starting a new feature
- Planning a migration or large refactor
- Fixing a complex bug with unclear root cause
- Making architecture decisions with tradeoffs
- Integrating with another system or external API
- Changing UI/UX flows that affect behavior
- Working on security- or performance-critical areas

Skip it when:

- The request is trivial and already clear
- It is a small, low-risk quick fix
- You already have full scope, constraints, and plan

---

## How It Works

This command runs in three phases.

### Phase 1: Discovery and Context Gathering

Goal: learn from the codebase first, so the interview asks fewer and better questions.

Typical actions:
1. Read project structure and architecture
2. Scan related code for patterns and conventions
3. Review configs (`package.json`, `tsconfig.json`, framework configs)
4. Check docs (`README`, architecture notes, API docs)
5. Narrow focus to the target area

Output:
- Current tech stack
- Existing patterns and conventions
- Relevant files and modules
- Possible constraints

Target duration: 30 to 60 seconds.

---

### Phase 2: Structured Interview

Goal: close all important gaps before implementation starts.

Interview style:
- Prefer closed questions when options are clear
- Include a recommended option with short reasoning
- Ask 3 to 5 questions per round
- Move from broad context to implementation detail
- Ask follow-ups immediately when answers are vague

Iteration logic:

```text
WHILE (important details are missing or ambiguous) {
  1. Identify knowledge gaps
  2. Ask 3-5 targeted questions
  3. Analyze answers
  4. Update understanding
  5. If answer is unclear, ask follow-up right away
}
```

Target duration: 2 to 5 minutes, depending on complexity.

---

### Phase 3: Summary and Action Plan

Goal: produce clear artifacts that are ready for execution.

Output includes three documents:

1. Structured summary
2. Implementation checklist
3. Full markdown implementation plan

Template:

```markdown
# Interview Summary: [Feature Name]

## Core Functionality
- [Functionality 1]
- [Functionality 2]

## User Flows
1. [Flow 1]
2. [Flow 2]

## Technical Requirements
- Stack: [Technologies]
- Dependencies: [Packages]
- APIs: [Endpoints/Integrations]

## Constraints
- [Constraint 1]
- [Constraint 2]

## UI/UX Requirements
- [Requirement 1]
- [Requirement 2]

## Tradeoffs and Decisions
- [Decision 1]: [Option] because [Reason]
- [Decision 2]: [Option] because [Reason]

## Security Considerations
- [Concern]
- [Mitigation]

## Performance Requirements
- [Goal]
- [Approach]

## Testing Strategy
- Unit tests: [Scope]
- Integration tests: [Scope]
- E2E tests: [Scope]

## Deliverables
1. [Deliverable 1] - [Acceptance Criteria]
2. [Deliverable 2] - [Acceptance Criteria]

## Edge Cases
- [Case 1] -> [Handling]
- [Case 2] -> [Handling]

## Verification Commands
- Tests: `[command]`
- Lint: `[command]`
- Type check: `[command]`
- Build: `[command]`
```

Target duration: 30 to 60 seconds.

---

## Question Coverage

The interview can cover all of these areas. Scope is adjusted based on the task.

1. Core functionality and user flows
- Feature behavior
- Business rules
- Data model expectations
- State management needs

2. Technical constraints and existing systems
- Stack and framework versions
- Compatibility and architecture limits
- Integration points
- Database and API contracts

3. Implementation details
- File and module organization
- Dependencies to add or update
- Build/config changes
- Environment requirements

4. UI/UX decisions
- Component hierarchy
- Styling strategy
- Responsive behavior
- Accessibility requirements
- Feedback states (loading, success, error)

5. Tradeoffs and priorities
- Performance vs readability
- Simplicity vs flexibility
- Delivery speed vs completeness
- Build now vs defer

6. System integration
- External APIs
- Internal services
- Authn/authz touchpoints
- Caching and event flows

7. Error handling
- Expected failures
- Unexpected failures and fallback behavior
- User-facing messages
- Logging and retry strategy

8. Performance
- Response-time goals
- Rendering and network optimizations
- Lazy loading and code splitting
- Bundle-size constraints

9. Security
- Authentication and authorization rules
- Input validation and sanitization
- XSS/CSRF protection
- Sensitive data handling
- API hardening and rate limiting

10. Concrete deliverables
- Feature-level acceptance criteria
- Definition of Done
- Required documentation and rollout conditions

11. Verification commands
- Test commands
- Lint/type-check commands
- Build and integration commands
- E2E commands

12. Edge cases and constraints
- Boundary values
- Null/undefined behavior
- Empty states
- Race conditions
- Network failure scenarios
- Browser/device compatibility

13. Testing strategy
- Unit coverage targets
- Integration scenarios
- E2E flows
- Performance/security/accessibility testing

14. Documentation requirements
- In-code comments where needed
- README/API updates
- Architecture notes
- Changelog entries

15. Migration concerns (when applicable)
- Backward compatibility
- Data migration plan
- Rollback strategy
- Gradual rollout and feature flags

16. Monitoring and observability
- Logs and metrics
- Alerting thresholds
- Debug visibility
- Runtime performance tracking

Note: the command adapts depth based on complexity and context.

---

## Interview Principles

### 1. Prefer closed questions when possible

Use closed questions if options are known and the goal is fast clarity.

Good example:

```text
Which state management approach should we use?
- Zustand (Recommended - lightweight and TypeScript-friendly)
- Redux Toolkit (strong tooling, more boilerplate)
- React Context (built-in, enough for small scope)
- Jotai (atomic and flexible)
- Other (custom input)
```

Weak example:

```text
Do you want performance optimization?
- Yes
- No
```

Why weak: too broad. Ask for explicit targets instead.

### 2. Do not ask what the codebase already tells you

Avoid:
- "Are you using React or Vue?" (read `package.json`)
- "TypeScript or JavaScript?" (check config and files)
- "What styling system do you use?" (scan imports and setup)

Ask instead:
- "Should this follow existing Pattern X, or introduce Pattern Y for this module?"
- "What constraints in the current approach should we preserve?"

### 3. Ask sharp, implementation-ready questions

Strong questions are:
- Specific
- Actionable
- Scoped
- Relevant to build decisions

Example:

```text
What should `/api/users` return?
- Flat array: [{ id, name, email }] (Recommended - simple)
- Nested object: { users: [...], meta: {...} }
- Paginated: { data: [...], page, totalPages }
```

### 4. Follow up immediately when answers are unclear

```text
IF (answer lacks detail) -> ask follow-up now
IF (answer is contradictory) -> resolve conflict now
IF (answer creates new dependency) -> add targeted question
```

### 5. Always provide a recommended option

Why:
- Speeds up decision-making
- Gives practical direction
- Shows tradeoff awareness

How to choose recommendation:
1. Analyze project context and conventions
2. Compare options against maintenance cost
3. Balance speed, quality, and complexity
4. Pick the most practical default

Format:

```text
Option A (Recommended - short reason)
```

### 6. Ask in the right sequence

Order: broad context -> implementation details -> final verification.

Stage 1 (big picture):
- What are we building?
- What is in scope?
- What constraints are fixed?
- What is the timeline?

Stage 2 (details):
- Component/module structure
- Data flow and state
- API and integration contracts
- UI and interaction specifics

Stage 3 (verification):
- Edge cases
- Testing strategy
- Performance/security requirements
- Delivery criteria

---

## Output and Deliverables

After the interview, the command returns:

### 1. Instant summary

```text
Interview complete.

Stats:
- Questions asked: 12
- Duration: 3m 24s
- Coverage: 8/16 areas
- Clarity score: 95%

Feature: [Feature Name]
Deliverables: [N items]
Blockers: [N, if any]
Recommended approach: [Approach Name]

Saved outputs:
- Structured summary
- Implementation checklist
- Full documentation

Next steps:
1. Review summary
2. Confirm approach with team if needed
3. Start implementation
```

### 2. Comprehensive docs

Three generated documents:
- Structured summary
- Implementation checklist
- Full markdown document

### 3. Action-ready suggestions

```bash
# Documentation location
# .cursor/interviews/[feature-name]-[date].md

# Create feature branch
git checkout -b feature/[feature-name]

# Create tracking ticket
# Template included in output

# Begin implementation
# Follow checklist
```

---

## Examples

### Example 1: User Authentication

Input:

```text
/interview

User: "I want email/password auth plus OAuth"
```

Discovery output:

```text
Discovery (30s)

Detected:
- Next.js 14 (App Router)
- Prisma + PostgreSQL
- API routes under /app/api/
- No existing auth library

Recommended options:
- NextAuth.js (best fit for Next.js)
- Lucia (lightweight alternative)
- Custom auth with jose + bcrypt
```

Interview sample (round-based):

```text
Round 1 - Big picture
Q1. Which auth library should we use?
- NextAuth.js (Recommended)
- Lucia
- Custom

Q2. Which OAuth providers are required?
- Google
- GitHub
- Facebook
- X/Twitter

Q3. Session approach?
- JWT (Recommended for stateless APIs)
- DB sessions (strong revocation control)
- Hybrid
```

Summary sample (shortened):

```markdown
# Interview Summary: User Authentication

## Core Functionality
- Email/password signup and login
- OAuth via Google and GitHub
- Email verification
- Password reset

## Technical Stack
- NextAuth.js v5
- Prisma models: User, Account, Session
- PostgreSQL
- Resend API for email

## Deliverables
1. DB schema updates
2. Auth API routes
3. UI forms (signup/login/reset)
4. Email templates

## Verification Commands
- `npm test`
- `npm run type-check`
- `npm run lint`
- `npm run build`
```

### Example 2: Quick Feature - Dark Mode Toggle

Input:

```text
/interview

User: "Add a dark mode toggle"
```

Discovery output:

```text
Detected:
- Next.js + Tailwind CSS
- No current theme system
Recommendation:
- next-themes
```

Interview sample:

```text
Q1. Theme implementation?
- next-themes + Tailwind (Recommended)
- Custom context
- Manual CSS variables

Q2. Default theme?
- System preference (Recommended)
- Light
- Dark

Q3. Toggle UI?
- Icon button (Recommended)
- Dropdown
- Keyboard shortcut only
```

Output (short):

```markdown
# Dark Mode Toggle - Plan

## Summary
- Library: next-themes
- Persistence: localStorage
- Default: system
- UI: icon button

## Implementation
1. Install `next-themes`
2. Add `ThemeProvider`
3. Build `ThemeToggle`
4. Update Tailwind config
5. Verify persistence and UI behavior
```

---

## Command Usage

Basic:

```text
/interview
```

With inline context:

```text
/interview

"I want to integrate Stripe payments"
```

With file context:

```text
@src/components/checkout/

/interview

"Refactor checkout to support multiple payment methods"
```

---

## Tips and Best Practices

### For users

1. Before interview
- Bring a rough feature idea
- Know hard constraints (timeline, stack, compliance)
- Share references (designs, similar flows, tickets)

2. During interview
- Answer directly
- Pick recommended options when unsure
- Use custom input only when needed
- Ask for clarification if a question is unclear

3. After interview
- Review summary carefully
- Confirm decisions with team if needed
- Save docs and follow checklist

### For AI

1. Discovery phase
- Move fast, but do not skip critical files
- Gather only context that improves question quality
- Keep this phase under 60 seconds

2. Interview phase
- Start broad, then narrow
- Keep each round to 3-5 questions
- Include recommendation and reason
- Follow up quickly on unclear answers
- Do not ask what can be inferred automatically

3. Summary phase
- Be complete without bloating
- Keep sections scannable
- Include verification commands and edge cases
- End with actionable next steps

---

## Advanced Options

If you want targeted depth:

```text
/interview --focus=security,performance
```

```text
/interview --skip=ui
```

```text
/interview --depth=quick
```

Note: these are placeholders for future enhancement. Current behavior adapts scope automatically from context.

---

## Troubleshooting

Issue: too many questions

Fix:
- Provide more initial context
- Choose recommended options when acceptable
- Explicitly say: "Keep it simple. Start with a basic implementation."

Issue: irrelevant questions

Fix:
- Clarify scope: "Only X is needed, not Y"
- Mark question as not applicable
- Explain why it does not apply

Issue: unsure how to answer

Fix:
- Choose recommended option
- Or ask: "I am not sure, suggest the best default and tradeoffs"

---

## Metadata

- Command: `/interview`
- Version: `1.0.0`
- Created: `2026-02-04`
- Language: `English`
- Complexity: `Advanced`
- Dependencies: `AskQuestion` tool
- Estimated duration: `3-8 minutes`

---

## Related Commands

- `/create-command` - create new slash commands
- `/create-rule` - create project rules
- `/council` - multi-agent collaboration
- `/phase-plan` - multi-phase planning

## Related Skills

- `lyra-prompt-optimizer`
- Use after `/interview` to improve prompts for downstream AI agents

Generated by `/create-command`.
