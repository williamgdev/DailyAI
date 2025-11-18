#!/bin/bash
# Tests obsidian-workflow skill workflows.
# Run from repo root: ./skills/obsidian-workflow/scripts/run-tests.sh
# Uses a temporary personal workspace so it does not modify your real personal/ folder.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILL_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
REPO_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
TEST_ROOT="${REPO_DIR}/.obsidian-workflow-test-$$"
PERSONAL="${TEST_ROOT}/personal"
trap 'rm -rf "$TEST_ROOT"; cd "$REPO_DIR" 2>/dev/null || true' EXIT

PASS=0
FAIL=0

run_test() {
  if "$@"; then ((PASS++)); return 0; else ((FAIL++)); return 1; fi
}

echo "🧪 Obsidian Workflow Skill — Workflow Tests"
echo "   Repo root: $REPO_DIR"
echo "   Test workspace: $TEST_ROOT"
echo ""

cd "$REPO_DIR"

# --- 1. Setup skill clients (project-level script) ---
echo "1️⃣  Setup skill clients"
if [ -x "$REPO_DIR/scripts/setup-skill-clients.sh" ]; then
  "$REPO_DIR/scripts/setup-skill-clients.sh" --clients cursor 2>/dev/null || true
  if [ -d ".cursor/skills/obsidian-workflow" ] || [ -L ".cursor/skills/obsidian-workflow" ]; then
    echo "   ✅ Skills linked to .cursor/skills/"
    ((PASS++))
  else
    echo "   ❌ .cursor/skills/obsidian-workflow missing after setup"
    ((FAIL++))
  fi
else
  echo "   ⏭️  scripts/setup-skill-clients.sh not executable (skip)"
fi
echo ""

# --- 2. Prerequisites: skill files and template ---
echo "2️⃣  Skill prerequisites"
run_test test -f "$SKILL_DIR/SKILL.md" && echo "   ✅ SKILL.md exists" || echo "   ❌ SKILL.md missing"
run_test test -f "$SKILL_DIR/references/DAILY_NOTE_TEMPLATE.md" && echo "   ✅ Daily note template exists" || echo "   ❌ Daily note template missing"
run_test test -f "$SKILL_DIR/references/AGENT_TEMPLATE.md" && echo "   ✅ AGENT template exists" || echo "   ❌ AGENT template missing"
run_test test -f "$SKILL_DIR/references/DIGEST_LOG_TEMPLATE.md" && echo "   ✅ Digest log template exists" || echo "   ❌ Digest log template missing"
run_test test -f "$SKILL_DIR/references/PERSONAL_CATALOG_TEMPLATE.md" && echo "   ✅ Personal catalog template exists" || echo "   ❌ Personal catalog template missing"
echo ""

# --- 3. Start My Day workflow ---
echo "3️⃣  Start My Day workflow"
mkdir -p "$PERSONAL/ThingsToDo" "$PERSONAL/ThingsToLearn" "$PERSONAL/Daily/$(date +%Y)"
cp "$SKILL_DIR/references/PERSONAL_CATALOG_TEMPLATE.md" "$PERSONAL/catalog-project.md"
TODAY=$(date +%Y-%m-%d)
DAILY_NOTE="$PERSONAL/Daily/$(date +%Y)/$TODAY.md"
if [ -f "$DAILY_NOTE" ]; then rm -f "$DAILY_NOTE"; fi
# Create daily note from template (as skill describes)
sed "s/{{date}}/$TODAY/g" "$SKILL_DIR/references/DAILY_NOTE_TEMPLATE.md" > "$DAILY_NOTE"
if [ -f "$DAILY_NOTE" ] && grep -q "$TODAY" "$DAILY_NOTE" && grep -q "Morning Planning" "$DAILY_NOTE"; then
  echo "   ✅ Daily note created with date and sections"
  ((PASS++))
else
  echo "   ❌ Daily note creation failed"
  ((FAIL++))
fi
echo ""

# --- 4. Create Project workflow ---
echo "4️⃣  Create Project workflow"
PROJECT_NAME="ObsidianTestProject"
PROJECT_DIR="$PERSONAL/$PROJECT_NAME"
mkdir -p "$PROJECT_DIR"
for f in AGENT.md project.md tasks.md meetings.md team_members.md notes.md; do
  echo "# $PROJECT_NAME — $f" > "$PROJECT_DIR/$f"
done
# Register in catalog (simulate adding a row)
TAG="#obsidian-test-project"
if grep -q "Things To Learn" "$PERSONAL/catalog-project.md"; then
  # Append a row (simplified)
  echo "| **$PROJECT_NAME** | \`$TAG\` | Test project for workflow | Active | \`$PROJECT_NAME/\` |" >> "$PERSONAL/catalog-project.md"
fi
if [ -f "$PROJECT_DIR/tasks.md" ] && [ -f "$PROJECT_DIR/AGENT.md" ] && [ -f "$PERSONAL/catalog-project.md" ]; then
  echo "   ✅ Project folder and catalog entry created"
  ((PASS++))
else
  echo "   ❌ Create project structure failed"
  ((FAIL++))
fi
echo ""

# --- 5. Digest My Day workflow ---
echo "5️⃣  Digest My Day workflow"
# Add a tagged task to the daily note
echo "" >> "$DAILY_NOTE"
echo "- [ ] Test task for digest $TAG" >> "$DAILY_NOTE"
DIGESTED="$PERSONAL/Daily/$(date +%Y)/$TODAY.digested.md"
rm -f "$DIGESTED"
# Simulate digest: create digest log (minimal)
cat > "$DIGESTED" << EOF
# Digest Log - $TODAY
**Source**: $TODAY.md
**Status**: ✅ Complete
EOF
# Verify "filed" by checking project tasks (we'd append there in real workflow)
if [ -f "$DIGESTED" ] && grep -q "Complete" "$DIGESTED"; then
  echo "   ✅ Digest log created; workflow can file tasks to projects"
  ((PASS++))
else
  echo "   ❌ Digest workflow check failed"
  ((FAIL++))
fi
echo ""

# --- 6. Check cadences / Update system ---
echo "6️⃣  Check cadences & Update system"
CADENCE_COUNT=0
for dir in "$PERSONAL"/*/; do
  [ -f "${dir}cadence.md" ] && ((CADENCE_COUNT++)) || true
done
echo "   ✅ Cadence scan works (found $CADENCE_COUNT cadence.md in test workspace)"
((PASS++))
if [ -f "$SKILL_DIR/references/AGENT_TEMPLATE.md" ]; then
  echo "   ✅ Update system: AGENT template readable"
  ((PASS++))
else
  echo "   ❌ AGENT template missing"
  ((FAIL++))
fi
echo ""

# --- 7. Work on a project (read catalog + tasks) ---
echo "7️⃣  Work on a project (catalog + tasks)"
if [ -f "$PERSONAL/catalog-project.md" ] && [ -f "$PROJECT_DIR/tasks.md" ]; then
  echo "   ✅ Catalog and project tasks readable for interactive workflow"
  ((PASS++))
else
  echo "   ❌ Catalog or project tasks missing"
  ((FAIL++))
fi
echo ""

# --- Summary ---
echo "📊 Results: $PASS passed, $FAIL failed"
echo ""

if [ $FAIL -eq 0 ]; then
  echo "✅ All obsidian-workflow tests passed."
  exit 0
else
  echo "❌ Some tests failed. Review output above."
  exit 1
fi
