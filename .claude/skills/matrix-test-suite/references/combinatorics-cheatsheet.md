# Combinatorics Cheatsheet for Test Design

Quick reference for all mathematical techniques used to calculate test case counts and optimize test suites.

## 1. Equivalence Class Partitioning (ECP)

### Concept

Divide input domain into classes where all values in a class produce equivalent behavior. Test one representative per class.

### Rules for Identifying Classes

| Input Type | Valid Classes | Invalid Classes | Example |
|-----------|--------------|-----------------|---------|
| Range [a, b] | 1 valid: [a, b] | 2 invalid: (<a), (>b) | Age 18-59: valid=[18,59], invalid=[<18], [>59] |
| Set {v1, v2, v3} | 1 per member or 1 for set | 1 invalid: not in set | PayMethod {card, cash, crypto}: 3 valid + 1 invalid |
| Boolean | 1 true, 1 false | N/A | isActive: {true, false} |
| Constrained range | Split by rule boundaries | Values outside constraints | Age with rules at 10, 18, 60: classes [<10], [10], [11-17], [18-59], [>=60] |

### Formula

```
Minimum test cases (ECP) = Number of equivalence classes
```

Each class requires at least one representative value.

### Selecting Representatives

- For ranges: use midpoint of class (e.g., class [11-17] -> representative 14)
- For sets: use any member
- For booleans: true and false

---

## 2. Boundary Value Analysis (BVA)

### Concept

Defects cluster at boundaries between equivalence classes. Test values at and near each boundary.

### 2-Value BVA

For each boundary point B between classes:
- **On-point**: the boundary value itself (B)
- **Off-point**: first value in adjacent class (B+1 or B-1)

```
Tests per boundary = 2
Total BVA tests = 2 x number_of_boundaries
```

### 3-Value BVA

For each boundary point B:
- **Below**: B-1 (last value in lower class)
- **On**: B (boundary value)
- **Above**: B+1 (first value in upper class)

```
Tests per boundary = 3
Total BVA tests = 3 x number_of_boundaries
```

### Risk-Adaptive BVA (Default for this skill)

- **P0 dimensions**: 3-value BVA (thorough)
- **P1/P2 dimensions**: 2-value BVA (lean)

### Example: Age with boundaries at 10, 11, 18, 60

| Boundary | 3-Value BVA Tests | 2-Value BVA Tests |
|----------|-------------------|-------------------|
| <10 / 10 | 9, 10, 11* | 9, 10 |
| 10 / 11 | 10*, 11, 12 | 10, 11 |
| 17 / 18 | 17, 18, 19 | 17, 18 |
| 59 / 60 | 59, 60, 61 | 59, 60 |

*Note: shared values (like 10, 11) count once. Deduplicate when calculating totals.

### Deduplication Formula

```
Unique BVA values = union of all BVA test values across all boundaries
BVA test count = |unique BVA values| - |values already covered by ECP representatives|
```

---

## 3. Cartesian Product (Full Combination)

### Formula

For k dimensions with v_1, v_2, ..., v_k values respectively:

```
Total combinations = v_1 x v_2 x ... x v_k = Product(v_i) for i=1..k
```

### Homogeneous Case

All dimensions have the same number of values v:

```
Total = v^k
```

### Example

| Dimension | Values | Count |
|-----------|--------|-------|
| Sex | Male, Female | 2 |
| AgeGroup | <10, 10, 11-17, 18-59, >=60 | 5 |
| Height | <100cm, >=100cm | 2 |

```
Full cartesian = 2 x 5 x 2 = 20
```

### When to Use Full Cartesian

- Dimensions <= 4 AND total combinations <= 50
- All dimensions are high-risk (P0)
- Regulatory requirement for exhaustive testing

### When NOT to Use

- Total exceeds 100: apply pairwise or ECP optimization
- Many dimensions are P2: fix defaults for low-risk dimensions

---

## 4. Conditional Dimensions (Sub-Matrices)

### Concept

Some dimensions only apply under certain conditions. These should NOT be included in the full cartesian product.

### Formula

```
Total cells = main_matrix_cells + sub_matrix_additional_cells

Where:
- main_matrix_cells = cartesian product of unconditional dimensions
- sub_matrix_additional_cells = cells added by conditional dimension - cells it replaces
```

### Example: Hotpot Pricing

- Main dimensions: Sex (2) x AgeGroup (6) = 12 cells
- Height only applies to Male + Age=10: adds 2 cells, replaces 1 cell
- Net: 12 - 1 + 2 = 13 logical cells

### General Rule

For each conditional dimension:
1. Identify which main matrix cell(s) it applies to
2. Count: `applicable_cells x (conditional_values - 1)` additional cells
3. The `-1` accounts for the default case already in the main matrix

---

## 5. Pairwise / N-Wise Coverage

### Concept

Instead of all combinations, ensure every pair (or t-tuple) of parameter values appears in at least one test.

### Approximate Test Count

**Pairwise (t=2)**:
```
T_approx = max(v_i) x max(v_j)
```
Where v_i, v_j are the two largest parameter value counts.

**3-wise (t=3)**:
```
T_approx = max(v_i) x max(v_j) x max(v_k)
```

### Defect Detection Rate

| Coverage Level | Typical Defect Detection |
|---------------|------------------------|
| 1-wise (each value) | ~40-60% |
| 2-wise (pairwise) | ~70-85% |
| 3-wise | ~90-95% |
| 4-wise | ~95-98% |
| Exhaustive | 100% (of combinatorial defects) |

### When to Apply

- **Use pairwise** when: dimensions > 5, not all combinations are critical
- **Use 3-wise** when: high-risk system, regulatory requirement for thorough coverage
- **Keep full cartesian** when: dimensions <= 4, all P0, total <= 50

---

## 6. Decision Table Combination Count

### Binary Conditions

```
Rules = 2^n (where n = number of binary conditions)
```

### Mixed-Value Conditions

```
Rules = Product(values_per_condition)
```

### Simplification

After building the full table:
1. Identify columns (rules) with identical actions
2. Check if the differing condition is irrelevant (doesn't affect output)
3. Merge and mark irrelevant condition with "-"
4. Simplified count <= original count

---

## 7. State-Transition Test Count

### Valid Transitions

```
Minimum tests >= number of valid transitions
```

Each valid transition should be covered at least once. Tests can chain transitions (one test covers a path of multiple transitions).

### Path Coverage

- **0-switch**: cover each transition once (minimum)
- **1-switch**: cover each pair of consecutive transitions
- **n-switch**: cover each sequence of n+1 transitions

### Invalid Transitions

```
Invalid transition tests = states x events - valid_transitions
```

Test that invalid transitions produce appropriate error or no-op.

---

## 8. Optimization Techniques

### ECP Merging

Merge matrix cells when:
- Same expected output AND same risk level AND no distinguishing business rule

```
Reduced cells = original_cells - merged_pairs
```

### Impossible Combination Pruning

Remove combinations that cannot occur:
- Contradictory conditions (e.g., age < 10 AND senior discount)
- System constraints (e.g., guest user AND admin panel)

```
Feasible cells = total_cells - impossible_cells
```

### Default Value Fixing

For low-risk (P2) dimensions:
- Fix to the most common/default value in tests focused on other dimensions
- Create separate P2 tests specifically varying the fixed dimension

```
Reduced combinations = P0_P1_combos + P2_dimension_specific_tests
```

### Boundary Value Deduplication

When a boundary test value serves as both the BVA test AND the ECP representative:
- Count it once
- Mark it as covering both purposes

---

## 9. Total Coverage Formula

### Complete Formula

```
Total test cases =
    base_matrix_cells                    (from L/T/X matrices)
  + sub_matrix_additional_cells          (conditional dimensions)
  + boundary_tests                       (BVA additions)
  - shared_boundary_ecp_values           (deduplication)
  - merged_equivalent_cells              (ECP merging)
  - impossible_combinations              (pruning)
  + sanity_cross_checks                  (optional random verification)
```

### Verification Check

```
Coverage % = (cells_with_tests / total_logical_cells) x 100

Where total_logical_cells = base + sub_matrix + boundary (after deduplication)
```

Target: 100% for all P0 and P1 cells. P2 cells may be deferred but must be documented.

---

## 10. Quick Decision Guide

| Scenario | Technique | Expected Reduction |
|----------|-----------|-------------------|
| Few dimensions (2-3), clear rules | L-matrix + BVA | None needed |
| Many values per dimension | ECP first, then matrix | 60-80% reduction |
| Many dimensions (>5) | Pairwise + ECP | 80-95% reduction |
| Complex boolean logic | Decision table + simplification | 20-50% reduction |
| Workflow/status | State-transition + path coverage | Varies |
| Mixed system | Multiple matrices + pairwise for high-dimension parts | Varies |
