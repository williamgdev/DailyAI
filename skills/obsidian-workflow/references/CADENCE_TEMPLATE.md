---
# Project Cadence Configuration
project: {{Project Name}}
tag: #{{tag}}
enabled: true
last_updated: {{YYYY-MM-DD}}
---

## ⏰ Time-Based Recurring Tasks

### Every [Day]
- [ ] Task description
  - Priority: [High/Medium/Low]
  - Assignee: @[Name]
  - Notes: Additional context

### First [Day] of Month
- [ ] Task description
  - Priority: [High/Medium/Low]
  - Assignee: @[Name]
  - Notes: Additional context

## 🔄 Sprint-Based Recurring Tasks

### Sprint Start (Reference: YYYY-MM-DD, Every N weeks, Day)
- [ ] Task description
  - Priority: [High/Medium/Low]
  - Assignee: @[Name]
  - Notes: Additional context

### Sprint End (Reference: YYYY-MM-DD, Every N weeks, Day)
- [ ] Task description
  - Priority: [High/Medium/Low]
  - Assignee: @[Name]
  - Notes: Additional context

## 🛠️ Configuration

recurring_rules:
  - id: {{rule-id}}
    schedule: "every [day]"
    task_template: "Task description"
    enabled: true

---

## 📖 Usage Notes

**For AI Agents:**
- This file is read during "Start My Day" workflow
- Tasks are auto-generated based on matching rules
- Rules are evaluated against today's date

**For Humans:**
- Edit this file to add/remove recurring tasks for this project
- Set `enabled: false` to temporarily disable a rule
- Use lowercase day names: monday, tuesday, wednesday, thursday, friday, saturday, sunday

**Examples:**
- Simple time-based: Every Monday, Every Friday
- Sprint-based: Sprint Start, Sprint End with reference dates
