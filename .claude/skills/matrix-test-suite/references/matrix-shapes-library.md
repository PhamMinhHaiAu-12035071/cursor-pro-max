# Matrix Shapes Library

Comprehensive reference of all matrix types available for test design. Use this to understand which matrix shape fits a given problem and how to construct it.

## 1. L-Shaped Matrix

**Structure**: Two groups of variables arranged as rows and columns in a standard 2D table.

**When to use**: Two primary dimensions interact to determine behavior. The most common matrix type.

**Example layout**:

```
         | Val_B1 | Val_B2 | Val_B3 |
---------|--------|--------|--------|
Val_A1   | Cell   | Cell   | Cell   |
Val_A2   | Cell   | Cell   | Cell   |
```

**Testing application**: Role x Feature (permission testing), Sex x AgeGroup (pricing), Device x Browser (compatibility), InputType x ValidationRule.

**Cell count**: `rows x columns`

**Best for**: 2-4 values per dimension, clear row/column mapping.

---

## 2. T-Shaped Matrix

**Structure**: Three groups where one group (B) relates to both A and C, but A and C do not directly relate.

**When to use**: A shared dimension connects two independent variable groups. Forms a T shape with B as the horizontal bar.

**Example layout**:

```
         | B1 | B2 | B3 |
---------|----|----|-----|
A1       | x  | x  |     |
A2       |    | x  | x   |
---------|----|----|-----|
C1       | x  |    | x   |
C2       | x  | x  |     |
```

**Testing application**: Input x Rule x Output (where rules connect inputs to outputs), Requirements x Features x TestCases.

**Cell count**: `(rows_A x cols_B) + (rows_C x cols_B)`

---

## 3. Y-Shaped Matrix

**Structure**: Three groups in circular relationship -- A relates to B, B relates to C, and C relates to A.

**When to use**: Three interdependent variable groups where every pair interacts.

**Testing application**: Process Parameter x In-Process Control x Final Test, or UserRole x DataAccess x AuditAction where all three pairs have meaningful interactions.

**Cell count**: Three separate L-matrices, one per pair.

---

## 4. X-Shaped Matrix

**Structure**: Four groups arranged in a cross pattern. A relates to B, B relates to C, C relates to D, and D relates to A. Non-adjacent groups (A-C, B-D) do not directly relate.

**When to use**: Four variable groups with paired relationships forming a chain.

**Testing application**: UserType x Operation x DataSet x Environment, where adjacent pairs interact but cross-pairs do not.

**Cell count**: Four L-matrices, one per adjacent pair.

---

## 5. C-Shaped Matrix

**Structure**: Three or more groups in a 3D or multi-dimensional representation. Visualized as a cube or higher-dimensional structure.

**When to use**: Rare. When three groups must be analyzed simultaneously (not pairwise).

**Testing application**: FailureMode x Effect x RiskLevel x Control x Regulation (FMEA-style analysis).

**Cell count**: Product of all group sizes.

---

## 6. Roof-Shaped (Correlation) Matrix

**Structure**: Triangular matrix placed above an L-matrix, showing correlation between items within the same group.

**When to use**: Identifying which features or variables interact with each other to determine which pairs need testing.

**Testing application**: Feature-to-feature interaction analysis. If Feature A and Feature B are correlated (marked in roof), their combination needs dedicated test cases.

**Cell count**: `n(n-1)/2` for n features.

---

## 7. Decision Table (Truth Table)

**Structure**: Conditions listed as rows, rules as columns. Each column is a unique combination of condition values. Actions/outputs shown below.

**When to use**: Complex boolean or multi-value conditional logic. Business rules with AND/OR combinations.

**Example layout**:

```
Conditions  | R1 | R2 | R3 | R4 |
------------|----|----|----|----|
Condition 1 | T  | T  | F  | F  |
Condition 2 | T  | F  | T  | F  |
------------|----|----|----|----|
Action 1    | X  |    | X  |    |
Action 2    |    | X  |    | X  |
```

**Testing application**: Pricing rules, discount conditions, access control logic, form validation rules.

**Cell count (before simplification)**: For binary conditions: `2^n`. For multi-value: product of values per condition.

**Simplification**: Merge columns with identical actions. Use "-" for irrelevant conditions.

---

## 8. State-Transition Matrix

**Structure**: States as both rows and columns (or rows as current state, columns as events). Cells contain the resulting state and/or action.

**When to use**: Systems with defined states and transitions (workflows, order processing, session management).

**Example layout**:

```
Current \ Event | Login  | Logout | Timeout |
----------------|--------|--------|---------|
Anonymous       | Active |  -     |   -     |
Active          |  -     | Anon   | Expired |
Expired         | Active |  -     |   -     |
```

**Testing application**: Order status flows, user session lifecycle, payment states, approval workflows.

**Cell count**: `states x events` (many cells will be invalid/impossible transitions).

**Test derivation**: One test per valid transition + tests for invalid transitions (should produce error or no-op).

---

## 9. Pairwise (2-wise) Combinatorial Matrix

**Structure**: A covering array where every pair of parameter values appears in at least one row.

**When to use**: Many parameters (>4) where testing all combinations is impractical but pairwise interactions catch most defects.

**Key property**: Research shows ~70-85% of defects are triggered by single parameter values or pairwise interactions.

**Test case count**: Approximately `max(v_i) x max(v_j)` for the two largest parameter value sets. Use tools (ACTS, PICT) for exact arrays.

**Testing application**: Configuration testing, API parameter combinations, form field interactions.

---

## 10. N-wise Combinatorial Matrix

**Structure**: Extension of pairwise to t-way combinations (t = 3 for 3-wise, t = 4 for 4-wise, etc.).

**When to use**: When interactions between 3+ parameters are suspected. Higher t = more tests but more coverage.

**Test case count**: Grows with t. No simple closed formula; use covering array tools.

**Tradeoff**: t=2 catches ~85% of defects, t=3 catches ~95%, t=4 catches ~98%.

---

## 11. Orthogonal Array Matrix

**Structure**: Pre-computed balanced arrays where every value appears equally often in each column, and all t-way combinations are evenly distributed.

**When to use**: When balanced distribution of test values is important (performance testing, statistical significance).

**Common arrays**: L4(2^3), L9(3^4), L18(2^1 x 3^7), L27(3^13).

**Notation**: `L_runs(levels^factors)` -- e.g., L9(3^4) = 9 runs, 4 factors, 3 levels each.

---

## 12. Risk / Probability-Impact Matrix

**Structure**: Probability (likelihood of defect) on one axis, Impact (severity of defect) on the other. Cells indicate risk level.

**When to use**: Prioritizing which matrix cells or test cases to execute first based on risk.

**Example layout**:

```
           | Low Impact | Med Impact | High Impact |
-----------|-----------|------------|-------------|
High Prob  | P1        | P0         | P0          |
Med Prob   | P2        | P1         | P0          |
Low Prob   | P2        | P2         | P1          |
```

**Testing application**: Assign priority labels to test cases. Not a test generation matrix but a prioritization overlay.

---

## 13. Requirement-TestCase Traceability Matrix

**Structure**: Requirements as rows, test cases as columns (or vice versa). Cells indicate which tests cover which requirements.

**When to use**: Proving coverage completeness. Mandatory for audit-grade reporting.

**Testing application**: The COVERAGE-REPORT file uses this format to prove every requirement maps to at least one test.

**Coverage check**: Any requirement row with no marked test cases = coverage gap.

---

## 14. Responsibility / Module-Owner Matrix

**Structure**: Modules as rows, team members or roles as columns. Cells indicate ownership or responsibility.

**When to use**: Test assignment and workload distribution. Not directly for test case generation.

---

## 15. Symmetric Relation Matrix

**Structure**: Square matrix where both axes represent the same set. Cell (i,j) indicates the relationship between item i and item j.

**When to use**: Testing interactions between entities of the same type (account-to-account transfers, user-to-user messaging).

**Key property**: If the relationship is bidirectional and identical (A->B same as B->A), use only the upper or lower triangle.

**Cell count**: `n^2` full, `n(n-1)/2` triangular (excluding diagonal).

---

## 16. Upper/Lower Triangular Matrix

**Structure**: Half of a symmetric matrix. Only cells above (or below) the diagonal are filled.

**When to use**: When the relationship between A and B is the same as B and A, testing both directions is redundant.

**Testing application**: Compatibility testing (browser A with browser B), interoperability testing, data migration between identical entity types.

**Cell count**: `n(n-1)/2`

---

## Selection Decision Tree

```
Start
├── How many core dimension groups?
│   ├── 2 groups → L-shaped matrix
│   ├── 3 groups
│   │   ├── 1 shared axis → T-shaped
│   │   ├── All pairs interact → Y-shaped
│   │   └── 3-way interaction → C-shaped (rare)
│   └── 4+ groups → X-shaped or split into multiple L-matrices
├── Nature of the rules?
│   ├── Boolean/conditional logic → Decision table
│   ├── Workflow/state-based → State-transition matrix
│   └── Same-type entity relations → Symmetric/Triangular
├── Number of dimensions?
│   ├── ≤5 → Direct matrix (L/T/X or decision table)
│   ├── 6-10 → Pairwise + focused L-matrices
│   └── >10 → Split by module, pairwise per module
└── Coverage proof needed?
    └── Always → Add traceability matrix + risk matrix overlay
```

## Combining Multiple Matrix Types

Complex systems often require multiple matrices:

1. **Primary matrix** (L or T) for core dimension interactions
2. **Sub-matrices** for conditional dimensions
3. **Decision table** for complex rules within specific cells
4. **State-transition matrix** for workflow aspects
5. **Traceability matrix** for coverage proof
6. **Risk matrix** for prioritization

Each matrix type addresses a different aspect of the system. The MATRIX output file may contain several matrix types combined.
