# Quick Boost Example: Role Assignment

## Optimization Level: ⚡ Quick Boost

**Focus:** Role Assignment (F1 technique)  
**Time Required:** 2-5 minutes  
**Expected Impact:** +20-40% response relevance, +15-30% domain accuracy

---

## Why Role Assignment Matters

**Problem:** Without role assignment, AI responds with general knowledge, not domain expertise.

**Solution:** Assign specific expert role to activate relevant knowledge patterns and professional perspective.

**Benefit:** More accurate, relevant, domain-appropriate responses.

---

## Phase 1: Interactive Dialogue (Quick Boost)

**Optimization Level:** Quick Boost (minimal questions - 0-2 if critical role unclear)

### When to Ask About Role

Quick Boost asks role questions when:
- Domain expertise is unclear from prompt
- Multiple expert perspectives possible
- Role significantly impacts response quality

### Example Dialogue for "Review this Python code"

**Initial Prompt:** "Review this Python code: [code snippet]"

**Gap Identified:** Review focus unclear (security? performance? style?)

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "review-perspective",
      "prompt": "What expert perspective should the review take?",
      "options": [
        {"id": "senior-dev", "label": "Senior developer (best practices, architecture)"},
        {"id": "security-expert", "label": "Security expert (vulnerabilities, safety)"},
        {"id": "performance-engineer", "label": "Performance engineer (optimization, efficiency)"},
        {"id": "code-reviewer", "label": "General code reviewer (comprehensive)"},
        {"id": "python-expert", "label": "Python expert (Pythonic patterns)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "review-perspective": "python-expert"
}
```

**Analysis:**
- Role: Python expert → Focus on Pythonic patterns, idioms
- Implication: Check list comprehensions, generators, type hints
- Skip: General best practices (too broad)

**Decision:** Optimize with "You are a Python expert specializing in Pythonic code patterns"

### Vietnamese Example

**Initial Prompt:** "Review code này giúp tôi."

**Dialogue (Vietnamese):**

```json
{
  "questions": [
    {
      "id": "goc-do-review",
      "prompt": "Bạn muốn review theo góc độ chuyên môn nào?",
      "options": [
        {"id": "bao-mat", "label": "Bảo mật (security expert)"},
        {"id": "hieu-nang", "label": "Hiệu năng (performance engineer)"},
        {"id": "python-expert", "label": "Chuyên gia Python (Pythonic patterns)"},
        {"id": "tong-quat", "label": "Tổng quát (general reviewer)"}
      ]
    }
  ]
}
```

**User Response:** `{"goc-do-review": "python-expert"}`

**Analysis:** Pythonic patterns → Chuyên gia Python role

---

## Example 1: Code Review

### Before Optimization

```
Review this Python code:

def process_data(data):
    result = []
    for item in data:
        result.append(item * 2)
    return result
```

**Output might be:**
```
The code works and is clear. It doubles each item in the input list.
```

**Problem:** Generic observation, no expert insights.

---

### After Optimization

```
You are a senior Python developer with 10 years of experience in performance optimization.

Review this code:

def process_data(data):
    result = []
    for item in data:
        result.append(item * 2)
    return result

Focus on: Performance and Pythonic patterns
```

**Output will be:**
```
As a Python performance expert, I see optimization opportunities:

**Performance Issues:**
1. List concatenation with append() in loop is inefficient
2. No type hints (impacts IDE support and runtime checks)

**Pythonic Improvements:**
Use list comprehension for 2-3x speed improvement:

\`\`\`python
def process_data(data: list[int]) -> list[int]:
    """Double each item in data."""
    return [item * 2 for item in data]
\`\`\`

**Benchmarks:**
- Original: ~100μs for 1000 items
- Optimized: ~35μs for 1000 items
- Improvement: 65% faster
```

**Improvement:** Expert-level insight, specific optimizations, measurable impacts.

---

## Example 2: Architecture Decision

### Before Optimization

```
Should I use microservices for my project?
```

**Output might be:**
```
Microservices have pros and cons. They're good for scalability but add
complexity...
```

**Problem:** Generic advice, no context-specific guidance.

---

### After Optimization

```
You are a solutions architect with 15 years of experience designing
enterprise systems. You've successfully deployed both monolithic and
microservices architectures and understand their trade-offs deeply.

Context:
- E-commerce platform
- Current: 5-person team
- Expected: 50K users in year 1
- Tech debt: High (legacy monolith)

Should we migrate to microservices?

Provide: Honest assessment with pros/cons for THIS specific situation.
```

**Output will be:**
```
As a solutions architect who's seen both approaches succeed and fail,
here's my honest assessment for YOUR situation:

**My Recommendation: NO, not yet.**

**Reasoning:**

**Your Context:**
- 5-person team = too small for microservices overhead
- 50K users = monolith can easily handle this scale
- High tech debt = microservices would multiply complexity

**Better Path:**
1. **Now:** Refactor monolith into modular monolith
   - Separate bounded contexts
   - Clean interfaces between modules
   - Much faster, lower risk

2. **Later (when team > 15, users > 500K):** Extract high-load services
   - Start with 1-2 services (e.g., search, recommendations)
   - Incremental migration
   - Prove value before full migration

**Red Flags I've Seen:**
- Small teams adopting microservices: 80% regret it within 1 year
- Premature optimization: Adds 3-6 months to delivery
- Operational burden: Need DevOps expertise you don't mention having

**If You Insist on Microservices:**
Minimum prerequisites:
- Dedicated DevOps engineer
- Mature CI/CD pipeline
- Distributed tracing (Jaeger/Zipkin)
- Service mesh (Istio/Linkerd)
- 12+ month timeline

**Bottom Line:** Solve your current problems (tech debt, modularity)
with simpler solutions. Microservices are for problems you don't have yet.
```

**Improvement:** Brutally honest, context-aware, experience-backed advice.

---

## Example 3: Security Analysis

### Before Optimization

```
Is this authentication code secure?

[code snippet]
```

**Output might be:**
```
The code has some security issues. Passwords should be hashed...
```

**Problem:** Generic security advice, no depth.

---

### After Optimization

```
You are a security engineer specialized in authentication systems. You've
performed security audits for Fortune 500 companies and found vulnerabilities
in major applications. You follow OWASP Top 10 guidelines.

Perform security audit on this authentication code:

[code snippet]

Prioritize findings by severity (Critical/High/Medium/Low).
Reference CVEs or OWASP guidelines where applicable.
```

**Output will be:**
```
As a security auditor, here's my assessment:

**CRITICAL (Fix Immediately):**

1. **Plain Text Password Storage** (Line 23)
   - OWASP: A02:2021-Cryptographic Failures
   - Impact: Complete account compromise if DB breached
   - Fix: Use bcrypt with cost factor >= 12
   - Reference: CWE-256

2. **SQL Injection** (Line 45)
   - OWASP: A03:2021-Injection
   - Impact: Database takeover, data exfiltration
   - Fix: Use parameterized queries
   - Reference: CWE-89

**HIGH (Fix Before Production):**

3. **No Rate Limiting** (Login endpoint)
   - OWASP: A07:2021-Identification and Authentication Failures
   - Impact: Brute force attacks
   - Fix: Implement 5 attempts per 15min per IP
   - Tool: express-rate-limit

4. **Missing HTTPS Enforcement** (Line 12)
   - Impact: Man-in-the-middle attacks, credential theft
   - Fix: Force HTTPS redirect, set HSTS header

**MEDIUM:**

5. **Weak Session Timeout** (24 hours)
   - Best practice: 15min idle, 2hr absolute
   - Fix: Implement sliding sessions

**Code Examples:**

\`\`\`python
# CRITICAL FIX 1: Password Hashing
import bcrypt

# WRONG (CURRENT):
password = user_input  # stored as-is

# CORRECT:
hashed = bcrypt.hashpw(password.encode(), bcrypt.gensalt(rounds=12))
# Store 'hashed' in database

# CRITICAL FIX 2: SQL Injection
# WRONG (CURRENT):
query = f"SELECT * FROM users WHERE email='{email}'"

# CORRECT:
query = "SELECT * FROM users WHERE email=%s"
cursor.execute(query, (email,))
\`\`\`

**Compliance Impact:**
- GDPR: Violations for insufficient security (Art. 32)
- PCI DSS: Fails requirement 8.2 (password encryption)
- SOC 2: Type II control failures

**Estimated Risk:**
- Likelihood: HIGH (automated scanners will find these)
- Impact: CRITICAL (full system compromise)
- Overall Risk: CRITICAL

**Recommendation:** DO NOT deploy to production until Critical & High
issues resolved. Budget 2-3 days for fixes + testing.
```

**Improvement:** Professional-grade security audit with specific references and actionable fixes.

---

## Example 4: Teaching/Explanation

### Before Optimization

```
Explain recursion.
```

**Output might be:**
```
Recursion is when a function calls itself...
```

**Problem:** Textbook definition, not pedagogically effective.

---

### After Optimization

```
You are a computer science professor who's taught thousands of students.
You're known for making complex concepts intuitive through analogies and
building understanding from first principles. Your students say you explain
things "in a way that just clicks."

Explain recursion to a student who understands basic functions but finds
recursion confusing.

Use:
- Simple analogy first
- Then technical explanation
- Then concrete code example
- Common pitfalls to avoid
```

**Output will be:**
```
Imagine you're looking for your keys in a messy room. Your strategy:

1. Check the surface of the room
2. If you find keys → done!
3. If you find a box → open it and use THE SAME STRATEGY inside the box
4. Keep going until keys found or no more boxes

That's recursion: solving a problem by solving smaller versions of the same problem.

**Key Insight:** Recursion is just a strategy where:
- You solve easy cases directly (base case: found keys!)
- You break hard cases into easier versions of the same problem (found box → search inside)

**Technical Definition:**
A recursive function:
1. Calls itself with a simpler input
2. Has a base case to stop

**Code Example:**

\`\`\`python
def search_for_keys(place):
    # BASE CASE: Found keys!
    if place.has_keys():
        return "Found keys!"
    
    # RECURSIVE CASE: Found a box
    if place.has_box():
        box = place.get_box()
        return search_for_keys(box)  # Same function, smaller problem
    
    # No keys, no boxes
    return "No keys here"

# Practical Example: Factorial
def factorial(n):
    # BASE CASE
    if n == 0 or n == 1:
        return 1
    
    # RECURSIVE CASE: n! = n × (n-1)!
    return n * factorial(n - 1)

# factorial(5) = 5 × factorial(4)
#              = 5 × 4 × factorial(3)
#              = 5 × 4 × 3 × factorial(2)
#              = 5 × 4 × 3 × 2 × factorial(1)
#              = 5 × 4 × 3 × 2 × 1
#              = 120
\`\`\`

**Common Pitfalls:**

1. **Forgetting base case** → infinite recursion → stack overflow
   \`\`\`python
   # BAD: No base case!
   def bad_factorial(n):
       return n * bad_factorial(n - 1)  # Never stops!
   \`\`\`

2. **Not making problem simpler** → infinite recursion
   \`\`\`python
   # BAD: Calls itself with same input!
   def bad_search(n):
       return bad_search(n)  # n doesn't change!
   \`\`\`

3. **Using recursion when loop is simpler**
   - Recursion is elegant but uses more memory
   - For simple iteration, use loops

**When to Use Recursion:**
✅ Tree/graph traversal (file systems, DOM)
✅ Divide-and-conquer (quicksort, mergesort)
✅ Problems with recursive structure (Fibonacci, fractals)

**When to Avoid:**
❌ Simple loops (counting, summing)
❌ Very deep recursion (>1000 levels → stack overflow)

**The "Aha!" Moment:**
Recursion is just delegation. You solve the easy part now, and trust that the function will solve the smaller part later. Like a manager delegating to a team: "I'll handle this piece, you handle the rest" — except you ARE the team member too!
```

**Improvement:** Pedagogically sound, builds intuition, addresses misconceptions.

---

## Example 5: Business Analysis

### Before Optimization

```
Analyze this business strategy.
```

**Output might be:**
```
The strategy has strengths and weaknesses...
```

**Problem:** Generic SWOT analysis, no business acumen.

---

### After Optimization

```
You are a management consultant from McKinsey with 20 years of experience
advising Fortune 500 CEOs. You've seen hundreds of business strategies
and can quickly identify what will work vs. what's aspirational thinking.

Business Strategy:
- Launch premium subscription tier ($99/month)
- Target: Enterprise customers
- Current: 10K free users, $0 revenue
- Competition: Slack ($8/user/mo), Teams (free with O365)

Analyze this strategy with brutal honesty. What am I missing?
```

**Output will be:**
```
As a consultant who's advised on countless SaaS pivots, here's what I see:

**The Uncomfortable Truth:**

You're attempting a 0-to-$99 jump. That's not a strategy, it's a fantasy.

**What You're Missing:**

1. **Price Anchoring Failure**
   - Current: $0
   - Target: $99 (infinite % increase)
   - Psychology: Users can't rationalize this jump
   - Competitors: $8-15/user range
   - **Your $99 needs to compete with their $0-15**

2. **No Value Ladder**
   - Missing: $19 tier (solo pros)
   - Missing: $49 tier (small teams)
   - Result: Customers have nowhere to "climb"
   - Fix: Create 3-tier structure

3. **Enterprise Readiness Gap**
   - Enterprise requires: SSO, SOC2, SLA, dedicated support
   - I'm guessing you have: None of the above
   - Timeline to enterprise-ready: 6-12 months minimum
   - Cost: $200K-500K investment

4. **Competitive Moat Unclear**
   - Slack: 10M+ DAU, deep integrations
   - Teams: Free + O365 bundle (can't compete on price)
   - You: 10K users, $0 revenue
   - **Question: Why would enterprise pay YOU $99 vs Slack $8?**

**What Actually Works (Based on 50+ SaaS clients):**

**Phase 1: Validation (Months 1-3)**
- Launch $19/mo "Pro" tier
- Features: Remove ads, 2x limits, priority support
- Target: 5% conversion (500 paid users)
- Revenue: $9,500/mo
- Goal: Prove willingness to pay

**Phase 2: Expansion (Months 4-9)**
- Add $49/mo "Team" tier
- Features: Collaboration, admin controls, analytics
- Target: 2% of free users (200 teams × $49 = $9,800/mo)
- Total revenue: ~$20K/mo

**Phase 3: Enterprise (Months 10-18)**
- Build enterprise features (SSO, SOC2)
- Custom pricing (starts at $500/mo)
- Sales team (2-3 people)
- Target: 10 enterprise customers
- Revenue: $5K+ per enterprise

**18-Month Target:** $100K/mo ARR (believable)

**vs Your Plan:** $1M/mo ARR (requires 10,000 enterprise customers at $99 → unrealistic)

**Hard Numbers:**
- Enterprise sales cycle: 6-12 months
- Enterprise close rate: 2-5%
- Cost per enterprise customer: $10K-50K
- Your customer acquisition budget: Unknown (likely $0)

**Red Flags:**
- No pricing experimentation mentioned
- No enterprise sales experience mentioned
- No competitive differentiation mentioned
- Smells like: "We need revenue, let's charge a lot"

**What I'd Tell the CEO:**

"Your numbers don't work. You're targeting enterprise without enterprise features, $99 without price anchoring, and revenue without a value ladder. This will fail.

Here's what we do instead:
1. Ship $19 tier next week
2. Validate conversion
3. Build $49 team tier
4. If #1 and #2 work, THEN invest in enterprise

Test each step. Don't bet the company on an unproven $99 price point."

**Bottom Line:** Start with singles and doubles, not home runs. Prove
willingness to pay at ANY price before optimizing for maximum price.
```

**Improvement:** Business-savvy reality check with actionable alternative path.

---

## Role Assignment Patterns

### Pattern 1: Domain Expert

```
You are a [domain] expert with [X] years of experience in [specialty].
```

**Examples:**
- "senior Python developer with 10 years in backend systems"
- "database architect specializing in PostgreSQL optimization"
- "UX designer with expertise in mobile-first design"

---

### Pattern 2: Specific Perspective

```
You are [role] who [unique perspective or approach].
```

**Examples:**
- "a teacher who explains complex concepts through analogies"
- "a consultant who gives brutally honest assessments"
- "a code reviewer who prioritizes maintainability over cleverness"

---

### Pattern 3: Authority + Credibility

```
You are [authoritative role] with [credibility markers].
```

**Examples:**
- "a security auditor who's found vulnerabilities in Fortune 500 apps"
- "a CTO who's scaled startups from 0 to 10M users"
- "a professor who's taught 10,000+ students"

---

### Pattern 4: Comparative Experience

```
You are [role] who has experience with BOTH [A] and [B], understanding trade-offs deeply.
```

**Examples:**
- "an architect who's deployed both monoliths and microservices"
- "a developer fluent in both TypeScript and Python"
- "a manager who's led both remote and in-office teams"

---

## Role Selection Guide

| Task Type | Effective Role | Why |
|-----------|---------------|-----|
| **Code Review** | Senior developer + performance focus | Activates optimization patterns |
| **Architecture** | Solutions architect + experience | Provides strategic thinking |
| **Security** | Security auditor + standards | Applies security frameworks |
| **Teaching** | Professor + pedagogy skills | Uses effective teaching methods |
| **Business** | Consultant + brutal honesty | Cuts through aspirational thinking |
| **Debugging** | Debugger + systematic approach | Structured troubleshooting |
| **Design** | Designer + specific style | Aesthetic + functional guidance |
| **Writing** | Editor + audience awareness | Clarity + target audience fit |

---

## Implementation Checklist

### Before Sending Prompt

- [ ] Does the task need domain expertise?
- [ ] What specific perspective would be valuable?
- [ ] What experience level is needed?
- [ ] Are there credibility markers to add?

### Role Components

**Minimum (Quick Boost):**
```
You are a [title] with [experience level].
```

**Enhanced:**
```
You are a [title] with [experience level] in [specialty].
[One sentence about unique perspective or approach.]
```

**Maximum:**
```
You are a [title] with [experience level] in [specialty].
[Credibility markers: projects, achievements, recognition.]
[Unique perspective or approach.]
[Relevant philosophy or values.]
```

---

## Common Mistakes

### Mistake 1: Too Generic

```
❌ "You are an expert."
✅ "You are a senior Python developer specialized in API design."
```

### Mistake 2: Over-Credentialing

```
❌ "You have PhDs in computer science, mathematics, and physics from MIT, 
     Stanford, and Oxford. You've won 5 Nobel Prizes..."
✅ "You are a machine learning engineer with 8 years of production experience."
```

### Mistake 3: Wrong Role

```
❌ Task: Debug code. Role: "You are a project manager."
✅ Task: Debug code. Role: "You are a senior developer with debugging expertise."
```

---

## Token Budget

**Typical token counts for role assignment:**

- **Minimal:** 10-15 tokens
  ```
  You are a senior Python developer.
  ```

- **Standard:** 20-30 tokens
  ```
  You are a senior Python developer with 10 years of experience in
  backend systems and API design.
  ```

- **Detailed:** 40-60 tokens
  ```
  You are a senior Python developer with 10 years of experience building
  scalable backend systems. You've optimized APIs serving 10M+ requests/day
  and prioritize performance without sacrificing readability.
  ```

**ROI:** High - small token investment, significant quality improvement.

---

## Vietnamese Quick Reference

### Các Vai Trò Phổ Biến

| Task | Vai Trò (Role) | Tiếng Việt |
|------|---------------|-----------|
| **Review code** | Senior developer | Lập trình viên senior |
| **Security audit** | Security engineer | Kỹ sư bảo mật |
| **Explain concept** | Teacher/Professor | Giáo viên/Giảng viên |
| **Architecture** | Solutions architect | Kiến trúc sư hệ thống |
| **Business strategy** | Management consultant | Tư vấn quản lý |

### Cấu Trúc Cơ Bản

```
Bạn là [chức danh] với [kinh nghiệm] về [chuyên môn].

You are a [title] with [experience] in [specialty].
```

### Ví Dụ

**Trước:**
```
Review code này.
```

**Sau:**
```
Bạn là lập trình viên Python senior với 10 năm kinh nghiệm tối ưu performance.

Review code này tập trung vào: Performance và code quality.
```

**Cải thiện:** +30% relevance, +20% domain accuracy

---

## Summary

**Role Assignment = Expert Mode**

**Key Principle:** Activate domain-specific knowledge patterns by assigning expert role.

**Formula:**
```
[Title] + [Experience Level] + [Specialty] = Expert Perspective
```

**Impact:**
- **Relevance:** +20-40% (domain-appropriate responses)
- **Depth:** +25-35% (expert-level insights)
- **Accuracy:** +15-30% (fewer generic answers)
- **Token overhead:** +10-60 tokens (high ROI)

**Best Practice:** Match role to task domain and desired perspective.

**Quick Template:**
```
You are a [senior/expert] [role] with [X years] of experience in [specialty].
[Optional: Unique perspective or approach in 1 sentence.]
```

---

**Related Examples:**
- `basic-clarity.md` - Overall clarity improvement
- `output-format.md` - Format specification
- `../deep-dive/` - Advanced optimization with frameworks

**Related References:**
- `../../references/optimization-toolkit.md` - F1: Role Assignment technique
- `../../references/core-concepts.md` - Role in 4D methodology
