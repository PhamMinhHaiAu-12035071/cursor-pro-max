# Ví Dụ Input/Output Mẫu

Các ví dụ hoàn chỉnh về cách skill này xử lý input và tạo output.

---

## Ví Dụ 1: Nhiều Lỗi Cơ Bản

### Input

```
I goes to school yesterday and I meet my friend. He give me a book. The book is very interest.
```

### Output

## ✅ Câu đã sửa

I went to school yesterday and met my friend. He gave me a book. The book is very interesting.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | I goes | I went | Hòa hợp chủ-vị + Thì |
| 2 | I meet | (I) met | Nhất quán thì |
| 3 | He give | He gave | Hòa hợp chủ-vị + Thì |
| 4 | is very interest | is very interesting | Dạng từ |

## 📚 Giải thích chi tiết

### Lỗi 1: Hòa hợp chủ-vị + Thì

**Sai**: I goes to school yesterday
**Đúng**: I went to school yesterday

**Quy tắc**:
Hai vấn đề ở đây:
1. "Goes" chỉ dùng cho ngôi thứ 3 số ít (he/she/it), không dùng cho "I"
2. "Yesterday" là dấu hiệu quá khứ → phải dùng thì quá khứ đơn

**Ví dụ thêm**:
- ❌ She go to work every day.
- ✅ She goes to work every day. (hiện tại đơn - thói quen)
- ❌ I goes to the market last week.
- ✅ I went to the market last week. (quá khứ đơn)

**Mẹo nhớ**: "Thấy yesterday/last week/ago → dùng V2/Ved ngay"

---

### Lỗi 2: Nhất quán thì

**Sai**: yesterday and I meet my friend
**Đúng**: yesterday and met my friend

**Quy tắc**:
Khi hai hành động xảy ra trong cùng một thời điểm quá khứ, cả hai động từ đều phải ở thì quá khứ.

**Ví dụ thêm**:
- ❌ I woke up and eat breakfast.
- ✅ I woke up and ate breakfast.

**Mẹo nhớ**: "Cùng thời gian → cùng thì"

---

### Lỗi 3: Hòa hợp chủ-vị + Thì

**Sai**: He give me a book
**Đúng**: He gave me a book

**Quy tắc**:
- "He" là ngôi thứ 3 số ít → ở hiện tại đơn sẽ là "gives"
- Nhưng câu đang kể về quá khứ → phải dùng "gave"

**Ví dụ thêm**:
- ❌ She give me her number yesterday.
- ✅ She gave me her number yesterday.

---

### Lỗi 4: Dạng từ (Word Form)

**Sai**: The book is very interest
**Đúng**: The book is very interesting

**Quy tắc**:
Sau động từ "be" (is, am, are, was, were) phải dùng tính từ, không phải danh từ.
- "interest" = danh từ (sự quan tâm)
- "interesting" = tính từ (thú vị)

**Ví dụ thêm**:
- ❌ This movie is very excite.
- ✅ This movie is very exciting.
- ❌ She is beauty.
- ✅ She is beautiful.

**Mẹo nhớ**: "Sau BE phải là tính từ"

---

## 💡 Gợi ý học tập

Bạn mắc 3/4 lỗi liên quan đến **thì và hòa hợp chủ-vị**. Đây là lỗi rất phổ biến của người Việt vì tiếng Việt không chia thì và không thay đổi động từ theo chủ ngữ.

**Gợi ý**:
1. Khi viết, xác định thời gian trước (hiện tại hay quá khứ?)
2. Sau đó chia động từ cho phù hợp
3. Kiểm tra lại xem tất cả động từ có cùng thì không

---

## Ví Dụ 2: Lỗi Mạo Từ và Giới Từ

### Input

```
I am student at university. My class depend of the schedule. I am interested at learning English.
```

### Output

## ✅ Câu đã sửa

I am a student at a university. My class depends on the schedule. I am interested in learning English.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | I am student | I am a student | Thiếu mạo từ |
| 2 | at university | at a university | Thiếu mạo từ |
| 3 | depend of | depends on | Giới từ + Hòa hợp chủ-vị |
| 4 | interested at | interested in | Giới từ |

## 📚 Giải thích chi tiết

### Lỗi 1 & 2: Thiếu mạo từ

**Sai**: I am student at university
**Đúng**: I am a student at a university

**Quy tắc**:
Danh từ số ít đếm được (student, university) phải có mạo từ đứng trước. Vì đang nói chung chung, chưa xác định cụ thể → dùng "a/an".

**Tại sao người Việt hay quên**:
Tiếng Việt không có mạo từ. "Tôi là sinh viên" - không cần "một".

**Ví dụ thêm**:
- ❌ She is doctor.
- ✅ She is a doctor.
- ❌ I bought book.
- ✅ I bought a book.

**Mẹo nhớ**: "Danh từ số ít đếm được = phải có a/an hoặc the"

---

### Lỗi 3: Giới từ + Hòa hợp chủ-vị

**Sai**: My class depend of
**Đúng**: My class depends on

**Quy tắc**:
1. "depend" đi với giới từ "on", không phải "of"
2. "My class" là số ít → động từ phải thêm -s

**Các cụm từ cần nhớ**:
- depend **on** (phụ thuộc vào)
- consist **of** (bao gồm)
- rely **on** (dựa vào)

**Mẹo nhớ**: "Depend đi với ON, không phải OF"

---

### Lỗi 4: Giới từ

**Sai**: interested at
**Đúng**: interested in

**Quy tắc**:
"Interested" luôn đi với giới từ "in".

**Các cụm từ tương tự**:
- interested **in** (quan tâm đến)
- good **at** (giỏi về)
- afraid **of** (sợ)

**Mẹo nhớ**: Học theo cụm: "interested IN", không học từ đơn lẻ.

---

## 💡 Gợi ý học tập

Bạn mắc 2 lỗi về **mạo từ** và 2 lỗi về **giới từ**. Đây là hai điểm yếu phổ biến nhất của người Việt.

**Gợi ý**:
1. Khi viết danh từ số ít, luôn hỏi: "Có cần a/an/the không?"
2. Học giới từ theo cụm từ cố định (collocations), đừng đoán

---

## Ví Dụ 3: Câu Đúng Ngữ Pháp

### Input

```
I have been studying English for three years. Every day, I practice speaking with my friends.
```

### Output

## ✅ Câu đã sửa

I have been studying English for three years. Every day, I practice speaking with my friends.

*(Không có lỗi ngữ pháp)*

## 📝 Nhận xét

Câu của bạn đã đúng ngữ pháp! Một vài điểm hay:

1. **Present perfect continuous** (have been studying) dùng đúng với "for three years"
2. **Present simple** (practice) dùng đúng với "every day" để diễn tả thói quen
3. Cấu trúc câu rõ ràng, mạch lạc

Tiếp tục phát huy! 🎉

---

## Ví Dụ 4: Lỗi Nâng Cao

### Input

```
The informations you gave me is very useful. I have much friends who need this advices.
```

### Output

## ✅ Câu đã sửa

The information you gave me is very useful. I have many friends who need this advice.

## ❌ Lỗi phát hiện

| # | Lỗi gốc | Sửa thành | Loại lỗi |
|---|---------|-----------|----------|
| 1 | informations | information | Danh từ không đếm được |
| 2 | much friends | many friends | Much/Many |
| 3 | this advices | this advice | Danh từ không đếm được |

## 📚 Giải thích chi tiết

### Lỗi 1 & 3: Danh từ không đếm được

**Sai**: informations, advices
**Đúng**: information, advice

**Quy tắc**:
"Information" và "advice" là danh từ không đếm được → không bao giờ thêm -s.

**Danh từ không đếm được phổ biến**:
- information (thông tin)
- advice (lời khuyên)
- news (tin tức)
- furniture (đồ nội thất)
- homework (bài tập về nhà)
- research (nghiên cứu)

**Nếu muốn đếm**:
- a piece of information
- a piece of advice
- a piece of news

---

### Lỗi 2: Much vs Many

**Sai**: much friends
**Đúng**: many friends

**Quy tắc**:
- "Many" đi với danh từ đếm được (friends, books, cars)
- "Much" đi với danh từ không đếm được (water, time, money)

**Mẹo nhớ**: "Many đếm được, much không đếm"

**Nếu không chắc**: Dùng "a lot of" - dùng được cho cả hai!
- I have a lot of friends. ✅
- I have a lot of money. ✅

---

## 💡 Gợi ý học tập

Bạn cần ghi nhớ danh sách các danh từ không đếm được phổ biến. Đây là lỗi khá phổ biến vì tiếng Việt không phân biệt rõ ràng giữa đếm được và không đếm được.
