# Coverage Report -- {Feature/Project Name}

**Generated**: {Date}
**Version**: 1.0
**Verdict**: {PASS / CONDITIONAL PASS / FAIL}

---

## 1. Executive Summary

| Metric | Value |
|--------|-------|
| Total dimensions | {D} |
| Total equivalence classes | {sum of all EC_i} |
| Total logical matrix cells | {C} |
| Total boundary points | {B} |
| Total test cases | {T} |
| Cell coverage | {C_covered}/{C_total} = {%} |
| Boundary coverage | {B_covered}/{B_total} = {%} |
| Outcome coverage | {O_covered}/{O_total} = {%} |
| **P0 cell coverage** | **{P0_covered}/{P0_total} = {%}** |
| Pairwise coverage level | {2-wise / 3-wise / full cartesian / N/A} |
| Avg tests per cell | {T}/{C} = {ratio} |
| Optimization reduction | {full_count} → {optimized_count} ({reduction}%) |
| Coverage strategy level | {Level 1: Direct / Level 2: Pairwise / Level 3: Modular} |

**Priority breakdown**:
- P0: {N} tests ({%})
- P1: {N} tests ({%})
- P2: {N} tests ({%})

---

## 2. Dimension Coverage Table

| # | Dimension | Type | Equivalence Classes | EC Tested | Boundaries | BD Tested | Risk |
|---|-----------|------|--------------------|-----------|-----------|-----------| -----|
| 1 | {Dim1} | {type} | {N} | {N}/{N} = 100% | {B} | {B}/{B} = 100% | {P0/P1/P2} |
| 2 | {Dim2} | {type} | {N} | {N}/{N} = 100% | {B} | {B}/{B} = 100% | {risk} |
| ... | ... | ... | ... | ... | ... | ... | ... |
| **Total** | | | **{sum}** | **{sum}/{sum}** | **{sum}** | **{sum}/{sum}** | |

---

## 3. Mathematical Proof of Coverage

### 3.1 Base Matrix Calculation

```
Unconditional dimensions:
  {Dim1}: {EC_1} equivalence classes
  {Dim2}: {EC_2} equivalence classes
  ...

Base matrix cells = {EC_1} x {EC_2} x ... = {product} cells
```

### 3.2 Conditional Dimension Adjustments

```
Conditional dimension: {DimX}
  Condition: {when Dim1=val AND Dim2=val}
  Applies to: {N} base cell(s)
  Values: {EC_X} equivalence classes
  Additional cells: {N} x ({EC_X} - 1) = {result}

Adjusted total = {base} + {additional} = {adjusted} logical cells
```

### 3.3 Boundary Test Additions

```
P0 dimensions (3-value BVA):
  {Dim}: {BP} boundaries x 3 values = {raw} raw tests
  Dedup with ECP: -{overlap} overlapping values
  Net BVA additions: {net}

P1/P2 dimensions (2-value BVA):
  {Dim}: {BP} boundaries x 2 values = {raw} raw tests
  Dedup with ECP: -{overlap} overlapping values
  Net BVA additions: {net}

Total boundary additions: {total_bva}
```

### 3.4 Optimization Reductions

```
ECP merging:
  {CellA} + {CellB} merged: identical output ({output}), same risk ({risk})
  Reduction: -{N} tests

Impossible combination pruning:
  {Combination}: {reason why impossible}
  Reduction: -{N} tests

Pairwise reduction (if applied):
  Dimensions: [{list}]
  Full cartesian: {full_count}
  Pairwise result: {pairwise_count}
  Reduction: {full - pairwise} = {reduction}%

Total optimization reduction: -{total_reduction}
```

### 3.5 Final Formula

```
Total test cases =
    {base_cells}           (base matrix cells)
  + {sub_matrix_cells}     (conditional dimension additions)
  + {bva_additions}        (boundary value tests)
  - {optimization}         (optimization reductions)
  + {sanity_checks}        (cross-check tests)
  = {FINAL_COUNT}
```

---

## 4. Traceability Matrix

### 4.1 Forward: Requirement -> Matrix Cell -> Test Cases

| Req ID | Requirement Description | Matrix Cells | Test Case IDs | Coverage |
|--------|------------------------|-------------|---------------|---------|
| REQ-{N} | {description} | {cell_ids} | {test_ids} | Covered |
| REQ-{N} | {description} | {cell_ids} | {test_ids} | Covered |
| ... | ... | ... | ... | ... |

### 4.2 Backward: Test Case -> Matrix Cell -> Requirements

| Test ID | Matrix Cells | Requirements Covered |
|---------|-------------|---------------------|
| MTX-{X}-{Y}-{Z} | {cell_ids} | REQ-{N}, REQ-{M} |
| ... | ... | ... |

### 4.3 Cell-to-Test Mapping

| Matrix Cell | Test Case IDs | Test Count |
|-------------|--------------|-----------|
| {CellID} | {test_ids} | {count} |
| {CellID} | {test_ids} | {count} |
| ... | ... | ... |
| **Total** | | **{total}** |

---

## 5. Gap Analysis

### 5.1 Coverage Gaps

| Gap # | Area | Type | Risk Level | Recommendation |
|-------|------|------|-----------|----------------|
| {N} | {description} | {Missing test / Missing requirement / Untested boundary} | {High/Medium/Low} | {action to take} |

*If no gaps: "No coverage gaps identified."*

### 5.2 Optimization Audit

| Optimization Applied | Items Affected | Justification | Risk of Missing Defects |
|---------------------|---------------|---------------|------------------------|
| {ECP merge / Pairwise / Pruning} | {cell IDs or test IDs} | {reason} | {Low/Medium/High} |

### 5.3 Recommendations

1. {Recommendation for improvement or additional testing}
2. {Recommendation}
3. ...

---

## 6. Coverage Verdict

### Checklist

- [ ] Every equivalence class of every dimension has at least one test: {YES/NO}
- [ ] Every logical matrix cell maps to at least one test case: {YES/NO}
- [ ] Every boundary transition has BVA test(s): {YES/NO}
- [ ] Every distinct expected outcome appears in at least one test: {YES/NO}
- [ ] Every requirement traces to at least one test: {YES/NO}
- [ ] Every test traces to at least one requirement: {YES/NO}
- [ ] Summary totals match actual counts: {YES/NO}
- [ ] No undocumented gaps: {YES/NO}

### Verdict: **{PASS / CONDITIONAL PASS / FAIL}**

{If CONDITIONAL PASS: list deferred items with risk assessment}
{If FAIL: list blocking issues}

---

## Change Log

| Date | Change | Affected Sections |
|------|--------|-------------------|
| {YYYY-MM-DD} | Initial generation | All |
