---
name: obsidian-workflow
description: AI-driven Obsidian workflow system for daily notes, task management, and project organization. Automates "Start my day" and "Digest my day" workflows with task rollover and project categorization.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
metadata:
  author: williamgdev
  version: 2.0
  vault-path: ./personal
sample-prompts:
  - "start my day"
  - "digest my day"
  - "create project [Name]"
  - "work on a project"
  - "set up skill clients"
  - "link skills for Cursor and Claude"
arguments:
  - [workflow-command] - required: "start", "digest", "create-project", "update-system", "setup-skill-clients"
  - [project-name] - optional, for create-project command
---

# Obsidian Workflow Skill

## Overview

This skill implements an AI-driven operating system for Obsidian that automates daily workflows, task management, and project organization. It follows the DailyAI Agentic System architecture with AGENT.md files for context-aware instructions.

## What This Skill Does

### 1. Start My Day 🌅

**Trigger**: Say "start my day" to your AI CLI

**Actions**:
1. Creates today's daily note using template
2. **Check Project Cadences** → Populates `## 🔄 Recurring Tasks` section from project cadence files
3. Scans yesterday's note for incomplete tasks
4. Rolls over undone tasks to today (only if not already in projects)
5. Scans all project folders for:
   - Critical tasks (`@Today` or `@YYYY-MM-DD`)
   - Upcoming tasks (future dates)
   - Undated tasks (no date tags)
6. Populates daily note with all task categories

**Result**: A comprehensive daily note ready for action with:
- Recurring tasks (from project cadences)
- Critical/due tasks highlighted
- Rolled over tasks from yesterday
- Upcoming and undated task visibility

### 2. Digest My Day 🌙

**Trigger**: Say "digest my day" to your AI CLI

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

**Trigger**: Say "create project [Name]" to your AI CLI

**Actions**:
1. Creates project folder structure:
   - `AGENT.md` - Project-specific AI instructions
   - `project.md` - Overview and stats
   - `tasks.md` - Canonical task list
   - `meetings.md` - Meeting log
   - `team_members.md` - Team collaboration tracking
   - `notes.md` - Research and learnings
2. Registers project in `personal/catalog-project.md`
3. Assigns unique tag (e.g., `#project-name`)
4. Sets up project phase (Discovery or Execution)

### 4. Work On a Project 🎯

**Trigger**: "work on a project"

**Actions**:
This is an **interactive, conversational workflow** where the AI agent guides you through selecting a project and task to work on.

### 5. Set up skill clients 🔗

**Trigger**: "set up skill clients", "link skills for Cursor", or "make skills visible to my IDE"

**Actions**:
1. From the **repository root**, run: `./scripts/setup-skill-clients.sh`
2. If symlinks are not supported (e.g. some Windows setups), run with `--copy`: `./scripts/setup-skill-clients.sh --copy`
3. Report what was linked (or any skip messages).

**What it does**: Links each skill under `skills/` (that has a `SKILL.md`) into the project's `.cursor/skills/`, `.claude/skills/`, `.codex/skills/`, `.vscode/skills/`, and `.opencode/skills/` so Cursor, Claude, Codex, VS Code, and openCode auto-discover them. All paths stay inside the project. Idempotent; safe to re-run.

**Phase 1: Show All Projects**
1. Read `personal/catalog-project.md` to get all projects
2. Extract active projects with their tags
3. For each project, count pending tasks in `personal/[Name]/tasks.md`
4. Display numbered list showing:
   - Project number
   - Project name
   - Project tag
   - Pending task count
   - Priority indicators (🔴 for high, ⚠️ for blockers)
5. Ask user: "Which project do you want to work on? (1-N)"
6. Wait for user to select a number

**Phase 2: Show Project Tasks**
7. Read the selected project's `personal/[Name]/tasks.md` file
8. Extract all incomplete tasks (lines starting with `- [ ]`)
9. Parse task metadata:
   - Priority (if in priority sections)
   - Due dates (`@YYYY-MM-DD` or `@Today`)
   - Assignees (`@PersonName`)
   - Blockers (in sub-items or notes)
10. Display numbered task list showing:
    - Task number
    - Task description
    - Metadata (priority, due date, blocker status)
11. Ask user: "Which task do you want to work on? (1-N)"
12. Wait for user to select a number

**Phase 3: Task Confirmed**
13. Show selected task details:
    - Full task description
    - Project tag
    - Location in vault
    - Metadata
14. Ask user what they want to do:
    - Add to today's daily note
    - Mark as @Today for morning plan
    - Start working (track progress)
    - Just viewing (done)

**Example Interaction**:
```
User: "work on a project"

AI: 📂 Available Projects (8 active)

    1. Things To Do (#things-to-do) - 4 pending tasks
    2. Things To Learn (#things-to-learn) - 2 pending tasks
    3. Test Accounts (#test-accounts) - 0 pending tasks ✓
    4. Error Messaging Improvements - CECPRO-30319 - 1 pending task
    5. GiftCard Quick Scan - CECPRO-30512 - 2 pending tasks 🔴
    6. PR Reviews (#pr-reviews) - 2 pending tasks
    7. Release Validation (#release-validation) - 3 pending tasks
    8. DailyAI Agentic System - 2 pending tasks

    Which project do you want to work on? (1-8)

User: 7

AI: 🎯 Release Validation - Pending Tasks (3 tasks)

    1. [ ] Work on generating the report for ios and android
       - Status: Pending (40+ days)

    2. [ ] Test the biweekly-release-validation skill
       - No due date

    3. [ ] Document the release process
       - Status: Blocked - waiting on team feedback

    Which task do you want to work on? (1-3)

User: 2

AI: ✅ Selected: Test the biweekly-release-validation skill

    Project: Release Validation (#release-validation)
    Location: personal/Release Validation/tasks.md

    What would you like to do?
    a) Add to today's daily note
    b) Mark as @Today (shows in morning plan)
    c) Start working on it now
    d) Just wanted to see it (done)

User: c

AI: ✅ Ready to work!

    Task: Test the biweekly-release-validation skill
    Project: #release-validation

    You can now work on this task. Your progress will be tracked
    when you run "digest my day" at the end of the day.
```

**Smart Features**:
- Empty projects show "0 pending tasks ✓"
- High priority projects marked with 🔴
- Blocked tasks show ⚠️
- Can type "back" at any step to go back
- Can combine steps: "work on project 7 task 2"
- Integrates with daily note workflows

**Edge Cases**:
- No active projects: "No active projects. Use 'create project [Name]' to start one."
- Project has no tasks: "No pending tasks in this project. Want to add one?"
- Invalid selection: "Please enter a number between 1-N, or 'back' to cancel"

**Integration**:
- Works seamlessly with "Start My Day" (tasks can be marked @Today)
- Works with "Digest My Day" (tracks progress automatically)
- Respects project catalog registry
- Follows tag system conventions

### 6. Check Today's Cadences 🔄

**Trigger**: "check cadences" or "what's recurring today"

**Actions**:
This workflow provides a comprehensive report of all recurring task configurations and upcoming schedules.

1. Scans all project folders under personal/ for `cadence.md` files
2. Evaluates recurring rules (time-based, sprint-based) against today's date
3. Displays detailed report showing:
   - All projects with cadence.md files
   - Recurring tasks scheduled for today
   - Which rules matched (time-based, sprint-based)
   - Next 7 days of upcoming recurring tasks

**Example Output**:
```
📅 Today's Recurring Tasks (Tuesday, 2026-01-27)

✅ Release Validation
   - Generate Android release validation report (Every Tuesday)
   - Generate iOS release validation report (Every Tuesday)

✅ PR Reviews
   - Weekly PR review triage (Every Tuesday)

📊 Summary: 3 recurring tasks for today

🔮 Next 7 Days:
   - Mon, 2026-02-02: Sprint planning
   - Tue, 2026-02-03: Android/iOS validation
```

**Integration**:
- Works seamlessly with "Start My Day" (cadences auto-populate)
- On-demand reporting for planning ahead
- On-demand reporting for planning ahead

## Workflow Implementation

### Start My Day - Step by Step

```bash
# 1. Get today's date
TODAY=$(date +%Y-%m-%d)

# 2. Check if today's note exists
if [ -f "personal/Daily/2026/$TODAY.md" ]; then
    echo "Daily note already exists"
    exit 0
fi

# 3. Create daily note from skill's internal template
# Template: references/DAILY_NOTE_TEMPLATE.md

# 4. Populate recurring tasks from project cadences

# 5. Scan project folders for tasks
# - Find tasks with @Today or @YYYY-MM-DD (today)
# - Find tasks with future dates
# - Find undated tasks

# 6. Populate daily note sections
# - ## 🚨 Critical / Due Today
# - ## 📅 Upcoming Tasks
# - ## 📌 Undated Tasks
```

### Digest My Day - Step by Step

```bash
# 1. Find latest daily note
LATEST_NOTE=$(find personal/Daily -name "*.md" ! -name "*.digested.md" | sort -r | head -1)

# 2. Check if already digested
NOTE_DATE=$(basename "$LATEST_NOTE" .md)
if [ -f "personal/Daily/2026/$NOTE_DATE.digested.md" ]; then
    echo "Already digested on [date]"
    exit 0
fi

# 3. Extract content by tags
# - Grep for #project-tag patterns
# - Identify meeting sections
# - Find loose tasks without tags

# 4. File content to project folders
# - Tagged tasks → personal/[Name]/tasks.md
# - Meetings → personal/[Name]/meetings.md
# - Notes → personal/[Name]/notes.md

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
**personal/[Name]/AGENT.md**: Project-specific instructions

**Priority Order**:
1. User prompts in chat (highest priority)
2. Project/AGENT.md (project-specific)
3. System/AGENT.md (system-wide defaults)
4. General conventions (lowest priority)

## Usage Examples

### Example 1: Starting Your Day

```
User: start my day
AI: *Creates daily note for 2026-01-26*
       *Populates recurring tasks from cadences*
       *Scans all project folders*

       ☀️ Good Morning! Your Day is Ready

       🚨 Critical Tasks: 2
       📌 Undated Tasks: 8

       Your daily note is ready!
```

### Example 2: Digesting Your Day

```
User: digest my day
AI: *Finds latest daily note (2026-01-26)*
       *Checks if already digested*
       *Extracts tagged tasks*
       *Files content to projects*
       *Creates digest log*

       ✅ Day Digested Successfully!

       📊 Summary:
       - 3 tasks filed to Release Validation
       - 2 tasks filed to DailyAI Agentic System
       - 1 meeting note copied to PR Reviews

       📂 Files Updated:
       ✅ personal/Release Validation/tasks.md
       ✅ personal/DailyAI-Agentic-System/tasks.md

       Digest log created: 2026-01-26.digested.md
```

### Example 3: Creating a Project

```
User: create project Mobile App Redesign
AI: *Creates project folder structure*
       *Registers in catalog with tag #mobile-app-redesign*
       *Sets up AGENT.md with instructions*

       ✅ Project Created!

       📁 Location: personal/Mobile App Redesign/
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
personal/
├── catalog-project.md           # Personal project registry
├── ThingsToDo/                  # Default inbox
├── ThingsToLearn/               # Learning items
├── [ProjectName]/               # Your projects (created via "create project")
└── Daily/
    └── YYYY/
        ├── YYYY-MM-DD.md       # Daily notes
        └── YYYY-MM-DD.digested.md  # Digest logs
```

## Skill Templates (Self-Contained)

All templates are included in this skill's `references/` folder - **no external dependencies required**:

```
references/
├── AGENT_TEMPLATE.md           # System AGENT.md template (the brain)
├── DAILY_NOTE_TEMPLATE.md      # Daily note structure
├── PROJECT_AGENT_TEMPLATE.md   # New project AGENT.md template
├── PROJECT_TASKS_TEMPLATE.md   # New project tasks.md template
├── PROJECT_CATALOG.md          # Project catalog example
├── DIGEST_LOG_TEMPLATE.md      # Digest log format
└── CADENCE_TEMPLATE.md         # Recurring tasks configuration
```

## Reference Files

- `references/AGENT_TEMPLATE.md` - System AGENT.md template (copy to `System/AGENT.md`)
- `references/DAILY_NOTE_TEMPLATE.md` - Daily note template
- `references/PROJECT_AGENT_TEMPLATE.md` - Template for new project AGENT.md files
- `references/PROJECT_TASKS_TEMPLATE.md` - Template for new project tasks.md files
- `references/PROJECT_CATALOG.md` - Project catalog example
- `references/DIGEST_LOG_TEMPLATE.md` - Digest log template
- `references/CADENCE_TEMPLATE.md` - Recurring tasks configuration template
- `scripts/start-day.sh` - Start my day automation
- `scripts/digest-day.sh` - Digest my day automation

## Troubleshooting

### Issue: "No tasks found in Daily Note"
- Check: Tasks use proper format `- [ ]`
- Check: Tags formatted correctly `#project-name`

### Issue: "Daily Note not created"
- Check: Template exists at `references/DAILY_NOTE_TEMPLATE.md` in skill folder
- Check: Folder exists: `personal/Daily/YYYY/`

### Issue: "Tasks not filing to correct project"
- Check: Project tag registered in `catalog-project.md`
- Check: Project folder exists
- Check: `tasks.md` exists in project folder

## Contributing

This system is designed to be collaborative. To add new workflows:

1. Edit `references/AGENT_TEMPLATE.md` in the skill folder
2. Add your workflow to the appropriate section
3. Run "Update System" to sync to active `System/AGENT.md`
4. Test the new workflow
5. Share with the team!

## Version History

- **v2.0** (2026-02-04): Repository restructure & simplification
  - Moved skill to `skills/obsidian-workflow/` at repo root
  - Simplified personal/ structure (removed System/ subfolder)
  - Catalog now at `personal/catalog-project.md`
  - Removed redundant System/AGENT.md (SKILL.md is the brain)
  - Removed "Update System" workflow (no longer needed)
  - Skills discoverable directly from repo - no installation needed
  - Added setup.sh and test-setup.sh for onboarding

- **v1.1** (2026-02-04): Self-contained skill
  - All templates now included in `references/` folder
  - Removed dependency on external `obsidian-templates/` folder
  - Fixed "Work on a Project" interactive workflow (Phase 1/2/3)

- **v1.0** (2026-01-26): Initial skill creation
  - Start My Day workflow
  - Digest My Day workflow
  - Project creation and management

---

**Status**: Active ✅
**Maintained By**: Team
**Repository**: &lt;your-repo-url&gt;
