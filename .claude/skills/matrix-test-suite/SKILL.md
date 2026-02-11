---
name: matrix-test-suite
description: |
  This skill should be used when the user asks to "generate test matrix",
  "create matrix test cases", "build test coverage matrix", "ma tran test",
  "L-matrix", "pairwise testing", "boundary value analysis", "test all combinations",
  "how many test cases do I need", "full coverage test suite", "decision table testing",
  "state transition testing", or provides specs/requirements that need systematic
  test case generation with mathematical coverage proof. Produces three files:
  MATRIX (test space model), TESTCASES (detailed test cases), and COVERAGE-REPORT
  (audit-grade traceability with mathematical proof of coverage completeness).
---

# Matrix-Based Test Suite Generator

## Purpose

Generate optimized, mathematically provable test suites from specifications and business rules using matrix-based test design. Transform requirements into structured test spaces (matrices), derive test cases that achieve complete coverage with minimal redundancy, and produce an audit-grade coverage report proving no meaningful combination is missed.

## When to Use

Activate this skill when:
- Specifications or business rules need systematic test case generation
- The user wants to know "how many test cases are needed" for a given problem
- Multiple variables/dimensions interact to produce different outcomes
- Coverage completeness must be provable (regulatory, audit, quality gate)
- Existing test suites need optimization (reduce redundancy, fill gaps)
- Complex pricing rules, permission matrices, or conditional logic require testing

## Cognitive Framework

Each phase of this skill maps to a deliberate thinking mode. This prevents the agent from improvising and ensures disciplined progression through the problem space.

| Phase | Thinking Mode | Cognitive Purpose | Guard Rails |
|-------|--------------|-------------------|-------------|
| 1. Discovery | **Divergent** | Cast wide net. Explore all possible dimensions, rules, edge cases. Ask "what else?" repeatedly. | Do not narrow or filter yet. No matrix building. |
| 2. Analysis | **Analytical** | Decompose. Classify each dimension. Apply ECP, BVA, risk scoring. Quantify partitions. | Do not generate test cases yet. Pure measurement. |
| 3. Matrix Design | **Convergent** | Synthesize dimensions into optimal matrix structure(s). Select shapes, build diagrams, resolve dependencies. | Commit to a design before proceeding. User may override. |
| 4. Test Generation | **Strategic** | Execute. Derive test cases from matrix cells with precision. Apply optimization. Assign priorities. | Follow the tiered approach. No skipping boundary tests. |
| 5. Validation | **Evaluative** | Verify. Run script, cross-check totals, prove coverage mathematically. Fix mismatches before delivery. | Zero tolerance for validation failures. Loop until PASS. |

This progression (Divergent -> Analytical -> Convergent -> Strategic -> Evaluative) prevents common agent failure modes: premature matrix design (skipping Discovery), skipping boundary analysis (jumping to test cases), and delivering unvalidated output.

## Workflow Orchestration

Follow this exact sequence. Do not skip steps. Do not reorder.

```
START
  │
  ▼
┌──────────────────────────────────────────────────────┐
│ PHASE 1: DISCOVERY (Divergent Thinking)              │
│ ┌─ Conduct structured interview (3-5 rounds)         │
│ ├─ Scan spec files, PRDs, codebase                   │
│ └─ Output: dimension inventory + business rules list │
│    ↓ Gate: User confirms dimensions are complete     │
└──────────────────────────────────────────────────────┘
  │
  ▼
┌──────────────────────────────────────────────────────┐
│ PHASE 2: ANALYSIS (Analytical Thinking)              │
│ ┌─ Classify each dimension (type, ECP, BVA)          │
│ ├─ Score risk: P0 / P1 / P2 per dimension            │
│ ├─ Identify conditional dependencies                 │
│ └─ Output: annotated dimension table + partition count│
│    ↓ Gate: Partition math verified                    │
└──────────────────────────────────────────────────────┘
  │
  ▼
┌──────────────────────────────────────────────────────┐
│ PHASE 3: MATRIX DESIGN (Convergent Thinking)         │
│ ┌─ Select matrix shape(s) via Selection Rules below  │
│ ├─ Select coverage level via Strategy Ladder below   │
│ ├─ Build matrix diagrams + sub-matrices              │
│ └─ Output: MATRIX-{Feature}.md                       │
│    ↓ Gate: User approves matrix design               │
└──────────────────────────────────────────────────────┘
  │
  ▼
┌──────────────────────────────────────────────────────┐
│ PHASE 4: TEST GENERATION (Strategic Thinking)        │
│ ┌─ Derive test cases from matrix cells (10-col)      │
│ ├─ Apply tiered optimization (full → boundary → opt) │
│ ├─ Assign P0/P1/P2 priorities                        │
│ └─ Output: TESTCASES-{Feature}.md                    │
│    ↓ Gate: All cells have ≥1 test                    │
└──────────────────────────────────────────────────────┘
  │
  ▼
┌──────────────────────────────────────────────────────┐
│ PHASE 5: VALIDATION (Evaluative Thinking)            │
│ ┌─ Generate: COVERAGE-REPORT-{Feature}.md            │
│ ├─ Run: validate-matrix.js on all 3 files            │
│ ├─ If FAIL → fix errors → re-run (loop max 3x)      │
│ └─ Output: 3 validated files + PASS verdict          │
│    ↓ Gate: Script returns PASS                       │
└──────────────────────────────────────────────────────┘
  │
  ▼
DELIVER to user
```

**Self-correction loop**: If `validate-matrix.js` returns FAIL, read the error list, fix the specific issues in the affected file(s), and re-run validation. Repeat up to 3 times. If still failing after 3 attempts, deliver with a note explaining the remaining issues and manual steps needed.

## Shape Selection Rules

Quick-reference decision map for choosing matrix type(s). Consult `references/matrix-shapes-library.md` for full definitions.

**By dimension count:**

| Dimensions | Primary Shape | Add-ons |
|-----------|--------------|---------|
| 2 | L-shaped matrix | + BVA tests |
| 3 (1 shared axis) | T-shaped matrix | + sub-matrices for conditionals |
| 3 (circular deps) | Y-shaped (3 L-matrices) | + decision table for rules |
| 4+ (paired) | X-shaped or split into multiple L-matrices | + risk overlay |
| 5+ | Pairwise covering array + focused L-matrices per module | + boundary tests |
| 10+ | Split by module, pairwise per module, merge results | + tiered optimization |

**By rule type:**

| Rule Nature | Matrix Type | When |
|------------|-------------|------|
| Boolean/conditional logic | Decision table | If/else rules, AND/OR conditions |
| Workflow/state changes | State-transition matrix | Order status, session lifecycle |
| Same-type entity interaction | Symmetric/triangular matrix | User-to-user, account transfers |
| Permission/access control | L-matrix (Role x Resource) | RBAC, feature flags |
| Pricing/calculation | L-matrix + decision table hybrid | Tiered pricing, discounts |

**Combining shapes**: Complex systems typically require 2-4 matrix types combined. Use L-matrix for primary dimensions, decision table for rule logic, state-transition for workflows, and traceability matrix for coverage proof.

## Coverage Strategy Ladder

Select the coverage level based on dimension count, risk profile, and practical constraints. Start at Level 1 and escalate only when needed.

### Level 1: Direct Matrix (default for ≤5 dimensions)

- **Technique**: L-matrix / T-matrix / decision table
- **Coverage**: Full cartesian of core dimensions + BVA at boundaries
- **Optimization**: ECP merging, impossible combination pruning
- **Target**: 100% cell coverage, 100% boundary coverage
- **Test count**: Typically 15-60 tests
- **When**: Clear business rules, few dimensions, regulatory/audit requirements

### Level 2: Pairwise-Augmented (for 6-10 dimensions)

- **Technique**: Pairwise covering array for cross-dimension interactions + focused L-matrices for critical pairs
- **Coverage**: 100% pairwise (2-wise) coverage + full coverage of P0 dimension pairs
- **Optimization**: All Level 1 techniques + default-value fixing for P2 dimensions
- **Target**: 100% pairwise, 100% P0 cell coverage
- **Test count**: Typically 40-120 tests
- **When**: Multiple feature interactions, configuration testing, API parameter combinations

### Level 3: Modular N-wise (for >10 dimensions)

- **Technique**: Decompose system into modules of ≤5 dimensions each. Apply Level 1 within each module. Apply 2-wise or 3-wise across modules.
- **Coverage**: 100% within-module coverage + n-wise cross-module coverage
- **Optimization**: All Level 1-2 techniques + module boundary testing + risk-weighted sampling
- **Target**: 100% within-module, ≥95% cross-module pairwise
- **Test count**: Typically 100-300 tests
- **When**: Enterprise systems, microservices, multi-module applications

**Escalation trigger**: If Level 1 produces >100 tests, consider Level 2 optimization. If any dimension set has >10 interacting variables, apply Level 3 decomposition.

## Five-Phase Workflow (Detail)

### Phase 1: Discovery (Divergent Thinking)

Conduct a structured interview using the AskQuestion tool (3-5 rounds):

1. **System context**: domain, modules, user roles, core flows
2. **Dimensions**: all behavior-influencing variables, types, value ranges, constraints, conditional dependencies
3. **Business rules**: conditions, thresholds, exceptions, expected outputs per combination
4. **Risk assessment**: critical combinations (money/security/data), known bug areas, usage frequency, failure consequences
5. **Scope**: inclusions/exclusions, timeline, environment constraints, remaining ambiguities

Also scan available sources: spec files, PRDs, codebase (validation rules, API parameters, database schemas, enums, constants). Gate: user confirms dimension inventory is complete.

### Phase 2: Analysis (Analytical Thinking)

For each dimension:

1. **Classify**: categorical, numeric-range, boolean, state, threshold
2. **Apply ECP**: group equivalent values, select one representative per class
3. **Apply BVA**: 3-value for P0 dimensions (boundary + both neighbors), 2-value for P1/P2
4. **Score risk**: P0 (critical path, financial, security) / P1 (important) / P2 (low risk) via Probability x Impact
5. **Count partitions**: record equivalence class count per dimension

Identify conditional dimensions (variables that only apply under certain conditions) -- these become sub-matrices, not full cross-product members.

### Phase 3: Matrix Design (Convergent Thinking)

1. Select matrix shape(s) via Shape Selection Rules above
2. Select coverage level via Coverage Strategy Ladder above
3. Build matrix diagrams with cell identifiers (e.g., M-A1, F-A2)
4. Build sub-matrices for conditional dimensions, decision tables for complex rules
5. Document expected behavior per cell
6. Present reasoning to user. User may override shape or level selection.

Consult `references/matrix-shapes-library.md` for detailed type definitions and visual examples.

### Phase 4: Test Generation (Strategic Thinking)

Derive test cases in three tiers:

- **Tier 1 (Full Matrix)**: one test per logical cell including sub-matrices -- the complete test space
- **Tier 2 (Boundaries)**: add BVA tests at each dimension transition (3-value P0, 2-value P1/P2)
- **Tier 3 (Optimized)**: when full matrix is impractical, merge identical cells, apply pairwise for >5 values, fix defaults for P2 dimensions. Always preserve: all P0 cells, all boundary tests, at least one test per unique expected outcome.

**Format**: 10 columns -- ID | Matrix Cell | Description | Preconditions | Steps | Expected Result | Priority | Status | Notes | Test Data

**ID pattern**: `MTX-{MatrixIndex}-{CellRef}-{TestIndex}` (e.g., `MTX-1-MA2H1-01`)

**Priority**: P0 (high probability x high impact), P1 (medium), P2 (low-risk, rare, or similar to existing P0/P1). Consult `references/combinatorics-cheatsheet.md` for formulas.

### Phase 5: Validation (Evaluative Thinking)

1. Generate `COVERAGE-REPORT-{Feature}.md` with mathematical proof
2. Run validation: `node scripts/validate-matrix.js MATRIX-*.md TESTCASES-*.md COVERAGE-REPORT-*.md`
3. Script checks: ID uniqueness/format, summary totals vs actual counts, cell-to-test mapping completeness, required columns, priority values (P0/P1/P2), bidirectional traceability
4. **If FAIL**: read errors, fix affected files, re-run (loop max 3x)
5. **If PASS**: deliver all three files

## Output Format

Each run produces exactly three files:

### File 1: `MATRIX-{Feature}.md`
Test space model containing: context and scope, dimensions table, matrix shape selection rationale, matrix diagram(s), decision tables (if applicable), sub-matrices for conditional dimensions, and cell-level expected behavior summary.

### File 2: `TESTCASES-{Feature}.md`
Detailed test cases containing: summary table (matrix ref, cell count, test count), total test cases, ID conventions, grouped test cases in 10-column tables, and risk-based prioritization explanation.

### File 3: `COVERAGE-REPORT-{Feature}.md`
Audit-grade coverage proof containing: executive summary, dimension coverage table, mathematical proof (formulas, per-cell counts, boundary counts, optimization rationale), full traceability matrix (requirement -> matrix cell -> test case IDs), gap analysis, and coverage verdict (PASS/FAIL).

For exact section structures and placeholder templates, consult `templates/`.

## Coverage Calculation Rules

To prove 100% coverage, the report must show:

1. **Dimension completeness**: every equivalence class of every dimension has at least one test
2. **Cell completeness**: every logical matrix cell (including sub-matrix cells) maps to at least one test case
3. **Boundary completeness**: every transition boundary between equivalence classes has boundary tests
4. **Outcome completeness**: every distinct expected outcome appears in at least one test
5. **Formula transparency**: show `Total = base_cells + sub_matrix_cells + boundary_tests - merged_duplicates`

For detailed calculation methodology, consult `references/coverage-calculation-guide.md`.

## Optimization Rules

Apply these rules to reduce test count without sacrificing coverage:

- **Equivalence class merging**: combine cells with identical expected behavior AND identical risk level
- **Boundary sharing**: when a boundary test covers two adjacent cells, count it once
- **Pairwise reduction**: for >5 interacting dimensions, use 2-wise or 3-wise covering arrays instead of full cartesian product
- **Default fixing**: for low-risk dimensions, fix to the most common value in non-focused tests
- **Impossible combination pruning**: remove combinations that cannot occur (e.g., "senior discount" for age < 60)
- **DRY enforcement**: no two test cases with identical preconditions, steps, and expected results

Always document what was optimized and why in the coverage report.

## Smart Update Workflow

When specifications change after initial generation:

1. Read the existing MATRIX, TESTCASES, and COVERAGE-REPORT files
2. Identify which dimensions, rules, or cells are affected by the change
3. Update only the affected sections (add/remove/modify cells and tests)
4. Recalculate summary totals and coverage proof
5. Re-run validation script
6. Document changes in a "Change Log" section at the bottom of each file

Supported operations:
- "Add a new dimension" -- extend matrices, generate new tests, update coverage
- "Change a business rule" -- update affected cells and tests, recalculate
- "Remove a dimension" -- prune matrices and tests, recalculate
- "Add more tests for X" -- add tests to specific cells without full regeneration

## Additional Resources

### Reference Files
- **`references/matrix-shapes-library.md`** -- All 16 matrix types with definitions, selection criteria, visual examples, and testing applications
- **`references/combinatorics-cheatsheet.md`** -- ECP, BVA, pairwise/n-wise formulas, cartesian product, optimization techniques
- **`references/coverage-calculation-guide.md`** -- Audit-grade coverage proof methodology, formulas, conditional dimension handling

### Template Files
- **`templates/matrix-output-template.md`** -- MATRIX file skeleton with placeholder values
- **`templates/testcases-output-template.md`** -- TESTCASES file skeleton with 10-column format
- **`templates/coverage-report-template.md`** -- COVERAGE-REPORT skeleton with proof sections

### Example Files
- **`examples/small-hotpot-pricing.md`** -- Complete 3-file output for a small business rule (~20 tests)
- **`examples/large-ecommerce-checkout.md`** -- Complete 3-file output for a complex system (~100+ tests, multiple matrices)

### Validation Script
- **`scripts/validate-matrix.js`** -- Node.js validation script (zero dependencies). Run: `node scripts/validate-matrix.js <files...>`

## What NOT to Do

- Do not generate test cases without completing the Discovery phase interview
- Do not skip the coverage report -- every run must prove coverage mathematically
- Do not create redundant tests that share identical conditions and expected results
- Do not use full cartesian product when dimensions exceed 5 without applying optimization
- Do not leave matrix cells without at least one mapped test case
- Do not assume dimension priorities -- confirm with the user during interview
- Do not mix test design levels (unit testing vs system testing vs acceptance testing)
- Do not forget conditional/dependent dimensions -- they must be sub-matrices, not ignored
- Do not present optimized counts without showing the full count for reference
