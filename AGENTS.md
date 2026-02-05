# AGENTS.md

## Project Overview

This repository is a **documentation and workflow hub** for team collaboration and AI-assisted productivity. It provides shared projects, skills, and scripts. Team- or repo-specific configuration, if needed by a project, lives only in the user's personal workspace (gitignored).

## Project Organization

- **`Projects/`** — Shared project definitions and agents (e.g. PR Reviews, Calendar). Each project can have its own README and AGENT.md.
- **`skills/`** — Agent skills (e.g. obsidian-workflow) that tools can discover and use. Skills are described by `SKILL.md` in each subfolder.
- **`personal/`** — User's private workspace (gitignored). Created by `./scripts/setup.sh`. Contains daily notes, task lists, project catalog. Never committed.
- **`docs/`** — Onboarding, requirements, and reference docs.
- **`scripts/`** — Setup and test scripts. Run `./scripts/setup.sh` from repo root for first-time or re-setup.

When working in this repo, use the folder layout above. For ownership or module mappings in external repos or tools, follow each project's or skill's instructions.

## External Integrations

This project can be connected with MCP servers for:

- **Jira** — Issue tracking and project management
- **GitHub** — Source code and CI/CD
- **SonarQube** — Code quality and security
- **Confluence** — Documentation
- Additional integrations as needed

## Documentation Focus

- Central place for shared docs and workflows
- No build or test commands required for the repo itself
- Keep project- and skill-level docs up to date

## Working with This Repository

- **AI Agents:** Use `skills/*/SKILL.md` for workflow and task behaviors. Do not assume a specific team, org, or repo layout; projects and skills document their own config when needed.
- Respect the split between shared content (Projects/, skills/, docs/) and user-private content (personal/).
- When a project or skill requires config, it will specify where (e.g. under personal/); do not hardcode paths or org names in AGENTS.md.

## Agent Skills

This repository provides **Agent Skills** in the `skills/` directory (per [agentskills.io](https://agentskills.io/specification)). Use them when the user asks about daily workflow, task management, or project organization.

**How to discover skills:**

- Read [skills/README.md](skills/README.md) for the list of available skills, or
- Scan `skills/*/SKILL.md` and parse each file's YAML frontmatter for `name` and `description`.

**Obsidian workflow skill:**

- **Name:** `obsidian-workflow`
- **Path:** [skills/obsidian-workflow/SKILL.md](skills/obsidian-workflow/SKILL.md)
- **When to use:** User asks about "start my day", "digest my day", "create project", "work on a project", daily notes, task filing, or Obsidian workflow.
- **Action:** Read the full `skills/obsidian-workflow/SKILL.md` and follow its instructions.

**Note for Cursor / Claude Code / AI CLI users:** Cursor discovers skills from `.cursor/skills/` (project) or `~/.cursor/skills/` (user). Other clients (e.g. Claude Code, VS Code, OpenAI CLI, Gemini CLI, openCode) use their own skill paths; setup links into `.claude/skills/`, `.codex/skills/`, `.vscode/skills/`, `.opencode/skills/`, etc. Run `./scripts/setup-skill-clients.sh` to link skills into `.cursor/skills/`, `.claude/skills/`, `.codex/skills/`, `.vscode/skills/`, `.opencode/skills/` (or say "set up skill clients" when using the obsidian-workflow skill).

## Future Considerations

- Additional MCP integrations may be added
- New skills and projects may be added under `skills/` and `Projects/`
