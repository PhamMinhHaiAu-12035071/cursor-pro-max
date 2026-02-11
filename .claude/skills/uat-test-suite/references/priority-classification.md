# Priority Classification Reference

## Priority Definitions

### P0 -- Critical (Must Pass Before Release)

A P0 test case validates functionality that, if broken, renders the system unusable or poses a security/data integrity risk. Releasing without P0 pass is a business-blocking decision.

**Criteria for P0:**
- Core user flows that every user must complete (login, signup, primary feature)
- Data integrity operations (create, update, delete with data consistency)
- Security-critical flows (authentication, authorization, access control)
- Payment and financial transaction processing
- Flows where failure causes data loss or corruption
- Regulatory compliance requirements

**Examples:**
| Module | P0 Test Case |
|--------|-------------|
| Authentication | Login with valid credentials redirects to dashboard |
| Authentication | Locked account after 5 failed attempts |
| Payments | Complete checkout with valid credit card |
| Payments | Refund processes correctly and updates balance |
| User Management | Admin can deactivate a user account |
| Data | Export preserves all records without data loss |

### P1 -- High Priority (Should Pass Before Release)

A P1 test case validates important functionality that affects user experience or key business operations. Failures are serious but do not render the system unusable.

**Criteria for P1:**
- Secondary features that most users interact with
- Important edge cases of core flows
- Error handling and user-facing error messages
- Non-critical but expected behaviors (sorting, filtering, pagination)
- Cross-browser or responsive design verification
- Performance under normal conditions

**Examples:**
| Module | P1 Test Case |
|--------|-------------|
| Authentication | Login with email instead of username |
| Search | Search returns results with partial keyword match |
| Profile | Update profile photo with valid image format |
| Reports | Export report as CSV with date range filter |
| Admin | Sort user list by registration date |
| Notifications | Email notification sent after password reset |

### P2 -- Medium Priority (Can Be Deferred)

A P2 test case validates nice-to-have functionality, rare edge cases, or UI polish. Failures can be documented and fixed in a subsequent release.

**Criteria for P2:**
- Rare edge cases that affect few users
- UI/UX improvements and polish
- Performance optimization validations
- Feature interactions with low business impact
- Help text and documentation accuracy
- Keyboard shortcuts and accessibility refinements

**Examples:**
| Module | P2 Test Case |
|--------|-------------|
| Authentication | "Remember me" persists session across browser restarts |
| Search | Search handles special characters (emojis, Unicode) |
| Profile | Profile displays gracefully with very long display names |
| Reports | Report generates correctly for empty date range |
| Dashboard | Widget drag-and-drop repositioning saves state |
| Settings | Theme toggle updates all components without page reload |

## Default Priority Distribution

The recommended default distribution balances thorough coverage of critical paths with practical testing effort:

| Priority | Percentage | Rationale |
|----------|-----------|-----------|
| P0 | 30% | Top 10-15% of test cases catch 75-90% of significant defects (ThinkTesting). P0 at 30% ensures critical path coverage while keeping the test suite executable. |
| P1 | 45% | The bulk of testing effort covers important features and key edge cases. This is where most user-facing bugs are caught. |
| P2 | 25% | Covers edge cases and polish. Keeps the suite comprehensive without inflating execution time. |

**Source**: Industry data from TestRail, ThinkTesting, and LambdaTest research indicates that effective prioritization concentrates resources on high-impact tests. The top 10-15% of test cases uncover 75-90% of significant defects.

## Auto-Adjustment Rules by Module Type

The default 30/45/25 ratio is adjusted based on module criticality. These adjustments are additive to the base percentages.

### Adjustment Table

| Module Type | P0 Adjustment | P1 Adjustment | P2 Adjustment | Resulting Ratio |
|-------------|--------------|---------------|---------------|-----------------|
| Authentication / Security | +15% | -5% | -10% | 45/40/15 |
| Payments / Transactions | +20% | -5% | -15% | 50/40/10 |
| Core Business Logic | +10% | -5% | -5% | 40/40/20 |
| Data Import/Export | +10% | 0% | -10% | 40/45/15 |
| User Management | +5% | 0% | -5% | 35/45/20 |
| Search / Filtering | 0% | 0% | 0% | 30/45/25 |
| File Management | +5% | 0% | -5% | 35/45/20 |
| Reports / Analytics | -15% | +5% | +10% | 15/50/35 |
| Admin / Configuration | -10% | +5% | +5% | 20/50/30 |
| Notifications | -10% | 0% | +10% | 20/45/35 |
| Settings / Preferences | -15% | +5% | +10% | 15/50/35 |
| Dashboard / Display | -10% | 0% | +10% | 20/45/35 |

### How to Apply Adjustments

1. Identify the module type from the table above
2. Apply the adjustment to the base ratio (30/45/25)
3. Round to the nearest whole number of test cases
4. Verify that the total still equals 100%
5. If the calculated P0 count is less than 2, set P0 to at least 2 test cases

### Example Calculation

Module: Authentication (15 test cases total)
- Base ratio: P0=30%, P1=45%, P2=25%
- Adjustment: P0+15%, P1-5%, P2-10%
- Adjusted ratio: P0=45%, P1=40%, P2=15%
- Applied: P0=7, P1=6, P2=2 (total=15)

Module: Reports (12 test cases total)
- Base ratio: P0=30%, P1=45%, P2=25%
- Adjustment: P0-15%, P1+5%, P2+10%
- Adjusted ratio: P0=15%, P1=50%, P2=35%
- Applied: P0=2, P1=6, P2=4 (total=12)

## Priority Decision Flowchart

Use this flowchart when uncertain about a test case's priority:

```
Is this a core user flow that every user must complete?
├── YES -> Is failure a security or data integrity risk?
│          ├── YES -> P0
│          └── NO  -> Does it block the primary business function?
│                     ├── YES -> P0
│                     └── NO  -> P1
└── NO  -> Is this a feature most users interact with?
           ├── YES -> Is failure visible and impactful to user experience?
           │          ├── YES -> P1
           │          └── NO  -> P2
           └── NO  -> Is this an edge case or rare scenario?
                      ├── YES -> P2
                      └── NO  -> P1 (default to P1 when uncertain)
```

## Reclassification Guidelines

Priorities may need adjustment during or after UAT execution:

**Upgrade to P0:**
- A P1 test failure reveals a data corruption issue
- A P1 failure blocks other test cases from executing
- Stakeholder identifies the feature as release-critical

**Downgrade to P2:**
- A P0 feature is descoped from the current release
- Stakeholder accepts the risk and agrees to defer
- A workaround exists that mitigates the impact

**Document all reclassifications** in the Notes column with the reason for the change.
