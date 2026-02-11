---
name: uat-test-suite
description: |
  Generate comprehensive User Acceptance Testing (UAT) documentation with full traceability,
  priority classification, and coverage gap analysis. Activate when the user mentions UAT,
  user acceptance testing, test suite, test plan, acceptance criteria, QA checklist, test cases,
  test scenarios, or needs test case documentation for business requirements validation.
  Produces a single UAT-{ProjectName}.md file with summary tables, module-by-module test cases
  (10-column format), coverage traceability matrix, and gap analysis with recommendations.
user-invocable: false
---

# UAT Test Suite Generator

## Purpose

Generate production-ready User Acceptance Testing documentation that validates business requirements through structured test cases. The output is a single markdown file (`UAT-{ProjectName}.md`) containing a summary table, detailed module-by-module test scenarios, a coverage traceability matrix, and a gap analysis with recommendations.

This skill focuses on business logic validation -- ensuring the system meets client requirements before go-live, not technical QA (unit/integration/e2e testing).

## When to Use

Activate this skill when:
- The user requests UAT, user acceptance testing, or test suite documentation
- The user asks for test cases, test scenarios, or acceptance criteria
- The user provides system requirements and needs validation documentation
- The user mentions modules, features, or business flows that need testing
- The user wants to verify business requirements coverage before release

## Four-Phase Workflow

### Phase 1: Discovery

Gather complete system understanding before generating any test cases.

**Step 1 -- User Description**

Ask the user to describe:
- System name and purpose
- Target users and their roles
- Core business flows and features
- Known constraints or compliance requirements

**Step 2 -- Codebase Scan**

Scan the codebase for relevant context:
- Read route definitions, API endpoints, and controller files
- Identify UI components and page structures
- Check database models and schema definitions
- Review middleware, auth guards, and permission logic
- Look at existing test files for coverage patterns

**Step 3 -- Deep Interview**

Conduct a structured interview using the AskQuestion tool. Run 3-5 rounds of 3-5 questions each, progressing from broad context to implementation detail.

Round 1 -- System Architecture:
- Confirm the module list discovered from codebase scan
- Identify user roles and permission levels
- Clarify core business flows and their priorities
- Ask about external integrations and dependencies

Round 2 -- Module Details:
- For each module, confirm the main user journeys
- Identify critical business rules and validation logic
- Ask about edge cases the client cares about
- Clarify expected behavior for error states

Round 3 -- Business Context:
- Ask about compliance or regulatory requirements
- Identify data sensitivity and security concerns
- Clarify performance expectations from the client
- Ask about browser/device/environment requirements

Round 4 -- Priorities and Constraints:
- Which modules are most critical to the client?
- What are the known risk areas?
- Are there any deferred features or known limitations?
- What is the timeline pressure (affects P2 scope)?

Round 5 (if needed) -- Clarifications:
- Resolve any ambiguities from previous rounds
- Confirm assumptions made during analysis
- Ask about any modules that lack clear requirements

Interview principles:
- Prefer closed questions with recommended options
- Never ask what the codebase already reveals
- Follow up immediately on unclear answers
- Include a recommended option with reasoning for every question

### Phase 2: Analysis

After Discovery, analyze the gathered information BEFORE generating any output. This is the "thinking" phase that produces the internal model driving test case generation.

**Step 1 -- Module Decomposition**

From the interview and codebase scan:

1. List every module identified (authentication, user management, core features, etc.)
2. For each module, extract:
   - Primary user journeys (happy paths)
   - Alternative paths (valid variations)
   - Error states (validation failures, server errors)
   - Edge cases (boundary conditions, rare inputs)
   - Security concerns (permissions, access control)
3. Assign a module type from the classification table (see Priority Distribution)

**Step 2 -- Coverage Heuristic Selection**

For each module, decide the testing approach based on complexity and risk:

| Module Characteristic | Recommended Approach |
|----------------------|---------------------|
| Simple CRUD with few rules | Use-case enumeration (list all user journeys) |
| Complex business rules with multiple conditions | Decision table testing (truth table of conditions -> outcomes) |
| Workflow/status-based features (orders, tickets) | State transition testing (valid/invalid state changes) |
| Inputs with ranges/limits (file size, character count) | Boundary value analysis (min, min+1, max-1, max) |
| Multiple interacting variables (filters, search combos) | Pairwise/combinatorial coverage (2-wise minimum) |
| Permission/role matrix | Permission matrix (role x action grid) |

Apply multiple approaches when a module has overlapping characteristics. For example, an order management module may need state transition testing for status flows AND decision table testing for discount rules.

**Step 3 -- Scenario Derivation Algorithm**

For each module, generate scenarios using this algorithm:

```
FOR each module M:
  1. IDENTIFY all user roles that interact with M
  2. FOR each role R:
     a. LIST all actions R can perform in M
     b. FOR each action A:
        - Generate HAPPY PATH: normal successful completion
        - Generate ALTERNATIVE PATHS: valid variations (different inputs, routes)
        - Generate ERROR CASES: each validation rule violated, each error state
        - Generate EDGE CASES: boundary values, empty inputs, max limits
        - Generate SECURITY CASES: unauthorized access, role escalation
  3. DEDUPLICATE: merge scenarios that test identical logic across roles
  4. APPLY coverage heuristic: fill gaps identified by decision table / state transition / BVA
  5. ASSIGN priority to each scenario using the Priority Decision Flowchart
```

**Step 4 -- Risk-Based Priority Assignment**

Apply the Priority Decision Flowchart (see `references/priority-classification.md`) to each scenario:

```
Is this a core user flow that every user must complete?
├── YES -> Is failure a security or data integrity risk?
│          ├── YES -> P0
│          └── NO  -> Does it block the primary business function?
│                     ├── YES -> P0
│                     └── NO  -> P1
└── NO  -> Is this a feature most users interact with?
           ├── YES -> Is failure visible and impactful to user experience?
           │          ├── YES -> P1
           │          └── NO  -> P2
           └── NO  -> Is an edge case or rare scenario?
                      ├── YES -> P2
                      └── NO  -> P1 (default to P1 when uncertain)
```

Then apply module-type auto-adjustment (see Priority Distribution section).

**Step 5 -- Coverage Sufficiency Check**

Before generating output, verify the analysis is complete:

- [ ] Every module has at least 8 test scenarios (critical modules: 15-25)
- [ ] Every module has Happy Path, Edge Cases, and Error Handling categories
- [ ] Every P0-classified module (auth, payments) has >= 40% P0 test cases
- [ ] Security scenarios exist for every module with role-based access
- [ ] State transitions are covered for every workflow-based feature
- [ ] Boundary values are tested for every numeric/size-limited input
- [ ] At least one negative test exists for every positive test in P0 flows

If any check fails, return to the relevant step and fill the gap before proceeding.

### Phase 3: Generation

Generate the UAT document following the exact output format below.

**Module Detection**

Identify modules from the interview and codebase scan. Typical module categories include:
- Authentication and session management
- User management and profiles
- Core business features (domain-specific)
- Admin panels and configuration
- Search and filtering
- File management and uploads
- Notifications and messaging
- Reports and analytics
- API and integrations
- Settings and preferences

**Priority Distribution**

Apply the default ratio to each module, then adjust based on module criticality:

| Priority | Default | Definition |
|----------|---------|------------|
| P0 (Critical) | 30% | Must pass before release. Core user flows, data integrity, security, payment flows. |
| P1 (High) | 45% | Should pass before release. Important features, key edge cases, secondary flows. |
| P2 (Medium) | 25% | Can be deferred. Nice-to-have validations, rare edge cases, UI polish. |

Auto-adjustment by module type:
- Authentication / Security: P0 +15%, P2 -15%
- Payments / Transactions: P0 +20%, P2 -20%
- Reports / Analytics: P0 -15%, P2 +15%
- Admin / Configuration: P0 -10%, P2 +10%
- Notifications: P0 -10%, P2 +10%

For detailed priority rules, consult `references/priority-classification.md`.

**Test Case Writing Rules**

ID format: `UAT-{Module}.{Scenario}.{Test}`
- Example: `UAT-1.1.1`, `UAT-2.3.5`, `UAT-12.2.1`

Test case names:
- Start with an action verb: "Login with valid credentials", "Upload PDF exceeding size limit"
- Be specific and measurable
- Include the expected behavior when relevant

Preconditions:
- State the system setup required before the test
- Include user roles, data states, and environment configuration
- Example: "User logged in as 'admin' with role SUPER_ADMIN"

Steps:
- Number each step clearly
- Use `<br>` for line breaks in markdown tables
- Be explicit: include exact inputs, button names, field values, URLs
- Example: `1. Navigate to /login<br>2. Enter username: admin<br>3. Enter password: Test@123<br>4. Click "Sign In"`

Expected results:
- Describe observable outcomes
- Include UI changes, redirects, data changes, response times
- Specify exact error messages for error case tests
- Example: `Redirect to /dashboard<br>Header shows "Welcome, Admin"<br>JWT stored in localStorage<br>Response time < 2s`

For detailed writing guidelines, consult `references/uat-best-practices.md`.

**Matrix-Enhanced Coverage (When Applicable)**

For modules with complex interacting variables, enhance use-case-based testing with matrix/combinatorial techniques. This bridges the gap between "enumerate user journeys" and "prove coverage mathematically."

When to apply matrix-enhanced coverage within UAT:

| Signal in the Module | Technique to Apply |
|---------------------|-------------------|
| Role x Action permissions | Permission matrix (role rows, action columns) -> one test per cell |
| Multiple filter/search criteria | Pairwise coverage -> test all 2-way combinations |
| Conditional pricing/discount rules | Decision table -> one test per rule combination |
| Workflow with status transitions | State-transition matrix -> test valid + invalid transitions |
| Input fields with min/max/format rules | Boundary value analysis -> min, min+1, max-1, max, invalid |

How to integrate matrix results into UAT output:
1. Design the matrix for the specific module interaction
2. Map each matrix cell to a UAT test case ID
3. Add the test cases to the module's scenario section as a dedicated subsection (e.g., "1.5 LOGIN - Permission Matrix" or "2.6 TASK - Filter Combinations")
4. Include a "Matrix Coverage Note" in the module section header explaining the approach
5. Reference the matrix shape in the Notes column of affected test cases

This does NOT require running the full `matrix-test-suite` skill. Apply the technique inline when the module warrants it. Use the full `matrix-test-suite` skill only when the user explicitly requests standalone mathematical coverage proof.

### Phase 4: Validation

After generating the UAT document, run the validation script:

```bash
node .claude/skills/uat-test-suite/scripts/validate-uat.js UAT-{ProjectName}.md
```

The script performs two levels of checks:

**Level 1 -- Structural Integrity (must pass):**
- All test IDs are unique (no duplicates)
- Summary table totals match actual test case counts
- P0/P1/P2 counts are accurate per module and in total
- No empty cells in required columns (ID, Test Case, Steps, Expected Result, Priority)
- ID format follows the `UAT-X.Y.Z` pattern
- Priority values are exactly P0, P1, or P2
- Status values (if present) are from the allowed set
- Per-module summary counts match actual per-module test counts

**Level 2 -- Quality Gates (warnings that should be addressed):**
- Priority distribution is within acceptable range (P0: 20-45%, P1: 35-55%, P2: 15-35%)
- Every module has minimum 8 test cases
- Critical modules (auth, payments, security) have >= 35% P0 test cases
- Coverage traceability matrix references only test IDs that actually exist in the document
- Coverage traceability matrix does not have orphaned test IDs (IDs not found in any module)
- No sequential ID gaps within a scenario (e.g., UAT-1.1.1, UAT-1.1.3 missing UAT-1.1.2)

Fix any Level 1 errors and address Level 2 warnings before delivering the document.

## Example Selection Guide

This skill includes two reference examples. Choose the closest match to the user's system to improve output consistency:

| Example | File | When to Reference |
|---------|------|-------------------|
| **Small SaaS** | `examples/small-saas-platform.md` | System has 3-7 modules, <80 test cases, single user type or 2-3 roles, startup/small team context, no compliance requirements |
| **Large Enterprise** | `examples/large-enterprise-system.md` | System has 8+ modules, 100+ test cases, multiple user roles with complex permissions, enterprise context, compliance/audit requirements (SOC2, HIPAA, GDPR) |

**How to use the examples:**
- Read the matching example BEFORE generating output to calibrate level of detail
- Match the example's test case density per module (Small: 8-12 per module, Large: 10-15 per module)
- Match the example's scenario categorization depth
- Match the example's precondition and steps specificity level
- If the user's system falls between the two, lean toward the larger example's level of detail

## Output Format

The generated file (`UAT-{ProjectName}.md`) must follow this exact structure:

### Section 1: Header

```markdown
# USER ACCEPTANCE TESTING (UAT) - {Project Name}

**Generated**: {Date}
**Version**: 1.0
**Total Test Cases**: {N}
**Priority Distribution**: P0: {X} ({X%}) | P1: {Y} ({Y%}) | P2: {Z} ({Z%})
```

### Section 2: UAT Summary Table

```markdown
## UAT Summary

| # | Module | Total | P0 | P1 | P2 |
|---|--------|-------|----|----|-----|
| 1 | Module Name | X | X | X | X |
| 2 | Module Name | X | X | X | X |
| **Total** | | **X** | **X** | **X** | **X** |
```

### Section 3: Module Sections

For each module, generate test scenarios grouped by category (Happy Path, Edge Cases, Error Handling, Security, etc.):

```markdown
## MODULE {N}: {Module Name} ({Total} Test Cases)

### {N}.1 {SCENARIO NAME} - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-N.1.1 | Test name | Preconditions | 1. Step<br>2. Step | Expected outcome | P0 | Not Started | | data | env |

### {N}.2 {SCENARIO NAME} - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-N.2.1 | Test name | Preconditions | 1. Step<br>2. Step | Expected outcome | P1 | Not Started | | data | env |
```

### Section 4: Coverage Traceability Matrix

```markdown
## Coverage Traceability Matrix

| Requirement ID | Requirement Description | Test Case IDs | Coverage Status |
|---------------|------------------------|---------------|-----------------|
| REQ-001 | User can login with email | UAT-1.1.1, UAT-1.1.2 | Covered |
| REQ-002 | Admin can manage users | UAT-4.1.1, UAT-4.1.2, UAT-4.2.1 | Covered |
| REQ-003 | System sends email notifications | | Gap |
```

### Section 5: Gap Analysis

```markdown
## Gap Analysis and Recommendations

### Uncovered Areas
| # | Area | Risk Level | Recommendation |
|---|------|-----------|----------------|
| 1 | Email notification delivery | High | Add test cases for email queue and delivery verification |
| 2 | Concurrent user sessions | Medium | Add load testing scenarios for session management |

### Coverage Summary
- **Total Requirements**: {N}
- **Covered**: {X} ({X%})
- **Gaps**: {Y} ({Y%})
- **Risk Assessment**: {Low/Medium/High}
```

For the complete output template with placeholders, consult `templates/uat-output-template.md`.

## Smart Update Workflow

When the user requests changes to an existing UAT document:

1. Read the existing UAT file
2. Identify which section needs modification
3. Apply only the requested changes (add test cases, change priorities, update module)
4. Recalculate the summary table totals automatically
5. Update the coverage traceability matrix if requirements changed
6. Re-run the validation script

Supported update operations:
- "Add more test cases for Module X" -- append new scenarios to the specified module
- "Change priority of UAT-X.Y.Z to P0" -- update the specific test case priority
- "Add a new module for {feature}" -- create a new module section and update summary
- "Remove test cases for {scenario}" -- delete and recalculate totals
- "Update expected results for UAT-X.Y.Z" -- modify the specific cell

## Additional Resources

### Reference Files
- **references/uat-best-practices.md** -- Test case writing guidelines, good vs bad examples, common pitfalls, execution tips
- **references/industry-standards.md** -- ISO 25010 quality characteristics, ISTQB UAT principles, IEEE 829 documentation standard
- **references/priority-classification.md** -- P0/P1/P2 definitions, default ratios, auto-adjustment rules by module type with industry data

### Example Files
- **examples/small-saas-platform.md** -- 5-module SaaS platform with ~50 test cases (demonstrates the complete format for small systems)
- **examples/large-enterprise-system.md** -- 15-module enterprise system with ~185 test cases (demonstrates scale for large systems)

### Template
- **templates/uat-output-template.md** -- Exact output format skeleton with placeholder values

### Validation Script
- **scripts/validate-uat.js** -- Node.js validation script (zero dependencies). Run: `node scripts/validate-uat.js <UAT-file.md>`

## What NOT to Do

- Do not generate test cases without completing the Discovery phase
- Do not skip the Analysis phase -- jumping from interview to output produces inconsistent results
- Do not mix technical QA (unit tests, integration tests) with business UAT
- Do not write vague steps like "User logs in" -- be explicit with every input
- Do not forget to calculate and verify summary totals
- Do not use inconsistent ID numbering across modules
- Do not skip the coverage traceability matrix and gap analysis
- Do not generate without understanding the user's business context
- Do not assume module priorities -- confirm with the user during interview
- Do not deliver without running the validation script
- Do not apply matrix/combinatorial techniques unless the module warrants it (simple CRUD does not need decision tables)
