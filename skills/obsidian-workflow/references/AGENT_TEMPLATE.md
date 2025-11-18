# AGENT.md — System Root

**Purpose**: Complete workflow guide for AI agents and humans.  
**Canonical Todo List**: `tasks.md` (Project-specific).  
**Source of Truth**: `catalog-project.md` (for Tags and Projects).

> This file serves dual purposes:
> 1. **For AI Agents**: Machine-readable workflow definitions to execute
> 2. **For Humans**: Complete reference guide with examples and best practices

---

## 📂 Portfolio Overview

This system organizes work into **Projects** or **Epics**.
Each project follows a standard structure.

```
Vault/ (personal folder — used by "start my day" and "create project")
├── System/
│   ├── AGENT.md               # This file (The Brain)
│   └── catalog-project.md     # List of all Projects & Tags
├── ThingsToDo/                # Default: Loose tasks (inbox)
├── ThingsToLearn/             # Default: Learning topics
├── [ProjectName]/             # Your projects (one folder per project)
├── ../../obsidian-templates/  # System Templates (clean, minimal)
└── Daily/                     # Daily Notes
```

---

## 🏗️ Standard Project Structure

### Phase 1: Discovery
```
ProjectName/
├── AGENT.md           # Instructions: Goal, Context, Rules
├── project.md         # Project Overview & Quick Stats
├── tasks.md           # Canonical Task List
├── meetings.md        # Meeting Log
├── team_members.md    # Team Collaboration Tracking
├── notes.md           # Research, Blockers, Risks, Learnings
└── discovery/         # Research, specs, analysis
```

### Phase 2: Execution
```
ProjectName/
├── AGENT.md           # Instructions
├── project.md         # Project Overview
├── tasks.md           # Canonical Task List
├── meetings.md        # Meeting Log
├── team_members.md    # Team Collaboration Tracking
├── notes.md           # Implementation notes, blockers, learnings
├── discovery/         # Archived research
└── execution/         # Implementation work
```

---

## 📖 Understanding AGENT.md Files

### What is AGENT.md?

AGENT.md is a project-specific instruction file designed for AI agents. Think of it as a "README for robots" - while README.md files explain projects to human developers, AGENT.md provides context and instructions that AI models need to work effectively with a project.

**Note**: This system uses `AGENT.md` (singular) for project-specific instructions. The industry standard `AGENTS.md` (plural) format is similar in concept, but our system uses the singular form for consistency with our project structure.

### How It Works in This System

**Two-Level Hierarchy**:

1. **System/AGENT.md** (this file)
   - System-wide workflows and rules
   - Universal commands like "Start my day", "Digest my day"
   - Project creation and management
   - Tag system and routing rules

2. **[Name]/AGENT.md** (project folder under vault/personal)
   - Project-specific instructions and context
   - Workflow procedures for that specific project
   - Commands and procedures unique to the project
   - Team conventions and domain knowledge

**Priority Order**:
1. User prompts in chat (highest priority - always override)
2. Project/AGENT.md (when working on specific project)
3. System/AGENT.md (system-wide defaults)
4. General conventions inferred from code (lowest priority)

### Reading Priority for AI Models

When working with this system, AI models should:

1. **Always read System/AGENT.md first**
   - Understand system-wide workflows
   - Learn how projects are structured
   - Know the standard commands

2. **Read Project/AGENT.md when working on a project**
   - Before making changes to a project, read its AGENT.md
   - Follow project-specific instructions
   - Apply project conventions and workflows

3. **Respect user prompts**
   - User instructions in chat always override AGENT.md
   - If user says "do X differently", follow the user
   - AGENT.md provides defaults, not constraints

4. **Use closest file in nested structures**
   - If multiple AGENT.md files exist, use the most specific one
   - Project-level overrides system-level for that project

### What Goes in Project AGENT.md

Each project's AGENT.md should contain:

- **Project Context**: What the project is, team structure, domain knowledge
- **Workflow Instructions**: Step-by-step procedures for common tasks
- **Commands**: Specific commands and how to execute them
- **Conventions**: Team-specific practices and standards
- **Examples**: Sample workflows and expected outputs

**Example**: The PR Reviews project has an AGENT.md that explains how to check PRs, categorize them by pod, and generate daily reports.

### How AI Models Should Use AGENT.md

When encountering an AGENT.md file:

1. **Read it first** before starting work on that project
2. **Follow instructions explicitly** - treat them as authoritative
3. **Execute code blocks** - if AGENT.md contains commands, run them
4. **Apply style rules** - use any code style guidelines specified
5. **Respect constraints** - follow security, testing, or process requirements
6. **Defer to user prompts** - if user instructions conflict, prioritize user

### Benefits for Teams

- **Consistency**: All AI agents follow same procedures for each project
- **Onboarding**: New team members' agents work correctly immediately
- **Documentation**: Keeps agent instructions separate from human docs
- **Evolution**: Easy to update as project practices change
- **Sharing**: Portable across different AI coding tools

### Creating a New Project AGENT.md

When you create a new project using "Create project [Name]", the system automatically:
- Creates `[Name]/AGENT.md` from template (under vault/personal)
- Provides basic structure for project-specific instructions
- Registers the project in `catalog-project.md`

You can then customize the AGENT.md with:
- Project-specific workflows
- Team conventions
- Domain knowledge
- Custom commands

---

## 🤖 Agent Workflows

### 1. Start My Day
- **Trigger**: "Start my day".
- **Action**:
    1.  **Create Note**: Create today's Daily Note using `../../obsidian-templates/daily_note_template.md`.
    2.  **Rollover**: Scan yesterday's note for incomplete tasks `[ ]` -> Copy to `## 📋 Rolled Over Tasks`.
    3.  **Critical Check**: Scan all project folders' `[Name]/tasks.md` (under vault/personal, excluding ThingsToDo, ThingsToLearn, Daily) for tasks with `@Today` or `@YYYY-MM-DD` (today's date) -> Copy to `## 🚨 Critical / Due Today` **with project tag** (e.g., `#things-to-do`, `#things-to-learn`).
    4.  **Upcoming Tasks**: Scan all project folders' `[Name]/tasks.md` for tasks with future dates `@YYYY-MM-DD` -> Copy to `## 📅 Upcoming Tasks` **with project tag** (show recurrently until due date).
    5.  **Undated Tasks**: Scan all project folders' `[Name]/tasks.md` for incomplete tasks without `@` date tags -> Copy to `## 📌 Undated Tasks` **with project tag** (show daily until completed or dated).

    **Note**: When copying tasks from project folders to daily notes, always add the appropriate project tag.

### 2. Digest My Day
- **Trigger**: "Digest my day".
- **Action**:
    - **Check if Already Digested**:
        - Find latest daily note: `Daily/YYYY/YYYY-MM-DD.md`
        - Check if `Daily/YYYY/YYYY-MM-DD.digested.md` exists
        - If exists: Show message with digest date and STOP (already processed)
        - If not exists: Continue with digest
    - **Find Latest Daily Note**: Automatically locate the most recent daily note in `Daily/` folder (if today's note doesn't exist, use the latest available).
    - **Identify Projects**: Check tags against `catalog-project.md`.
    - **Tagged Tasks**: Copy to specific `Project/tasks.md` **and remove project tag** (keep other tags like `@date`).
        - **Format**: Copy task content ONLY, without source links or daily note references.
    - **Meeting Notes**: Copy to `Project/meetings.md` or `Project/execution/meetings/` (create meeting entry if needed).
    - **Loose Tasks (Inbox)**: Copy to `ThingsToDo/tasks.md` under Inbox section.
        - **IMPORTANT**: Preserve ALL details (Address, Time, Date) in the task description. Do not summarize.
    - **Detailed Appointments**: If task has a specific date/time, add `@YYYY-MM-DD` tag.
    - **Learning Items**: Copy to `ThingsToLearn/tasks.md` (tasks only, not catalog entries).
    - **File Notes**: Extract notes under `## Notes` or with specific tags -> Copy to `[Name]/notes.md`.
        - **Format**: Copy content ONLY, without source links or daily note references.
    - **Team Interactions**: Update `Project/team_members.md` interaction counts.
    - **Create Digest Log**:
        - Summarize all actions performed during this digest
        - Save to `Daily/YYYY/YYYY-MM-DD.digested.md` (same folder as daily note)
        - Include: what was filed where, files modified, statistics
        - Keep summary concise but complete
    - **Show Summary**:
        - Date of note being digested
        - Tasks by project (tagged items)
        - Meetings identified (by headers or tags)
        - Untagged items (inbox candidates)
        - Learning captured
        - Team interactions
        - Time spent estimates
        - Wins and challenges
        - Confirmation that digest log was created
    - **Important**:
        - Daily notes are NEVER modified or deleted. They serve as permanent records.
        - Digest logs are NEVER modified after creation.
        - If `.digested.md` exists = already processed, do not re-digest.
        - Do NOT add source links (`[[../../Daily/...]]`) when copying content to projects.
        - Copy content cleanly without metadata or references.
    
    **Note**: This command **COPIES** content to project folders and provides a summary. The daily note remains **UNCHANGED** as your permanent record. When copying tasks from daily notes to project folders, remove the project tag since the folder location provides context. If no daily note exists for today, it will automatically use the most recent available daily note. A digest log file (`.digested.md`) is created to track what was processed and prevent duplicate digests.

**Digest My Day Checklist** (AI agents MUST complete ALL steps):
- [ ] Check if `.digested.md` already exists (if yes, STOP)
- [ ] Read latest daily note
- [ ] Extract and copy tagged tasks to project folders
- [ ] Extract and copy meetings to project folders
- [ ] Extract and copy notes to project folders
- [ ] Update team interaction counts
- [ ] **CREATE `.digested.md` file** (use `templates/Digest Log Template.md`)
- [ ] Show summary to user
- [ ] Confirm digest log file path to user

### 3. Create Project
- **Trigger**: "Create project [Name]".
- **Action**:
    1.  **Create Folder**: `[Name]/` (under vault/personal).
    2.  **Instantiate**: Copy templates to create:
        - `[Name]/AGENT.md` (from `../../obsidian-templates/project_agent_template.md`)
          - **Purpose**: Project-specific instructions for AI agents
          - Contains: Project context, workflows, commands, and team conventions
          - AI models should read this before working on the project
        - `[Name]/project.md` (individual project template)
        - `[Name]/tasks.md` (from `../../obsidian-templates/project_tasks_template.md`)
        - `[Name]/meetings.md` (from `../../obsidian-templates/meeting_note_template.md`)
        - `[Name]/team_members.md` (individual project template)
        - `[Name]/notes.md` (individual project template)
    3.  **Register**: Add a new row to `System/catalog-project.md` with a unique `#tag` and status.
    4.  **Update AGENT.md**: Fill in project name, tag, owner information, and project-specific instructions.

### 4. Update System
- **Trigger**: "Update System".
- **Action**:
    1.  **Read** `../../obsidian-templates/system_agent_template.md` (Source of Truth).
    2.  **Compare** with `System/AGENT.md` (Current Brain).
    3.  **Update** the `## 🤖 Agent Workflows` section to match the template.
    4.  **Do NOT touch** the `## 🧩 Personal Workflows` section.
    5.  **Preserve** user-specific data (Owner, Project Status Summary).

---

## 🧩 Personal Workflows
*(Add your custom workflows here. The System Updater will NOT touch this section.)*

---

## 🏷️ Tag System Rules

### Tag Format

**Project Tags**: `#<project-name>`

- Example: `#things-to-do`, `#website-redesign`
- Registered in `System/catalog-project.md`
- Used for routing content to projects

**Date Tags**: `@YYYY-MM-DD` or `@Today`

- Example: `@2025-12-09`, `@Today`
- Used for scheduling and prioritization
- Preserved when moving tasks

**Person Tags**: `@PersonName`

- Example: `@John`, `@Sarah`
- Used for tracking interactions and assignments

### Tag Behavior

1. **In Daily Notes**: Tags route content to correct project
2. **In Project Files**: Tags are removed (folder provides context)
3. **Registry**: All tags registered in `catalog-project.md` as single source of truth
4. **Special Tags**:
   - `@Today` - Task is critical for today
   - `@YYYY-MM-DD` - Task scheduled for specific date
   - `@[Person]` - Waiting on person or mention

### Tag Routing

- Tagged items in daily notes → Extract to project folder
- Untagged items → Route to `ThingsToDo` inbox
- Meeting notes → Extract to project `meetings.md`
- Learning items → Extract to `ThingsToLearn` or project notes

### Tagging Best Practices

- ✅ Use project tags in daily notes: `- [ ] Fix bug #things-to-do`
- ✅ Use date tags for scheduling: `- [ ] Meeting prep @2025-12-10`
- ✅ Combine tags: `- [ ] Review code @Today #things-to-do @John`
- ❌ Don't use project tags inside project folders (redundant)

---

## 📅 Date Filtering

### Critical Tasks

Tasks tagged `@Today` or `@YYYY-MM-DD` (today's date) appear in the **Critical / Due Today** section.

```markdown
- [ ] Submit report @Today
- [ ] Call client @2025-12-09
```

### Upcoming Tasks

Tasks with future date tags appear in **Upcoming Tasks** until their due date.

```markdown
- [ ] Prepare presentation @2025-12-15
- [ ] Review Q4 goals @2025-12-31
```

### Undated Tasks

Tasks without date tags appear in **Undated Tasks** as reminders.

```markdown
- [ ] Update README
- [ ] Research new framework
```

---

## 📥 Inbox Management

### Untagged Items

Items without project tags go to the **ThingsToDo** inbox:

```markdown
## In Daily Note
- [ ] Call dentist

## After "Digest My Day" → Copied To
ThingsToDo/tasks.md (Inbox section)

**Note**: Original task remains in daily note
```

### Tagged Items

Items with project tags go to their designated project:

```markdown
## In Daily Note
- [ ] Fix login bug #website-redesign

## After "Digest My Day" → Copied To
WebsiteRedesign/tasks.md (or personal/WebsiteRedesign/tasks.md from repo root)
(Tag removed, becomes: "- [ ] Fix login bug")

**Note**: Original task with tag remains in daily note
```

---

## 🎙️ Meeting Extraction

### In Daily Note

```markdown
## Meeting Notes

### Team Standup #things-to-do
- Discussed sprint progress
- **Action**: Update documentation @John
- **Decision**: Use React for frontend
```

### After "Digest My Day"

Copied to `ThingsToDo/meetings.md`:

```markdown
## 2025-12-09 - Team Standup
- Discussed sprint progress
- **Action**: Update documentation @John
- **Decision**: Use React for frontend
```

---

## 💡 Learning Extraction

### In Daily Note

```markdown
## Learning & Insights
- Learned about React Hooks optimization #things-to-learn
- Best practice: Use useMemo for expensive calculations
```

### After "Digest My Day"

Copied to `ThingsToLearn/notes.md`:

```markdown
## Key Learnings
- **2025-12-09**: React Hooks optimization
  - Best practice: Use useMemo for expensive calculations
```

---

## 🔧 Customization

### Personal Workflows

Add custom workflows below in the `## 🧩 Personal Workflows` section:

```markdown
## 🧩 Personal Workflows

### Weekly Review
- **Trigger**: "Do weekly review"
- **Action**:
  1. Review completed tasks from past week
  2. Identify patterns and blockers
  3. Set goals for next week
  4. Update project statuses
```

### Custom Tags

Add custom tags to `System/catalog-project.md`:

```markdown
| Project | Tag | Description | Status | Location |
|---------|-----|-------------|--------|----------|
| **My Custom Project** | `#custom` | Special project | Active | `MyCustom/` |
```

---

## 📋 Task Management Rules

### Task States

- `[ ]` - Todo
- `[x]` - Done
- `[-]` - Canceled

### Task Metadata

- **Project Tag**: `#project-name` (lowercase with hyphens)
- **Date Tag**: `@YYYY-MM-DD` or `@Today`
- **Person Tag**: `@PersonName`
- **Priority**: `!!` (high), `!` (medium), no marker (normal)

### Task Examples

```markdown
- [ ] Submit expense report @Today #things-to-do
- [ ] Review architecture doc @2025-12-15 #website-redesign
- [ ] Follow up with @John about deployment !! #mobile-app
- [ ] Learn React Hooks #things-to-learn
```

### Task Filing Rules

**From Daily Notes to Projects**:

1. **Tagged Tasks** (`#project-name`): Go to `[Name]/tasks.md`
2. **Untagged Tasks**: Go to `ThingsToDo/tasks.md` (Inbox)
3. **Learning Items** (no project tag): Go to `ThingsToLearn/tasks.md`
4. **Dated Tasks** (`@YYYY-MM-DD`): Go to "Scheduled" section
5. **Today Tasks** (`@Today`): Go to "Today" section
6. **Undated Tasks**: Go to "Inbox" section

---

## 📝 Meeting Notes Rules

### Meeting Note Structure

```markdown
## Meeting: [Title] - YYYY-MM-DD

**Attendees**: @Person1, @Person2, @Person3
**Project**: #project-name

### Agenda
- Topic 1
- Topic 2

### Discussion
[Notes]

### Decisions
- [ ] Decision 1 @Owner
- [ ] Decision 2 @Owner

### Action Items
- [ ] Task 1 @Person @YYYY-MM-DD #project-name
- [ ] Task 2 @Person @YYYY-MM-DD #project-name
```

### Meeting Filing Rules

**From Daily Notes**:
1. Extract meetings (headings with "Meeting:" or multiple `@Person` tags)
2. Copy to `[Name]/meetings.md` based on `#project-name` tag
3. Extract action items -> Copy to `[Name]/tasks.md`

---

## 🎯 Project Registration

**All projects must be registered in `System/catalog-project.md`.**

### Required Fields

- **Project Name**: Display name
- **Tag**: Unique `#tag` (lowercase-with-hyphens)
- **Description**: Brief purpose
- **Status**: Active, Pending, On Hold, Completed, Archived
- **Owner**: Team or Person name
- **Location**: Folder path

### Example Registration

```markdown
| Project | Tag | Description | Status | Owner | Location |
|---------|-----|-------------|--------|-------|----------|
| Website Redesign | `#website-redesign` | Company website refresh | Active | Design Team | `WebsiteRedesign/` |
```

---

## 🔧 Troubleshooting

### Issue: "No tasks found in Daily Note"
- **Check**: Are tasks using proper format `- [ ]`?
- **Check**: Are tags formatted correctly `#project-name`?

### Issue: "Daily Note not created"
- **Check**: Does `../../obsidian-templates/daily_note_template.md` exist?
- **Check**: Does `Daily/YYYY/` folder exist?

### Issue: "Tasks not filing to correct project"
- **Check**: Is project tag registered in `System/catalog-project.md`?
- **Check**: Does project folder exist?
- **Check**: Does `tasks.md` exist in project folder?

### Issue: "Digest shows no summary"
- **Check**: Is there a daily note for today? If not, system will use latest available.
- **Check**: Does the daily note have any content with tags?

---

## 📚 Best Practices

1. **Tag Consistently**: Use registered tags from `catalog-project.md`
2. **Date Important Tasks**: Add `@Today` or specific dates to critical items
3. **Review Daily**: Run "Digest my day" at end of each day to file content
4. **Clean Inbox**: Regularly assign projects to inbox items
5. **Update Catalog**: Keep project registry current
6. **Sync System**: Run "Update System" when templates change
7. **Use Meetings**: Meeting notes are automatically copied to projects
8. **Track Learning**: Tag educational content for future reference
9. **Daily Notes as Records**: Your daily notes are never modified, serving as permanent records

---

## 📌 Quick Reference

### Common Commands

```bash
"Start my day"           # Create daily note with tasks
"Digest my day"          # File content to projects + show summary
"Create project X"       # Set up new project structure
"Update System"          # Sync workflows from templates
```

### Tag Syntax

```markdown
#project-name            # Project tag (lowercase-with-hyphens)
@YYYY-MM-DD              # Date tag for scheduling
@Today                   # Today's date tag
@Person                  # Person tag for collaboration
```

### File Locations

```
System/AGENT.md          # This file (workflows)
System/catalog-project.md  # Project registry
Daily/YYYY/              # Daily notes by year
[Name]/                  # Project folders (under vault/personal)
../../obsidian-templates/  # System templates (clean, minimal)
```

---

## 🎓 Workflow Examples

### Daily Workflow

```bash
# Morning
"Start my day"
# → Creates daily note with rolled-over and critical tasks

# During Day
# → Add notes, tasks, meetings to daily note
# → Use tags: #things-to-do, @Today, @John

# Evening
"Digest my day"
# → Files everything to projects AND shows summary
# → Daily note remains unchanged as permanent record
```

### Project Workflow

```bash
# Create New Project
"Create project MobileApp"
# → Sets up full structure

# Daily Work
# → Add tasks in daily note: "- [ ] Design login screen #mobile-app"
# → Digest day to file to project

# Meetings
# → Add meeting notes with #mobile-app tag
# → Automatically copied to project meetings log
```

---

## 🔄 System Updates

To get latest workflows from templates:

1. **Pull Changes**: `git pull` (if using git)
2. **Update**: "Update System" (command)
3. **Review**: Check what was added to `System/AGENT.md`

---

**Last Updated**: 2025-12-16
**System Version**: 2.0
**Owner**: Team
