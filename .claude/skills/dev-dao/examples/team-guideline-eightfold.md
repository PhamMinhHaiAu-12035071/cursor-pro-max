# Ví Dụ: Coding Guideline Team theo Bát Chánh Đạo

Ví dụ đầy đủ một coding guideline viết cho team development, dùng 8 nhánh Bát Chánh Đạo làm khung tổ chức. Generic cho mọi stack — team tự điền ví dụ cụ thể theo ngôn ngữ và framework đang dùng.

---

## Scenario

**Team:** Backend team 8 người, mix senior và junior, làm product SaaS B2B.
**Vấn đề:** Code quality không đồng đều, review mất nhiều thời gian, junior hay mắc lỗi lặp lại, không có document chuẩn chung.
**Mục tiêu:** Tạo guideline ngắn gọn, dễ nhớ, team có thể reference hàng ngày.

---

## [Team Name] Coding Guideline — Theo Bát Chánh Đạo

> *"Bát Chánh Đạo không phải 8 bước tuần tự mà là 8 chiều thực hành đồng thời. Thiếu một chiều, các chiều khác sẽ yếu đi."*

Guideline này tổ chức theo 8 nhánh Bát Chánh Đạo — 8 chiều mà mỗi thành viên team thực hành song song trong mọi hoạt động development.

---

### 1. Chánh Kiến — Nhìn Đúng Vấn Đề

**Nguyên tắc:** Hiểu rõ trước khi làm. Đừng code khi chưa hiểu requirements.

**Thực hành bắt buộc:**

- **Diễn đạt lại requirements** bằng lời của mình trước khi bắt tay vào code. Viết 2-3 câu tóm tắt trong ticket: "Tôi hiểu task này là..."
- **Hỏi khi không rõ.** "Tôi không hiểu" là câu nói dũng cảm nhất, không phải yếu đuối nhất. Hỏi sớm tiết kiệm hơn sửa muộn.
- **Nhìn đúng thực trạng codebase.** Test coverage 80% nhưng toàn test trivial? Thừa nhận. "Nó vẫn chạy" không có nghĩa là "nó đúng."

**Anti-pattern:** Nhận ticket → code ngay → submit PR → reviewer phát hiện hiểu sai requirements → rewrite. Lãng phí 2x thời gian.

**Checklist trước khi code:**

- [ ] Tôi có thể giải thích task này cho người không-technical hiểu?
- [ ] Tôi biết acceptance criteria cụ thể là gì?
- [ ] Tôi biết task này ảnh hưởng những phần nào của hệ thống?

---

### 2. Chánh Tư Duy — Nghĩ Trước Khi Code

**Nguyên tắc:** 10 phút plan tiết kiệm 2 giờ debug. Design trước, code sau.

**Thực hành bắt buộc:**

- **Viết approach trước khi code.** Comment trong ticket hoặc PR description: "Approach: tôi sẽ X vì Y, alternative là Z nhưng không chọn vì W."
- **Không tham feature.** "Tiện thể thêm luôn cái này" = scope creep. Mỗi task làm đúng scope, không thêm không bớt.
- **Không tham abstraction.** Chưa cần thì chưa abstract. "Để sau này linh hoạt" thường biến thành "phức tạp mà không ai dùng." YAGNI.
- **Biết dừng.** Đã code 2 giờ mà approach rõ ràng sai? Dừng. Hỏi đồng nghiệp. Sunk cost không phải lý do tiếp tục.

**Anti-pattern:** Mở IDE, code ngay, refactor 3 lần, cuối cùng approach lại giống ý ban đầu của reviewer. Plan trước sẽ tránh được vòng lặp này.

---

### 3. Chánh Ngữ — Giao Tiếp Rõ Ràng

**Nguyên tắc:** Code là giao tiếp. Naming, comments, commit messages, docs — tất cả đều là "lời nói" của developer.

**Naming conventions:**

- Tên biến/hàm phải nói lên ý nghĩa mà không cần comment. `getUserById(id)` chứ không phải `get(x)`.
- Boolean bắt đầu bằng `is`, `has`, `should`, `can`. VD: `isExpired`, `hasPermission`.
- Hàm bắt đầu bằng verb. VD: `calculateTotal()`, `validateInput()`, `sendNotification()`.

**Commit messages:**

```
Format: <type>(<scope>): <description>

Types: feat, fix, refactor, docs, test, chore

VD tốt:  fix(payment): handle race condition when concurrent requests exceed pool limit
VD tệ:   fix bug
VD tệ:   WIP
VD tệ:   update
```

**PR descriptions:**

- Mô tả WHY (tại sao thay đổi) trước WHAT (thay đổi gì)
- Có screenshot/recording nếu liên quan UI
- Tag related tickets

**Anti-pattern:** Biến `temp`, `data`, `x`, `thing`. Commit "fix". PR description trống. Đồng nghiệp đọc code 6 tháng sau không hiểu gì.

---

### 4. Chánh Nghiệp — Code Có Trách Nhiệm

**Nguyên tắc:** Mỗi dòng code là một hành động có hậu quả. Code an toàn, test kỹ, cleanup đàng hoàng.

**Thực hành bắt buộc:**

- **Validate input ở mọi boundary.** API endpoint, function params, user input — validate hết. Trust nothing.
- **Handle errors explicitly.** Không nuốt exception. Không `catch(e) {}` rồi bỏ trống. Log error, return meaningful message, hoặc propagate lên.
- **Test trước khi merge.** Không merge code chưa test. Unit test cho logic phức tạp. Integration test cho critical paths. "Nó chạy trên máy tôi" không phải test.
- **Cleanup after yourself.** Xóa dead code, unused imports, commented-out code. Merge PR xong, xóa branch. Tech debt tạo ra phải tạo ticket track.

**Security checklist (cho mọi PR):**

- [ ] Input đã validate/sanitize?
- [ ] Không hardcode secrets?
- [ ] SQL queries dùng parameterized queries?
- [ ] Sensitive data đã mask trong logs?

---

### 5. Chánh Mạng — Xây Product Có Ý Nghĩa

**Nguyên tắc:** Chúng ta xây product để giúp user, không phải để hại user.

**Team agreements:**

- Không implement dark patterns dù PM yêu cầu. Push back bằng data: "Pattern này tăng conversion nhưng tăng churn rate."
- Accessibility là requirement, không phải nice-to-have. Mọi feature phải accessible cho người khuyết tật.
- Privacy by design. Thu thập minimum data cần thiết. Có clear opt-out cho mọi data collection.
- Nếu không thoải mái giải thích feature cho user nghe, đặt câu hỏi lại với team.

---

### 6. Chánh Tinh Tấn — Nỗ Lực Đúng Chỗ

**Nguyên tắc:** Không phải làm nhiều hơn mà làm đúng hơn. 2 giờ focused > 6 giờ fragmented.

**Thực hành bắt buộc:**

- **Deep work blocks.** Mỗi ngày có ít nhất 1 block 2 giờ không meeting, không Slack (trừ urgent). Team tôn trọng deep work time của nhau.
- **80/20 effort.** Test 5 critical paths trước khi test 50 edge cases. Optimize 1 bottleneck trước khi micro-optimize 10 non-bottlenecks.
- **Tránh yak shaving.** Đang fix bug → "à tiện refactor cái này" → "à cần update dependency trước" → 3 giờ sau vẫn chưa fix bug. Nhận ra khi đang shaving và quay lại task gốc.
- **Sustainable pace.** Crunch 1 tuần trước deadline OK. Crunch 3 tháng liên tục: bugs tăng, morale giảm, turnover tăng. Nếu phải crunch liên tục, vấn đề ở scope/planning, không phải ở effort.

**Anti-pattern:** "Busy" ≠ "Productive". 10 giờ ở office mà 4 giờ code thực sự = 4 giờ productivity. 6 giờ focused code = 6 giờ productivity.

---

### 7. Chánh Niệm — Chú Ý Khi Code

**Nguyên tắc:** Đọc kỹ, review kỹ, không auto-pilot.

**Thực hành bắt buộc:**

- **Đọc error message trước khi Google.** Error message thường chứa chính xác thông tin bạn cần. 5 giây đọc kỹ tiết kiệm 15 phút Google.
- **`git diff --staged` trước mỗi commit.** Đọc từng dòng. Có debug log quên xóa? Có file không nên commit? 30 giây review tiết kiệm 30 phút revert.
- **Đọc kỹ code khi copy-paste.** Copy từ Stack Overflow? Hiểu mỗi dòng trước khi paste. Copy từ codebase? Check context có giống nhau không.
- **Nhận biết trạng thái bản thân.** Mệt? Code quality giảm. Frustrated? Dễ skip edge cases. Đi break 10 phút rồi quay lại tốt hơn ép code thêm 1 giờ.

**Code review mindfulness:**

- Đọc PR title và description trước khi xem code
- Hiểu context (WHY) trước khi đánh giá implementation (WHAT)
- Review khi tỉnh táo, không review cuối ngày khi mệt
- Mỗi PR dành ít nhất 15 phút — nếu ít hơn, có thể đang skim thay vì review

---

### 8. Chánh Định — Flow State & Deep Focus

**Nguyên tắc:** Tập trung sâu vào một việc tại một thời điểm.

**Thực hành bắt buộc:**

- **Single-tasking.** Một ticket tại một thời điểm. Context switching tốn 23 phút để regain focus. Hoàn thành task A rồi mới bắt đầu task B.
- **Protect flow state.** Khi đang trong flow, snooze notifications, đeo headphones. Đồng nghiệp cần gì urgent thì tap vai — không Slack khi thấy người đang focused.
- **Meeting-free mornings (team agreement).** Buổi sáng dành cho deep work. Meetings dồn sau 2 PM. Nếu phải có morning meeting, tối đa 30 phút.
- **Warm-up rituals.** Đầu ngày: 5 phút review code hôm qua, xem TODO list, đọc lại ticket. Giống warm-up trước khi tập thể thao — không nhảy ngay vào task phức tạp.

**Team norms cho focus:**

- Slack DM: expect reply trong 30 phút (không phải ngay lập tức)
- Channel messages: expect reply trong 2 giờ
- Urgent: gọi điện hoặc tap vai trực tiếp
- Không ai bị "trách" vì reply Slack chậm khi đang deep work

---

## Cách Dùng Guideline Này

1. **Onboarding:** Thành viên mới đọc toàn bộ guideline trong tuần đầu
2. **Hàng ngày:** Reference khi code, review, hoặc plan
3. **Sprint retro:** Pick 1-2 nhánh để team focus cải thiện sprint tiếp theo
4. **Code review:** Reviewer có thể reference nhánh cụ thể khi comment. VD: "Chánh Ngữ — naming hàm này chưa rõ ý"
5. **1:1:** Manager dùng 8 nhánh làm framework đánh giá và coaching

---

## Nhắc Nhở

Guideline không phải checklist làm xong rồi bỏ. Đó là **8 chiều thực hành đồng thời, suốt career.** Không ai "hoàn thành" Bát Chánh Đạo — chỉ có tiến bộ dần.

Junior bắt đầu với **Chánh Niệm** (chú ý khi code) và **Chánh Ngữ** (naming rõ ràng). Quen rồi mở rộng sang các nhánh khác. Trung Đạo cũng áp dụng cho cách thực hành guideline này — không ép quá chặt, không bỏ qua hoàn toàn.

---

*Ví dụ này minh họa cách dùng Bát Chánh Đạo làm khung tổ chức cho coding guideline. 8 nhánh = 8 section rõ ràng, dễ nhớ, dễ reference. Team có thể customize từng section theo ngôn ngữ, framework, và culture riêng.*
