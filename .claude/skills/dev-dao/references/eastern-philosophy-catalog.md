# Catalog Triết Lý Đông Phương cho Software Engineering

Tham chiếu chi tiết cho 17 triết lý tích hợp trong Đạo Coding. Mỗi triết lý được trình bày theo cùng cấu trúc: Nguồn gốc, Nguyên lý, Mapping Dev, Ví dụ thực tế, Khi nào dùng. Tổ chức theo 5 nhóm: Đạo giáo, Phật giáo, Nhật Bản, Zen, và Việt Nam/Khác.

**Lưu ý:** Hai hệ thống chính (Sun Tzu Framework và Bát Chánh Đạo) được trình bày chi tiết trong files riêng. Tài liệu này tập trung vào 15 triết lý còn lại trong catalog, cộng thêm mục tóm tắt cho Tứ Diệu Đế và Duyên Khởi (thuộc nhóm Phật giáo nhưng khác với Bát Chánh Đạo).

---

## Nhóm 1: Đạo Giáo

### 1. Vô Vi — Wu Wei — Hành Động Không Cưỡng Ép

**Nguồn gốc:** Đạo Đức Kinh (道德經), Lão Tử, khoảng thế kỷ 6 TCN. Chương 48: *"Vô vi nhi vô bất vi"* — Không cố làm mà không gì không làm được.

**Nguyên lý:** Vô Vi không phải "không làm gì" — mà là hành động thuận theo tự nhiên, không cưỡng ép, không thừa. Nước chảy xuống dốc không cần ai bảo, nhưng không gì ngăn được. Hành động hiệu quả nhất là hành động không có sự dư thừa.

**Mapping Dev:**

- **YAGNI (You Aren't Gonna Need It):** Không build feature chưa cần. Code tồn tại ít nhất cũng tốt như code tồn tại đúng. Code không viết không có bug, không cần maintain, không cần test.
- **KISS (Keep It Simple, Stupid):** Solution đơn giản nhất work được là solution tốt nhất. Complexity là cost, simplicity là asset.
- **Minimalism trong API design:** API tốt nhất là API ít method nhất mà vẫn đủ dùng. Mỗi method thêm vào là một commitment vĩnh viễn.
- **Declarative over imperative:** Nói cái gì cần xảy ra, không nói cách xảy ra. SQL là Vô Vi — bạn mô tả data cần gì, engine tự tìm cách tối ưu.

**Ví dụ thực tế:** Team thêm caching layer "phòng performance issue". Chưa có performance issue. Cache thêm complexity: invalidation, consistency, memory management. Vô Vi nói: đo trước, optimize khi cần, không khi "nghĩ sẽ cần".

**Khi nào dùng:** Feature creep, over-engineering, premature optimization, API quá phức tạp, khi thấy mình đang code "phòng trường hợp".

---

### 2. Âm Dương — Yin-Yang — Cân Bằng Đối Lập

**Nguồn gốc:** Triết học Trung Quốc cổ đại, Kinh Dịch (易經). Hai lực đối lập nhưng bổ sung, tạo nên sự hài hòa.

**Nguyên lý:** Mọi thứ đều có hai mặt đối lập nhưng không thể tách rời. Trong Âm có mầm Dương, trong Dương có mầm Âm. Cực Dương sinh Âm, cực Âm sinh Dương. Cân bằng không phải 50-50 mà là tương thích với hoàn cảnh.

**Mapping Dev:**

| Âm | Dương | Cân bằng |
|----|-------|----------|
| Speed (ship nhanh) | Quality (ship đúng) | Cần cả hai: nhanh với guardrails |
| Flexibility (linh hoạt) | Structure (cấu trúc) | Flexible framework, structured process |
| Abstraction (trừu tượng) | Concreteness (cụ thể) | Abstract enough to reuse, concrete enough to understand |
| Centralization (tập trung) | Decentralization (phân tán) | Central orchestration, decentralized execution |
| Innovation (đổi mới) | Stability (ổn định) | Innovation trong sandbox, stability trong production |
| DRY (không lặp) | Clarity (rõ ràng) | DRY khi pattern rõ, duplicate khi context khác |

**Ví dụ thực tế:** Team đang tranh cãi monolith vs microservices. Âm Dương nói: cả hai đều đúng — trong context khác nhau. Startup 3 người cần Dương (monolith — tập trung, nhanh). Enterprise 300 người cần nhiều Âm hơn (microservices — phân tán, autonomy). Nhưng ngay cả trong microservices vẫn cần Dương (shared libraries, common contracts).

**Khi nào dùng:** Mọi trade-off decision, architecture debates, khi team phân cực giữa hai lựa chọn.

---

### 3. Khí — Qi/Chi — Dòng Chảy Năng Lượng

**Nguồn gốc:** Triết học Trung Quốc, y học cổ truyền, phong thủy. Khí là năng lượng sống lưu chuyển trong mọi vật. Khi Khí lưu thông tốt, cơ thể khỏe mạnh. Khi Khí bị tắc, bệnh phát sinh.

**Nguyên lý:** Dòng chảy phải thông suốt, không tắc nghẽn, không rò rỉ. Nơi Khí tụ là nơi có năng lượng mạnh. Nơi Khí bị chặn là nơi phát sinh vấn đề.

**Mapping Dev:**

- **Data flow:** Data trong hệ thống cũng như Khí trong cơ thể. Flow phải rõ ràng, unidirectional khi có thể, không circular dependencies.
- **Pipeline design:** ETL pipelines, event streaming, message queues — tất cả là hệ thống dẫn Khí. Bottleneck trong pipeline = Khí bị tắc = system unhealthy.
- **Information flow:** Thông tin từ user → system → response phải mượt mà. Bước nào gây friction là bước cần optimize.
- **Build pipeline:** CI/CD pipeline chậm = Khí tắc = developer productivity giảm.

**Ví dụ thực tế:** API response time trung bình 200ms nhưng P99 là 5s. Khí bị tắc ở đâu đó. Trace request path: database query full table scan ở edge case. Khai thông Khí: thêm index, query optimized. P99 về 300ms.

**Khi nào dùng:** Data architecture, streaming systems, pipeline design, performance bottleneck analysis, developer experience optimization.

---

## Nhóm 2: Phật Giáo

### 4. Tứ Diệu Đế — Four Noble Truths — Debug Methodology

**Nguồn gốc:** Phật giáo, bài giảng đầu tiên của Đức Phật tại Vườn Nai (Lộc Uyển). Bốn sự thật cao quý về khổ đau và con đường thoát khổ.

**Nguyên lý:**

1. **Khổ Đế** (Dukkha) — Khổ đau tồn tại: Thừa nhận vấn đề, không phủ nhận
2. **Tập Đế** (Samudaya) — Nguyên nhân của khổ: Tìm root cause, không chỉ triệu chứng
3. **Diệt Đế** (Nirodha) — Khổ có thể chấm dứt: Xác định trạng thái mong muốn
4. **Đạo Đế** (Magga) — Con đường chấm dứt khổ: Lên kế hoạch hành động

**Mapping Dev — 4 bước debug:**

| Đế | Debug Step | Hành động |
|----|-----------|-----------|
| **Khổ Đế** | Xác định bug | Triệu chứng cụ thể? Reproduce được? Impact? Ai bị ảnh hưởng? |
| **Tập Đế** | Tìm root cause | Logs, traces, bisect. Hỏi "5 whys". Không dừng ở triệu chứng. |
| **Diệt Đế** | Xác định expected state | Khi fix xong, hệ thống nên hoạt động thế nào? Success criteria? |
| **Đạo Đế** | Lên plan fix | Steps cụ thể, test plan, rollout plan, prevention cho tương lai |

**Ví dụ thực tế:** User report "app chậm" (Khổ Đế — thừa nhận vấn đề). Trace cho thấy N+1 query trong một loop (Tập Đế — root cause). App nên load page < 1s (Diệt Đế — target). Fix: eager loading + cache layer + monitoring alert khi > 1s (Đạo Đế — plan).

**Khi nào dùng:** Debug bất kỳ vấn đề phức tạp nào, root cause analysis, post-mortem, incident response.

---

### 5. Trung Đạo — Middle Way — Tránh Cực Đoan

**Nguồn gốc:** Phật giáo. Trung Đạo là con đường giữa hai cực đoan: khổ hạnh cực đoan và hưởng thụ cực đoan. Đức Phật từ bỏ cả hai để tìm ra con đường trung dung.

**Nguyên lý:** Cực đoan nào cũng dẫn đến khổ. Chân lý thường nằm ở giữa — nhưng "giữa" không phải lúc nào cũng là 50-50. "Giữa" là điểm phù hợp nhất cho context hiện tại.

**Mapping Dev:**

| Cực đoan A | Cực đoan B | Trung Đạo |
|-----------|-----------|-----------|
| Monolith cứng nhắc | Microservices cho mọi thứ | Modular monolith, tách khi cần |
| Zero tests | 100% coverage bằng mọi giá | Test critical paths, risk-based |
| No documentation | Document mọi thứ | Document decisions và public APIs |
| No abstractions | Abstract mọi thứ | Extract khi thấy 3 lần lặp |
| Waterfall cứng | "No process" chaos | Lightweight process phù hợp team |
| Only proven tech | Always bleeding edge | Proven core, experiment ở edges |

**Ví dụ thực tế:** Team lead muốn microservices vì "industry best practice". Solo developer muốn monolith vì "đơn giản". Trung Đạo: bắt đầu modular monolith, tách service khi có clear bounded context và team đủ lớn để own.

**Khi nào dùng:** Khi team phân cực giữa hai approach, architecture decisions, process decisions, khi nghe "always" hoặc "never".

---

### 6. Duyên Khởi — Pratītyasamutpāda — Phụ Thuộc Lẫn Nhau

**Nguồn gốc:** Phật giáo. Mọi hiện tượng đều phát sinh do sự kết hợp của nhiều nhân duyên. Không gì tồn tại độc lập — mọi thứ đều interconnected.

**Nguyên lý:** Mọi thứ phụ thuộc vào điều kiện. Thay đổi một điều kiện, kết quả thay đổi. Hiểu mạng lưới dependencies là hiểu hệ thống.

**Mapping Dev:**

- **Dependency analysis:** Mỗi module phụ thuộc vào nhiều module khác. Thay đổi module A ảnh hưởng gì đến B, C, D? Dependency graph là bản đồ Duyên Khởi.
- **Cascading failures:** Service A down → Service B timeout → Service C queue full → User thấy 500 error. Chuỗi nhân quả Duyên Khởi.
- **Configuration dependencies:** Thay đổi env variable X → behavior Y thay đổi → feature Z bị ảnh hưởng. Config cũng là "duyên".
- **People dependencies:** Developer A nghỉ phép → feature B delay → release C bị ảnh hưởng. Bus factor là một dạng Duyên Khởi.

**Ví dụ thực tế:** Deploy service X với breaking API change. Service Y và Z call service X → cả hai fail. Service W depend on Y → cũng fail. Cascading failure từ 1 change. Duyên Khởi nhắc: mọi thay đổi đều có ripple effects. Map dependencies trước khi thay đổi.

**Khi nào dùng:** Dependency analysis, impact assessment trước khi thay đổi, post-mortem cascading failures, risk analysis.

---

## Nhóm 3: Nhật Bản

### 7. Võ Đạo — Bushido — Software Craftsmanship

**Nguồn gốc:** Nhật Bản, thời Kamakura (~1185). Bushido (武士道) — con đường của chiến binh. 8 đức tính: Nghĩa (Gi), Dũng (Yū), Nhân (Jin), Lễ (Rei), Thành (Makoto), Danh (Meiyo), Trung (Chūgi), Kiểm (Jisei).

**Nguyên lý:** Chiến binh thực sự không chiến đấu vì ego mà vì honor và trách nhiệm. Mỗi kiếm chém đều có chủ đích. Bushido là commitment trọn đời với sự hoàn thiện.

**Mapping Dev:**

| Đức tính | Bushido | Developer |
|----------|---------|-----------|
| **Nghĩa** (Gi) | Làm điều đúng | Code đúng, ethical tech, push back khi cần |
| **Dũng** (Yū) | Can đảm | Refactor khi cần, nói "không biết", challenge bad decisions |
| **Nhân** (Jin) | Nhân từ | Mentoring juniors, code review constructive, patience |
| **Lễ** (Rei) | Tôn trọng | Respect codebase (clean code), respect team (communication) |
| **Thành** (Makoto) | Trung thực | Honest estimates, honest docs, admit mistakes |
| **Danh** (Meiyo) | Danh dự | Tự hào với code quality, không ship biết sai |
| **Trung** (Chūgi) | Trung thành | Loyalty với team, với commitments, với users |
| **Kiểm** (Jisei) | Tự chế | Không over-engineer, không gold-plate, restraint |

**Ví dụ thực tế:** Code review phát hiện bug nhỏ trong code của mình từ 3 tháng trước. Bushido developer (Makoto/Thành thật + Dũng/Can đảm): thừa nhận bug, tự fix, viết test ngăn tái phát. Không giấu, không blame.

**Khi nào dùng:** Xây team culture, software craftsmanship manifesto, personal development, code of conduct.

---

### 8. Thủ-Phá-Ly — Shu-Ha-Ri — Ba Giai Đoạn Học

**Nguồn gốc:** Võ thuật Nhật Bản, Aikido. Ba giai đoạn trên con đường tinh thông một nghệ thuật.

**Nguyên lý:**

- **Thủ** (守 — Shu — Giữ): Tuân thủ nghiêm ngặt quy tắc. Học form, copy master, không sáng tạo.
- **Phá** (破 — Ha — Phá): Bắt đầu phá vỡ quy tắc có chủ đích. Hiểu tại sao rule tồn tại, biết khi nào phá.
- **Ly** (離 — Ri — Rời): Vượt qua quy tắc. Tạo phong cách riêng. Rule đã nội hóa, không cần nghĩ đến nữa.

**Mapping Dev:**

| Giai đoạn | Level | Biểu hiện | Mentoring approach |
|-----------|-------|-----------|-------------------|
| **Thủ** | Junior | Theo guide, dùng pattern chuẩn, code review learn | Cho rule rõ ràng, template, pair programming |
| **Phá** | Mid | Biết khi nào break rule, propose alternatives | Thảo luận trade-offs, cho quyền quyết định có giới hạn |
| **Ly** | Senior+ | Tạo rule mới, mentor người khác, innovation | Cho freedom, review outcome không review process |

**Ví dụ thực tế:** Junior developer học React: Thủ — follow React docs, dùng hooks như hướng dẫn, không custom hooks phức tạp. Mid: Phá — viết custom hooks, biết khi nào useEffect không phải solution tốt nhất, challenge React conventions khi có lý do. Senior: Ly — design state management approach riêng, mentor team, contribute lại community.

**Khi nào dùng:** Learning path design, mentoring, onboarding, team skill assessment, training program.

---

### 9. Cải Tiến — Kaizen — Cải Tiến Liên Tục

**Nguồn gốc:** Nhật Bản sau Thế chiến II, Toyota Production System. Kai (改 — thay đổi) + Zen (善 — tốt) = thay đổi tốt hơn.

**Nguyên lý:** Cải thiện nhỏ mỗi ngày tốt hơn cải cách lớn mỗi năm. 1% tốt hơn mỗi ngày = 37.78x tốt hơn sau 1 năm (compound effect). Mọi người trong tổ chức đều có thể đề xuất cải tiến.

**Mapping Dev:**

- **Continuous improvement:** Mỗi sprint retrospective tìm 1-2 điều cải thiện. Không cần revolution, cần evolution.
- **Small PRs:** PR nhỏ review nhanh hơn, merge nhanh hơn, bug ít hơn. Mỗi PR là một cải tiến nhỏ.
- **Refactoring liên tục:** Mỗi lần touch file, để sạch hơn lúc đến (Boy Scout Rule). Không cần "refactoring sprint" nếu Kaizen hàng ngày.
- **Automation dần dần:** Tuần 1: automate deployment. Tuần 2: automate testing. Tuần 3: automate monitoring. Mỗi tuần một cải tiến.
- **Blameless post-mortems:** Khi incident xảy ra, focus vào "làm sao để không tái phát" không phải "ai gây ra". Kaizen culture = learning culture.

**Ví dụ thực tế:** Team deploy thủ công mất 2 giờ mỗi tuần. Tuần 1: viết script đơn giản, giảm còn 1 giờ. Tuần 3: thêm CI pipeline, giảm còn 15 phút. Tháng 2: fully automated, 0 phút manual. Kaizen: từng bước nhỏ, compound effect.

**Khi nào dùng:** Process improvement, retrospectives, technical debt reduction, team culture building, personal growth.

---

### 10. Wabi-Sabi — Chấp Nhận Sự Không Hoàn Hảo

**Nguồn gốc:** Mỹ học Nhật Bản, trà đạo, Zen Buddhism. Wabi (侘 — đơn sơ) + Sabi (寂 — patina của thời gian).

**Nguyên lý:** Vẻ đẹp nằm trong sự không hoàn hảo, vô thường, và chưa hoàn thành. Chiếc chén trà có vết nứt đẹp hơn chiếc chén hoàn hảo vì nó real, nó có câu chuyện.

**Mapping Dev:**

- **"Done is better than perfect":** Ship MVP imperfect nhưng valuable > không ship gì vì chờ perfect.
- **Accept technical debt:** Mọi codebase đều có debt. Acknowledge nó, manage nó, đừng ám ảnh eliminate nó.
- **Imperfect tests > no tests:** 60% coverage cho critical paths > 0% vì "chưa có thời gian viết đủ".
- **Progress over perfection:** Version 1 xấu nhưng work > Version 1 đẹp nhưng chưa bao giờ ship.
- **Embrace legacy:** Legacy code là code đang chạy production, serving users. Nó xấu nhưng nó work. Respect that.

**Ví dụ thực tế:** Developer perfectionist refactor module 3 lần, delay release 2 tuần. Wabi-Sabi: version hiện tại đủ tốt cho user, ship đi, iterate sau. Perfect là kẻ thù của done.

**Khi nào dùng:** Perfectionism paralysis, analysis paralysis, khi team không dám ship, khi đối mặt legacy code, khi cần chấp nhận imperfection để tiến bộ.

---

### 11. Ikigai — Lý Do Tồn Tại

**Nguồn gốc:** Nhật Bản. Iki (生き — sống) + Gai (甲斐 — giá trị). Giao điểm của 4 vòng tròn: Đam mê, Chuyên môn, Nhu cầu thế giới, Thu nhập.

**Nguyên lý:** Hạnh phúc bền vững đến từ giao điểm: việc bạn yêu thích ∩ việc bạn giỏi ∩ việc thế giới cần ∩ việc được trả tiền.

**Mapping Dev:**

| Vòng tròn | Câu hỏi | Developer context |
|-----------|---------|-------------------|
| **Đam mê** | Bạn yêu thích gì? | Frontend, backend, ML, DevOps, teaching? |
| **Chuyên môn** | Bạn giỏi gì? | Ngôn ngữ nào? Domain nào? Skills nào? |
| **Nhu cầu** | Thế giới cần gì? | Industry nào đang grow? Vấn đề nào cần giải? |
| **Thu nhập** | Được trả cho gì? | Market rate cho skills? Opportunity nào? |

**Ví dụ thực tế:** Developer yêu thích frontend (đam mê), giỏi React (chuyên môn), accessibility đang được coi trọng (nhu cầu), senior frontend positions trả tốt (thu nhập). Ikigai: trở thành accessibility expert trong frontend engineering.

**Khi nào dùng:** Career planning, burnout recovery, job change decisions, tìm purpose trong công việc.

---

### 12. Kintsugi — Vá Vàng — Ôm Ấp Lịch Sử Sửa Chữa

**Nguồn gốc:** Nghệ thuật Nhật Bản (金継ぎ). Khi đồ gốm vỡ, thay vì vứt đi, người ta dùng vàng gắn lại. Vết nứt trở thành phần đẹp nhất.

**Nguyên lý:** Lịch sử sửa chữa không phải điều xấu hổ mà là điều tự hào. Vật được sửa có câu chuyện, có giá trị hơn vật chưa từng bị thử thách.

**Mapping Dev:**

- **Legacy code:** Legacy code là code đang chạy production, đã survive hàng trăm edge cases. Khi refactor, embrace lịch sử — đọc git blame, hiểu tại sao code như vậy trước khi thay đổi.
- **Bug fixes:** Fix bug xong, viết test regression. Test đó là "đường vàng" — vĩnh viễn bảo vệ khỏi bug tái phát. Bug fixed + test = stronger than no bug ever.
- **Post-mortem:** Incident xong, document learnings. "Chúng tôi từng down 4 giờ vì lý do X, đây là cách chúng tôi fix và ngăn tái phát." Vết sẹo trở thành wisdom.
- **Refactoring:** Không rewrite from scratch. Cải thiện từng phần, giữ lại những gì work. Mỗi refactor là một đường vàng trên codebase.

**Ví dụ thực tế:** Module payment được viết 5 năm trước, code "xấu" nhưng handle được 47 edge cases phát hiện qua production incidents. Rewrite from scratch? Kintsugi nói: refactor từng phần, giữ lại wisdom của 47 edge cases đó, thêm tests bảo vệ. Mỗi edge case handled là một đường vàng.

**Khi nào dùng:** Technical debt decisions, legacy code modernization, post-incident improvements, khi ai đó muốn "rewrite everything from scratch".

---

### 13. Kata/Dojo — Luyện Tập & Kỷ Luật

**Nguồn gốc:** Võ thuật Nhật Bản. Kata (型 — form) là bài tập luyện lặp đi lặp lại. Dojo (道場 — nơi luyện tập) là không gian an toàn để luyện.

**Nguyên lý:** Mastery đến từ repetition có chủ đích. Kata không phải lặp vô nghĩa — mỗi lần lặp là một cơ hội tinh chỉnh. Dojo là nơi fail an toàn.

**Mapping Dev:**

- **Coding kata:** Bài tập coding lặp đi lặp lại (FizzBuzz, Roman Numerals, Bowling Game) — mỗi lần focus vào một kỹ năng khác: TDD, refactoring, design patterns. Không phải giải bài mới, mà giải bài cũ tốt hơn.
- **Code dojo:** Team meeting regular (weekly/bi-weekly) để cùng giải một bài tập. Mob programming, pair programming. An toàn để thử approach mới, fail không có hậu quả.
- **Practice environment:** Sandbox, playground, spike projects — Dojo cho developer. Thử technology mới ở đây, không thử trên production.
- **Deliberate practice:** Không chỉ "code 10 năm" mà "practice cụ thể skill X trong 10 năm". 10 năm kinh nghiệm ≠ 1 năm kinh nghiệm lặp 10 lần.

**Ví dụ thực tế:** Team hàng tuần làm 1 coding kata cùng nhau. Tuần này: implement LRU Cache bằng TDD. Không ai bị đánh giá. Focus vào process, không phải result. Sau 3 tháng: TDD trở thành tự nhiên, team code quality tăng rõ.

**Khi nào dùng:** Team skill building, onboarding training, personal development, khi muốn improve specific skill.

---

## Nhóm 4: Zen

### 14. Vô Tâm — Mushin — Flow State

**Nguồn gốc:** Thiền Zen Nhật Bản, võ thuật. Mushin (無心 — no-mind). Trạng thái tâm trí không bị chi phối bởi suy nghĩ hay cảm xúc, phản ứng tự nhiên mà không cần suy tính.

**Nguyên lý:** Khi samurai chiến đấu, họ không "nghĩ" về từng đường kiếm — họ phản ứng tự nhiên vì đã luyện tập đủ nhiều. Mushin là trạng thái mà kỹ năng đã nội hóa, hành động xảy ra tự nhiên.

**Mapping Dev:**

- **Flow state:** Trạng thái coding mà thời gian dường như dừng lại. Code tuôn ra tự nhiên. Không cần tra cứu syntax, không cần suy nghĩ API — tất cả đã nội hóa.
- **Automatic responses:** Nhìn thấy bug pattern → biết ngay hướng fix. Nhìn code smell → refactor tự động. Không cần phân tích dài dòng vì experience đã tích lũy đủ.
- **Detachment from outcome:** Code mà không attach vào kết quả. Không ego khi code bị reject. Không proud khi code được khen. Chỉ focus vào quá trình.

**Điều kiện để đạt Mushin:**

1. Luyện tập đủ nhiều (Kata/Dojo)
2. Environment đủ tốt (tools, setup, quiet space)
3. Tâm trạng đủ bình (không stressed, không rush)
4. Challenge vừa đủ (không quá dễ gây chán, không quá khó gây anxious)

**Khi nào dùng:** Khi muốn đạt peak productivity, khi cần deep work, khi design personal coding ritual.

---

### 15. Sơ Tâm — Shoshin — Tâm Người Mới Bắt Đầu

**Nguồn gốc:** Thiền Zen. Shunryu Suzuki: *"Trong tâm người mới bắt đầu có nhiều khả năng. Trong tâm chuyên gia chỉ có vài cái."*

**Nguyên lý:** Expert mind đầy giả định, shortcuts, và "tôi biết rồi". Beginner's mind mở, tò mò, không giả định. Sơ Tâm là giữ sự tò mò và openness của người mới, ngay cả khi đã có kinh nghiệm.

**Mapping Dev:**

- **Code review:** Đọc code với Sơ Tâm — không giả định "chắc họ biết cái này" hay "chắc cái này đúng rồi". Hỏi "tại sao approach này?" thay vì assume.
- **Learning new tech:** Đến với React/Rust/Go bằng tâm trắng, không áp kinh nghiệm Angular/C++/Python lên. Mỗi công nghệ có triết lý riêng.
- **Bug investigation:** "Chắc không phải ở đây" → bỏ lỡ bug. Sơ Tâm: check mọi thứ, không assume cái gì đúng.
- **User feedback:** "User không hiểu cách dùng" → Sơ Tâm: "có thể UI không rõ ràng?" Đặt mình vào vị trí người chưa biết gì.

**Ví dụ thực tế:** Senior developer debug lỗi 2 ngày. Junior hỏi "anh đã check log file chưa?" — Senior đã assume log không có gì hữu ích mà không check. Sơ Tâm của junior phát hiện bug. Expert mind bỏ lỡ.

**Khi nào dùng:** Code review, learning new technology, debugging khi bị stuck, UX research, khi thấy mình assume quá nhiều.

---

## Nhóm 5: Việt Nam & Khác

### 16. Phản Phác Quy Chân — Return to Fundamentals

**Nguồn gốc:** Tư tưởng Việt Nam, gốc từ Đạo giáo (返璞歸真 — Fǎn pǔ guī zhēn). Trở về mộc mạc, trở về chân thật. Phổ biến trong cộng đồng dev Việt Nam qua các bài viết trên toidicodedao.com.

**Nguyên lý:** Khi mọi thứ quá phức tạp, quay về cơ bản. Strip away layers of abstraction, trendy patterns, và fashionable tools. Trở về fundamentals: data structures, algorithms, HTTP, SQL, và logic đơn giản.

**Mapping Dev:**

- **Over-abstraction remedy:** 5 layers of abstraction để gọi một API? Phản Phác: flatten, simplify, gọi trực tiếp.
- **Tool fatigue:** 47 npm packages cho một CRUD app? Phản Phác: cần bao nhiêu thực sự?
- **Framework dependency:** Không biết JavaScript vanilla, chỉ biết React? Phản Phác: học lại DOM API, understand what React abstracts.
- **Back to basics debugging:** Fancy debugger không work? Phản Phác: `console.log`, `print`, binary search bằng commenting out code. Cơ bản nhưng hiệu quả.
- **Architecture simplification:** "We need event sourcing + CQRS + DDD" cho todo app? Phản Phác: database + REST API + simple frontend.

**Ví dụ thực tế:** Team adopt DDD + CQRS + Event Sourcing cho internal tool. 6 tháng: chưa ship. Code complexity explosion. Phản Phác: quay về MVC đơn giản, ship trong 3 tuần. Complexity không phải giá trị — simplicity mới là.

**Khi nào dùng:** Over-engineering, tool fatigue, framework lock-in, khi mọi thứ quá phức tạp mà không nên, khi junior developer bị overwhelm bởi tech stack.

---

### 17. Tao of Programming — Đạo Lập Trình

**Nguồn gốc:** "The Tao of Programming" của Geoffrey James (1987). Cuốn sách nhỏ viết theo phong cách Đạo Đức Kinh, áp dụng triết lý Đạo giáo vào lập trình.

**Nguyên lý:** Lập trình giỏi nhất là lập trình "vô hình" — code tự nhiên đến mức không ai nhận ra sự tài tình. Giống nước: mềm nhưng xuyên đá, không hình dạng nhưng khắp nơi.

**Các wisdom chính:**

- *"A program should follow the Law of Least Astonishment."* — Code nên hoạt động đúng như người đọc expect. Không surprises.
- *"A well-written program is its own heaven; a poorly-written program is its own hell."* — Code quality là môi trường bạn sống trong.
- *"When you have learned to snatch the error code from the trap frame, it will be time for you to leave."* — Mastery là khi debugging trở thành tự nhiên.
- *"The Tao that can be compiled is not the eternal Tao."* — Giải pháp tốt nhất không cố gắng giải quyết mọi thứ cùng lúc.
- *"Though a program be but three lines long, someday it will have to be maintained."* — Mọi code đều là legacy code. Viết cho người maintain sau.

**Mapping Dev:** Tao of Programming là "meta-philosophy" — không cho recipe cụ thể mà cho mindset tổng thể. Viết code tự nhiên, đơn giản, không ép buộc. Để code "chảy" thay vì "đẩy".

**Khi nào dùng:** General mindset, khi cần nhắc nhở bản thân về bản chất của lập trình, khi cảm thấy mất kết nối với craft.

---

## Bảng Tóm Tắt Toàn Bộ

| # | Triết lý | Nhóm | Một câu mapping | Use case chính |
|---|---------|------|-----------------|----------------|
| 1 | Vô Vi | Đạo giáo | Không code thừa | Over-engineering |
| 2 | Âm Dương | Đạo giáo | Cân bằng đối lập | Trade-offs |
| 3 | Khí | Đạo giáo | Dòng chảy data | Data/pipeline design |
| 4 | Tứ Diệu Đế | Phật giáo | 4 bước debug | Debugging |
| 5 | Trung Đạo | Phật giáo | Tránh cực đoan | Architecture decisions |
| 6 | Duyên Khởi | Phật giáo | Phụ thuộc lẫn nhau | Dependency analysis |
| 7 | Bushido | Nhật Bản | Honor in code | Team culture |
| 8 | Thủ-Phá-Ly | Nhật Bản | 3 stages of learning | Mentoring, growth |
| 9 | Kaizen | Nhật Bản | Small daily gains | Continuous improvement |
| 10 | Wabi-Sabi | Nhật Bản | Accept imperfection | Ship over perfect |
| 11 | Ikigai | Nhật Bản | Find purpose | Career direction |
| 12 | Kintsugi | Nhật Bản | Golden repair | Legacy code, post-mortem |
| 13 | Kata/Dojo | Nhật Bản | Deliberate practice | Skill building |
| 14 | Mushin | Zen | Flow state | Deep work, productivity |
| 15 | Shoshin | Zen | Beginner's mind | Code review, learning |
| 16 | Phản Phác | Việt Nam | Return to basics | Over-complexity |
| 17 | Tao of Programming | Mixed | Code naturally | General mindset |
