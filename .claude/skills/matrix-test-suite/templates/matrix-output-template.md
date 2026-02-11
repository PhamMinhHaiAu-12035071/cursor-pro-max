# Test Matrix -- {Feature/Project Name}

## 1. Context & Scope

- **Domain**: {Web App / API / Business Rule Engine / Workflow / Mixed}
- **Feature**: {Feature or system under test}
- **Modules in scope**: {List of modules}
- **Goal**: Build optimized test matrices to cover all meaningful behavior with minimal redundancy.

## 2. Dimensions

| # | Dimension | Type | Representative Values | Boundary Points | Risk | Rationale |
|---|-----------|------|----------------------|-----------------|------|-----------|
| 1 | {Dim1} | {categorical / numeric / boolean / state / threshold} | [{val1}, {val2}, ...] | {boundary list or N/A} | {P0/P1/P2} | {Why this dimension matters} |
| 2 | {Dim2} | {type} | [{values}] | {boundaries} | {risk} | {rationale} |
| ... | ... | ... | ... | ... | ... | ... |

### Conditional Dimensions

| Conditional Dimension | Condition | Applies To |
|----------------------|-----------|------------|
| {DimX} | {When Dim1=val AND Dim2=val} | {Cell IDs} |

## 3. Matrix Shape Selection

**Selected matrix type(s)**: {L-shaped / T-shaped / Decision table / State-transition / etc.}

**Reasoning**: {Why this matrix type was chosen based on the dimensions and their relationships}

**User override**: {None / User requested {type} instead}

## 4. Primary Matrix -- {Dim1} x {Dim2}

### 4.1 {Matrix Name} (L-shaped)

|          | {Val_B1} | {Val_B2} | {Val_B3} | {Val_B4} |
|----------|----------|----------|----------|----------|
| {Val_A1} | {CellID} | {CellID} | {CellID} | {CellID} |
| {Val_A2} | {CellID} | {CellID} | {CellID} | {CellID} |

**Cell behavior summary**:
- {CellID}: {Expected behavior / output}
- {CellID}: {Expected behavior / output}
- ...

### 4.2 Sub-Matrix -- {Conditional Dimension} for {Condition}

| {Dim1} | {Dim2} | {ConditionalDim} | Cell ID | Expected Behavior |
|--------|--------|------------------|---------|-------------------|
| {val} | {val} | {cond_val1} | {CellID} | {behavior} |
| {val} | {val} | {cond_val2} | {CellID} | {behavior} |

### 4.3 Decision Table -- {Rule Group} (if applicable)

| Case | Cond: {Dim1} | Cond: {Dim2} | Cond: {Dim3} | Expected Output | Notes |
|------|-------------|-------------|-------------|-----------------|-------|
| C1 | {val} | {val} | {val} | {output} | {notes} |
| C2 | {val} | {val} | {val} | {output} | {notes} |
| ... | ... | ... | ... | ... | ... |

### 4.4 State-Transition Matrix (if applicable)

| Current State \ Event | {Event1} | {Event2} | {Event3} |
|----------------------|----------|----------|----------|
| {State1} | {NewState/Action} | - | - |
| {State2} | - | {NewState/Action} | {NewState/Action} |

## 5. Coverage Summary

| Matrix Component | Total Cells | Merged/Pruned | Effective Cells |
|-----------------|-------------|---------------|-----------------|
| Primary matrix ({Dim1} x {Dim2}) | {N} | {M} | {N-M} |
| Sub-matrix ({ConditionalDim}) | {N} | {M} | {N-M} |
| Decision table | {N} | {M} | {N-M} |
| **Total logical cells** | **{T}** | **{R}** | **{T-R}** |

- Boundary tests to add: {B}
- Estimated total test cases: **{T-R+B}**

## Change Log

| Date | Change | Affected Sections |
|------|--------|-------------------|
| {YYYY-MM-DD} | Initial generation | All |
