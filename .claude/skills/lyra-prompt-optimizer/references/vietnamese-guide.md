# Vietnamese Support Guide

## Hướng Dẫn Hỗ Trợ Tiếng Việt

**Mục đích / Purpose:** Provide comprehensive bilingual support for Vietnamese speakers learning prompt engineering.

**Triết lý / Philosophy:** Language should not be a barrier to mastering AI prompt optimization.

---

## Bilingual Activation Patterns

### English Triggers

Users can activate Lyra with these English phrases:

- "optimize this prompt"
- "improve my prompt"
- "make this prompt better"
- "refine this prompt"
- "help with prompt engineering"
- "fix this prompt"
- "enhance this prompt"
- "prompt optimization"

### Vietnamese Triggers (Từ Khóa Tiếng Việt)

Người dùng có thể kích hoạt Lyra bằng các cụm từ tiếng Việt:

- "tối ưu prompt"
- "tối ưu hóa prompt"
- "cải thiện prompt"
- "làm prompt tốt hơn"
- "sửa prompt"
- "prompt engineering"
- "hướng dẫn viết prompt"
- "làm sao để viết prompt tốt"
- "prompt này có vấn đề gì"
- "giúp tôi với prompt"

**Lưu ý / Note:** Hệ thống nhận diện cả tiếng Việt có dấu và không dấu.

---

## Response Language Strategy

### Auto-Detection Rule

**IF** user uses Vietnamese trigger **OR** writes in Vietnamese:
  → Respond with bilingual content (Vietnamese primary, English secondary)

**IF** user uses English trigger **AND** writes in English only:
  → Respond in English only, with option to switch to Vietnamese

**IF** unclear:
  → Ask preference: "Bạn muốn tôi trả lời bằng tiếng Việt hay tiếng Anh? / Would you like responses in Vietnamese or English?"

### Bilingual Format Patterns

#### Pattern 1: Side-by-Side Sections

```markdown
## Section Title / Tiêu Đề

**English:** 
[Content in English]

**Tiếng Việt:**
[Nội dung bằng tiếng Việt]
```

**When to use:** Detailed explanations, concepts, methodology

---

#### Pattern 2: Inline Translation

```markdown
Chain-of-Thought (Chuỗi Suy Nghĩ): [Explanation in Vietnamese]
```

**When to use:** Technical terms, framework names, quick definitions

---

#### Pattern 3: Vietnamese-Primary with English Terms

```markdown
**Chuỗi Suy Nghĩ (Chain-of-Thought - CoT):**

CoT là kỹ thuật yêu cầu AI giải thích từng bước suy nghĩ trước khi đưa ra
câu trả lời cuối cùng. Giống như khi bạn giải toán, bạn viết đầy đủ các
bước thay vì chỉ viết đáp án.

**English term:** Chain-of-Thought (CoT)
```

**When to use:** Vietnamese-speaking audience who needs to know English terms

---

## Bilingual Question Patterns for AskUserQuestion Tool

### Language Detection and Matching

**Core Principle:** Questions should match the user's language to create a seamless experience.

**Detection Logic:**

```
IF user_trigger IN vietnamese_triggers:
    question_language = "Vietnamese"
ELSE IF user_message CONTAINS vietnamese_characters:
    question_language = "Vietnamese"
ELSE:
    question_language = "English"
```

**Implementation:**

When calling AskUserQuestion tool, select question templates based on detected language.

### Vietnamese Question Templates by Category

#### Category 1: Goal Clarification (Làm Rõ Mục Tiêu)

**Mẫu Câu Hỏi 1: Mục tiêu chính**

```json
{
  "questions": [
    {
      "id": "muc-tieu-chinh",
      "prompt": "Mục tiêu chính của prompt này là gì?",
      "options": [
        {"id": "viet-code", "label": "Viết code (functions, scripts, programs)"},
        {"id": "giai-thich", "label": "Giải thích khái niệm (teaching, docs)"},
        {"id": "phan-tich-du-lieu", "label": "Phân tích dữ liệu (insights, reports)"},
        {"id": "tao-noi-dung", "label": "Tạo nội dung (articles, stories)"},
        {"id": "ho-tro-quyet-dinh", "label": "Hỗ trợ quyết định (recommendations)"},
        {"id": "sang-tao", "label": "Sáng tạo (brainstorming, ideas)"}
      ]
    }
  ]
}
```

**Mẫu Câu Hỏi 2: Tiêu chí thành công**

```json
{
  "questions": [
    {
      "id": "tieu-chi-thanh-cong",
      "prompt": "Bạn đánh giá prompt thành công dựa trên yếu tố nào?",
      "options": [
        {"id": "chinh-xac", "label": "Độ chính xác (accuracy)"},
        {"id": "day-du", "label": "Đầy đủ và chi tiết (completeness)"},
        {"id": "sang-tao", "label": "Tính sáng tạo (creativity)"},
        {"id": "toc-do", "label": "Tốc độ nhanh (speed)"},
        {"id": "ro-rang", "label": "Rõ ràng dễ hiểu (clarity)"},
        {"id": "thuc-thi-duoc", "label": "Thực thi được (actionable)"}
      ]
    }
  ]
}
```

#### Category 2: Audience Definition (Xác Định Đối Tượng)

**Mẫu Câu Hỏi: Đối tượng sử dụng**

```json
{
  "questions": [
    {
      "id": "doi-tuong-su-dung",
      "prompt": "Ai sẽ sử dụng hoặc đọc output?",
      "options": [
        {"id": "chuyen-gia-ky-thuat", "label": "Chuyên gia kỹ thuật (developers, engineers)"},
        {"id": "doanh-nhan", "label": "Doanh nhân (managers, business professionals)"},
        {"id": "nguoi-dung-phothong", "label": "Người dùng phổ thông (non-technical)"},
        {"id": "hoc-sinh-sinh-vien", "label": "Học sinh/sinh viên (students)"},
        {"id": "lanh-dao", "label": "Lãnh đạo (executives, decision makers)"},
        {"id": "da-dang", "label": "Đa dạng (mixed audience)"}
      ]
    },
    {
      "id": "trinh-do",
      "prompt": "Trình độ hiểu biết của họ về chủ đề này?",
      "options": [
        {"id": "moi-bat-dau", "label": "Mới bắt đầu (beginner)"},
        {"id": "trung-binh", "label": "Trung bình (intermediate)"},
        {"id": "nang-cao", "label": "Nâng cao (advanced)"},
        {"id": "chuyen-gia", "label": "Chuyên gia (expert)"}
      ]
    }
  ]
}
```

#### Category 3: Context Exploration (Khám Phá Bối Cảnh)

**Mẫu Câu Hỏi: Bối cảnh sử dụng**

```json
{
  "questions": [
    {
      "id": "boi-canh",
      "prompt": "Prompt này sẽ được dùng trong bối cảnh nào?",
      "options": [
        {"id": "san-xuat", "label": "Hệ thống sản xuất (production - độ tin cậy cao)"},
        {"id": "phat-trien", "label": "Phát triển/thử nghiệm (development - thử nghiệm OK)"},
        {"id": "hoc-tap", "label": "Học tập/giáo dục (learning - focus vào dạy)"},
        {"id": "nghien-cuu", "label": "Nghiên cứu (research - open-ended)"},
        {"id": "tu-dong-hoa", "label": "Tự động hóa (automation - kết quả ổn định)"}
      ]
    },
    {
      "id": "nen-tang-ai",
      "prompt": "Bạn sẽ dùng prompt này trên nền tảng AI nào?",
      "options": [
        {"id": "claude", "label": "Claude (Anthropic) - Ngữ cảnh dài, lý luận tốt"},
        {"id": "chatgpt", "label": "ChatGPT (OpenAI) - Đối thoại, sáng tạo"},
        {"id": "gemini", "label": "Gemini (Google) - Đa phương tiện, 1M+ tokens"},
        {"id": "nhieu-nen-tang", "label": "Nhiều nền tảng (cần tương thích)"},
        {"id": "khac", "label": "Nền tảng khác"}
      ]
    }
  ]
}
```

#### Category 4: Structural Preferences (Tùy Chọn Cấu Trúc)

**Mẫu Câu Hỏi: Định dạng output**

```json
{
  "questions": [
    {
      "id": "dinh-dang-output",
      "prompt": "Bạn cần output ở định dạng nào?",
      "options": [
        {"id": "markdown", "label": "Markdown (văn bản có format)"},
        {"id": "json", "label": "JSON (dữ liệu có cấu trúc)"},
        {"id": "code", "label": "Code kèm comments"},
        {"id": "plain-text", "label": "Plain text (đơn giản)"},
        {"id": "xml", "label": "XML (thẻ có cấu trúc)"},
        {"id": "tuy-y", "label": "Tùy ý (AI tự quyết định)"}
      ]
    },
    {
      "id": "cach-to-chuc",
      "prompt": "Output nên được tổ chức như thế nào?",
      "options": [
        {"id": "tung-buoc", "label": "Từng bước (step-by-step)"},
        {"id": "phan-sections", "label": "Chia sections"},
        {"id": "danh-sach", "label": "Danh sách bullet points"},
        {"id": "doan-van", "label": "Đoạn văn (paragraph)"},
        {"id": "bang-bieu", "label": "Bảng biểu (table)"},
        {"id": "linh-hoat", "label": "Linh hoạt (AI tự chọn)"}
      ]
    }
  ]
}
```

#### Category 5: Criticality Assessment (Đánh Giá Mức Độ Quan Trọng)

**Mẫu Câu Hỏi: Mức độ quan trọng**

```json
{
  "questions": [
    {
      "id": "muc-do-quan-trong",
      "prompt": "Prompt này quan trọng ở mức độ nào?",
      "options": [
        {"id": "cuc-quan-trong", "label": "Cực kỳ quan trọng (mission-critical, production)"},
        {"id": "quan-trong", "label": "Quan trọng (professional use, công việc)"},
        {"id": "trung-binh", "label": "Trung bình (general use, sử dụng chung)"},
        {"id": "thap", "label": "Thấp (experimentation, thử nghiệm)"}
      ]
    },
    {
      "id": "rang-buoc",
      "prompt": "Có những ràng buộc nào cần lưu ý?",
      "allow_multiple": true,
      "options": [
        {"id": "gioi-han-token", "label": "Giới hạn token/độ dài"},
        {"id": "phai-chinh-xac", "label": "Phải chính xác cao"},
        {"id": "phai-nhanh", "label": "Phải nhanh"},
        {"id": "phai-nhat-quan", "label": "Phải nhất quán (consistent)"},
        {"id": "can-sang-tao", "label": "Cần sáng tạo"},
        {"id": "an-toan", "label": "An toàn và đạo đức"},
        {"id": "khong-co", "label": "Không có ràng buộc đặc biệt"}
      ]
    }
  ]
}
```

### Language Matching Implementation

**Pattern:** Match question language to user's input language

**English User Example:**

```json
{
  "questions": [
    {
      "id": "primary-goal",
      "prompt": "What is the primary goal of this prompt?",
      "options": [
        {"id": "generate-code", "label": "Generate code"},
        {"id": "explain-concept", "label": "Explain a concept"}
      ]
    }
  ]
}
```

**Vietnamese User Example:**

```json
{
  "questions": [
    {
      "id": "muc-tieu-chinh",
      "prompt": "Mục tiêu chính của prompt này là gì?",
      "options": [
        {"id": "viet-code", "label": "Viết code"},
        {"id": "giai-thich", "label": "Giải thích khái niệm"}
      ]
    }
  ]
}
```

### Vietnamese Question Translation Guidelines

**Principles:**

1. **Natural Vietnamese** - Use conversational Vietnamese, not literal translation
   - Good: "Bạn cần output ở định dạng nào?"
   - Bad: "Bạn cần cái gì định dạng đầu ra?" (word-by-word translation)

2. **Preserve Technical Terms** - Keep English terms with Vietnamese explanation
   - Example: "Markdown (văn bản có format)"
   - Example: "JSON (dữ liệu có cấu trúc)"

3. **Cultural Context** - Use Vietnamese cultural references when helpful
   - Instead of "like a recipe", use "như công thức nấu ăn"
   - Instead of "step-by-step", use "từng bước như làm toán"

4. **Clarity over Brevity** - Vietnamese can be more verbose for clarity
   - Good: "Bạn cần output ở định dạng nào? (để tôi biết cách trình bày tốt nhất)"
   - Acceptable: "Output format?"

### Common Vietnamese Question Phrases

| English | Vietnamese | When to Use |
|---------|-----------|-------------|
| "What is..." | "... là gì?" | Definitions |
| "Which..." | "... nào?" | Choices |
| "How..." | "Như thế nào..." / "Làm sao..." | Processes |
| "Who..." | "Ai..." | People/roles |
| "Do you need..." | "Bạn có cần..." | Yes/No |
| "What should..." | "... nên như thế nào?" | Preferences |
| "Which is better..." | "Cái nào tốt hơn..." | Comparisons |

### Memory Tips for Vietnamese Users

**When writing Vietnamese questions:**

**Mẹo 1: Giữ nguyên technical terms**
- "Markdown", "JSON", "API" → Không dịch
- Thêm giải thích ngắn trong ngoặc: "(văn bản có format)"

**Mẹo 2: Dùng động từ quen thuộc**
- "Generate" → "Tạo ra", "Viết"
- "Analyze" → "Phân tích"
- "Optimize" → "Tối ưu hóa" (hoặc ngắn gọn: "tối ưu")

**Mẹo 3: Options rõ ràng**
- Mỗi option nên ngắn gọn, dễ scan
- Thêm giải thích ngắn trong ngoặc nếu cần
- Example: "Trung bình (intermediate)" thay vì chỉ "Trung bình"

**Mẹo 4: Context trong prompt**
- Thêm lý do hỏi: "(để tôi biết cách optimize tốt nhất)"
- Giúp user hiểu tại sao cần thông tin này

### Full Dialogue Example (Vietnamese)

**Scenario:** User activates với "tối ưu prompt này cho code review"

**Round 1: Questions in Vietnamese**

```json
{
  "questions": [
    {
      "id": "ngon-ngu-lap-trinh",
      "prompt": "Code review cho ngôn ngữ lập trình nào?",
      "options": [
        {"id": "python", "label": "Python"},
        {"id": "javascript", "label": "JavaScript/TypeScript"},
        {"id": "java", "label": "Java"},
        {"id": "go", "label": "Go"},
        {"id": "rust", "label": "Rust"},
        {"id": "khac", "label": "Khác (vui lòng nêu rõ)"}
      ]
    },
    {
      "id": "trong-tam-review",
      "prompt": "Bạn muốn review tập trung vào khía cạnh nào?",
      "allow_multiple": true,
      "options": [
        {"id": "bao-mat", "label": "Bảo mật (security vulnerabilities)"},
        {"id": "hieu-nang", "label": "Hiệu năng (performance issues)"},
        {"id": "doc-duoc", "label": "Dễ đọc (code readability)"},
        {"id": "best-practices", "label": "Best practices chuẩn"},
        {"id": "logic", "label": "Logic và tính đúng đắn"}
      ]
    },
    {
      "id": "nen-tang-ai",
      "prompt": "Bạn sẽ dùng AI nào để review?",
      "options": [
        {"id": "claude", "label": "Claude (giỏi lý luận và phân tích)"},
        {"id": "chatgpt", "label": "ChatGPT (đa năng, sáng tạo)"},
        {"id": "gemini", "label": "Gemini (multimodal, ngữ cảnh dài)"}
      ]
    }
  ]
}
```

**User Response:**
```json
{
  "ngon-ngu-lap-trinh": "python",
  "trong-tam-review": ["bao-mat", "hieu-nang"],
  "nen-tang-ai": "claude"
}
```

**Follow-up Round (if needed):**

```json
{
  "questions": [
    {
      "id": "dinh-dang-output",
      "prompt": "Bạn muốn kết quả review ở dạng nào?",
      "options": [
        {"id": "checklist", "label": "Checklist (danh sách kiểm tra)"},
        {"id": "bao-cao-chi-tiet", "label": "Báo cáo chi tiết (detailed report)"},
        {"id": "comment-inline", "label": "Comment trực tiếp trong code"},
        {"id": "tom-tat", "label": "Tóm tắt ngắn gọn (summary)"}
      ]
    }
  ]
}
```

### Cultural Adaptation for Questions

**Principle:** Vietnamese users may prefer different communication styles

**Formal vs Informal:**

**Formal (default):**
```
"Bạn muốn output ở định dạng nào?"
```

**Informal (for learning context):**
```
"Bạn thích output dạng nào nhất?"
```

**With Context (recommended):**
```
"Bạn muốn output ở định dạng nào? (để tôi tối ưu cho phù hợp)"
```

**Polite Phrasing:**

Use "vui lòng" (please) for requests:
- "Vui lòng chọn một trong các option sau"
- "Bạn có thể cho tôi biết..."

**Encouraging Tone:**

Add positive framing:
- "Tuyệt! Giờ tôi cần biết thêm một chút về..."
- "Được rồi! Câu hỏi cuối cùng..."

### Question Quality Checklist (Vietnamese)

**Trước khi hỏi câu hỏi bằng tiếng Việt, check:**

- [ ] **Tự nhiên** - Câu hỏi nghe tự nhiên, không như dịch máy
- [ ] **Rõ ràng** - Người dùng hiểu ngay câu hỏi muốn gì
- [ ] **Options đầy đủ** - Có 3-5 options cover hầu hết cases
- [ ] **Technical terms preserved** - Giữ nguyên thuật ngữ tiếng Anh
- [ ] **Context provided** - Giải thích tại sao hỏi (trong ngoặc)
- [ ] **Culturally appropriate** - Phù hợp với văn hóa Việt Nam

### Troubleshooting Bilingual Questions

**Issue: Vietnamese questions sound unnatural**

**Solution:**
- Review vietnamese-guide.md examples
- Use conversational Vietnamese
- Add context in parentheses
- Test with native Vietnamese speaker

**Issue: User confused by technical terms**

**Solution:**
- Always provide Vietnamese explanation in parentheses
- Example: "API (giao diện lập trình ứng dụng)"
- Add memory tip if term is complex

**Issue: Mixed language answers**

**Solution:**
- Accept both Vietnamese and English answers
- Process based on option ID, not label
- Respond in user's preferred language

---

## Terminology Translation Table

### Core Concepts

| English | Tiếng Việt | Viết Tắt | Giải Thích Ngắn |
|---------|-----------|---------|-----------------|
| Prompt | Prompt / Câu lệnh | - | Chỉ dẫn cho AI |
| Prompt Engineering | Kỹ Thuật Viết Prompt | - | Nghệ thuật tối ưu câu lệnh AI |
| Optimization | Tối Ưu Hóa | - | Làm tốt hơn, hiệu quả hơn |
| Framework | Khung Suy Nghĩ / Framework | - | Cấu trúc để giải quyết vấn đề |
| Chain-of-Thought | Chuỗi Suy Nghĩ | CoT | Suy nghĩ từng bước một |
| Tree-of-Thoughts | Cây Suy Nghĩ | ToT | Khám phá nhiều nhánh giải pháp |
| Graph-of-Thoughts | Đồ Thị Suy Nghĩ | GoT | Mạng lưới suy nghĩ đa chiều |
| Algorithm-of-Thoughts | Thuật Toán Suy Nghĩ | AoT | Cải thiện lặp đi lặp lại |
| Token | Token | - | Đơn vị đo văn bản AI xử lý |
| Context | Ngữ Cảnh | - | Thông tin nền, bối cảnh |
| Constraint | Ràng Buộc | - | Giới hạn, điều kiện bắt buộc |
| Validation | Kiểm Chứng | - | Xác minh tính đúng đắn |
| Role Assignment | Phân Công Vai Trò | - | Chỉ định chuyên môn cho AI |
| Output Format | Định Dạng Đầu Ra | - | Cách trình bày kết quả |

### Reasoning Concepts

| English | Tiếng Việt | Giải Thích |
|---------|-----------|------------|
| Reasoning | Lý Luận / Suy Luận | Quá trình suy nghĩ logic |
| Step-by-step | Từng Bước | Làm tuần tự, không nhảy cóc |
| Branch | Nhánh | Hướng giải quyết khác nhau |
| Node | Nút / Điểm | Thành phần trong hệ thống |
| Iteration | Lặp / Vòng Lặp | Lặp lại để cải thiện |
| Refinement | Tinh Chỉnh | Làm mịn, làm tốt hơn |
| Synthesis | Tổng Hợp | Kết hợp các phần lại |
| Analysis | Phân Tích | Xem xét kỹ càng |
| Trade-off | Đánh Đổi | Ưu/nhược điểm của lựa chọn |
| Feedback Loop | Vòng Phản Hồi | Đầu ra ảnh hưởng đầu vào |

### Quality Metrics

| English | Tiếng Việt | Thang Đo |
|---------|-----------|----------|
| Clarity | Độ Rõ Ràng | 0-100 |
| Specificity | Độ Cụ Thể | 0-100 |
| Effectiveness | Hiệu Quả | 0-100 |
| Token Efficiency | Tiết Kiệm Token | 0-100 |
| Accuracy | Độ Chính Xác | 0-100 |
| Consistency | Tính Nhất Quán | 0-100 |

---

## Cultural Adaptation Strategies

### Vietnamese Learning Preferences

**1. Concrete Examples (Ví Dụ Cụ Thể)**

Vietnamese learners prefer seeing practical examples before theory.

**Strategy:**
- Always provide example BEFORE explanation
- Use familiar scenarios (Vietnamese context when possible)
- Show before/after comparisons

**Example:**
```markdown
❌ Don't start with: "Chain-of-Thought is a prompting technique..."

✅ Do start with:
"Ví dụ: Thay vì hỏi AI 'Giải phương trình này', 
bạn hỏi 'Giải phương trình này từng bước: Bước 1..., Bước 2...'"

Đó là Chain-of-Thought (Chuỗi Suy Nghĩ) - technique này...
```

---

**2. Visual Analogies (Ẩn Dụ Trực Quan)**

Use familiar Vietnamese metaphors and analogies.

**Effective analogies:**

| Concept | Vietnamese Analogy | English Equivalent |
|---------|-------------------|-------------------|
| Chain-of-Thought | Chuỗi hạt (necklace beads) | Chain links |
| Tree-of-Thoughts | Cây quyết định (decision tree) | Branching tree |
| Graph-of-Thoughts | Bản đồ tư duy (mind map) | Network graph |
| Iterative refinement | Mài dao (sharpening knife) | Polish/refine |
| Token budget | Ngân sách chữ (word budget) | Token limit |

**Usage example:**
```markdown
**CoT giống như chuỗi hạt:** Mỗi hạt là một bước suy nghĩ, nối tiếp nhau 
tạo thành chuỗi hoàn chỉnh. Nếu thiếu một hạt, chuỗi không toàn vẹn.
```

---

**3. Step-by-Step Instructions (Hướng Dẫn Chi Tiết)**

Vietnamese learners value detailed, actionable steps.

**Pattern:**
```markdown
## Cách Làm (How To)

**Bước 1:** [Action cụ thể]
- Làm gì
- Làm như thế nào
- Ví dụ

**Bước 2:** [Action tiếp theo]
- Làm gì
- Làm như thế nào
- Ví dụ

**Kết quả:** [Expected outcome]
```

---

**4. "Tại Sao" Explanations (Why It Works)**

Always explain the reasoning behind techniques.

**Pattern:**
```markdown
## [Technique Name]

**Là gì:** [Definition]

**Tại sao hiệu quả:** [Reasoning]

**Khi nào dùng:** [Use cases]

**Cách dùng:** [Instructions]

**Ví dụ:** [Example]
```

---

**5. Common Mistakes Section (Lỗi Thường Gặp)**

Vietnamese learners appreciate knowing what NOT to do.

**Pattern:**
```markdown
### Lỗi Thường Gặp

❌ **Lỗi 1:** [Common mistake]
**Tại sao sai:** [Why it's wrong]
✅ **Sửa:** [Correct approach]

❌ **Lỗi 2:** [Another mistake]
**Tại sao sai:** [Why it's wrong]
✅ **Sửa:** [Correct approach]
```

---

## Memory Tips (Mẹo Ghi Nhớ)

### Mnemonics for Frameworks

**CoT (Chain-of-Thought):**
```
Mẹo nhớ: "Chuỗi" = Chain
→ C-o-T = Chuỗi-ở-Từng bước
→ Làm từng bước như chuỗi hạt
```

**ToT (Tree-of-Thoughts):**
```
Mẹo nhớ: "Tree" = Cây
→ T-o-T = Tree-of-Thoughts = Cây suy nghĩ
→ Cây có nhiều nhánh = nhiều hướng giải quyết
```

**GoT (Graph-of-Thoughts):**
```
Mẹo nhớ: "Graph" = Đồ thị/Bản đồ
→ G-o-T = Graph-of-Thoughts = Đồ thị suy nghĩ
→ Bản đồ tư duy với nhiều liên kết
```

**AoT (Algorithm-of-Thoughts):**
```
Mẹo nhớ: "Algorithm" = Thuật toán
→ A-o-T = Algorithm = Quy trình lặp lại
→ Làm đi làm lại để hoàn thiện (như mài dao)
```

### Foundation Techniques Mnemonic

**R-C-F (Role, Context, Format):**
```
Nhớ: "RồI Cần phải Format" 
R = Role (Vai trò)
C = Context (Ngữ cảnh)
F = Format (Định dạng)
```

### Quality Dimensions Mnemonic

**C-S-E-T (Clarity, Specificity, Effectiveness, Token efficiency):**
```
Nhớ: "Cần Sửa Để Tốt"
C = Clarity (Rõ ràng)
S = Specificity (Cụ thể)
E = Effectiveness (Hiệu quả)
T = Token efficiency (Tiết kiệm)
```

---

## Common Vietnamese Phrases

### Questions Users Might Ask

| Vietnamese Question | English Translation | How to Respond |
|---------------------|---------------------|----------------|
| "Prompt này có tốt không?" | "Is this prompt good?" | Đánh giá 4 chiều: Clarity, Specificity, Effectiveness, Token efficiency |
| "Làm sao để prompt tốt hơn?" | "How to make prompt better?" | Áp dụng Foundation layer trước, sau đó framework nếu cần |
| "Tại sao kết quả AI không như mong muốn?" | "Why is AI output not as expected?" | Kiểm tra: thiếu context? thiếu format? thiếu constraints? |
| "Nên dùng technique nào?" | "Which technique should I use?" | Phụ thuộc vào: loại task, độ phức tạp, token budget |
| "CoT và ToT khác nhau như thế nào?" | "How are CoT and ToT different?" | CoT = 1 đường, ToT = nhiều nhánh |
| "Token là gì?" | "What is token?" | Đơn vị đo text (khoảng 1 token ≈ 4 ký tự tiếng Anh, ≈ 1 từ tiếng Việt) |
| "Platform nào tốt nhất?" | "Which platform is best?" | Claude = phức tạp, ChatGPT = code, Gemini = research |

### Response Templates

**When user asks for optimization:**
```markdown
Tôi sẽ tối ưu prompt này cho bạn!

**Mức độ tối ưu:**
- ⚡ Quick Boost (5-15 phút, cải thiện cơ bản)
- 🔍 Deep Dive (20-45 phút, tối ưu toàn diện)
- 🚀 Revolutionary (45-90 phút, tối ưu tối đa)

Bạn muốn mức nào?
```

**When explaining a framework:**
```markdown
## [Framework Name] ([Tên Tiếng Việt])

**Là gì:**
[Simple Vietnamese explanation]

**Ví dụ thực tế:**
[Concrete example in Vietnamese context]

**Khi nào dùng:**
[Use cases với ví dụ Việt Nam]

**Mẹo nhớ:**
[Vietnamese mnemonic]
```

**When providing before/after:**
```markdown
### Trước Khi Tối Ưu (Before)

```
[Original prompt]
```

**Vấn đề:** [Issues identified]

### Sau Khi Tối Ưu (After)

```
[Optimized prompt]
```

**Cải thiện:** [Improvements made]

**Kết quả dự kiến:** [Expected better outcomes]
```

---

## Translation Guidelines

### DO's

1. **Keep technical terms in English with Vietnamese explanation:**
   ```
   Chain-of-Thought (Chuỗi Suy Nghĩ): [explanation in Vietnamese]
   ```

2. **Use familiar Vietnamese words when good equivalents exist:**
   - "optimize" → "tối ưu hóa" (not "optimize")
   - "context" → "ngữ cảnh" (not "context")
   - "step-by-step" → "từng bước" (not "step-by-step")

3. **Provide both versions for key concepts:**
   ```
   Success criteria / Tiêu chí thành công
   ```

4. **Use Vietnamese sentence structure:**
   ```
   ❌ "Prompt này có clarity tốt."
   ✅ "Prompt này rõ ràng (clarity cao)."
   ```

5. **Include phonetic for difficult English terms:**
   ```
   Token (đọc: "tô-kần")
   ```

### DON'T's

1. **Don't translate names of frameworks as they are proper nouns:**
   ```
   ✅ Chain-of-Thought (Chuỗi Suy Nghĩ)
   ❌ Chuỗi Suy Nghĩ only
   ```

2. **Don't mix English and Vietnamese randomly:**
   ```
   ❌ "Bạn cần add thêm context và specify output format rõ ràng hơn."
   ✅ "Bạn cần thêm ngữ cảnh (context) và chỉ định rõ định dạng đầu ra (output format)."
   ```

3. **Don't over-translate technical jargon:**
   ```
   ✅ "API" (keep as is)
   ❌ "Giao diện lập trình ứng dụng" (too verbose)
   ```

4. **Don't assume Vietnamese readers know English technical terms without explanation:**
   ```
   ❌ "Dùng self-consistency technique."
   ✅ "Dùng self-consistency (kỹ thuật tự kiểm tra tính nhất quán)."
   ```

---

## Vietnamese-Friendly Examples

### Example 1: Simple Task (Nhiệm Vụ Đơn Giản)

**Before / Trước:**
```
Viết code.
```

**After / Sau:**
```
Bạn là lập trình viên Python có 5 năm kinh nghiệm.

Viết hàm Python để:
- Đọc file CSV
- Lọc các dòng có giá trị cột "age" > 18
- Trả về danh sách dictionary

Yêu cầu:
- Có type hints
- Có docstring
- Xử lý lỗi file không tồn tại

Output format: Code Python + ví dụ sử dụng
```

**Giải thích cải thiện:**
- ✅ Thêm vai trò (role assignment)
- ✅ Làm rõ nhiệm vụ (specificity)
- ✅ Thêm yêu cầu cụ thể (constraints)
- ✅ Định dạng đầu ra (format specification)

---

### Example 2: Decision Task (Quyết Định)

**Before / Trước:**
```
Nên dùng database nào?
```

**After / Sau:**
```
Bạn là database architect với 10 năm kinh nghiệm.

Tình huống:
- Xây dựng app quản lý bán hàng
- Dự kiến: 10,000 users, 1M sản phẩm
- Đặc điểm: 80% đọc, 20% ghi
- Đội: Quen với MySQL
- Ngân sách: <$200/tháng
- Hosting: AWS

So sánh 3 lựa chọn:
1. PostgreSQL
2. MySQL
3. MongoDB

Cho mỗi lựa chọn, phân tích:
- Ưu điểm với tình huống này
- Nhược điểm với tình huống này
- Chi phí dự kiến
- Độ khó migration từ MySQL

Cuối cùng: Đề xuất lựa chọn tốt nhất với lý do rõ ràng.
```

**Giải thích cải thiện:**
- ✅ Thêm ngữ cảnh đầy đủ (context provision)
- ✅ Dùng Tree-of-Thoughts (so sánh lựa chọn)
- ✅ Tiêu chí đánh giá cụ thể
- ✅ Yêu cầu giải thích lý do

---

## Vietnamese Optimization Workflow

### Quy Trình Tối Ưu Cho Người Việt

**Bước 1: Phân Loại Task (Task Classification)**

Hỏi bản thân:
- Task này đơn giản hay phức tạp?
- Cần AI làm gì? (giải thích, code, quyết định, phân tích?)
- Có nhiều cách giải quyết không?

**Kết quả:** Chọn mức tối ưu (Quick/Deep/Revolutionary)

---

**Bước 2: Đặt Câu Hỏi (Dialogue)**

5 câu hỏi then chốt:
1. **Mục tiêu:** Thành công là gì?
2. **Đối tượng:** AI trả lời cho ai? (beginner, expert?)
3. **Phạm vi:** Làm gì, không làm gì?
4. **Định dạng:** Muốn output kiểu gì?
5. **Quan trọng:** Điều gì tuyệt đối phải có?

**Kết quả:** Hiểu rõ yêu cầu

---

**Bước 3: Chọn Kỹ Thuật (Blueprint)**

**Nền tảng (Foundation) - Luôn có:**
- [ ] Vai trò chuyên môn (Role)
- [ ] Ngữ cảnh (Context)
- [ ] Định dạng (Format)

**Nâng cao (Advanced) - Nếu phức tạp:**
- [ ] CoT (một đường giải quyết)
- [ ] ToT (nhiều lựa chọn so sánh)
- [ ] GoT (hệ thống phức tạp)
- [ ] AoT (tối ưu dần dần)

**Kiểm chứng (Meta-Cognitive) - Nếu quan trọng:**
- [ ] Self-Correction (tự sửa lỗi)
- [ ] Validation (kiểm tra chất lượng)

---

**Bước 4: Viết Prompt (Synthesis)**

Cấu trúc prompt tốt:

```markdown
[Vai trò chuyên môn]

Ngữ cảnh:
- [Thông tin nền]
- [Tình huống hiện tại]

Nhiệm vụ: [Mô tả rõ ràng]

Yêu cầu:
- [Yêu cầu 1]
- [Yêu cầu 2]

[Framework nếu cần: CoT/ToT/GoT/AoT]

Output format: [Định dạng mong muốn]
```

---

**Bước 5: Kiểm Tra & Cải Thiện (Refinement)**

Tự hỏi:
- [ ] Prompt có rõ ràng không? (Clarity)
- [ ] Có đủ cụ thể không? (Specificity)
- [ ] Có thiếu gì không?
- [ ] Có dư thừa gì không?

Test với AI → Xem kết quả → Sửa nếu cần → Test lại

---

## Quick Reference Card (Thẻ Tham Khảo Nhanh)

### Khi Nào Dùng Framework Nào?

| Tình Huống | Framework | Ví Dụ |
|-----------|-----------|-------|
| Giải thích từng bước | CoT | Giải toán, debug code |
| So sánh lựa chọn | ToT | Chọn database, chọn framework |
| Phân tích hệ thống | GoT | Thiết kế kiến trúc, tối ưu app |
| Cải thiện dần dần | AoT | Tối ưu query, refactor code |

### Checklist Prompt Tốt

- [ ] **Vai trò rõ ràng:** "Bạn là [chuyên gia gì]"
- [ ] **Ngữ cảnh đầy đủ:** Cung cấp thông tin nền
- [ ] **Nhiệm vụ cụ thể:** Không mơ hồ
- [ ] **Yêu cầu rõ ràng:** Must have vs nice to have
- [ ] **Định dạng output:** JSON? Table? Code? Prose?
- [ ] **Ví dụ (nếu cần):** Cho AI xem mẫu

### Lỗi Thường Gặp & Cách Sửa

| Lỗi | Dấu Hiệu | Cách Sửa |
|-----|---------|----------|
| Quá mơ hồ | "Làm cái này tốt hơn" | Định nghĩa "tốt" là gì |
| Thiếu context | AI hỏi lại nhiều | Cung cấp thông tin nền |
| Không có format | Output không nhất quán | Chỉ định rõ format |
| Quá dài dòng | Prompt >3000 từ | Cắt bỏ phần dư thừa |
| Sai framework | Dùng GoT cho task đơn giản | Dùng CoT hoặc không dùng |

---

## Practice Exercises (Bài Tập Thực Hành)

### Bài 1: Cải Thiện Prompt Đơn Giản

**Prompt gốc:**
```
Viết hàm sort.
```

**Nhiệm vụ:** Áp dụng Foundation layer (Role + Context + Format)

<details>
<summary>Gợi ý đáp án</summary>

```
Bạn là lập trình viên Python.

Viết hàm sort một list số nguyên theo thứ tự tăng dần.

Yêu cầu:
- Dùng thuật toán Quick Sort
- Có type hints
- Có docstring
- Có test cases

Output: Code Python hoàn chỉnh
```
</details>

---

### Bài 2: Chọn Framework Phù Hợp

**Tình huống 1:** Debug một bug phức tạp
→ Framework: _______

**Tình huống 2:** Chọn giữa React, Vue, Angular
→ Framework: _______

**Tình huống 3:** Tối ưu performance toàn app
→ Framework: _______

<details>
<summary>Đáp án</summary>

**Tình huống 1:** CoT (debug từng bước)

**Tình huống 2:** ToT (so sánh 3 lựa chọn)

**Tình huống 3:** GoT (phân tích hệ thống) + AoT (tối ưu dần)
</details>

---

### Bài 3: Viết Prompt Hoàn Chỉnh

**Yêu cầu:** Viết prompt yêu cầu AI thiết kế database cho app quản lý thư viện.

**Áp dụng:**
- Foundation layer đầy đủ
- Tree-of-Thoughts (so sánh SQL vs NoSQL)
- Format rõ ràng

<details>
<summary>Gợi ý đáp án</summary>

```
Bạn là database architect với 10 năm kinh nghiệm.

Tình huống:
- App quản lý thư viện trường đại học
- 50,000 sinh viên, 200,000 sách
- Chức năng: Mượn/trả, tìm kiếm, đặt trước, gia hạn
- Team quen với PostgreSQL
- Ngân sách: <$300/tháng
- Cần hỗ trợ full-text search tiếng Việt

So sánh 2 approach:
1. PostgreSQL thuần
2. PostgreSQL + Elasticsearch

Cho mỗi approach, phân tích:
- Schema design
- Ưu điểm
- Nhược điểm
- Chi phí
- Complexity

Đề xuất approach tốt nhất với lý do cụ thể.

Output format:
- Comparison table
- ER diagram (mô tả bằng text)
- Recommended approach
- Implementation guide
```
</details>

---

## Additional Resources

### Vietnamese Learning Materials

**Recommended to create:**
- Video tutorials in Vietnamese
- Step-by-step Vietnamese guides
- Vietnamese-specific examples (Vietnamese business contexts)
- Vietnamese community forum

### English Resources with Vietnamese Notes

**Useful resources:**
- OpenAI Prompt Engineering Guide (có thể đọc kèm guide này)
- Anthropic Claude prompting documentation (áp dụng được với guide này)
- Papers on CoT, ToT, GoT (đọc với terminology table trong guide này)

---

## Summary / Tóm Tắt

**Key Takeaways / Điểm Chính:**

1. **Bilingual support / Hỗ trợ song ngữ:** Có thể dùng tiếng Việt hoặc tiếng Anh
2. **Cultural adaptation / Thích nghi văn hóa:** Dùng ví dụ và ẩn dụ Việt Nam
3. **Progressive learning / Học dần dần:** Từ đơn giản đến phức tạp
4. **Practical focus / Tập trung thực hành:** Nhiều ví dụ cụ thể
5. **Memory aids / Hỗ trợ ghi nhớ:** Mẹo nhớ bằng tiếng Việt

**Next Steps / Bước Tiếp Theo:**

1. Đọc `core-concepts.md` để hiểu 4D methodology
2. Thực hành với `examples/vietnamese/` folder
3. Tham khảo `reasoning-frameworks.md` để hiểu sâu frameworks
4. Áp dụng `optimization-toolkit.md` cho kỹ thuật cụ thể

---

**Document Version:** 1.0.0  
**Last Updated:** 2026-02-05  
**Related:** `core-concepts.md`, `reasoning-frameworks.md`, `optimization-toolkit.md`
