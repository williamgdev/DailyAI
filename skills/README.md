# Team Skills Hub

This folder contains shareable Agent Skills for the team. Skills are discovered and used directly from this folder - no installation required.

## 🚀 Quick Start

After cloning the repo and running setup:

```bash
# Use any skill with your AI CLI (Claude Code, Cursor, OpenAI CLI, etc.)
"start my day"              # Uses obsidian-workflow skill
"work on a project"         # Interactive project selection
```

## 📂 Available Skills

| Skill | Description | Sample Prompts | Author |
|-------|-------------|----------------|--------|
| [obsidian-workflow](./obsidian-workflow/) | Daily notes, task management, project workflows, and set up skill clients | "start my day", "digest my day", "work on a project", "create project [Name]", "set up skill clients" | AndroidStorm |

## ➕ How to Add a New Skill

Skills follow the [Agent Skills specification](https://agentskills.io/specification).

### 1. Create Skill Folder

```bash
mkdir -p skills/my-skill-name/references
```

### 2. Create SKILL.md

```yaml
---
name: my-skill-name
description: Clear description with keywords that help agents know when to use this skill
allowed-tools:
  - Read
  - Write
  - Grep
  - Glob
metadata:
  author: Your Name
  version: 1.0
---

# My Skill Name

## Overview
What this skill does...

## Workflows

### 1. Main Workflow
When user says "trigger phrase":
1. Step one (using Read tool)
2. Step two (using Write tool)
...
```

### 3. Add References (Optional)

```bash
skills/my-skill-name/references/
├── TEMPLATE_1.md
└── TEMPLATE_2.md
```

### 4. Update This Index

Add your skill to the table above.

### 5. Commit & Push

```bash
git add skills/my-skill-name/
git commit -m "feat: Add my-skill-name skill"
git push
```

**That's it!** The skill is now available to anyone who pulls the repo.  
To have Cursor, Claude, Codex, or VS Code discover it: run `./scripts/setup-skill-clients.sh` from the repo root. That script **scans the entire `skills/` folder** and links every `skills/<name>/` that has a `SKILL.md`—no need to register your skill anywhere else.

---

## 📖 Best Practices

- **Keep SKILL.md under 500 lines** - Move detailed content to `references/`
- **Use clear trigger phrases** - Make it obvious when your skill should activate
- **Document thoroughly** - Include examples and edge cases
- **Test before committing** - Make sure your skill works as expected
- **Follow the spec** - See [agentskills.io/specification](https://agentskills.io/specification)

---

## 🧪 Testing Skills

See [../docs/TESTING.md](../docs/TESTING.md) for how to test skills before committing.
