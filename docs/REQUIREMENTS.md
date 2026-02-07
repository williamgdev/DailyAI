# Requirements

## Required Tools

| Tool | Version | Purpose | Installation |
|------|---------|---------|--------------|
| **Git** | 2.0+ | Clone repository | `brew install git` (macOS) |

## Optional Tools

| Tool | Purpose | Installation |
|------|---------|--------------|
| **AI CLI** (e.g. OpenAI CLI, Claude Code, Gemini CLI, or your org’s assistant CLI) | Run agent skills from the terminal | Install per your chosen tool (e.g. Claude Code, OpenAI CLI, Gemini CLI) |
| **Obsidian** | View/edit vault in UI | [obsidian.md](https://obsidian.md) |
| **Calendar CLI** (optional) | Calendar integration for “Start my day” | Depends on your environment; see project docs if you use a calendar skill |

## System Requirements

- **Operating System**: macOS 12+, Linux, or Windows (WSL)
- **Memory**: 4GB RAM minimum
- **Disk Space**: 100MB minimum
- **Network**: Access to your Git host

## Verify Installation

```bash
# Check Git (required)
git --version
# Should show: git version 2.x.x or higher

# Optional: your AI CLI (e.g. Claude Code, OpenAI CLI, Gemini CLI)
# Run the version command for whichever you use.
```

## If You Don't Have These (CLI / AI workflows)

When running AI from the CLI (Cursor, Claude Code, OpenAI CLI, Gemini CLI, etc.), you may need one or more of the tools below.

### GitHub CLI (`gh`)

- **Needed for:** PR Reviews project (e.g. `gh pr list`, `gh pr view`). If you skip GitHub questions during setup, we assume you’ll use `gh` for auth.
- **Install:**  
  - macOS: `brew install gh`  
  - Then run: `gh auth login` and follow the prompts (use your Git host if on Enterprise).
- **If you don’t install:** Set `GITHUB_TOKEN` (and optionally `GITHUB_USERNAME`, `GITHUB_EMAIL`) in your environment.

### AI CLI (OpenAI, Claude, Gemini, or your org’s CLI)

- **Needed for:** Running skills from the terminal (e.g. “start my day”, “work on a project”). Any CLI that can run agent skills works.
- **Examples:** Claude Code, OpenAI CLI, Gemini CLI, or your organization’s AI assistant CLI. Install and configure per that tool’s docs.
- **If you don't use a terminal CLI:** You can run the same workflows from **Cursor** or other IDEs (including openCode) by opening this repo; skills are linked into `.cursor/skills/`, `.claude/skills/`, `.vscode/skills/`, `.opencode/skills/`, etc. by setup.

### Calendar integration (optional)

- **Needed for:** Showing calendar events in “Start my day” when a calendar skill is used. Optional.
- **If you don’t install:** “Start my day” and other workflows still work; they just won’t include calendar events.

## Notes

- **AI CLIs** (OpenAI, Claude, Gemini, or your org’s) are interchangeable for running skills from the terminal.
- **Obsidian** is optional — you can use any text editor for markdown.
- All skills work with plain markdown files — no proprietary formats.
