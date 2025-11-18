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
tar cf - --exclude='.git' --exclude='personal' --exclude='.cursor' --exclude='.claude' --exclude='.codex' -C "$REPO_DIR" . | tar xf - -C "$TEST_DIR/repo"
cd "$TEST_DIR/repo"
echo "✅ Repository cloned"
echo ""

echo "2️⃣ Running setup (personal workspace + link skill clients)..."
./scripts/setup.sh
echo ""

echo "3️⃣ Verifying personal workspace..."
PASS=0
FAIL=0

if [ -d "personal/ThingsToDo" ]; then
    echo "✅ ThingsToDo exists"
    ((PASS++))
else
    echo "❌ ThingsToDo missing"
    ((FAIL++))
fi

if [ -d "personal/ThingsToLearn" ]; then
    echo "✅ ThingsToLearn exists"
    ((PASS++))
else
    echo "❌ ThingsToLearn missing"
    ((FAIL++))
fi

if [ -d "personal/Daily/$(date +%Y)" ]; then
    echo "✅ Daily folder exists"
    ((PASS++))
else
    echo "❌ Daily folder missing"
    ((FAIL++))
fi

if [ -f "personal/catalog-project.md" ]; then
    echo "✅ Catalog exists"
    ((PASS++))
else
    echo "❌ Catalog missing"
    ((FAIL++))
fi

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
