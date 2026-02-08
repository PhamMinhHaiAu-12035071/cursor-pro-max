#!/usr/bin/env bash

# quality-check.sh
# Quality validation script for Lyra v2 Prompt Optimizer Skill
# Checks: YAML validity, file sizes, markdown linting, internal links

set -e

# Default PROJECT_ROOT to current directory if not set
PROJECT_ROOT="${PROJECT_ROOT:-.}"
export PROJECT_ROOT

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Counters
ERRORS=0
WARNINGS=0
CHECKS=0

# Script directory and project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "==================================="
echo "Lyra v2 Quality Check"
echo "==================================="
echo ""

# Function to print colored output
print_error() {
    echo -e "${RED}✗ ERROR:${NC} $1"
    ((ERRORS++))
}

print_warning() {
    echo -e "${YELLOW}⚠ WARNING:${NC} $1"
    ((WARNINGS++))
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo "ℹ $1"
}

# Check 1: YAML Frontmatter Validation
echo "1. Checking YAML frontmatter..."
((CHECKS++))

if command -v python3 &> /dev/null; then
    python3 << 'EOF'
import yaml
import sys
import os

skill_file = os.path.join(os.environ['PROJECT_ROOT'], 'SKILL.md')

try:
    with open(skill_file, 'r') as f:
        content = f.read()
        
    # Extract YAML frontmatter
    if content.startswith('---'):
        parts = content.split('---', 2)
        if len(parts) >= 3:
            yaml_content = parts[1]
            data = yaml.safe_load(yaml_content)
            
            # Check required fields
            required = ['name', 'description', 'author', 'version', 'date', 'allowed-tools']
            missing = [field for field in required if field not in data]
            
            if missing:
                print(f"ERROR: Missing required YAML fields: {', '.join(missing)}", file=sys.stderr)
                sys.exit(1)
            
            # Validate name
            if data['name'] != 'lyra-prompt-optimizer':
                print(f"ERROR: Skill name mismatch: {data['name']}", file=sys.stderr)
                sys.exit(1)
                
            # Validate version format
            version = data['version']
            if not all(part.isdigit() for part in version.split('.')):
                print(f"ERROR: Invalid version format: {version}", file=sys.stderr)
                sys.exit(1)
            
            print("YAML frontmatter valid")
            sys.exit(0)
        else:
            print("ERROR: YAML frontmatter not properly delimited", file=sys.stderr)
            sys.exit(1)
    else:
        print("ERROR: SKILL.md missing YAML frontmatter", file=sys.stderr)
        sys.exit(1)
        
except FileNotFoundError:
    print(f"ERROR: SKILL.md not found at {skill_file}", file=sys.stderr)
    sys.exit(1)
except yaml.YAMLError as e:
    print(f"ERROR: Invalid YAML syntax: {e}", file=sys.stderr)
    sys.exit(1)
except Exception as e:
    print(f"ERROR: {e}", file=sys.stderr)
    sys.exit(1)
EOF

    if [ $? -eq 0 ]; then
        print_success "YAML frontmatter is valid"
    else
        print_error "YAML frontmatter validation failed"
    fi
else
    print_warning "Python3 not found, skipping YAML validation"
fi

echo ""

# Check 2: File Size Validation
echo "2. Checking file sizes..."
((CHECKS++))

SIZE_ERRORS=0

check_file_size() {
    local file=$1
    local max_lines=$2
    local tolerance=20  # Allow 20% over target
    
    if [ -f "$file" ]; then
        lines=$(wc -l < "$file" | xargs)
        max_with_tolerance=$((max_lines + max_lines * tolerance / 100))
        
        if [ "$lines" -gt "$max_with_tolerance" ]; then
            print_warning "$(basename "$file"): $lines lines (target ~$max_lines, max $max_with_tolerance)"
            ((SIZE_ERRORS++))
        fi
    fi
}

# Check main files
check_file_size "$PROJECT_ROOT/SKILL.md" 400
check_file_size "$PROJECT_ROOT/references/reasoning-frameworks.md" 500
check_file_size "$PROJECT_ROOT/references/optimization-toolkit.md" 600
check_file_size "$PROJECT_ROOT/references/core-concepts.md" 400
check_file_size "$PROJECT_ROOT/references/vietnamese-guide.md" 300
check_file_size "$PROJECT_ROOT/references/anti-patterns.md" 400

if [ $SIZE_ERRORS -eq 0 ]; then
    print_success "All file sizes within acceptable range"
else
    print_warning "$SIZE_ERRORS files exceed target size (within tolerance)"
fi

echo ""

# Check 3: Required Files Exist
echo "3. Checking required files exist..."
((CHECKS++))

REQUIRED_FILES=(
    "SKILL.md"
    "references/reasoning-frameworks.md"
    "references/optimization-toolkit.md"
    "references/core-concepts.md"
    "references/vietnamese-guide.md"
    "references/anti-patterns.md"
    "examples/quick-boost/basic-clarity.md"
    "examples/quick-boost/output-format.md"
    "examples/quick-boost/role-assignment.md"
    "examples/deep-dive/chain-of-thought.md"
    "examples/deep-dive/few-shot-learning.md"
    "examples/deep-dive/constraint-optimization.md"
    "examples/deep-dive/multi-perspective.md"
    "examples/revolutionary/graph-of-thoughts.md"
    "examples/revolutionary/multi-framework.md"
    "examples/revolutionary/platform-specific.md"
    "examples/vietnamese/basic-vietnamese.md"
    "examples/vietnamese/advanced-vietnamese.md"
)

MISSING_FILES=0

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$PROJECT_ROOT/$file" ]; then
        print_error "Missing required file: $file"
        ((MISSING_FILES++))
    fi
done

if [ $MISSING_FILES -eq 0 ]; then
    print_success "All required files exist (${#REQUIRED_FILES[@]} files)"
else
    print_error "$MISSING_FILES required files missing"
fi

echo ""

# Check 4: Internal Link Validation
echo "4. Checking internal markdown links..."
((CHECKS++))

BROKEN_LINKS=0

# Find all markdown files and check internal links
while IFS= read -r -d '' file; do
    # Extract markdown links: [text](path)
    grep -oE '\[([^]]+)\]\(([^)]+)\)' "$file" 2>/dev/null | while read -r link; do
        # Extract the URL part
        url=$(echo "$link" | sed -E 's/\[([^]]+)\]\(([^)]+)\)/\2/')
        
        # Skip external URLs (http/https)
        if [[ "$url" =~ ^https?:// ]]; then
            continue
        fi
        
        # Skip anchors (#section)
        if [[ "$url" =~ ^# ]]; then
            continue
        fi
        
        # Resolve relative path
        file_dir=$(dirname "$file")
        target_path="$file_dir/$url"
        
        # Remove anchor from path if present
        target_path="${target_path%#*}"
        
        # Check if target exists
        if [ ! -f "$target_path" ] && [ ! -d "$target_path" ]; then
            print_warning "Broken link in $(basename "$file"): $url"
            ((BROKEN_LINKS++))
        fi
    done
done < <(find "$PROJECT_ROOT" -name "*.md" -type f -print0)

if [ $BROKEN_LINKS -eq 0 ]; then
    print_success "No broken internal links found"
else
    print_warning "$BROKEN_LINKS potential broken links found"
fi

echo ""

# Check 5: Markdown Formatting
echo "5. Checking markdown formatting..."
((CHECKS++))

FORMAT_ISSUES=0

# Check for common formatting issues
while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    
    # Check for trailing whitespace
    if grep -q '[[:space:]]$' "$file" 2>/dev/null; then
        ((FORMAT_ISSUES++))
    fi
    
    # Check for multiple blank lines (>2)
    if grep -Pzo '\n\n\n\n' "$file" &>/dev/null; then
        ((FORMAT_ISSUES++))
    fi
    
done < <(find "$PROJECT_ROOT" -name "*.md" -type f -print0)

if [ $FORMAT_ISSUES -eq 0 ]; then
    print_success "No major formatting issues found"
else
    print_warning "$FORMAT_ISSUES formatting issues detected (minor)"
fi

echo ""

# Check 6: Code Block Validation
echo "6. Checking code blocks..."
((CHECKS++))

UNCLOSED_BLOCKS=0

while IFS= read -r -d '' file; do
    # Count opening and closing code fences
    opening=$(grep -c '^```' "$file" 2>/dev/null || echo 0)
    
    # Code fences should come in pairs
    if [ $((opening % 2)) -ne 0 ]; then
        print_error "Unclosed code block in $(basename "$file")"
        ((UNCLOSED_BLOCKS++))
    fi
done < <(find "$PROJECT_ROOT" -name "*.md" -type f -print0)

if [ $UNCLOSED_BLOCKS -eq 0 ]; then
    print_success "All code blocks properly closed"
else
    print_error "$UNCLOSED_BLOCKS files with unclosed code blocks"
fi

echo ""

# Summary
echo "==================================="
echo "Quality Check Summary"
echo "==================================="
echo ""
echo "Total Checks: $CHECKS"
print_success "Passed checks: $((CHECKS - ERRORS))"

if [ $WARNINGS -gt 0 ]; then
    print_warning "Warnings: $WARNINGS"
fi

if [ $ERRORS -gt 0 ]; then
    print_error "Errors: $ERRORS"
fi

echo ""

# Exit with appropriate code
if [ $ERRORS -gt 0 ]; then
    echo -e "${RED}❌ Quality check FAILED${NC}"
    exit 1
elif [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}⚠️  Quality check PASSED with warnings${NC}"
    exit 0
else
    echo -e "${GREEN}✅ Quality check PASSED${NC}"
    exit 0
fi
