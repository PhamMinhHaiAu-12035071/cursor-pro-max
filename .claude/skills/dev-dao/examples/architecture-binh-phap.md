# Ví Dụ: Thiết Kế Kiến Trúc AI Orchestrator theo Binh Pháp Tôn Tử

Ví dụ đầy đủ áp dụng khung Đạo-Thiên-Địa-Tướng-Pháp-Hư/Thực để thiết kế kiến trúc một hệ thống AI orchestrator. Scenario generic — bạn có thể map vào bất kỳ stack nào.

---

## Scenario

**Yêu cầu:** Thiết kế hệ thống AI orchestrator cho một fintech startup. Hệ thống cần:

- Một LLM orchestrator tạo kế hoạch và kiểm chứng kết quả
- Nhiều execution agents thực hiện tác vụ (gọi API, đọc/ghi database, gửi notification)
- Xử lý giao dịch tài chính — cần bảo mật, audit trail, và rollback
- Team 5 người, MVP trong 6 tuần

---

## Đạo — Mục Tiêu & Sự Đồng Lòng

**Câu hỏi cốt lõi:** "Hệ thống này tồn tại để làm gì?"

**Purpose statement:** Biến prompt chiến lược từ LLM orchestrator thành hành động có kiểm soát — gọi API, đọc/ghi data, phát lệnh, tạo bằng chứng — đảm bảo mọi tác vụ đều có trace, có phanh, và có đường quay đầu.

**Stakeholder alignment:**

| Stakeholder | Mục tiêu chính | Mối quan tâm |
|-------------|----------------|-------------|
| Product Owner | Ship MVP nhanh, validate market fit | Timeline, cost |
| Tech Lead | Kiến trúc bền vững, dễ mở rộng | Maintainability, tech debt |
| Developer | Code rõ ràng, dễ debug | DX, tooling |
| Compliance | Audit trail đầy đủ, data security | Regulations, evidence |
| End User | Giao dịch chính xác, nhanh, minh bạch | Trust, UX |

**Quy luật chơi (Đạo bất biến):**

- Mọi tác vụ ghi đi qua Evidence Layer (log + chữ ký + anchor)
- Two-eyes approval cho thay đổi rủi ro cao
- Deny-by-default cho quyền truy cập
- Idempotency cho mọi lệnh ghi

**Kiểm tra Đạo:** Hỏi 5 thành viên team "hệ thống này phục vụ ai và vì sao?" — nếu 5 câu trả lời khác nhau, dừng lại align trước khi vẽ diagram.

---

## Thiên — Nhịp Độ & Timing

**Cadence phát triển:**

- Sprint 2 tuần, phù hợp team 5 người
- Week 1: develop + unit test. Week 2: integration + staging deploy
- MVP 6 tuần = 3 sprints

**SLOs:**

| Metric | Target | Lý do |
|--------|--------|-------|
| Orchestration latency (P95) | ≤ 3s | UX — user chờ quá lâu sẽ bỏ |
| Task success rate | ≥ 99.5% | Fintech — mỗi failure là tiền thật |
| Drift/rollback | ≤ 1/cycle | Stability signal |
| MTTR | < 15 phút | On-call phải recover nhanh |

**Kill-switch:**

- Feature flag cho mỗi agent — tắt ngay nếu agent misbehave
- Circuit breaker cho external APIs — auto-disconnect khi failure rate > 5%
- Global kill-switch cho toàn bộ orchestrator — dùng khi incident nghiêm trọng

**Deployment windows:**

- Deploy staging: bất kỳ lúc nào
- Deploy production: thứ 2-4, 9AM-4PM (có người trực)
- Không deploy thứ 6, không deploy trước holiday

---

## Địa — Kiến Trúc Lớp

```
Lớp 0 — Interface (Mặt trận)
├── Web Console / Chat UI
├── Admin Panel
└── API Gateway (validate + rate-limit)
        │
        ▼
Lớp 1 — Orchestrator (Trung quân)
├── Planner: phân rã mục tiêu → Plan DAG (bước, rủi ro, guards)
├── Policy Engine: rules quyền, hạn mức, checklist bằng chứng
├── Memory: context dự án, schema, tool specs
└── Command Gateway: ký HMAC, dispatch commands
        │
        ▼
Lớp 2 — Execution Agents (Đội thi công)
├── Agent: API Caller (HTTP requests, webhook handlers)
├── Agent: Data Writer (database operations, idempotent upserts)
├── Agent: Notifier (email, SMS, push notifications)
├── Agent: Calculator (business logic, rebates, fees)
└── Task Queue (retry backoff + idempotency key)
        │
        ▼
Lớp 3 — Storage (Hậu cần)
├── Primary DB: state, user data, transaction records
├── Cache: hot data, session state
├── Message Queue: async job dispatch
└── Secret Manager: API keys, HMAC secrets, signing keys
        │
        ▼
Lớp 4 — Evidence & Observability (Giám sát)
├── Audit hash-chain (prevHash + current log + HMAC)
├── Signed manifests cho policy changes
├── Structured logs → queryable evidence graph
├── Metrics: orchestration, execution, risk
└── Alert rules: SLO burn-rate, anomaly detection
```

**Nguyên tắc Địa:**

- Dependency đi từ trên xuống — Lớp 0 gọi Lớp 1, Lớp 1 gọi Lớp 2, không ngược lại
- Mỗi lớp validate input trước khi xử lý — defense in depth
- Lớp 2 (Agents) là stateless — state nằm ở Lớp 3 (Storage)
- Lớp 4 (Evidence) là immutable — chỉ append, không update hay delete

---

## Tướng — Vai Trò & Quyền Hạn

| Vai trò | Component | Quyền hạn | Accountability |
|---------|-----------|-----------|---------------|
| **Tổng tư lệnh** | LLM Orchestrator | Lập kế hoạch, chọn chiến thuật, kiểm chứng bằng chứng | Kết quả tổng thể của flow |
| **Đội thi công** | Execution Agents | Thực thi lệnh đơn lẻ trong scope được giao | Kết quả từng task |
| **Gián quan** | Gatekeeper/Policy Engine | Quyền veto — chặn lệnh vi phạm policy | An toàn hệ thống |
| **Giám sát** | Evidence Layer | Chỉ đọc + ghi audit — không thay đổi business state | Visibility, compliance |
| **Quân sư** | Human-in-the-loop | Override cho P1 operations, approve two-eyes requests | Business outcomes |

**Nguyên tắc phân vai:**

- **Least privilege:** Agent gọi API payment không cần quyền đọc user profile. Agent gửi email không cần quyền ghi database.
- **Separation of duties:** Orchestrator tạo request ≠ Gatekeeper approve request. Không ai vừa tạo vừa duyệt.
- **Escalation path:** Agent gặp error → báo Orchestrator. Orchestrator gặp policy violation → báo Gatekeeper. Gatekeeper cần judgment → escalate cho Human.

---

## Pháp — Luật Vận Hành

**Command Contract (tối thiểu cho mọi lệnh):**

```json
{
  "cmd": "payment.execute",
  "args": { "accountId": "acc_123", "amount": 125.50, "currency": "USD" },
  "actor": "orchestrator",
  "risk": { "tier": "P1", "maxLoss": 200, "requiresTwoEyes": true },
  "evidence": { "idempotencyKey": "uuid-v4", "manifestVersion": "2.2" }
}
```

**Guardrails bắt buộc:**

- Deny-by-default: mọi quyền phải explicit grant
- Rate limiting ở API Gateway + service level
- Input validation ở mọi boundary (Lớp 0, Lớp 1, Lớp 2)
- Idempotency key bắt buộc cho mọi write operation
- Retry policy: exponential backoff + jitter, max 3 retries
- Dead letter queue cho tasks fail sau max retries

**Two-eyes protocol cho P1 operations:**

1. Orchestrator soạn lệnh + preview impact
2. Gatekeeper review impact report
3. Human approve hoặc reject
4. Chỉ khi approved → Agent thực thi
5. Evidence Layer ghi toàn bộ flow

---

## Hư/Thực — Chiến Thuật Rollout

**Lộ trình triển khai 3 chặng:**

**Tuần 1-2 — SEED (Gieo hạt):**

- Bật khung cơ bản: Gateway HMAC, Task Queue, Database audit_logs, /health endpoint
- Orchestrator tool spec + 3 lệnh mẫu: user.init, payment.prepare, policy.preview
- Test coverage: unit tests cho mỗi agent, integration test cho happy path
- Deploy staging, manual testing

**Tuần 3-4 — TREE (Mọc cây):**

- Policy Engine + Two-Eyes protocol
- Evidence hash-chain với HMAC signing
- Rate limiting dynamic + circuit breakers
- Canary deployment: 10% → 25% → 50% → 100% với cooldown giữa mỗi phase
- Monitoring dashboard + alert rules

**Tuần 5-6 — FOREST (Thành rừng):**

- Full audit trail + compliance reporting
- Auto-scaling cho Agents dựa trên queue depth
- Performance optimization dựa trên metrics thực tế
- Load testing + chaos engineering (kill random agent, verify recovery)
- Production launch với canary 10% → 100%

**Rollback plan:**

- Mỗi deployment có tag version — rollback = deploy tag cũ
- Database migration có reverse migration
- Feature flag cho mỗi feature mới — tắt flag = instant rollback
- On-call engineer có quyền one-click rollback 24/7

---

## Guardrails & KPIs

| Category | Metric | Target | Alert threshold |
|----------|--------|--------|----------------|
| Orchestration | plan_build_ms (P95) | < 500ms | > 1000ms |
| Orchestration | plan_steps (avg) | < 10 | > 20 |
| Execution | task_success_rate | ≥ 99.5% | < 99% |
| Execution | p95_exec_ms | < 2000ms | > 5000ms |
| Evidence | proof_emit_rate | 100% | < 99.9% |
| Evidence | verify_pass_rate | ≥ 99.99% | < 99.9% |
| Risk | rollback_count/week | ≤ 1 | > 2 |
| Risk | incident_rate/7d | 0 | > 0 |

---

## Checklist "Xong Mới Chơi"

- [ ] Purpose statement rõ ràng, team đồng thuận
- [ ] SLOs define xong, dashboard sẵn sàng
- [ ] 5 lớp kiến trúc có ranh giới rõ ràng
- [ ] Roles phân quyền theo least privilege
- [ ] API contracts versioned, validation ở mọi boundary
- [ ] Idempotency key cho mọi write operation
- [ ] Two-eyes cho P1 operations
- [ ] Evidence hash-chain chạy và verify pass
- [ ] Feature flags cho mọi feature mới
- [ ] Rollback plan tested
- [ ] Canary deployment pipeline sẵn sàng
- [ ] On-call rotation và escalation path documented

---

## Triết Lý Bổ Sung Đã Áp Dụng

| Triết lý | Nơi áp dụng |
|----------|-------------|
| **Âm Dương** | Cân bằng speed ↔ safety trong rollout (canary thay vì big bang) |
| **Trung Đạo** | Không monolith cũng không full microservices — modular monolith cho MVP |
| **Khí (Qi)** | Data flow design: command → execute → evidence, một chiều rõ ràng |
| **Kaizen** | 3 chặng rollout: seed → tree → forest, cải tiến dần |
| **Duyên Khởi** | Dependency analysis: mỗi agent phụ thuộc gì, failure cascade ra sao |

---

*Ví dụ này minh họa cách áp dụng khung 6 yếu quyết vào thiết kế kiến trúc thực tế. Mọi tên component và technology đều generic — bạn có thể thay "LLM Orchestrator" bằng bất kỳ orchestration tool nào, "Execution Agents" bằng bất kỳ worker framework nào, tùy stack của bạn.*
