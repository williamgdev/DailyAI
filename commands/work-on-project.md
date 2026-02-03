---
name: work-on-project
description: Load project context and display comprehensive project status
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

# Work on Project Command

Load project-specific context from AGENT.md and display comprehensive project status including tasks, meetings, and team updates.

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
    echo "Usage: /work-on-project ProjectName"
    exit 1
fi

PROJECT_NAME="$1"
```

### 3. Find Project Folder
Search for project folder matching the name:

```bash
PROJECT_FOLDER="$VAULT_PATH/Projects/$PROJECT_NAME"

if [ ! -d "$PROJECT_FOLDER" ]; then
    echo "❌ Project not found: $PROJECT_NAME"
    echo ""
    echo "Available projects:"
    ls "$VAULT_PATH/Projects/" | grep -v "^Things" | head -10
    exit 1
fi
```

### 4. Load Project AGENT.md
Read the project's AGENT.md file for project-specific AI context:

```bash
AGENT_FILE="$PROJECT_FOLDER/AGENT.md"

if [ ! -f "$AGENT_FILE" ]; then
    echo "⚠️ WARNING: AGENT.md not found for this project"
    echo "   File: Projects/$PROJECT_NAME/AGENT.md"
fi
```

Parse and display key sections from AGENT.md for AI context.

### 5. Load Project Overview
Read `project.md` to get:
- Project description
- Current status (Active, On Hold, Archived)
- Current phase (Discovery, Execution)
- Project goals and objectives
- Current sprint or milestone
- Expected completion date

### 6. Extract Project Tag
Get the normalized project tag:

```bash
# Look for tag in AGENT.md or catalog
PROJECT_TAG=$(grep "tag:" "$AGENT_FILE" 2>/dev/null | cut -d':' -f2 | xargs)

if [ -z "$PROJECT_TAG" ]; then
    PROJECT_TAG=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
fi
```

### 7. Load and Display Project Status
Read `project.md` and display key information:

**Header Section:**
```
💼 Working on: Mobile App Redesign
📁 Location: Projects/Mobile-App-Redesign/
🏷️ Tag: #mobile-app-redesign
📋 Status: Active (Execution Phase)
```

**Project Overview** (from project.md):
```
🎯 Project Overview:
- Redesigning mobile app UI/UX for better user experience
- Target: Q2 2026 launch
- Current Sprint: Authentication & Onboarding
```

### 8. Extract and Display Critical Tasks
Search `tasks.md` for tasks with:
- `@Today` tag
- Today's date `@YYYY-MM-DD`
- Priority markers or "Critical" labels

Display top 5-10 critical tasks:

```
🚨 Critical Tasks (3):
- [ ] Complete login screen mockups @Today
- [ ] Review authentication flow @2026-02-03
- [ ] User testing session prep @2026-02-05
```

### 9. Extract and Display In-Progress Tasks
Search `tasks.md` for:
- `🔄 In Progress` section
- Tasks marked with `[>]` or similar
- Last 2-3 weeks of activity

Display up to 5 in-progress items:

```
📝 In Progress (2):
- [ ] Design system documentation
- [ ] Accessibility audit
```

### 10. Extract and Display Recent Meetings
Read `meetings.md` and extract:
- Last 3-5 meeting entries
- Meeting dates, attendees, key points
- Associated action items

Display as list:

```
📅 Recent Meetings:
- 2026-01-30: Design Review with UX Team
- 2026-01-28: Sprint Planning
- 2026-01-25: Stakeholder Sync
```

### 11. Extract Team Information
Read `team_members.md`:
- Count active team members
- Show recent collaborators (top interactions)
- Display team size

```
👥 Team: 5 active members
Recent collaborators: Sarah, Mike, Jessica
```

### 12. Extract Blockers and Risks
Read `notes.md` and search for:
- `⚠️ Blockers` section
- `🚨 Risks` section
- Items marked with ⚠️ or 🔴

Display:

```
⚠️ Blockers: Waiting on API specs from backend team

🚨 Risks:
- Tight timeline for Q2 launch
- Dependency on third-party animation library
```

### 13. Display AGENT.md Rules
Show that AGENT.md context is now active:

```
✅ Project context loaded. AGENT.md rules active.
```

This informs the AI that project-specific instructions should be followed.

### 14. Show Summary
Display complete status:

```
💼 Working on: Mobile App Redesign
📁 Location: Projects/Mobile-App-Redesign/
🏷️ Tag: #mobile-app-redesign
📋 Status: Active (Execution Phase)

🎯 Project Overview:
- Redesigning mobile app UI/UX for better user experience
- Target: Q2 2026 launch
- Current Sprint: Authentication & Onboarding

🚨 Critical Tasks (3):
- [ ] Complete login screen mockups @Today
- [ ] Review authentication flow @2026-02-03
- [ ] User testing session prep @2026-02-05

📝 In Progress (2):
- [ ] Design system documentation
- [ ] Accessibility audit

📅 Recent Meetings (3):
- 2026-01-30: Design Review with UX Team
- 2026-01-28: Sprint Planning
- 2026-01-25: Stakeholder Sync

👥 Team: 5 active members
Recent: Sarah, Mike, Jessica

⚠️ Blockers: Waiting on API specs from backend team

✅ Project context loaded. AGENT.md rules active.
```

## Error Handling

- **VAULT_PATH not set**: Show error with setup instructions
- **No project name provided**: Show usage example
- **Project not found**: Show available projects
- **AGENT.md missing**: Show warning, continue with basic display
- **project.md missing**: Show warning, continue
- **tasks.md missing**: Show info, skip task display
- **meetings.md missing**: Show info, skip meetings
- **No critical tasks**: Show message
- **No team members**: Show message
- **No blockers**: Omit section

## AGENT.md Integration

The project's AGENT.md file contains:
- Project-specific workflows and conventions
- How to work with this project
- Team guidelines and practices
- Decision-making frameworks
- Communication protocols

By loading AGENT.md, the AI assistant gets:
- **Priority Context**: What matters most for this project
- **Workflow Rules**: How tasks should be handled
- **Team Conventions**: How to collaborate effectively
- **Success Criteria**: What "done" looks like

## Priority Hierarchy

1. **User commands** in chat (highest priority)
2. **Project AGENT.md** (project-specific rules active)
3. **System AGENT.md** (system-wide defaults)
4. **General conventions** (lowest priority)

## Example Usage

```bash
/work-on-project Mobile App
/work-on-project Website Redesign
/work-on-project Backend API Integration
/work-on-project Q2 Planning
```

## Quick Navigation

After loading project context, you can:

1. **Add tasks**: Reference project tag in daily note (`#mobile-app`)
2. **Log meetings**: Add entries to meetings.md
3. **Update progress**: Mark tasks complete in tasks.md
4. **Escalate blockers**: Document in notes.md
5. **Track team**: Update interactions in team_members.md

## Project Context Persistence

Once a project is loaded with `/work-on-project`:
- AGENT.md rules remain active for subsequent prompts
- Project tag (`#mobile-app`) is known for daily notes
- Team context is loaded for collaboration
- Blockers and risks are visible

Context remains active until:
- A different project is loaded: `/work-on-project OtherProject`
- A new daily note is started: `/start-day`
- Explicitly cleared by user

## Notes

- Non-invasive: Only reads, doesn't modify files
- Fast: Loads all context efficiently
- Complete: Shows comprehensive project status
- AI-aware: Feeds AGENT.md to AI for intelligent context
