# Obsidian Workflow - Wibey Skill

AI-driven workflow automation for Obsidian using Wibey CLI.

## 🚀 Quick Start

After installation, use natural language with Wibey:

```bash
# Morning workflow
wibey -p "start my day"

# Evening workflow
wibey -p "digest my day"

# Project management
wibey -p "create project Mobile App Redesign"
```

## 📋 Available Commands

### Natural Language (Recommended)

```bash
# Start day
wibey -p "start my day"
wibey -p "good morning, let's get started"

# Digest day
wibey -p "digest my day"
wibey -p "end of day, file everything"

# Quick checks
wibey -p "show me today's tasks"
```

### Direct Scripts (from repo root)

```bash
# Start day (manual)
./skills/obsidian-workflow/scripts/start-day.sh

# Digest day (manual)
./skills/obsidian-workflow/scripts/digest-day.sh

# Run tests
./skills/obsidian-workflow/scripts/run-tests.sh
```

## 🏷️ Tag System

### Project Tags
Route content to projects:
```markdown
- [ ] Review PR #431 #pr-reviews
- [ ] Fix bug #release-validation
```

### Date Tags
Schedule tasks:
```markdown
- [ ] Submit report @Today
- [ ] Meeting prep @2026-01-27
```

### Person Tags
Track collaborations:
```markdown
- [ ] Follow up with @Andrii
- [ ] Review with @TeamLead
```

## 🔧 Configuration

### Vault Path

Default vault path is set in scripts. To change:

```bash
# Edit scripts (in project)
vim skills/obsidian-workflow/scripts/*.sh

# Update VAULT_PATH variable
VAULT_PATH="/your/vault/path"
```

## 🧪 Testing

```bash
# Run full test suite (from repo root)
./skills/obsidian-workflow/scripts/run-tests.sh

# Should see: ✅ All tests passed (8/8)
```

## 🆘 Troubleshooting

### Daily Note Not Created

```bash
# Check vault structure
ls -la ~/vault/System/
ls -la ~/vault/Daily/2026/

# Verify template exists
ls -la ~/vault-templates/daily_note_template.md
```

### Tasks Not Filing

```bash
# Check project exists in catalog
cat ~/vault/System/catalog-project.md

# Verify project folder
ls -la ~/vault/

# Check tasks.md exists
ls -la ~/vault/*/tasks.md
```

## 📚 Documentation

- **QUICK_REFERENCE.md** - One-page cheat sheet
- **SKILL.md** - Complete skill definition
- **Full docs**: See project documentation/ folder

## 🎯 Daily Workflow Example

### Morning (9:00 AM)
```bash
wibey -p "start my day"
```

Creates daily note with:
- 🚨 Critical tasks due today
- 📋 Rolled over tasks from yesterday
- 📌 Undated tasks from all projects

### During Day
- Add notes and tasks to daily note
- Use tags: `#project-name`, `@Today`, `@PersonName`
- Capture meeting notes with project tags

### Evening (5:00 PM)
```bash
wibey -p "digest my day"
```

Automatically:
- ✅ Files tagged tasks to project folders
- ✅ Copies meeting notes to projects
- ✅ Creates digest log with summary
- ✅ Preserves daily note as permanent record

## 💡 Tips

- Use consistent project tags (see catalog-project.md)
- Add `@Today` to tasks you want to do today
- Tag meetings with project names for automatic filing
- Run digest at end of day to keep projects organized
- Review undated tasks weekly and add dates

## 🔗 Dependencies

### Required
- Wibey CLI installed and configured
- Obsidian vault with proper structure

---

**Version**: 1.0
**Last Updated**: 2026-01-26
**Full Documentation**: ../documentation/
