# Test Cases -- {Feature/Project Name}

## 1. Summary

| Matrix Reference | Logical Cells | Test Cases | Notes |
|-----------------|---------------|-----------|-------|
| {Primary matrix name} | {N} | {N} | {1 case per cell / notes} |
| {Sub-matrix name} | {N} | {N} | {notes} |
| {Boundary tests} | {N} | {N} | {boundary transitions} |
| **Total** | **{T}** | **{T}** | |

**Total test cases**: **{T}**

**Priority distribution**:
- P0 (Critical): {X} ({X%})
- P1 (High): {Y} ({Y%})
- P2 (Medium): {Z} ({Z%})

## 2. Conventions

### ID Pattern

`MTX-{MatrixIndex}-{CellRef}-{TestIndex}`

- **MatrixIndex**: sequential number for each matrix in the MATRIX file (1, 2, 3...)
- **CellRef**: cell identifier from the matrix (e.g., MA1, FA2, MA2H1, C3)
- **TestIndex**: sequential within the cell (01, 02...)

Examples: `MTX-1-MA1-01`, `MTX-1-MA2H1-01`, `MTX-2-C3-01`

### Priority Definitions

| Priority | Definition | Examples |
|----------|-----------|---------|
| P0 (Critical) | Must pass. Core business logic, financial rules, boundary transitions, security paths. | Payment calculation, age boundary tests |
| P1 (High) | Should pass. Important features, secondary flows, non-boundary representative values. | Standard user flows, mid-range values |
| P2 (Medium) | Can defer. Low-risk variations, sanity checks, duplicate-similar cases. | Random cross-checks, rare combinations |

---

## 3. Detailed Test Cases

### 3.1 {Matrix Section Name} -- {Group Description} ({N} cases)

#### {Sub-group}: {Description}

| ID | Matrix Cell | Description | Preconditions | Steps | Expected Result | Priority | Status | Notes | Test Data |
|----|-------------|-------------|---------------|-------|-----------------|----------|--------|-------|-----------|
| MTX-{X}-{Cell}-01 | {CellID} | {Short description} | {System state required} | 1. {Step}<br>2. {Step}<br>3. {Step} | {Observable outcome}<br>{Data changes}<br>{UI feedback} | {P0/P1/P2} | Not Started | {Any notes} | {Specific test values} |
| MTX-{X}-{Cell}-02 | {CellID} | {Short description} | {preconditions} | 1. {Step}<br>2. {Step} | {Expected} | {Priority} | Not Started | | {data} |

### 3.2 {Sub-Matrix Section} -- {Group Description} ({N} cases)

| ID | Matrix Cell | Description | Preconditions | Steps | Expected Result | Priority | Status | Notes | Test Data |
|----|-------------|-------------|---------------|-------|-----------------|----------|--------|-------|-----------|
| MTX-{X}-{Cell}-01 | {CellID} | {description} | {preconditions} | 1. {Step}<br>2. {Step} | {Expected} | {Priority} | Not Started | | {data} |

### 3.3 Boundary Tests -- {Dimension Transitions} ({N} cases)

| ID | Matrix Cell | Description | Preconditions | Steps | Expected Result | Priority | Status | Notes | Test Data |
|----|-------------|-------------|---------------|-------|-----------------|----------|--------|-------|-----------|
| MTX-{X}-BD{N}-01 | BD-{boundary} | {Boundary description} | {preconditions} | 1. {Step}<br>2. {Step} | {Expected at boundary} | P0 | Not Started | Boundary test | {boundary value} |

---

## 4. Risk-Based Prioritization

### Priority Rationale

| Matrix Region | Default Priority | Adjustment | Final | Reason |
|--------------|-----------------|------------|-------|--------|
| {Region/cells} | {P1} | {+1 level} | {P0} | {Why elevated: financial impact, known bug area, etc.} |
| {Region/cells} | {P1} | {None} | {P1} | {Standard risk} |
| {Region/cells} | {P1} | {-1 level} | {P2} | {Why lowered: rare path, already similar to P0 test, etc.} |

### Coverage Checklist

- [ ] Every matrix cell has at least one test case
- [ ] All boundary transitions have BVA tests
- [ ] All distinct expected outcomes appear in at least one test
- [ ] No two tests have identical preconditions + steps + expected results
- [ ] P0 tests cover all critical business rules
- [ ] Summary totals match actual test case counts

## Change Log

| Date | Change | Affected Tests |
|------|--------|---------------|
| {YYYY-MM-DD} | Initial generation | All |
