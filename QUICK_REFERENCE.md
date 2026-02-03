# DailyAI - Quick Reference

**Agent Skills Format** - All workflows executed by AI reading SKILL.md

## 🎯 Commands

| Say to Claude | What It Does |
|--------------|--------------|
| `start my day` | Creates daily note + calendar + tasks |
| `digest my day` | Files tasks to projects + creates log |
| `create project [Name]` | Sets up new project structure |
| `work on [ProjectName]` | Loads project context + shows status |
| `update system` | Syncs workflows from templates |
| `show me today's tasks` | Lists critical and upcoming tasks |

## 🏷️ Tags

| Tag Type | Format | Example | Purpose |
|----------|--------|---------|---------|
| Project | `#project-name` | `#mobile-app` | Routes to project |
| Date | `@YYYY-MM-DD` | `@2026-01-27` | Schedules task |
| Today | `@Today` | `@Today` | Marks as critical |
| Person | `@Name` | `@Sarah` | Tracks collaboration |

## 📂 Daily Note Structure

```markdown
# YYYY-MM-DD

## 📅 Calendar
(Calendar events)

## 🚀 Targeted Projects
(Projects from calendar + catalog)

## 🌅 Morning Planning

### 🚨 Critical / Due Today
(Tasks with @Today or @YYYY-MM-DD)

### 📋 Rolled Over Tasks
(Incomplete from yesterday)

### 📅 Upcoming Tasks
(Future dated tasks)

### 📌 Undated Tasks
(Tasks without dates)

## 📝 Notes / Thoughts

## 📌 Action Items Captured Today
(Add tasks here with #tags)

## 🎙️ Meeting Notes
```

## 🔄 Workflow Flow

### Morning
```
1. Say "start my day"
2. AI creates daily note
3. Calendar events fetched
4. Tasks populated from projects
5. Note ready for action
```

### During Day
```
1. Add tasks with #project-tags
2. Capture meeting notes
3. Take general notes
4. Track time blocks
```

### Evening
```
1. Say "digest my day"
2. AI extracts tagged content
3. Files to project folders
4. Creates digest log
5. Daily note preserved
```

## 📁 Project Structure

```
Projects/[ProjectName]/
├── AGENT.md           # AI instructions
├── project.md         # Overview
├── tasks.md           # Task list
├── meetings.md        # Meeting log
├── team_members.md    # Team tracking
└── notes.md           # Research/learnings
```

## 🎨 Task Examples

```markdown
# Critical task for today
- [ ] Submit report @Today #website-redesign

# Scheduled task
- [ ] Meeting prep @2026-01-27 #mobile-app

# Task with person
- [ ] Follow up with @Sarah #api-integration

# Learning item
- [ ] Study React Hooks #things-to-learn

# Inbox item (untagged)
- [ ] Buy groceries
```

## 📍 Key Locations

| Path | Contents |
|------|----------|
| `personal/System/AGENT.md` | System workflows |
| `personal/System/catalog-project.md` | Project registry |
| `personal/Daily/YYYY/` | Daily notes |
| `personal/Projects/` | All projects |
| `obsidian-templates/` | Source templates |

## 🚨 Troubleshooting

| Problem | Solution |
|---------|----------|
| Note not created | Check template exists |
| Calendar not working | Verify calendar integration |
| Tasks not filing | Check project tag in catalog |
| Already digested | Look for `.digested.md` file |

## 💡 Pro Tips

- 🌅 Run "start my day" first thing every morning
- 🌙 Run "digest my day" before signing off
- 🏷️ Use tags consistently for auto-routing
- 📅 Add dates to important tasks for visibility
- 📁 Create projects for epics and initiatives
- 🔄 Run "update system" after template changes
- 📝 Daily notes are permanent records - never edited

## 🎯 Remember

**Daily notes → Digest → Project folders → Permanent record**

---

**Version**: 1.0 | **Created**: 2026-01-26 | **Status**: ✅ Active
