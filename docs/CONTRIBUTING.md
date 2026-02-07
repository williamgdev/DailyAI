# Contributing Guide

Thank you for contributing to the Team Productivity System! This guide will help you add skills, projects, and improvements.

---

## 🔌 Contributing a New Skill

Skills are reusable AI workflows that anyone on the team can use.

### 1. Create Skill Structure

```bash
mkdir -p skills/my-skill-name/references
cd skills/my-skill-name
```

### 2. Create SKILL.md

Follow the [Agent Skills specification](https://agentskills.io/specification):

```yaml
---
name: my-skill-name
description: Clear description with keywords. Explain WHEN to use this skill.
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
Explain what this skill does and when to use it.

## Workflows

### 1. Primary Workflow
**Trigger**: "what the user says"

**Actions**:
1. Do something (using Read tool)
2. Process data
3. Write results (using Write tool)

**Result**: What the user gets
```

### 3. Add Templates (Optional)

If your skill needs templates:

```bash
# Add to references/
skills/my-skill-name/references/
├── TEMPLATE_1.md
└── TEMPLATE_2.md
```

### 4. Update Skills Index

Edit `skills/README.md` and add your skill to the table.

### 5. Test Your Skill

```bash
# Test locally with your AI CLI (e.g. use your trigger phrase)

# Run test script
./scripts/test-setup.sh
```

### 6. Submit PR

```bash
git add skills/my-skill-name/
git commit -m "feat: Add my-skill-name skill"
git push origin main
```

---

## 📂 Contributing a Team Project

Team projects are shared work that everyone collaborates on.

### 1. Create Project Structure

```bash
mkdir -p "Projects/My Project"
cd "Projects/My Project"
```

### 2. Copy Templates

```bash
# Copy from skill references
cp ../../skills/obsidian-workflow/references/PROJECT_AGENT_TEMPLATE.md AGENT.md
cp ../../skills/obsidian-workflow/references/PROJECT_TASKS_TEMPLATE.md tasks.md
```

### 3. Customize AGENT.md

Update with:
- Project goal and context
- Team members
- Workflows specific to this project
- Domain knowledge

```markdown
# AGENT.md — My Project

**Goal**: What we're trying to achieve
**Tag**: #my-project
**Owner**: Team Name

## Project Context
Detailed explanation...

## Workflows
How to work on this project...
```

### 4. Create README.md

Help humans understand the project:

```markdown
# My Project

## Overview
What this project is about

## Team
- Person A (lead)
- Person B (contributor)

## Current Status
What we're working on
```

### 5. Update Projects Index

Edit `Projects/README.md` and add your project.

### 6. Submit PR

```bash
git add "Projects/My Project/"
git commit -m "feat: Add My Project"
git push origin main
```

---

## 🏷️ Good First Issues

New to the project? Look for issues labeled **"good first issue"** in the GitHub Issues tab. These are:
- Small, well-defined tasks
- Good for learning the codebase
- Typically documentation or minor fixes

**Examples of good first issues:**
- Fix typos in documentation
- Add missing examples to README
- Improve error messages in scripts
- Add tests for existing functionality

---

## 🐛 Reporting Issues

### Bug Reports

Use this template:

```markdown
**Description**: What went wrong
**Steps to Reproduce**:
1. Run this command
2. See this error

**Expected**: What should happen
**Actual**: What actually happened
**Environment**: macOS/Linux/Windows, AI CLI or IDE version
```

### Feature Requests

```markdown
**Problem**: What problem does this solve?
**Proposed Solution**: How should it work?
**Alternatives**: Other approaches considered
```

---

## 📝 Style Guidelines

### Markdown

- Use `#` for headings (not `##` for top-level)
- Use fenced code blocks with language: ```bash
- Keep lines under 120 characters
- Use tables for structured data

### SKILL.md

- Keep under 500 lines (move details to references/)
- Use clear, imperative language
- Include examples
- Document edge cases

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```bash
feat: Add new feature
fix: Fix bug
docs: Update documentation
refactor: Refactor code
test: Add tests
```

---

## 🔄 Pull Request Process

1. **Fork** (if external) or **branch** (if internal)
2. **Make changes** following guidelines above
3. **Test** locally
4. **Commit** with conventional message
5. **Push** to your branch
6. **Create PR** with description
7. **Address feedback** if requested
8. **Merge** after approval

---

## ✅ Checklist Before Submitting

### For Skills

- [ ] SKILL.md follows specification
- [ ] Skill name is kebab-case
- [ ] Description includes keywords
- [ ] Tested locally
- [ ] Added to skills/README.md
- [ ] References folder includes templates (if needed)

### For Projects

- [ ] AGENT.md customized
- [ ] README.md explains project
- [ ] tasks.md has initial tasks
- [ ] Added to Projects/README.md
- [ ] Tag is unique and lowercase-with-hyphens

### For Documentation

- [ ] Markdown is properly formatted
- [ ] Links work
- [ ] Examples are tested
- [ ] No typos

---

## 🎯 Best Practices

### Skills

- **Single responsibility** - One skill, one purpose
- **Clear triggers** - Obvious when to use
- **Progressive disclosure** - Start simple, add complexity as needed
- **Self-contained** - All templates in references/

### Projects

- **Clear ownership** - Know who's responsible
- **Regular updates** - Keep tasks.md current
- **Document decisions** - Use notes.md
- **Tag consistently** - Use the project tag everywhere

### Code

- **Test before committing** - Run test script
- **Keep it simple** - Prefer clarity over cleverness
- **Document why** - Explain reasoning, not just what
- **Follow conventions** - Match existing style

---

## 💬 Getting Help

- **Questions?** Ask in team chat
- **Stuck?** Create an issue
- **Want to pair?** Set up a meeting

---

## 📚 Resources

- [Agent Skills Specification](https://agentskills.io/specification)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Markdown Guide](https://www.markdownguide.org/)
- [Git Best Practices](https://git-scm.com/book/en/v2)

---

**Thank you for contributing!** 🎉
