# Troubleshooting Guide

Common issues and solutions for DailyAI.

## Installation Issues

### VAULT_PATH not set
**Error:** `❌ ERROR: VAULT_PATH environment variable not set`

**Solution:**
```bash
export VAULT_PATH="/path/to/your/obsidian/vault"
# Add to ~/.zshrc or ~/.bashrc for permanent setup
source ~/.zshrc
```

### Plugin won't install
**Solution:**
- Check internet connection
- Try: `/plugin validate`
- Try: `/plugin install dailyai --verbose`
- Check GitHub access

### Scripts not executable
**Solution:**
```bash
chmod +x ~/.claude/plugins/dailyai/scripts/*.sh
chmod +x ~/.claude/plugins/dailyai/calendar/*.py
```

## Command Issues

### /start-day not creating notes
**Check:**
- VAULT_PATH exists: `ls $VAULT_PATH`
- Daily folder exists: `ls $VAULT_PATH/Daily/$(date +%Y)/`
- Template exists: `ls $VAULT_PATH/templates/`

**Solution:**
```bash
mkdir -p "$VAULT_PATH/Daily/$(date +%Y)"
./scripts/install.sh  # Re-run setup
```

### /digest-day shows "Already digested"
**This is normal!** It means you already digested that day's note.

**If you want to re-digest:**
```bash
rm "$VAULT_PATH/Daily/YYYY/YYYY-MM-DD.digested.md"
/digest-day
```

### /create-project fails
**Check:**
- Projects folder exists: `ls $VAULT_PATH/Projects/`
- Project doesn't already exist
- Project name is valid (no special characters)

**Solution:**
```bash
mkdir -p "$VAULT_PATH/Projects"
/create-project YourProjectName
```

### /work-on-project shows "Project not found"
**Check:**
- Exact spelling of project name
- Project folder exists: `ls "$VAULT_PATH/Projects/"`
- No extra spaces in name

**Solution:**
```bash
ls $VAULT_PATH/Projects/
# Use exact folder name in command
```

## Calendar Issues

### Google Calendar not working
**Check:**
- Environment variable set: `echo $GOOGLE_CALENDAR_CREDENTIALS`
- File exists: `ls $GOOGLE_CALENDAR_CREDENTIALS`
- Python installed: `python3 --version`

**Solution:**
1. Check [Calendar Setup Guide](calendar-setup.md)
2. Verify credentials.json is valid
3. Try removing token: `rm ~/.config/dailyai/google_calendar_token.json`
4. Run `/start-day` again to re-authenticate

### iCal/CalDAV not fetching
**Check:**
- Environment variable set: `echo $ICAL_CALENDAR_URL`
- URL is valid: Try pasting in browser
- URL points to .ics file

**Solution:**
1. Verify URL is correct
2. Test with `curl $ICAL_CALENDAR_URL`
3. Check [Calendar Setup Guide](calendar-setup.md)

### Calendar events not showing
**Check:**
- Calendar configured (see above)
- Events exist on the calendar
- Events are on today's date
- Events aren't marked as "private"

**Solution:**
- Verify events in Obsidian vault directly
- Try a different date: `/start-day 2026-02-05`
- Check calendar settings (visibility, sharing)

### "Calendar dependencies not installed"
**Solution:**
```bash
pip install -r ~/.claude/plugins/dailyai/calendar/requirements.txt
```

Or during setup:
```bash
~/.claude/plugins/dailyai/scripts/install.sh
```

## Task Filing Issues

### Tasks not filing to project
**Check:**
- Project tag is correct: `#project-name`
- Project folder exists
- Project in catalog: `System/catalog-project.md`
- `tasks.md` exists in project folder

**Solution:**
1. Verify tag matches project name exactly
2. Check project exists: `/work-on-project ProjectName`
3. Manually add `tasks.md` if missing
4. Check `System/catalog-project.md` has project listed

### Untagged tasks not going to inbox
**Check:**
- `Projects/ThingsToDo/` folder exists
- `projects/ThingsToDo/tasks.md` exists

**Solution:**
```bash
mkdir -p "$VAULT_PATH/Projects/ThingsToDo"
touch "$VAULT_PATH/Projects/ThingsToDo/tasks.md"
```

### Tags not parsing correctly
**Check:**
- Tag format: `#lowercase-with-hyphens`
- No spaces in tag
- Tag at end of task line

**Bad:** `#Mobile App` (has space, uppercase)
**Good:** `#mobile-app`

## Performance Issues

### Commands running slow
**Solution:**
- Close other programs
- Check disk space: `df -h`
- Check Python process: `ps aux | grep python`

### Vault too large
**Solution:**
- Archive old daily notes to a separate folder
- Archive completed projects
- Check for duplicate files

## Testing Your Setup

**Quick test:**
```bash
# 1. Check environment
echo "VAULT_PATH=$VAULT_PATH"
ls $VAULT_PATH

# 2. Try creating daily note
/start-day

# 3. Check it was created
ls "$VAULT_PATH/Daily/$(date +%Y)/"

# 4. Try creating project
/create-project TestProject

# 5. Check it exists
ls "$VAULT_PATH/Projects/TestProject/"

# 6. Load project
/work-on-project TestProject

# 7. Try digest
/digest-day
```

All should show ✅ without errors.

## Still Having Issues?

1. Check [Installation Guide](installation.md)
2. Check [Commands Reference](commands.md)
3. Verify your vault structure matches expected layout
4. Check that all templates exist
5. Review error messages carefully

**Error Messages:**
- Look at the full error text
- Check file paths mentioned
- Try the suggested solutions

## Getting Help

- Report issues on GitHub
- Include error message and steps to reproduce
- Include your macOS/Linux version
- Include Python version (if relevant)
- Include Claude Code version

---

Most issues are easily solved by:
1. Verifying VAULT_PATH is set
2. Running `./scripts/install.sh` again
3. Checking folder/file permissions
4. Clearing and re-running the command

You've got this! 🚀
