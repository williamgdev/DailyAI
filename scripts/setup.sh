#!/bin/bash
# Setup script - Creates personal folder structure for new users

set -e

REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PERSONAL_DIR="${REPO_DIR}/personal"

echo "🚀 Setting up Team Productivity System"
echo ""

# Check if personal folder already exists
if [ -d "$PERSONAL_DIR" ]; then
    echo "⚠️  personal/ folder already exists"
    read -p "Do you want to reset it? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Setup cancelled."
        exit 0
    fi
    rm -rf "$PERSONAL_DIR"
fi

# Create folder structure
echo "📁 Creating personal folder structure..."
mkdir -p "$PERSONAL_DIR/ThingsToDo"
mkdir -p "$PERSONAL_DIR/ThingsToLearn"
mkdir -p "$PERSONAL_DIR/Daily/$(date +%Y)"

# Copy personal-only catalog template (no team/example projects)
echo "📋 Creating personal project catalog..."
PERSONAL_CATALOG_TEMPLATE="$REPO_DIR/skills/obsidian-workflow/references/PERSONAL_CATALOG_TEMPLATE.md"
if [ -f "$PERSONAL_CATALOG_TEMPLATE" ]; then
  cp "$PERSONAL_CATALOG_TEMPLATE" "$PERSONAL_DIR/catalog-project.md"
else
  cp "$REPO_DIR/skills/obsidian-workflow/references/PROJECT_CATALOG.md" "$PERSONAL_DIR/catalog-project.md"
fi

# Create empty tasks files for default projects
cat > "$PERSONAL_DIR/ThingsToDo/tasks.md" << 'EOF'
# Tasks — Things To Do

Your personal task inbox.

## Active Tasks
- [ ] Example task

## Completed Tasks

(Completed tasks will be filed here)
EOF

cat > "$PERSONAL_DIR/ThingsToLearn/tasks.md" << 'EOF'
# Tasks — Things To Learn

Learning topics and resources.

## Active Learning
- [ ] Example learning item

## Completed
(Completed learning items will be filed here)
EOF

echo ""
echo "✅ Personal workspace ready!"
echo ""
echo "📂 Structure created:"
echo "  personal/"
echo "  ├── catalog-project.md"
echo "  ├── ThingsToDo/"
echo "  ├── ThingsToLearn/"
echo "  └── Daily/$(date +%Y)/"
echo ""

# Interactive skill and client linking: choose which skills and which clients
echo "🔗 Linking skills to clients (Cursor, Claude, Codex, VS Code)..."
SKILL_CLIENTS_SCRIPT="$REPO_DIR/scripts/setup-skill-clients.sh"
if [ -x "$SKILL_CLIENTS_SCRIPT" ]; then
  AVAILABLE_SKILLS=()
  for dir in "$REPO_DIR/skills"/*/; do
    [ -d "$dir" ] || continue
    name=$(basename "$dir")
    [ -f "${dir}SKILL.md" ] || continue
    AVAILABLE_SKILLS+=("$name")
  done
  CLIENT_NAMES=(cursor claude codex vscode)
  CLIENT_LABELS=("Cursor" "Claude" "Codex" "VS Code")
  if [ ${#AVAILABLE_SKILLS[@]} -eq 0 ]; then
    echo "  No skills found under skills/ (expected skills/<name>/SKILL.md)."
  else
    # 1) Choose skills (multiple)
    echo "  Available skills:"
    for i in "${!AVAILABLE_SKILLS[@]}"; do echo "    $((i+1))) ${AVAILABLE_SKILLS[$i]}"; done
    read -p "  Which skills to install? (space-separated numbers, e.g. 1 3, or 'all'): " SKILL_CHOICE
    if [ -z "$SKILL_CHOICE" ] || [ "$SKILL_CHOICE" = "all" ]; then
      SELECTED_SKILLS=("${AVAILABLE_SKILLS[@]}")
    else
      SELECTED_SKILLS=()
      for num in $SKILL_CHOICE; do
        if [ "$num" -ge 1 ] 2>/dev/null && [ "$num" -le ${#AVAILABLE_SKILLS[@]} ]; then
          SELECTED_SKILLS+=("${AVAILABLE_SKILLS[$((num-1))]}")
        fi
      done
    fi

    # 2) Choose clients (multiple)
    echo "  Which clients to link to?"
    for i in "${!CLIENT_LABELS[@]}"; do echo "    $((i+1))) ${CLIENT_LABELS[$i]}"; done
    read -p "  Your choice (space-separated numbers, e.g. 1 4, or 'all'): " CLIENT_CHOICE
    if [ -z "$CLIENT_CHOICE" ] || [ "$CLIENT_CHOICE" = "all" ]; then
      SELECTED_CLIENTS=""
    else
      SELECTED_CLIENTS=""
      for num in $CLIENT_CHOICE; do
        if [ "$num" -ge 1 ] 2>/dev/null && [ "$num" -le ${#CLIENT_NAMES[@]} ]; then
          [ -n "$SELECTED_CLIENTS" ] && SELECTED_CLIENTS="${SELECTED_CLIENTS},"
          SELECTED_CLIENTS="${SELECTED_CLIENTS}${CLIENT_NAMES[$((num-1))]}"
        fi
      done
    fi

    if [ ${#SELECTED_SKILLS[@]} -eq 0 ]; then
      echo "  No valid skill selection; skipping skill link."
    else
      if [ -n "$SELECTED_CLIENTS" ]; then
        "$SKILL_CLIENTS_SCRIPT" --clients "$SELECTED_CLIENTS" "${SELECTED_SKILLS[@]}" || true
      else
        "$SKILL_CLIENTS_SCRIPT" "${SELECTED_SKILLS[@]}" || true
      fi
    fi
  fi
else
  echo "  (Skip: scripts/setup-skill-clients.sh not found or not executable)"
fi
echo ""

echo "🎯 Next steps:"
echo "  1. (Optional) Open this folder in Obsidian: File → Open folder → personal/"
echo "  2. Run your AI CLI (e.g. Claude Code, OpenAI CLI, Gemini CLI) or use Cursor in this repo — try \"start my day\""
echo "  (For repo paths or GitHub, see docs/ONBOARDING.md. PR Reviews use 'gh'; run 'gh auth login' once if needed.)"
echo ""

# Hint if gh is missing (common for PR Reviews)
if ! command -v gh >/dev/null 2>&1; then
    echo "💡 GitHub CLI (gh) not found. Optional for some workflows; see docs/REQUIREMENTS.md."
    echo ""
fi
