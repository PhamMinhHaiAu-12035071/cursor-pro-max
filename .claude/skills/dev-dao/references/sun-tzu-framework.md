# Khung Binh Pháp Tôn Tử — Đạo-Thiên-Địa-Tướng-Pháp-Hư/Thực

Tham chiếu chi tiết cho hệ thống chiến lược số 1 của Đạo Coding. Khung này chuyển hóa 6 yếu quyết của Tôn Tử Binh Pháp thành phương pháp luận thiết kế kiến trúc hệ thống, deployment strategy, và quản trị rủi ro.

**Nguồn gốc:** Tôn Tử Binh Pháp (孫子兵法), khoảng 500 TCN, Trung Quốc. Thiên "Thủy Kế" (篇一) mở đầu bằng 5 yếu tố quyết định thắng bại: Đạo, Thiên, Địa, Tướng, Pháp. Khung này bổ sung thêm Hư/Thực (篇六) — chiến thuật triển khai thực tế.

**Nguyên lý cốt lõi:** *"Biết người biết ta, trăm trận trăm thắng. Biết người mà không biết ta, thắng một thua một. Không biết người không biết ta, mọi trận đều thua."* Trong software: hiểu hệ thống, hiểu user, hiểu team, hiểu constraints — trước khi đặt bút thiết kế.

---

## Đạo — Mục Tiêu & Sự Đồng Lòng

### Ý nghĩa gốc

Đạo trong binh pháp là mục tiêu chung mà toàn quân đều hiểu và đồng lòng hướng tới. Khi quân và tướng cùng chí, khi mục đích chiến tranh rõ ràng — đó là nền tảng cho mọi chiến lược phía sau. Không có Đạo, mọi chiến thuật đều vô nghĩa.

### Mapping Software

Đạo là **system vision** — mục đích tồn tại của hệ thống, sự alignment giữa tất cả bên liên quan.

**Các thành phần:**

- **System purpose:** Hệ thống này giải quyết vấn đề gì? Cho ai? Tại sao cần tồn tại? Một câu trả lời rõ ràng cho "why" trước khi bàn đến "how".
- **Team alignment:** Tất cả thành viên — từ developer đến product owner đến stakeholder — đều hiểu và đồng ý về purpose. Không có alignment, mỗi người sẽ tối ưu theo hướng riêng, hệ thống sẽ phân mảnh.
- **Product-market fit:** Hệ thống đang xây có thực sự cần thiết không? "Đánh không cần đánh" — Tôn Tử coi chiến thắng không cần chiến đấu là thượng sách. Trong software: đừng xây cái không cần xây.
- **Stakeholder mapping:** Ai hưởng lợi? Ai bị ảnh hưởng? Ai có quyền quyết định? Xác định rõ trước khi thiết kế.

**Câu hỏi khi áp dụng:**

1. Hệ thống này tồn tại để làm gì? (Một câu, không jargon)
2. Ai là người dùng chính và họ cần gì nhất?
3. Team có hiểu mục tiêu giống nhau không? Nếu hỏi 5 người, câu trả lời có nhất quán?
4. Có đang xây thứ thực sự cần thiết, hay đang xây vì "có thể xây"?

**Anti-pattern:** Bắt đầu thiết kế kiến trúc mà chưa trả lời được "hệ thống này phục vụ ai và vì sao". Kết quả: over-engineering, feature creep, misalignment giữa technical và business.

---

## Thiên — Nhịp Độ & Timing

### Ý nghĩa gốc

Thiên là thời tiết, mùa màng, ngày đêm — yếu tố thời gian mà tướng lĩnh phải thuận theo. Không ai đánh trận giữa mùa bão. Tướng giỏi chọn thời điểm, không ép thời thế.

### Mapping Software

Thiên là **timing strategy** — cadence phát triển, chu kỳ triển khai, và khả năng phản ứng khi mọi thứ thay đổi.

**Các thành phần:**

- **Release cadence:** Nhịp phát triển phù hợp. Sprint 1 tuần, 2 tuần, hay continuous delivery? Cadence phải khớp với khả năng team và nhu cầu business. Ép nhịp quá nhanh: quality giảm, burnout tăng. Nhịp quá chậm: feedback loop dài, mất momentum.
- **Deployment cycles:** Khi nào deploy? Tự động hay manual approval? Deploy thứ 6 chiều hay chỉ deploy đầu tuần? Biết lúc nào nên deploy và lúc nào nên chờ.
- **Kill-switch & Circuit breaker:** Khả năng dừng mọi thứ ngay lập tức khi phát hiện vấn đề. "Tốc chiến, tốc thắng" — nhưng phải có phanh. Kill-switch cho feature flags. Circuit breaker cho external services. Rollback plan cho mọi deployment.
- **SLOs & Time-based constraints:** Service Level Objectives đặt giới hạn thời gian cho hệ thống. P95 latency, uptime target, MTTR (Mean Time To Recovery). Thiên trong software là biết giới hạn thời gian của mình.
- **Market timing:** Đôi khi launch sớm với MVP thắng hơn launch trễ với sản phẩm hoàn hảo. "Binh quý thần tốc" — nhưng chỉ khi đã chuẩn bị đủ.

**Câu hỏi khi áp dụng:**

1. Release cadence hiện tại có phù hợp với team size và domain risk?
2. Nếu deployment lỗi, bao lâu để rollback? MTTR là bao nhiêu?
3. Có kill-switch cho mọi feature mới không?
4. SLOs đã define chưa? Team có biết target latency/uptime?
5. Deadline business có thực tế không? Có đang ép "đánh giữa mùa bão"?

**Anti-pattern:** Deploy production vào thứ Sáu chiều. Launch feature lớn mà không có feature flag. Chạy theo deadline mà bỏ qua test. Ép team sprint nhanh liên tục không có breathing room.

---

## Địa — Kiến Trúc Lớp

### Ý nghĩa gốc

Địa là địa hình — cao thấp, rộng hẹp, xa gần, hiểm trở hay bằng phẳng. Tướng giỏi chọn địa hình có lợi, bố trí quân theo thế đất. Không hiểu địa hình thì chiến thuật hay mấy cũng vô dụng.

### Mapping Software

Địa là **architecture layers** — cấu trúc phân lớp của hệ thống, nơi mỗi lớp có vai trò rõ ràng và ranh giới nghiêm ngặt.

**Kiến trúc 5 lớp tham chiếu:**

```
Lớp 0 — Interface (Mặt trận)
   Nơi user tương tác. Web UI, Mobile app, CLI, API endpoints.
   Nguyên tắc: mỏng, stateless, validate input tại đây.

Lớp 1 — Orchestrator (Trung quân)
   Bộ não điều phối. Nhận request, lập kế hoạch, phân phối tasks.
   Nguyên tắc: logic điều phối nằm đây, không chứa business logic chi tiết.

Lớp 2 — Services/Agents (Đội thi công)
   Thực thi business logic cụ thể. Mỗi service/agent một nhiệm vụ rõ ràng.
   Nguyên tắc: single responsibility, idempotent, báo cáo kết quả.

Lớp 3 — Storage (Hậu cần)
   Database, cache, file storage, message queue.
   Nguyên tắc: data integrity, backup, replication, access control.

Lớp 4 — Evidence & Observability (Giám sát)
   Logs, metrics, traces, audit trail, monitoring.
   Nguyên tắc: immutable, queryable, alertable.
```

**Nguyên tắc phân lớp:**

- **Dependency đi từ trên xuống.** Lớp trên gọi lớp dưới, không ngược lại. Interface gọi Orchestrator, Orchestrator gọi Services, Services gọi Storage. Không bao giờ Storage gọi ngược lên Interface.
- **Mỗi lớp là một "chốt kiểm soát".** Request đi qua từng lớp, mỗi lớp validate và transform. Giống quân đi qua từng trạm kiểm soát trước khi vào trận.
- **Ranh giới rõ ràng.** Contract giữa các lớp phải explicit — API schema, interface definition, message format. Ranh giới mờ dẫn đến coupling, coupling dẫn đến cascading failures.
- **Địa hình hiểm trở cần phòng thủ dày.** Các lớp xử lý data nhạy cảm (payment, PII, authentication) cần encryption, access control, audit logging chặt hơn.

**Câu hỏi khi áp dụng:**

1. Hệ thống có bao nhiêu lớp? Ranh giới giữa các lớp có rõ ràng?
2. Dependency flow có đi một chiều không? Có circular dependency nào?
3. Nếu một lớp fail, lớp khác có bị kéo theo không? Blast radius là gì?
4. Lớp nào chứa data nhạy cảm nhất? Phòng thủ ở đó đủ chưa?
5. Kiến trúc hiện tại có match với team size? (Microservices cho team 3 người là overkill)

**Anti-pattern:** Monolith với mọi thứ mixed chung không có boundary. Microservices cho startup 3 người. Database call trực tiếp từ UI layer. Business logic nằm rải rác ở mọi lớp.

---

## Tướng — Vai Trò & Quyền Hạn

### Ý nghĩa gốc

Tướng là người chỉ huy — cần có trí, tín, nhân, dũng, nghiêm. Tướng tốt biết dùng người đúng chỗ, phân quyền rõ ràng, và biết khi nào nên ủy quyền, khi nào cần tự quyết.

### Mapping Software

Tướng là **roles & responsibilities** — ai/cái gì đảm nhận vai trò nào, quyền hạn đến đâu, và accountability ra sao.

**Các vai trò trong hệ thống:**

| Vai trò | Mô tả | Quyền hạn | Accountability |
|---------|-------|-----------|---------------|
| **Orchestrator** | Điều phối tổng thể, lập kế hoạch, phân task | Cao — quyết định flow | Kết quả tổng thể |
| **Service/Agent** | Thực thi nhiệm vụ cụ thể | Giới hạn — chỉ scope được giao | Kết quả task đơn lẻ |
| **Gatekeeper** | Kiểm tra policy, approve changes | Quyền veto — chặn nếu vi phạm | An toàn hệ thống |
| **Observer/Monitor** | Giám sát, cảnh báo, audit | Chỉ đọc — không thay đổi state | Visibility |
| **Human-in-the-loop** | Quyết định cuối cho tasks rủi ro cao | Override — quyết định cuối | Business outcomes |

**Nguyên tắc phân vai:**

- **Least privilege.** Mỗi component chỉ có đủ quyền để hoàn thành nhiệm vụ của mình. Service xử lý payment không cần quyền đọc user profile. Agent gửi email không cần quyền ghi database.
- **Separation of duties.** Người/component tạo request không phải người approve. Người deploy không phải người review. Đặc biệt quan trọng với operations nhạy cảm (tài chính, data deletion, policy change).
- **Clear escalation path.** Khi một component không tự xử lý được, phải biết escalate cho ai. Service gặp error → báo Orchestrator. Orchestrator gặp policy violation → báo Gatekeeper. Gatekeeper cần judgment → escalate cho Human.
- **Accountability.** Mỗi action trong hệ thống phải trace được ai/cái gì thực hiện. Audit trail không chỉ ghi "what happened" mà cả "who initiated, who approved, who executed".

**Câu hỏi khi áp dụng:**

1. Mỗi component trong hệ thống có vai trò rõ ràng không?
2. Quyền hạn của mỗi component có tuân theo least privilege?
3. Có escalation path khi component gặp vấn đề ngoài scope?
4. Actions nhạy cảm có require approval từ role khác không (separation of duties)?
5. Audit trail có đủ để trace được "ai làm gì, khi nào, tại sao"?

**Anti-pattern:** Service có god-mode access vào mọi resource. Một component vừa tạo vừa approve request của chính mình. Không có escalation path — error bị nuốt im lặng. Audit log chỉ ghi "error occurred" mà không ghi context.

---

## Pháp — Luật Vận Hành & Kỷ Luật

### Ý nghĩa gốc

Pháp là quân pháp — luật lệ, kỷ luật, tổ chức, hậu cần. Quân không có pháp thì loạn. Pháp phải rõ ràng, công bằng, và được thực thi nhất quán. Nhưng pháp cũng cần linh hoạt — tướng tại ngoại, quân mệnh có sở bất thụ (tướng ngoài chiến trường có quyền không tuân lệnh vua khi tình huống thay đổi).

### Mapping Software

Pháp là **contracts, guardrails, và operating policies** — bộ quy tắc vận hành đảm bảo hệ thống chạy nhất quán, an toàn, và có thể dự đoán.

**Các thành phần:**

**Contracts (Hợp đồng giữa các components):**

- API contracts: schema rõ ràng, versioned, backward-compatible
- Message contracts: format, encoding, validation rules
- SLA giữa các services: timeout, retry policy, fallback behavior
- Error contracts: error codes chuẩn, error response format nhất quán

**Guardrails (Rào chắn an toàn):**

- Input validation ở mọi boundary
- Rate limiting để ngăn abuse và cascading failures
- Circuit breakers cho external dependencies
- Deny-by-default: mọi quyền phải explicit grant, không implicit allow

**Idempotency & Retry:**

- Mọi write operation phải idempotent — gọi 2 lần cho kết quả giống gọi 1 lần
- Idempotency key bắt buộc cho transactions quan trọng
- Retry policy: exponential backoff + jitter, có max retries
- Dead letter queue cho messages fail sau max retries

**Policy-as-Code:**

- Rules vận hành nên viết thành code, không phải document. Code verify được, test được, version được.
- Access control rules, deployment policies, compliance checks — tất cả nên có code representation.

**Câu hỏi khi áp dụng:**

1. API contracts giữa services có explicit không? Có versioning?
2. Write operations có idempotent không? Nếu retry, có bị duplicate?
3. Rate limiting đã config ở mọi public endpoint chưa?
4. Circuit breakers có cho external dependencies không?
5. Policies có viết thành code (testable) hay chỉ nằm trong doc?
6. Default access policy là deny hay allow? (Phải là deny)

**Anti-pattern:** API không có schema documentation. Retry vô hạn không có backoff. Rate limit chỉ set ở gateway mà không set ở service level. Policy chỉ nằm trong Confluence page mà không ai đọc.

---

## Hư/Thực — Chiến Thuật Triển Khai

### Ý nghĩa gốc

Hư/Thực là nghệ thuật "biến ảo" — dùng hư binh để dụ địch, dùng thực binh để đánh. Biết mạnh mà tỏ yếu, biết yếu mà tỏ mạnh. Mục đích: giảm rủi ro, tăng khả năng kiểm soát, và luôn có đường rút.

### Mapping Software

Hư/Thực là **rollout tactics & deployment strategies** — cách đưa code mới lên production với rủi ro tối thiểu, khả năng rollback tối đa.

**Chiến thuật triển khai:**

**Canary Deployment (Thả chim thăm dò):**

Thả phiên bản mới cho một nhóm nhỏ user (5-10%) trước. Theo dõi metrics. Nếu ổn, tăng dần (25% → 50% → 100%). Nếu có vấn đề, rollback chỉ ảnh hưởng nhóm nhỏ.

- Khi nào dùng: Changes có risk trung bình, cần validate với real traffic
- Metrics cần theo dõi: error rate, latency p95, business metrics (conversion, engagement)
- Cooldown giữa các phase: đủ để thu thập data có ý nghĩa thống kê

**Blue-Green Deployment (Hai thế trận):**

Duy trì 2 environment giống hệt nhau. Blue đang chạy production, Green chạy version mới. Switch traffic khi Green sẵn sàng. Nếu có vấn đề, switch ngược về Blue.

- Khi nào dùng: Changes lớn, cần instant rollback, database schema compatible
- Lưu ý: cần xử lý database migration cẩn thận, cả Blue và Green phải đọc được cùng schema

**Feature Flags (Hư binh):**

Code mới đã deploy nhưng ẩn sau flag. Bật flag cho nhóm nhỏ để test, tắt flag nếu có vấn đề. Deployment và release là hai thứ tách rời.

- Khi nào dùng: Features cần A/B test, gradual rollout, hoặc kill-switch nhanh
- Quản lý: cleanup flags cũ thường xuyên, flag debt nguy hiểm không kém tech debt
- Nguyên tắc: flag nên có expiry date, flag không owner sẽ bị remove

**Rolling Deployment (Thay quân tuần tự):**

Thay từng instance/pod một. Lúc nào cũng có instances cũ và mới chạy song song. Nếu instance mới fail, chỉ instance đó bị ảnh hưởng.

- Khi nào dùng: Stateless services, changes risk thấp
- Lưu ý: backward compatibility là must — old và new code phải hoạt động cùng nhau

**Rollback Plan (Đường rút):**

Mọi deployment phải có rollback plan rõ ràng. Không bao giờ deploy mà không biết cách revert.

- Automated rollback: khi metrics vượt threshold, tự động revert
- One-click rollback: team bất kỳ ai cũng có thể trigger rollback
- Database rollback: migration phải có reverse migration
- Data rollback: nếu deployment đã thay đổi data, plan restore ra sao

**Câu hỏi khi áp dụng:**

1. Deployment strategy hiện tại là gì? Có phù hợp với risk level?
2. Thời gian rollback là bao lâu? Có phải ai cũng rollback được?
3. Feature mới có ẩn sau feature flag không?
4. Canary deployment có cooldown đủ giữa các phase?
5. Database migration có reversible không?
6. Nếu deploy lúc 3 giờ sáng bị lỗi, on-call engineer có rollback được trong vòng 5 phút không?

**Anti-pattern:** Big bang deployment — đẩy toàn bộ changes lên production cùng lúc. Deploy mà không có rollback plan. Feature flag sống mãi không ai cleanup. Canary không có cooldown — từ 5% lên 100% trong 2 phút.

---

## Quy Trình Áp Dụng Khung 6 Yếu Quyết

Khi cần thiết kế hoặc đánh giá kiến trúc hệ thống, đi qua 6 bước theo thứ tự:

### Bước 1: Đạo — Xác định Purpose

"Hệ thống này tồn tại để làm gì?" Không bắt đầu vẽ diagram cho đến khi trả lời được câu này bằng một câu rõ ràng.

### Bước 2: Thiên — Xác định Constraints

Timing, SLOs, cadence, deployment windows. Biết giới hạn thời gian trước khi thiết kế.

### Bước 3: Địa — Vẽ Kiến Trúc Lớp

Phân lớp, xác định ranh giới, vẽ dependency flow. Đảm bảo dependencies đi một chiều.

### Bước 4: Tướng — Phân Vai

Mỗi component/service một vai trò rõ ràng. Least privilege. Separation of duties cho operations nhạy cảm.

### Bước 5: Pháp — Định Luật

Contracts, guardrails, retry policies, idempotency. Viết thành code khi có thể.

### Bước 6: Hư/Thực — Lên Kế Hoạch Rollout

Chọn deployment strategy phù hợp risk level. Đảm bảo có rollback plan. Test rollback plan thường xuyên.

---

## Bảng Tóm Tắt Nhanh

| Yếu quyết | Câu hỏi chính | Output | Red Flag |
|-----------|---------------|--------|----------|
| **Đạo** | "Tại sao?" | Purpose statement, stakeholder map | Team không thống nhất về mục tiêu |
| **Thiên** | "Khi nào?" | SLOs, cadence, kill-switch plan | Không có SLOs, deploy thứ 6 chiều |
| **Địa** | "Ở đâu?" | Layer diagram, dependency flow | Circular deps, mixed responsibilities |
| **Tướng** | "Ai làm gì?" | Role matrix, permission model | God-mode access, no escalation path |
| **Pháp** | "Luật gì?" | Contracts, guardrails, policies | No API schema, no retry policy |
| **Hư/Thực** | "Triển khai sao?" | Rollout plan, rollback procedure | Big bang deploy, no rollback plan |

---

## Tôn Tử Nói Gì Thêm — Các Nguyên Tắc Bổ Sung

### "Thượng binh phạt mưu" — Thắng ở chiến lược, không phải chiến thuật

Kiến trúc tốt nhất là kiến trúc khiến vấn đề không xảy ra, không phải kiến trúc giỏi xử lý vấn đề khi xảy ra. Prevention tốt hơn cure.

### "Thiện chiến giả, cầu chi ư thế, bất trách ư nhân" — Tạo thế, không đổ lỗi người

Nếu bug liên tục xảy ra, đừng đổ lỗi developer. Sửa hệ thống: thêm type safety, thêm tests, thêm linting. Tạo môi trường mà làm sai khó hơn làm đúng.

### "Binh quý thần tốc" — Nhanh nhưng có chuẩn bị

Ship fast, nhưng với guardrails. CI/CD pipeline nhanh vì automated tests đã cover. Deploy nhanh vì có canary + rollback. Tốc độ thực sự đến từ chuẩn bị, không phải bỏ qua chuẩn bị.

### "Bất chiến nhi khuất nhân chi binh" — Thắng mà không cần đánh

Hệ thống tốt nhất giải quyết vấn đề trước khi vấn đề trở thành incident. Monitoring cảnh báo sớm. Auto-scaling xử lý load trước khi user nhận thấy. Self-healing services tự recover.

### "Tướng tại ngoại, quân mệnh có sở bất thụ" — Quyền tự quyết tại chiến trường

Services tự trị trong scope của mình. Không cần hỏi orchestrator cho mọi quyết định nhỏ. Circuit breaker tự quyết disconnect khi dependency fail. Agent tự retry theo policy đã define. Autonomy trong ranh giới — freedom within framework.

---

## Khi Nào Dùng Khung Này

| Scenario | Phù hợp? | Lý do |
|----------|----------|-------|
| Thiết kế kiến trúc mới từ đầu | Rất phù hợp | Cover toàn diện từ vision đến deployment |
| Đánh giá kiến trúc hiện tại | Phù hợp | Dùng 6 yếu quyết như checklist đánh giá |
| Planning migration | Phù hợp | Hư/Thực cho rollout strategy, Địa cho target architecture |
| Debug một bug cụ thể | Không phù hợp | Dùng Tứ Diệu Đế thay thế |
| Viết coding guideline | Không phù hợp | Dùng Bát Chánh Đạo thay thế |
| Chọn giữa 2 kiến trúc | Phù hợp | So sánh theo 6 chiều |
| Sprint planning | Ít phù hợp | Quá chi tiết cho sprint level, dùng cho quarter/roadmap |

---

## Kết Hợp Với Triết Lý Khác

Khung Binh Pháp mạnh nhất khi kết hợp với:

- **Âm Dương** — Cho các trade-off decisions trong từng yếu quyết (speed vs safety, flexibility vs consistency)
- **Trung Đạo** — Tránh cực đoan trong kiến trúc (monolith cực đoan hay microservices cực đoan)
- **Khí (Qi)** — Cho data flow design trong Địa (lớp kiến trúc)
- **Kaizen** — Cho continuous improvement của từng yếu quyết sau mỗi cycle
- **Duyên Khởi** — Cho dependency analysis sâu trong Địa và Tướng
