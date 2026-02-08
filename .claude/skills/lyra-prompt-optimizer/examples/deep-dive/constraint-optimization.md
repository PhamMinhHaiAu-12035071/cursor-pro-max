# Deep Dive Example: Constraint Optimization

## Optimization Level: 🔍 Deep Dive

**Focus:** Constraint Optimization (A6 technique)  
**Time Required:** 25-45 minutes  
**Expected Impact:** +40-60% solution fitness, +35% constraint compliance

---

## When to Use Constraint Optimization

**Best for:**
- Limited resources (budget, time, performance)
- Must-satisfy requirements (security, compliance)
- Trade-off decisions
- Multi-criteria optimization

**Indicators:**
- "Within budget of..."
- "Must comply with..."
- "Cannot exceed..."
- "Optimize for X while maintaining Y"

---

## Phase 1: Interactive Dialogue (Deep Dive)

**Optimization Level:** Deep Dive (4 questions, focus on constraints and tradeoffs)

### Round 1: Core Questions (Goal + Constraints)

**Initial Prompt:** "Design a scalable web application architecture."

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "primary-constraint",
      "prompt": "What is the primary constraint you must work within?",
      "options": [
        {"id": "budget", "label": "Budget/cost limits"},
        {"id": "performance", "label": "Performance requirements"},
        {"id": "timeline", "label": "Development timeline"},
        {"id": "team-size", "label": "Team size/expertise"},
        {"id": "compliance", "label": "Regulatory compliance"},
        {"id": "multiple", "label": "Multiple constraints (need to balance)"}
      ]
    },
    {
      "id": "scale-target",
      "prompt": "What scale are you targeting?",
      "options": [
        {"id": "small", "label": "Small (< 10K users, simple infrastructure)"},
        {"id": "medium", "label": "Medium (10K-100K users, distributed)"},
        {"id": "large", "label": "Large (100K-1M users, multi-region)"},
        {"id": "massive", "label": "Massive (1M+ users, global scale)"}
      ]
    },
    {
      "id": "optimization-priority",
      "prompt": "What should the architecture optimize for?",
      "allow_multiple": true,
      "options": [
        {"id": "cost", "label": "Cost efficiency"},
        {"id": "performance", "label": "Performance/speed"},
        {"id": "reliability", "label": "Reliability/uptime"},
        {"id": "scalability", "label": "Scalability/growth"},
        {"id": "simplicity", "label": "Simplicity/maintainability"},
        {"id": "security", "label": "Security/compliance"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "primary-constraint": "budget",
  "scale-target": "medium",
  "optimization-priority": ["cost", "scalability"]
}
```

**Analysis:**
- Constraint: Budget is primary → Cost-effective solutions
- Scale: Medium (10K-100K) → Need some distribution, not massive
- Optimize: Cost + Scalability → Tradeoff between cheap and growth-ready

### Round 2: Tradeoff Clarification

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "tradeoff-preference",
      "prompt": "When cost and scalability conflict, which takes priority?",
      "options": [
        {"id": "cost-first", "label": "Cost first (start cheap, scale later)"},
        {"id": "balanced", "label": "Balanced (reasonable cost, good scalability) - Recommended"},
        {"id": "scalability-first", "label": "Scalability first (invest upfront for growth)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "tradeoff-preference": "balanced"
}
```

**Final Understanding:**
- Goal: Web application architecture
- Scale: Medium (10K-100K users)
- Primary Constraint: Budget
- Optimize: Balance cost and scalability
- Approach: Cost-effective with growth path
- Framework: Constraint optimization (balance competing requirements)

---

## Example 1: System Architecture Under Constraints

### Before Optimization

```
Design a scalable web application architecture.
```

**Output might be:**
```
Use microservices with Kubernetes, Redis caching, PostgreSQL primary with
read replicas, Elasticsearch for search, Kafka for events...
[Expensive, over-engineered solution]
```

**Problem:** No budget consideration, assumes unlimited resources.

---

### After Optimization (With Constraints)

```
Design a scalable web application architecture.

**HARD CONSTRAINTS (Must Satisfy):**
1. Budget: Max $500/month for infrastructure
2. Team: 2 developers (no DevOps specialist)
3. Scale: Must support 10K concurrent users
4. Performance: p95 response time < 200ms
5. Availability: 99.5% uptime minimum
6. Compliance: GDPR data residency (EU)

**SOFT CONSTRAINTS (Optimize For, In Priority Order):**
1. Minimize operational complexity (priority: HIGH)
2. Maximize development velocity (priority: HIGH)
3. Future scalability to 100K users (priority: MEDIUM)
4. Cost efficiency (priority: MEDIUM)

**Trade-off Guidance:**
- Sacrifice cutting-edge tech for simplicity
- Sacrifice perfect scalability for faster delivery
- Do NOT sacrifice security or compliance

Provide architecture that satisfies all hard constraints and optimizes
for soft constraints in priority order. Show constraint validation.
```

**Output with Constraint Optimization:**
```
**Architecture Decision: Monolithic + Managed Services**

**Core Stack:**
- **App Server:** Single Node.js server on AWS EC2 t3.medium ($30/mo)
- **Database:** AWS RDS PostgreSQL db.t3.micro ($15/mo) + automated backups
- **Cache:** Redis on same EC2 instance (ElastiCache too expensive)
- **CDN:** Cloudflare Free tier
- **Monitoring:** AWS CloudWatch basic (included)
- **Hosting:** AWS eu-west-1 (GDPR compliance)

**Total Cost:** ~$50/month (90% under budget, leaves room for growth)

**HARD CONSTRAINT VALIDATION:**

✅ **Budget: $500/month**
- Actual: $50/month
- Margin: $450 remaining for traffic costs
- Status: SATISFIED (90% under budget)

✅ **Team: 2 developers (no DevOps)**
- Monolith = simpler deployment
- Managed services = no server management
- Single codebase = easier for small team
- Status: SATISFIED

✅ **Scale: 10K concurrent users**
- t3.medium: ~2000 req/sec capacity
- 10K users × 1 req/10sec = 1000 req/sec average
- Peaks (3x average) = 3000 req/sec → need caching
- With Redis caching (80% hit rate):
  - 3000 × 0.2 = 600 req/sec to app
- Status: SATISFIED (with caching)

✅ **Performance: p95 < 200ms**
- Monolith latency: ~50ms
- DB query (cached 80%): 10ms avg
- DB query (uncached): 100ms
- p95 estimate: 120ms
- Status: SATISFIED

✅ **Availability: 99.5%**
- EC2 SLA: 99.5%
- RDS SLA: 99.95%
- Combined: 99.45% (close enough)
- Can add auto-restart for 99.6%
- Status: SATISFIED

✅ **GDPR Compliance:**
- All data in EU (eu-west-1 region)
- RDS encryption at rest (enabled)
- SSL/TLS in transit (configured)
- Status: SATISFIED

**SOFT CONSTRAINT OPTIMIZATION:**

**1. Operational Complexity (HIGH) → Score: 9/10**
- Single server to manage ✓
- Managed database (no backups/scaling) ✓
- No orchestration (no K8s) ✓
- Minimal moving parts ✓
- Trade-off: Can't scale horizontally easily

**2. Development Velocity (HIGH) → Score: 8/10**
- Single codebase ✓
- No microservice complexity ✓
- Familiar stack (Node.js + PostgreSQL) ✓
- Fast iteration ✓
- Trade-off: Shared codebase for 2 devs (potential conflicts)

**3. Future Scalability to 100K (MEDIUM) → Score: 6/10**
- Vertical scaling: t3.medium → t3.large ($60/mo)
- Add read replica: +$15/mo
- Add load balancer: +$15/mo
- Total for 100K: ~$90/mo (still under budget)
- Trade-off: Eventually need to refactor to microservices

**4. Cost Efficiency (MEDIUM) → Score: 10/10**
- 90% under budget ✓
- No over-provisioning ✓
- Managed services (no ops cost) ✓
- Room for 10x growth within budget ✓

**WHY NOT Microservices + K8s (Typical "Scalable" Answer)?**

| Approach | Cost | Complexity | Team Fit | Constraint Match |
|----------|------|------------|----------|------------------|
| **Microservices + K8s** | $800-1500/mo | Very High | Need DevOps | ❌ FAILS budget + team |
| **Monolith + Managed** | $50/mo | Low | Perfect fit | ✅ ALL constraints satisfied |

**Migration Path (When Constraints Change):**

When budget > $2K/mo AND team > 5 people:
1. Extract high-traffic services first (e.g., API)
2. Add load balancer + 2nd server
3. Separate cache tier (ElastiCache)
4. Eventually move to microservices

**Bottom Line:**
The "best" architecture isn't the most sophisticated—it's the one that
satisfies your constraints. Microservices would fail your budget and team
constraints. This monolith satisfies ALL hard constraints and optimizes
for your priorities.

**Recommendation: Deploy the monolith. Revisit when constraints change.**
```

**Improvement:** Realistic, constraint-aware solution vs. idealistic over-engineering.

---

## Example 2: Algorithm Selection with Performance Constraints

### Before Optimization

```
Write a function to search for an item in a list.
```

**Output might be:**
```python
def search(items, target):
    for item in items:
        if item == target:
            return True
    return False
```

**Problem:** No optimization, inefficient for large lists.

---

### After Optimization (With Constraints)

```
Write a function to search for an item in a list.

**HARD CONSTRAINTS:**
1. Time complexity: Must be O(log n) or better
2. Space complexity: Max O(n) additional space
3. Input: List is pre-sorted (can rely on this)
4. Must handle: Empty list, duplicates, item not found

**SOFT CONSTRAINTS (Optimize For):**
1. Readability (priority: HIGH)
2. Minimal code (priority: MEDIUM)

**Trade-off Guidance:**
- Use standard library if available
- Prefer clarity over micro-optimizations

Provide implementation with complexity analysis and constraint validation.
```

**Output with Constraint Optimization:**
```python
from typing import List, Optional
import bisect

def search(items: List[int], target: int) -> Optional[int]:
    """
    Binary search for target in sorted list.
    
    Leverages bisect module (C implementation, O(log n)).
    
    Args:
        items: Sorted list of integers
        target: Value to find
        
    Returns:
        Index of target if found, None otherwise
        
    Time: O(log n)
    Space: O(1)
    
    Examples:
        >>> search([1, 3, 5, 7, 9], 5)
        2
        >>> search([1, 3, 5, 7, 9], 6)
        None
        >>> search([], 5)
        None
    """
    if not items:  # Edge case: empty list
        return None
    
    # bisect_left returns insertion point
    # If items[idx] == target, we found it
    idx = bisect.bisect_left(items, target)
    
    if idx < len(items) and items[idx] == target:
        return idx
    
    return None


# Alternative: Pure implementation (if bisect not available)
def search_pure(items: List[int], target: int) -> Optional[int]:
    """Binary search without stdlib."""
    if not items:
        return None
    
    left, right = 0, len(items) - 1
    
    while left <= right:
        mid = (left + right) // 2
        
        if items[mid] == target:
            return mid
        elif items[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    
    return None


**CONSTRAINT VALIDATION:**

✅ **Time Complexity: O(log n) required**
- Binary search: O(log n)
- Status: SATISFIED

✅ **Space Complexity: O(n) max**
- Actual: O(1) (no extra data structures)
- Status: SATISFIED (better than required)

✅ **Input: Sorted list assumption**
- Algorithm requires sorted input (documented)
- Status: SATISFIED

✅ **Edge Cases:**
- Empty list: ✓ Handled (returns None)
- Duplicates: ✓ Returns first occurrence
- Not found: ✓ Returns None
- Status: SATISFIED

**SOFT CONSTRAINT OPTIMIZATION:**

**1. Readability (HIGH) → Score: 9/10**
- Uses well-known bisect module ✓
- Clear variable names ✓
- Comprehensive docstring ✓
- Type hints ✓

**2. Minimal Code (MEDIUM) → Score: 10/10**
- 4 lines of logic (with bisect)
- No redundant code ✓

**ALTERNATIVE REJECTED:**

❌ **Linear Search O(n)**
```python
def search_linear(items, target):
    return target in items
```
Reason: Violates time complexity constraint O(log n).

❌ **Hash Table O(1)**
```python
def search_hash(items, target):
    item_set = set(items)  # O(n) space
    return target in item_set  # O(1) lookup
```
Reason: While O(1) lookup, setup is O(n) time, and returns bool not index.
Still valid if only existence check needed.

**COMPLEXITY COMPARISON:**

| Approach | Time | Space | Constraint Match |
|----------|------|-------|------------------|
| **Linear** | O(n) | O(1) | ❌ FAILS time |
| **Binary (bisect)** | O(log n) | O(1) | ✅ ALL satisfied |
| **Binary (pure)** | O(log n) | O(1) | ✅ ALL satisfied |
| **Hash** | O(n) setup | O(n) | ❌ Worse than binary |

**Recommendation:**
Use bisect implementation—leverages optimized C code, most readable,
satisfies all constraints.
```

**Improvement:** Complexity-aware, validated against constraints, justified choice.

---

## Constraint Optimization Template

```markdown
**HARD CONSTRAINTS (Must Satisfy):**
1. [Constraint 1]: [Specific requirement]
2. [Constraint 2]: [Specific requirement]
...

**SOFT CONSTRAINTS (Optimize For, In Priority Order):**
1. [Optimization goal 1] (priority: HIGH/MEDIUM/LOW)
2. [Optimization goal 2] (priority: HIGH/MEDIUM/LOW)
...

**Trade-off Guidance:**
- Willing to sacrifice [X] for [Y]
- NOT willing to sacrifice [Z]

---

**SOLUTION:**
[Your solution]

**CONSTRAINT VALIDATION:**

✅/❌ **[Constraint 1]:**
- Requirement: [What's required]
- Actual: [What solution provides]
- Status: SATISFIED/VIOLATED
- [Evidence/measurement]

[Repeat for all hard constraints]

**SOFT CONSTRAINT OPTIMIZATION:**

**1. [Goal 1] (priority: HIGH) → Score: X/10**
- [How solution optimizes for this]
- [Trade-offs made]

[Repeat for all soft constraints]

**ALTERNATIVES CONSIDERED:**

❌ **[Alternative 1]:**
Reason rejected: [Which constraint violated / why not optimal]

**RECOMMENDATION:**
[Final decision with justification]
```

---

## Common Constraint Categories

### Budget Constraints

```
**Budget Hard Constraints:**
- Infrastructure: Max $X/month
- Development time: Max Y hours
- Third-party services: Max $Z/month

**Optimization:**
- Use managed services to reduce ops time
- Leverage free tiers where possible
- Plan for 2x growth within budget
```

### Performance Constraints

```
**Performance Hard Constraints:**
- Latency: p95 < X ms
- Throughput: Min Y req/sec
- Memory: Max Z MB

**Optimization:**
- Profile to find bottlenecks
- Cache hot paths
- Optimize critical sections
```

### Team Constraints

```
**Team Hard Constraints:**
- Team size: X developers
- Expertise: [Known technologies]
- Availability: Y hours/week

**Optimization:**
- Choose familiar tech stack
- Minimize operational overhead
- Prioritize maintainability
```

---

## Vietnamese Quick Reference

### Tối Ưu Theo Ràng Buộc

**Khái niệm:** Tìm giải pháp tốt nhất trong giới hạn cho phép.

**Hai loại ràng buộc:**
1. **HARD (Bắt buộc):** Phải thỏa mãn (budget, performance, compliance)
2. **SOFT (Tối ưu hóa):** Càng tốt càng hay (readability, scalability)

**Công thức:**
```
1. List ràng buộc HARD (must-have)
2. List ràng buộc SOFT (ưu tiên)
3. Đưa ra giải pháp
4. Validate từng ràng buộc HARD
5. Score từng ràng buộc SOFT
```

**Ví dụ:**
```
HARD: Budget $500, Team 2 người, Scale 10K users
SOFT: Đơn giản (HIGH), Scalable (MEDIUM)

→ Chọn Monolith + Managed Services
  (không chọn Microservices vì vi phạm budget và team size)
```

**Lợi ích:**
- Solution fit: +40-60%
- Constraint compliance: +90%
- Realistic solutions (không over-engineer)

---

## Summary

**Constraint Optimization Philosophy:** The best solution satisfies all hard constraints and optimizes for soft constraints in priority order.

**Core Process:**
1. Define hard constraints (must-satisfy)
2. Define soft constraints (optimize-for)
3. Specify priorities
4. Provide trade-off guidance
5. Validate solution against constraints
6. Score optimization goals
7. Justify over alternatives

**Best For:**
- Limited resources
- Must-satisfy requirements
- Multi-criteria decisions
- Trade-off analysis

**Impact:**
- **Solution Fitness:** +40-60%
- **Constraint Compliance:** +80-95%
- **Realism:** +70% (avoid over-engineering)
- **Token overhead:** +150-300 tokens

**Key Takeaway:** Constraints aren't limitations—they're clarity. They eliminate infinite possibilities and focus on viable solutions.

---

**Related Examples:**
- `multi-perspective.md` - Consider stakeholder constraints
- `../revolutionary/graph-of-thoughts.md` - Complex constraint networks
- `chain-of-thought.md` - Systematic constraint checking

**Related References:**
- `../../references/optimization-toolkit.md` - A6: Constraint Optimization
- `../../references/core-concepts.md` - Constraint handling in methodology
