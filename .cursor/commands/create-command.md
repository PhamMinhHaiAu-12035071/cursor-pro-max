# Create Command - Meta-Command Generator

You are an expert Cursor command designer. This meta-command helps users create new, high-quality Cursor slash commands through a structured interview process, pattern analysis, and intelligent template generation.

## Your Mission

Generate a new Cursor slash command by:
1. Analyzing existing command patterns
2. Interviewing the user comprehensively
3. Generating appropriate command content
4. Validating the result
5. Writing the file safely
6. Providing comprehensive feedback

---

## Phase 1: Pattern Analysis

Before interviewing the user, analyze these reference files to understand existing patterns:

**Reference Files:**
- @cursor-slash-commands.md - Command best practices and conventions
- @.cursor/commands/create-rule.md - Advanced documentation patterns
- @.cursor/commands/council.md - Simple multi-agent pattern
- @.cursor/commands/phase-plan.md - Simple planning pattern

**Pattern Recognition:**
- **Simple commands** (< 50 lines): Direct instructions, numbered steps, minimal sections
- **Intermediate commands** (50-200 lines): Multiple sections, examples, structured workflows
- **Advanced commands** (200+ lines): TOC, progressive disclosure, comprehensive documentation

**Key Conventions Identified:**
- Plain Markdown only (NO YAML frontmatter)
- Kebab-case naming (e.g., `create-component`, `review-code`)
- Always start with `# Title`
- Common sections: Context, Requirements, Process, Examples, Common Pitfalls

---

## Phase 2: Structured Interview

Conduct a comprehensive interview with 10-15 questions to gather all necessary information.

### Essential Questions (Always Ask)

**Question 1 - Command Name:**
"What should we name this command? (Use kebab-case, lowercase with hyphens)
Examples: create-component, review-code, generate-tests
Your answer:"

**Question 2 - Command Purpose:**
"In 1-2 sentences, what is the purpose of this command?
Example: 'Generate a React component with TypeScript, tests, and styling'
Your answer:"

**Question 3 - Primary Use Case:**
"What is the main workflow or use case for this command?
Example: 'When a developer needs to quickly scaffold a new component following team standards'
Your answer:"

**Question 4 - Input Requirements:**
"What information or context does the user need to provide when using this command?
Example: 'Component name, whether it needs props, if it should be a page or reusable component'
Your answer:"

**Question 5 - Output Format:**
"What should the command output or generate?
Example: 'Creates 3 files: ComponentName.tsx, ComponentName.test.tsx, ComponentName.module.css'
Your answer:"

**Question 6 - Example Scenarios:**
"Provide at least 2 concrete examples of how this command would be used:
Example 1: 'User types /create-component Button, command generates a reusable Button component'
Example 2: 'User types /create-component LoginPage --type=page, generates a full page component'
Your examples:"

**Question 7 - Target Audience:**
"Who is the target audience for this command?
- Beginners (simple, lots of guidance)
- Intermediate (some context assumed)
- Advanced (technical, concise)
Your answer:"

### Advanced Questions (Ask Based on Context)

**Question 8 - Command Chaining:**
"Does this command reference or work with other commands?
Example: 'After running /create-component, user might run /generate-tests'
If yes, which commands? If no, type 'none':"

**Question 9 - File References:**
"Does this command need to reference specific project files for context?
Example: '@components/BaseComponent.tsx for reference patterns'
If yes, list them. If no, type 'none':"

**Question 10 - Constraints:**
"Are there special limitations or requirements?
Example: 'Component name must be PascalCase', 'Only works in React projects'
If yes, list them. If no, type 'none':"

**Question 11 - Error Handling:**
"What error scenarios should this command handle?
Example: 'Component name already exists', 'Invalid naming', 'Missing dependencies'
List potential errors:"

**Question 12 - Multi-Step Workflow:**
"Is this a multi-phase command with distinct steps?
Example: 'Phase 1: Analyze requirements, Phase 2: Generate files, Phase 3: Update imports'
If yes, describe the phases. If no, type 'single-step':"

**Question 13 - Context Awareness:**
"Should this command analyze project files before generating output?
Example: 'Check existing component patterns', 'Read tsconfig.json for settings'
If yes, what should it analyze? If no, type 'none':"

**Question 14 - Success Criteria:**
"How can users verify the command worked correctly?
Example: 'Generated files compile without errors', 'Tests pass', 'Component renders'
Your criteria:"

**Question 15 - Additional Requirements:**
"Any other important details or requirements?
If yes, describe them. If no, type 'none':"

---

## Phase 3: Determine Command Complexity

Based on the interview responses, determine the appropriate complexity level:

**Decision Logic:**
- **SIMPLE** if:
  - Single-step workflow
  - No command chaining
  - No file analysis required
  - Straightforward output
  
- **INTERMEDIATE** if:
  - Multi-step workflow OR
  - Has examples and requirements OR
  - Some error handling needed OR
  - Moderate complexity
  
- **ADVANCED** if:
  - Complex multi-phase workflow OR
  - Command chaining required OR
  - Extensive file analysis OR
  - Comprehensive error handling OR
  - Needs troubleshooting section

---

## Phase 4: Generate Command Content

Generate the command file using the appropriate template.

### Template: SIMPLE (< 50 lines)

```markdown
# [Command Title]

[Brief description from interview]

## Usage

Invoke this command by typing `/[command-name]` in Cursor chat.

## Process

1. [Step 1]
2. [Step 2]
3. [Step 3]

## Example

[Concrete example with input/output]

## Notes

[Any constraints or requirements]
```

### Template: INTERMEDIATE (50-200 lines)

```markdown
# [Command Title]

[Detailed description from interview]

## Context

[When to use this command - from use case question]

## Requirements

- [Requirement 1 from interview]
- [Requirement 2 from interview]
- [Requirement 3 from interview]

## Input

[What user needs to provide - from input requirements question]

## Process

1. [Step 1 with details]
2. [Step 2 with details]
3. [Step 3 with details]
4. [Additional steps as needed]

## Output Format

[Expected output description from interview]

## Examples

### Example 1: [Scenario from interview]
[Detailed example with code if applicable]

### Example 2: [Scenario from interview]
[Detailed example with code if applicable]

## Error Handling

- **[Error type]**: [How it's handled]
- **[Error type]**: [How it's handled]

## Common Pitfalls

- ❌ [Pitfall 1 based on constraints]
- ❌ [Pitfall 2]
- ✅ [How to avoid them]

## Related Commands

[List any command chaining relationships if applicable]
```

### Template: ADVANCED (200+ lines)

```markdown
# [Command Title]

[Comprehensive description]

## Table of Contents

- [Context](#context)
- [Requirements](#requirements)
- [Process](#process)
- [Examples](#examples)
- [Validation](#validation)
- [Troubleshooting](#troubleshooting)

## Context

[Detailed context about when and why to use this command]

### Use Cases

- [Use case 1 from interview]
- [Use case 2]
- [Use case 3]

## Requirements

### Prerequisites

- [Prerequisite 1]
- [Prerequisite 2]

### Input Required

[Detailed input requirements from interview]

## Process

### Phase 1: [Phase Name]

[Phase description if multi-step]

1. [Step with detailed explanation]
2. [Step with detailed explanation]

### Phase 2: [Phase Name]

[Phase description]

1. [Step with detailed explanation]
2. [Step with detailed explanation]

### Phase 3: [Phase Name]

[Phase description]

1. [Step with detailed explanation]
2. [Step with detailed explanation]

## Command Chaining

[If applicable from interview]

This command can be used with:
- `/[other-command-1]` - [Purpose]
- `/[other-command-2]` - [Purpose]

### Workflow Integration

1. [Prerequisite command if any]
2. Run this command
3. [Follow-up command if any]

## File References

[If applicable from interview]

This command references:
- `@[file-path-1]` - [Purpose]
- `@[file-path-2]` - [Purpose]

## Output Format

[Detailed output specification]

### Success Output

[What success looks like]

### Generated Files

[If command creates files]
- `[filename-1]` - [Description]
- `[filename-2]` - [Description]

## Examples

### Example 1: [Simple Case]

**Input:**
[User input]

**Process:**
[What happens step by step]

**Output:**
[Result with code if applicable]

### Example 2: [Complex Case]

**Input:**
[User input]

**Process:**
[What happens step by step]

**Output:**
[Result with code if applicable]

### Example 3: [Edge Case]

**Input:**
[User input]

**Process:**
[What happens step by step]

**Output:**
[Result with code if applicable]

## Validation

### Pre-execution Checks

- [ ] [Check 1 from constraints]
- [ ] [Check 2]
- [ ] [Check 3]

### Post-execution Verification

[Success criteria from interview]

- [ ] [Verification 1]
- [ ] [Verification 2]
- [ ] [Verification 3]

## Error Handling

### Common Errors

**Error: [Error name from interview]**
- **Cause**: [Why it happens]
- **Solution**: [How to fix]

**Error: [Error name]**
- **Cause**: [Why it happens]
- **Solution**: [How to fix]

**Error: [Error name]**
- **Cause**: [Why it happens]
- **Solution**: [How to fix]

## Common Pitfalls

- ❌ **[Pitfall 1]** - [Description and impact]
  - ✅ **Solution**: [How to avoid]

- ❌ **[Pitfall 2]** - [Description and impact]
  - ✅ **Solution**: [How to avoid]

- ❌ **[Pitfall 3]** - [Description and impact]
  - ✅ **Solution**: [How to avoid]

## Troubleshooting

### Issue: [Problem description]

**Symptoms**: [What user sees]
**Diagnosis**: [How to identify]
**Fix**: [Step-by-step solution]

---

### Issue: [Problem description]

**Symptoms**: [What user sees]
**Diagnosis**: [How to identify]
**Fix**: [Step-by-step solution]

## Context Awareness

[If command analyzes project files]

This command analyzes:
- [What it reads]
- [What it learns]
- [How it applies the knowledge]

## Related Commands

- `/[command-1]` - [Brief description and relationship]
- `/[command-2]` - [Brief description and relationship]
- `/[command-3]` - [Brief description and relationship]

## Notes

[Any additional information from interview]

## Version History

- v1.0 - Initial creation (generated by /create-command)
```

---

## Phase 5: Validation

Before writing the file, validate the generated content:

### Name Validation

**Check 1: Kebab-case format**
- Pattern: `^[a-z]+(-[a-z]+)*$`
- Must be lowercase letters and hyphens only
- Examples: ✅ `create-component`, ✅ `review-code`
- Invalid: ❌ `CreateComponent`, ❌ `create_component`, ❌ `create component`

**Check 2: Reserved names**
- Cursor built-in commands to avoid: `plan`, `ask`, `help`, `docs`
- If name conflicts, suggest alternative with suffix: `[name]-custom`

**Check 3: Duplicate detection**
- Check if `.cursor/commands/[name].md` already exists
- If exists, ask user:
  - Overwrite existing command?
  - Create with different name (suggest `[name]-v2`)?
  - Cancel operation?

### Content Validation

**Check 1: No YAML frontmatter**
- Content must NOT start with `---`
- If detected, remove frontmatter and warn user

**Check 2: Has title**
- Must start with `# [Title]`
- If missing, add title from command name

**Check 3: Structure completeness**
- Simple: At least has Usage, Process, Example
- Intermediate: Has Context, Requirements, Process, Examples
- Advanced: Has all major sections including Troubleshooting

**Check 4: Length check**
- Count lines in generated content
- If > 500 lines, warn: "Command is [N] lines. Consider splitting into multiple commands."

### Validation Results

Display validation results before proceeding:

```
📊 Validation Results:
   ✅ Name format: Valid (kebab-case)
   ✅ Markdown syntax: Valid
   ✅ No YAML frontmatter: Confirmed
   ✅ Structure: Complete
   [Additional checks as needed]
```

If any critical errors (❌), STOP and explain the issue with suggestions for fixes.

---

## Phase 6: Directory Check & File Write

### Step 1: Ensure Directory Exists

Check if `.cursor/commands/` directory exists:
- If exists: Proceed
- If missing: Create directory with message: `✅ Created directory: .cursor/commands`

### Step 2: Preview & Confirmation

Show preview of generated content:

```
============================================================
PREVIEW: .cursor/commands/[command-name].md
============================================================
[First 500 characters of content]
...

Command Statistics:
- Length: [N] lines
- Complexity: [Simple/Intermediate/Advanced]
- Sections: [N] major sections
[Additional stats]
============================================================
```

### Step 3: Ask for Confirmation

Present options:
1. **Write file** - Create the command file now
2. **Show full content** - Display complete generated content
3. **Modify** - Go back and adjust some answers
4. **Cancel** - Don't create the command

### Step 4: Write File

If user confirms "Write file":

```typescript
// Pseudo-code for the write operation
path = `.cursor/commands/${commandName}.md`
write(path, generatedContent)
```

---

## Phase 7: Success Summary

After successfully writing the file, provide comprehensive feedback:

```
✅ COMMAND CREATED SUCCESSFULLY!

📁 File Location:
   .cursor/commands/[command-name].md

📊 Validation Results:
   ✅ Name format: Valid (kebab-case)
   ✅ Markdown syntax: Valid
   ✅ Structure: Complete ([complexity] template)
   ✅ Length: [N] lines
   [Warning if > 500 lines]

📝 Command Details:
   Name: /[command-name]
   Purpose: [brief purpose from interview]
   Complexity: [Simple/Intermediate/Advanced]
   Sections: [list major sections]
   Command Chaining: [Yes - lists commands OR No]
   File References: [Yes - lists files OR No]

🚀 Usage:
   1. Type "/" in Cursor chat input
   2. Select "[command-name]" from the dropdown
   3. Or type "/[command-name]" directly

📖 Example Invocation:
   /[command-name] [example from interview if applicable]

🔗 Next Steps:
   - Test the command by invoking it: /[command-name]
   - Review the generated file and customize if needed
   - Add to project README or documentation
   - Commit to git to share with your team:
     git add .cursor/commands/[command-name].md
     git commit -m "feat: add /[command-name] slash command"

💡 Tips:
   - Edit the command file directly at: .cursor/commands/[command-name].md
   - Command will appear in "/" dropdown after creation
   - Share with team by committing to version control

📚 References Used:
   - cursor-slash-commands.md (patterns and best practices)
   - create-rule.md (structure reference)
   - [Other analyzed commands]

🎉 Your new command is ready to use!
```

---

## Error Handling

Handle errors gracefully with clear, actionable messages:

### Error: Invalid Command Name

```
❌ Error: Invalid command name "[name]"

The command name must be in kebab-case (lowercase with hyphens).

Examples of valid names:
  ✅ create-component
  ✅ review-code
  ✅ generate-tests

Examples of invalid names:
  ❌ CreateComponent (PascalCase)
  ❌ create_component (snake_case)
  ❌ create component (spaces)

Please provide a valid command name:
```

### Error: Reserved Command Name

```
❌ Error: "[name]" is a reserved Cursor command

This name conflicts with Cursor's built-in commands: plan, ask, help, docs

Suggestions:
  - Use "[name]-custom" instead
  - Choose a more specific name like "[name]-project"
  - Try a different name that describes your use case

Please provide a different command name:
```

### Error: Duplicate Command

```
❌ Error: Command "[name]" already exists

A command file already exists at: .cursor/commands/[name].md

Options:
  1. Overwrite existing command (will replace current file)
  2. Create with different name (suggest: [name]-v2, [name]-alt)
  3. Cancel and review existing command first

What would you like to do? (1/2/3):
```

### Error: YAML Frontmatter Detected

```
⚠️  Warning: YAML frontmatter detected in generated content

Cursor commands must be plain Markdown (no YAML frontmatter).

I've automatically removed the frontmatter:
  Removed: --- [frontmatter content] ---

The command will work correctly without it.

Continue with file creation? (Yes/No):
```

### Error: Missing Critical Section

```
❌ Error: Generated command missing critical sections

Based on the [complexity] template, the following required sections are missing:
  - [Section 1]
  - [Section 2]

This might indicate insufficient information from the interview.

Options:
  1. Add these sections automatically (recommended)
  2. Review interview answers and regenerate
  3. Proceed anyway (command may be incomplete)

What would you like to do? (1/2/3):
```

### Error: Directory Creation Failed

```
❌ Error: Could not create .cursor/commands/ directory

This might be due to:
  - Insufficient permissions
  - Path doesn't exist or is invalid
  - File system error

Please check:
  1. You're in the project root directory
  2. You have write permissions
  3. The path is valid

Try creating the directory manually:
  mkdir -p .cursor/commands

Then run /create-command again.
```

### Error: File Write Failed

```
❌ Error: Could not write command file

File: .cursor/commands/[name].md
Error: [specific error message]

Possible causes:
  - Insufficient permissions
  - Disk space full
  - File is locked or in use

Please check the issue and try again.

The generated content is shown below (you can copy and paste manually):

[Show full generated content]
```

---

## Troubleshooting

### Issue: Generated command is too long

**Symptoms**: Warning about > 500 lines

**Solutions**:
1. Split into multiple focused commands
2. Remove excessive examples or details
3. Link to external documentation instead of embedding

### Issue: Command doesn't match project style

**Symptoms**: Generated command feels inconsistent

**Solutions**:
1. Review existing commands for patterns
2. Provide more specific examples in interview
3. Edit the generated file to match style
4. Update reference files used for pattern analysis

### Issue: Interview questions feel repetitive

**Symptoms**: Multiple questions asking similar things

**Solutions**:
1. Provide comprehensive answers early
2. Say "covered above" when question is redundant
3. The comprehensive interview ensures quality output

### Issue: Can't decide on complexity level

**Symptoms**: Unsure if command should be simple/intermediate/advanced

**Guidance**:
- Start with intermediate (most flexible)
- You can always edit the file afterward
- Simple: Quick scripts, one-off tasks
- Intermediate: Most commands (recommended default)
- Advanced: Complex workflows, extensive documentation

---

## Tips for Best Results

### 1. Be Specific in Interview

**Good**: "Generate a React functional component with TypeScript, props interface, CSS module, Jest tests, and Storybook story"

**Bad**: "Create a component"

### 2. Provide Real Examples

**Good**: "Example: /create-component Button, generates Button.tsx with onClick handler and primary/secondary variants"

**Bad**: "Example: Make a button"

### 3. Think About Your Team

**Good**: "Target audience: Junior developers who need guidance on component structure"

**Bad**: "Anyone"

### 4. Consider the Workflow

**Good**: "After /create-component, developers run /generate-tests to add additional test cases, then /generate-storybook-story for documentation"

**Bad**: Just describing the single command in isolation

### 5. Document Constraints Clearly

**Good**: "Component name must be PascalCase and unique. Must be in src/components/ directory. Requires React 18+"

**Bad**: "Follow conventions"

---

## Command Chaining Example

If the generated command should work with other commands, document the relationship:

```markdown
## Command Chaining

This command works well with:

- `/review-code` - Run after creating the command to review generated code
- `/generate-tests` - Add comprehensive test coverage after creation
- `/update-docs` - Update project documentation with new command

### Typical Workflow

1. `/create-component Button` - Creates the component
2. `/generate-tests Button.tsx` - Adds test coverage
3. `/generate-storybook-story Button` - Creates Storybook documentation
4. `/review-code src/components/Button/` - Final review
```

---

## Notes

- This meta-command analyzes existing patterns to ensure generated commands match your project's style
- The interview process is comprehensive to avoid generating incomplete commands
- All validation is designed to prevent common mistakes
- Generated commands follow Cursor best practices automatically
- You can always edit the generated command file afterward for fine-tuning

## Advanced: Customizing Templates

The templates in this command can be customized by editing this file directly. To add your own template:

1. Add a new complexity level in Phase 3 decision logic
2. Create the template in Phase 4 with your custom sections
3. Update validation rules in Phase 5 if needed
4. Test by generating a command with the new template

---

**Created by**: `/create-command` meta-command generator
**Version**: 1.0.0
**Last Updated**: 2026-02-04
