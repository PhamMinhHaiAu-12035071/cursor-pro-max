#!/usr/bin/env bash
# cursor-pro-max Installation Script
#
# Description: Single-file bash script that integrates cursor-pro-max into projects
# by copying .cursor/ directory and GLOBAL_RULE.md with interactive conflict resolution,
# validation, and update/uninstall capabilities.
#
# Usage:
#   ./install.sh              # Install in current directory
#   ./install.sh --update     # Update existing installation
#   ./install.sh --uninstall  # Remove installation
#   ./install.sh --help       # Show help
#   ./install.sh --version    # Show version

# ============================================================================
# STRICT MODE
# ============================================================================
set -euo pipefail

# ============================================================================
# CONFIGURATION
# ============================================================================
readonly VERSION="1.0.0"
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"

# ============================================================================
# COLOR CONSTANTS
# ============================================================================
# Initialize color variables (will be set by init_colors)
GREEN=""
RED=""
YELLOW=""
BLUE=""
BOLD=""
RESET=""

# Function to initialize colors using tput for cross-platform support
init_colors() {
    if has_color; then
        GREEN=$(tput setaf 2 2>/dev/null || echo "")
        RED=$(tput setaf 1 2>/dev/null || echo "")
        YELLOW=$(tput setaf 3 2>/dev/null || echo "")
        BLUE=$(tput setaf 4 2>/dev/null || echo "")
        BOLD=$(tput bold 2>/dev/null || echo "")
        RESET=$(tput sgr0 2>/dev/null || echo "")
    fi
}

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

# Detect if terminal supports colors
# Returns 0 (true) if colors should be used, 1 (false) otherwise
has_color() {
    # Check if NO_COLOR environment variable is set
    if [[ -n "${NO_COLOR:-}" ]]; then
        return 1
    fi
    
    # Check if stdout is a terminal
    if [[ ! -t 1 ]]; then
        return 1
    fi
    
    # Check if terminal supports colors
    if command -v tput >/dev/null 2>&1; then
        local colors
        colors=$(tput colors 2>/dev/null || echo 0)
        if [[ $colors -ge 8 ]]; then
            return 0
        fi
    fi
    
    return 1
}

# Logging functions with emojis and colors
log_info() {
    echo "${BLUE}ℹ️  $*${RESET}"
}

log_success() {
    echo "${GREEN}✅ $*${RESET}"
}

log_error() {
    echo "${RED}❌ $*${RESET}" >&2
}

log_warning() {
    echo "${YELLOW}⚠️  $*${RESET}"
}

# Check if required prerequisites are available
check_prerequisites() {
    local missing_tools=()
    local required_tools=("cp" "mv" "rm" "find")
    
    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" >/dev/null 2>&1; then
            missing_tools+=("$tool")
        fi
    done
    
    if [[ ${#missing_tools[@]} -gt 0 ]]; then
        log_error "Missing required tools: ${missing_tools[*]}"
        log_error "Please install these tools before running this script."
        exit 3
    fi
    
    log_success "All prerequisites are available"
}

# Show help message
show_help() {
    cat <<EOF
${BOLD}cursor-pro-max Installation Script${RESET}

${BOLD}DESCRIPTION${RESET}
    Installs cursor-pro-max toolkit into your project by copying:
    - .cursor/ directory (commands and skills)
    - GLOBAL_RULE.md (system prompt)
    
    Supports install, update, and uninstall modes with interactive conflict resolution.

${BOLD}USAGE${RESET}
    ${SCRIPT_NAME} [OPTIONS] [TARGET_DIR]

${BOLD}OPTIONS${RESET}
    --help              Show this help message
    --version           Show version information
    --update            Update existing installation (processes only changed files)
    --uninstall         Remove installation from project

${BOLD}ARGUMENTS${RESET}
    TARGET_DIR          Target directory for installation (default: current directory)

${BOLD}EXAMPLES${RESET}

    ${BOLD}Basic Installation (Greenfield Project)${RESET}
    
        # Install in current directory
        cd /path/to/your-project
        ${SCRIPT_NAME}
        
        # Install in specific directory
        ${SCRIPT_NAME} /path/to/your-project

    ${BOLD}Installation with Conflicts (Brownfield Project)${RESET}
    
        # Install where .cursor/ already exists
        cd /path/to/existing-project
        ${SCRIPT_NAME}
        # You'll be prompted to overwrite or skip conflicting files
        
    ${BOLD}Update Mode${RESET}
    
        # Update only changed files (preserves your modifications)
        cd /path/to/project-with-cursor-pro-max
        ${SCRIPT_NAME} --update
        # Only modified files will be updated (with prompts)
        
    ${BOLD}Uninstall Mode${RESET}
    
        # Remove cursor-pro-max from project
        cd /path/to/project-with-cursor-pro-max
        ${SCRIPT_NAME} --uninstall
        # Removes .cursor/ directory and GLOBAL_RULE.md
        
    ${BOLD}Help and Version${RESET}
    
        # Show this help message
        ${SCRIPT_NAME} --help
        
        # Show version
        ${SCRIPT_NAME} --version

${BOLD}WHAT GETS INSTALLED${RESET}

    .cursor/commands/            6 slash commands for Cursor IDE:
                                 • check-grammar.md    - Grammar checking
                                 • council.md          - Multi-agent coordination
                                 • create-command.md   - Create new commands
                                 • create-rule.md      - Create Cursor rules
                                 • interview.md        - Requirements gathering
                                 • phase-plan.md       - Project phase planning

    .claude/skills/              AI Skills:
                                 • grammar-learning/   - Grammar correction skill

    GLOBAL_RULE.md               System prompt (~5,600 lines)
                                 Comprehensive AI guidelines and best practices

${BOLD}CONFLICT RESOLUTION${RESET}

    When files already exist, you'll receive grouped prompts:
    
    1. Commands conflict    - Overwrite all command files? (y/n)
    2. Skills conflict      - Overwrite all skills? (y/n)
    3. GLOBAL_RULE conflict - Overwrite GLOBAL_RULE.md? (y/n)
    
    This reduces prompt fatigue while giving you control.

${BOLD}UPDATE MODE BEHAVIOR${RESET}

    Update mode (--update) is smart:
    
    ✓ Only processes files that changed in source
    ✓ Skips identical files (checksum comparison)
    ✓ Prompts individually for each changed file
    ✓ Shows summary of updated vs skipped files
    
    Perfect for pulling latest changes from cursor-pro-max repo.

${BOLD}PREREQUISITES${RESET}

    Required tools (usually pre-installed on macOS/Linux):
    • cp       - Copy files and directories
    • mv       - Move files
    • rm       - Remove files
    • find     - Find files
    • bash     - Bash shell (3.2+)
    
    The script validates these before proceeding.

${BOLD}EXIT CODES${RESET}

    0    Success
    1    General error
    2    Invalid arguments
    3    Prerequisites not met
    126  Permission denied
    130  User interrupted (Ctrl+C)

${BOLD}TROUBLESHOOTING${RESET}

    Permission denied:
        chmod +x ${SCRIPT_NAME}
        
    Installation incomplete:
        Check file permissions in target directory
        Ensure you have write access
        
    Validation failed:
        Verify source directory structure
        Run from cursor-pro-max repository root

${BOLD}MORE INFO${RESET}

    Repository: https://github.com/yourusername/cursor-pro-max
    Documentation: See README.md
    Issues: Report bugs at GitHub Issues

${BOLD}AFTER INSTALLATION${RESET}

    ${YELLOW}IMPORTANT:${RESET} Restart Cursor IDE to load new commands and rules!
    
    Then try:
        /interview          Start requirements interview
        /phase-plan         Create phased project plan
        /check-grammar      Check English grammar

EOF
}

# Show version information
show_version() {
    echo "cursor-pro-max installation script version ${VERSION}"
}

# Parse command-line arguments
parse_args() {
    local mode="install"
    local target_dir="${PWD}"
    
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --help|-h)
                show_help
                exit 0
                ;;
            --version|-v)
                show_version
                exit 0
                ;;
            --update)
                mode="update"
                shift
                ;;
            --uninstall)
                mode="uninstall"
                shift
                ;;
            -*)
                log_error "Unknown option: $1"
                echo ""
                echo "Run '${SCRIPT_NAME} --help' for usage information."
                exit 2
                ;;
            *)
                target_dir="$1"
                shift
                ;;
        esac
    done
    
    # Return mode and target_dir as global variables
    MODE="$mode"
    TARGET_DIR="$target_dir"
}

# Validate target path and normalize to absolute directory path
# Prevents common mistakes like passing install.sh file path as target
validate_target_dir() {
    local target_dir="$1"
    local resolved_target=""
    local parent_dir=""
    local base_name=""

    if [[ -z "$target_dir" ]]; then
        log_error "Target directory is empty."
        return 1
    fi

    # Common mistake: passing a file path (e.g., /path/to/install.sh)
    if [[ -f "$target_dir" ]]; then
        log_error "Target must be a directory, but got a file: $target_dir"
        log_error "Use a project directory path, for example:"
        log_error "  ${SCRIPT_NAME} /path/to/your-project"
        return 1
    fi

    # Resolve to absolute path for reliable comparisons and logging
    if [[ -d "$target_dir" ]]; then
        resolved_target="$(cd "$target_dir" && pwd)"
    else
        parent_dir="$(dirname "$target_dir")"
        base_name="$(basename "$target_dir")"
        if [[ -d "$parent_dir" ]]; then
            resolved_target="$(cd "$parent_dir" && pwd)/${base_name}"
        else
            log_error "Parent directory does not exist: $parent_dir"
            return 1
        fi
    fi

    # Guardrail: source and target must not be the same directory
    if [[ "$resolved_target" == "$SCRIPT_DIR" ]]; then
        log_error "Target directory cannot be the same as source directory."
        log_error "Source: $SCRIPT_DIR"
        log_error "Target: $resolved_target"
        log_error "Please provide a different project directory."
        return 1
    fi

    TARGET_DIR="$resolved_target"
    return 0
}

# ============================================================================
# INTERACTIVE PROMPTS AND USER INPUT (Phase 3)
# ============================================================================

# Prompt for yes/no questions with default value
# Usage: prompt_yes_no "Question?" "y" (default yes) or "n" (default no)
# Returns: 0 for yes, 1 for no
prompt_yes_no() {
    local question="$1"
    local default="${2:-n}"  # Default to "n" if not specified
    local prompt_suffix
    
    if [[ "$default" == "y" ]]; then
        prompt_suffix="(Y/n)"
    else
        prompt_suffix="(y/N)"
    fi
    
    while true; do
        echo -n "${question} ${prompt_suffix}: "
        read -r response
        
        # Use default if empty response
        if [[ -z "$response" ]]; then
            response="$default"
        fi
        
        # Normalize to lowercase
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
        
        case "$response" in
            y|yes)
                return 0
                ;;
            n|no)
                return 1
                ;;
            *)
                log_warning "Please answer 'y' or 'n'"
                ;;
        esac
    done
}

# Prompt for grouped conflicts (all files of same type)
# Usage: prompt_group_conflict "commands" 5
# Returns: 0 to overwrite, 1 to skip
prompt_group_conflict() {
    local conflict_type="$1"
    local count="$2"
    local target_dir="${3:-$TARGET_DIR}"
    
    log_warning ""
    log_warning "${count} ${conflict_type} file(s) already exist"
    
    # List existing files
    case "$conflict_type" in
        commands)
            local commands_dir="${target_dir}/.cursor/commands"
            if [[ -d "$commands_dir" ]]; then
                find "$commands_dir" -maxdepth 1 -type f -name "*.md" -exec basename {} \; | sort | while read -r file; do
                    echo "   - $file"
                done
            fi
            ;;
        skills)
            local skills_dir="${target_dir}/.claude/skills"
            if [[ -d "$skills_dir" ]]; then
                find "$skills_dir" -maxdepth 1 -type d ! -path "$skills_dir" -exec basename {} \; | sort | while read -r dir; do
                    echo "   - $dir/"
                done
            fi
            ;;
        global_rule)
            echo "   - GLOBAL_RULE.md"
            ;;
    esac
    
    echo ""
    if prompt_yes_no "Overwrite all ${conflict_type}?" "n"; then
        return 0  # Overwrite
    else
        return 1  # Skip
    fi
}

# Prompt for uninstall confirmation
# Returns: 0 to proceed, 1 to cancel
prompt_uninstall_confirmation() {
    local target_dir="${1:-$TARGET_DIR}"
    
    log_warning ""
    log_warning "This will PERMANENTLY DELETE the following from ${target_dir}:"
    
    if detect_cursor_dir "$target_dir"; then
        echo "   - .cursor/ directory (commands)"
    fi
    
    if [[ -d "${target_dir}/.claude/skills" ]]; then
        echo "   - .claude/ directory (skills)"
    fi
    
    if detect_global_rule "$target_dir"; then
        echo "   - GLOBAL_RULE.md"
    fi
    
    echo ""
    log_warning "This action cannot be undone!"
    echo ""
    
    if prompt_yes_no "Are you sure you want to uninstall?" "n"; then
        # Double confirmation for safety
        if prompt_yes_no "Really delete? (final confirmation)" "n"; then
            return 0  # Proceed with uninstall
        fi
    fi
    
    return 1  # Cancel
}

# Show summary of what will be affected by installation
show_conflict_summary() {
    local target_dir="${1:-$TARGET_DIR}"
    
    log_info ""
    log_info "Installation Summary:"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Check what exists
    local has_conflicts=false
    
    if detect_cursor_dir "$target_dir"; then
        log_info "Existing .cursor/ directory: ${YELLOW}FOUND${RESET}"
        has_conflicts=true
        
        # Count existing files
        local commands_dir="${target_dir}/.cursor/commands"
        if [[ -d "$commands_dir" ]]; then
            local cmd_count
            cmd_count=$(find "$commands_dir" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $cmd_count -gt 0 ]]; then
                log_info "  - Commands: $cmd_count file(s)"
            fi
        fi
        
        local skills_dir="${target_dir}/.cursor/skills"
        if [[ -d "$skills_dir" ]]; then
            local skills_count
            skills_count=$(find "$skills_dir" -maxdepth 1 -type d ! -path "$skills_dir" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $skills_count -gt 0 ]]; then
                log_info "  - Skills: $skills_count directory(s)"
            fi
        fi
    else
        log_info "Existing .cursor/ directory: ${GREEN}NOT FOUND${RESET} (clean install)"
    fi
    
    if detect_global_rule "$target_dir"; then
        log_info "Existing GLOBAL_RULE.md: ${YELLOW}FOUND${RESET}"
        has_conflicts=true
    else
        log_info "Existing GLOBAL_RULE.md: ${GREEN}NOT FOUND${RESET} (clean install)"
    fi
    
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    if $has_conflicts; then
        log_warning "Conflicts detected - you will be prompted for each group"
    else
        log_success "No conflicts - clean installation"
    fi
    
    log_info ""
}

# Set up trap for graceful Ctrl+C handling
setup_interrupt_handler() {
    trap 'log_error ""; log_error "Installation interrupted by user"; exit 130' SIGINT SIGTERM
}

# ============================================================================
# FILE DETECTION AND VALIDATION
# ============================================================================

# Detect if .cursor/ directory exists in target
detect_cursor_dir() {
    local target_dir="${1:-$TARGET_DIR}"
    
    if [[ -d "${target_dir}/.cursor" ]]; then
        return 0  # exists
    else
        return 1  # does not exist
    fi
}

# Detect if GLOBAL_RULE.md exists in target
detect_global_rule() {
    local target_dir="${1:-$TARGET_DIR}"
    
    if [[ -f "${target_dir}/GLOBAL_RULE.md" ]]; then
        return 0  # exists
    else
        return 1  # does not exist
    fi
}

# Count files by type in source directory
# Usage: count_files_by_type "commands" or "skills"
count_files_by_type() {
    local file_type="$1"
    local source_dir
    if [[ "$file_type" == "skills" ]]; then
        source_dir="${SCRIPT_DIR}/.claude/skills"
    else
        source_dir="${SCRIPT_DIR}/.cursor/${file_type}"
    fi
    local count=0
    
    if [[ -d "$source_dir" ]]; then
        case "$file_type" in
            commands)
                # Count .md files in commands directory
                count=$(find "$source_dir" -maxdepth 1 -type f -name "*.md" | wc -l | tr -d ' ')
                ;;
            skills)
                # Count subdirectories in skills directory
                count=$(find "$source_dir" -maxdepth 1 -type d ! -path "$source_dir" | wc -l | tr -d ' ')
                ;;
            *)
                log_error "Unknown file type: $file_type"
                return 1
                ;;
        esac
    fi
    
    echo "$count"
}

# List conflicts grouped by type
# Returns: Array of conflict types (commands, skills, global_rule)
list_conflicts() {
    local target_dir="${1:-$TARGET_DIR}"
    local conflicts=()
    
    # Check for command conflicts
    if detect_cursor_dir "$target_dir"; then
        local commands_dir="${target_dir}/.cursor/commands"
        if [[ -d "$commands_dir" ]]; then
            local existing_commands
            existing_commands=$(find "$commands_dir" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $existing_commands -gt 0 ]]; then
                conflicts+=("commands:$existing_commands")
            fi
        fi
        
        # Check for skills conflicts
        local skills_dir="${target_dir}/.claude/skills"
        if [[ -d "$skills_dir" ]]; then
            local existing_skills
            existing_skills=$(find "$skills_dir" -maxdepth 1 -type d ! -path "$skills_dir" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $existing_skills -gt 0 ]]; then
                conflicts+=("skills:$existing_skills")
            fi
        fi
    fi
    
    # Check for GLOBAL_RULE.md conflict
    if detect_global_rule "$target_dir"; then
        conflicts+=("global_rule:1")
    fi
    
    # Return conflicts as newline-separated list
    if [[ ${#conflicts[@]} -gt 0 ]]; then
        printf '%s\n' "${conflicts[@]}"
        return 0
    else
        return 1
    fi
}

# Validate source files exist in cursor-pro-max directory
validate_source() {
    local errors=()
    
    log_info "Validating source files..."
    
    # Check .cursor directory exists
    if [[ ! -d "${SCRIPT_DIR}/.cursor" ]]; then
        errors+=(".cursor/ directory not found in source")
    fi
    
    # Check commands directory
    if [[ ! -d "${SCRIPT_DIR}/.cursor/commands" ]]; then
        errors+=(".cursor/commands/ directory not found")
    else
        local cmd_count
        cmd_count=$(count_files_by_type "commands")
        if [[ $cmd_count -eq 0 ]]; then
            errors+=("No command files found in .cursor/commands/")
        fi
    fi
    
    # Check skills directory
    if [[ ! -d "${SCRIPT_DIR}/.claude/skills" ]]; then
        errors+=(".claude/skills/ directory not found")
    else
        # Check for grammar-learning skill specifically
        if [[ ! -d "${SCRIPT_DIR}/.claude/skills/grammar-learning" ]]; then
            errors+=("grammar-learning skill not found in .claude/skills/")
        fi
        
        if [[ ! -f "${SCRIPT_DIR}/.claude/skills/grammar-learning/SKILL.md" ]]; then
            errors+=("SKILL.md not found in grammar-learning/")
        fi
    fi
    
    # Check GLOBAL_RULE.md exists
    if [[ ! -f "${SCRIPT_DIR}/GLOBAL_RULE.md" ]]; then
        errors+=("GLOBAL_RULE.md not found in source")
    else
        # Verify file is not empty
        if [[ ! -s "${SCRIPT_DIR}/GLOBAL_RULE.md" ]]; then
            errors+=("GLOBAL_RULE.md is empty")
        fi
    fi
    
    # Report errors if any
    if [[ ${#errors[@]} -gt 0 ]]; then
        log_error "Source validation failed:"
        for error in "${errors[@]}"; do
            log_error "  - $error"
        done
        log_error ""
        log_error "Please ensure you're running this script from the cursor-pro-max directory."
        return 1
    fi
    
    log_success "Source files validated successfully"
    return 0
}

# Validate installation was successful
validate_installation() {
    local target_dir="${1:-$TARGET_DIR}"
    local errors=()
    
    log_info "Validating installation..."
    
    # Check .cursor directory exists
    if [[ ! -d "${target_dir}/.cursor" ]]; then
        errors+=(".cursor/ directory not found in target")
    else
        # Check commands directory
        if [[ ! -d "${target_dir}/.cursor/commands" ]]; then
            errors+=(".cursor/commands/ directory not found")
        else
            local cmd_count
            cmd_count=$(find "${target_dir}/.cursor/commands" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $cmd_count -lt 6 ]]; then
                errors+=("Expected 6 command files, found $cmd_count")
            fi
        fi
        
        # Check skills directory
        if [[ ! -d "${target_dir}/.claude/skills/grammar-learning" ]]; then
            errors+=("grammar-learning skill directory not found")
        fi
        
        if [[ ! -f "${target_dir}/.claude/skills/grammar-learning/SKILL.md" ]]; then
            errors+=("SKILL.md not found in grammar-learning/")
        fi
    fi
    
    # Check GLOBAL_RULE.md
    if [[ ! -f "${target_dir}/GLOBAL_RULE.md" ]]; then
        errors+=("GLOBAL_RULE.md not found in target")
    else
        # Check file size (should be around 5,600 lines)
        local line_count
        line_count=$(wc -l < "${target_dir}/GLOBAL_RULE.md" | tr -d ' ')
        if [[ $line_count -lt 1000 ]]; then
            errors+=("GLOBAL_RULE.md appears incomplete ($line_count lines)")
        fi
    fi
    
    # Report results
    if [[ ${#errors[@]} -gt 0 ]]; then
        log_error "Installation validation failed:"
        for error in "${errors[@]}"; do
            log_error "  - $error"
        done
        return 1
    fi
    
    log_success "Installation validated successfully"
    
    # Show summary
    local cmd_count
    cmd_count=$(find "${target_dir}/.cursor/commands" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    local line_count
    line_count=$(wc -l < "${target_dir}/GLOBAL_RULE.md" | tr -d ' ')
    
    log_info ""
    log_info "Installed components:"
    log_info "  - Commands: $cmd_count files"
    log_info "  - Skills: grammar-learning"
    log_info "  - GLOBAL_RULE.md: $line_count lines"
    
    return 0
}

# ============================================================================
# CORE INSTALLATION LOGIC (Phase 4)
# ============================================================================

# Preserve file permissions during copy
# Usage: preserve_file_permissions SOURCE DEST
preserve_file_permissions() {
    local source="$1"
    local dest="$2"
    
    # Use cp -p to preserve mode, ownership, and timestamps
    # -R for recursive, -p for preserve attributes
    if ! cp -Rp "$source" "$dest" 2>/dev/null; then
        log_error "Failed to copy $source to $dest"
        return 1
    fi
    
    return 0
}

# Copy .cursor/ directory to target
copy_cursor_directory() {
    local target_dir="${1:-$TARGET_DIR}"
    local source_cursor="${SCRIPT_DIR}/.cursor"
    local target_cursor="${target_dir}/.cursor"
    
    log_info "📁 Copying .cursor/ directory..."
    
    # Create target .cursor directory if it doesn't exist
    if [[ ! -d "$target_cursor" ]]; then
        if ! mkdir -p "$target_cursor"; then
            log_error "Failed to create .cursor/ directory"
            return 1
        fi
    fi
    
    # Copy commands directory
    if [[ -d "${source_cursor}/commands" ]]; then
        log_info "  ➤ Copying commands..."
        if ! preserve_file_permissions "${source_cursor}/commands" "${target_cursor}/"; then
            log_error "Failed to copy commands"
            return 1
        fi
        local cmd_count
        cmd_count=$(find "${target_cursor}/commands" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        log_success "    Copied $cmd_count command file(s)"
    fi
    
    # Copy skills directory from .claude/skills/
    local source_skills="${SCRIPT_DIR}/.claude/skills"
    local target_skills="${target_dir}/.claude/skills"
    if [[ -d "$source_skills" ]]; then
        log_info "  ➤ Copying skills..."
        mkdir -p "${target_dir}/.claude"
        if ! preserve_file_permissions "$source_skills" "${target_dir}/.claude/"; then
            log_error "Failed to copy skills"
            return 1
        fi
        local skills_count
        skills_count=$(find "$target_skills" -maxdepth 1 -type d ! -path "$target_skills" 2>/dev/null | wc -l | tr -d ' ')
        log_success "    Copied $skills_count skill(s)"
    fi
    
    log_success "✅ .cursor/ directory copied successfully"
    return 0
}

# Copy GLOBAL_RULE.md to target
copy_global_rule() {
    local target_dir="${1:-$TARGET_DIR}"
    local source_file="${SCRIPT_DIR}/GLOBAL_RULE.md"
    local target_file="${target_dir}/GLOBAL_RULE.md"
    
    log_info "📄 Copying GLOBAL_RULE.md..."
    
    if ! preserve_file_permissions "$source_file" "$target_file"; then
        log_error "Failed to copy GLOBAL_RULE.md"
        return 1
    fi
    
    local line_count
    line_count=$(wc -l < "$target_file" | tr -d ' ')
    log_success "✅ GLOBAL_RULE.md copied ($line_count lines)"
    
    return 0
}

# Handle conflicts using grouped prompts
# Groups conflicts by type (commands, skills, global_rule) and prompts once per group
# This reduces prompt fatigue compared to asking about each file individually
# Returns: 0 to proceed, 1 to skip
handle_conflicts() {
    local target_dir="${1:-$TARGET_DIR}"
    
    # Default to overwriting everything (will be changed based on user input)
    local overwrite_commands=true
    local overwrite_skills=true
    local overwrite_global_rule=true
    
    # Get list of conflicts from target directory
    # list_conflicts returns format: "type:count" (e.g., "commands:5")
    local conflicts
    if ! conflicts=$(list_conflicts "$target_dir"); then
        # No conflicts found - proceed with clean installation
        return 0
    fi
    
    log_info ""
    log_warning "Conflicts detected - existing files found"
    log_info ""
    
    # Process each conflict type and prompt user
    # IFS=: splits each line by colon into conflict_type and count
    while IFS=: read -r conflict_type count; do
        case "$conflict_type" in
            commands)
                # Prompt whether to overwrite all command files
                if ! prompt_group_conflict "commands" "$count" "$target_dir"; then
                    overwrite_commands=false
                    log_info "Skipping commands installation"
                fi
                ;;
            skills)
                # Prompt whether to overwrite all skill directories
                if ! prompt_group_conflict "skills" "$count" "$target_dir"; then
                    overwrite_skills=false
                    log_info "Skipping skills installation"
                fi
                ;;
            global_rule)
                # Prompt whether to overwrite GLOBAL_RULE.md
                if ! prompt_group_conflict "global_rule" "$count" "$target_dir"; then
                    overwrite_global_rule=false
                    log_info "Skipping GLOBAL_RULE.md installation"
                fi
                ;;
        esac
    done <<< "$conflicts"
    
    # Store decisions in global variables for use in install_mode()
    OVERWRITE_COMMANDS=$overwrite_commands
    OVERWRITE_SKILLS=$overwrite_skills
    OVERWRITE_GLOBAL_RULE=$overwrite_global_rule
    
    return 0
}

# Main installation mode handler
install_mode() {
    local target_dir="${TARGET_DIR}"
    
    log_info ""
    log_info "════════════════════════════════════════════"
    log_info "  🚀 cursor-pro-max Installation"
    log_info "════════════════════════════════════════════"
    log_info ""
    
    # Validate source files
    if ! validate_source; then
        log_error "Source validation failed. Cannot proceed with installation."
        exit 1
    fi
    
    log_info ""
    
    # Show conflict summary
    show_conflict_summary "$target_dir"
    
    # Handle conflicts if any exist
    handle_conflicts "$target_dir"
    
    log_info ""
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Starting installation..."
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info ""
    
    # ========================================
    # Selective Installation Based on User Choices
    # ========================================
    
    # Copy .cursor/ directory (if not completely skipped)
    # We handle commands and skills separately to allow partial installation
    if ${OVERWRITE_COMMANDS:-true} || ${OVERWRITE_SKILLS:-true}; then
        local source_cursor="${SCRIPT_DIR}/.cursor"
        local target_cursor="${target_dir}/.cursor"
        
        # Ensure .cursor directory exists in target
        mkdir -p "$target_cursor"
        
        # ========================================
        # Install Commands (if user approved)
        # ========================================
        if ${OVERWRITE_COMMANDS:-true}; then
            log_info "📦 Installing commands..."
            if [[ -d "${source_cursor}/commands" ]]; then
                # Remove existing commands directory to avoid conflicts
                if [[ -d "${target_cursor}/commands" ]]; then
                    rm -rf "${target_cursor}/commands"
                fi
                
                # Copy commands directory with permissions preserved
                if preserve_file_permissions "${source_cursor}/commands" "${target_cursor}/"; then
                    local cmd_count
                    cmd_count=$(find "${target_cursor}/commands" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
                    log_success "✅ Installed $cmd_count command(s)"
                else
                    log_error "Failed to copy commands"
                fi
            fi
        else
            log_info "⏭️  Skipped commands (user choice)"
        fi
        
        # ========================================
        # Install Skills (if user approved)
        # ========================================
        if ${OVERWRITE_SKILLS:-true}; then
            log_info "📦 Installing skills..."
            local source_skills="${SCRIPT_DIR}/.claude/skills"
            local target_skills="${target_dir}/.claude/skills"
            if [[ -d "$source_skills" ]]; then
                # Create .claude/skills directory if it doesn't exist
                mkdir -p "$target_skills"
                
                # Copy each skill individually to preserve other existing skills
                local skills_installed=0
                for skill_dir in "$source_skills"/*; do
                    if [[ -d "$skill_dir" ]]; then
                        local skill_name=$(basename "$skill_dir")
                        local target_skill_dir="${target_skills}/${skill_name}"
                        
                        # Remove existing skill with same name (overwrite)
                        if [[ -d "$target_skill_dir" ]]; then
                            rm -rf "$target_skill_dir"
                        fi
                        
                        # Copy skill directory with permissions preserved
                        if preserve_file_permissions "$skill_dir" "$target_skills/"; then
                            ((skills_installed++))
                        else
                            log_error "Failed to copy skill: $skill_name"
                        fi
                    fi
                done
                
                if [[ $skills_installed -gt 0 ]]; then
                    log_success "✅ Installed $skills_installed skill(s)"
                else
                    log_error "No skills were installed"
                fi
            fi
        else
            log_info "⏭️  Skipped skills (user choice)"
        fi
    fi
    
    # ========================================
    # Install GLOBAL_RULE.md (if user approved)
    # ========================================
    if ${OVERWRITE_GLOBAL_RULE:-true}; then
        log_info "📦 Installing GLOBAL_RULE.md..."
        if copy_global_rule "$target_dir"; then
            log_success "✅ Installed GLOBAL_RULE.md"
        else
            log_error "Failed to copy GLOBAL_RULE.md"
        fi
    else
        log_info "⏭️  Skipped GLOBAL_RULE.md (user choice)"
    fi
    
    log_info ""
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Validate installation using enhanced validation (Phase 7)
    if post_install_validation "$target_dir"; then
        # Show installed components summary (Phase 7)
        show_installed_summary "$target_dir"
        
        log_info ""
        log_success "════════════════════════════════════════════"
        log_success "  🎉 Installation completed successfully!"
        log_success "════════════════════════════════════════════"
        
        # Display next steps with Cursor restart reminder (Phase 7)
        show_next_steps
        log_info ""
    else
        log_error ""
        log_error "Installation validation failed. Please check the errors above."
        exit 1
    fi
}

# ============================================================================
# UPDATE MODE (Phase 5)
# ============================================================================

# Calculate checksum of a file for change detection
# Tries multiple checksum tools for cross-platform compatibility:
# 1. shasum (macOS default)
# 2. sha256sum (Linux default)
# 3. md5 (macOS fallback)
# 4. md5sum (Linux fallback)
calculate_checksum() {
    local file="$1"
    
    # Verify file exists
    if [[ ! -f "$file" ]]; then
        echo ""
        return 1
    fi
    
    # Try SHA-256 first (more secure, widely available)
    if command -v shasum >/dev/null 2>&1; then
        # macOS has shasum by default
        shasum -a 256 "$file" 2>/dev/null | awk '{print $1}'
    elif command -v sha256sum >/dev/null 2>&1; then
        # Linux has sha256sum by default
        sha256sum "$file" 2>/dev/null | awk '{print $1}'
    else
        # Fallback to MD5 if SHA-256 not available (rare but possible)
        if command -v md5 >/dev/null 2>&1; then
            # macOS md5 command (-q for quiet mode)
            md5 -q "$file" 2>/dev/null
        elif command -v md5sum >/dev/null 2>&1; then
            # Linux md5sum command
            md5sum "$file" 2>/dev/null | awk '{print $1}'
        else
            # No checksum tool available - should not happen on standard systems
            echo ""
            return 1
        fi
    fi
}

# Detect which files changed between source and target
# Uses checksum comparison to identify modified files
# Returns: List of changes in format "type:filename" or "type:filename:new"
detect_changes() {
    local target_dir="${1:-$TARGET_DIR}"
    local changes=()
    
    # ========================================
    # Check command files for changes
    # ========================================
    local source_commands="${SCRIPT_DIR}/.cursor/commands"
    local target_commands="${target_dir}/.cursor/commands"
    
    if [[ -d "$source_commands" && -d "$target_commands" ]]; then
        # Use null-delimited output to handle filenames with spaces
        # -print0 and read -d '' work together for safe filename handling
        while IFS= read -r -d '' source_file; do
            local filename
            filename=$(basename "$source_file")
            local target_file="${target_commands}/${filename}"
            
            if [[ -f "$target_file" ]]; then
                # Both files exist - compare checksums to detect changes
                local source_sum
                local target_sum
                source_sum=$(calculate_checksum "$source_file")
                target_sum=$(calculate_checksum "$target_file")
                
                if [[ "$source_sum" != "$target_sum" ]]; then
                    # File was modified
                    changes+=("command:${filename}")
                fi
            else
                # File exists in source but not target - new file
                changes+=("command:${filename}:new")
            fi
        done < <(find "$source_commands" -maxdepth 1 -type f -name "*.md" -print0)
    fi
    
    # ========================================
    # Check GLOBAL_RULE.md for changes
    # ========================================
    local source_rule="${SCRIPT_DIR}/GLOBAL_RULE.md"
    local target_rule="${target_dir}/GLOBAL_RULE.md"
    
    if [[ -f "$source_rule" && -f "$target_rule" ]]; then
        # Both files exist - compare checksums
        local source_sum
        local target_sum
        source_sum=$(calculate_checksum "$source_rule")
        target_sum=$(calculate_checksum "$target_rule")
        
        if [[ "$source_sum" != "$target_sum" ]]; then
            # GLOBAL_RULE.md was modified
            changes+=("global_rule:GLOBAL_RULE.md")
        fi
    elif [[ -f "$source_rule" && ! -f "$target_rule" ]]; then
        # GLOBAL_RULE.md exists in source but not target - new file
        changes+=("global_rule:GLOBAL_RULE.md:new")
    fi
    
    # ========================================
    # Check skills directory (recursive comparison)
    # ========================================
    local source_skills="${SCRIPT_DIR}/.claude/skills"
    local target_skills="${target_dir}/.claude/skills"
    
    if [[ -d "$source_skills" ]]; then
        # Recursively find all files in skills directory
        while IFS= read -r -d '' source_file; do
            # Get relative path from skills directory
            # This preserves the directory structure (e.g., "grammar-learning/SKILL.md")
            local rel_path="${source_file#$source_skills/}"
            local target_file="${target_skills}/${rel_path}"
            
            if [[ -f "$target_file" ]]; then
                # File exists in both - compare checksums
                local source_sum
                local target_sum
                source_sum=$(calculate_checksum "$source_file")
                target_sum=$(calculate_checksum "$target_file")
                
                if [[ "$source_sum" != "$target_sum" ]]; then
                    # Skill file was modified
                    changes+=("skill:${rel_path}")
                fi
            else
                # File exists in source but not target - new file
                changes+=("skill:${rel_path}:new")
            fi
        done < <(find "$source_skills" -type f -print0)
    fi
    
    # ========================================
    # Return changes list
    # ========================================
    if [[ ${#changes[@]} -gt 0 ]]; then
        # Print each change on a new line
        printf '%s\n' "${changes[@]}"
        return 0
    else
        # No changes detected
        return 1
    fi
}

# Prompt for each file during update
prompt_update_file() {
    local file_type="$1"
    local filename="$2"
    local is_new="${3:-false}"
    
    if $is_new; then
        log_info "➕ New file: ${filename}"
        if prompt_yes_no "  Add this file?" "y"; then
            return 0
        fi
    else
        log_info "📝 Modified: ${filename}"
        if prompt_yes_no "  Update this file?" "y"; then
            return 0
        fi
    fi
    
    return 1
}

# Main update mode handler
update_mode() {
    local target_dir="${TARGET_DIR}"
    
    log_info ""
    log_info "════════════════════════════════════════════"
    log_info "  🔄 cursor-pro-max Update"
    log_info "════════════════════════════════════════════"
    log_info ""
    
    # Validate source files
    if ! validate_source; then
        log_error "Source validation failed. Cannot proceed with update."
        exit 1
    fi
    
    # Check if installation exists
    if ! detect_cursor_dir "$target_dir" && ! detect_global_rule "$target_dir"; then
        log_error "No existing installation found in ${target_dir}"
        log_error "Use install mode instead: ${SCRIPT_NAME}"
        exit 1
    fi
    
    log_info "Detecting changes..."
    log_info ""
    
    # Detect changes
    local changes
    if ! changes=$(detect_changes "$target_dir"); then
        log_success "✅ No changes detected - installation is up to date!"
        exit 0
    fi
    
    # Count changes
    local total_changes
    total_changes=$(echo "$changes" | wc -l | tr -d ' ')
    
    log_info "Found ${total_changes} change(s)"
    log_info ""
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info ""
    
    # Track statistics
    local updated_count=0
    local skipped_count=0
    local files_updated=()
    local files_skipped=()
    
    # Process each change
    while IFS=: read -r change_type filename is_new; do
        local is_new_file=false
        if [[ "$is_new" == "new" ]]; then
            is_new_file=true
        fi
        
        if prompt_update_file "$change_type" "$filename" "$is_new_file"; then
            # Update the file
            case "$change_type" in
                command)
                    local source_file="${SCRIPT_DIR}/.cursor/commands/${filename}"
                    local target_file="${target_dir}/.cursor/commands/${filename}"
                    mkdir -p "${target_dir}/.cursor/commands"
                    if preserve_file_permissions "$source_file" "$target_file"; then
                        log_success "  ✅ Updated"
                        ((updated_count++))
                        files_updated+=("$filename")
                    else
                        log_error "  ❌ Failed to update"
                    fi
                    ;;
                global_rule)
                    local source_file="${SCRIPT_DIR}/GLOBAL_RULE.md"
                    local target_file="${target_dir}/GLOBAL_RULE.md"
                    if preserve_file_permissions "$source_file" "$target_file"; then
                        log_success "  ✅ Updated"
                        ((updated_count++))
                        files_updated+=("GLOBAL_RULE.md")
                    else
                        log_error "  ❌ Failed to update"
                    fi
                    ;;
                skill)
                    local source_file="${SCRIPT_DIR}/.claude/skills/${filename}"
                    local target_file="${target_dir}/.claude/skills/${filename}"
                    local target_dir_path
                    target_dir_path=$(dirname "$target_file")
                    mkdir -p "$target_dir_path"
                    if preserve_file_permissions "$source_file" "$target_file"; then
                        log_success "  ✅ Updated"
                        ((updated_count++))
                        files_updated+=("skills/${filename}")
                    else
                        log_error "  ❌ Failed to update"
                    fi
                    ;;
            esac
        else
            log_info "  ⏭️  Skipped"
            ((skipped_count++))
            files_skipped+=("$filename")
        fi
        
        log_info ""
    done <<< "$changes"
    
    # Show summary
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Update Summary:"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_success "✅ Updated: ${updated_count} file(s)"
    log_info "⏭️  Skipped: ${skipped_count} file(s)"
    log_info ""
    
    if [[ ${#files_updated[@]} -gt 0 ]]; then
        log_info "Updated files:"
        for file in "${files_updated[@]}"; do
            log_info "  - $file"
        done
        log_info ""
    fi
    
    if [[ ${#files_skipped[@]} -gt 0 ]]; then
        log_info "Skipped files:"
        for file in "${files_skipped[@]}"; do
            log_info "  - $file"
        done
        log_info ""
    fi
    
    log_success "════════════════════════════════════════════"
    log_success "  🎉 Update completed!"
    log_success "════════════════════════════════════════════"
    log_info ""
    
    if [[ $updated_count -gt 0 ]]; then
        log_info "📌 Next Steps:"
        log_info "  1. Restart Cursor IDE to load updated files"
        log_info ""
    fi
}

# ============================================================================
# UNINSTALL MODE (Phase 6)
# ============================================================================

# Main uninstall mode handler
uninstall_mode() {
    local target_dir="${TARGET_DIR}"
    
    log_info ""
    log_info "════════════════════════════════════════════"
    log_info "  🗑️  cursor-pro-max Uninstall"
    log_info "════════════════════════════════════════════"
    log_info ""
    
    # Detect what was installed
    local has_cursor=false
    local has_global_rule=false
    
    if detect_cursor_dir "$target_dir"; then
        has_cursor=true
    fi
    
    if detect_global_rule "$target_dir"; then
        has_global_rule=true
    fi
    
    # Check for .claude/skills directory
    local has_claude=false
    if [[ -d "${target_dir}/.claude/skills" ]]; then
        has_claude=true
    fi
    
    # Check if anything is installed
    if ! $has_cursor && ! $has_global_rule && ! $has_claude; then
        log_info "No cursor-pro-max installation found in ${target_dir}"
        log_info "Nothing to uninstall."
        exit 0
    fi
    
    # Show what will be removed
    log_info "Detected installation:"
    if $has_cursor; then
        log_info "  ✓ .cursor/ directory"
        
        # Count what's inside
        local cmd_count=0
        local skills_count=0
        
        if [[ -d "${target_dir}/.cursor/commands" ]]; then
            cmd_count=$(find "${target_dir}/.cursor/commands" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $cmd_count -gt 0 ]]; then
                log_info "    - Commands: $cmd_count file(s)"
            fi
        fi
        
        if [[ -d "${target_dir}/.claude/skills" ]]; then
            skills_count=$(find "${target_dir}/.claude/skills" -maxdepth 1 -type d ! -path "${target_dir}/.claude/skills" 2>/dev/null | wc -l | tr -d ' ')
            if [[ $skills_count -gt 0 ]]; then
                log_info "    - Skills: $skills_count directory(s)"
            fi
        fi
    fi
    
    if $has_global_rule; then
        log_info "  ✓ GLOBAL_RULE.md"
        local line_count
        line_count=$(wc -l < "${target_dir}/GLOBAL_RULE.md" 2>/dev/null | tr -d ' ')
        log_info "    - Size: $line_count lines"
    fi
    
    log_info ""
    
    # Prompt for confirmation
    if ! prompt_uninstall_confirmation "$target_dir"; then
        log_info ""
        log_info "Uninstall cancelled by user."
        exit 0
    fi
    
    log_info ""
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Removing installation..."
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info ""
    
    local removed_items=()
    local failed_items=()
    
    # Remove .cursor/ directory
    if $has_cursor; then
        log_info "🗑️  Removing .cursor/ directory..."
        if rm -rf "${target_dir}/.cursor" 2>/dev/null; then
            log_success "✅ Removed .cursor/ directory"
            removed_items+=(".cursor/ directory")
        else
            log_error "❌ Failed to remove .cursor/ directory"
            failed_items+=(".cursor/ directory")
        fi
    fi
    
    # Remove .claude/ directory
    if $has_claude; then
        log_info "🗑️  Removing .claude/ directory..."
        if rm -rf "${target_dir}/.claude" 2>/dev/null; then
            log_success "✅ Removed .claude/ directory"
            removed_items+=(".claude/ directory")
        else
            log_error "❌ Failed to remove .claude/ directory"
            failed_items+=(".claude/ directory")
        fi
    fi
    
    # Remove GLOBAL_RULE.md
    if $has_global_rule; then
        log_info "🗑️  Removing GLOBAL_RULE.md..."
        if rm -f "${target_dir}/GLOBAL_RULE.md" 2>/dev/null; then
            log_success "✅ Removed GLOBAL_RULE.md"
            removed_items+=("GLOBAL_RULE.md")
        else
            log_error "❌ Failed to remove GLOBAL_RULE.md"
            failed_items+=("GLOBAL_RULE.md")
        fi
    fi
    
    log_info ""
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Uninstall Summary:"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Show summary of what was removed
    if [[ ${#removed_items[@]} -gt 0 ]]; then
        log_success "Successfully removed:"
        for item in "${removed_items[@]}"; do
            log_success "  ✓ $item"
        done
    fi
    
    if [[ ${#failed_items[@]} -gt 0 ]]; then
        log_error ""
        log_error "Failed to remove:"
        for item in "${failed_items[@]}"; do
            log_error "  ✗ $item"
        done
        log_error ""
        log_error "Please check file permissions and try again."
        exit 1
    fi
    
    log_info ""
    log_success "════════════════════════════════════════════"
    log_success "  🎉 Uninstall completed successfully!"
    log_success "════════════════════════════════════════════"
    log_info ""
}

# ============================================================================
# POST-INSTALL VALIDATION (Phase 7)
# ============================================================================

# Post-install validation wrapper with comprehensive checks
post_install_validation() {
    local target_dir="${1:-$TARGET_DIR}"
    
    log_info ""
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "Validating installation..."
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    local validation_passed=true
    local warnings=()
    
    # Count installed commands (expect 6)
    if [[ -d "${target_dir}/.cursor/commands" ]]; then
        local cmd_count
        cmd_count=$(find "${target_dir}/.cursor/commands" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        
        log_info "Commands: $cmd_count file(s) found"
        
        if [[ $cmd_count -eq 6 ]]; then
            log_success "  ✓ Expected number of commands (6)"
        elif [[ $cmd_count -gt 0 ]]; then
            log_warning "  ⚠ Expected 6 commands, found $cmd_count"
            warnings+=("Command count mismatch (expected 6, found $cmd_count)")
        else
            log_error "  ✗ No commands found"
            validation_passed=false
        fi
    else
        log_error "Commands directory not found"
        validation_passed=false
    fi
    
    # Verify grammar-learning skill directory structure
    log_info "Skills: Checking structure..."
    
    if [[ -d "${target_dir}/.claude/skills/grammar-learning" ]]; then
        log_success "  ✓ grammar-learning skill directory exists"
        
        # Check for SKILL.md
        if [[ -f "${target_dir}/.claude/skills/grammar-learning/SKILL.md" ]]; then
            log_success "  ✓ SKILL.md exists"
        else
            log_error "  ✗ SKILL.md not found"
            validation_passed=false
        fi
        
        # Check for references directory (optional but expected)
        if [[ -d "${target_dir}/.claude/skills/grammar-learning/references" ]]; then
            log_success "  ✓ references/ directory exists"
        else
            log_warning "  ⚠ references/ directory not found (optional)"
            warnings+=("grammar-learning/references/ directory missing")
        fi
        
        # Check for examples directory (optional but expected)
        if [[ -d "${target_dir}/.claude/skills/grammar-learning/examples" ]]; then
            log_success "  ✓ examples/ directory exists"
        else
            log_warning "  ⚠ examples/ directory not found (optional)"
            warnings+=("grammar-learning/examples/ directory missing")
        fi
    else
        log_error "  ✗ grammar-learning skill not found"
        validation_passed=false
    fi
    
    # Check GLOBAL_RULE.md file size (~5,600 lines expected)
    if [[ -f "${target_dir}/GLOBAL_RULE.md" ]]; then
        local line_count
        line_count=$(wc -l < "${target_dir}/GLOBAL_RULE.md" 2>/dev/null | tr -d ' ')
        
        log_info "GLOBAL_RULE.md: $line_count lines"
        
        # Expected range: 1000-10000 lines (with 5600 as target)
        if [[ $line_count -ge 5000 && $line_count -le 6500 ]]; then
            log_success "  ✓ Size looks correct (~5,600 lines expected)"
        elif [[ $line_count -ge 1000 && $line_count -lt 5000 ]]; then
            log_warning "  ⚠ File seems smaller than expected (expected ~5,600 lines)"
            warnings+=("GLOBAL_RULE.md is smaller than expected ($line_count lines)")
        elif [[ $line_count -gt 6500 ]]; then
            log_warning "  ⚠ File seems larger than expected (expected ~5,600 lines)"
            warnings+=("GLOBAL_RULE.md is larger than expected ($line_count lines)")
        else
            log_error "  ✗ File appears incomplete ($line_count lines)"
            validation_passed=false
        fi
    else
        log_error "GLOBAL_RULE.md not found"
        validation_passed=false
    fi
    
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Show warnings if any
    if [[ ${#warnings[@]} -gt 0 ]]; then
        log_warning ""
        log_warning "Validation warnings:"
        for warning in "${warnings[@]}"; do
            log_warning "  ⚠ $warning"
        done
    fi
    
    if $validation_passed; then
        log_success "✅ Validation passed"
        return 0
    else
        log_error "❌ Validation failed"
        return 1
    fi
}

# Show installed components summary
show_installed_summary() {
    local target_dir="${1:-$TARGET_DIR}"
    
    log_info ""
    log_info "📦 Installed Components:"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Commands
    if [[ -d "${target_dir}/.cursor/commands" ]]; then
        local cmd_count
        cmd_count=$(find "${target_dir}/.cursor/commands" -maxdepth 1 -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        log_info "Commands: $cmd_count file(s)"
        
        # List command files
        find "${target_dir}/.cursor/commands" -maxdepth 1 -type f -name "*.md" -exec basename {} \; 2>/dev/null | sort | while read -r file; do
            log_info "  • $file"
        done
    fi
    
    # Skills
    if [[ -d "${target_dir}/.claude/skills" ]]; then
        log_info "Skills:"
        find "${target_dir}/.claude/skills" -maxdepth 1 -type d ! -path "${target_dir}/.claude/skills" -exec basename {} \; 2>/dev/null | sort | while read -r dir; do
            log_info "  • $dir/"
        done
    fi
    
    # GLOBAL_RULE.md
    if [[ -f "${target_dir}/GLOBAL_RULE.md" ]]; then
        local line_count
        line_count=$(wc -l < "${target_dir}/GLOBAL_RULE.md" 2>/dev/null | tr -d ' ')
        log_info "GLOBAL_RULE.md: $line_count lines"
    fi
    
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Display next steps with Cursor restart reminder
show_next_steps() {
    log_info ""
    log_info "📌 Next Steps:"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    log_info "1. ${BOLD}Restart Cursor IDE${RESET} to load new commands and rules"
    log_info "   (This is REQUIRED for changes to take effect)"
    log_info ""
    log_info "2. Try slash commands:"
    log_info "   • /interview      - Interview-style requirements gathering"
    log_info "   • /phase-plan     - Organize work into phases"
    log_info "   • /check-grammar  - Grammar checking with Vietnamese explanations"
    log_info "   • /council        - Multi-agent coordination"
    log_info "   • /create-rule    - Create new Cursor rules"
    log_info "   • /create-command - Create new Cursor commands"
    log_info ""
    log_info "3. Explore installed files:"
    log_info "   • .cursor/commands/       - All slash commands"
    log_info "   • .claude/skills/         - AI skills"
    log_info "   • GLOBAL_RULE.md          - System prompt and guidelines"
    log_info "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# ============================================================================
# ERROR HANDLING (Phase 8)
# ============================================================================

# Enhanced error handler with meaningful messages
handle_error() {
    local exit_code=$?
    local line_number=${1:-"unknown"}
    
    log_error ""
    log_error "════════════════════════════════════════════"
    log_error "  ❌ Script Error"
    log_error "════════════════════════════════════════════"
    log_error "An error occurred at line: $line_number"
    log_error "Exit code: $exit_code"
    log_error ""
    
    # Provide context-specific error messages
    case $exit_code in
        1)
            log_error "General error occurred."
            log_error "Check the error messages above for details."
            ;;
        2)
            log_error "Invalid arguments provided."
            log_error "Run '${SCRIPT_NAME} --help' for usage information."
            ;;
        3)
            log_error "Missing prerequisites."
            log_error "Install required tools and try again."
            ;;
        126)
            log_error "Permission denied."
            log_error "Possible fixes:"
            log_error "  1. Run: chmod +x ${SCRIPT_NAME}"
            log_error "  2. Check file permissions in target directory"
            log_error "  3. Make sure you have write permissions"
            ;;
        127)
            log_error "Command not found."
            log_error "Required tools are missing from your system."
            ;;
        130)
            log_error "Script interrupted by user (Ctrl+C)."
            ;;
        *)
            log_error "Unexpected error occurred."
            ;;
    esac
    
    log_error ""
    log_error "For help, run: ${SCRIPT_NAME} --help"
    log_error "════════════════════════════════════════════"
    
    exit "$exit_code"
}

# Handle permission denied errors with helpful suggestions
handle_permission_error() {
    local file_path="$1"
    
    log_error "Permission denied: $file_path"
    log_error ""
    log_error "Possible solutions:"
    log_error "  1. Check file ownership:"
    log_error "     ls -la \"$file_path\""
    log_error ""
    log_error "  2. Change ownership (if you own the directory):"
    log_error "     sudo chown -R \$USER \"$file_path\""
    log_error ""
    log_error "  3. Grant write permissions:"
    log_error "     chmod u+w \"$file_path\""
    log_error ""
    log_error "  4. Run script with appropriate permissions"
    log_error ""
}

# Handle disk full errors gracefully
handle_disk_full_error() {
    log_error "Disk full - cannot complete installation"
    log_error ""
    log_error "Solutions:"
    log_error "  1. Free up disk space:"
    log_error "     df -h  # Check disk usage"
    log_error ""
    log_error "  2. Clean up temporary files:"
    log_error "     rm -rf ~/Library/Caches/*"
    log_error "     rm -rf ~/.Trash/*"
    log_error ""
    log_error "  3. Move files to external drive"
    log_error ""
    log_error "  4. Try installation in different directory with more space"
    log_error ""
}

# Validate source directory structure before proceeding
validate_source_structure() {
    local errors=()
    
    # Check source directory exists
    if [[ ! -d "$SCRIPT_DIR" ]]; then
        errors+=("Source directory does not exist: $SCRIPT_DIR")
    fi
    
    # Check .cursor directory structure
    if [[ ! -d "${SCRIPT_DIR}/.cursor" ]]; then
        errors+=("Missing .cursor/ directory in source")
    else
        # Check commands subdirectory
        if [[ ! -d "${SCRIPT_DIR}/.cursor/commands" ]]; then
            errors+=("Missing .cursor/commands/ directory")
        fi
    fi
    
    # Check .claude directory structure
    if [[ ! -d "${SCRIPT_DIR}/.claude" ]]; then
        errors+=("Missing .claude/ directory in source")
    else
        # Check skills subdirectory
        if [[ ! -d "${SCRIPT_DIR}/.claude/skills" ]]; then
            errors+=("Missing .claude/skills/ directory")
        fi
    fi
    
    # Check GLOBAL_RULE.md
    if [[ ! -f "${SCRIPT_DIR}/GLOBAL_RULE.md" ]]; then
        errors+=("Missing GLOBAL_RULE.md in source")
    fi
    
    # Report errors
    if [[ ${#errors[@]} -gt 0 ]]; then
        log_error "Source directory structure validation failed:"
        for error in "${errors[@]}"; do
            log_error "  • $error"
        done
        log_error ""
        log_error "Make sure you're running this script from the cursor-pro-max directory."
        log_error "Expected structure:"
        log_error "  cursor-pro-max/"
        log_error "  ├── install.sh"
        log_error "  ├── .cursor/"
        log_error "  │   └── commands/"
        log_error "  ├── .claude/"
        log_error "  │   └── skills/"
        log_error "  └── GLOBAL_RULE.md"
        return 1
    fi
    
    return 0
}

# Set up comprehensive error traps
setup_error_handlers() {
    # Trap ERR for any command failures
    trap 'handle_error ${LINENO}' ERR
    
    # Trap EXIT for cleanup (only on error)
    # trap 'cleanup_on_error' EXIT
    
    # Trap SIGINT (Ctrl+C) and SIGTERM for graceful shutdown
    trap 'log_error ""; log_error "Installation interrupted by user"; exit 130' SIGINT SIGTERM
}

# ============================================================================
# MAIN ENTRY POINT
# ============================================================================

main() {
    # Initialize colors first
    init_colors
    
    # Set up error handlers (Phase 8)
    setup_error_handlers
    
    # Parse arguments
    parse_args "$@"

    # Validate and normalize target directory
    if ! validate_target_dir "$TARGET_DIR"; then
        exit 2
    fi
    
    # Validate source directory structure before doing anything (Phase 8)
    if ! validate_source_structure; then
        exit 1
    fi
    
    # Check prerequisites
    check_prerequisites
    
    # Display mode and target
    log_info "Mode: ${MODE}"
    log_info "Target directory: ${TARGET_DIR}"
    log_info "Source directory: ${SCRIPT_DIR}"
    
    # Execute mode handler
    case "$MODE" in
        install)
            install_mode
            ;;
        update)
            update_mode
            ;;
        uninstall)
            uninstall_mode
            ;;
        *)
            log_error "Invalid mode: $MODE"
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
