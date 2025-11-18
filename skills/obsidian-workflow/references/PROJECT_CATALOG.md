# Project Catalog

**Purpose**: Central registry for all projects, tags, and portfolio status.  
**Single Source of Truth**: All project tags must be registered here.

---

## 🏢 Portfolio

| Project                          | Tag                                 | Description                                 | Status | Owner | Location                                                |
| -------------------------------- | ----------------------------------- | ------------------------------------------- | ------ | ----- | ------------------------------------------------------- |
| **Things To Do**                 | `#things-to-do`                     | Loose tasks & ideas (inbox)                 | Active | Self  | `ThingsToDo/`                                           |
| **Test Accounts**                | `#test-accounts`                    | Test credentials and notes                  | Active | Self  | `TestAccounts/`                                         |
| **Error Messaging Improvements** | `#error-messaging-CECPRO-30319`     | CECPRO-30319 Epic                           | Active | Team  | `Error Messaging Improvements - CECPRO-30319/`          |
| **GiftCard Quick Scan**          | `#giftcard-quick-scan-CECPRO-30512` | CECPRO-30512 Epic                           | Active | Team  | `GiftCard Quick Scan - CECPRO-30512/`                    |
| **PR Reviews**                   | `#pr-reviews`                       | PR review tracking and management           | Active | Self  | `PR Reviews/`                                           |
| **Continuous Improvement**       | `#continuous-improvement`           | Kaizen principles & process optimization    | Active | Self  | `Continuous Improvement/`                               |
| **Release Validation**           | `#release-validation`               | Cross-platform release testing & validation | Active | Team  | `Release Validation/`                                    |
| **Demo Live ON KT Session**      | `#demo-live-on-kt-session`          | Knowledge Transfer (KT) session demo        | Active | Self  | `Demo Live ON KT Session/`                              |

---

## 📊 Portfolio Statistics

- **Total Projects**: 8
- **Active**: 8
- **Pending**: 0
- **On Hold**: 0
- **Completed**: 0
- **Archived**: 0

---

## 🏷️ Tagging System

### Tag Format

**Project Tags**: `#<project-name>`

- Use lowercase with hyphens for multi-word names
- Examples: `#things-to-do`, `#website-redesign`, `#mobile-app`
- Must be unique across all projects

**Date Tags**: `@YYYY-MM-DD` or `@Today`

- Examples: `@2025-12-09`, `@Today`, `@2025-12-31`
- Used for task scheduling and prioritization

**Person Tags**: `@PersonName`

- Examples: `@John`, `@Sarah`, `@TeamLead`
- Used for assignments and collaboration tracking

### Tag Usage

**In Daily Notes**:

```markdown
- [ ] Submit expense report @Today #things-to-do
- [ ] Learn React Hooks @2025-12-15 #things-to-learn
- [ ] Review PR with @John #website-redesign
```

**In Project Files**:

```markdown
- [ ] Submit expense report @Today
- [ ] Code review with @John
```

**No need to repeat project tag within project files** — the project context is implicit.

---

## 📁 Project Lifecycle

### Phase 1: Discovery

**Folder Structure**:
```
ProjectName/
├── AGENT.md           # Project AI instructions
├── project.md         # Overview & stats
├── tasks.md           # Task list
├── meetings.md        # Meeting notes
├── team_members.md    # Team tracking
├── notes.md           # Research & learnings
└── discovery/         # Discovery artifacts
```

**Focus**: Research, planning, analysis, architecture design.

### Phase 2: Execution

**Folder Structure**:
```
ProjectName/
├── AGENT.md           # Project AI instructions
├── project.md         # Overview & stats
├── tasks.md           # Task list
├── meetings.md        # Meeting notes
├── team_members.md    # Team tracking
├── notes.md           # Implementation notes
├── discovery/         # Archived research
└── execution/         # Implementation work
    ├── features/      # Feature implementation
    ├── bugs/          # Bug fixes
    └── docs/          # Documentation
```

**Focus**: Implementation, testing, deployment.

---

## 🎯 Adding a New Project

**Steps**:

1. **Create Project**: Use command `"Create project [Name]"`
2. **Register Here**: Add new row to Portfolio table above
3. **Assign Tag**: Use format `#project-name` (lowercase-with-hyphens)
4. **Set Status**: Active, Pending, On Hold, Completed, or Archived
5. **Update Stats**: Increment project counts

**Template**: Use `../../obsidian-templates/` templates for structure.

---

## 📋 Project Status Definitions

- **Active**: Currently being worked on
- **Pending**: Not yet started, awaiting resources or approval
- **On Hold**: Temporarily paused
- **Completed**: Finished and delivered
- **Archived**: Historical reference, no longer active

---

## 🔄 Maintenance

**Regular Reviews**:

- **Weekly**: Update project status and task counts
- **Monthly**: Archive completed projects
- **Quarterly**: Review and clean up archived projects

**Keep Clean**:

- Remove duplicate tags
- Ensure all projects have unique tags
- Update folder locations if projects are moved
- Archive inactive projects

---

## 📌 Reserved Tags

These tags are system defaults and should not be changed:

- `#things-to-do` - General inbox for loose tasks
- `#things-to-learn` - Learning topics and resources

---

## 🔍 Finding Projects

**By Tag**: Search for `#project-name` across all daily notes  
**By Folder**: Navigate to `[Name]/` (under personal)  
**By Status**: Filter this table by Status column  
**By Owner**: Filter this table by Owner column

---

## 📚 Examples

### Example: Simple Task Project

```markdown
| Project | Tag | Description | Status | Owner | Location |
|---------|-----|-------------|--------|-------|----------|
| Things To Do | `#things-to-do` | Loose tasks & ideas | Active | Team | `ThingsToDo/` |
```

### Example: Epic Project

```markdown
| Project | Tag | Description | Status | Owner | Location |
|---------|-----|-------------|--------|-------|----------|
| Website Redesign | `#website-redesign` | Q1 2025 website refresh | Active | Design Team | `WebsiteRedesign/` |
```

### Example: Completed Project

```markdown
| Project | Tag | Description | Status | Owner | Location |
|---------|-----|-------------|--------|-------|----------|
| Mobile App v1.0 | `#mobile-app-v1` | Initial mobile release | Completed | Mobile Team | `MobileApp-v1/` |
```

---

## 🔗 Related Files

- `System/AGENT.md` — Workflow definitions
- `../../obsidian-templates/project_agent_template.md` — Project AGENT.md template
- `../../obsidian-templates/system_agent_template.md` — Source of truth for workflows
- `../../obsidian-templates/daily_note_template.md` — Clean daily note template

---

**Last Updated**: 2026-01-05
**Maintained By**: Team
**Version**: 2.0
