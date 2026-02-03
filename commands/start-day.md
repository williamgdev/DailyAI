---
name: start-day
description: Create today's daily note with calendar events and task rollover
arguments:
  - "[date]"
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# Start My Day Command

Create today's daily note with calendar integration, task rollover, and project scanning.

## Workflow

### 1. Validate Environment
Check that VAULT_PATH is set. If not, show error with setup instructions.

```bash
if [ -z "$VAULT_PATH" ]; then
  echo "❌ ERROR: VAULT_PATH environment variable not set"
  echo ""
  echo "Please set VAULT_PATH to your Obsidian vault location:"
  echo "  export VAULT_PATH=\"/path/to/your/obsidian/vault\""
  exit 1
fi
```

### 2. Set Up Date Variables
Get today's date or use provided date argument:

```bash
TODAY=${1:-$(date +%Y-%m-%d)}
YEAR=$(date +%Y)
DAILY_NOTE="$VAULT_PATH/Daily/$YEAR/$TODAY.md"
YESTERDAY=$(date -d "$TODAY -1 day" +%Y-%m-%d 2>/dev/null || date -v-1d -f "%Y-%m-%d" "$TODAY" +%Y-%m-%d)
```

### 3. Check if Daily Note Already Exists
If `$DAILY_NOTE` already exists, show message and exit.

```bash
if [ -f "$DAILY_NOTE" ]; then
    echo "📝 Daily note already exists for $TODAY"
    echo "   Location: Daily/$YEAR/$TODAY.md"
    exit 0
fi
```

### 4. Create Daily Folder if Missing
Ensure the Daily/$YEAR folder exists:

```bash
mkdir -p "$VAULT_PATH/Daily/$YEAR"
```

### 5. Create Daily Note from Template
Copy the daily note template to create today's note:

```bash
if [ ! -f "$VAULT_PATH/templates/DAILY_NOTE_TEMPLATE.md" ]; then
    echo "❌ ERROR: Daily note template not found"
    echo "   Expected: $VAULT_PATH/templates/DAILY_NOTE_TEMPLATE.md"
    echo "   Run: /plugin install dailyai && ./scripts/install.sh"
    exit 1
fi

cp "$VAULT_PATH/templates/DAILY_NOTE_TEMPLATE.md" "$DAILY_NOTE"
```

### 6. Try to Fetch Calendar Events (Optional)
Attempt to fetch calendar events using MCP server. This is optional - if calendar is unavailable, continue without it.

**If GOOGLE_CALENDAR_CREDENTIALS is set:**
- Call the MCP Google Calendar server
- Parse returned events
- Extract time and summary

**If ICAL_CALENDAR_URL is set:**
- Call the MCP iCal server
- Parse returned events
- Extract time and summary

**If both unavailable:**
- Skip calendar section gracefully
- Continue with other sections

### 7. Populate Calendar Section (if events fetched)
Format calendar events as markdown list and insert into the Calendar section:

```markdown
## 📅 Calendar

- 9:00 AM - 10:00 AM: Team Standup
- 11:00 AM - 12:00 PM: Sprint Planning
- 2:00 PM - 3:00 PM: 1:1 with Manager
```

### 8. Extract Targeted Projects (from calendar)
Parse event titles for project tags (e.g., `#mobile-app` or `Mobile App`):

```markdown
## 🚀 Targeted Projects

- #mobile-app
- #website-redesign
```

### 9. Find Yesterday's Daily Note
Look for `Daily/$YEAR/$YESTERDAY.md`:

```bash
YESTERDAY_NOTE="$VAULT_PATH/Daily/$YEAR/$YESTERDAY.md"
if [ -f "$YESTERDAY_NOTE" ]; then
    # Extract incomplete tasks
fi
```

### 10. Extract Incomplete Tasks from Yesterday
Use grep to find uncompleted tasks (`- [ ]` pattern):

```bash
YESTERDAY_TASKS=$(grep "^\- \[ \]" "$YESTERDAY_NOTE" 2>/dev/null | head -20)
```

Only include tasks that aren't already in project folders (check project tasks.md files).

### 11. Populate Rolled Over Tasks Section
If incomplete tasks found, add to "Rolled Over Tasks" section:

```markdown
## 📋 Rolled Over Tasks

- [ ] Complete report analysis
- [ ] Review pull request #42
- [ ] Follow up with Sarah on design feedback
```

### 12. Scan All Project Folders for Critical Tasks
Search all `$VAULT_PATH/Projects/*/tasks.md` files for:
- Tasks with `@Today` tag
- Tasks with today's date `@YYYY-MM-DD`

Extract these with their project tags intact.

### 13. Populate Critical / Due Today Section

```markdown
## 🚨 Critical / Due Today

- [ ] Submit quarterly report @Today #finance-planning
- [ ] Review authentication flow @2026-02-02 #mobile-app
- [ ] Finalize budget approval @Today #admin
```

### 14. Scan for Upcoming Tasks
Search all project tasks for future date tags (`@YYYY-MM-DD`).

Group by date, show next 5-7 days ahead.

### 15. Populate Upcoming Tasks Section

```markdown
## 📅 Upcoming Tasks

**2026-02-03:**
- [ ] Client call with marketing team #website-redesign
- [ ] Design review meeting #mobile-app

**2026-02-04:**
- [ ] Submit final proposal #new-client-project

**2026-02-05:**
- [ ] Team retrospective #team-sync
```

### 16. Scan for Undated Tasks
Search all project tasks that don't have date tags.

Extract category by project.

### 17. Populate Undated Tasks Section

```markdown
## 📌 Undated Tasks

**#mobile-app:**
- [ ] Research animation libraries
- [ ] Accessibility audit for login screen
- [ ] Create design system documentation

**#website-redesign:**
- [ ] Update typography system
- [ ] Optimize image assets

**#things-to-learn:**
- [ ] Machine Learning fundamentals
- [ ] Advanced React patterns
```

### 18. Show Summary Output
Display user-friendly summary:

```
✅ Good Morning! Your Day is Ready

📅 Calendar:
   ✓ 3 events scheduled

🚀 Targeted Projects: 2
🚨 Critical Tasks: 4
📋 Rolled Over: 2
📅 Upcoming (next 7 days): 6
📌 Undated: 8

📍 Daily note created: Daily/2026/2026-02-02.md
```

## Error Handling

- **VAULT_PATH not set**: Show clear error with export command
- **Template missing**: Show error with setup instructions
- **Daily folder doesn't exist**: Create it automatically
- **Daily note already exists**: Show info message, don't overwrite
- **Calendar unavailable**: Skip calendar section, continue with tasks
- **No projects found**: Continue, show message
- **Yesterday's note not found**: Skip task rollover, continue
- **Invalid date argument**: Show error with correct format

## Example Usage

```bash
/start-day                    # Creates note for today
/start-day 2026-02-05        # Creates note for specific date
```

## Notes

- Non-destructive: Only creates new files, never modifies existing notes
- Calendar is optional: Works perfectly without calendar integration
- Tags are preserved: All original tags (@date, @person) are maintained
- Project context: Each task shows which project it belongs to
