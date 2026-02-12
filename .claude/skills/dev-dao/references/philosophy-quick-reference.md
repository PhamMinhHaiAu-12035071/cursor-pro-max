# Bảng Tra Nhanh — Scenario → Triết Lý → Nguyên Tắc Áp Dụng

Bảng tra nhanh cho Đạo Coding. Dùng khi cần nhanh chóng xác định triết lý phù hợp cho tình huống cụ thể. Mỗi entry gồm: Scenario, Triết lý chính, Triết lý bổ sung, Nguyên tắc áp dụng, và Output mong đợi.

---

## Kiến Trúc & Thiết Kế

| Scenario | Triết lý chính | Bổ sung | Nguyên tắc | Output |
|----------|---------------|---------|------------|--------|
| Thiết kế system architecture mới | **Sun Tzu** (6 yếu quyết) | Âm Dương, Khí | Đi theo Đạo→Thiên→Địa→Tướng→Pháp→Hư/Thực | Architecture document |
| Chọn monolith vs microservices | **Trung Đạo** | Âm Dương | Không cực đoan; modular monolith → tách khi cần | Decision document + rationale |
| Thiết kế data pipeline | **Khí** (Qi) | Sun Tzu (Địa) | Dòng chảy thông suốt, không bottleneck, unidirectional | Pipeline diagram + monitoring points |
| Đánh giá trade-offs | **Âm Dương** | Trung Đạo | Mọi lựa chọn đều có 2 mặt; cân bằng cho context | Trade-off matrix |
| API design | **Vô Vi** | Phản Phác | Ít method nhất mà đủ dùng; tự nhiên, không surprises | API schema + documentation |
| Migration planning | **Sun Tzu** (Hư/Thực) | Kaizen | Canary, rollback plan, từng bước một | Migration plan + rollback procedures |
| Dependency decisions | **Duyên Khởi** | Vô Vi | Map dependencies trước khi thêm; ít dependency = ít risk | Dependency graph + risk assessment |

---

## Debugging & Problem-Solving

| Scenario | Triết lý chính | Bổ sung | Nguyên tắc | Output |
|----------|---------------|---------|------------|--------|
| Debug bug phức tạp | **Tứ Diệu Đế** | Sơ Tâm | Khổ→Tập→Diệt→Đạo: xác định→root cause→target→fix | Debug report |
| Bug reproduce được nhưng root cause ẩn | **Tứ Diệu Đế** (Tập Đế focus) | Duyên Khởi | 5 Whys; trace dependency chain | Root cause analysis |
| Bug intermittent, khó reproduce | **Sơ Tâm** | Chánh Niệm | Không assume; check mọi thứ; đọc logs kỹ | Hypothesis list + test plan |
| Cascading failure / incident | **Duyên Khởi** | Sun Tzu (Pháp) | Map cascade chain; fix gốc, không fix ngọn | Incident post-mortem |
| Performance bottleneck | **Khí** (Qi) | Tứ Diệu Đế | Tìm chỗ Khí tắc; đo trước khi optimize | Performance profile + fix plan |
| Stuck debug 2+ giờ | **Sơ Tâm** + **Incubation** | Chánh Định | Reset giả định; nghỉ ngơi; quay lại fresh | Fresh approach after break |

---

## Code Quality & Practices

| Scenario | Triết lý chính | Bổ sung | Nguyên tắc | Output |
|----------|---------------|---------|------------|--------|
| Over-engineering | **Vô Vi** (Wu Wei) | Phản Phác, Wabi-Sabi | Xóa cái thừa; YAGNI; code không viết = code tốt nhất | Simplified code |
| Premature abstraction | **Vô Vi** | Trung Đạo | Chờ thấy 3 lần lặp mới extract; concrete > abstract sớm | Removed unnecessary abstractions |
| Perfectionism paralysis | **Wabi-Sabi** | Kaizen | Done > perfect; ship, iterate, improve | Shipped imperfect but working code |
| Code review | **Sơ Tâm** + **Chánh Ngữ** | Bushido (Rei, Makoto) | Đọc không giả định; feedback cụ thể, constructive | Thoughtful review comments |
| Naming và documentation | **Chánh Ngữ** | Tao of Programming | Tên = ý nghĩa; docs = trung thực; commit message = context | Clear naming + honest docs |
| Test strategy | **Trung Đạo** | Chánh Tinh Tấn | Không 0% không 100%; test critical paths, risk-based | Test plan focused on value |

---

## Technical Debt & Legacy Code

| Scenario | Triết lý chính | Bổ sung | Nguyên tắc | Output |
|----------|---------------|---------|------------|--------|
| Đối mặt legacy code | **Kintsugi** | Sơ Tâm, Kaizen | Respect lịch sử; refactor từng phần; giữ wisdom | Incremental refactoring plan |
| "Rewrite from scratch" debate | **Kintsugi** | Trung Đạo | Vá vàng > vứt đi; chỉ rewrite khi repair cost > rebuild cost | Decision matrix: repair vs rebuild |
| Technical debt prioritization | **Kaizen** + **Chánh Tinh Tấn** | Kintsugi | 80/20: 20% debt gây 80% pain → fix đó trước | Prioritized debt backlog |
| Reduce complexity | **Phản Phác Quy Chân** | Vô Vi | Quay về cơ bản; strip abstraction layers; simplify | Simpler architecture |
| Post-incident improvement | **Kintsugi** | Tứ Diệu Đế, Kaizen | Đường vàng: fix + test regression + doc learnings | Post-mortem + regression tests |

---

## Team & Process

| Scenario | Triết lý chính | Bổ sung | Nguyên tắc | Output |
|----------|---------------|---------|------------|--------|
| Viết coding guideline | **Bát Chánh Đạo** | Bushido | 8 nhánh = 8 chiều guideline | Team guideline document |
| Team culture building | **Bushido** | Kaizen, Bát Chánh Đạo | Honor, respect, honesty, courage, continuous improvement | Culture manifesto |
| Retrospective | **Kaizen** | Chánh Kiến | 1-2 cải tiến nhỏ mỗi sprint; honest assessment | Action items |
| Onboarding new member | **Thủ-Phá-Ly** | Sơ Tâm, Kata/Dojo | Bắt đầu Thủ: theo rules, templates, pair programming | Onboarding plan + learning path |
| Mentoring junior | **Thủ-Phá-Ly** | Bushido (Nhân), Kaizen | Xác định giai đoạn; adjust mentoring style theo level | Mentoring framework |
| Team conflict resolution | **Trung Đạo** | Chánh Ngữ, Âm Dương | Không phe nào hoàn toàn đúng; tìm middle ground | Consensus or compromise |
| Process improvement | **Kaizen** | Sun Tzu (Pháp) | Thay đổi nhỏ, đo impact, iterate | Process changelog |

---

## Career & Mindset

| Scenario | Triết lý chính | Bổ sung | Nguyên tắc | Output |
|----------|---------------|---------|------------|--------|
| Career direction / burnout | **Ikigai** | Chánh Mạng, Thủ-Phá-Ly | 4 vòng tròn: đam mê ∩ giỏi ∩ cần ∩ trả tiền | Career reflection + action plan |
| "Nên học gì tiếp?" | **Thủ-Phá-Ly** | Phản Phác, Ikigai | Xác định giai đoạn; Thủ: fundamentals, Phá: explore, Ly: specialize | Learning roadmap |
| Flow state / productivity | **Vô Tâm** (Mushin) | Chánh Định | Luyện đủ (Kata) + env tốt + challenge vừa + tâm bình | Deep work ritual |
| Impostor syndrome | **Sơ Tâm** | Thủ-Phá-Ly, Wabi-Sabi | Không biết = bình thường; ai cũng từng ở giai đoạn Thủ | Self-compassion + learning plan |
| Ethical dilemma | **Chánh Mạng** + **Chánh Nghiệp** | Bushido (Gi) | Code ảnh hưởng người dùng; nghĩa vụ push back | Decision framework |
| Skill building / practice | **Kata/Dojo** | Thủ-Phá-Ly, Kaizen | Deliberate practice; lặp có chủ đích; safe environment | Practice schedule |
| Dealing with uncertainty | **Wabi-Sabi** | Sơ Tâm, Trung Đạo | Chấp nhận không biết hết; act on best available info | Decision with known unknowns |

---

## Vibe Coding & AI-Assisted Development

| Scenario | Triết lý chính | Bổ sung | Nguyên tắc | Output |
|----------|---------------|---------|------------|--------|
| Dùng AI tools hiệu quả | **Âm Dương** | Chánh Niệm | AI = Dương (speed), Human = Âm (judgment); cần cả hai | AI usage guidelines |
| Review AI-generated code | **Chánh Niệm** + **Sơ Tâm** | Chánh Kiến | Không trust blind; đọc từng dòng; hiểu intent | Review checklist |
| AI dependency concerns | **Phản Phác Quy Chân** | Trung Đạo | Hiểu fundamentals dưới AI layer; AI là tool, không là crutch | Fundamentals learning plan |
| Prompt engineering | **Chánh Ngữ** | Chánh Tư Duy | Nói rõ ý muốn; context đầy đủ; iterate | Better prompts |

---

## Cách Sử Dụng Bảng Tra

### Quy trình 3 bước:

1. **Tìm scenario** gần nhất với tình huống hiện tại
2. **Đọc triết lý chính** — đây là lens chủ đạo
3. **Xem triết lý bổ sung** — thêm chiều sâu nếu cần

### Nguyên tắc chọn triết lý:

- **Một scenario = 1 triết lý chính + 1-2 bổ sung.** Không tham lam quá nhiều triết lý.
- **Triết lý chính quyết định framework/cấu trúc output.** Triết lý bổ sung thêm nuance.
- **Nếu scenario không khớp chính xác,** tìm scenario gần nhất rồi adapt.
- **Nếu 2 triết lý conflict,** dùng Trung Đạo — tìm middle ground.

### Khi không tìm thấy scenario phù hợp:

Hỏi 3 câu:
1. Vấn đề này về **chiến lược** hay **chiến thuật**? → Chiến lược: Sun Tzu. Chiến thuật: Tứ Diệu Đế hoặc Kaizen.
2. Vấn đề này về **kỹ thuật** hay **con người**? → Kỹ thuật: Sun Tzu, Tứ Diệu Đế, Vô Vi. Con người: Bát Chánh Đạo, Bushido, Ikigai.
3. Vấn đề cần **thêm** hay **bớt**? → Thêm: Kaizen, Kata. Bớt: Vô Vi, Phản Phác, Wabi-Sabi.

---

## Decision Tree Nhanh

```
Cần thiết kế / đánh giá kiến trúc?
  ├─ Có → Sun Tzu Framework
  │       └─ Trade-off? → thêm Âm Dương / Trung Đạo
  └─ Không
     ├─ Cần debug / fix vấn đề?
     │   ├─ Có → Tứ Diệu Đế
     │   │       └─ Cascading? → thêm Duyên Khởi
     │   └─ Không
     │       ├─ Cần guideline / culture?
     │       │   ├─ Có → Bát Chánh Đạo + Bushido
     │       │   └─ Không
     │       │       ├─ Cần đơn giản hóa?
     │       │       │   ├─ Có → Vô Vi / Phản Phác
     │       │       │   └─ Không
     │       │       │       ├─ Legacy code / tech debt?
     │       │       │       │   ├─ Có → Kintsugi + Kaizen
     │       │       │       │   └─ Không
     │       │       │       │       ├─ Career / purpose?
     │       │       │       │       │   ├─ Có → Ikigai + Thủ-Phá-Ly
     │       │       │       │       │   └─ Không → Tao of Programming (general wisdom)
```
