# Onboarding Guide

Welcome to the Team Productivity System! This guide will help you get started.

## 📋 Prerequisites

Before you begin, make sure you have:
- [x] Git installed
- [x] (Optional) An AI CLI (e.g. OpenAI CLI, Claude Code, Gemini CLI) or Cursor
- [x] Access to this repository

See [REQUIREMENTS.md](./REQUIREMENTS.md) for detailed installation instructions.

---

## 📂 Folder Structure (Important)

This repo has two distinct areas:

| Area | Purpose | In version control? |
|------|---------|---------------------|
| **`Projects/`** | **Team projects and agents** — work the team is collaborating on (e.g. PR Reviews, Calendar Integration). Each project has an `AGENT.md` and is shared with the team. | ✅ **Yes** — committed and pushed |
| **`personal/`** | **Your private workspace** — daily notes, your inbox (ThingsToDo), learning (ThingsToLearn), and projects you create with “create project”. Used by “start my day” and “digest my day”. | ❌ **No** — **never pushed to the repository** (gitignored) |

- **Projects/** = shared team agents and projects. Everything here is committed and visible to the team.
- **personal/** = your own notes and projects. It stays only on your machine and is never pushed.

After setup, your repo will look like this:

```
wcp-profile-ai-colaboration/
├── Projects/                # Team projects and agents (shared, version controlled)
│   ├── PR Reviews/
│   ├── Calendar Integration/
│   └── ...
├── skills/                  # Team skills (shared)
├── scripts/
├── docs/
└── personal/                # Your workspace only — never pushed to the repo
    ├── catalog-project.md
    ├── ThingsToDo/
    ├── ThingsToLearn/
    ├── Daily/
    └── [Your projects from "create project"]
```

---

## 🚀 Quick Start

### Step 1: Clone the Repository

```bash
git clone <your-repo-url>
cd <repo-directory>
```

### Step 2: Run Setup Script

This creates your **personal** workspace:

```bash
./scripts/setup.sh
```

The script will create:
- `personal/` folder (gitignored — your private workspace)
- `personal/ThingsToDo/` (your inbox)
- `personal/ThingsToLearn/` (learning tracker)
- `personal/Daily/2026/` (daily notes)
- `personal/catalog-project.md` (your **personal** project registry only; team projects are in `Projects/catalog-team.md`)

To link skills for Cursor, Claude, Codex, or VS Code, run: `./scripts/setup-skill-clients.sh` (or say "set up skill clients" when using the obsidian-workflow skill). Re-run after adding a new skill under `skills/`.

### Step 3: Start Using

Use your AI CLI (e.g. Claude Code, OpenAI CLI, Gemini CLI) or Cursor with prompts like **"start my day"**, **"work on a project"**, **"digest my day"**.

---

## 🎯 Core Workflows

### Morning: Start My Day

Use your AI CLI or Cursor with **"start my day"**.

- Creates today’s daily note in **personal/**
- Shows calendar events (if a calendar integration is configured)
- Lists critical and due tasks, rollover from yesterday, upcoming tasks

### During the Day: Work on a Project

Use your AI CLI or Cursor with **"work on a project"**:

- Lists projects from your **personal** catalog
- Lets you pick a project and work on its tasks

### Evening: Digest My Day

Use your AI CLI or Cursor with **"digest my day"**:

- Files tasks and meeting notes into the right **personal** project folders
- Creates a digest log; your daily note stays unchanged as a record

---

## 📂 Reminder: What Gets Pushed

- **Pushed:** Everything except `personal/` (your private workspace). That includes `Projects/`, `skills/`, `scripts/`, and `docs/`.
- **Never pushed:** The **personal/** folder and any file containing your secrets or local paths. Your daily notes, ThingsToDo, ThingsToLearn, and projects you create with “create project” stay only on your machine.

---

## 🔌 Optional: Obsidian

1. Open Obsidian.
2. “Open folder as vault.”
3. Select: `wcp-profile-ai-colaboration/personal/`

You can then use Obsidian’s UI while skills drive “start my day” and “digest my day.”

---

## 📚 Next Steps

- [Contributing Guide](./CONTRIBUTING.md)
- [Available Skills](../skills/README.md)
- [Team Projects](../Projects/README.md) — agents and projects the team is working on

### Create your first personal project

Use your AI CLI or Cursor with **"create project My First Project"** (or your preferred project name).

This creates a project under **personal/** and registers it in your catalog. It will not be pushed to the repo.

---

## 🆘 Troubleshooting

### Daily note not created

- Ensure `personal/` exists: `ls -la personal/`
- If not, run: `./scripts/setup.sh`

### Skill not found

- Check: `ls -la skills/obsidian-workflow/`
- Run from repo root and use your AI CLI or Cursor with **"start my day"**

### Git shows personal files

- Confirm `personal/` is ignored: `grep personal .gitignore`
- If missing: `echo "personal/" >> .gitignore`

---

## 💡 Tips

1. Run **“start my day”** each morning; run **“digest my day”** each evening.
2. Tag tasks in daily notes with `#project-name` so they file to the right **personal** project.
3. Use `@Today` for urgent tasks.
4. **personal/** is only on your machine — never commit it.

---

**Need help?** Ask in the team chat or open an issue in the repository.

**Full walkthrough:** For a step-by-step mock-up of the entire onboarding (clone → setup → first use), see [ONBOARDING_MOCKUP.md](./ONBOARDING_MOCKUP.md).
