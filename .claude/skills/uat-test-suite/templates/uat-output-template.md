# USER ACCEPTANCE TESTING (UAT) - {Project Name}

**Generated**: {YYYY-MM-DD}
**Version**: {1.0}
**Total Test Cases**: {N}
**Priority Distribution**: P0: {X} ({X%}) | P1: {Y} ({Y%}) | P2: {Z} ({Z%})
**Coverage Approach**: {Use-case enumeration | Use-case + Matrix-enhanced (specify modules)}

---

## UAT Summary

| # | Module | Total | P0 | P1 | P2 | Coverage Approach |
|---|--------|-------|----|----|-----|-------------------|
| 1 | {Module 1 Name} | {N} | {N} | {N} | {N} | Use-case |
| 2 | {Module 2 Name} | {N} | {N} | {N} | {N} | Use-case + Permission Matrix |
| 3 | {Module 3 Name} | {N} | {N} | {N} | {N} | Use-case + BVA |
| ... | ... | ... | ... | ... | ... | ... |
| | **Total** | **{N}** | **{N}** | **{N}** | **{N}** | |

---

## MODULE 1: {Module Name} ({Total} Test Cases)

### 1.1 {SCENARIO NAME} - Happy Path

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.1.1 | {Action verb + specific test description} | {System state required: user role, data state, config} | 1. {Navigate to URL}<br>2. {Enter specific input}<br>3. {Click specific button}<br>4. {Observe result} | {Observable outcome 1}<br>{Observable outcome 2}<br>{Response time expectation} | P0 | Not Started | | {Specific test data: email, file, values} | {Browser, device, environment} |
| UAT-1.1.2 | {Next test case} | {Preconditions} | {Numbered steps with <br> separators} | {Measurable expected results} | P1 | Not Started | | {Test data} | {Environment} |

### 1.2 {SCENARIO NAME} - Edge Cases

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.2.1 | {Edge case test description} | {Preconditions} | {Steps} | {Expected results} | P1 | Not Started | | {Test data} | {Environment} |

### 1.3 {SCENARIO NAME} - Error Handling

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.3.1 | {Error scenario description} | {Preconditions} | {Steps that trigger error} | {Exact error message}<br>{System behavior after error}<br>{Data integrity preserved} | P0 | Not Started | | {Invalid test data} | {Environment} |

### 1.4 {SCENARIO NAME} - Permission Matrix {Optional: include when module has role-based access}

> **Matrix Coverage Note**: This scenario uses a permission matrix (Role x Action) to ensure all role-action combinations are tested. The matrix covers {N} roles x {M} actions = {N*M} combinations.

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.4.1 | {Role} attempts {Action} | {User logged in as Role} | {Steps} | {Allowed or denied} | P0 | Not Started | Matrix: {Role}-{Action} | {Test data} | {Environment} |

### 1.5 {SCENARIO NAME} - Boundary Values {Optional: include when module has numeric/size limits}

> **BVA Coverage Note**: Input field "{field name}" has range [{min}, {max}]. Testing boundaries: min-1 (invalid), min (valid), min+1 (valid), max-1 (valid), max (valid), max+1 (invalid).

| ID | Test Case | Precondition | Steps | Expected Result | Priority | Status | Notes | Test Data | Environment |
|----|-----------|--------------|-------|-----------------|----------|--------|-------|-----------|-------------|
| UAT-1.5.1 | {Input at boundary value} | {Preconditions} | {Steps with boundary input} | {Expected behavior at boundary} | P0 | Not Started | BVA: {field}={value} | {Boundary test data} | {Environment} |

---

## MODULE 2: {Module Name} ({Total} Test Cases)

{Repeat the same pattern for each module. Include matrix-enhanced scenarios (Permission Matrix, BVA, Decision Table, State Transition, Pairwise) ONLY when the module warrants it based on the Analysis phase. Simple CRUD modules only need standard scenarios: Happy Path, Alternative Paths, Edge Cases, Error Handling, Security.}

---

{Continue for all modules...}

---

## Coverage Traceability Matrix

| Requirement ID | Requirement Description | Test Case IDs | Coverage Status |
|---------------|------------------------|---------------|-----------------|
| REQ-001 | {Requirement description from spec/interview} | UAT-1.1.1, UAT-1.1.2, UAT-1.2.1 | Covered |
| REQ-002 | {Requirement description} | UAT-2.1.1, UAT-2.3.1 | Covered |
| REQ-003 | {Requirement description} | | Gap |
| ... | ... | ... | ... |

---

## Gap Analysis and Recommendations

### Uncovered Areas

| # | Area | Risk Level | Recommendation |
|---|------|-----------|----------------|
| 1 | {Uncovered feature or requirement} | {High/Medium/Low} | {Specific recommendation: how many test cases to add and what they should cover} |
| 2 | {Another gap} | {Risk level} | {Recommendation} |

### Coverage Summary

- **Total Requirements**: {N}
- **Covered**: {X} ({X%})
- **Gaps**: {Y} ({Y%})
- **Risk Assessment**: {Low/Medium/High/Critical} -- {Brief explanation of overall risk posture and recommendations}

### Coverage Technique Summary {Optional: include when matrix-enhanced techniques were used}

| Module | Technique | Dimensions | Cells/Combinations | Tests Generated |
|--------|-----------|------------|-------------------|-----------------|
| {Module with matrix} | {Permission Matrix / Decision Table / BVA / State Transition / Pairwise} | {Dimension count or Role x Action} | {Total combinations} | {Test count} |

---

## Column Reference

| Column | Purpose | Required | Default Value |
|--------|---------|----------|---------------|
| ID | Unique test identifier (UAT-Module.Scenario.Test) | Yes | N/A |
| Test Case | Action-verb description of what is being tested | Yes | N/A |
| Precondition | System state required before test execution | Yes | N/A |
| Steps | Numbered steps with exact inputs and actions | Yes | N/A |
| Expected Result | Observable, measurable outcomes | Yes | N/A |
| Priority | P0 (Critical) / P1 (High) / P2 (Medium) | Yes | N/A |
| Status | Not Started / Pass / Fail / Blocked / Skipped | Yes | Not Started |
| Notes | Actual results, screenshots, deviation notes; Matrix cell reference when applicable | No | Empty |
| Test Data | Specific data required for the test | Yes | N/A |
| Environment | Browser, device, server environment | Yes | N/A |

## Priority Reference

| Priority | Meaning | Release Gate |
|----------|---------|-------------|
| P0 | Critical -- must pass | 100% pass required |
| P1 | High -- should pass | 90% pass required |
| P2 | Medium -- can defer | Document failures, fix in next release |

## Status Reference

| Status | Meaning |
|--------|---------|
| Not Started | Test has not been executed |
| Pass | Expected result matches actual result |
| Fail | Expected result does not match actual result |
| Blocked | Cannot execute due to dependency or environment issue |
| Skipped | Intentionally not executed with documented reason |
