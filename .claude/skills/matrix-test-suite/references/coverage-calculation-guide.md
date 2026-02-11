# Coverage Calculation Guide

Step-by-step methodology for computing audit-grade coverage proof. This guide explains how to build the mathematical proof section of the COVERAGE-REPORT file.

## 1. Coverage Proof Structure

Every coverage report must answer five questions with mathematical evidence:

1. **Dimension completeness**: Is every equivalence class of every dimension tested?
2. **Cell completeness**: Does every logical matrix cell have at least one test?
3. **Boundary completeness**: Is every transition boundary tested?
4. **Outcome completeness**: Does every distinct expected outcome appear?
5. **Traceability**: Can every test trace back to a requirement, and every requirement forward to a test?

---

## 2. Step-by-Step Calculation

### Step 1: Count Dimensions and Partitions

Create a dimension inventory table:

```
| # | Dimension | Type        | Equivalence Classes | Boundary Points | Risk |
|---|-----------|-------------|--------------------|-----------------| -----|
| 1 | Sex       | categorical | 2 (Male, Female)   | 0               | P1   |
| 2 | Age       | numeric     | 5 (<10, 10, 11-17, 18-59, >=60) | 4 (10, 11, 18, 60) | P0 |
| 3 | Height    | threshold   | 2 (<100cm, >=100cm) | 1 (100cm)      | P1   |
```

Record:
- `D` = number of dimensions
- `EC_i` = number of equivalence classes for dimension i
- `BP_i` = number of boundary points for dimension i

### Step 2: Identify Conditional Dependencies

List which dimensions are conditional:

```
| Conditional Dim | Condition                  | Applies To     |
|-----------------|---------------------------|----------------|
| Height          | Only when Sex=Male AND Age=10 | Cell M-A2 only |
```

Record:
- `CD` = number of conditional dimensions
- For each: the specific cells it applies to

### Step 3: Calculate Base Matrix Cells

For unconditional dimensions only:

```
Base cells = Product of EC_i for all unconditional dimensions
```

Example: Sex (2) x AgeGroup (5) = 10 base cells

Note: If Age has 6 brackets (including boundary-specific ones like "exactly 10"), use the full partition count.

### Step 4: Calculate Sub-Matrix Additional Cells

For each conditional dimension:

```
Additional cells = applicable_base_cells x (conditional_EC - 1)
```

Example: Height applies to 1 cell (Male, Age=10), has 2 values:
- Additional = 1 x (2 - 1) = 1 additional cell
- The original Male-Age10 cell splits into Male-Age10-ShortHeight and Male-Age10-TallHeight
- Net change: remove 1 original cell, add 2 specific cells = +1 net

### Step 5: Calculate Total Logical Cells

```
Total logical cells = Base cells - replaced_cells + expanded_cells
```

Or equivalently:

```
Total logical cells = Base cells + sum(additional_cells for each conditional dimension)
```

### Step 6: Calculate Boundary Test Additions

For P0 dimensions (3-value BVA):
```
BVA_tests_P0 = sum(3 x BP_i) for each P0 dimension
```

For P1/P2 dimensions (2-value BVA):
```
BVA_tests_P1P2 = sum(2 x BP_i) for each P1/P2 dimension
```

Raw BVA total:
```
Raw BVA = BVA_tests_P0 + BVA_tests_P1P2
```

### Step 7: Deduplicate

Remove BVA values that overlap with ECP representatives already in the base matrix:

```
Unique BVA additions = Raw BVA - overlapping_values
```

An overlap occurs when a boundary value IS the representative value for its equivalence class (common for exact-value classes like "Age = 10").

### Step 8: Apply Optimization Reductions

Count reductions:
- `M` = cells merged (identical behavior + identical risk)
- `I` = impossible combinations removed
- `P` = pairwise reduction (if applied)

```
Optimization reduction = M + I + P
```

### Step 9: Final Count Formula

```
Total recommended tests =
    Total logical cells              [from Step 5]
  + Unique BVA additions             [from Step 7]
  - Optimization reduction           [from Step 8]
  + Sanity checks                    [optional: 0-3 random verification tests]

= FINAL TEST COUNT
```

### Step 10: Verify Coverage Percentage

```
Cell coverage = (cells_with_at_least_one_test / total_logical_cells) x 100%
Boundary coverage = (boundaries_with_BVA_test / total_boundaries) x 100%
Outcome coverage = (distinct_outcomes_tested / total_distinct_outcomes) x 100%
```

All three must be 100% for PASS verdict.

---

## 3. Conditional Dimension Deep Dive

### Identification

A dimension is conditional when its values only affect the output under specific conditions. Signs:

- "If X AND Y, then Z matters" in the spec
- A variable is mentioned only in a subset of rules
- A variable has "N/A" or "any" for most combinations

### Handling Options

**Option A: Sub-matrix (recommended)**
- Keep the dimension out of the main matrix cartesian product
- Create a sub-matrix only for the cells where it applies
- Reduces total count significantly

**Option B: Full inclusion with N/A marking**
- Include in main cartesian product
- Mark non-applicable cells as "N/A -- same as default"
- Creates more cells but simpler structure
- Use when the conditional dimension applies to >50% of cells

### Coverage Rule for Conditional Dimensions

Even as sub-matrices, every conditional equivalence class must have at least one test. The coverage report must explicitly show:

```
| Conditional Dim | EC Values    | Tested In     |
|-----------------|-------------|---------------|
| Height          | <100cm      | MTX-1-MA2H1-01 |
| Height          | >=100cm     | MTX-1-MA2H2-01 |
```

---

## 4. Optimization Documentation Requirements

When applying any optimization, document in the coverage report:

### For ECP Merging

```
MERGED: Cells [F-A1] and [F-A2] merged as "Female <=10"
- Both have expected output: 100$
- Both have risk level: P0
- No rule distinguishes between age <10 and age =10 for females
- Optimization saves: 1 test case
```

### For Pairwise Reduction

```
PAIRWISE APPLIED: Dimensions [UserType, PayMethod, Device, ShipMethod, CouponType]
- Full cartesian: 3 x 4 x 3 x 3 x 2 = 216 combinations
- Pairwise (2-wise): 16 combinations
- Reduction: 92.6%
- Justification: >5 dimensions, interactions are pairwise, not higher-order
```

### For Impossible Combination Pruning

```
PRUNED: [GuestUser + AdminPanel] -- impossible by system design
- Guest users cannot access admin panel
- Removes 12 combinations from matrix
```

---

## 5. Traceability Matrix Format

### Forward Traceability (Requirement -> Tests)

```
| Req ID  | Requirement Description            | Matrix Cells  | Test IDs                    | Status  |
|---------|-----------------------------------|---------------|-----------------------------| --------|
| REQ-001 | Children under 10 pay 100$        | M-A1, F-A1    | MTX-1-MA1-01, MTX-1-FA1-01 | Covered |
| REQ-002 | Male 10yr, tall: 110$             | M-A2-H2       | MTX-1-MA2H2-01              | Covered |
| REQ-003 | Senior discount: Male -30$        | M-A6          | MTX-1-MA6-01                | Covered |
```

### Backward Traceability (Test -> Requirements)

```
| Test ID         | Covers Requirements | Matrix Cells |
|-----------------|--------------------| -------------|
| MTX-1-MA1-01    | REQ-001            | M-A1         |
| MTX-1-MA2H2-01  | REQ-002            | M-A2-H2      |
```

### Coverage Gaps

Any requirement with no test IDs = GAP. Document with risk level and recommendation:

```
| Gap # | Requirement | Risk Level | Recommendation |
|-------|------------|-----------|----------------|
| GAP-1 | REQ-007    | High      | Add test case for edge case X |
```

---

## 6. Coverage Verdict Criteria

### PASS (100% Coverage)

All of the following must be true:
- Every equivalence class has at least one test
- Every matrix cell has at least one test
- Every boundary has BVA test(s)
- Every requirement maps to at least one test
- Every test maps to at least one requirement
- Summary totals match actual counts
- No gaps identified

### CONDITIONAL PASS

- All P0 and P1 requirements covered
- P2 gaps exist but are documented with risk assessment
- Deferred P2 tests are listed with justification

### FAIL

- Any P0 requirement without a test
- Any matrix cell without a test (excluding pruned impossible cells)
- Summary totals do not match
- Undocumented gaps exist

---

## 7. Worked Example: Coverage Proof for Hotpot Pricing

### Dimension Inventory

| # | Dimension | Type | ECs | Boundaries | Risk |
|---|-----------|------|-----|-----------|------|
| 1 | Sex | categorical | 2 | 0 | P1 |
| 2 | Age | numeric | 6 (<10, 10, 11-17, 18, 19-59, >=60) | 4 (9/10, 10/11, 17/18, 59/60) | P0 |
| 3 | Height | threshold | 2 (<100cm, >=100cm) | 1 (100cm) | P1 |

### Conditional: Height only for Male + Age=10

### Base Matrix

Sex (2) x AgeGroup (6) = 12 cells

### Sub-Matrix Addition

Height for Male-Age10: 1 cell becomes 2 = +1 additional
Total logical cells: 12 + 1 = 13

### BVA Additions

Age (P0, 3-value): 4 boundaries x 3 values = 12 raw BVA values
- Values: {9, 10, 11, 10, 11, 12, 17, 18, 19, 59, 60, 61}
- Unique: {9, 10, 11, 12, 17, 18, 19, 59, 60, 61} = 10 values
- Already covered by ECP representatives: {10, 18, 60} and partially {9 covers <10 class}
- Net new BVA tests: ~6 additional tests

Height (P1, 2-value): 1 boundary x 2 values = 2 raw
- Already covered by sub-matrix tests
- Net new: 0

### Final Count

```
13 (logical cells) + 6 (boundary) + 1 (sanity cross-check) = 20 test cases
```

### Verification

- Cell coverage: 13/13 = 100%
- Boundary coverage: 4/4 boundaries = 100%
- Outcome coverage: 6/6 distinct prices (100, 110, 150, 200, 170, 160) = 100%
- Verdict: PASS
