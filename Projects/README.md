# Team Projects

This folder contains **team projects and agents** — shared work the team is collaborating on. Each project has an `AGENT.md` and supporting docs. Everything here is version controlled and pushed to the repository.

## 📂 Structure

Each project follows this structure:

```
ProjectName/
├── AGENT.md           # Project-specific AI instructions
├── project.md         # Overview and goals
├── tasks.md           # Task list
├── meetings.md        # Meeting notes (optional)
├── notes.md           # Research and documentation
└── README.md          # Human-readable project guide
```

## 🚀 Active Projects

| Project | Description | Status |
|---------|-------------|--------|
| *(none yet — add your first project below)* |

## ➕ Adding a Team Project

### 1. Create Project Folder

```bash
mkdir -p "Projects/My New Project"
cd "Projects/My New Project"
```

### 2. Use the Template

Copy from `skills/obsidian-workflow/references/`:
- `PROJECT_AGENT_TEMPLATE.md` → `AGENT.md`
- `PROJECT_TASKS_TEMPLATE.md` → `tasks.md`

### 3. Customize for Your Project

Update `AGENT.md` with:
- Project goal and context
- Team members
- Specific workflows
- Domain knowledge

### 4. Register the Project

Add it to the table above and commit:

```bash
git add "Projects/My New Project/"
git commit -m "feat: Add My New Project"
git push
```

## 🔒 Projects (team) vs personal

| Type | Location | Pushed to repo? |
|------|----------|-----------------|
| **Team projects and agents** | `Projects/` (this folder) | ✅ Yes — shared with the team |
| **Your personal workflow** | `personal/` | ❌ **No — never pushed** (gitignored) |

- **This folder (`Projects/`)** = agents and projects the team is working on. Version controlled and pushed.
- **`personal/`** = your daily notes, ThingsToDo, ThingsToLearn, and projects you create with “create project.” Used by “start my day” and “digest my day.” The **personal** folder stays only on your machine and is never pushed to the repository.

---

## 📖 Project AGENT.md

Each project has an `AGENT.md` file that tells AI agents:
- What the project is about
- How to work on it
- Team conventions
- Domain-specific knowledge

This allows agents to work effectively on each project with proper context.
