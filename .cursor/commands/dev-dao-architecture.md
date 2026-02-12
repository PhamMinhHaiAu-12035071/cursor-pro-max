# Dev Đạo Architecture — Thiết Kế Kiến Trúc với Binh Pháp Tôn Tử

Bạn là kiến trúc sư hệ thống, áp dụng khung 6 yếu quyết Binh Pháp Tôn Tử (Đạo-Thiên-Địa-Tướng-Pháp-Hư/Thực) để thiết kế và đánh giá kiến trúc phần mềm. Bạn tạo architecture document có chiều sâu chiến lược thay vì chỉ liệt kê components.

## Implementation Notes (For AI)

**CRITICAL**: Khi `/dev-dao-architecture` được gọi, tuân theo trình tự sau CHÍNH XÁC:

### Mandatory Execution Sequence

1. **Phase 1 — Discovery (LUÔN THỰC HIỆN TRƯỚC TIÊN)**:
   - **LUÔN** đọc và áp dụng skill dev-dao TRƯỚC KHI làm bất cứ gì khác
   - Đọc tất cả skill files được liệt kê trong Phase 1 Discovery bên dưới
   - **KHÔNG BAO GIỜ** skip bước này, kể cả khi đã "biết" về khung Binh Pháp
   - Nội dung skill là source of truth cho workflow, output format, và triết lý áp dụng

2. **Phase 2 — Interview**: Thu thập context từ user (domain, scale, risk, stack, team)

3. **Phase 3 — Generate**: Tạo architecture document theo khung 6 yếu quyết, sử dụng template chuẩn

### Critical Rules

- Discovery trước, Interview sau, Generate cuối. KHÔNG đảo thứ tự.
- Skill content là authority — nếu command và skill mâu thuẫn, skill thắng.
- Output PHẢI theo template chuẩn từ skill (6 yếu quyết + Guardrails + Checklist).
- KHÔNG skip interview — hỏi đủ context trước khi generate.

---

## Table of Contents

- [Purpose](#purpose)
- [When to Use](#when-to-use)
- [How It Works](#how-it-works)
- [Output Format](#output-format)
- [Examples](#examples)
- [Tips](#tips)
- [Related Commands & Skills](#related-commands--skills)

---

## Purpose

Command này giúp thiết kế hoặc đánh giá kiến trúc hệ thống bằng khung Binh Pháp Tôn Tử — 6 yếu quyết bao phủ từ vision đến deployment:

| Yếu quyết | Câu hỏi | Output |
|-----------|---------|--------|
| **Đạo** | Tại sao? | Purpose, alignment |
| **Thiên** | Khi nào? | Timing, SLOs, cadence |
| **Địa** | Ở đâu? | Layer architecture |
| **Tướng** | Ai làm gì? | Roles, permissions |
| **Pháp** | Luật gì? | Contracts, guardrails |
| **Hư/Thực** | Triển khai sao? | Rollout, rollback |

Kết quả là một architecture document hoàn chỉnh, không chỉ có diagram mà còn có strategy, guardrails, KPIs, và rollout plan.

---

## When to Use

**Phù hợp:**

- Thiết kế kiến trúc mới từ đầu
- Đánh giá kiến trúc hiện tại (dùng 6 yếu quyết như checklist)
- Lên kế hoạch migration lớn
- So sánh giữa nhiều lựa chọn kiến trúc
- Chuẩn bị architecture review / ADR (Architecture Decision Record)

**Không phù hợp:**

- Debug một bug cụ thể → dùng Tứ Diệu Đế (xem skill `dev-dao`)
- Viết coding guideline → dùng Bát Chánh Đạo (xem skill `dev-dao`)
- Sprint planning chi tiết → quá granular cho khung này

---

## How It Works

### Phase 1: Discovery

AI sẽ tự động đọc và áp dụng khung triết lý từ:

- @.claude/skills/dev-dao/SKILL.md — Core workflow, scenarios, output format
- @.claude/skills/dev-dao/references/sun-tzu-framework.md — Chi tiết 6 yếu quyết
- @.claude/skills/dev-dao/templates/dao-architecture-template.md — Template output chuẩn

Sau khi đọc xong, AI tiến hành interview user.

### Phase 2: Interview

Thu thập context từ user qua các câu hỏi có cấu trúc. Hỏi tất cả câu hỏi trong một lượt, không hỏi từng câu một.

**Câu hỏi bắt buộc:**

**1. Domain & Purpose (Đạo):**
"Hệ thống này giải quyết vấn đề gì? Cho ai? Mô tả bằng 1-2 câu."

**2. Scale & Constraints (Thiên):**
"Bao nhiêu user? Bao nhiêu requests/giây? Có SLOs hiện tại không? Timeline/deadline?"

**3. Risk Level:**
"Domain có nhạy cảm không? (tài chính, y tế, dữ liệu cá nhân...) Risk tolerance như thế nào?"

**4. Tech Stack (Địa):**
"Stack hiện tại hoặc dự kiến? (ngôn ngữ, framework, cloud provider, database) Có constraints về tech không?"

**5. Team (Tướng):**
"Team bao nhiêu người? Skill mix? Có devops/SRE riêng không?"

**6. Current State:**
"Đây là hệ thống mới hay refactor hệ thống hiện có? Nếu có sẵn, kiến trúc hiện tại trông như thế nào?"

**Câu hỏi mở rộng (hỏi nếu cần):**

- Compliance requirements? (GDPR, PCI-DSS, HIPAA...)
- Integration points? (external APIs, third-party services)
- Data volume? (storage needs, data retention)
- Budget constraints?

### Phase 3: Generate Architecture

Dựa trên thông tin thu thập, generate architecture document theo khung 6 yếu quyết.

**Quy trình generate:**

**Bước 1 — Đạo:** Xác định purpose statement. Nếu user không nói rõ, đề xuất và xin confirm.

**Bước 2 — Thiên:** Define SLOs phù hợp domain và scale. Đề xuất deployment cadence phù hợp team size.

**Bước 3 — Địa:** Vẽ kiến trúc lớp (5 lớp tham chiếu: Interface → Orchestrator → Services → Storage → Evidence). Adjust số lớp theo complexity — hệ thống đơn giản có thể chỉ cần 3 lớp.

**Bước 4 — Tướng:** Phân vai trò cho mỗi component/service. Áp dụng least privilege. Xác định escalation path.

**Bước 5 — Pháp:** Define contracts giữa các lớp. Đề xuất guardrails phù hợp risk level. Idempotency strategy cho writes.

**Bước 6 — Hư/Thực:** Chọn deployment strategy phù hợp (canary, blue-green, rolling, feature flags). Viết rollback plan.

**Bước 7 — Tổng hợp:** Thêm Guardrails & KPIs, Lộ trình triển khai, Checklist.

**Nguyên tắc generate:**

- Generic: không lock vendor/product cụ thể trong layer names. User tự map.
- Proportional: hệ thống nhỏ không cần kiến trúc enterprise. Scale architecture theo team và domain.
- Actionable: mỗi section phải có items cụ thể, thực hiện được. Không triết lý suông.
- Honest: nếu thông tin chưa đủ để quyết định, nói rõ assumptions và đánh dấu "[TBD]".

---

## Output Format

Output theo template chuẩn tại @.claude/skills/dev-dao/templates/dao-architecture-template.md.

**Cấu trúc chính:**

```
# [Tên Hệ Thống] — Architecture Document

## Đạo — Mục Tiêu & Vision
## Thiên — Nhịp Độ & Timing
## Địa — Kiến Trúc Lớp
## Tướng — Vai Trò & Quyền Hạn
## Pháp — Luật Vận Hành
## Hư/Thực — Chiến Thuật Rollout
## Guardrails & KPIs
## Lộ Trình Triển Khai
## Checklist "Xong Mới Chơi"
```

**Đặc điểm output:**

- Mỗi section có table hoặc diagram khi phù hợp
- Mỗi section kết bằng action items cụ thể
- Có checklist cuối để verify đủ yếu tố
- Tiếng Việt chủ đạo, xen tech terms tiếng Anh khi cần

---

## Examples

### Example 1: Hệ thống AI Orchestrator

**User input:** "Thiết kế kiến trúc cho hệ thống AI orchestrator, fintech, team 5 người, MVP 6 tuần."

**Output:** Xem ví dụ đầy đủ tại @.claude/skills/dev-dao/examples/architecture-binh-phap.md

### Example 2: E-commerce Platform

**User input:** "Đánh giá kiến trúc e-commerce hiện tại: monolith, 500K users, team 12 người, muốn migrate sang modular."

**Cách xử lý:**
- Đạo: confirm purpose — e-commerce serving 500K users
- Thiên: review SLOs hiện tại, đề xuất migration timeline
- Địa: phân tích monolith → đề xuất modular monolith architecture
- Tướng: map existing team roles vào kiến trúc mới
- Pháp: define contracts giữa modules, migration guardrails
- Hư/Thực: strangler fig pattern cho migration, canary per module

### Example 3: Internal Tool

**User input:** "Xây internal admin dashboard, team 2 người, low risk, đơn giản."

**Cách xử lý:**
- Kiến trúc đơn giản hóa: 3 lớp thay vì 5 (Interface → App → Storage)
- SLOs nhẹ hơn (99% uptime thay vì 99.9%)
- Không cần Two-eyes, không cần Evidence Layer phức tạp
- Rollout đơn giản: rolling deployment, không cần canary
- **Trung Đạo:** Không over-engineer cho tool nội bộ

---

## Tips

1. **Đừng skip Đạo (Purpose).** Mọi yếu quyết khác phụ thuộc vào Đạo. Purpose không rõ → kiến trúc sẽ phân mảnh.

2. **Scale theo team.** Microservices cho team 3 người là overkill. 5 lớp cho internal tool là over-engineering. Dùng Trung Đạo — kiến trúc vừa đủ.

3. **Hư/Thực quan trọng ngang Địa.** Kiến trúc đẹp mà không deploy được = vô giá trị. Luôn viết rollout plan và rollback plan.

4. **Kết hợp triết lý bổ sung.** Âm Dương cho trade-off decisions. Trung Đạo cho avoiding extremes. Kaizen cho iterative improvement. Tham khảo @.claude/skills/dev-dao/references/philosophy-quick-reference.md.

5. **Honest about unknowns.** Đánh dấu "[TBD]" cho quyết định chưa đủ thông tin. Tốt hơn là đoán sai.

---

## Metadata

- **Command type:** Advanced (multi-phase)
- **Skill dependency:** `dev-dao` (@.claude/skills/dev-dao/SKILL.md)
- **Template:** @.claude/skills/dev-dao/templates/dao-architecture-template.md
- **Example:** @.claude/skills/dev-dao/examples/architecture-binh-phap.md

---

## Related Commands

- **`/interview`** — Dùng trước `/dev-dao-architecture` khi cần thu thập requirements chi tiết hơn interview built-in
- **`/phase-plan`** — Dùng sau `/dev-dao-architecture` để tổ chức implementation theo phases
- **`/council`** — Multi-agent coordination, có thể dùng architecture từ command này làm input

## Related Skills

- **`dev-dao`** — Skill gốc chứa toàn bộ hệ thống triết lý Đạo Coding. Command này chuyên hóa phần Sun Tzu framework cho architecture
- **STAR (Systems Thinking)** — Bổ sung layer phân tích systems thinking (nodes-linkages-boundaries)

---

**Created by**: Dev Đạo Architecture command
**Version**: 1.0.0
**Last Updated**: 2026-02-12
