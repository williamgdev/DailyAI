---
name: digest-day
description: File tagged content from latest daily note to project folders
arguments: []
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# Digest My Day Command

Extract and file tagged content from the latest daily note to project folders, creating a comprehensive digest log.

## Workflow

### 1. Validate Environment
Check that VAULT_PATH is set:

```bash
if [ -z "$VAULT_PATH" ]; then
  echo "❌ ERROR: VAULT_PATH environment variable not set"
  exit 1
fi
```

### 2. Find Latest Daily Note
Search for the most recent daily note (excluding `.digested.md` files):

```bash
LATEST_NOTE=$(find "$VAULT_PATH/Daily" -name "*.md" ! -name "*.digested.md" -type f 2>/dev/null | sort -r | head -1)

if [ -z "$LATEST_NOTE" ]; then
    echo "❌ No daily notes found"
    echo "   Run: /start-day"
    exit 1
fi

NOTE_DATE=$(basename "$LATEST_NOTE" .md)
YEAR=$(echo "$NOTE_DATE" | cut -d'-' -f1)
```

### 3. Check if Already Digested
Verify that `.digested.md` file doesn't exist for this date:

```bash
DIGEST_FILE="$VAULT_PATH/Daily/$YEAR/$NOTE_DATE.digested.md"

if [ -f "$DIGEST_FILE" ]; then
    DIGEST_DATE=$(head -5 "$DIGEST_FILE" | grep "Digested on:" | cut -d':' -f2 | xargs)
    echo "⏭️  Already digested on: $DIGEST_DATE"
    echo "   Log: Daily/$YEAR/$NOTE_DATE.digested.md"
    exit 0
fi
```

### 4. Load Project Catalog
Read `System/catalog-project.md` to get list of project tags and folders:

```bash
CATALOG="$VAULT_PATH/System/catalog-project.md"

if [ ! -f "$CATALOG" ]; then
    echo "❌ ERROR: Project catalog not found"
    echo "   Expected: System/catalog-project.md"
    exit 1
fi
```

Extract project mappings (tag → folder name).

### 5. Extract Content from Daily Note
Read the daily note and extract:

**Tagged Tasks** (format: `- [ ] Task text #project-tag`):
- Match lines with `- [ ]` or `- [x]`
- Extract `#project-name` tags
- Store task text and metadata

**Meeting Notes** (sections with "Meeting:" or multiple `@Person` tags):
- Extract entire meeting section
- Preserve formatting and details
- Link to projects if mentioned

**Untagged Tasks** (format: `- [ ] Task text` without project tag):
- Extract all task lines without tags
- These go to ThingsToDo (inbox)

**Learning Items** (tasks with `#things-to-learn` tag):
- Extract learning-related content
- File to ThingsToLearn project

**Notes** (content under `## Notes` or with project tags):
- Extract note sections
- Match to projects

**Team Interactions** (count `@PersonName` mentions):
- Find all `@Person` tags
- Track interaction counts

### 6. File Tagged Tasks to Projects
For each tagged task:

1. Extract project tag (e.g., `#mobile-app`)
2. Find corresponding project folder (e.g., `Projects/Mobile-App/`)
3. Append task to `Projects/[Name]/tasks.md`
4. Remove project tag from task (keep date/person tags)

Example:
```
Input:  - [ ] Complete login screen @Today #mobile-app
Output: - [ ] Complete login screen @Today
        (appended to Projects/Mobile-App/tasks.md)
```

### 7. File Untagged Tasks to Inbox
Append untagged tasks to `Projects/ThingsToDo/tasks.md` under Inbox section:

```markdown
## 📥 Inbox

- [ ] Task without project
- [ ] Another loose task
```

### 8. File Learning Items
Append learning-tagged tasks to `Projects/ThingsToLearn/tasks.md`:

```markdown
## 📚 Learning Queue

- [ ] Study React Hooks patterns
- [ ] Machine Learning fundamentals
```

### 9. Copy Meeting Notes to Projects
If meeting notes exist in daily note:

1. Extract meeting section (identified by "Meeting:" or multiple attendees)
2. Find associated project (if mentioned)
3. Append to `Projects/[Name]/meetings.md` with date header

Example:
```markdown
## 2026-02-02 - Design Review

Attendees: @Sarah, @Mike, @Jessica
Key Points:
- Finalized mobile app mockups
- Next iteration due 2026-02-09

Action Items:
- [ ] Review feedback with team
- [ ] Update design system
```

### 10. Copy Notes to Projects
Extract notes sections and append to `Projects/[Name]/notes.md`:

1. Identify project association
2. Preserve formatting
3. Add date header

### 11. Update Team Interaction Counts
For each `@PersonName` mention:

1. Find associated project
2. Update `Projects/[Name]/team_members.md`
3. Increment interaction count

Format:
```markdown
| Name | Interactions | Last Updated |
|------|-------------|--------------|
| Sarah | 5 | 2026-02-02 |
| Mike | 3 | 2026-02-01 |
```

### 12. Create Digest Log
Create `$VAULT_PATH/Daily/$YEAR/$NOTE_DATE.digested.md` with summary:

```markdown
# Digest Log - 2026-02-02

**Digested on:** 2026-02-02 14:35

## 📊 Summary

### Tasks Filed
- 3 tasks → Mobile App
- 2 tasks → Website Redesign
- 1 task → Finance Planning
- 4 tasks → Inbox (untagged)

### Learning Captured
- 2 items → Things to Learn

### Meetings Logged
- 1 meeting → Mobile App (Design Review)

### Team Interactions
- Sarah: 2 mentions
- Mike: 1 mention
- Jessica: 1 mention

## 📂 Files Updated

✅ Projects/Mobile-App/tasks.md
✅ Projects/Mobile-App/meetings.md
✅ Projects/Website-Redesign/tasks.md
✅ Projects/Finance-Planning/tasks.md
✅ Projects/ThingsToDo/tasks.md
✅ Projects/ThingsToLearn/tasks.md

## ✨ Processing Complete

All content has been filed and organized. Daily note remains unchanged as permanent record.
```

### 13. Show Summary to User
Display user-friendly digest summary:

```
🌙 Day Digested Successfully!

📊 Summary:
✅ 3 tasks filed to Mobile App
✅ 2 tasks filed to Website Redesign
✅ 1 meeting note copied to Mobile App
✅ 4 inbox items added
✅ 2 learning items captured
✅ Team interactions updated

📂 Files Updated:
✅ Projects/Mobile-App/tasks.md
✅ Projects/Website-Redesign/tasks.md
✅ Projects/Finance-Planning/tasks.md
✅ Projects/ThingsToDo/tasks.md
✅ Projects/ThingsToLearn/tasks.md

📍 Digest log: Daily/2026/2026-02-02.digested.md
```

## Error Handling

- **No daily notes found**: Show error with /start-day instruction
- **Already digested**: Show digest date, prevent re-processing
- **Catalog missing**: Show error with setup instructions
- **Project folder missing**: Show warning, skip that task
- **Tasks.md not found**: Create it if project folder exists
- **Empty daily note**: Show message, create minimal digest log
- **Invalid tag format**: Skip malformed tags, log warning

## Important Rules

1. **Daily notes are NEVER modified**
   - Read-only operation
   - Permanent records
   - No deletions or edits

2. **Non-destructive filing**
   - Content copied, not moved
   - Full task preserved
   - Tags maintained (except project tag removed)

3. **One digest per day**
   - `.digested.md` prevents duplicate processing
   - Safe to run multiple times
   - No duplicate entries

4. **Clean output**
   - No source links added
   - No "from Daily/..." annotations
   - Just the content, organized by project

## Example Usage

```bash
/digest-day    # Files latest daily note to projects
```

## Notes

- Non-destructive: Daily notes remain unchanged
- Idempotent: Safe to run multiple times (digest log prevents duplicates)
- Flexible: Works with any project structure in catalog
- Graceful: Continues even if some projects missing
