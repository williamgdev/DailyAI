⚠️ **LEGACY FORMAT** - This is the Agent Skills format (v1.0).

**For Claude Code users:** Use the plugin format instead!
- Installation: See [docs/installation.md](docs/installation.md)
- Commands: `/start-day`, `/digest-day`, `/create-project`, `/work-on-project`
- Guide: [docs/commands.md](docs/commands.md)

This file is maintained for backward compatibility. It still works if you share it with Claude, but the Claude Code plugin is the recommended approach.

---

name: dailyai
description: DailyAI - AI-driven Obsidian workflow system for daily notes, task management, and project organization. Automates "Start my day" and "Digest my day" workflows with optional calendar integration, task rollover, and project categorization. Works with Claude and other AI assistants.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
metadata:
  author: Luc M.
  version: 1.0
  vault-path: $VAULT_PATH
sample-prompts:
  - "start my day"
  - "digest my day"
  - "create project [Name]"
  - "work on [ProjectName]"
  - "update system"
  - "show me today's tasks"
arguments:
  - [workflow-command] - required: "start", "digest", "create-project", "work-on-project", "update-system"
  - [project-name] - optional, for create-project and work-on-project commands
---

# DailyAI Skill

## Overview

DailyAI is an AI-driven operating system for Obsidian that automates daily workflows, task management, and project organization. It follows an agentic architecture with AGENT.md files for context-aware instructions.

## What This Skill Does

### 1. Start My Day 🌅

**Trigger**: `claude dailyai start` or just say "start my day"

**Actions**:
1. Creates today's daily note using template
2. **Optionally fetches calendar events** (if calendar API configured)
   - Populates `## 📅 Calendar` section with events
   - Extracts project tags from calendar event titles
3. Scans yesterday's note for incomplete tasks
4. Rolls over undone tasks to today (only if not already in projects)
5. Scans all project folders for:
   - Critical tasks (`@Today` or `@YYYY-MM-DD`)
   - Upcoming tasks (future dates)
   - Undated tasks (no date tags)
6. Populates daily note with all task categories

**Result**: A comprehensive daily note ready for action with:
- Calendar events with project associations (optional)
- Targeted projects for the day
- Critical/due tasks highlighted
- Rolled over tasks from yesterday
- Upcoming and undated task visibility

### 2. Digest My Day 🌙

**Trigger**: `claude dailyai digest` or just say "digest my day"

**Actions**:
1. Finds the most recent daily note
2. Checks if already digested (`.digested.md` file exists)
3. Extracts and categorizes content:
   - **Tagged tasks** → Filed to specific project folders (removes project tag)
   - **Untagged tasks** → Filed to ThingsToDo inbox
   - **Meeting notes** → Copied to project meetings files
   - **Notes** → Filed to project notes
   - **Learning items** → Filed to ThingsToLearn
4. Creates comprehensive digest log (`.digested.md`)
5. Shows summary of what was filed where

**Important**: Daily notes are NEVER modified - they remain as permanent records.

### 3. Create Project 📁

**Trigger**: `claude dailyai create-project [Name]`

**Actions**:
1. Creates project folder structure:
   - `AGENT.md` - Project-specific AI instructions
   - `project.md` - Overview and stats
   - `tasks.md` - Canonical task list
   - `meetings.md` - Meeting log
   - `team_members.md` - Team collaboration tracking
   - `notes.md` - Research and learnings
2. Registers project in `System/catalog-project.md`
3. Assigns unique tag (e.g., `#project-name`)
4. Sets up project phase (Discovery or Execution)

### 4. Update System 🔄

**Trigger**: `claude dailyai update-system`

**Actions**:
1. Reads source of truth: `obsidian-templates/system_agent_template.md`
2. Compares with current: `$VAULT_PATH/System/AGENT.md`
3. Updates workflows section to match template
4. Preserves personal workflows and custom data
5. Maintains system version consistency

### 5. Work on Project 💼

**Trigger**: `work on [ProjectName]` or `focus on [ProjectName]`

**Actions**:
1. Locates project folder: `$VAULT_PATH/Projects/[ProjectName]/`
2. Reads project's `AGENT.md` file to load AI context
3. Displays project overview from `project.md`:
   - Project status and phase (Discovery/Execution)
   - Key objectives and goals
   - Current sprint or milestone
4. Shows open tasks from `tasks.md`:
   - Critical tasks (@Today or due dates)
   - In-progress tasks
   - Upcoming tasks
5. Lists recent meetings from `meetings.md` (last 3-5)
6. Shows team members and collaboration status
7. Highlights any blockers or risks from `notes.md`

**Result**:
- AI assistant has full project context loaded
- Project-specific AGENT.md rules are active
- You see a comprehensive project status summary
- Ready to work with project-specific workflows and conventions

**Example Output**:
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

📅 Recent Meetings:
- 2026-01-30: Design Review with UX Team
- 2026-01-28: Sprint Planning
- 2026-01-25: Stakeholder Sync

👥 Team: 5 active members
⚠️ Blockers: Waiting on API specs from backend team

✅ Project context loaded. AGENT.md rules active.
```

## Workflow Implementation

### Start My Day - Step by Step

```bash
# 1. Get today's date
TODAY=$(date +%Y-%m-%d)

# 2. Check if today's note exists
if [ -f "$VAULT_PATH/Daily/2026/$TODAY.md" ]; then
    echo "Daily note already exists"
    exit 0
fi

# 3. Create daily note from template
cp obsidian-templates/daily_note_template.md "$VAULT_PATH/Daily/2026/$TODAY.md"

# 4. Optionally fetch calendar events (if calendar API configured)
# CALENDAR_OUTPUT=$(calendar-api-command)

# 5. Populate calendar section in daily note (if enabled)
# Extract events and add to ## 📅 Calendar section

# 6. Scan project folders for tasks
# - Find tasks with @Today or @YYYY-MM-DD (today)
# - Find tasks with future dates
# - Find undated tasks

# 7. Populate daily note sections
# - ## 🚨 Critical / Due Today
# - ## 📅 Upcoming Tasks
# - ## 📌 Undated Tasks
```

### Digest My Day - Step by Step

```bash
# 1. Find latest daily note
LATEST_NOTE=$(find $VAULT_PATH/Daily -name "*.md" ! -name "*.digested.md" | sort -r | head -1)

# 2. Check if already digested
NOTE_DATE=$(basename "$LATEST_NOTE" .md)
if [ -f "$VAULT_PATH/Daily/2026/$NOTE_DATE.digested.md" ]; then
    echo "Already digested on [date]"
    exit 0
fi

# 3. Extract content by tags
# - Grep for #project-tag patterns
# - Identify meeting sections
# - Find loose tasks without tags

# 4. File content to project folders
# - Tagged tasks → Projects/[Name]/tasks.md
# - Meetings → Projects/[Name]/meetings.md
# - Notes → Projects/[Name]/notes.md

# 5. Create digest log
# - Summary of all actions
# - Files modified list
# - Statistics
```

## Key Features

### 🏷️ Tag System

**Project Tags**: `#project-name` (lowercase-with-hyphens)
- Routes content to specific projects
- Registered in `System/catalog-project.md`
- Removed when filing to project folders

**Date Tags**: `@YYYY-MM-DD` or `@Today`
- Schedules tasks for specific dates
- Preserved when moving tasks
- Creates visibility in Critical/Upcoming sections

**Person Tags**: `@PersonName`
- Tracks collaborations and assignments
- Updates team interaction counts

### 📂 Project Structure

**Phase 1: Discovery**
```
ProjectName/
├── AGENT.md           # AI instructions
├── project.md         # Overview
├── tasks.md           # Task list
├── meetings.md        # Meeting notes
├── team_members.md    # Team tracking
├── notes.md           # Research
└── discovery/         # Discovery artifacts
```

**Phase 2: Execution**
```
ProjectName/
├── AGENT.md
├── project.md
├── tasks.md
├── meetings.md
├── team_members.md
├── notes.md
├── discovery/         # Archived research
└── execution/         # Implementation work
```

### 🤖 AGENT.md Files

This system uses `AGENT.md` files (singular, not AGENTS.md) for project-specific AI instructions:

**System/AGENT.md**: System-wide workflows and rules
**Projects/[Name]/AGENT.md**: Project-specific instructions

**Priority Order**:
1. User prompts in chat (highest priority)
2. Project/AGENT.md (project-specific)
3. System/AGENT.md (system-wide defaults)
4. General conventions (lowest priority)

## Calendar Integration (Optional)

The skill can integrate with calendar APIs for event access:

**Calendar Check Command**:
```bash
# Example using a generic calendar API
calendar-api --date today --format markdown
```

**What It Does**:
- Fetches today's calendar events
- Identifies project associations from event titles
- Formats events as markdown list
- Extracts project tags for Targeted Projects section

**Example Output**:
```markdown
- 9:00 AM - 10:00 AM: Team Standup #team-sync
- 11:00 AM - 12:00 PM: Project Planning #mobile-app
- 2:00 PM - 3:00 PM: 1:1 with Manager
```

**Note**: Calendar integration is optional. The workflow works perfectly fine without it by manually adding calendar events to your daily note.

## Usage Examples

### Example 1: Starting Your Day

```
User: start my day
Claude: *Creates daily note for 2026-01-26*
        *Optionally fetches calendar events*
        *Populates calendar events*
        *Scans all project folders*

        ☀️ Good Morning! Your Day is Ready

        📅 Calendar:
        - 9:00 AM: Team Standup
        - 11:00 AM: Sprint Planning

        🎯 Targeted Projects: 3
        🚨 Critical Tasks: 2
        📌 Undated Tasks: 8

        Your daily note is ready!
```

### Example 2: Digesting Your Day

```
User: digest my day
Claude: *Finds latest daily note (2026-01-26)*
        *Checks if already digested*
        *Extracts tagged tasks*
        *Files content to projects*
        *Creates digest log*

        ✅ Day Digested Successfully!

        📊 Summary:
        - 3 tasks filed to Website Redesign
        - 2 tasks filed to API Integration
        - 1 meeting note copied to Mobile App

        📂 Files Updated:
        ✅ Projects/Website Redesign/tasks.md
        ✅ Projects/API-Integration/tasks.md

        Digest log created: 2026-01-26.digested.md
```

### Example 3: Creating a Project

```
User: create project Mobile App Redesign
Claude: *Creates project folder structure*
        *Registers in catalog with tag #mobile-app-redesign*
        *Sets up AGENT.md with instructions*

        ✅ Project Created!

        📁 Location: Projects/Mobile App Redesign/
        🏷️ Tag: #mobile-app-redesign
        📋 Status: Active

        Files created:
        - AGENT.md
        - project.md
        - tasks.md
        - meetings.md
        - team_members.md
        - notes.md
```

## Best Practices

1. **Tag Consistently**: Use registered tags from `catalog-project.md`
2. **Date Important Tasks**: Add `@Today` or specific dates to critical items
3. **Review Daily**: Run "Digest my day" at end of each day
4. **Clean Inbox**: Regularly assign projects to inbox items
5. **Update Catalog**: Keep project registry current
6. **Sync System**: Run "Update System" when templates change
7. **Use Meetings**: Meeting notes automatically copy to projects
8. **Track Learning**: Tag educational content for future reference

## File Locations

```
$VAULT_PATH/
├── System/
│   ├── AGENT.md                 # System brain
│   ├── catalog-project.md       # Project registry
│   └── CALENDAR_INTEGRATION.md  # Optional calendar setup
├── Projects/
│   ├── ThingsToDo/             # Default inbox
│   ├── ThingsToLearn/          # Learning items
│   └── [ProjectName]/          # Your projects
└── Daily/
    └── YYYY/
        ├── YYYY-MM-DD.md       # Daily notes
        └── YYYY-MM-DD.digested.md  # Digest logs

obsidian-templates/             # Source of truth templates
├── system_agent_template.md
├── daily_note_template.md
├── project_agent_template.md
└── ...
```

## Reference Files

- `templates/AGENT_TEMPLATE.md` - System AGENT.md template
- `templates/DAILY_NOTE_TEMPLATE.md` - Daily note template
- `templates/PROJECT_CATALOG.md` - Project catalog example

## Troubleshooting

### Issue: "No tasks found in Daily Note"
- Check: Tasks use proper format `- [ ]`
- Check: Tags formatted correctly `#project-name`

### Issue: "Daily Note not created"
- Check: Template exists at `obsidian-templates/daily_note_template.md`
- Check: Folder exists: `$VAULT_PATH/Daily/YYYY/`

### Issue: "Calendar API not responding"
- Check: Calendar API is configured and accessible
- Check: API credentials/tokens are valid
- Check: Calendar API permissions are set correctly
- Note: Calendar integration is optional - you can manually add events

### Issue: "Tasks not filing to correct project"
- Check: Project tag registered in `catalog-project.md`
- Check: Project folder exists
- Check: `tasks.md` exists in project folder

## Contributing

This system is designed to be collaborative. To add new workflows:

1. Edit `obsidian-templates/system_agent_template.md`
2. Add your workflow to the appropriate section
3. Run "Update System" to sync to active AGENT.md
4. Test the new workflow
5. Share with the community!

## Version History

- **v1.0** (2026-01-26): Initial skill creation
  - Start My Day workflow
  - Digest My Day workflow
  - Optional calendar integration
  - Project creation and management
  - System update functionality

---

**Status**: Active ✅
**License**: Open Source
