---
name: create-project
description: Create a new project with folder structure and templates
arguments:
  - "[project-name]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# Create Project Command

Create a new project with full folder structure, templates, and registration in the project catalog.

## Workflow

### 1. Validate Environment
Check that VAULT_PATH is set:

```bash
if [ -z "$VAULT_PATH" ]; then
  echo "❌ ERROR: VAULT_PATH environment variable not set"
  exit 1
fi
```

### 2. Validate Arguments
Ensure project name is provided:

```bash
if [ $# -eq 0 ]; then
    echo "❌ ERROR: Project name required"
    echo "Usage: /create-project ProjectName"
    exit 1
fi

PROJECT_NAME="$1"
```

### 3. Generate Project Tag
Create a normalized lowercase tag from project name:

```bash
# Convert "Mobile App" to "mobile-app"
PROJECT_TAG=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-z0-9-]//g')

if [ -z "$PROJECT_TAG" ]; then
    echo "❌ ERROR: Invalid project name"
    exit 1
fi
```

### 4. Check if Project Already Exists
Verify project folder doesn't already exist:

```bash
PROJECT_FOLDER="$VAULT_PATH/Projects/$PROJECT_NAME"

if [ -d "$PROJECT_FOLDER" ]; then
    echo "❌ Project already exists: $PROJECT_NAME"
    echo "   Location: Projects/$PROJECT_NAME"
    exit 1
fi
```

### 5. Create Project Folder Structure
Create main folder and subdirectories:

```bash
mkdir -p "$PROJECT_FOLDER"
mkdir -p "$PROJECT_FOLDER/discovery"
mkdir -p "$PROJECT_FOLDER/execution"
```

### 6. Create Project Files from Templates

**AGENT.md** - Project-specific AI instructions
- Copy from `templates/PROJECT_AGENT_TEMPLATE.md`
- Replace placeholders:
  - `{{PROJECT_NAME}}` → Project name
  - `{{PROJECT_TAG}}` → Project tag
  - `{{CREATION_DATE}}` → Today's date

**project.md** - Project overview
- Include project name, description fields
- Add status, phase (Discovery/Execution)
- Add team section
- Add milestones/timeline
- Add success criteria

**tasks.md** - Task list (from template)
- Copy `templates/PROJECT_TASKS_TEMPLATE.md`
- Initialize with empty sections:
  - 🚨 Critical Tasks
  - 🔄 In Progress
  - ⏭️ Up Next
  - 🗂️ Backlog

**meetings.md** - Meeting log
- Create with header: "# Meeting Notes - $PROJECT_NAME"
- Initialize with template structure
- Add sections for attendees, action items

**team_members.md** - Team tracking
- Create table with columns: Name, Role, Interactions, Last Updated
- Add header comment with usage

**notes.md** - Research and learnings
- Create with sections:
  - 📚 Research Notes
  - 💡 Decisions
  - ⚠️ Blockers & Risks

### 7. Register Project in Catalog
Update `System/catalog-project.md`:

1. Read existing catalog
2. Add new project entry:

```markdown
| Project Name | Tag | Status | Phase | Created |
|------|-----|--------|-------|---------|
| Mobile App | #mobile-app | Active | Discovery | 2026-02-02 |
```

3. Add to portfolio statistics

### 8. Validate All Files Created
Check that all required files exist:

```bash
REQUIRED_FILES=(
    "AGENT.md"
    "project.md"
    "tasks.md"
    "meetings.md"
    "team_members.md"
    "notes.md"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ ! -f "$PROJECT_FOLDER/$file" ]; then
        echo "❌ Failed to create: $file"
        exit 1
    fi
done
```

### 9. Show Success Summary
Display project creation confirmation:

```
✅ Project Created!

📁 Location: Projects/Mobile App/
🏷️ Tag: #mobile-app
📋 Status: Active
🎯 Phase: Discovery

Files created:
✅ AGENT.md (AI instructions)
✅ project.md (Overview)
✅ tasks.md (Task list)
✅ meetings.md (Meeting log)
✅ team_members.md (Team tracking)
✅ notes.md (Research)
✅ discovery/ (Research folder)
✅ execution/ (Implementation folder)

📝 Next steps:
1. Edit project.md with project details
2. Add team members to team_members.md
3. Define initial tasks in tasks.md
4. Use /work-on-project to load context
```

### 10. Optional: Open Project for Editing
If user wants, show how to load project context:

```bash
echo ""
echo "💡 Tip: Load project context with:"
echo "   /work-on-project Mobile App"
```

## Error Handling

- **VAULT_PATH not set**: Show error with setup instructions
- **No project name provided**: Show usage example
- **Project already exists**: Show error and location
- **Invalid project name**: Show error with valid naming rules
- **Template missing**: Show error with file location
- **Catalog missing**: Show error with setup instructions
- **Permission denied**: Show error with permission instructions
- **Disk full**: Show error message

## Important Rules

1. **Non-destructive**: Only creates new folders/files
2. **Idempotent**: Detect and prevent duplicates
3. **Complete structure**: All files created at once
4. **Normalized tags**: Lowercase, hyphenated, safe for markdown
5. **Immediate registration**: Added to catalog immediately

## Project Phases

**Discovery Phase** (default):
- Folder for research artifacts
- Questions and learnings documented
- Later archived when entering Execution

**Execution Phase**:
- Folder for implementation work
- Discovery materials archived
- Working files and outputs

Switch phases by updating `project.md` status.

## Example Usage

```bash
/create-project Mobile App
/create-project Website Redesign
/create-project Backend API Integration
/create-project Q2 Planning
```

## Naming Conventions

- **Project Name**: Use full descriptive name
  - Good: "Mobile App Redesign", "Q2 Planning"
  - Avoid: "Proj1", "TODO", "XYZ"

- **Project Tag** (auto-generated):
  - Lowercase with hyphens
  - No special characters
  - Examples: `#mobile-app-redesign`, `#q2-planning`

- **Folder Name**: Matches Project Name exactly
  - Case-sensitive on macOS/Linux
  - Used for references in tasks

## Notes

- Templates are copied at creation time
- Each project is independent and isolated
- Changes to templates don't affect existing projects
- Projects can be archived by moving folder or marking "Archived" in status
