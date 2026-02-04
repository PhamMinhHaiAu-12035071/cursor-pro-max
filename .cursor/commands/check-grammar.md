# Check Grammar - Kiểm Tra Ngữ Pháp Tiếng Anh

Kiểm tra ngữ pháp tiếng Anh với giải thích chi tiết bằng tiếng Việt. Command này tự động kích hoạt grammar-learning skill để sửa lỗi và dạy bạn cách tránh lỗi đó trong tương lai.

## Context

Sử dụng command này khi bạn:
- Viết xong một đoạn tiếng Anh và muốn kiểm tra ngữ pháp
- Không chắc câu tiếng Anh của mình có đúng không
- Muốn hiểu TẠI SAO một cấu trúc sai và cách sửa
- Muốn học ngữ pháp thông qua việc sửa lỗi thực tế của mình
- **[NEW]** Muốn check grammar của prompt trước khi thực hiện task (middleware mode)

Command này không chỉ sửa lỗi mà còn **dạy bạn ngữ pháp** qua giải thích chi tiết bằng tiếng Việt tự nhiên, dễ hiểu.

**[NEW] Middleware Mode**: Nếu input chứa task/yêu cầu cụ thể (như "help me review file..."), command sẽ tự động thực hiện task sau khi check grammar xong, KHÔNG cần hỏi lại.

## Requirements

- Input phải là **text tiếng Anh** (không phải tiếng Việt)
- Text có thể ngắn (1 câu) hoặc dài (nhiều câu)
- Command sẽ tự động đọc và áp dụng grammar-learning skill
- Giải thích sẽ bằng **tiếng Việt** để dễ hiểu

## Input

Gõ text cần kiểm tra ngay sau command, cách nhau bởi khoảng trắng:

```
/check-grammar [your English text here]
```

**Ví dụ (Grammar only)**:
```
/check-grammar She go to school yesterday
```

**Ví dụ (Middleware - with task)**:
```
/check-grammar Help me read file X and analyze whether it follow best practices
```
→ Sẽ check grammar TRƯỚC, sau đó TỰ ĐỘNG đọc và analyze file X

## Process

Khi command được gọi, AI sẽ thực hiện 5 bước sau:

### Bước 1: Đọc Grammar Learning Skill

AI sẽ tự động đọc và áp dụng các quy tắc từ:
- `@.cursor/skills/grammar-learning/SKILL.md` - Workflow chính
- `@.cursor/skills/grammar-learning/references/grammar-rules.md` - Chi tiết quy tắc ngữ pháp
- `@.cursor/skills/grammar-learning/references/common-mistakes-vn.md` - Lỗi phổ biến của người Việt
- `@.cursor/skills/grammar-learning/references/vietnamese-writing-style.md` - Cách viết tiếng Việt tự nhiên

### Bước 2: Phân Tích Input

Phân tích text để tìm các lỗi ngữ pháp, phân loại theo:
- Subject-Verb Agreement (Hòa hợp chủ-vị)
- Tense Errors (Lỗi thì)
- Article Usage (Mạo từ a/an/the)
- Preposition Errors (Giới từ)
- Word Form (Dạng từ)
- Pronoun Errors (Đại từ)
- Pluralization/Countable vs Uncountable (Danh từ đếm được/không đếm được)
- Sentence Structure (Cấu trúc câu)
- Confusing Words (Từ dễ nhầm lẫn)

### Bước 3: Tạo Câu Đã Sửa

Tạo phiên bản đã sửa tất cả lỗi ngữ pháp, giữ nguyên ý nghĩa và phong cách gốc.

### Bước 4: Tạo Bảng Tóm Tắt Lỗi

Liệt kê tất cả lỗi trong bảng rõ ràng với 4 cột:
- Số thứ tự
- Lỗi gốc
- Sửa thành
- Loại lỗi

### Bước 5: Giải Thích Chi Tiết Bằng Tiếng Việt

Cho mỗi lỗi, giải thích:
1. **Quy tắc** - Quy tắc ngữ pháp bị vi phạm
2. **Tại sao sai** - Lý do phần gốc không đúng
3. **Ví dụ thêm** - Các ví dụ khác để củng cố
4. **Mẹo nhớ** - Mẹo ghi nhớ để tránh lỗi này

### Bước 6: Nhận Diện Pattern (Nếu Có)

Nếu cùng một loại lỗi xuất hiện 3+ lần, AI sẽ:
- Chỉ ra pattern này
- Đưa ra giải thích tổng hợp
- Gợi ý bài tập hoặc mảng cần tập trung

---

### Bước 7: Phát Hiện Task (NEW - Middleware Logic)

Sau khi check grammar xong, AI sẽ phân tích xem input có chứa **task/yêu cầu** không.

**Task Detection Logic**:
- Tìm action verbs: help, read, review, check, analyze, create, fix, explain, show, etc.
- Tìm objects: file references, specific requests, actionable items
- Nếu phát hiện task → Chuyển sang Bước 8
- Nếu KHÔNG có task → Dừng lại (pure grammar practice)

**Ví dụ có task**:
- "Help me read file global_rule markdown review..." → Task: review file
- "Check whether code follows best practices" → Task: check code
- "Analyze this function performance" → Task: analyze function

**Ví dụ KHÔNG có task** (grammar practice only):
- "She go to school yesterday" → Pure grammar practice
- "I am student" → No action requested
- "This is beauty" → Statement only

---

### Bước 8: Tự Động Thực Hiện Task (NEW - Auto-execution)

Nếu Bước 7 phát hiện task, AI sẽ:

1. **Hiển thị separator rõ ràng**:
```markdown

---

## 🔄 Tiếp tục thực hiện task đã được sửa ngữ pháp...

**🎯 Detected Task**: [Brief description of the task]

**⚙️ Task Execution**:
```

2. **Tự động thực hiện task** với câu đã được sửa ngữ pháp (không hỏi lại user)

3. **Xử lý lỗi gracefully**: Nếu task execution fail, vẫn giữ nguyên grammar correction ở trên và báo lỗi rõ ràng

**Lưu ý quan trọng**:
- Grammar correction LUÔN được hiển thị đầy đủ trước khi thực hiện task
- Task detection là conservative (yêu cầu 2+ indicators để tránh false positive)
- Nếu không chắc có task hay không → Coi như không có task (grammar-only mode)

## Output Format

Output sẽ được format theo cấu trúc chuẩn sau:

```markdown
## ✅ Câu đã sửa

[Text đã được sửa tất cả lỗi ngữ pháp]

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | [error] | [correction] | [error type] |
| 2 | [error] | [correction] | [error type] |

## 📚 Giải thích chi tiết

### Lỗi 1: [Tên loại lỗi bằng tiếng Việt]

**Sai**: [incorrect phrase]
**Đúng**: [correct phrase]

**Quy tắc**:
[Giải thích quy tắc ngữ pháp bằng tiếng Việt tự nhiên]

**Ví dụ thêm**:
- ❌ [incorrect example]
- ✅ [correct example]

**Mẹo nhớ**: [Memory trick bằng tiếng Việt]

---

[Lặp lại cho mỗi lỗi]

## 💡 Gợi ý học tập

[Nếu phát hiện pattern: gợi ý mảng cần tập trung]
```

## Examples

### Example 1: Lỗi Đơn Giản (Subject-Verb Agreement)

**Input**:
```
/check-grammar She go to school every day
```

**Expected Output**:

## ✅ Câu đã sửa

She goes to school every day.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | She go | She goes | Hòa hợp chủ-vị |

## 📚 Giải thích chi tiết

### Lỗi 1: Hòa hợp chủ-vị (Subject-Verb Agreement)

**Sai**: She go to school
**Đúng**: She goes to school

**Quy tắc**:
Trong thì hiện tại đơn, động từ phải thêm -s/-es khi chủ ngữ là ngôi thứ 3 số ít (he, she, it). "She" là ngôi thứ 3 số ít nên động từ "go" phải thêm "-es" thành "goes".

**Ví dụ thêm**:
- ❌ He play football.
- ✅ He plays football.
- ❌ It work well.
- ✅ It works well.

**Mẹo nhớ**: "He/She/It = động từ thêm S"

---

### Example 2: Nhiều Loại Lỗi

**Input**:
```
/check-grammar I am student and I like play football because football is very beauty sport
```

**Expected Output**:

## ✅ Câu đã sửa

I am a student and I like to play football because football is a very beautiful sport.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | I am student | I am a student | Thiếu mạo từ |
| 2 | like play | like to play | Thiếu "to" |
| 3 | is very beauty sport | is a very beautiful sport | Dạng từ + Thiếu mạo từ |

## 📚 Giải thích chi tiết

### Lỗi 1: Thiếu mạo từ

**Sai**: I am student
**Đúng**: I am a student

**Quy tắc**:
Danh từ số ít đếm được (như "student") phải có mạo từ (a/an/the) đứng trước. Vì đang nói chung chung về nghề nghiệp, ta dùng "a".

**Tại sao người Việt hay quên**:
Tiếng Việt không có mạo từ. Ta nói "Tôi là sinh viên" mà không cần "một".

**Ví dụ thêm**:
- ❌ She is teacher.
- ✅ She is a teacher.
- ❌ He bought car.
- ✅ He bought a car.

**Mẹo nhớ**: "Danh từ số ít đếm được = phải có a/an hoặc the"

---

### Lỗi 2: Thiếu "to" sau động từ

**Sai**: I like play football
**Đúng**: I like to play football

**Quy tắc**:
Sau động từ "like", nếu theo sau là động từ khác, ta dùng cấu trúc "like + to + verb" hoặc "like + verb-ing". Cả hai đều đúng:
- I like to play football. ✅
- I like playing football. ✅

**Ví dụ thêm**:
- ❌ I want go home.
- ✅ I want to go home.
- ❌ She decided leave.
- ✅ She decided to leave.

**Mẹo nhớ**: "Want, need, decide, plan, hope + TO + verb"

---

### Lỗi 3: Dạng từ sai + Thiếu mạo từ

**Sai**: is very beauty sport
**Đúng**: is a very beautiful sport

**Quy tắc**:
1. Sau động từ "be" (is, am, are) phải dùng **tính từ**, không phải danh từ:
   - "beauty" = danh từ (sự đẹp)
   - "beautiful" = tính từ (đẹp)
2. "Sport" là danh từ số ít đếm được → cần mạo từ "a"

**Ví dụ thêm**:
- ❌ This is excite movie.
- ✅ This is an exciting movie.
- ❌ She is success.
- ✅ She is successful.

**Mẹo nhớ**: "Sau BE phải là tính từ"

---

### Example 3: Pattern Detection (3+ Lỗi Giống Nhau)

**Input**:
```
/check-grammar I am student. I have friend. I live in house near school. I want be doctor.
```

**Expected Output**:

## ✅ Câu đã sửa

I am a student. I have a friend. I live in a house near a school. I want to be a doctor.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | I am student | I am a student | Thiếu mạo từ |
| 2 | I have friend | I have a friend | Thiếu mạo từ |
| 3 | in house near school | in a house near a school | Thiếu mạo từ |
| 4 | want be | want to be | Thiếu "to" |
| 5 | be doctor | be a doctor | Thiếu mạo từ |

## 📚 Giải thích chi tiết

### Lỗi 1, 2, 3, 5: Thiếu mạo từ (Articles)

**Pattern phát hiện**: Bạn quên mạo từ "a/an" trong tất cả các trường hợp có danh từ số ít đếm được.

**Quy tắc chung**:
Danh từ số ít đếm được (student, friend, house, school, doctor) **BẮT BUỘC** phải có mạo từ:
- Dùng "a/an" khi nói chung chung (lần đầu nhắc đến)
- Dùng "the" khi cả người nói và người nghe đều biết đang nói về cái gì cụ thể

**Tại sao người Việt hay mắc lỗi này**:
Tiếng Việt KHÔNG có hệ thống mạo từ. Chúng ta nói "Tôi là sinh viên", "Tôi có bạn", "Tôi sống trong nhà" mà không cần thêm "một" hay "cái" trước danh từ. Nhưng tiếng Anh bắt buộc phải có!

**Ví dụ thêm**:
- ❌ I need pen. → ✅ I need a pen.
- ❌ She bought book. → ✅ She bought a book.
- ❌ He is engineer. → ✅ He is an engineer.

**Mẹo nhớ**: 
"Mỗi khi viết danh từ số ít đếm được, hãy tự hỏi: Đã có a/an/the chưa?"

---

### Lỗi 4: Thiếu "to" sau "want"

**Sai**: I want be a doctor
**Đúng**: I want to be a doctor

**Quy tắc**:
Động từ "want" bắt buộc phải theo sau bởi "to + verb":
- want **to** go
- want **to** be
- want **to** study

**Ví dụ thêm**:
- ❌ I want learn English. → ✅ I want to learn English.
- ❌ She wants become famous. → ✅ She wants to become famous.

**Mẹo nhớ**: "Want + TO + động từ"

---

## 💡 Gợi ý học tập

**Nhận xét**: Bạn có xu hướng **quên mạo từ "a/an/the"**. Đây là lỗi RẤT phổ biến của người Việt vì tiếng Việt không có mạo từ.

**Gợi ý**:
1. Mỗi khi viết danh từ số ít đếm được, hãy dừng lại 1 giây và hỏi: "Có cần a/an/the không?"
2. Quy tắc đơn giản: **Danh từ số ít đếm được = phải có mạo từ**
3. Thực hành: Viết 10 câu với danh từ số ít và nhớ thêm a/an trước mỗi từ
4. Đọc nhiều tiếng Anh để não bạn quen với pattern này

**Bài tập gợi ý**: Sửa các câu sau
- I am teacher.
- She has cat.
- He wants buy car.
- This is good book.

---

## Examples (Middleware Mode)

### Example 4: Task Detection & Auto-execution

**Input**:
```
/check-grammar Help me read file global_rule markdown review it's follow best practice rule 10/10 production ready or not? report help me
```

**Expected Output**:

## ✅ Câu đã sửa

Help me read the global_rule markdown file and review whether it follows best practice rules. Is it 10/10 production-ready or not? Please give me a report.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | file global_rule markdown | the global_rule markdown file | Thiếu mạo từ + Thứ tự từ |
| 2 | it's follow | it follows | Nhầm "it's" với "its" + Hòa hợp chủ-vị |
| 3 | best practice rule | best practice rules | Số nhiều |
| 4 | 10/10 production ready | 10/10 production-ready | Dấu gạch nối |
| 5 | report help me | Please give me a report | Cấu trúc câu |

## 📚 Giải thích chi tiết

### Lỗi 1: Thiếu mạo từ + Thứ tự từ sai

**Sai**: file global_rule markdown
**Đúng**: the global_rule markdown file

**Quy tắc**:
1. Danh từ cụ thể (tên file) cần mạo từ "the"
2. Thứ tự từ trong tiếng Anh: tính từ/modifier trước + danh từ sau ("markdown" mô tả loại file)

**Ví dụ thêm**:
- ❌ document project plan → ✅ the project plan document
- ❌ folder source code → ✅ the source code folder

**Mẹo nhớ**: "The + [tên cụ thể] + [loại]"

---

### Lỗi 2: Nhầm "it's" với "its" + Sai hòa hợp chủ-vị

**Sai**: it's follow
**Đúng**: it follows

**Quy tắc**:
1. "it's" = "it is" hoặc "it has" (viết tắt)
2. "its" = của nó (possessive)
3. Trong câu hỏi "whether it follows", cần động từ chia theo ngôi thứ 3 số ít

**Ví dụ thêm**:
- ❌ it's color is red → ✅ its color is red
- ❌ Check if it work → ✅ Check if it works

**Mẹo nhớ**: "It's = It is | Its = của nó"

---

### Lỗi 3: Số nhiều

**Sai**: best practice rule
**Đúng**: best practice rules

**Quy tắc**:
"Rules" (nhiều quy tắc) nên dùng số nhiều. Trong context này đang nói về nhiều best practices, không phải 1 quy tắc duy nhất.

---

### Lỗi 4: Dấu gạch nối trong tính từ ghép

**Sai**: production ready
**Đúng**: production-ready

**Quy tắc**:
Khi hai từ kết hợp thành một tính từ đứng trước danh từ, cần dấu gạch nối (-).

**Ví dụ thêm**:
- ❌ well known fact → ✅ well-known fact
- ❌ high quality code → ✅ high-quality code

**Mẹo nhớ**: Tính từ ghép trước danh từ = cần dấu gạch nối

---

### Lỗi 5: Cấu trúc câu không rõ ràng

**Sai**: report help me
**Đúng**: Please give me a report

**Quy tắc**:
"Report help me" không phải cấu trúc câu hợp lệ. Cần động từ rõ ràng: "give me", "provide me", "show me" + object.

**Ví dụ thêm**:
- ❌ answer help me → ✅ Please give me an answer
- ❌ explanation help me → ✅ Please provide me with an explanation

---

## 💡 Gợi ý học tập

**Nhận xét**: Bạn có xu hướng viết theo cấu trúc tiếng Việt (mạo từ, thứ tự từ). Hãy chú ý:
1. Mạo từ "the" cho danh từ cụ thể
2. Thứ tự từ: modifier + noun
3. It's vs Its
4. Tính từ ghép cần dấu gạch nối

---

## 🔄 Tiếp tục thực hiện task đã được sửa ngữ pháp...

**🎯 Detected Task**: Review the GLOBAL_RULE.md file for best practices compliance and production readiness

**⚙️ Task Execution**:

[AI would now automatically proceed to read and review the GLOBAL_RULE.md file, providing comprehensive analysis of whether it follows best practices and is production-ready, without asking for confirmation]

---

### Example 5: Grammar Only (No Task Detected)

**Input**:
```
/check-grammar She go to school yesterday
```

**Expected Output**:

## ✅ Câu đã sửa

She went to school yesterday.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | She go | She went | Lỗi thì (Past tense) |

## 📚 Giải thích chi tiết

### Lỗi 1: Lỗi thì (Tense Error)

**Sai**: She go to school yesterday
**Đúng**: She went to school yesterday

**Quy tắc**:
Khi có "yesterday" (hôm qua) trong câu, động từ phải chia ở thì quá khứ đơn (Simple Past). "Go" là hiện tại, "went" là quá khứ.

**Ví dụ thêm**:
- ❌ I see him yesterday. → ✅ I saw him yesterday.
- ❌ They eat pizza last night. → ✅ They ate pizza last night.

**Mẹo nhớ**: "Yesterday, last week, ago = Past tense"

---

**[NO TASK EXECUTION - Command stops cleanly here because no task was detected]**

---

### Example 6: Complex Task with Multiple Actions

**Input**:
```
/check-grammar Can you help me analyze code performance and give suggestion for optimization?
```

**Expected Output**:

## ✅ Câu đã sửa

Can you help me analyze code performance and give suggestions for optimization?

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | give suggestion | give suggestions | Số nhiều |

## 📚 Giải thích chi tiết

### Lỗi 1: Danh từ đếm được số nhiều

**Sai**: give suggestion for optimization
**Đúng**: give suggestions for optimization

**Quy tắc**:
Khi nói chung chung về "gợi ý" (không chỉ 1 gợi ý cụ thể), nên dùng số nhiều "suggestions". Nếu muốn dùng số ít, cần thêm mạo từ: "give a suggestion" hoặc "give one suggestion".

**Ví dụ thêm**:
- ❌ I have question → ✅ I have questions / I have a question
- ❌ Give me advice (advice không đếm được - đúng) ✅
- ❌ Give me recommendation → ✅ Give me recommendations / Give me a recommendation

**Mẹo nhớ**: Danh từ đếm được số ít = phải có a/an/the HOẶC dùng số nhiều

---

## 🔄 Tiếp tục thực hiện task đã được sửa ngữ pháp...

**🎯 Detected Task**: Analyze code performance and provide optimization suggestions

**⚙️ Task Execution**:

[AI would now automatically proceed to:
1. Ask which code file/section to analyze (if not specified)
2. Analyze the code performance
3. Provide concrete optimization suggestions
All without asking "Do you want me to do this?"]

---

## Error Handling

### Trường Hợp 1: Không Nhập Text

**Input**: `/check-grammar`

**Output**: 
```
⚠️ **Thiếu Text Input**

Vui lòng nhập text tiếng Anh cần kiểm tra ngay sau `/check-grammar`

**Ví dụ đúng**:
```
/check-grammar She go to school yesterday
```

**Lưu ý**: Text phải ở cùng dòng với command, cách nhau bởi khoảng trắng.
```

---

### Trường Hợp 2: Text Là Tiếng Việt

**Input**: `/check-grammar Tôi đi học hôm qua`

**Output**:
```
⚠️ **Language Detection Error**

Command này dùng để kiểm tra ngữ pháp **tiếng Anh**, không phải tiếng Việt.

**Phát hiện**: Text của bạn có vẻ là tiếng Việt.

**Giải pháp**:
- ✍️ Nếu muốn check ngữ pháp: Vui lòng nhập text **tiếng Anh**
- 🔄 Nếu muốn dịch từ tiếng Việt sang tiếng Anh: Nói rõ "Dịch sang tiếng Anh: [text]"

**Ví dụ đúng**:
```
/check-grammar I went to school yesterday
```
```

---

### Trường Hợp 3: Text Đúng Ngữ Pháp

**Input**: `/check-grammar I have been studying English for three years.`

**Output**:

## ✅ Câu đã sửa

I have been studying English for three years.

*(Không có lỗi ngữ pháp)*

## 📝 Nhận xét

Tuyệt vời! Câu của bạn đã đúng ngữ pháp! Một vài điểm hay:

1. **Present perfect continuous** (have been studying) dùng đúng với "for three years" để diễn tả hành động bắt đầu trong quá khứ và tiếp tục đến hiện tại
2. Cấu trúc câu rõ ràng, mạch lạc

Tiếp tục phát huy! 🎉

---

### Trường Hợp 4: Text Rất Ngắn (< 3 Từ)

**Input**: `/check-grammar He go`

**Output**:

## ✅ Câu đã sửa

He goes.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | He go | He goes | Hòa hợp chủ-vị |

## 📚 Giải thích chi tiết

[Giải thích như bình thường]

---

💡 **Lưu ý về Text Ngắn**

Text của bạn khá ngắn (< 3 từ). Nếu cung cấp câu đầy đủ hơn với context, tôi có thể:
- ✅ Kiểm tra chính xác hơn (ví dụ: thì nào đang được dùng)
- ✅ Phát hiện thêm lỗi về cấu trúc câu
- ✅ Đưa ra giải thích phù hợp với ngữ cảnh

**Ví dụ tốt hơn**: "He goes to school every day" (thay vì chỉ "He go")

---

### Trường Hợp 5: Ambiguous Task Detection (NEW - Middleware Mode)

**Scenario**: Text có thể là task hoặc grammar practice, không rõ ràng

**Input**: `/check-grammar I need check grammar`

**Output**:

## ✅ Câu đã sửa

I need to check grammar.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | need check | need to check | Thiếu "to" |

## 📚 Giải thích chi tiết

[Full explanation as usual...]

---

⚠️ **Task Detection Uncertainty**

Text của bạn không rõ ràng về ý định:
- 🤔 Có thể là: Statement thực hành ngữ pháp (grammar practice)
- 🤔 Có thể là: Request thực hiện task (middleware mode)

**Quyết định**: Coi như **grammar practice only** (không tự động execute task)

💡 **Gợi ý**: Nếu muốn AI thực hiện task, hãy diễn đạt rõ ràng hơn:
- ✅ "Help me check the grammar of this file" (clear task)
- ✅ "Please review the grammar rules" (clear task)
- ✅ "Check whether the code follows grammar rules" (clear task)

---

### Trường Hợp 6: Task Execution Fails (NEW - Middleware Mode)

**Scenario**: Grammar checked successfully, but task execution encounters error

**Input**: `/check-grammar Help me read file_that_doesnt_exist.txt`

**Output**:

## ✅ Câu đã sửa

Help me read the file_that_doesnt_exist.txt file.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | read file_that_doesnt_exist.txt | read the file_that_doesnt_exist.txt file | Thiếu mạo từ + Thêm "file" |

## 📚 Giải thích chi tiết

[Full explanation as usual...]

---

## 🔄 Tiếp tục thực hiện task đã được sửa ngữ pháp...

**🎯 Detected Task**: Read the file_that_doesnt_exist.txt file

**⚙️ Task Execution**:

❌ **Task Execution Error**: File not found: `/path/to/file_that_doesnt_exist.txt`

---

💡 **Lưu ý quan trọng**: Grammar correction ở trên vẫn hoàn toàn chính xác và hữu ích. Task execution thất bại vì file không tồn tại trong workspace hiện tại.

**🔧 Bạn có thể**:
1. ✅ Kiểm tra lại tên file và thử lại với đường dẫn chính xác
2. 📂 Liệt kê các file hiện có: `ls` hoặc hỏi "What files are in this directory?"
3. 🔍 Tìm file bằng pattern: `find . -name "*partial_name*"`
4. 📚 Hoặc chỉ tham khảo grammar corrections ở trên để học ngữ pháp

---

### Trường Hợp 7: Vague Task Reference (NEW - Middleware Mode)

**Scenario**: Task được detect nhưng thiếu context cần thiết để execute

**Input**: `/check-grammar Help me check this`

**Output**:

## ✅ Câu đã sửa

Help me check this.

*(Không có lỗi ngữ pháp)*

---

## 🔄 Tiếp tục thực hiện task đã được sửa ngữ pháp...

**🎯 Detected Task**: Check something (reference unclear)

**⚙️ Task Execution**:

⚠️ **Task Context Missing**

Task được phát hiện nhưng reference không rõ ràng: "this" chưa được định nghĩa.

**🤔 Cần thêm thông tin**:
- "This" đang chỉ cái gì? (file, code, document, etc.)
- Check theo tiêu chí nào? (grammar, best practices, errors, performance, etc.)

**✅ Ví dụ request rõ ràng hơn**:
- "Help me check the GLOBAL_RULE.md file for best practices"
- "Help me check this function for performance issues"
- "Help me check whether this code follows coding standards"

**💡 Tôi có thể giúp gì tiếp theo?**
Hãy cung cấp thêm context và tôi sẽ thực hiện task cho bạn!

---

## Troubleshooting Guide

### 🔧 Middleware Mode Issues

#### Issue 1: Task không được execute tự động

**Triệu chứng**: Grammar được check nhưng task không tự động chạy

**Nguyên nhân có thể**:
- Input không chứa action verb rõ ràng
- Task reference quá mơ hồ (low confidence detection)
- Câu là statement thay vì request/imperative

**Giải pháp**:
```
❌ Không rõ: "I need check file"
✅ Rõ ràng: "Help me check the file"
✅ Rõ ràng: "Please review the GLOBAL_RULE.md file"
```

---

#### Issue 2: Task được execute nhưng không phải ý muốn

**Triệu chứng**: AI tự động làm task bạn chỉ muốn check grammar

**Nguyên nhân**: Text chứa action verb + object → Bị nhận dạng là task

**Giải pháp**: Nếu chỉ muốn check grammar, không phải execute:
```
❌ Sẽ execute: "Help me read file X"
✅ Grammar only: "I want help read file X" (statement, not imperative)
✅ Grammar only: "She need check code" (3rd person, not request)
```

Hoặc nói rõ: "Check grammar only: [your text]"

---

#### Issue 3: Task execution error nhưng không hiểu tại sao

**Triệu chứng**: Task được detect và chạy nhưng báo lỗi

**Các lỗi phổ biến**:
- 📂 **File not found**: Tên file sai hoặc file không tồn tại
- 🔒 **Permission denied**: Không có quyền truy cập file/directory
- ⚠️ **Missing context**: Reference "this/that" không rõ ràng
- 🔌 **Dependency missing**: Task cần tool/package chưa cài

**Giải pháp**:
1. Đọc kỹ error message (có gợi ý cụ thể)
2. Kiểm tra file path với `ls` hoặc `find`
3. Cung cấp context rõ ràng hơn
4. Thử lại với absolute path thay vì relative path

---

#### Issue 4: Grammar correction sai hoặc thiếu

**Triệu chứng**: Bạn nghĩ có lỗi nhưng AI không phát hiện

**Nguyên nhân có thể**:
- Lỗi nằm ở level phong cách (style), không phải grammar
- Text quá ngắn, thiếu context
- Cấu trúc đúng ngữ pháp nhưng không tự nhiên

**Giải pháp**:
- Cung cấp câu đầy đủ hơn với context
- Hỏi thêm: "Is this sentence natural?" để check style
- Nhớ: Command CHỈ check grammar, không check style/word choice

---

### 🎯 General Issues

#### Issue 5: Command không phản hồi hoặc báo lỗi lạ

**Checklist khắc phục**:
- [ ] Text có nhập sau `/check-grammar` không? (cùng dòng)
- [ ] Text có phải tiếng Anh không? (không phải tiếng Việt)
- [ ] Text có ký tự đặc biệt lạ không? (emoji, ký tự unicode phức tạp)
- [ ] Text có quá dài không? (> 500 từ → chia nhỏ ra)

---

## Common Pitfalls

### Lỗi 1: Quên Nhập Text Sau Command

❌ **Sai**:
```
/check-grammar
[Sau đó mới paste text ở dòng khác]
```

✅ **Đúng**:
```
/check-grammar [text ngay sau command, cùng dòng]
```

**Lý do**: Command cần text ở cùng dòng để parse đúng.

---

### Lỗi 2: Nhầm Tưởng Đây Là Dịch Thuật

❌ **Sai**: Kỳ vọng command sẽ dịch tiếng Việt sang tiếng Anh

✅ **Đúng**: Command này CHỈ kiểm tra ngữ pháp tiếng Anh đã có sẵn, KHÔNG dịch

**Giải pháp**: Nếu muốn dịch, nói rõ: "Dịch sang tiếng Anh: [text tiếng Việt]"

---

### Lỗi 3: Paste Text Quá Dài (> 200 Từ)

❌ **Sai**: Paste cả đoạn văn dài (nhiều đoạn, nhiều chủ đề)

✅ **Đúng**: Chia nhỏ thành các đoạn ngắn hơn (1-3 câu mỗi lần) để giải thích rõ ràng hơn

**Lý do**: Giải thích chi tiết cho text quá dài sẽ rất dài và khó theo dõi.

---

### Lỗi 4: Mong Chờ Sửa Phong Cách Viết

❌ **Sai**: Kỳ vọng command sẽ paraphrase, cải thiện phong cách, làm "đẹp" câu văn

✅ **Đúng**: Command CHỈ sửa **ngữ pháp**, không thay đổi style hay word choice

**Ví dụ**:
- Input: "The movie was good" → Output: "The movie was good" (đúng ngữ pháp rồi, không đổi)
- Không đổi thành: "The movie was excellent" (đổi từ vựng - không phải nhiệm vụ của command này)

---

## FAQ - Comprehensive Guide

### 📋 General Questions

#### Q1: Command này dùng để làm gì?

**A**: Command có **2 chức năng chính**:
1. **Grammar Checking** (primary): Check và sửa lỗi ngữ pháp tiếng Anh với giải thích chi tiết bằng tiếng Việt
2. **Middleware Mode** (secondary): Tự động thực hiện task sau khi check grammar (nếu input chứa task)

**Mục tiêu chính**: Giúp người Việt học ngữ pháp tiếng Anh thông qua việc sửa lỗi thực tế

---

#### Q2: Tôi có thể check grammar cho text dài bao nhiêu?

**A**: 
- ✅ **Tối ưu**: 1-5 câu (20-100 từ) → Giải thích chi tiết, dễ theo dõi
- ⚠️ **Chấp nhận được**: Đến 200 từ → Vẫn OK nhưng giải thích sẽ dài
- ❌ **Không khuyến khích**: > 200 từ → Quá dài, khó học

**Gợi ý**: Chia text dài thành nhiều lần check để học hiệu quả hơn

---

#### Q3: Command có thể dịch tiếng Việt sang tiếng Anh không?

**A**: KHÔNG. Command này CHỈ check grammar của text tiếng Anh đã có sẵn.

**Nếu muốn dịch**: Nói rõ "Dịch sang tiếng Anh: [text tiếng Việt]" hoặc dùng tool dịch khác

---

#### Q4: Command có sửa phong cách viết (style) không?

**A**: KHÔNG. Command CHỈ sửa **ngữ pháp** (grammar), không thay đổi:
- Word choice (chọn từ)
- Sentence style (phong cách câu)
- Tone (giọng văn)
- Formality level (trang trọng hay thân mật)

**Ví dụ**:
- Input: "The movie was good" → Output: "The movie was good" ✅ (đúng grammar rồi)
- KHÔNG đổi thành: "The movie was excellent" (đổi từ vựng)

---

### 🔄 Middleware Mode Questions

#### Q5: Khi nào command tự động thực hiện task?

**A**: Khi input đáp ứng **cả 2 điều kiện**:
1. Có **action verb** (help, read, review, check, analyze, create, etc.)
2. Có **object/target** rõ ràng (file, code, document, function, etc.)

**Ví dụ Auto-execute**:
- ✅ "Help me read file X" → Action: help, read | Object: file X
- ✅ "Check whether code follows best practices" → Action: check | Object: code
- ✅ "Review the document" → Action: review | Object: the document
- ✅ "Can you analyze this function?" → Action: analyze | Object: this function

**Ví dụ Grammar Only** (không auto-execute):
- ❌ "She go to school" → Statement, không phải request
- ❌ "I am student" → No action verb + object
- ❌ "I need help" → Quá mơ hồ, không có specific object

---

#### Q6: Làm sao để CHỈ check grammar mà không execute task?

**A**: Có 3 cách:

**Cách 1**: Viết dưới dạng statement (không phải imperative)
```
❌ Sẽ execute: "Help me read file X"
✅ Grammar only: "I want help read file X" (statement)
```

**Cách 2**: Dùng ngôi thứ 3
```
❌ Sẽ execute: "Check this code"
✅ Grammar only: "She need check code" (3rd person)
```

**Cách 3**: Nói rõ ý định
```
✅ "Check grammar only: Help me read file X"
```

---

#### Q7: Task execution fail thì sao?

**A**: **Grammar correction vẫn hoàn toàn valid!** Task execution fail không ảnh hưởng đến grammar output.

**Bạn sẽ nhận được**:
- ✅ Full grammar correction (như bình thường)
- ⚠️ Error message rõ ràng về task execution
- 💡 Gợi ý cách khắc phục (fix path, add context, etc.)
- 📚 Có thể tham khảo grammar corrections để học

**Lợi ích**: Dù task fail, bạn vẫn học được ngữ pháp!

---

#### Q8: Nếu grammar perfect nhưng có task, có execute không?

**A**: **CÓ!** Task detection độc lập với grammar checking.

**Ví dụ**:

**Input**: `/check-grammar Help me review the GLOBAL_RULE.md file`

**Output**:
```
## ✅ Câu đã sửa

Help me review the GLOBAL_RULE.md file.

*(Không có lỗi ngữ pháp)*

## 📝 Nhận xét

Tuyệt vời! Câu của bạn đã đúng ngữ pháp! 🎉

---

## 🔄 Tiếp tục thực hiện task đã được sửa ngữ pháp...

[Task execution proceeds normally]
```

---

#### Q9: Command có thể detect task bằng tiếng Việt không?

**A**: **KHÔNG**. Command chỉ detect task trong text **tiếng Anh**.

**Nếu input tiếng Việt**: Sẽ nhận warning về language detection và không proceed (xem Error Handling section)

---

#### Q10: Task detection có bao giờ sai không?

**A**: **Có thể**, nhưng hiếm. Command sử dụng **conservative detection** (cẩn thận):
- **False Negative** (có task nhưng không detect): Có thể xảy ra nếu text mơ hồ → Safe, vẫn có grammar correction
- **False Positive** (không có task nhưng bị detect): Rất hiếm vì cần 2+ indicators

**Nếu gặp false positive**: Report để cải thiện algorithm!

---

### 🎓 Learning Questions

#### Q11: Tại sao giải thích bằng tiếng Việt?

**A**: Command được thiết kế cho **người Việt học tiếng Anh**:
- 🇻🇳 Giải thích bằng tiếng Việt → Dễ hiểu hơn
- 🎯 Tập trung vào lỗi phổ biến của người Việt
- 📚 Phong cách giảng dạy, không phải sách khô khan
- 💡 So sánh với tiếng Việt để hiểu tại sao sai

---

#### Q12: Làm sao tận dụng command này để học tốt nhất?

**A**: **Best Practices**:

1. **Viết trước, check sau**: Viết câu tiếng Anh theo ý của bạn, sau đó check
2. **Đọc kỹ giải thích**: Không chỉ xem câu đúng, mà hiểu TẠI SAO sai
3. **Ghi chú pattern**: Nếu cùng lỗi lặp lại 3+ lần → Ghi nhớ và thực hành
4. **Áp dụng ngay**: Viết lại câu tương tự để củng cố
5. **Check thường xuyên**: Càng check nhiều, càng nhớ lâu

**Ví dụ Workflow**:
```
1. Viết email tiếng Anh → Check từng đoạn
2. Đọc giải thích → Hiểu lỗi
3. Ghi note: "Chủ ngữ số ít + động từ thêm S"
4. Viết 5 câu tương tự để practice
5. Check lại 5 câu đó
```

---

#### Q13: Command có thể thay thế giáo viên không?

**A**: **KHÔNG hoàn toàn**, nhưng là **công cụ bổ trợ tuyệt vời**:

**Command có thể**:
- ✅ Sửa lỗi ngữ pháp cơ bản đến nâng cao
- ✅ Giải thích quy tắc chi tiết
- ✅ Cho ví dụ minh họa
- ✅ Phát hiện pattern lỗi
- ✅ Available 24/7, không giới hạn số lần check

**Command KHÔNG thể**:
- ❌ Dạy từ đầu (cần kiến thức tiếng Anh cơ bản)
- ❌ Đánh giá phong cách viết
- ❌ Sửa speaking/pronunciation
- ❌ Tạo bài tập structured course

**Tốt nhất**: Kết hợp command + giáo viên/khóa học chính thống

---

## Validation

### Pre-execution Checks

Trước khi xử lý, AI sẽ kiểm tra:

- [ ] Text input không rỗng
- [ ] Text có vẻ là tiếng Anh (không phải tiếng Việt)
- [ ] Text có ít nhất 1 từ có nghĩa (không phải toàn ký tự đặc biệt)

Nếu fail bất kỳ check nào → Show error message phù hợp (xem Error Handling section)

---

### Post-execution Verification

Sau khi output, xác nhận:

- [ ] Tất cả lỗi ngữ pháp được xác định
- [ ] Câu đã sửa là ngữ pháp đúng 100%
- [ ] Bảng lỗi format đúng với 4 cột đầy đủ
- [ ] Mỗi lỗi có đầy đủ 4 phần: Quy tắc, Tại sao sai (hoặc ví dụ), Ví dụ thêm, Mẹo nhớ
- [ ] Giải thích bằng tiếng Việt tự nhiên, dễ hiểu (không dịch máy móc)
- [ ] Nếu có 3+ lỗi cùng loại → có section "Gợi ý học tập" chỉ ra pattern

---

## Related Commands

Command này làm việc độc lập, nhưng có thể kết hợp với:

- **Chat thường với AI**: Sau khi được sửa, bạn có thể hỏi thêm chi tiết: "Explain more about present perfect tense"
- **Future potential**: `/practice-grammar [topic]` (nếu được tạo sau này) - Tạo bài tập thực hành cho mảng ngữ pháp cụ thể

---

## Notes

- Command này được thiết kế cho **người Việt học tiếng Anh**, nên giải thích sẽ bằng tiếng Việt và tập trung vào lỗi phổ biến của người Việt
- Mục tiêu là **dạy**, không chỉ **sửa** - mỗi lỗi là một cơ hội học tập
- Giải thích được viết theo phong cách thầy cô dạy học, không phải sách vở khô khan
- Command tự động đọc grammar-learning skill mỗi lần được gọi để đảm bảo tuân thủ đúng quy trình

---

## Implementation Notes (For AI)

**CRITICAL**: When `/check-grammar` is invoked, follow this EXACT sequence:

### Phase 1: Grammar Check (ALWAYS EXECUTE)

1. **ALWAYS** perform full grammar check first (Steps 1-6)
2. **ALWAYS** display complete grammar correction output with all sections:
   - ✅ Câu đã sửa
   - ❌ Lỗi phát hiện (if errors found)
   - 📚 Giải thích chi tiết (if errors found)
   - 💡 Gợi ý học tập (if patterns detected)
3. **NEVER** skip or abbreviate the grammar correction output
4. **NEVER** proceed to task execution without completing grammar output first

### Phase 2: Task Detection (CONDITIONAL)

**Task Detection Algorithm**:

```
IF (input contains action verb) AND (input contains object/request):
    task_detected = TRUE
ELSE:
    task_detected = FALSE
```

**Action Verbs** (indicators of task):
- help, read, review, check, analyze, create, fix, explain, show, tell, give, provide, make, build, write, update, find, search, list, display, compare, evaluate, test, debug, optimize, refactor, improve

**Objects/Requests** (indicators of task):
- File references: "file X", "@file", "document", "code", "function", "class", "GLOBAL_RULE", etc.
- Specific entities: "this", "that", "the X", concrete nouns
- Question marks: "?", "Can you", "Could you", "Will you"
- Imperative mood: Commands starting with verbs

**Task Detection Confidence**:
- **High confidence** (2+ indicators): Proceed with task execution
- **Low confidence** (1 indicator only): Treat as grammar practice only
- **No indicators**: Grammar practice only

**Examples**:

✅ **Task Detected** (High Confidence):
- "Help me read file X" → Verb: "help, read" + Object: "file X"
- "Check whether code follows best practices" → Verb: "check, follows" + Object: "code, best practices"
- "Can you analyze this function?" → Verb: "analyze" + Object: "this function" + Question mark
- "Review the GLOBAL_RULE.md file" → Verb: "review" + Object: "GLOBAL_RULE.md file"

❌ **Task NOT Detected** (Grammar Practice):
- "She go to school yesterday" → Verb: "go" (not action verb in imperative) + No request object
- "I am student" → Statement only, no action verb
- "This is beauty flower" → Statement only, no request
- "I need help" → Only 1 indicator (vague), no specific object

### Phase 3: Task Execution (CONDITIONAL - Only if Task Detected)

**IF task_detected == TRUE**:

1. **Display clear separator**:
```markdown

---

## 🔄 Tiếp tục thực hiện task đã được sửa ngữ pháp...

**🎯 Detected Task**: [1-sentence description of what you will do]

**⚙️ Task Execution**:
```

2. **Execute the task using the CORRECTED text** (not the original text with grammar errors)

3. **Error handling**: If task execution fails:
```markdown

---

## 🔄 Tiếp tục thực hiện task đã được sửa ngữ pháp...

**🎯 Detected Task**: [task description]

**⚙️ Task Execution**:

❌ **Task Execution Error**: [Specific error message]

---

💡 **Lưu ý quan trọng**: Grammar correction ở trên vẫn hoàn toàn chính xác và hữu ích. Task execution thất bại vì: [reason]

**Bạn có thể**:
1. ✅ Thử lại task với context rõ ràng hơn
2. 📚 Hoặc chỉ tham khảo grammar corrections ở trên để học ngữ pháp
```

**ELSE** (task_detected == FALSE):
- Stop after grammar correction output
- Do NOT ask "Do you want me to...?"
- Do NOT suggest any follow-up actions
- Clean stop after grammar education

### Critical Rules

1. **Grammar First, Always**: Grammar correction is PRIMARY. Task execution is SECONDARY.
2. **Full Output Before Task**: NEVER abbreviate grammar output to rush to task execution
3. **Conservative Detection**: When in doubt, treat as grammar practice (false negative better than false positive)
4. **No Confirmation Needed**: If task detected with high confidence, execute immediately without asking
5. **Preserve Educational Value**: Even when executing tasks, maintain the teaching/learning tone
6. **Use Corrected Text**: Always use the grammatically correct version when executing the task
7. **Clear Separation**: Always use the separator `---` and heading `## 🔄` before task execution

### Testing Your Implementation

Before delivering output, verify:
- [ ] Grammar correction displayed in full (not summarized)
- [ ] Task detection logic applied correctly
- [ ] If task detected: Clear separator shown
- [ ] If task detected: Task description stated explicitly  
- [ ] If task detected: Using corrected text for execution
- [ ] If no task: Clean stop after grammar output

---

## 📋 Changelog

### Version 2.0.0 (2026-02-04) - Middleware Mode Release

**🎉 Major Features**:
- ✨ **NEW: Middleware Mode** - Command now automatically detects and executes tasks after grammar checking
- 🎯 **Smart Task Detection** - Identifies action verbs + objects to determine if input contains executable tasks
- ⚙️ **Auto-execution** - Seamlessly continues to task without asking for confirmation (if task detected with high confidence)
- 🔄 **Conservative Detection** - Uses 2+ indicators to avoid false positives, prefers false negatives for safety

**🔧 Enhancements**:
- 🎨 Enhanced visual separators with emoji for better readability (`🔄`, `🎯`, `⚙️`)
- 💬 Improved error messages for all middleware edge cases
- 📚 Comprehensive troubleshooting guide added
- ❓ Expanded FAQ from 6 to 13 questions covering both grammar and middleware modes
- ⚠️ New error cases: Ambiguous task detection, Vague task reference, Task execution failures
- 📖 Added 3 middleware examples (Task auto-execution, Grammar only, Complex task)

**📝 Documentation**:
- ✅ Step 7 added: Task Detection Logic
- ✅ Step 8 added: Auto-execution Workflow
- ✅ Implementation Notes section for AI behavior
- ✅ Complete middleware examples with expected outputs
- ✅ Error handling for 7 different scenarios (was 4)
- ✅ FAQ expanded to 13 comprehensive Q&As (was 6)
- ✅ Troubleshooting guide with 5 common issues

**🎓 Educational Value Maintained**:
- Grammar checking remains primary function
- Full Vietnamese explanations preserved
- Task execution is additive, not replacement
- Grammar corrections always shown first, in full
- Educational tone maintained throughout

**🔒 Backward Compatibility**:
- ✅ Existing grammar-only workflows unchanged
- ✅ No breaking changes to output format
- ✅ Pure grammar practice mode fully functional
- ✅ Middleware is opt-in (triggered by task patterns, not forced)

**🚀 Performance**:
- Task detection runs after grammar check (no slowdown for grammar-only users)
- Conservative algorithm prevents unnecessary task execution
- Clear separation between grammar output and task execution

**📊 Success Metrics**:
- Task detection accuracy target: 90%+ (2+ indicators required)
- False positive rate: < 5% (conservative detection)
- Zero regression in grammar checking functionality
- Full documentation coverage

**🔗 Related Updates**:
- Command metadata updated to reflect middleware capabilities
- Context section updated to describe both modes
- Input section includes middleware examples
- Process section expanded from 6 to 8 steps

---

### Version 1.0.0 (Initial Release)

**Core Features**:
- ✅ Grammar checking with Vietnamese explanations
- ✅ Error categorization (9 types)
- ✅ Detailed explanations with examples
- ✅ Pattern detection for repeated errors
- ✅ Educational focus for Vietnamese learners

---

**Version**: 2.0.0
**Last Updated**: 2026-02-04
**Created**: 2026-02-04
**Generated by**: `/create-command` meta-command
**Middleware Mode**: ✅ Enabled (Auto-executes tasks when detected)
