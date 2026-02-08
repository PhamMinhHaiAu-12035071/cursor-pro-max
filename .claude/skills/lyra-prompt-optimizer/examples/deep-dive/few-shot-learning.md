# Deep Dive Example: Few-Shot Learning

## Optimization Level: 🔍 Deep Dive

**Focus:** Example Provision (F6 technique)  
**Time Required:** 15-35 minutes  
**Expected Impact:** +45-70% format accuracy, +30-50% consistency

---

## When to Use Few-Shot Learning

**Best for:**
- Complex or unusual output formats
- Specific style/tone required
- Pattern-based tasks (parsing, transformation, generation)
- When rules are hard to explain but easy to show

**Indicators:**
- "Format like this..."
- "In the style of..."
- "Similar to..."
- Output format is easier to show than explain

---

## Phase 1: Interactive Dialogue (Deep Dive)

**Optimization Level:** Deep Dive (3-5 questions, focus on examples and format)

### Round 1: Initial Questions (Goal + Format + Platform)

**Initial Prompt:** "Document this API endpoint in a specific format I use."

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "doc-purpose",
      "prompt": "What is the primary purpose of this API documentation?",
      "options": [
        {"id": "developer-reference", "label": "Developer reference (technical specs)"},
        {"id": "user-guide", "label": "User guide (how-to instructions)"},
        {"id": "integration-guide", "label": "Integration guide (for third-party)"},
        {"id": "internal-docs", "label": "Internal team documentation"}
      ]
    },
    {
      "id": "format-style",
      "prompt": "Do you have an existing documentation style/format?",
      "options": [
        {"id": "yes-can-provide", "label": "Yes, I can provide examples"},
        {"id": "yes-describe", "label": "Yes, I can describe it"},
        {"id": "no-standard", "label": "No, suggest best practice"},
        {"id": "custom-complex", "label": "Yes, but it's complex (need multiple examples)"}
      ]
    },
    {
      "id": "ai-platform",
      "prompt": "Which AI will generate these docs?",
      "options": [
        {"id": "claude", "label": "Claude (good at structured formats)"},
        {"id": "chatgpt", "label": "ChatGPT (versatile documentation)"},
        {"id": "gemini", "label": "Gemini"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "doc-purpose": "developer-reference",
  "format-style": "yes-can-provide",
  "ai-platform": "claude"
}
```

**Analysis:**
- Purpose: Developer reference → Technical, precise
- Format: User has examples → Use few-shot learning
- Platform: Claude → Can handle complex structured formats

### Round 2: Follow-up for Examples

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "example-count",
      "prompt": "How many example formats can you provide? (More examples = better pattern learning)",
      "options": [
        {"id": "one", "label": "1 example (minimal pattern learning)"},
        {"id": "two-three", "label": "2-3 examples (good pattern learning) - Recommended"},
        {"id": "four-five", "label": "4-5 examples (excellent pattern learning)"},
        {"id": "many", "label": "5+ examples (comprehensive patterns)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "example-count": "two-three"
}
```

**Final Understanding:**
- Goal: Developer reference API documentation
- Technique: Few-shot learning with 2-3 examples
- Platform: Claude (structured formats)
- Format: User will provide examples
- Next step: Ask for examples, then optimize

---

## Example 1: Custom API Documentation Format

### Before Optimization (Zero-Shot)

```
Document this API endpoint:

POST /api/users/register
Params: email, password, name
Returns: user object or error
```

**Output might be:**
```
## /api/users/register

This endpoint registers a new user...
[Arbitrary format, inconsistent structure]
```

**Problem:** Format varies, missing standard sections.

---

### After Optimization (Few-Shot)

```
Document this API endpoint following these examples:

**Example 1:**
## GET /api/products/{id}
**Description:** Retrieve product by ID
**Authentication:** Required (Bearer token)
**Parameters:**
- `id` (path, string, required): Product UUID
**Response (200):**
\`\`\`json
{"id": "123", "name": "Widget", "price": 29.99}
\`\`\`
**Errors:**
- 404: Product not found
- 401: Unauthorized

**Example 2:**
## POST /api/cart/add
**Description:** Add item to shopping cart
**Authentication:** Required (Bearer token)
**Request Body:**
\`\`\`json
{"product_id": "string", "quantity": "number"}
\`\`\`
**Response (201):**
\`\`\`json
{"cart_id": "456", "items": [...], "total": 59.98}
\`\`\`
**Errors:**
- 400: Invalid product_id or quantity
- 404: Product not found

Now document this endpoint using the same format:

POST /api/users/register
Params: email (string, required), password (string, min 8 chars), name (string, required)
Returns: user object with id, email, name, created_at
Possible errors: 400 (validation), 409 (email exists)
```

**Output with Few-Shot:**
```
## POST /api/users/register
**Description:** Register a new user account
**Authentication:** None (public endpoint)
**Request Body:**
\`\`\`json
{
  "email": "string (required)",
  "password": "string (required, min 8 characters)",
  "name": "string (required)"
}
\`\`\`
**Response (201):**
\`\`\`json
{
  "id": "uuid",
  "email": "user@example.com",
  "name": "John Doe",
  "created_at": "2026-02-05T10:30:00Z"
}
\`\`\`
**Errors:**
- 400: Validation error (invalid email, weak password, missing name)
- 409: Email already registered
```

**Improvement:** Consistent format, all sections present, professional structure.

---

## Example 2: Code Comment Style

### Before Optimization

```
Add comments to this function:

def calculate_tax(amount, rate, deductions):
    taxable = amount - sum(deductions)
    tax = taxable * rate
    return tax
```

**Output might be:**
```python
# Calculate tax
def calculate_tax(amount, rate, deductions):
    # Calculate taxable amount
    taxable = amount - sum(deductions)
    # Calculate tax
    tax = taxable * rate
    # Return
    return tax
```

**Problem:** Generic, uninformative comments.

---

### After Optimization (Few-Shot)

```
Add comments to this function following the style of these examples:

**Example 1:**
\`\`\`python
def calculate_discount(price, percentage):
    """
    Calculate final price after percentage discount.
    
    Formula: price × (1 - percentage/100)
    Example: $100 with 20% off → $80
    
    Args:
        price (float): Original price before discount (must be > 0)
        percentage (float): Discount percentage, 0-100 (e.g., 20 for 20%)
        
    Returns:
        float: Final price after discount applied
        
    Raises:
        ValueError: If price ≤ 0 or percentage not in [0, 100]
    """
    if price <= 0:
        raise ValueError(f"Price must be positive, got {price}")
    if not 0 <= percentage <= 100:
        raise ValueError(f"Percentage must be 0-100, got {percentage}")
    
    return price * (1 - percentage / 100)
\`\`\`

**Example 2:**
\`\`\`python
def parse_date(date_string, format="%Y-%m-%d"):
    """
    Parse date string into datetime object.
    
    Supports multiple formats via format parameter.
    Defaults to ISO format (YYYY-MM-DD).
    
    Args:
        date_string (str): Date as string (e.g., "2026-02-05")
        format (str, optional): strftime format string. Defaults to "%Y-%m-%d"
        
    Returns:
        datetime: Parsed datetime object
        
    Raises:
        ValueError: If date_string doesn't match format
        
    Examples:
        >>> parse_date("2026-02-05")
        datetime.datetime(2026, 2, 5, 0, 0)
        >>> parse_date("02/05/2026", "%m/%d/%Y")
        datetime.datetime(2026, 2, 5, 0, 0)
    """
    return datetime.strptime(date_string, format)
\`\`\`

Now add comments to this function using the same style:

def calculate_tax(amount, rate, deductions):
    taxable = amount - sum(deductions)
    tax = taxable * rate
    return tax
```

**Output with Few-Shot:**
```python
def calculate_tax(amount, rate, deductions):
    """
    Calculate tax owed after applying deductions.
    
    Formula: (amount - total_deductions) × rate
    Example: $50,000 income, 20% rate, $5,000 deductions → $9,000 tax
    
    Args:
        amount (float): Gross income/amount before deductions (must be ≥ 0)
        rate (float): Tax rate as decimal (e.g., 0.20 for 20%)
        deductions (list[float]): List of deduction amounts to subtract
        
    Returns:
        float: Tax owed after deductions
        
    Raises:
        ValueError: If amount < 0 or rate not in [0, 1]
        TypeError: If deductions is not iterable
        
    Examples:
        >>> calculate_tax(50000, 0.20, [5000, 2000])
        8600.0  # (50000 - 7000) × 0.20
        >>> calculate_tax(30000, 0.15, [])
        4500.0  # No deductions
    """
    if amount < 0:
        raise ValueError(f"Amount must be non-negative, got {amount}")
    if not 0 <= rate <= 1:
        raise ValueError(f"Rate must be between 0 and 1, got {rate}")
    
    # Calculate taxable income after all deductions
    taxable = amount - sum(deductions)
    
    # Apply tax rate to taxable amount
    tax = taxable * rate
    
    return tax
```

**Improvement:** Professional docstring with formula, examples, error cases.

---

## Example 3: Data Transformation Pattern

### Before Optimization

```
Transform this data from format A to format B:

Input: [{"name": "Alice", "age": 30}, {"name": "Bob", "age": 25}]

Output should be different format.
```

**Output might be:**
```json
{"Alice": 30, "Bob": 25}
```

**Problem:** AI guesses format, might not match needs.

---

### After Optimization (Few-Shot)

```
Transform data following these examples:

**Example 1:**

Input:
[{"product": "Widget", "price": 29.99}, {"product": "Gadget", "price": 39.99}]

Output:
{
  "items": [
    {"id": 1, "name": "Widget", "cost": "$29.99", "category": "unknown"},
    {"id": 2, "name": "Gadget", "cost": "$39.99", "category": "unknown"}
  ],
  "total_items": 2
}

Pattern:
- Add sequential id (starting from 1)
- Rename "product" → "name", "price" → "cost"
- Format cost with $ prefix
- Add "category": "unknown" default field
- Wrap in "items" array with "total_items" count

**Example 2:**

Input:
[{"city": "NYC", "temp": 72}, {"city": "LA", "temp": 85}]

Output:
{
  "locations": [
    {"id": 1, "location": "NYC", "temperature_f": 72, "temperature_c": 22},
    {"id": 2, "location": "LA", "temperature_f": 85, "temperature_c": 29}
  ],
  "count": 2
}

Pattern:
- Add sequential id
- Rename "city" → "location", "temp" → "temperature_f"
- Add calculated "temperature_c" (formula: (F - 32) × 5/9)
- Wrap in "locations" array with "count"

Now transform this data following the same pattern structure:

Input:
[{"name": "Alice", "age": 30}, {"name": "Bob", "age": 25}]

Apply pattern:
- Add sequential id
- Keep "name" as is, rename "age" → "years_old"
- Add calculated "birth_year" (2026 - age)
- Wrap in "users" array with "total_users" count
```

**Output with Few-Shot:**
```json
{
  "users": [
    {
      "id": 1,
      "name": "Alice",
      "years_old": 30,
      "birth_year": 1996
    },
    {
      "id": 2,
      "name": "Bob",
      "years_old": 25,
      "birth_year": 2001
    }
  ],
  "total_users": 2
}
```

**Improvement:** Exact format match, pattern correctly applied.

---

## Few-Shot Learning Patterns

### Pattern 1: Format Template (2-3 examples)

**Use when:** Need consistent output structure

**Template:**
```
Format your response like these examples:

Example 1: [Complete example with all sections]

Example 2: [Another complete example, different content]

[Optional Example 3: Edge case or variation]

Now format this: [Your input]
```

### Pattern 2: Transformation Pairs (Input → Output)

**Use when:** Data transformation or parsing

**Template:**
```
Transform data following these examples:

Input 1: [Data]
Output 1: [Transformed data]
Explanation: [What changed]

Input 2: [Data]
Output 2: [Transformed data]
Explanation: [What changed]

Now transform: [Your data]
```

### Pattern 3: Style Mimicry (3-5 examples of style)

**Use when:** Need specific writing style or tone

**Template:**
```
Write in the style of these examples:

Example 1: [Text demonstrating style]

Example 2: [Text demonstrating style]

Example 3: [Text demonstrating style]

Now write about [topic] in this style.
```

---

## Example Selection Guidelines

### How Many Examples?

- **2 examples:** Minimum for establishing pattern
- **3 examples:** Ideal for most cases (pattern + variation)
- **4-5 examples:** Complex patterns or multiple edge cases
- **>5 examples:** Rarely needed, wastes tokens

### What Makes a Good Example?

✅ **Diverse:** Show different variations of the pattern  
✅ **Complete:** Include all sections/fields  
✅ **Realistic:** Use real-world-like content  
✅ **Clear:** Easy to see the pattern  
✅ **Annotated:** Explain what to notice (if pattern complex)

❌ **Redundant:** Don't repeat same pattern exactly  
❌ **Incomplete:** Missing sections confuse the pattern  
❌ **Trivial:** Too simple, doesn't show full complexity  
❌ **Obscure:** Pattern hard to identify

---

## Before/After Comparison

| Task | Zero-Shot | Few-Shot | Improvement |
|------|-----------|----------|-------------|
| **API Docs** | Inconsistent format | Standard format | +80% consistency |
| **Code Comments** | Generic comments | Professional docstrings | +70% quality |
| **Data Transform** | Guessed format | Exact format match | +90% accuracy |
| **Style Writing** | Generic voice | Target style matched | +60% style adherence |

---

## Token Budget Management

### Example Size

**Minimal (per example):** 30-50 tokens
```
Example 1: Input → Output
```

**Standard (per example):** 80-150 tokens
```
Example 1:
Input: [data]
Output: [transformed]
```

**Detailed (per example):** 200-400 tokens
```
Example 1:
Input: [data]
Output: [transformed]
Explanation: [what changed and why]
```

### Total Token Investment

- **2 examples × 100 tokens:** 200 tokens
- **3 examples × 150 tokens:** 450 tokens
- **4 examples × 200 tokens:** 800 tokens

**ROI:** High - dramatically improves format accuracy

---

## Common Mistakes

### Mistake 1: Examples Too Similar

```
❌ Bad:
Example 1: {"name": "Alice", "age": 30}
Example 2: {"name": "Bob", "age": 25}
Example 3: {"name": "Carol", "age": 28}

✅ Good:
Example 1: Simple case {"name": "Alice", "age": 30}
Example 2: Missing field {"name": "Bob"}
Example 3: Extra fields {"name": "Carol", "age": 28, "email": "carol@example.com"}
```

### Mistake 2: Incomplete Examples

```
❌ Bad:
Example 1: [Shows only happy path]

✅ Good:
Example 1: Happy path
Example 2: Edge case
Example 3: Error case
```

### Mistake 3: No Pattern Explanation

```
❌ Bad:
[Just showing examples without explaining pattern]

✅ Good:
Examples + "Notice how each example [pattern description]"
```

---

## Vietnamese Quick Reference

### Few-Shot Learning (Học Từ Ví Dụ)

**Khái niệm:** Cho AI xem ví dụ mẫu để nó học pattern.

**Khi nào dùng:**
- Format phức tạp, khó giải thích bằng lời
- Cần style/tone cụ thể
- Transform dữ liệu theo pattern

**Công thức:**
```
Ví dụ 1: [Mẫu đầy đủ]
Ví dụ 2: [Mẫu tương tự nhưng khác content]
Ví dụ 3 (option): [Edge case]

Bây giờ làm theo mẫu: [Input của bạn]
```

**Số lượng ví dụ:**
- 2 ví dụ: Đủ dùng
- 3 ví dụ: Tốt nhất
- 4-5 ví dụ: Cho pattern phức tạp
- >5 ví dụ: Lãng phí token

**Lợi ích:**
- Accuracy: +45-70%
- Consistency: +60-80%
- Format correctness: +80-90%

---

## Summary

**Few-Shot Philosophy:** Show, don't just tell.

**Core Pattern:**
1. Provide 2-3 complete examples
2. Show diversity (different inputs, edge cases)
3. Explain pattern (if complex)
4. Request same format for new input

**Best For:**
- Complex output formats
- Style/tone matching
- Data transformations
- Pattern-based tasks

**Impact:**
- **Format Accuracy:** +45-70%
- **Consistency:** +60-80%
- **Style Adherence:** +50-70%
- **Token overhead:** +200-800 tokens (2-4 examples)

**Key Takeaway:** Good examples are worth a thousand words of explanation.

---

**Related Examples:**
- `chain-of-thought.md` - Complementary reasoning technique
- `constraint-optimization.md` - Format + constraints
- `../quick-boost/output-format.md` - Simpler format specification

**Related References:**
- `../../references/optimization-toolkit.md` - F6: Example Provision
- `../../references/core-concepts.md` - Few-shot in methodology
