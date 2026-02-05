# Obsidian Workflow Skill - Quick Reference

## 🎯 Commands

| Say to Your AI CLI      | What It Does                          |
| ----------------------- | ------------------------------------- |
| `start my day`          | Creates daily note + tasks            |
| `digest my day`         | Files tasks to projects + creates log |
| `create project [Name]` | Sets up new project structure         |
| `update system`         | Syncs workflows from templates        |
| `show me today's tasks` | Lists critical and upcoming tasks     |

## 🏷️ Tags

| Tag Type | Format | Example | Purpose |
|----------|--------|---------|---------|
| Project | `#project-name` | `#pr-reviews` | Routes to project |
| Date | `@YYYY-MM-DD` | `@2026-01-27` | Schedules task |
| Today | `@Today` | `@Today` | Marks as critical |
| Person | `@Name` | `@Andrii` | Tracks collaboration |

## 📂 Daily Note Structure

```markdown
# YYYY-MM-DD

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
3. Tasks populated from projects
4. Note ready for action
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
personal/[ProjectName]/
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
- [ ] Submit report @Today #release-validation

# Scheduled task
- [ ] Meeting prep @2026-01-27 #pr-reviews

# Task with person
- [ ] Follow up with @Andrii #giftcard-quick-scan-CECPRO-30512

# Learning item
- [ ] Study React Hooks #things-to-learn

# Inbox item (untagged)
- [ ] Buy groceries
```

## 🔧 Helper Scripts

| Script | Path | Purpose |
|--------|------|---------|
| `start-day.sh` | `skills/obsidian-workflow/scripts/` | Creates daily note |
| `digest-day.sh` | `skills/obsidian-workflow/scripts/` | Finds latest note |
## 📍 Key Locations

| Path | Contents |
|------|----------|
| `personal/System/AGENT.md` | System workflows |
| `personal/System/catalog-project.md` | Project registry |
| `personal/Daily/YYYY/` | Daily notes |
| `personal/[ProjectName]/` | Your projects (created via "create project") |
| `obsidian-templates/` | Source templates |

## 🚨 Troubleshooting

| Problem | Solution |
|---------|----------|
| Note not created | Check template exists |
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
