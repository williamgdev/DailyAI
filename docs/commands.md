# DailyAI Commands Reference

Complete reference for all DailyAI slash commands.

## Overview

DailyAI provides 4 main workflow commands:

| Command | Purpose | When to Use |
|---------|---------|------------|
| `/start-day` | Create daily note with tasks | Every morning |
| `/digest-day` | File tasks to projects | Every evening |
| `/create-project` | Create new project | When starting new work |
| `/work-on-project` | Load project context | When working on a project |

---

## /start-day

Create today's daily note with calendar events and task rollover.

### Usage

```bash
/start-day                    # Today's note
/start-day 2026-02-05        # Specific date
```

### What It Does

1. Creates a daily note from template
2. Fetches calendar events (if configured)
3. Rolls over incomplete tasks from yesterday
4. Scans all projects for critical/upcoming/undated tasks
5. Populates daily note with categorized tasks

### Output Sections

```markdown
## 📅 Calendar
[Today's calendar events]

## 🚀 Targeted Projects
[Projects mentioned in calendar]

## 🚨 Critical / Due Today
[Tasks with @Today tag]

## 📋 Rolled Over Tasks
[Incomplete tasks from yesterday]

## 📅 Upcoming Tasks
[Tasks due next 7 days]

## 📌 Undated Tasks
[Tasks without dates]
```

### Example

```
✅ Good Morning! Your Day is Ready

📅 Calendar:
   ✓ 3 events scheduled

🚀 Targeted Projects: 2
🚨 Critical Tasks: 4
📋 Rolled Over: 2
📅 Upcoming (7 days): 6
📌 Undated: 8

📍 Daily note: Daily/2026/2026-02-02.md
```

### Tips

- Run every morning for comprehensive day view
- Calendar is optional (works without it)
- Works with any date format for daily notes
- Non-destructive: only creates, never modifies

---

## /digest-day

File tagged content from daily note to project folders.

### Usage

```bash
/digest-day    # Digest latest daily note
```

### What It Does

1. Finds latest daily note
2. Checks if already digested (prevents duplicates)
3. Extracts tagged tasks (`#project-tag`)
4. Files untagged tasks to inbox
5. Copies meeting notes to projects
6. Creates digest log summary

### Task Filing

- Tasks with `#project-tag` → `Projects/ProjectName/tasks.md`
- Untagged tasks → `Projects/ThingsToDo/tasks.md` (Inbox)
- Meeting notes → `Projects/ProjectName/meetings.md`
- Learning items → `Projects/ThingsToLearn/tasks.md`

### Example Output

```
🌙 Day Digested Successfully!

📊 Summary:
✅ 3 tasks filed to Mobile App
✅ 2 tasks filed to Website Redesign
✅ 1 meeting note copied to Mobile App
✅ 4 inbox items added
✅ 2 learning items captured

📂 Files Updated:
✅ Projects/Mobile-App/tasks.md
✅ Projects/Website-Redesign/tasks.md
✅ Projects/ThingsToDo/tasks.md

📍 Digest log: Daily/2026/2026-02-02.digested.md
```

### Important Rules

- Daily notes are **never modified** (permanent records)
- Project tags are **removed** when filing (redundant in project folder)
- Date tags (`@date`) are **preserved**
- Person tags (`@person`) are **preserved**
- Safe to run multiple times (digest log prevents duplicates)

### Tips

- Run every evening to organize tasks
- Creates digest log for historical reference
- Look for warnings if some projects missing
- Check digest log for what was processed

---

## /create-project

Create a new project with full folder structure.

### Usage

```bash
/create-project "Mobile App"
/create-project "Website Redesign"
/create-project "Q1 Planning"
```

### What It Does

1. Creates project folder: `Projects/ProjectName/`
2. Creates subdirectories: `discovery/`, `execution/`
3. Creates project files:
   - `AGENT.md` - AI instructions
   - `project.md` - Overview and status
   - `tasks.md` - Task list
   - `meetings.md` - Meeting log
   - `team_members.md` - Team tracking
   - `notes.md` - Research and learnings
4. Registers project in `System/catalog-project.md`
5. Generates project tag (e.g., `#mobile-app`)

### Example Output

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

Next steps:
1. Edit project.md with project details
2. Add team members to team_members.md
3. Define initial tasks in tasks.md
4. Use /work-on-project to load context
```

### Naming Conventions

- **Project Name**: Use full descriptive name
  - Good: "Mobile App", "Website Redesign", "Q2 Planning"
  - Avoid: "Proj1", "TODO", "XYZ"

- **Project Tag** (auto-generated): lowercase-with-hyphens
  - "Mobile App" → `#mobile-app`
  - "Website Redesign" → `#website-redesign`

### Tips

- Create projects for epics and initiatives
- Edit `project.md` right after creating
- Use project tag in daily notes: `#project-tag`
- Each project is independent

---

## /work-on-project

Load project context and display comprehensive status.

### Usage

```bash
/work-on-project "Mobile App"
/work-on-project "Website Redesign"
```

### What It Does

1. Finds project folder
2. Loads `AGENT.md` for AI context
3. Displays project overview
4. Shows critical tasks (due today)
5. Shows in-progress tasks
6. Lists recent meetings
7. Shows team status
8. Highlights blockers/risks
9. Activates project-specific rules

### Example Output

```
💼 Working on: Mobile App
📁 Location: Projects/Mobile-App/
🏷️ Tag: #mobile-app
📋 Status: Active (Execution Phase)

🎯 Project Overview:
- Redesigning mobile app UI/UX
- Target: Q2 2026 launch
- Current Sprint: Authentication & Onboarding

🚨 Critical Tasks (3):
- [ ] Complete login screen @Today
- [ ] Review auth flow @2026-02-03
- [ ] User testing prep @2026-02-05

📝 In Progress (2):
- [ ] Design system documentation
- [ ] Accessibility audit

📅 Recent Meetings (3):
- 2026-01-30: Design Review
- 2026-01-28: Sprint Planning

👥 Team: 5 active members

⚠️ Blockers: Waiting on API specs

✅ Project context loaded. AGENT.md rules active.
```

### Context Persistence

Once a project is loaded:
- AGENT.md rules remain active
- Project tag is known for daily notes
- Team context is loaded
- Stay active until:
  - Different project loaded
  - New daily note started
  - Context explicitly cleared

### Tips

- Load project to see complete status
- AGENT.md guides how to work on project
- Critical tasks show what needs attention
- Blockers section highlights impediments
- Team section shows who's involved

---

## Task Tag Reference

### Date Tags

Use in daily notes and task descriptions:

```markdown
- [ ] Task @Today                 # Due today
- [ ] Task @2026-02-05          # Specific date
- [ ] Task @Next week           # General timing
```

### Project Tags

Use to route content to projects:

```markdown
- [ ] Task #mobile-app          # Goes to Mobile App project
- [ ] Task #website-redesign    # Goes to Website Redesign
- [ ] Task #things-to-learn     # Learning item
- [ ] Task                      # No tag = Inbox
```

### Person Tags

Use for collaboration tracking:

```markdown
- [ ] Task @Sarah               # Assign to Sarah
- [ ] Task @Sarah @Mike         # Multiple people
- [ ] Meeting with @Alice       # Person mention
```

### Task Status

Use checkboxes in tasks.md:

```markdown
- [ ] Not started
- [>] In progress (custom marker)
- [x] Completed
```

---

## Quick Reference

| Task | Command |
|------|---------|
| Start your day | `/start-day` |
| End your day | `/digest-day` |
| Create project | `/create-project Name` |
| Work on project | `/work-on-project Name` |
| View this guide | See this file |

---

## Examples

### Daily Workflow

**Morning:**
```
/start-day
→ Creates daily note with calendar and tasks
```

**During day:**
```
Add tasks to daily note with #project-tag and @date tags
```

**Evening:**
```
/digest-day
→ Files tasks to projects, creates digest log
```

### Project Workflow

**Start new project:**
```
/create-project Mobile App
→ Creates project structure
```

**Edit project:**
Edit `Projects/Mobile App/AGENT.md` with project details

**Work on project:**
```
/work-on-project Mobile App
→ Loads context, shows status
```

**Add tasks:**
Add to daily note with `#mobile-app` tag
```
/digest-day
→ Files tasks to project
```

---

## Troubleshooting

See [Troubleshooting Guide](troubleshooting.md) for common issues.

---

**Need help?** Check [Installation Guide](installation.md) or [Troubleshooting Guide](troubleshooting.md)
