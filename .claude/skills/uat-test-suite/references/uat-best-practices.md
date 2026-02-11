# UAT Best Practices Reference

## Test Case Writing Guidelines

### The Anatomy of a Good Test Case

Every UAT test case must answer five questions:
1. **What** is being tested? (Test Case name)
2. **What state** must exist before the test? (Precondition)
3. **What actions** does the user perform? (Steps)
4. **What should happen?** (Expected Result)
5. **How critical is this?** (Priority)

Plus three traceability fields:
6. **What data is needed?** (Test Data)
7. **Where does it run?** (Environment)
8. **What happened?** (Status + Notes -- filled during execution)

### Writing Test Case Names

Start every test case name with an action verb. The name should describe what the user does and the expected outcome.

**Good examples:**
- "Login with valid email and password"
- "Upload PDF file within 10MB size limit"
- "Search documents by keyword with partial match"
- "Delete user account with active subscriptions"
- "Export report as CSV with date range filter"

**Bad examples:**
- "Test login" -- too vague, no specifics
- "Authentication" -- not an action, just a noun
- "Check if upload works" -- informal, not measurable
- "Button click" -- describes UI element, not business action
- "Error" -- no context at all

### Writing Preconditions

Preconditions describe the system state required before the test can execute. Be explicit about user roles, data states, and environment configuration.

**Good examples:**
- "User logged in as 'admin@company.com' with role SUPER_ADMIN"
- "At least 5 documents exist in the system, including 2 PDF and 3 DOCX files"
- "Payment gateway configured with test mode enabled (Stripe test key)"
- "User has exceeded 3 failed login attempts within the last 15 minutes"
- "System has 100+ users registered (for pagination testing)"

**Bad examples:**
- "System ready" -- what does "ready" mean?
- "User exists" -- which user? what role?
- "Data available" -- what data? how much?
- "Normal conditions" -- completely unmeasurable

### Writing Steps

Number each step explicitly. Use `<br>` for line breaks in markdown tables. Include exact inputs, URLs, button labels, and field names.

**Good example:**
```
1. Navigate to /settings/profile<br>
2. Click "Edit Profile" button<br>
3. Clear the "Display Name" field<br>
4. Enter new name: "John Updated"<br>
5. Upload new avatar: test-avatar.png (200x200, 50KB)<br>
6. Click "Save Changes"
```

**Bad example:**
```
1. Go to settings<br>
2. Edit profile<br>
3. Save
```

Problems with the bad example:
- "Go to settings" -- which URL? which settings page?
- "Edit profile" -- what fields? what values?
- "Save" -- which button? what label?

### Writing Expected Results

Describe observable outcomes. Include UI changes, data changes, redirects, response times, and error messages where relevant.

**Good example:**
```
- Success toast: "Profile updated successfully"<br>
- Display name shows "John Updated" in header<br>
- Avatar image updated on profile page<br>
- Last modified timestamp updated in database<br>
- Response time < 2 seconds
```

**Bad example:**
```
- Works correctly
- Profile saved
```

Problems: "Works correctly" is not observable. "Profile saved" does not describe what the user can verify.

### Test Data Column

Specify the exact test data needed, including file names, sizes, formats, and any special characteristics.

**Good examples:**
- "Email: test@example.com, Password: Test@123!"
- "File: invoice-2024.pdf (5.2MB, 12 pages)"
- "Search term: 'annual report' (partial match expected)"
- "Date range: 2024-01-01 to 2024-12-31"
- "N/A" (when no special test data is required)

### Environment Column

Specify the environment configuration needed for the test.

**Good examples:**
- "Chrome 120+, Desktop (1920x1080)"
- "iOS Safari 17, iPhone 15 Pro"
- "Staging server, VPN connected"
- "Production-mirror, test database seeded"
- "All browsers" (for cross-browser tests)

## Scenario Organization

### Standard Scenario Categories

Organize test cases within each module using these categories:

1. **Happy Path** -- Main success flow that most users follow
2. **Alternative Paths** -- Valid variations of the happy path
3. **Edge Cases** -- Boundary conditions, limits, unusual but valid inputs
4. **Error Handling** -- Invalid inputs, server errors, validation failures
5. **Security and Permissions** -- Unauthorized access, role-based restrictions

### How Many Test Cases Per Scenario

- Happy Path: 3-5 test cases covering the main flow variations
- Alternative Paths: 2-4 test cases for secondary flows
- Edge Cases: 3-6 test cases for boundary conditions
- Error Handling: 3-5 test cases for validation and failure states
- Security: 2-4 test cases for permission and access control

### Module Coverage Target

Each module should have a minimum of 8-12 test cases distributed across the scenario categories. Critical modules (authentication, payments) may have 15-25 test cases.

## Common Pitfalls to Avoid

### Pitfall 1: Mixing Technical QA with Business UAT

UAT validates business requirements from the user's perspective. Do not include:
- Unit test scenarios
- API response format validation
- Database query performance tests
- Code coverage metrics

Instead, focus on:
- "Can the user complete their task?"
- "Does the system behave as the client expects?"
- "Are business rules enforced correctly?"

### Pitfall 2: Inconsistent ID Numbering

Always follow the `UAT-{Module}.{Scenario}.{Test}` pattern. Never skip numbers or reuse IDs across modules.

Bad: UAT-1.1.1, UAT-1.1.2, UAT-1.1.5 (gap at 3-4)
Good: UAT-1.1.1, UAT-1.1.2, UAT-1.1.3

### Pitfall 3: Forgetting Summary Table Updates

Whenever you add, remove, or reclassify test cases, recalculate:
- Per-module totals
- Per-module P0/P1/P2 counts
- Grand totals

### Pitfall 4: Vague Error Messages in Expected Results

Instead of "Error message displayed", specify the exact message:
- Good: "Error toast: 'File size exceeds 10MB limit. Please upload a smaller file.'"
- Bad: "Error shown"

### Pitfall 5: Missing Negative Test Cases

For every positive test (happy path), consider at least one negative test:
- Login succeeds -> Login fails with wrong password
- Upload succeeds -> Upload fails with invalid file type
- Search returns results -> Search returns empty state

## Test Execution Best Practices

### Execution Order

1. Run all P0 tests first -- block release if any fail
2. Run P1 tests next -- evaluate impact of failures
3. Run P2 tests last -- document results, defer fixes if needed

### Recording Results

For each test case, record:
- **Status**: Not Started / Pass / Fail / Blocked / Skipped
- **Notes**: Actual result if different from expected, screenshots, error logs
- **Date executed**: When the test was performed
- **Tester**: Who performed the test

### Failure Handling

When a test fails:
1. Record the actual result in the Notes column
2. Take a screenshot or record the error
3. Create a bug report linking to the test case ID
4. Re-test after the fix is applied
5. Update status to Pass or Fail after retest

### Regression Testing

After fixing bugs found during UAT:
- Re-run all P0 tests in the affected module
- Re-run the specific failed test case
- Run smoke tests on related modules to check for regressions

## Quick Reference Checklist

Before delivering a UAT document, verify:

- [ ] Every test case has all 10 columns filled (Status defaults to "Not Started")
- [ ] All IDs follow UAT-X.Y.Z format with no duplicates
- [ ] Summary table totals match actual test case counts
- [ ] Priority distribution is reasonable (roughly 30% P0, 45% P1, 25% P2)
- [ ] Every module has at least 8 test cases
- [ ] Happy path, edge cases, and error handling are all covered per module
- [ ] Steps are explicit with exact inputs and actions
- [ ] Expected results are observable and measurable
- [ ] Coverage traceability matrix maps requirements to test cases
- [ ] Gap analysis identifies uncovered areas with risk levels
