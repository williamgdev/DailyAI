# AGENT.md — {{Project Name}}

**Purpose**: Instructions and Context for agents working on {{Project Name}}.
**Canonical Todo List**: [tasks.md](tasks.md)
**Recurring Tasks**: [cadence.md](cadence.md) (optional)

---

## About This File

**This is the project's AGENT.md file** - instructions for AI agents working on this specific project.

- **Purpose**: Provides project-specific context, workflows, and procedures for AI models
- **For AI Models**: Read this file before starting work on this project
- **For Humans**: This documents how AI agents should handle this project
- **Full Documentation**: See `System/AGENT.md` for complete explanation of AGENT.md files

**Priority**: User prompts in chat override these instructions. This file provides defaults and project-specific guidance.

---

## Project Context
**Goal**: [Describe the high-level goal]
**Tag**: #{{tag}} <!-- Register this tag in System/catalog-project.md -->
**Owner**: [User/Owner]
**Status**: [Discovery / Execution]

## Commands for Agents
- **Add Task**: Add to `tasks.md`.
- **Add Recurring Task**: Add to `cadence.md` (if project has recurring work).
- **Update Status**: Modify `execution/tasks.md` (if Execution) or `tasks.md` (if Discovery).
- **Digest Meeting**: Move notes to `execution/scrum/meetings/`.

---

## Recurring Tasks (Optional)

If this project has recurring tasks (weekly reports, scheduled reviews, etc.):
- Create `cadence.md` to define recurring task schedules
- Tasks will be auto-generated in daily notes by "Start My Day" workflow
- Use `references/CADENCE_TEMPLATE.md` as starting point

**When to use cadences:**
- Regular reports (weekly, monthly)
- Scheduled reviews or check-ins
- Sprint-based activities
- Time- or sprint-dependent tasks (e.g., validation after releases)
