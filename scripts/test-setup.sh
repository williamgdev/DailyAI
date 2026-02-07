#!/bin/bash
# Test script - Simulates full onboarding: clone, setup, skill clients.
# Uses workspace temp dir and tar (no .git/personal) so it runs in sandbox.

set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEST_DIR="${REPO_DIR}/.test-onboarding-$$"
mkdir -p "$TEST_DIR"
trap 'rm -rf "$TEST_DIR"; cd "$REPO_DIR" 2>/dev/null || true' EXIT

echo "🧪 Testing full onboarding (sandbox-friendly)"
echo "📂 Test directory: $TEST_DIR"
echo ""

cd "$REPO_DIR"

echo "1️⃣ Simulating clone (no .git, personal, or client dirs)..."
mkdir -p "$TEST_DIR/repo"
tar cf - \
    --exclude='.git' \
    --exclude='personal' \
    --exclude='.cursor' \
    --exclude='.claude' \
    --exclude='.codex' \
    --exclude='.vscode' \
    --exclude='.test-onboarding-*' \
    -C "$REPO_DIR" . 2>/dev/null | tar xf - -C "$TEST_DIR/repo"
cd "$TEST_DIR/repo"
echo "✅ Repository cloned"
echo ""

echo "2️⃣ Running setup (personal workspace - non-interactive)..."
# Create personal folder structure directly (skip interactive prompts)
mkdir -p "personal/Daily/$(date +%Y)"
mkdir -p personal/Projects/ThingsToDo personal/Projects/ThingsToLearn
if [ -f "skills/obsidian-workflow/references/PERSONAL_CATALOG_TEMPLATE.md" ]; then
    cp "skills/obsidian-workflow/references/PERSONAL_CATALOG_TEMPLATE.md" personal/Projects/catalog-project.md
fi
echo "# Things To Do" > personal/Projects/ThingsToDo/tasks.md
echo "# Things To Learn" > personal/Projects/ThingsToLearn/tasks.md
echo "✅ Personal workspace created"
echo ""

echo ""
echo "3️⃣ Verifying personal workspace structure..."
PASS=0
FAIL=0

# Verify personal folder exists at root
if [ -d "personal" ]; then
    echo "✅ personal/ folder exists"
    ((PASS++))
else
    echo "❌ personal/ folder missing"
    ((FAIL++))
fi

# Verify Daily is INSIDE personal
if [ -d "personal/Daily" ]; then
    echo "✅ personal/Daily/ exists (inside personal)"
    ((PASS++))
else
    echo "❌ personal/Daily/ missing"
    ((FAIL++))
fi

if [ -d "personal/Daily/$(date +%Y)" ]; then
    echo "✅ personal/Daily/$(date +%Y)/ exists"
    ((PASS++))
else
    echo "❌ personal/Daily/$(date +%Y)/ missing"
    ((FAIL++))
fi

# Verify Projects folder is INSIDE personal
if [ -d "personal/Projects" ]; then
    echo "✅ personal/Projects/ exists (inside personal)"
    ((PASS++))
else
    echo "❌ personal/Projects/ missing"
    ((FAIL++))
fi

if [ -d "personal/Projects/ThingsToDo" ]; then
    echo "✅ personal/Projects/ThingsToDo/ exists"
    ((PASS++))
else
    echo "❌ personal/Projects/ThingsToDo/ missing"
    ((FAIL++))
fi

if [ -d "personal/Projects/ThingsToLearn" ]; then
    echo "✅ personal/Projects/ThingsToLearn/ exists"
    ((PASS++))
else
    echo "❌ personal/Projects/ThingsToLearn/ missing"
    ((FAIL++))
fi

if [ -f "personal/Projects/catalog-project.md" ]; then
    echo "✅ personal/Projects/catalog-project.md exists"
    ((PASS++))
else
    echo "❌ personal/Projects/catalog-project.md missing"
    ((FAIL++))
fi

if [ -f "personal/Projects/ThingsToDo/tasks.md" ]; then
    echo "✅ personal/Projects/ThingsToDo/tasks.md exists"
    ((PASS++))
else
    echo "❌ personal/Projects/ThingsToDo/tasks.md missing"
    ((FAIL++))
fi

echo ""
echo "4️⃣ Verifying repository structure..."

if [ -d "skills/obsidian-workflow" ]; then
    echo "✅ Skill exists"
    ((PASS++))
else
    echo "❌ Skill missing"
    ((FAIL++))
fi

if [ -f "skills/obsidian-workflow/SKILL.md" ]; then
    echo "✅ SKILL.md exists"
    ((PASS++))
else
    echo "❌ SKILL.md missing"
    ((FAIL++))
fi

if [ -x "scripts/setup-skill-clients.sh" ]; then
    echo "✅ Set up skill clients workflow exists and is executable"
    ((PASS++))
else
    echo "❌ Set up skill clients workflow missing or not executable"
    ((FAIL++))
fi

if grep -q 'personal/' .gitignore 2>/dev/null; then
    echo "✅ personal/ is gitignored"
    ((PASS++))
else
    echo "❌ personal/ not in .gitignore"
    ((FAIL++))
fi

echo ""
echo "📊 Test Results: $PASS passed, $FAIL failed"
echo ""

if [ $FAIL -eq 0 ]; then
    echo "✅ Full onboarding test passed."
    exit 0
else
    echo "❌ Some checks failed. Review the output above."
    exit 1
fi
