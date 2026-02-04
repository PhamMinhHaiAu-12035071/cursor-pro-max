# Interview - Phỏng Vấn Chi Tiết Cho Implementation/Migration

Công cụ phỏng vấn có cấu trúc để thu thập đầy đủ thông tin trước khi triển khai/migration bất kỳ tính năng hoặc thay đổi nào trong dự án.

## 📑 Mục Lục

- [Mục Đích](#mục-đích)
- [Khi Nào Sử Dụng](#khi-nào-sử-dụng)
- [Quy Trình](#quy-trình)
- [Phạm Vi Câu Hỏi](#phạm-vi-câu-hỏi)
- [Nguyên Tắc Phỏng Vấn](#nguyên-tắc-phỏng-vấn)
- [Output & Deliverables](#output--deliverables)
- [Ví Dụ](#ví-dụ)

---

## Mục Đích

Command này giúp bạn:

- ✅ Thu thập requirements đầy đủ, rõ ràng trước khi code
- ✅ Tránh thiếu sót thông tin quan trọng
- ✅ Hiểu rõ constraints và tradeoffs
- ✅ Xác định deliverables cụ thể (không mơ hồ)
- ✅ Nghĩ đến edge cases và lỗi tiềm ẩn
- ✅ Có plan implementation chi tiết và thực tế

**Triết lý**: "Measure twice, cut once" - Thu thập thông tin kỹ lưỡng để implementation nhanh và chính xác.

---

## Khi Nào Sử Dụng

Sử dụng `/interview` khi bạn:

- 🆕 **Bắt đầu feature mới**: Cần hiểu requirements đầy đủ
- 🔄 **Migration/Refactoring**: Cần biết scope và ảnh hưởng
- 🐛 **Fix bug phức tạp**: Cần hiểu root cause và context
- 🏗️ **Architectural decision**: Cần cân nhắc tradeoffs
- 📦 **Integration với hệ thống khác**: Cần biết interfaces và constraints
- 🎨 **UI/UX changes**: Cần hiểu user flows và requirements
- 🔐 **Security/Performance critical**: Cần đánh giá kỹ lưỡng

**Không dùng khi**:
- ❌ Câu hỏi đơn giản, đã rõ ràng
- ❌ Quick fixes không ảnh hưởng lớn
- ❌ Đã có đầy đủ thông tin và plan

---

## Quy Trình

Command này hoạt động theo 3 phases:

### Phase 1: Discovery & Context Gathering

**Mục tiêu**: Tự động thu thập thông tin từ codebase để giảm số câu hỏi cần thiết.

**Hoạt động**:
1. 📖 **Đọc cấu trúc dự án**: Hiểu architecture tổng thể
2. 🔍 **Scan code liên quan**: Tìm patterns, conventions, existing implementations
3. 📋 **Đọc configs**: package.json, tsconfig.json, framework configs
4. 📚 **Kiểm tra docs**: README, ARCHITECTURE.md, API docs
5. 🎯 **Xác định area of interest**: Focus vào phần cần implement

**Output**: Context summary về:
- Công nghệ stack hiện tại
- Patterns và conventions đang dùng
- Related code/files
- Potential constraints

**Duration**: 30-60 giây

---

### Phase 2: Structured Interview

**Mục tiêu**: Hỏi câu hỏi có cấu trúc để thu thập mọi thông tin cần thiết.

**Đặc điểm**:
- ✅ **Tiếng Việt có dấu**, rõ ràng, dễ hiểu
- ✅ **Ưu tiên câu hỏi đóng**: Yes/No, Multiple choice (giảm mơ hồ nhanh hơn)
- ✅ **Luôn có gợi ý recommended**: Option tốt nhất theo AI analysis
- ✅ **3-5 câu mỗi lần**: Ngắn gọn, có cấu trúc
- ✅ **Hỏi từ tổng quan → chi tiết → xác nhận**
- ✅ **Hỏi tiếp nếu còn mơ hồ**: Không bỏ qua ambiguity

**Iteration Logic**:
```
WHILE (còn thông tin ambiguous hoặc thiếu) {
  1. Phân tích gaps trong knowledge
  2. Tạo 3-5 câu hỏi targeted
  3. Đặt câu hỏi với AskQuestion tool
  4. Phân tích câu trả lời
  5. Update knowledge base
  6. IF (câu trả lời unclear) {
       Hỏi follow-up ngay
     }
}
```

**Duration**: 2-5 phút (tùy độ phức tạp)

---

### Phase 3: Summary & Action Plan

**Mục tiêu**: Tổng hợp và đề xuất implementation plan.

**Output gồm 3 phần**:

#### 1. Structured Summary
```markdown
# Tổng Hợp Phỏng Vấn: [Feature Name]

## 📋 Core Functionality
- [Functionality 1]
- [Functionality 2]

## 🎯 User Flows
1. [Flow 1]
2. [Flow 2]

## 🔧 Technical Requirements
- Stack: [Technologies]
- Dependencies: [Packages needed]
- APIs: [Endpoints/Integrations]

## ⚠️ Constraints
- [Constraint 1]
- [Constraint 2]

## 🎨 UI/UX Requirements
- [UI Requirement 1]
- [Design decision 1]

## ⚖️ Tradeoffs & Decisions
- [Decision 1]: Chọn [Option A] vì [reasoning]
- [Decision 2]: Chọn [Option B] vì [reasoning]

## 🔐 Security Considerations
- [Security concern 1]
- [How to address it]

## ⚡ Performance Requirements
- [Performance goal 1]
- [Strategy to achieve]

## 🧪 Testing Strategy
- Unit tests: [What to test]
- Integration tests: [What to test]
- E2E tests: [What to test]

## 📦 Deliverables
1. [Deliverable 1] - [Acceptance criteria]
2. [Deliverable 2] - [Acceptance criteria]

## 🔍 Edge Cases
- [Edge case 1] → [How to handle]
- [Edge case 2] → [How to handle]

## ✅ Verification Commands
- Tests: `[command]`
- Lint: `[command]`
- Type check: `[command]`
- Build: `[command]`
```

#### 2. Implementation Checklist
```markdown
# Implementation Checklist: [Feature Name]

## Pre-Implementation
- [ ] Review requirements với team
- [ ] Design review (nếu cần)
- [ ] Confirm technical approach
- [ ] Setup development environment
- [ ] Create feature branch

## Implementation Steps
- [ ] [Step 1 với sub-tasks]
  - [ ] [Sub-task 1.1]
  - [ ] [Sub-task 1.2]
- [ ] [Step 2 với sub-tasks]
  - [ ] [Sub-task 2.1]
  - [ ] [Sub-task 2.2]
- [ ] [Step 3 với sub-tasks]

## Testing
- [ ] Unit tests written và passing
- [ ] Integration tests written và passing
- [ ] E2E tests (nếu cần)
- [ ] Manual testing completed
- [ ] Edge cases tested
- [ ] Performance tested (nếu cần)

## Pre-Commit
- [ ] Code follows conventions
- [ ] No console.logs hoặc debug code
- [ ] TypeScript errors resolved
- [ ] Linting passes
- [ ] All tests pass
- [ ] Documentation updated

## Review & Deploy
- [ ] Code review requested
- [ ] Feedback addressed
- [ ] CI/CD passes
- [ ] Staging deployment successful
- [ ] Production deployment plan ready
```

#### 3. Full Markdown Document
```markdown
# [Feature Name] - Implementation Plan

*Generated by /interview command on [Date]*

## Executive Summary
[1-2 paragraphs tóm tắt feature, tại sao cần làm, impact]

## Requirements Analysis
[Chi tiết requirements từ interview]

## Technical Design
[Architecture decisions, component design, data flow]

## Implementation Plan
[Step-by-step plan with timeline estimates]

## Risk Assessment
[Potential risks and mitigation strategies]

## Success Metrics
[How to measure success]

## References
- [Related docs]
- [Related tickets]
- [Design files]
```

**Duration**: 30-60 giây

---

## Phạm Vi Câu Hỏi

Command sẽ cover **TẤT CẢ** các phạm vi sau (không giới hạn):

### 1. Core Functionality & User Flows
- Features chính cần implement
- User journeys và interactions
- Business logic và rules
- Data models và relationships
- State management requirements

### 2. Technical Constraints & Hệ Thống Hiện Có
- Technology stack hiện tại
- Framework versions và compatibility
- Existing architecture và patterns
- Integration points với services khác
- Database schema và constraints
- API contracts và interfaces

### 3. Chi Tiết Triển Khai Kỹ Thuật
- File structure và organization
- Component/module design
- Dependencies cần thêm
- Build configuration changes
- Environment setup requirements
- Third-party integrations

### 4. Quyết Định UI/UX
- Component hierarchy
- Styling approach (CSS, Tailwind, etc.)
- Responsive design requirements
- Accessibility (a11y) standards
- Animation và transitions
- User feedback mechanisms (loading states, errors, success)

### 5. Tradeoffs & Ưu Tiên
- Performance vs Readability
- Flexibility vs Simplicity
- Time vs Quality
- Build now vs Build later
- Custom vs Library solutions

### 6. Tích Hợp Hệ Thống
- External APIs
- Internal services
- Database operations
- Authentication/Authorization
- Caching strategies
- Message queues/Event buses

### 7. Xử Lý Lỗi
- Expected errors và handling
- Unexpected errors và fallbacks
- User error messaging
- Logging strategy
- Retry mechanisms
- Graceful degradation

### 8. Hiệu Năng
- Performance goals (load time, response time)
- Optimization strategies
- Caching requirements
- Lazy loading
- Code splitting
- Bundle size considerations

### 9. Bảo Mật
- Authentication requirements
- Authorization rules
- Input validation
- XSS/CSRF protection
- Sensitive data handling
- API security (rate limiting, authentication)

### 10. Deliverables Cụ Thể
- Acceptance criteria cho mỗi feature
- Definition of Done
- Testable outcomes
- Documentation requirements
- Deployment criteria

### 11. Lệnh Kiểm Chứng
- Test commands (`npm test`, `jest`, etc.)
- Linting commands (`npm run lint`)
- Type checking (`tsc --noEmit`)
- Build commands (`npm run build`)
- Integration test commands
- E2E test commands

### 12. Edge Cases & Ràng Buộc
- Boundary conditions
- Null/undefined handling
- Empty states
- Maximum/minimum values
- Race conditions
- Network failures
- Browser compatibility
- Device compatibility (mobile, tablet, desktop)

### 13. Testing Strategy
- Unit test coverage goals
- Integration test scenarios
- E2E test flows
- Performance testing
- Security testing
- Accessibility testing

### 14. Documentation Requirements
- Code comments
- README updates
- API documentation
- Architecture diagrams
- User guides
- Changelog entries

### 15. Migration Considerations (nếu áp dụng)
- Backward compatibility
- Data migration strategy
- Rollback plan
- Gradual rollout approach
- Feature flags

### 16. Monitoring & Observability
- Logging requirements
- Metrics to track
- Alerting criteria
- Debugging capabilities
- Performance monitoring

**Lưu ý**: AI sẽ **tự động điều chỉnh** phạm vi dựa trên:
- Độ phức tạp của task
- Context từ discovery phase
- Câu trả lời của user
- Scope hiện tại của project

---

## Nguyên Tắc Phỏng Vấn

### 1. Ưu Tiên Câu Hỏi Đóng

**Khi nào dùng câu hỏi đóng**:
- ✅ Khi có thể list ra các options rõ ràng
- ✅ Khi cần giảm mơ hồ nhanh chóng
- ✅ Khi có recommended option

**Ví dụ câu hỏi đóng tốt**:
```
Bạn muốn dùng state management nào?
- Zustand (Recommended - lightweight, TypeScript-first)
- Redux Toolkit (enterprise-grade, nhiều boilerplate)
- React Context (built-in, đủ cho app nhỏ)
- Jotai (atomic, flexible)
- Khác (tự nhập)
```

**Ví dụ câu hỏi đóng kém**:
```
Bạn có muốn tối ưu performance không?
- Có
- Không

(Quá chung chung! Nên hỏi cụ thể: "Performance goal là gì? Load time < 2s, response time < 100ms, etc.")
```

### 2. Không Hỏi Những Gì Có Thể Tự Suy Ra

**Tránh hỏi**:
- ❌ "Bạn dùng React hay Vue?" (→ Đọc package.json)
- ❌ "TypeScript hay JavaScript?" (→ Check tsconfig.json)
- ❌ "Styling approach là gì?" (→ Scan imports trong components)

**Nên hỏi**:
- ✅ "Component này nên dùng pattern nào? Existing pattern X hay pattern Y mới?"
- ✅ "Approach hiện tại có constraints gì cần lưu ý không?"

### 3. Câu Hỏi Đủ Sắc Nét

**Câu hỏi tốt**:
- ✅ Cụ thể và actionable
- ✅ Có context và options rõ ràng
- ✅ Liên quan trực tiếp đến implementation

**Ví dụ câu hỏi sắc nét**:
```
API endpoint `/api/users` nên return data structure nào?
- Flat array: [{ id, name, email }] (Recommended - simple)
- Nested: { users: [...], meta: {...} } (có pagination info)
- Paginated: { data: [...], page, totalPages } (hỗ trợ pagination)
```

**Ví dụ câu hỏi mơ hồ**:
```
Bạn muốn API như thế nào?

(Quá rộng! User không biết trả lời gì)
```

### 4. Hỏi Tiếp Nếu Ambiguous

**Logic**:
```
IF (câu trả lời thiếu detail) {
  Hỏi follow-up ngay lập tức
}

IF (câu trả lời contradictory) {
  Clarify ngay
}

IF (câu trả lời mở ra questions mới) {
  Add vào question queue
}
```

**Ví dụ**:
```
Q1: "Bạn muốn dùng form library nào?"
A1: "React Hook Form"

Q2 (follow-up): "Validation strategy? 
     - Yup schema (Recommended - type-safe)
     - Zod (TypeScript-first)
     - Custom validation
     - Không cần validation"

(Không dừng ở câu trả lời đầu tiên nếu còn questions liên quan!)
```

### 5. Luôn Có Recommended Option

**Lý do**:
- ✅ Giúp user có direction
- ✅ Thể hiện expertise của AI
- ✅ Tăng tốc decision making
- ✅ Dựa trên best practices và context

**Cách chọn recommended**:
1. Analyze project context (stack, patterns, conventions)
2. Consider best practices for the tech stack
3. Factor in team size, complexity, maintenance
4. Balance simplicity vs power
5. Choose most suitable option

**Format**:
```
Option: "Solution A (Recommended - [lý do ngắn gọn])"
```

### 6. Thứ Tự Câu Hỏi

**Nguyên tắc**: Tổng quan → Chi tiết → Xác nhận

**Stage 1: Tổng Quan (Big Picture)**
- Feature chính là gì?
- Scope như thế nào?
- Tech stack constraints?
- Timeline expectations?

**Stage 2: Chi Tiết (Details)**
- Component structure?
- Data flow?
- State management?
- API design?
- UI/UX specifics?

**Stage 3: Xác Nhận (Verification)**
- Edge cases nào cần handle?
- Testing strategy?
- Performance requirements?
- Security concerns?
- Deliverable criteria?

---

## Output & Deliverables

Sau khi hoàn thành interview, command sẽ cung cấp:

### 1. Instant Summary (Ngay lập tức)

```
✅ PHỎNG VẤN HOÀN TẤT!

📊 Thống Kê:
   - Số câu hỏi: 12 câu
   - Thời gian: 3 phút 24 giây
   - Phạm vi covered: 8/16 areas
   - Clarity score: 95% (xuất sắc)

🎯 Feature: [Tên feature]
📦 Deliverables: [Số lượng] items
⚠️ Blockers: [Số lượng nếu có]
✨ Recommended approach: [Approach name]

💾 Đã lưu:
   - Structured Summary
   - Implementation Checklist  
   - Full Documentation

🚀 Next Steps:
   1. Review summary below
   2. Confirm approach với team (nếu cần)
   3. Ready to implement!
```

### 2. Comprehensive Documentation

3 documents được generate:

#### A. Structured Summary
- Tất cả thông tin quan trọng organized theo sections
- Easy to scan và reference
- Export-friendly format

#### B. Implementation Checklist
- Actionable checklist với sub-tasks
- Track progress during implementation
- Ensure nothing is missed

#### C. Full Markdown Document
- Complete documentation
- Sharable với team
- Archive-friendly

### 3. Ready-to-Use Outputs

Command cũng suggest:

```bash
# 1. Save documentation
# Already saved at: .cursor/interviews/[feature-name]-[date].md

# 2. Create feature branch
git checkout -b feature/[feature-name]

# 3. Create tracking issue/ticket
# Template provided in output

# 4. Start implementation
# Checklist ready to follow
```

---

## Ví Dụ

### Ví Dụ 1: Implement User Authentication

**Input**:
```
/interview

AI: "Bạn muốn implement feature gì?"
User: "User authentication với email/password và OAuth"
```

**Discovery Phase Output**:
```
🔍 DISCOVERY PHASE (30s)

Đã phân tích:
✅ Project: Next.js 14 với App Router
✅ Auth library: Chưa có (sẽ cần chọn)
✅ Database: Prisma với PostgreSQL
✅ Existing patterns: API routes trong /app/api/

Recommendations:
- NextAuth.js (recommended cho Next.js)
- Lucia Auth (lightweight alternative)
- Custom implementation với jose + bcrypt

Ready cho interview phase...
```

**Interview Phase** (3-5 câu mỗi round):

**Round 1 - Big Picture**:
```
Q1: Auth library nào phù hợp nhất?
    - NextAuth.js (Recommended - first-party cho Next.js)
    - Lucia (lightweight, TypeScript-first)
    - Custom (full control, nhiều công)

Q2: OAuth providers nào cần support?
    [Multiple choice] Google, GitHub, Facebook, Twitter

Q3: Session management approach?
    - JWT (stateless, recommended cho API)
    - Database sessions (more secure, có revocation)
    - Hybrid (JWT + DB validation)
```

**Round 2 - Chi Tiết**:
```
Q4: User data structure cần lưu gì?
    [Open question để user tự nhập fields]

Q5: Password requirements?
    - Minimum 8 chars, 1 uppercase, 1 number (Standard)
    - Minimum 12 chars với complexity (Strict)
    - Custom rules (Nhập manually)

Q6: Email verification workflow?
    - Send verification email (Recommended)
    - Skip verification
    - Admin approval required
```

**Round 3 - Edge Cases & Verification**:
```
Q7: Handle existing email khi signup?
    - Show error "Email already exists"
    - Suggest login or password reset
    - Other

Q8: Password reset flow?
    - Email with reset link (expires 1hr) - Recommended
    - Security questions
    - Admin reset only

Q9: Rate limiting cho login attempts?
    - Yes, 5 attempts per 15 minutes (Recommended)
    - Yes, custom threshold
    - No rate limiting
```

**Summary Output**:
```markdown
# Tổng Hợp: User Authentication Implementation

## 📋 Core Functionality
- Email/password authentication
- OAuth (Google, GitHub)
- Email verification
- Password reset flow
- Session management với JWT

## 🔧 Technical Stack
- NextAuth.js v5
- Prisma (User, Account, Session models)
- PostgreSQL database
- Email service: Resend API

## 🎯 User Flows

### 1. Signup Flow
1. User nhập email + password
2. Validate password requirements (min 8 chars, 1 uppercase, 1 number)
3. Check email không trùng
4. Create user record (password hashed với bcrypt)
5. Send verification email
6. Redirect to "Check your email" page

### 2. Login Flow
1. User nhập email + password
2. Validate credentials
3. Check email verified
4. Generate JWT session
5. Redirect to dashboard

### 3. OAuth Flow
1. User clicks "Login with Google/GitHub"
2. Redirect to OAuth provider
3. Handle OAuth callback
4. Create/update user record
5. Generate session
6. Redirect to dashboard

## ⚠️ Constraints
- MUST use HTTPS in production
- Passwords MUST be hashed (bcrypt, cost factor 10)
- JWT secret MUST be in env var
- Email verification required before full access

## 🔐 Security Measures
- Rate limiting: 5 attempts per 15 min per IP
- Password hashing: bcrypt cost 10
- JWT expiry: 7 days
- CSRF protection: Enabled
- Email verification: Required
- Password reset tokens: 1-hour expiry

## 📦 Deliverables

### 1. Database Schema
- [x] User model với email, password, emailVerified
- [x] Account model cho OAuth
- [x] Session model cho JWT tracking
- [x] Verification token model

### 2. API Routes
- [x] POST /api/auth/signup
- [x] POST /api/auth/login  
- [x] POST /api/auth/logout
- [x] POST /api/auth/reset-password
- [x] POST /api/auth/verify-email
- [x] GET /api/auth/callback/[provider]

### 3. UI Components
- [x] SignupForm
- [x] LoginForm
- [x] ResetPasswordForm
- [x] EmailVerificationNotice

### 4. Email Templates
- [x] Welcome email
- [x] Email verification
- [x] Password reset
- [x] Password changed notification

## 🧪 Testing Strategy

### Unit Tests
- Password validation logic
- Email validation
- JWT generation/verification
- Password hashing

### Integration Tests
- Signup flow end-to-end
- Login flow with correct/incorrect credentials
- OAuth callback handling
- Password reset flow
- Email verification flow

### E2E Tests (Playwright)
- User can sign up successfully
- User cannot sign up với email trùng
- User can log in after signup
- User can reset password
- OAuth login works

## ✅ Verification Commands
```bash
# Run all tests
npm test

# Run specific test suites
npm test auth

# Type check
npm run type-check

# Lint
npm run lint

# Build
npm run build

# Run dev server
npm run dev
```

## 🔍 Edge Cases

1. **Email đã tồn tại**: Show "Email already registered. Try logging in or reset your password."
2. **Unverified email login**: Allow login but show banner "Please verify your email"
3. **OAuth email trùng với password email**: Link accounts automatically
4. **Password reset token expired**: Show "Link expired. Request a new one."
5. **Rate limit exceeded**: Show "Too many attempts. Try again in X minutes."
6. **JWT expired**: Redirect to login with message "Session expired"
7. **Network error during OAuth**: Show "Authentication failed. Please try again."

## 🚧 Implementation Plan

### Phase 1: Setup (Day 1)
- [ ] Install NextAuth.js và dependencies
- [ ] Configure Prisma schema
- [ ] Setup env variables
- [ ] Create auth config

### Phase 2: Core Auth (Day 2-3)  
- [ ] Implement signup endpoint
- [ ] Implement login endpoint
- [ ] Implement JWT session management
- [ ] Add password hashing

### Phase 3: OAuth (Day 4)
- [ ] Configure Google OAuth
- [ ] Configure GitHub OAuth
- [ ] Test OAuth flows
- [ ] Handle account linking

### Phase 4: Email Flows (Day 5)
- [ ] Setup email service (Resend)
- [ ] Create email templates
- [ ] Implement email verification
- [ ] Implement password reset

### Phase 5: UI Components (Day 6)
- [ ] Build SignupForm
- [ ] Build LoginForm
- [ ] Build ResetPasswordForm
- [ ] Style with Tailwind

### Phase 6: Security & Polish (Day 7)
- [ ] Add rate limiting
- [ ] CSRF protection
- [ ] Security headers
- [ ] Error handling

### Phase 7: Testing (Day 8)
- [ ] Write unit tests
- [ ] Write integration tests
- [ ] Write E2E tests
- [ ] Manual testing

### Phase 8: Documentation & Deploy (Day 9)
- [ ] Update README
- [ ] API documentation
- [ ] Deployment guide
- [ ] Deploy to staging
```

---

### Ví Dụ 2: Quick Feature - Add Dark Mode Toggle

**Input**:
```
/interview

User: "Thêm dark mode toggle"
```

**Discovery**:
```
✅ Detected: Next.js với Tailwind CSS
✅ Found: No existing theme system
✅ Recommendation: next-themes library
```

**Interview** (ngắn gọn hơn vì feature đơn giản):
```
Round 1:
Q1: Dark mode implementation approach?
    - next-themes với Tailwind (Recommended - 5 min setup)
    - Custom với Context API
    - CSS variables manual

Q2: Default theme?
    - System preference (Recommended)
    - Light
    - Dark

Q3: Theme toggle UI?
    - Button with icon (Recommended - common pattern)
    - Dropdown menu
    - Keyboard shortcut only
```

**Output Summary** (ngắn gọn):
```markdown
# Dark Mode Toggle - Implementation

## Quick Summary
- Library: next-themes
- Storage: localStorage
- Default: System preference
- Toggle: Button với sun/moon icon

## Implementation (15 phút)

1. Install: `npm install next-themes`
2. Wrap app với ThemeProvider
3. Create ThemeToggle component
4. Update tailwind.config.js
5. Test theme switching

## Deliverables
- [x] ThemeProvider setup
- [x] ThemeToggle component
- [x] Icon switching logic
- [x] Persist theme preference

## Testing
- [ ] Theme persists on reload
- [ ] System preference works
- [ ] All pages support dark mode
```

---

## Cách Dùng Command

### Usage Cơ Bản

```
/interview
```

AI sẽ hỏi: "Bạn muốn implement/migrate feature gì?"

### Usage Với Context

```
/interview

"Tôi muốn thêm payment integration với Stripe"
```

### Usage Với Files

```
@src/components/checkout/

/interview

"Refactor checkout flow để support multiple payment methods"
```

---

## Tips & Best Practices

### Cho User

1. **Chuẩn bị trước**:
   - Có rough idea về feature muốn làm
   - Biết constraints chính (timeline, tech stack)
   - Có references nếu có (designs, similar features)

2. **Trong interview**:
   - Trả lời thật thà, không overthink
   - Chọn "Recommended" nếu không chắc
   - Dùng "Other" để nhập custom nếu cần
   - Đừng ngại hỏi lại nếu không hiểu câu hỏi

3. **Sau interview**:
   - Review summary kỹ
   - Confirm với team nếu cần
   - Save documentation vào project
   - Follow implementation checklist

### Cho AI

1. **Discovery Phase**:
   - Scan thoroughly nhưng nhanh
   - Focus vào info giúp craft better questions
   - Don't over-analyze, keep it under 60s

2. **Interview Phase**:
   - Start broad, zoom in progressively
   - Ask 3-5 questions per round max
   - Always include recommended option với reasoning
   - Follow up immediately nếu answer unclear
   - Don't ask what can be inferred

3. **Summary Phase**:
   - Be comprehensive nhưng concise
   - Structure clearly với sections
   - Include actionable items
   - Provide verification commands
   - Think about edge cases

---

## Advanced: Custom Question Areas

Nếu bạn muốn focus vào specific areas:

```
/interview --focus=security,performance

hoặc

/interview --skip=ui

hoặc  

/interview --depth=quick
```

**Note**: Cú pháp này là placeholder cho future enhancement. Hiện tại command sẽ tự động điều chỉnh scope dựa trên context.

---

## Troubleshooting

### Vấn Đề: Câu hỏi quá nhiều

**Giải pháp**: 
- Cung cấp nhiều context ban đầu
- Trả lời "Recommended" để skip deep dive
- Nói rõ: "Keep it simple, I want basic implementation first"

### Vấn Đề: Câu hỏi không relate

**Giải pháp**:
- Clarify scope: "I only need X, not Y"
- Skip: "Not relevant for this feature"
- Feedback: "This question doesn't apply because..."

### Vấn Đề: Không biết trả lời

**Giải pháp**:
- Chọn "Recommended"
- Hoặc: "I'm not sure, suggest best approach"
- AI sẽ explain tradeoffs và suggest

---

## Metadata

**Command**: `/interview`
**Version**: 1.0.0
**Created**: 2026-02-04
**Language**: Vietnamese
**Complexity**: Advanced
**Dependencies**: AskQuestion tool
**Estimated Duration**: 3-8 phút

---

## Related Commands

- `/create-command` - Tạo slash commands mới
- `/create-rule` - Tạo project rules
- `/council` - Multi-agent collaboration
- `/phase-plan` - Multi-phase planning

---

**Happy interviewing! 🎤✨**

Được tạo bởi `/create-command` - Meta-command generator
