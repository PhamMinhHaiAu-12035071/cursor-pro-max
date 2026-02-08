# cursor-pro-max

> Meta-toolkit tối ưu workflow Cursor IDE cho Vietnamese developers

**cursor-pro-max** là một meta-project tập hợp best practices từ "Vibe Coding Cursor" - bao gồm commands, rules, skills và agents. Đây không phải là một ứng dụng code mà là một knowledge base và toolkit để tối ưu workflow với Cursor IDE.

> **📌 Migration Note (Feb 2026):** Skills have been moved from `.cursor/skills/` to `.claude/skills/` for better Claude Code (claude.ai/code) compatibility and multi-IDE support. All three skill directories (`.cursor/skills/`, `.claude/skills/`, `.codex/skills/`) are equally supported by Cursor.

## Về Project

Project này được thiết kế để:

- **Tối ưu workflow**: Cung cấp commands, skills, và rules có thể tái sử dụng
- **Tăng năng suất**: Tự động hóa các tác vụ lặp đi lặp lại
- **Chuẩn hóa quy trình**: Đảm bảo tính nhất quán trong development
- **Hỗ trợ học tập**: Giải thích chi tiết bằng tiếng Việt cho Vietnamese developers

**cursor-pro-max** không phải là một ứng dụng mà là một bộ công cụ meta-level - nó cấu hình và nâng cao IDE của bạn thay vì xây dựng phần mềm cho người dùng cuối.

### Đặc Điểm Nổi Bật

- **Meta-capabilities**: Bao gồm công cụ để tạo ra công cụ mới (`/create-command`, `/create-rule`)
- **Vietnamese-first**: Documentation và explanations chủ yếu bằng tiếng Việt
- **Production-ready**: GLOBAL_RULE.md v2.0.0 với versioning và performance budgets
- **Self-documenting**: Mỗi component đều có documentation chi tiết
- **Extensible**: Dễ dàng thêm commands, skills, và rules mới

## Tính Năng Chính

### Commands System (6 slash commands)

Commands là các workflow có thể gọi bằng `/command-name`:

- **`/check-grammar`** (1,420 dòng, Advanced)
  - Grammar checking với Vietnamese explanations
  - Middleware mode: tự động thực hiện tasks sau khi check grammar
  - Pattern detection cho lỗi lặp lại
  - Tích hợp với `grammar-learning` skill

- **`/interview`** (1,074 dòng, Advanced)
  - Requirements gathering có cấu trúc
  - 3-phase workflow: Discovery → Interview → Summary
  - Output: Summary, Checklist, và Full Documentation
  - Vietnamese language support

- **`/council`** (7 dòng, Simple)
  - Multi-agent coordination
  - Spawn n=10 task agents (configurable)
  - Parallel codebase exploration và analysis

- **`/phase-plan`** (11 dòng, Simple)
  - Tổ chức công việc theo phases
  - Tag todos với `[Phase X]`
  - Hỗ trợ parallel/sequential execution

- **`/create-command`** (870 dòng, Advanced)
  - Meta-command generator
  - Tạo commands mới từ template
  - 3 complexity levels: Simple, Intermediate, Advanced

- **`/create-rule`** (1,367 dòng, Advanced)
  - Hướng dẫn tạo Cursor rules
  - Educational guide với examples
  - Phân biệt Commands vs Rules

### Skills System

Skills là các AI capabilities tự động activate khi match triggers:

- **`grammar-learning`**
  - Grammar correction với Vietnamese explanations
  - 9 grammar categories
  - Pattern detection cho lỗi phổ biến của người Việt
  - References: grammar rules, common mistakes, writing style
  - Examples: sample corrections

- **`lyra-prompt-optimizer`**
  - AI prompt optimization và engineering
  - 4 advanced reasoning frameworks (CoT, ToT, GoT, AoT)
  - 3 optimization levels (Quick Boost, Deep Dive, Revolutionary)
  - Bilingual support (Vietnamese-English)
  - Platform-specific optimization (Claude, ChatGPT, Gemini)
  - References: reasoning frameworks, optimization toolkit, anti-patterns
  - Examples: 12 comprehensive examples across all levels

### Rules System

Rules system được document đầy đủ trong `.cursor/commands/create-rule.md` nhưng chưa có rules nào được implement. Bạn có thể tạo rules để apply coding standards tự động khi mở files.

### System Prompt (GLOBAL_RULE.md v2.0.0)

- Production-ready system prompt (~5,600 dòng)
- Task classification: 🟢 Lightweight, 🟡 Standard, 🔴 Critical
- Performance budgets: Token limits và time constraints
- Conflict resolution hierarchy
- Versioning với changelog và migration guide

## Cài Đặt

### 🎯 Installation Script (Recommended)

cursor-pro-max cung cấp `install.sh` - một installation script tự động với conflict resolution thông minh.

#### Quick Start

**Greenfield Project (Empty directory):**

```bash
# Clone project
git clone https://github.com/[username]/cursor-pro-max.git

# Navigate to your project
cd /path/to/your-project

# Run installer
/path/to/cursor-pro-max/install.sh

# Restart Cursor IDE
```

**Brownfield Project (Existing .cursor/):**

```bash
# Same as above - script will detect conflicts
cd /path/to/existing-project

/path/to/cursor-pro-max/install.sh
# You'll be prompted for each conflict group
```

#### Installation Script Features

- ✅ **Smart Conflict Detection**: Detects existing files và prompts for resolution
- 🔄 **Update Mode**: Only updates changed files (checksums comparison)
- 🗑️ **Clean Uninstall**: Safely removes all installed components
- 📊 **Post-Install Validation**: Verifies installation completeness
- 🎨 **Colored Output**: Beautiful terminal output với emojis
- 🚫 **Error Handling**: Comprehensive error messages và troubleshooting hints

#### Usage Modes

##### 1️⃣ Install Mode (Default)

Installs cursor-pro-max vào target directory với interactive conflict resolution.

```bash
# Install in current directory
./install.sh

# Install in specific directory
./install.sh /path/to/project
```

**What Gets Installed:**
- `.cursor/commands/` - 6 slash commands
- `.claude/skills/grammar-learning/` - Grammar skill với references
- `GLOBAL_RULE.md` - System prompt (~5,600 lines)

**Conflict Resolution:**

Khi files tồn tại, bạn sẽ được hỏi theo nhóm:

```
⚠️  5 command files already exist in .cursor/commands/
   - check-grammar.md
   - council.md
   - create-command.md
   - create-rule.md
   - interview.md

Overwrite all commands? (y/n) [n]:
```

**Grouped prompts** giảm prompt fatigue:
- Commands group → 1 prompt cho tất cả commands
- Skills group → 1 prompt cho tất cả skills
- GLOBAL_RULE.md → 1 prompt riêng

##### 2️⃣ Update Mode

Updates existing installation - chỉ process changed files.

```bash
./install.sh --update
```

**Smart Update:**
- ✅ Detects changes using checksums (SHA-256/MD5)
- ✅ Skips identical files
- ✅ Prompts individually for each changed file
- ✅ Shows summary: updated vs skipped

**Example output:**

```
Found 3 change(s)

📝 Modified: check-grammar.md
  Update this file? (Y/n): y
  ✅ Updated

📝 Modified: GLOBAL_RULE.md
  Update this file? (Y/n): y
  ✅ Updated

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Update Summary:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Updated: 2 file(s)
⏭️  Skipped: 0 file(s)
```

##### 3️⃣ Uninstall Mode

Safely removes cursor-pro-max from project.

```bash
./install.sh --uninstall
```

**Safety Features:**
- Shows what will be deleted
- **Double confirmation** required
- Clear summary of removed items

**Example:**

```
⚠️  This will PERMANENTLY DELETE the following:
   - .cursor/ directory (commands and skills)
   - GLOBAL_RULE.md

⚠️  This action cannot be undone!

Are you sure you want to uninstall? (y/N): y
Really delete? (final confirmation) (y/N): y

✅ Removed .cursor/ directory
✅ Removed GLOBAL_RULE.md

🎉 Uninstall completed successfully!
```

#### Help and Version

```bash
# Show help with examples
./install.sh --help

# Show version
./install.sh --version
```

#### Prerequisites

Installation script requires (usually pre-installed on macOS/Linux):

| Tool | Purpose | Check |
|------|---------|-------|
| `bash` | Shell (3.2+) | `bash --version` |
| `cp` | Copy files | `which cp` |
| `mv` | Move files | `which mv` |
| `rm` | Remove files | `which rm` |
| `find` | Find files | `which find` |

Script tự động validates prerequisites trước khi chạy.

#### Troubleshooting

**Permission Denied:**

```bash
chmod +x install.sh
./install.sh
```

**Installation Incomplete:**

- Check file permissions in target directory
- Ensure you have write access
- Verify disk space available

**Validation Failed:**

```bash
# Make sure you're running from cursor-pro-max directory
cd /path/to/cursor-pro-max
./install.sh
```

**Wrong Directory Structure:**

Script expects:
```
cursor-pro-max/
├── install.sh
├── .cursor/
│   ├── commands/
│   └── skills/
└── GLOBAL_RULE.md
```

If structure is incorrect, validation will fail with clear error messages.

#### Advanced Usage

**Disable Colors:**

```bash
NO_COLOR=1 ./install.sh
```

**Install from Different Location:**

```bash
# Run script from anywhere
/absolute/path/to/cursor-pro-max/install.sh /target/project
```

**Scripted Installation (Non-interactive):**

```bash
# Auto-accept all prompts (use with caution!)
yes | ./install.sh

# Or pipe specific answers
printf "y\nn\ny\n" | ./install.sh  # yes, no, yes
```

#### Exit Codes

| Code | Meaning | Action |
|------|---------|--------|
| `0` | Success | Installation completed |
| `1` | General error | Check error message |
| `2` | Invalid arguments | Run `--help` |
| `3` | Prerequisites not met | Install missing tools |
| `126` | Permission denied | Run `chmod +x` |
| `130` | User interrupted (Ctrl+C) | Re-run if needed |

#### Post-Installation

**IMPORTANT:** Restart Cursor IDE để load commands và rules!

Sau khi restart:
- Commands available ngay: gõ `/` để xem list
- Skills auto-activate khi match triggers
- GLOBAL_RULE.md được AI đọc và follow

**Verify Installation:**

```bash
# Check installed files
ls -la .cursor/commands/
ls -la .cursor/skills/
ls -la GLOBAL_RULE.md

# Count commands (should be 6)
find .cursor/commands -name "*.md" | wc -l

# Check GLOBAL_RULE.md size
wc -l GLOBAL_RULE.md  # Should be ~5,600 lines
```

### Template-based Installation (Manual)

Nếu không muốn dùng `install.sh`, bạn có thể copy manually:

```bash
# Clone project
git clone https://github.com/[username]/cursor-pro-max.git

# Copy vào workspace mới
cp -r cursor-pro-max/.cursor /path/to/your/project/

# Copy GLOBAL_RULE.md (optional nhưng recommended)
cp cursor-pro-max/GLOBAL_RULE.md /path/to/your/project/

# Copy CLAUDE.md (optional - project documentation)
cp cursor-pro-max/CLAUDE.md /path/to/your/project/

# Restart Cursor IDE
# Commands và skills sẽ available ngay
```

### Sau Khi Cài Đặt

**Commands:**
- Available ngay sau khi restart Cursor
- Gõ `/` trong chat để xem danh sách commands

**Skills:**
- Auto-activate khi input match description triggers
- Ví dụ: gõ "check my grammar" hoặc "sửa ngữ pháp" để activate grammar-learning skill

**Rules:**
- Chưa có rules nào được tạo sẵn
- Tạo rules theo nhu cầu (xem section [Rules System](#rules-system))

**GLOBAL_RULE.md:**
- Nếu copy vào project, AI sẽ follow system prompt này
- Định nghĩa task classification và behavioral guidelines

## Quick Start

### Ví Dụ 1: Check Grammar

```
/check-grammar She go to school yesterday
```

**Output:**
- ✅ Câu đã sửa: "She went to school yesterday"
- ❌ Bảng lỗi: "go" → "went" (Lỗi thì - Past tense)
- 📚 Giải thích chi tiết bằng tiếng Việt
- 💡 Mẹo nhớ để tránh lỗi tương tự

**Use case:** Check grammar trước khi gửi email, viết documentation, hoặc submit PR.

---

### Ví Dụ 2: Interview cho Feature Mới

```
/interview

"Tôi muốn implement user authentication với email/password và OAuth"
```

**Output:**
- **Discovery Phase** (30-60s): Tự động scan codebase để hiểu context
- **Interview Phase** (2-5 min): Hỏi câu hỏi có cấu trúc với recommended options
- **Summary Phase** (30-60s): Generate 3 documents:
  - Structured Summary
  - Implementation Checklist
  - Full Documentation

**Use case:** Requirements gathering trước khi implement feature mới hoặc migration.

---

### Ví Dụ 3: Multi-agent Exploration

```
/council n=5

"Phân tích architecture của authentication module trong codebase này"
```

**Output:**
- Spawn 5 task agents
- Mỗi agent explore một khía cạnh khác nhau
- Aggregate kết quả thành comprehensive analysis

**Use case:** Hiểu nhanh codebase mới, phân tích architecture, hoặc tìm patterns.

---

### Ví Dụ 4: Phased Planning

```
/phase-plan

[Context: Migration từ REST API sang GraphQL]
```

**Output:**
- Todos organized by phases
- Ví dụ:
  - `[Phase 1]` Map current REST endpoints
  - `[Phase 2]` Design GraphQL schema
  - `[Phase 3]` Implement resolvers
  - `[Phase 4]` Testing và migration

**Use case:** Break down large projects thành manageable phases cho team.

## Commands Chi Tiết

Dưới đây là danh sách đầy đủ các commands với mô tả:

| Command | Complexity | Lines | Mô Tả | Use Case |
|---------|-----------|-------|-------|----------|
| `/check-grammar` | Advanced | 1,420 | Grammar checking + middleware mode | Check English text, tự động execute tasks |
| `/interview` | Advanced | 1,074 | Requirements gathering interview | Feature planning, migration planning |
| `/council` | Simple | 7 | Multi-agent coordination | Codebase exploration, parallel analysis |
| `/phase-plan` | Simple | 11 | Phased work organization | Break work thành phases cho teams |
| `/create-command` | Advanced | 870 | Meta-command generator | Tạo slash commands mới |
| `/create-rule` | Advanced | 1,367 | Rule creation guide | Học cách tạo Cursor rules |

### `/check-grammar` - Grammar Checking với Middleware Mode

**Input format:**
```
/check-grammar [English text to check]
```

**Features:**
- Grammar correction với Vietnamese explanations
- Middleware mode: Tự động detect và execute tasks
- Pattern detection (3+ lỗi giống nhau)
- Educational focus: giải thích TẠI SAO sai

**Output:**
- ✅ Câu đã sửa
- ❌ Bảng lỗi (4 cột)
- 📚 Giải thích chi tiết cho mỗi lỗi
- 💡 Gợi ý học tập (nếu có pattern)

**Chi tiết:** Xem `.cursor/commands/check-grammar.md`

---

### `/interview` - Requirements Gathering

**Input format:**
```
/interview

"[Mô tả feature hoặc task cần làm]"
```

**3-Phase Workflow:**
1. **Discovery** (30-60s): Tự động scan codebase
2. **Interview** (2-5 min): Hỏi 10-15 câu có cấu trúc
3. **Summary** (30-60s): Generate documentation

**Output:**
- Structured Summary
- Implementation Checklist
- Full Markdown Document

**Chi tiết:** Xem `.cursor/commands/interview.md`

---

### `/council` - Multi-agent Coordination

**Input format:**
```
/council n=[số lượng agents]

"[Area of interest hoặc task]"
```

**Workflow:**
1. Dig around codebase
2. Spawn n agents (mặc định 10)
3. Aggregate results

**Chi tiết:** Xem `.cursor/commands/council.md`

---

### `/phase-plan` - Phased Work Organization

**Input format:**
```
/phase-plan

[Context về project hoặc task]
```

**Output:**
Todos với phase tags, ví dụ:
- `[Phase 1]` Task 1
- `[Phase 1]` Task 2
- `[Phase 2]` Task 3

**Chi tiết:** Xem `.cursor/commands/phase-plan.md`

---

### `/create-command` - Meta-command Generator

**Input format:**
```
/create-command
```

AI sẽ interview bạn để tạo command mới.

**7-Phase Process:**
1. Pattern Analysis
2. Structured Interview
3. Complexity Determination
4. Content Generation
5. Validation
6. File Write
7. Success Summary

**Chi tiết:** Xem `.cursor/commands/create-command.md`

---

### `/create-rule` - Rule Creation Guide

**Input format:**
```
/create-rule
```

Educational guide để học cách tạo Cursor rules.

**Nội dung:**
- Rules vs Commands comparison
- File structure (`.mdc` với YAML frontmatter)
- Glob patterns
- Examples (Basic → Intermediate → Advanced)
- Troubleshooting

**Chi tiết:** Xem `.cursor/commands/create-rule.md`

## Skills Chi Tiết

### grammar-learning

Grammar correction skill với Vietnamese explanations, được thiết kế đặc biệt cho Vietnamese English learners.

**Activation Triggers:**
- "check my grammar"
- "fix my English"
- "sửa ngữ pháp"
- "correct this sentence"
- "giúp tôi viết tiếng Anh"
- "kiểm tra lỗi chính tả"
- Paste English text với grammar errors

**Purpose:**
Không chỉ sửa lỗi mà còn DẠY ngữ pháp qua việc giải thích TẠI SAO sai và cách tránh lỗi đó trong tương lai.

**Structure:**
```
.claude/skills/grammar-learning/
├── SKILL.md                           # Main skill definition
├── references/                        # Knowledge base
│   ├── grammar-rules.md               # 9 grammar categories
│   ├── common-mistakes-vn.md          # 10 lỗi phổ biến của người Việt
│   └── vietnamese-writing-style.md    # Cách viết tiếng Việt tự nhiên
└── examples/
    └── sample-corrections.md          # 4 examples with explanations
```

**9 Grammar Categories:**
1. Subject-Verb Agreement
2. Tenses (Present Simple, Past Simple, Present Perfect)
3. Articles (a/an/the)
4. Prepositions
5. Word Forms
6. Pronouns
7. Countable vs Uncountable
8. Sentence Structure
9. Confusing Words

**Features:**
- ❌/✅ format cho errors vs corrections
- Vietnamese explanations (không phải machine translation)
- Mnemonics: "He/She/It cộng S, còn lại thì thôi"
- Cultural context (tại sao người Việt hay mắc lỗi này)
- Pattern detection (3+ lỗi giống nhau)

**Chi tiết:** Xem `.claude/skills/grammar-learning/SKILL.md`

## Rules System

Rules system cho phép bạn define coding standards và patterns tự động apply khi mở files match glob patterns.

### Hiện Trạng

Rules system đã được document đầy đủ trong `.cursor/commands/create-rule.md` nhưng **chưa có rules nào được implement**.

### Cách Tạo Rule Đầu Tiên

```bash
# Tạo thư mục rules
mkdir -p .cursor/rules

# Tạo rule file
touch .cursor/rules/typescript-standards.mdc
```

### Example Rule

```yaml
---
title: TypeScript Coding Standards
description: Guidelines for TypeScript code quality and consistency
globs: **/*.ts
alwaysApply: false
---

# TypeScript Coding Standards

## Purpose
Đảm bảo code TypeScript consistent và maintainable.

## Guidelines

### 1. Type Safety
- ✅ Always define types explicitly
- ✅ Use interfaces for object shapes
- ❌ Avoid `any` type

### 2. Naming Conventions
- Variables: camelCase
- Interfaces: PascalCase with `I` prefix
- Constants: UPPER_SNAKE_CASE

## Example

\`\`\`typescript
// ❌ Bad
const data: any = fetchData();

// ✅ Good
interface IUserData {
  id: number;
  name: string;
}
const data: IUserData = fetchData();
\`\`\`
```

### Rule Activation

Rules activate automatically khi:
- Mở file matching `globs` pattern
- @-reference file trong chat
- File trong `@codebase` search results
- Set `alwaysApply: true` để apply mọi lúc

**Học thêm:** Xem `.cursor/commands/create-rule.md` (1,367 dòng) để hiểu đầy đủ về rules system.

## Architecture

### Cấu Trúc Project

```
cursor-pro-max/
├── .cursor/
│   ├── commands/                    # Slash commands (plain .md files)
│   │   ├── check-grammar.md         # Grammar + middleware (1,420 dòng)
│   │   ├── council.md               # Multi-agent (7 dòng)
│   │   ├── create-command.md        # Meta-command generator (870 dòng)
│   │   ├── create-rule.md           # Rule creation guide (1,367 dòng)
│   │   ├── interview.md             # Requirements gathering (1,074 dòng)
│   │   └── phase-plan.md            # Phased work (11 dòng)
│   │
│   └── rules/                       # [Chưa tạo] Cursor rules (.mdc files)
│       └── (empty - chưa có rules)
│
├── .claude/
│   └── skills/                      # AI Skills (YAML + references + examples)
│       ├── grammar-learning/
│       │   ├── SKILL.md             # Main skill definition (186 dòng)
│       │   ├── references/          # Knowledge base
│       │   │   ├── grammar-rules.md            # 9 categories (454 dòng)
│       │   │   ├── common-mistakes-vn.md       # 10 common errors
│       │   │   └── vietnamese-writing-style.md # Writing guidelines (232 dòng)
│       │   └── examples/
│       │       └── sample-corrections.md       # 4 example scenarios
│       └── lyra-prompt-optimizer/
│           ├── SKILL.md             # Prompt optimization skill (380 dòng)
│           ├── references/          # Core documentation
│           │   ├── reasoning-frameworks.md     # CoT, ToT, GoT, AoT (512 dòng)
│           │   ├── optimization-toolkit.md     # Techniques catalog (618 dòng)
│           │   ├── core-concepts.md            # 4D methodology (432 dòng)
│           │   ├── vietnamese-guide.md         # Bilingual support (341 dòng)
│           │   └── anti-patterns.md            # Common mistakes (441 dòng)
│           ├── examples/
│           │   ├── quick-boost/     # Basic optimization (3 examples)
│           │   ├── deep-dive/       # Advanced optimization (4 examples)
│           │   ├── revolutionary/   # Maximum optimization (3 examples)
│           │   └── vietnamese/      # Vietnamese examples (2 examples)
│           └── scripts/
│               └── quality-check.sh # Validation script
│
├── GLOBAL_RULE.md                   # System prompt (5,600 dòng, v2.0.0)
├── CLAUDE.md                        # Project documentation
├── README.md                        # File này
└── LICENSE                          # MIT License
```

### So Sánh: Commands vs Skills vs Rules

| Aspect | Commands | Skills | Rules |
|--------|----------|--------|-------|
| **File Extension** | `.md` | `SKILL.md` | `.mdc` |
| **Location** | `.cursor/commands/` | `.claude/skills/<name>/` | `.cursor/rules/` |
| **YAML Frontmatter** | ❌ Không cần | ✅ Required | ✅ Required |
| **Activation** | Manual (`/command`) | Auto (via description triggers) | Auto (glob pattern matching) |
| **Purpose** | Workflow/Action | Domain knowledge/capability | Standards/Patterns |
| **Scope** | Single invocation | Multi-use capability | File-scoped persistent |
| **Example** | `/interview` | `grammar-learning` | `typescript-standards.mdc` |

### Cách Hoạt Động

#### Workflow 1: Command Execution

```
User gõ /command
   ↓
Cursor reads .cursor/commands/<command>.md
   ↓
AI executes workflow theo instructions
   ↓
Output trả về user
```

**Example:** `/check-grammar She go to school` → Grammar correction output

---

#### Workflow 2: Skill Activation

```
User input matches skill description
   ↓
Cursor loads .claude/skills/<skill>/SKILL.md + references
   ↓
AI applies skill knowledge
   ↓
Output theo skill format
```

**Example:** User gõ "sửa ngữ pháp" → `grammar-learning` skill activates

---

#### Workflow 3: Rule Application

```
User opens file matching glob pattern
   ↓
Cursor loads relevant .cursor/rules/<rule>.mdc
   ↓
AI follows rules khi edit file
   ↓
Code suggestions theo rules
```

**Example:** Open `src/utils.ts` → Rules với `globs: **/*.ts` apply

### Key Concepts

#### Task Classification (từ GLOBAL_RULE.md v2.0.0)

- 🟢 **Lightweight** (Max 500 tokens, <5s)
  - Simple queries, typo fixes, single-file changes
  - Example: "Fix this typo", "Add a comment"

- 🟡 **Standard** (Max 2000 tokens, <30s)
  - Feature implementation, multi-file changes
  - Example: "Add user authentication endpoint"

- 🔴 **Critical** (Max 5000 tokens, <2min)
  - Security, database schema, infrastructure
  - Example: "Implement JWT refresh token rotation"

#### Conflict Resolution Hierarchy

Khi rules conflict, precedence order (cao → thấp):
1. **Security** (highest)
2. **Correctness**
3. **User Safety**
4. **Scope Discipline**
5. **Simplicity**
6. **Performance** (lowest)

## Contributing

### Cách Contribute

#### Thêm Command Mới

**Option 1: Sử dụng meta-command**
```
/create-command
```
AI sẽ interview bạn và generate command từ template.

**Option 2: Tự tạo**
1. Tạo file `.cursor/commands/<command-name>.md`
2. Viết plain markdown (không cần YAML frontmatter)
3. Follow patterns trong existing commands
4. Test command bằng cách gõ `/command-name`

---

#### Thêm Skill Mới

1. Tạo directory:
   ```bash
   mkdir -p .claude/skills/<skill-name>
   ```

2. Tạo `SKILL.md` với YAML frontmatter:
   ```yaml
   ---
   name: skill-name
   description: "This skill should be used when..."
   ---
   
   # Skill content here
   ```

3. (Optional) Thêm references và examples:
   ```bash
   mkdir -p .claude/skills/<skill-name>/references
   mkdir -p .claude/skills/<skill-name>/examples
   ```

4. Test skill bằng cách trigger description

---

#### Thêm Rule Mới

1. Tạo file `.cursor/rules/<rule-name>.mdc`

2. Thêm YAML frontmatter:
   ```yaml
   ---
   title: Rule Title
   description: Guidelines for...
   globs: **/*.ts
   alwaysApply: false
   ---
   
   # Rule content
   ```

3. Test rule bằng cách mở file matching glob pattern

**Học thêm:** Đọc `.cursor/commands/create-rule.md` để hiểu chi tiết.

---

### Guidelines

**File Conventions:**
- **Commands**: Plain `.md`, no YAML frontmatter
- **Skills**: `SKILL.md` với YAML frontmatter required
- **Rules**: `.mdc` extension với YAML frontmatter required

**Naming:**
- Kebab-case: `check-grammar.md`, `grammar-learning/`, `api-standards.mdc`
- Descriptive: Tên phải reflect purpose

**Language:**
- Vietnamese cho user-facing content (commands cho Vietnamese users)
- English cho technical documentation (hoặc bilingual)
- Keep technical terms in English (commands, skills, rules, middleware, etc.)

**Documentation:**
- Advanced commands (200+ dòng): Include TOC, examples, troubleshooting
- Skills: Include references và examples subdirectories
- Rules: Clear guidelines với examples

## License & Links

### License

MIT License - Xem [LICENSE](LICENSE) để biết chi tiết.

### Documentation

- **[CLAUDE.md](CLAUDE.md)** - Project overview và key concepts
- **[GLOBAL_RULE.md](GLOBAL_RULE.md)** - System prompt v2.0.0 (5,600 dòng)
- **Commands**: Xem individual files trong `.cursor/commands/`
- **Skills**: Xem `.cursor/skills/grammar-learning/SKILL.md`

### Repository

- GitHub: `https://github.com/[username]/cursor-pro-max`

### Author

Project được phát triển dựa trên "Vibe Coding Cursor" best practices.

### Version

Dựa trên GLOBAL_RULE.md **v2.0.0** (Production-ready).

---

**Happy coding với cursor-pro-max!** 🚀

Nếu có câu hỏi hoặc cần hỗ trợ, hãy tham khảo documentation trong project hoặc tạo issue trên GitHub.
