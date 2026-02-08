# Quick Boost Example: Output Format Specification

## Optimization Level: ⚡ Quick Boost

**Focus:** Format Specification (F3 technique)  
**Time Required:** 3-7 minutes  
**Expected Impact:** +50-80% output usability

---

## Why Format Matters

**Problem:** Without format specification, AI chooses arbitrary structure, leading to:
- Inconsistent outputs across runs
- Unusable format for your needs (wanted JSON, got prose)
- Missing sections you expected
- Extra sections you didn't need

**Solution:** Explicitly specify output format, structure, and style.

---

## Phase 1: Interactive Dialogue (Quick Boost)

**Optimization Level:** Quick Boost (ask only if format is critical and ambiguous)

### When to Ask About Format

Quick Boost asks format questions when:
- Output format completely unspecified
- Multiple valid formats exist
- Format choice significantly impacts usability

### Example Dialogue for "List the top programming languages"

**Initial Prompt:** "List the top programming languages."

**Critical Gap:** Format unspecified (prose? JSON? table?)

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "output-format",
      "prompt": "What output format do you need? (Determines structure)",
      "options": [
        {"id": "json", "label": "JSON array (structured data for programming)"},
        {"id": "markdown-table", "label": "Markdown table (readable format)"},
        {"id": "csv", "label": "CSV (spreadsheet-compatible)"},
        {"id": "plain-list", "label": "Plain text list (simple)"},
        {"id": "prose", "label": "Prose paragraph (narrative)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "output-format": "json"
}
```

**Analysis:**
- Format: JSON → Structured data output
- Implication: Array of objects with properties
- Structure: `[{"name": "...", "rank": ...}]`

**Decision:** Optimize for JSON array with name, rank, popularity metrics

### Vietnamese Example

**Initial Prompt:** "Liệt kê các ngôn ngữ lập trình phổ biến."

**Dialogue (Vietnamese):**

```json
{
  "questions": [
    {
      "id": "dinh-dang",
      "prompt": "Bạn cần kết quả ở định dạng nào? (để tôi format đúng cách)",
      "options": [
        {"id": "json", "label": "JSON (dữ liệu có cấu trúc)"},
        {"id": "bang", "label": "Bảng biểu (table)"},
        {"id": "danh-sach", "label": "Danh sách đơn giản (list)"},
        {"id": "doan-van", "label": "Đoạn văn (paragraph)"}
      ]
    }
  ]
}
```

**User Response:** `{"dinh-dang": "bang"}`

**Analysis:** Markdown table → Add structure with columns

---

## Example 1: Data Output

### Before Optimization

```
List the top programming languages.
```

**Output might be:**
```
Python, JavaScript, Java, C++, and C# are among the top programming
languages in 2026. Python is particularly popular for...
[prose paragraph]
```

**Problem:** Wanted structured data, got prose.

---

### After Optimization

```
List the top 10 programming languages in 2026.

Output format:
| Rank | Language | Primary Use Case | Popularity Score |
|------|----------|------------------|------------------|
| 1    | ...      | ...              | ...              |

Sort by popularity (most popular first).
```

**Output will be:**
```
| Rank | Language   | Primary Use Case | Popularity Score |
|------|------------|------------------|------------------|
| 1    | Python     | AI/ML, Web       | 95/100          |
| 2    | JavaScript | Web Frontend     | 93/100          |
...
```

**Improvement:** Structured, consistent, usable data format.

---

## Example 2: Code Documentation

### Before Optimization

```
Document this function:

def calculate_discount(price, percentage):
    return price * (1 - percentage / 100)
```

**Output might be:**
```
This function calculates a discount. It takes price and percentage...
[prose description]
```

**Problem:** Wanted standard docstring format, got prose.

---

### After Optimization

```
Add a docstring to this function:

def calculate_discount(price, percentage):
    return price * (1 - percentage / 100)

Docstring format:
\`\`\`python
"""
[One-line summary]

Args:
    [param]: [type] - [description]
    ...

Returns:
    [type]: [description]

Example:
    >>> [usage example]
"""
\`\`\`
```

**Output will be:**
```python
def calculate_discount(price, percentage):
    """
    Calculate final price after applying percentage discount.
    
    Args:
        price: float - Original price before discount
        percentage: float - Discount percentage (0-100)
    
    Returns:
        float: Final price after discount applied
    
    Example:
        >>> calculate_discount(100, 20)
        80.0
    """
    return price * (1 - percentage / 100)
```

**Improvement:** Standard, tool-parseable docstring.

---

## Example 3: Comparison Output

### Before Optimization

```
Compare React and Vue.
```

**Output might be:**
```
React is a popular library created by Facebook. It uses JSX and...
Vue is a progressive framework that...
[long paragraphs]
```

**Problem:** Hard to compare side-by-side, buried in prose.

---

### After Optimization

```
Compare React vs Vue for building a dashboard app.

Output format:

## React
**Pros:**
- [bullet list]

**Cons:**
- [bullet list]

**Best for:**
- [bullet list]

## Vue
**Pros:**
- [bullet list]

**Cons:**
- [bullet list]

**Best for:**
- [bullet list]

## Recommendation
[Which to choose and why]
```

**Output will be:**
```
## React
**Pros:**
- Huge ecosystem and community
- Excellent for large, complex apps
- Strong corporate backing (Meta)

**Cons:**
- Steeper learning curve
- More boilerplate code
- JSX syntax takes getting used to

**Best for:**
- Large-scale enterprise apps
- Teams familiar with JavaScript ecosystem
- Projects requiring extensive third-party integrations

## Vue
**Pros:**
- Gentle learning curve
- Excellent documentation
- More intuitive template syntax

**Cons:**
- Smaller ecosystem than React
- Less corporate backing
- Fewer job opportunities

**Best for:**
- Rapid prototyping
- Small to medium projects
- Teams new to modern frameworks

## Recommendation
For dashboard with complex state and large team → React
For quick dashboard with small team → Vue
```

**Improvement:** Clear, scannable, actionable comparison.

---

## Example 4: API Documentation

### Before Optimization

```
Document the user registration API endpoint.
```

**Output might be:**
```
The registration endpoint accepts user data and creates a new user...
[prose description]
```

**Problem:** Missing standard API doc sections (method, URL, params, responses).

---

### After Optimization

```
Document the user registration API endpoint.

Format:
## Endpoint Name

**Method:** [HTTP method]
**URL:** [endpoint path]

**Request Body:**
\`\`\`json
{
  "field": "type - description"
}
\`\`\`

**Response (Success - 201):**
\`\`\`json
{
  ...
}
\`\`\`

**Response (Error - 400):**
\`\`\`json
{
  ...
}
\`\`\`

**Example cURL:**
\`\`\`bash
curl -X POST ...
\`\`\`
```

**Output will be:**
```
## User Registration

**Method:** POST
**URL:** `/api/v1/auth/register`

**Request Body:**
\`\`\`json
{
  "email": "string - Valid email address",
  "password": "string - Min 8 characters, 1 uppercase, 1 number",
  "name": "string - Full name"
}
\`\`\`

**Response (Success - 201):**
\`\`\`json
{
  "id": "string - User UUID",
  "email": "string - Registered email",
  "name": "string - User name",
  "created_at": "timestamp - ISO 8601"
}
\`\`\`

**Response (Error - 400):**
\`\`\`json
{
  "error": "string - Error message",
  "details": ["string - Validation errors"]
}
\`\`\`

**Example cURL:**
\`\`\`bash
curl -X POST https://api.example.com/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"user@example.com","password":"SecurePass123","name":"John Doe"}'
\`\`\`
```

**Improvement:** Complete, standard API documentation.

---

## Example 5: Analysis Report

### Before Optimization

```
Analyze this code for issues.

[code snippet]
```

**Output might be:**
```
There are several issues with this code. First, there's a potential
null pointer... Also, the performance could be improved... Additionally...
[unstructured prose]
```

**Problem:** Hard to prioritize, no clear action items.

---

### After Optimization

```
Analyze this code for issues.

[code snippet]

Output format:

## Critical Issues (Must Fix)
| Line | Issue | Impact | Fix |
|------|-------|--------|-----|
| ...  | ...   | ...    | ... |

## Warnings (Should Fix)
| Line | Issue | Impact | Fix |
|------|-------|--------|-----|
| ...  | ...   | ...    | ... |

## Suggestions (Nice to Have)
| Line | Issue | Impact | Fix |
|------|-------|--------|-----|
| ...  | ...   | ...    | ... |

## Summary
- Critical: [count]
- Warnings: [count]
- Suggestions: [count]
```

**Output will be:**
```
## Critical Issues (Must Fix)
| Line | Issue | Impact | Fix |
|------|-------|--------|-----|
| 42   | Null pointer risk | App crash | Add null check |
| 67   | SQL injection | Security vulnerability | Use parameterized query |

## Warnings (Should Fix)
| Line | Issue | Impact | Fix |
|------|-------|--------|-----|
| 15   | Unused variable | Code clutter | Remove declaration |
| 89   | Magic number | Maintainability | Extract to constant |

## Suggestions (Nice to Have)
| Line | Issue | Impact | Fix |
|------|-------|--------|-----|
| 23   | Long function | Readability | Split into helpers |
| 56   | Inconsistent naming | Confusion | Rename to camelCase |

## Summary
- Critical: 2 (fix immediately)
- Warnings: 2 (fix before merge)
- Suggestions: 2 (refactor when time permits)
```

**Improvement:** Prioritized, actionable, structured feedback.

---

## Format Specification Patterns

### Pattern 1: Structured Data

**Use when:** Need parseable, consistent data output.

**Template:**
```
Output format: [JSON/CSV/Table/YAML]

Structure:
[Show exact structure with field types]

Example:
[Provide one example]
```

---

### Pattern 2: Documentation

**Use when:** Need standard documentation format.

**Template:**
```
Follow [standard] documentation format:
- [Section 1]: [What to include]
- [Section 2]: [What to include]

Use [markdown/reStructuredText/etc.]
```

---

### Pattern 3: Comparison

**Use when:** Comparing multiple options.

**Template:**
```
For each option, provide:

## [Option Name]
**Pros:**
- [List]

**Cons:**
- [List]

**Best for:**
- [Use cases]

## Final Recommendation
[Decision + reasoning]
```

---

### Pattern 4: Step-by-Step

**Use when:** Need process or instructions.

**Template:**
```
Output as numbered steps:

**Step 1:** [Action]
- How: [Details]
- Why: [Reasoning]
- Example: [Concrete example]

[Repeat for each step]
```

---

### Pattern 5: Report

**Use when:** Need analysis or findings.

**Template:**
```
## Executive Summary
[1-2 sentences]

## Findings
[Bullet list or table]

## Recommendations
[Prioritized list]

## Next Steps
[Action items]
```

---

## Common Format Specifications

### For Code

```
Provide:
1. Complete, runnable code
2. Inline comments for complex logic
3. Type hints (if Python/TypeScript)
4. Example usage after code
```

### For Explanations

```
Structure:
1. Brief definition (1-2 sentences)
2. Why it matters
3. How it works
4. Example (concrete)
5. Common pitfalls

Length: ~300 words
Audience: [specify]
```

### For Lists

```
Output format:
- Bullet list (unordered)
  OR
- Numbered list (ordered)
  OR
- Table with columns: [col1, col2, col3]

Include: [number] items
Sort by: [criteria]
```

### For JSON

```
Output as valid JSON:

{
  "field1": "type - description",
  "field2": {
    "nested": "structure"
  },
  "field3": ["array", "of", "values"]
}

Ensure:
- Valid JSON syntax
- Proper escaping
- Consistent naming (camelCase/snake_case)
```

---

## Before/After Summary

| Task Type | Before (Vague) | After (Formatted) | Improvement |
|-----------|---------------|-------------------|-------------|
| **Data** | "List items" | Specify: JSON/Table/CSV | +80% usability |
| **Code** | "Write function" | Specify: docstring, types, examples | +70% documentation |
| **Compare** | "Compare X vs Y" | Specify: Pros/Cons/Best-for sections | +75% scannability |
| **API Doc** | "Document endpoint" | Specify: Method/URL/Params/Responses | +85% completeness |
| **Analysis** | "Find issues" | Specify: Severity levels, table format | +70% actionability |

---

## Implementation Checklist

### Before Sending Prompt

- [ ] Did I specify the format? (JSON, table, prose, etc.)
- [ ] Did I show an example structure?
- [ ] Did I list required sections/fields?
- [ ] Did I specify order/sorting?
- [ ] Did I define length/size constraints?

### Format Elements to Specify

**Structure:**
- [ ] Top-level organization (sections, headings)
- [ ] Subsections and hierarchy
- [ ] Field/column names

**Style:**
- [ ] Markdown/Plain text/JSON/etc.
- [ ] Bullet points vs numbered vs prose
- [ ] Code blocks vs inline code

**Content:**
- [ ] Required sections
- [ ] Optional sections
- [ ] Examples to include
- [ ] Length per section

---

## Token Budget

**Typical token overhead for format specification:**
- **Minimal (just format name):** +5-10 tokens
  ```
  Output as JSON.
  ```

- **Basic (format + structure):** +30-50 tokens
  ```
  Output format:
  | Column1 | Column2 | Column3 |
  ```

- **Detailed (format + structure + example):** +80-150 tokens
  ```
  Output format:
  [Show complete structure with example]
  ```

**ROI:** High - small token investment, large usability gain.

---

## Common Mistakes

### Mistake 1: Format Too Vague

```
❌ "Provide a nice output format"
✅ "Output as markdown table with columns: Name, Value, Description"
```

### Mistake 2: No Example

```
❌ "Use JSON format"
✅ "Use JSON format:
{
  "name": "string",
  "age": "number"
}"
```

### Mistake 3: Contradictory Format

```
❌ "Provide detailed analysis. Keep it brief. Use table format and prose."
✅ "Provide analysis in table format with 3 columns: Issue, Impact, Fix.
Max 10 rows."
```

---

## Vietnamese Quick Reference

### Các Định Dạng Phổ Biến

| Loại Output | Format | Ví Dụ |
|-------------|--------|-------|
| **Dữ liệu** | JSON, Table, CSV | Danh sách có cấu trúc |
| **Code** | Code block + docstring | Hàm với tài liệu |
| **Giải thích** | Sections: Định nghĩa, Cách dùng, Ví dụ | Bài giải thích có cấu trúc |
| **So sánh** | Pros/Cons cho mỗi option | Dễ đối chiếu |
| **Phân tích** | Table: Vấn đề, Mức độ, Giải pháp | Ưu tiên rõ ràng |

### Checklist Nhanh

- [ ] **Format:** JSON? Table? Prose?
- [ ] **Cấu trúc:** Cột/trường nào?
- [ ] **Độ dài:** Bao nhiêu mục/từ?
- [ ] **Thứ tự:** Sắp xếp theo gì?
- [ ] **Ví dụ:** Có mẫu không?

---

## Summary

**Format Specification = Usability**

**Key Principle:** Show the AI exactly what structure you want.

**Techniques:**
1. Name the format (JSON, table, markdown)
2. Show the structure (columns, fields, sections)
3. Provide example (one complete example)
4. Specify constraints (length, order, required fields)

**Impact:**
- **Consistency:** +80% (same format every time)
- **Usability:** +50-80% (output ready to use)
- **Clarity:** +40-60% (organized, scannable)
- **Token overhead:** +30-150 tokens (high ROI)

**Best Practice:** When in doubt, show an example of desired output.

---

**Related Examples:**
- `basic-clarity.md` - Overall clarity improvement
- `role-assignment.md` - Expert role specification
- `../deep-dive/` - Advanced formatting with frameworks

**Related References:**
- `../../references/optimization-toolkit.md` - F3: Format Specification technique
- `../../references/core-concepts.md` - Output format in 4D methodology
