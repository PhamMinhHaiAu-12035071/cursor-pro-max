# Changelog

All notable changes to Lyra v2 - The Cognitive Prompt Architect will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.1.0] - 2026-02-05

### 🎉 Major Feature: Interactive Dialogue with AskUserQuestion Tool

#### Added

**Core Features:**
- **Interactive Dialogue System**: Integrated Claude's native `AskUserQuestion` tool for guided, structured question-answer experience
- **Multi-Level Question Strategy**:
  - Quick Boost: 0-2 critical questions (single round)
  - Deep Dive: 3-5 questions (2 rounds)
  - Revolutionary: 10-15 questions (3-4 rounds)
- **Bilingual Auto-Detection**: Automatic EN/VN language detection with matching question templates
- **Smart Iteration Logic**: WHILE loop pattern to ask follow-up questions until context is complete
- **Context-Aware Questions**: Later questions adapt based on earlier answers

**Documentation:**
- **New Reference Files**:
  - `references/dialogue-workflows.md` (~150 lines) - Complete workflow patterns and decision trees
  - `references/question-library.md` (~180 lines) - Comprehensive question bank with EN/VN templates
  - `references/askuserquestion-patterns.md` (~170 lines) - Best practices and common patterns (corrected filename)

**Enhanced Existing Documentation:**
- `SKILL.md`: Added comprehensive "Interactive Dialogue with AskUserQuestion Tool" section (~100 lines)
- `references/core-concepts.md`: Enhanced Dialogue Engine with implementation details (~200 lines)
- `references/vietnamese-guide.md`: Added bilingual question patterns and templates (~150 lines)
- `README.md`: Updated with v1.1.0 features, interactive dialogue section, migration guide

**Example Files Updated:**
- **Quick Boost** (3 files):
  - `examples/quick-boost/basic-clarity.md` - Added 0-2 question dialogue example
  - `examples/quick-boost/output-format.md` - Added format clarification dialogue
  - `examples/quick-boost/role-assignment.md` - Added role perspective dialogue
- **Deep Dive** (4 files):
  - `examples/deep-dive/chain-of-thought.md` - Added 3-5 question multi-round dialogue
  - `examples/deep-dive/few-shot-learning.md` - Added documentation purpose dialogue
  - `examples/deep-dive/constraint-optimization.md` - Added constraint analysis dialogue
  - `examples/deep-dive/multi-perspective.md` - Added stakeholder perspective dialogue
- **Revolutionary** (3 files):
  - `examples/revolutionary/graph-of-thoughts.md` - Added 14-question comprehensive dialogue
  - `examples/revolutionary/multi-framework.md` - Added 14-question migration strategy dialogue
  - `examples/revolutionary/platform-specific.md` - Added 15-question platform optimization dialogue
- **Vietnamese** (2 files):
  - `examples/vietnamese/basic-vietnamese.md` - Added full Vietnamese dialogue examples
  - `examples/vietnamese/advanced-vietnamese.md` - Added advanced multi-round Vietnamese dialogue

**Question Templates:**
- 5 core question categories with EN/VN versions:
  1. Goal Clarification
  2. Audience Definition
  3. Context Exploration
  4. Structural Preferences
  5. Criticality Assessment
- Domain-specific questions for: Web dev, Database, API design, Testing, Debugging, Migration, Optimization

**Workflow Patterns:**
- 12 reusable patterns documented in `askquestion-patterns.md`:
  - Single-Round Quick Clarification
  - Parallel Information Gathering
  - Sequential Deep Dive
  - Exploration Tree
  - Iterative Refinement
  - Validation & Clarification
  - Progressive Disclosure
  - Multi-Select for Related Options
  - Bilingual Language Matching
  - Contextual Option Generation
  - Default Values with Override
  - Error Recovery

#### Fixed

**Critical Tool Name Correction (2026-02-05):**
- **Issue**: Initial implementation incorrectly used "AskUserQuestion" throughout all documentation
- **Correction**: Updated all 104 occurrences across 17 files to use correct tool name "AskUserQuestion"
- **Files affected**: SKILL.md, README.md, CHANGELOG.md, all reference docs, all 12 example files
- **Reference**: [Official AskUserQuestion tool description](https://raw.githubusercontent.com/Piebald-AI/claude-code-system-prompts/refs/heads/main/system-prompts/tool-description-askuserquestion.md)
- **Impact**: Tool now references the correct Claude Code API
- **Credit**: Thanks to user for catching this critical error

#### Changed

**Dialogue Phase (Phase 1):**
- **Before (v1.0)**: Text-based questions in assistant output
- **After (v1.1)**: Structured AskUserQuestion tool calls with UI-rendered options
- **Impact**: Faster, more accurate, clearer user experience

**Optimization Level Behavior:**
- Quick Boost: Now asks 0 questions if prompt is already clear (was always 1-2)
- Deep Dive: Added automatic follow-up round based on answer completeness
- Revolutionary: Structured into 4 distinct rounds (was unstructured)

**Vietnamese Support:**
- Upgraded from translation guidelines to full bilingual question templates
- Added automatic language detection logic
- Added Vietnamese dialogue examples across all optimization levels

#### Improved

**User Experience:**
- Reduced ambiguity: Structured options vs free-form text
- Faster interaction: Click/select vs typing
- Better visibility: Native UI vs text buried in output
- Consistency: Standardized question formats across all levels

**Developer Experience:**
- Complete workflow documentation with code examples
- Ready-to-use question templates (copy-paste)
- 12 documented patterns for common scenarios
- Bilingual support with parallel EN/VN templates

**Quality Assurance:**
- Error handling patterns for invalid/missing answers
- Validation patterns for contradictory responses
- Retry logic with intelligent defaults
- Completeness checks before proceeding to Phase 2

#### Technical Details

**Implementation:**
- AskUserQuestion tool JSON format with `id`, `prompt`, `options`, `allow_multiple`
- Iteration pattern: WHILE loop with max_rounds safety limit
- Language detection: Heuristic-based Vietnamese character detection
- Context management: Progressive context building across rounds

**File Statistics:**
- 12 example files updated (~2000 lines of dialogue content added)
- 3 new reference files created (~500 lines)
- 3 existing reference files enhanced (~450 lines added)
- Total: ~3000 lines of new interactive dialogue documentation

#### Migration Guide

**For Users:**
- No breaking changes - Lyra automatically uses new dialogue system
- Same triggers: "optimize this prompt", "tối ưu prompt", etc.
- Enhanced experience with structured questions vs text

**For Skill Developers:**
- New patterns available for implementing interactive dialogues
- Reference `dialogue-workflows.md` for workflow templates
- Reference `question-library.md` for reusable questions

---

## [1.0.0] - 2026-02-05

### Initial Release

#### Added

**Core Features:**
- 4-Phase Methodology (Dialogue, Blueprint, Synthesis, Refinement)
- 3 Optimization Levels (Quick Boost, Deep Dive, Revolutionary)
- 4 Advanced Reasoning Frameworks (CoT, ToT, GoT, AoT)
- Platform-specific optimizations (Claude, ChatGPT, Gemini)
- Bilingual support (English/Vietnamese)
- Anti-pattern detection and fixes

**Documentation:**
- `SKILL.md` - Main skill definition
- `README.md` - Comprehensive guide
- `references/core-concepts.md` - 4D Methodology details
- `references/optimization-techniques.md` - Technique library
- `references/advanced-frameworks.md` - CoT, ToT, GoT, AoT details
- `references/platform-specific.md` - Platform optimizations
- `references/vietnamese-guide.md` - Vietnamese support
- `references/anti-patterns.md` - Common mistakes and fixes
- `references/examples-index.md` - Example navigation

**Examples:**
- 3 Quick Boost examples
- 4 Deep Dive examples
- 3 Revolutionary examples
- 2 Vietnamese examples

**Total:** 12 comprehensive examples demonstrating all optimization levels

---

## Version History Summary

| Version | Date | Major Changes |
|---------|------|---------------|
| 1.1.0 | 2026-02-05 | Interactive Dialogue with AskUserQuestion Tool |
| 1.0.0 | 2026-02-05 | Initial release with 4-phase methodology |

---

## Roadmap

### v1.2.0 (Planned)
- Custom question templates
- User-defined optimization profiles
- Integration with other Claude Code Skills
- Enhanced platform-specific features

### v2.0.0 (Future)
- Machine learning-based prompt analysis
- Automated A/B testing framework
- Prompt performance analytics
- Multi-agent prompt optimization

---

**Note:** All dates reflect 2026-02-05 as the development date in the conversation context.
