# Ví Dụ Cơ Bản (Vietnamese Basic Example)

## Optimization Level: ⚡ Quick Boost (Tối Ưu Nhanh)

**Chủ đề:** Cải thiện prompt cơ bản bằng tiếng Việt  
**Thời gian:** 5-15 phút  
**Kỹ thuật áp dụng:** Vai trò (Role), Ngữ cảnh (Context), Định dạng (Format)

---

## Tại Sao Cần Tối Ưu Prompt?

**Vấn đề:** Prompt mơ hồ → Kết quả AI không như mong muốn

**Ví dụ thực tế:**
- Bạn: "Viết code"
- AI: "...viết code gì?" (AI confused)

**Giải pháp:** Nói rõ ràng, cụ thể, đầy đủ

---

## Phase 1: Hội Thoại Tương Tác (Interactive Dialogue)

**Optimization Level:** ⚡ Quick Boost (0-2 câu hỏi quan trọng)

**Chiến lược:**
- Phát hiện ngôn ngữ: Tiếng Việt
- Hỏi 0-2 câu quan trọng nhất để làm rõ prompt
- Sử dụng AskUserQuestion tool với tiếng Việt

### Ví Dụ 1: "Viết code"

**Initial Prompt:** "Viết code."

**Phân tích:** Prompt quá mơ hồ - không biết ngôn ngữ, không biết chức năng

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "ngon-ngu",
      "prompt": "Bạn muốn viết code bằng ngôn ngữ lập trình nào?",
      "options": [
        {"id": "python", "label": "Python (dễ học, đa năng)"},
        {"id": "javascript", "label": "JavaScript (web, frontend/backend)"},
        {"id": "java", "label": "Java (ứng dụng doanh nghiệp)"},
        {"id": "php", "label": "PHP (web backend)"},
        {"id": "other", "label": "Khác (nêu rõ)"}
      ]
    },
    {
      "id": "chuc-nang",
      "prompt": "Code cần làm gì?",
      "options": [
        {"id": "xu-ly-du-lieu", "label": "Xử lý dữ liệu (đọc, ghi file, database)"},
        {"id": "tinh-toan", "label": "Tính toán (thuật toán, logic)"},
        {"id": "web-api", "label": "Web API (server, endpoints)"},
        {"id": "giao-dien", "label": "Giao diện (UI, form, trang web)"},
        {"id": "automation", "label": "Automation (tự động hóa tác vụ)"}
      ]
    }
  ]
}
```

**Câu trả lời của User:**
```json
{
  "ngon-ngu": "python",
  "chuc-nang": "xu-ly-du-lieu"
}
```

**Phân tích:**
- Ngôn ngữ: Python
- Chức năng: Xử lý dữ liệu
- Đã đủ thông tin cơ bản để tạo prompt tốt hơn

**Kết quả:** Chuyển sang Phase 2 (Blueprint) với context rõ ràng

### Ví Dụ 2: "Viết bài viết"

**Initial Prompt:** "Viết bài viết."

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "chu-de",
      "prompt": "Bài viết về chủ đề gì?",
      "options": [
        {"id": "cong-nghe", "label": "Công nghệ (AI, lập trình, tech trends)"},
        {"id": "kinh-doanh", "label": "Kinh doanh (marketing, sales, startup)"},
        {"id": "giao-duc", "label": "Giáo dục (học tập, kỹ năng)"},
        {"id": "lifestyle", "label": "Lifestyle (sức khỏe, du lịch, ăn uống)"},
        {"id": "other", "label": "Khác (nêu rõ)"}
      ]
    },
    {
      "id": "dinh-dang",
      "prompt": "Định dạng bài viết?",
      "options": [
        {"id": "blog-post", "label": "Blog post (dài, chi tiết)"},
        {"id": "social-media", "label": "Social media (ngắn, hấp dẫn)"},
        {"id": "huong-dan", "label": "Hướng dẫn (how-to, step-by-step)"},
        {"id": "danh-sach", "label": "Danh sách (listicle, top 10)"}
      ]
    }
  ]
}
```

**Câu trả lời của User:**
```json
{
  "chu-de": "cong-nghe",
  "dinh-dang": "huong-dan"
}
```

**Phân tích:**
- Chủ đề: Công nghệ
- Định dạng: Hướng dẫn (how-to)
- Context đã rõ, có thể tạo prompt tối ưu

### Ví Dụ 3: "Giúp tôi với dự án"

**Initial Prompt:** "Giúp tôi với dự án."

**AskUserQuestion Tool Call:**

```json
{
  "questions": [
    {
      "id": "loai-du-an",
      "prompt": "Đây là dự án gì?",
      "options": [
        {"id": "web-app", "label": "Web application (trang web, web app)"},
        {"id": "mobile-app", "label": "Mobile app (iOS, Android)"},
        {"id": "data-analysis", "label": "Phân tích dữ liệu (data science, ML)"},
        {"id": "automation", "label": "Automation (script, bot, tool)"},
        {"id": "other", "label": "Khác (nêu rõ)"}
      ]
    }
  ]
}
```

**Câu trả lời của User:**
```json
{
  "loai-du-an": "web-app"
}
```

**Follow-up Question (Round 2):**

```json
{
  "questions": [
    {
      "id": "tro-giup-gi",
      "prompt": "Bạn cần giúp gì cụ thể cho web app này?",
      "options": [
        {"id": "bat-dau", "label": "Bắt đầu từ đầu (setup, cấu trúc)"},
        {"id": "sua-loi", "label": "Sửa lỗi (debugging)"},
        {"id": "them-tinh-nang", "label": "Thêm tính năng mới"},
        {"id": "toi-uu", "label": "Tối ưu (performance, UX)"},
        {"id": "review-code", "label": "Review code"}
      ]
    }
  ]
}
```

**Câu trả lời của User:**
```json
{
  "tro-giup-gi": "them-tinh-nang"
}
```

**Final Understanding:**
- Dự án: Web application
- Cần: Thêm tính năng mới
- Có thể tạo prompt chi tiết

### Khi KHÔNG Cần Hỏi (Prompt Đã Rõ)

**Ví dụ prompt rõ ràng:**
"Viết hàm Python để đọc file CSV và tính tổng cột 'revenue'. Xử lý exception nếu file không tồn tại."

**Phân tích:**
- ✅ Ngôn ngữ rõ: Python
- ✅ Chức năng rõ: Đọc CSV, tính tổng
- ✅ Yêu cầu rõ: Exception handling

**Quyết định:** KHÔNG cần hỏi thêm → Chuyển thẳng sang Phase 2 (Blueprint)

---

## Ví Dụ 1: Viết Code

### ❌ Trước Khi Tối Ưu (Mơ Hồ)

```
Viết code.
```

**Vấn đề:**
- Không biết ngôn ngữ nào (Python? JavaScript? Java?)
- Không biết làm gì
- Không có yêu cầu cụ thể

**Kết quả:** AI đoán mò, cho code không đúng ý bạn

---

### ✅ Sau Khi Tối Ưu (Rõ Ràng)

```
Viết hàm Python để kiểm tra email hợp lệ.

Yêu cầu:
- Input: Chuỗi email (string)
- Output: True nếu hợp lệ, False nếu không hợp lệ
- Kiểm tra: Có ký tự @, có tên miền, có đuôi (.com, .vn...)

Kèm theo:
- Docstring (chú thích hàm)
- Ví dụ sử dụng
- Test cases (ít nhất 3 trường hợp)
```

**Cải thiện:**
- ✅ Ngôn ngữ: Python (rõ ràng)
- ✅ Chức năng: Kiểm tra email (cụ thể)
- ✅ Yêu cầu: Liệt kê đầy đủ
- ✅ Kèm theo: Docstring, example, tests

**Kết quả:**
```python
def kiem_tra_email_hop_le(email: str) -> bool:
    """
    Kiểm tra xem email có hợp lệ hay không.
    
    Args:
        email (str): Chuỗi email cần kiểm tra
        
    Returns:
        bool: True nếu email hợp lệ, False nếu không
        
    Examples:
        >>> kiem_tra_email_hop_le("test@example.com")
        True
        >>> kiem_tra_email_hop_le("invalid-email")
        False
    """
    import re
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(pattern, email))


# Test cases
assert kiem_tra_email_hop_le("user@example.com") == True
assert kiem_tra_email_hop_le("invalid") == False
assert kiem_tra_email_hop_le("test@domain.vn") == True
```

**Độ cải thiện:**
- Rõ ràng: +70%
- Đúng yêu cầu: +80%
- Có thể dùng ngay: +90%

---

## Ví Dụ 2: Giải Thích Khái Niệm

### ❌ Trước Khi Tối Ưu

```
Giải thích API.
```

**Vấn đề:**
- Quá chung chung
- Không biết đối tượng đọc là ai (beginner? expert?)
- Không biết giải thích sâu hay nông

---

### ✅ Sau Khi Tối Ưu

```
Giải thích API (Application Programming Interface) cho người mới học lập trình.

Yêu cầu:
- Dùng ngôn ngữ đơn giản, dễ hiểu
- Có ví dụ cụ thể (ví dụ trong đời sống)
- Giải thích tại sao cần API
- Ví dụ code đơn giản (nếu được)

Format:
1. Định nghĩa (2-3 câu)
2. Ví dụ thực tế (so sánh với đời sống)
3. Tại sao cần API?
4. Ví dụ code đơn giản

Độ dài: ~300 từ
```

**Kết quả:**

```markdown
# API là gì?

## 1. Định Nghĩa

API (Application Programming Interface) là "cầu nối" giữa các ứng dụng,
giúp chúng nói chuyện với nhau. Giống như menu nhà hàng: bạn không cần
biết bếp làm món ăn thế nào, chỉ cần gọi món từ menu là được.

## 2. Ví Dụ Thực Tế

**Ví dụ: Đặt Grab**
- Bạn mở app Grab → nhấn "Đặt xe"
- Grab app gọi API của Google Maps → lấy vị trí bạn
- Grab API tìm tài xế gần nhất
- Bạn nhận thông tin xe

**API ở đây:** Cầu nối giữa Grab và Google Maps.
Grab không cần tự làm bản đồ, chỉ cần "hỏi" Google Maps qua API.

## 3. Tại Sao Cần API?

- **Tiết kiệm thời gian:** Không cần làm lại tính năng có sẵn
- **Chuyên môn hóa:** Mỗi app làm tốt việc của mình
- **Kết nối:** Apps có thể làm việc cùng nhau

**Ví dụ:** Facebook Login API → Bạn không cần tạo hệ thống đăng nhập
riêng, chỉ cần dùng Facebook API.

## 4. Ví Dụ Code Đơn Giản

\`\`\`python
import requests

# Gọi API lấy thông tin thời tiết
response = requests.get("https://api.weather.com/hanoi")
weather = response.json()

print(f"Nhiệt độ Hà Nội: {weather['temperature']}°C")
\`\`\`

**Giải thích:**
- `requests.get()`: "Gọi" API (như gọi món ăn)
- API trả về dữ liệu thời tiết (như nhà hàng mang món ra)
- Bạn dùng dữ liệu đó (ăn món)

**Tóm tắt:** API = Menu giúp apps "gọi món" từ nhau!
```

**Độ cải thiện:**
- Dễ hiểu: +80%
- Có ví dụ thực tế: +90%
- Nhớ lâu (có so sánh đời sống): +70%

---

## Ví Dụ 3: Thiết Kế Cơ Sở Dữ Liệu

### ❌ Trước Khi Tối Ưu

```
Thiết kế database.
```

**Vấn đề:**
- Không biết cho hệ thống gì (blog? shop? banking?)
- Không biết dùng SQL hay NoSQL
- Không có yêu cầu cụ thể

---

### ✅ Sau Khi Tối Ưu

```
Thiết kế cơ sở dữ liệu cho website bán sách online.

Ngữ cảnh:
- Website nhỏ: Dự kiến 1,000 users, 10,000 sách
- Chức năng: Users đăng ký, tìm sách, mua sách, để lại review
- Công nghệ: PostgreSQL (SQL database)

Yêu cầu:
- Thiết kế các bảng (tables) cần thiết
- Xác định quan hệ giữa các bảng (relationships)
- Đề xuất indexes cho tìm kiếm nhanh

Output mong muốn:
- Sơ đồ các bảng (table definitions)
- Mối quan hệ (ERD - Entity Relationship)
- Giải thích tại sao thiết kế như vậy
```

**Kết quả:**

```markdown
# Thiết Kế Database: Website Bán Sách

## Các Bảng (Tables)

### 1. Bảng `users` (Người dùng)
\`\`\`sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
\`\`\`

### 2. Bảng `books` (Sách)
\`\`\`sql
CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_books_title ON books(title);
CREATE INDEX idx_books_author ON books(author);
\`\`\`

### 3. Bảng `orders` (Đơn hàng)
\`\`\`sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_orders_user_id ON orders(user_id);
\`\`\`

### 4. Bảng `order_items` (Chi tiết đơn hàng)
\`\`\`sql
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    book_id INT REFERENCES books(id),
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
\`\`\`

### 5. Bảng `reviews` (Đánh giá)
\`\`\`sql
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    book_id INT REFERENCES books(id),
    user_id INT REFERENCES users(id),
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_reviews_book_id ON reviews(book_id);
\`\`\`

## Sơ Đồ Quan Hệ (ERD)

\`\`\`
users (1) ----< (n) orders      [Một user có nhiều orders]
orders (1) ---< (n) order_items [Một order có nhiều items]
books (1) ----< (n) order_items [Một book có trong nhiều orders]
books (1) ----< (n) reviews     [Một book có nhiều reviews]
users (1) ----< (n) reviews     [Một user viết nhiều reviews]
\`\`\`

## Giải Thích Thiết Kế

**Tại sao tách `orders` và `order_items`?**
- Một đơn hàng (order) có nhiều sách (books)
- Cần lưu giá của sách tại thời điểm mua (giá có thể thay đổi sau)

**Tại sao có indexes?**
- `idx_users_email`: Tìm user khi đăng nhập (search by email)
- `idx_books_title`: Tìm sách theo tên (tính năng tìm kiếm)
- `idx_orders_user_id`: Lấy lịch sử đơn hàng của user

**Quan hệ quan trọng:**
- `REFERENCES`: Đảm bảo data integrity (không có order của user không tồn tại)
- `CHECK`: Đảm bảo rating từ 1-5 (không có rating 0 hoặc 10)
```

**Độ cải thiện:**
- Đầy đủ: +85%
- Có giải thích: +80%
- Thực tế, dùng được ngay: +90%

---

## Công Thức Tối Ưu Cơ Bản

### Công Thức 5W1H (Tiếng Việt)

```
WHAT (Cái gì):   Làm gì cụ thể? (viết hàm, giải thích, thiết kế...)
WHO (Ai):        Cho đối tượng nào? (beginner, expert...)
WHY (Tại sao):   Mục đích gì? (học, làm dự án, debug...)
WHERE (Ở đâu):   Môi trường nào? (Python, JavaScript, SQL...)
WHEN (Khi nào):  Điều kiện gì? (input/output...)
HOW (Như thế nào): Format đầu ra? (code, giải thích, bảng...)
```

### Template Prompt Cơ Bản

```
[Nhiệm vụ cụ thể] + [Ngôn ngữ/công nghệ] + [Đối tượng]

Yêu cầu:
- [Yêu cầu 1]
- [Yêu cầu 2]
- [Yêu cầu 3]

Kèm theo: [docstring, examples, tests...]
```

---

## Mẹo Ghi Nhớ (Memory Tips)

### Mẹo 1: RCF (Role - Context - Format)

```
R (Role - Vai trò):      Bạn là lập trình viên Python
C (Context - Ngữ cảnh):  Viết hàm kiểm tra email
F (Format - Định dạng):  Code + docstring + examples
```

**Nhớ:** "RồI Cần phải Format" (R-C-F)

### Mẹo 2: So Sánh Đời Sống

**Prompt mơ hồ** = Đi nhà hàng nói "Cho tôi đồ ăn" (???)  
**Prompt tốt** = "Cho tôi phở bò, không hành, thêm chanh" (rõ ràng!)

### Mẹo 3: Checklist Nhanh

Trước khi gửi prompt, tự hỏi:
- [ ] Đã nói rõ ngôn ngữ/công nghệ? (Python, SQL...)
- [ ] Đã mô tả nhiệm vụ cụ thể? (không mơ hồ)
- [ ] Đã liệt kê yêu cầu? (2-3 điểm)
- [ ] Đã nói rõ format output? (code? giải thích? bảng?)

Nếu thiếu → Bổ sung trước khi gửi!

---

## Lỗi Thường Gặp (Common Mistakes)

### Lỗi 1: Quá Ngắn Gọn

❌ **Sai:** "Code Python"  
✅ **Đúng:** "Viết hàm Python tính giai thừa với input n, output n!"

**Tại sao sai:** AI không biết viết gì

### Lỗi 2: Quá Chung Chung

❌ **Sai:** "Làm tốt nhé"  
✅ **Đúng:** "Code phải có docstring, type hints, và test cases"

**Tại sao sai:** "Tốt" nghĩa là gì? Không cụ thể.

### Lỗi 3: Không Có Ngữ Cảnh

❌ **Sai:** "Fix bug này"  
✅ **Đúng:** "Fix bug: Hàm login trả về error 500 khi password có ký tự đặc biệt"

**Tại sao sai:** AI không biết bug gì, ở đâu, triệu chứng thế nào.

---

## Bài Tập Thực Hành

### Bài 1: Cải Thiện Prompt

**Prompt gốc (mơ hồ):**
```
Viết function sort.
```

**Nhiệm vụ của bạn:** Áp dụng RCF (Role-Context-Format) để cải thiện.

<details>
<summary>Xem gợi ý đáp án</summary>

```
Bạn là lập trình viên Python.

Viết hàm sắp xếp (sort) một list số nguyên theo thứ tự tăng dần.

Yêu cầu:
- Dùng thuật toán Quick Sort
- Có docstring
- Có type hints
- Có ví dụ sử dụng

Output: Code Python hoàn chỉnh
```
</details>

---

### Bài 2: Tìm Lỗi Trong Prompt

**Prompt có vấn đề:**
```
Giải thích cách làm app. Phải hay và dễ hiểu.
```

**Tìm lỗi:** Prompt này thiếu gì? Mơ hồ ở đâu?

<details>
<summary>Xem đáp án</summary>

**Các lỗi:**
1. "App" quá chung (app gì? web? mobile? game?)
2. "Cách làm" không cụ thể (thiết kế? code? deploy?)
3. "Hay và dễ hiểu" không đo được (hay = thế nào?)
4. Không nói đối tượng đọc (beginner? expert?)
5. Không nói format output

**Cải thiện:**
```
Giải thích các bước cơ bản để làm một web app đơn giản cho người mới học.

Yêu cầu:
- Công nghệ: HTML, CSS, JavaScript cơ bản
- Các bước: Từ thiết kế đến deploy
- Format: Danh sách 5-7 bước, mỗi bước có giải thích ngắn

Đối tượng: Sinh viên năm 1 IT, biết lập trình cơ bản
```
</details>

---

## Tóm Tắt

**Nguyên tắc vàng:** Càng rõ ràng, càng tốt!

**Ba bước tối ưu nhanh:**
1. **R (Role):** Bạn là [chuyên gia gì]
2. **C (Context):** Làm [gì] với [yêu cầu cụ thể]
3. **F (Format):** Output dạng [code/giải thích/bảng]

**Kết quả:**
- Rõ ràng: +70%
- Đúng yêu cầu: +80%
- Tiết kiệm thời gian: +50% (ít phải hỏi lại)

**Mẹo nhớ:** Prompt = Menu nhà hàng. Gọi món càng rõ, nhà hàng làm càng đúng ý!

---

**Bước tiếp theo:**
- Thực hành với 3 ví dụ trên
- Làm 2 bài tập
- Đọc `advanced-vietnamese.md` khi đã thành thạo cơ bản

**Tài liệu liên quan:**
- `../../references/vietnamese-guide.md` - Hướng dẫn đầy đủ
- `../quick-boost/` - Thêm ví dụ tiếng Anh
- `../../references/optimization-toolkit.md` - Kỹ thuật nâng cao
