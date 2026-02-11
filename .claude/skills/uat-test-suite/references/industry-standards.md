# Industry Standards Reference for UAT

## ISO 25010 -- Software Product Quality

ISO/IEC 25010:2023 defines eight quality characteristics for software systems. Map UAT test cases to these characteristics for comprehensive coverage.

### Quality Characteristics Mapped to UAT

| Characteristic | Sub-characteristics | UAT Focus Area | Example Test Cases |
|---------------|--------------------|-----------------|--------------------|
| **Functional Suitability** | Functional completeness, correctness, appropriateness | Core business flows, CRUD operations, business rules | "Create order with valid items", "Calculate discount correctly" |
| **Performance Efficiency** | Time behavior, resource utilization, capacity | Response times, page load, concurrent users | "Dashboard loads within 3 seconds", "System handles 100 concurrent users" |
| **Compatibility** | Co-existence, interoperability | Cross-browser, API integration, third-party services | "Works in Chrome, Firefox, Safari", "Stripe payment integration" |
| **Usability** | Learnability, operability, error protection, accessibility | User journey clarity, error messages, form validation | "New user completes onboarding in <5 minutes", "Form shows inline validation" |
| **Reliability** | Maturity, availability, fault tolerance, recoverability | System uptime, error recovery, data preservation | "System recovers from network timeout", "Unsaved data restored after crash" |
| **Security** | Confidentiality, integrity, authenticity, accountability | Auth, authorization, data protection, audit trails | "Unauthorized user cannot access admin", "Passwords stored hashed" |
| **Maintainability** | Modularity, reusability, analyzability, modifiability | Not directly tested in UAT (technical concern) | N/A for UAT |
| **Portability** | Adaptability, installability, replaceability | Cross-platform, responsive design | "App works on mobile and desktop", "Responsive layout at 768px" |

### Applying ISO 25010 to UAT

For each module in the UAT, verify that test cases cover at least these quality dimensions:

1. **Functional Suitability** (mandatory) -- Does the feature work as specified?
2. **Security** (mandatory for auth, payments, data) -- Is access properly controlled?
3. **Usability** (recommended) -- Can users complete tasks without confusion?
4. **Performance Efficiency** (recommended for critical flows) -- Does it respond within acceptable time?
5. **Reliability** (recommended for data operations) -- Does it handle failures gracefully?

## ISTQB -- UAT Principles

The International Software Testing Qualifications Board (ISTQB) defines UAT as the final stage of testing where the system is validated against business requirements by end users or their representatives.

### ISTQB UAT Key Principles

**1. User Involvement**
- Test cases must be written from the user's perspective, not the developer's
- Business stakeholders should review and approve test scenarios
- Test data should reflect real-world usage patterns

**2. Requirements-Based Testing**
- Every test case should trace back to a business requirement
- The coverage traceability matrix must link requirements to test case IDs
- Untraceable test cases indicate either missing requirements or unnecessary tests

**3. Risk-Based Prioritization**
- P0 tests cover the highest-risk business flows
- Risk = Likelihood of failure x Business impact of failure
- Focus testing effort where it matters most

**4. Entry and Exit Criteria**

Entry criteria (before starting UAT):
- All P0 bugs from QA testing are resolved
- Test environment mirrors production configuration
- Test data is prepared and loaded
- UAT test cases are reviewed and approved

Exit criteria (UAT is complete when):
- All P0 test cases pass (100% pass rate required)
- At least 90% of P1 test cases pass
- All P2 failures are documented with deferral justification
- Coverage traceability matrix shows >= 95% requirement coverage
- Gap analysis risks are acknowledged by stakeholders

**5. Defect Management**
- Defects found during UAT are classified by severity (Critical, Major, Minor)
- Critical defects block release
- Major defects require fix or documented workaround
- Minor defects can be deferred to next release

### ISTQB Test Case Design Techniques Applicable to UAT

| Technique | Description | When to Apply |
|-----------|-------------|---------------|
| Equivalence Partitioning | Divide inputs into valid and invalid groups, test one from each | Form fields, input validation |
| Boundary Value Analysis | Test at exact boundaries (min, min+1, max-1, max) | Numeric limits, file sizes, character counts |
| Decision Table Testing | Test all combinations of conditions and actions | Complex business rules, pricing tiers |
| State Transition Testing | Test state changes (e.g., order: created -> paid -> shipped) | Workflow-driven features, order processing |
| Use Case Testing | Test end-to-end user scenarios | Happy paths, complete user journeys |

## IEEE 829 -- Test Documentation Standard (Simplified)

IEEE 829 defines the structure for test documentation. The UAT document generated by this skill incorporates these elements in a simplified format.

### IEEE 829 Elements Mapped to UAT Output

| IEEE 829 Section | UAT Equivalent | Location in Output |
|-----------------|----------------|--------------------|
| Test Plan Identifier | UAT-{ProjectName} | Document header |
| Test Items | Module list | UAT Summary table |
| Features to be Tested | Module scope descriptions | Module section headers |
| Test Cases | Individual test rows | Module test case tables |
| Pass/Fail Criteria | Expected Result column | Test case tables |
| Test Deliverables | UAT document + validation report | The generated file + validation output |
| Environmental Needs | Environment column | Test case tables |
| Responsibilities | Defined during execution | Notes column |

### Simplified IEEE 829 Compliance Checklist

The generated UAT document satisfies IEEE 829 requirements when it includes:

- [ ] Unique test plan identifier (UAT-{ProjectName})
- [ ] Clear scope definition (modules and features listed)
- [ ] Individual test cases with unique IDs
- [ ] Pass/fail criteria for each test (Expected Result)
- [ ] Priority classification (P0/P1/P2)
- [ ] Environmental requirements (Environment column)
- [ ] Traceability to requirements (Coverage Traceability Matrix)

## Risk-Based Testing Approach

### Risk Assessment Matrix

Combine likelihood and impact to determine module risk level:

| | Low Impact | Medium Impact | High Impact |
|---|-----------|---------------|-------------|
| **High Likelihood** | Medium Risk | High Risk | Critical Risk |
| **Medium Likelihood** | Low Risk | Medium Risk | High Risk |
| **Low Likelihood** | Low Risk | Low Risk | Medium Risk |

### Risk-to-Priority Mapping

| Risk Level | Testing Approach | Priority Distribution |
|-----------|------------------|-----------------------|
| Critical Risk | Maximum coverage, all paths tested | P0: 50%, P1: 35%, P2: 15% |
| High Risk | Thorough coverage, all main paths + key edge cases | P0: 35%, P1: 40%, P2: 25% |
| Medium Risk | Standard coverage, happy path + major edge cases | P0: 25%, P1: 45%, P2: 30% |
| Low Risk | Minimal coverage, happy path + basic error handling | P0: 20%, P1: 40%, P2: 40% |

### Common High-Risk Areas

These features typically require higher P0 concentration:
- User authentication and session management
- Payment processing and financial transactions
- Data import/export and migration
- Permission and access control
- Sensitive data handling (PII, PHI, financial data)
- Integration with external services

### Common Lower-Risk Areas

These features typically tolerate higher P2 concentration:
- Reporting and analytics dashboards
- User preference settings
- Notification configuration
- Admin tools for internal use
- Help pages and documentation links
- Theme and display customization
