# Demo Project

A sample project to help you understand how DailyAI works.

## Purpose

This project demonstrates:
- How project folders are structured
- How tasks flow between daily notes and projects
- How to use project tags (`#demo`)

## Quick Test

1. Run `start my day` with your AI CLI
2. Add a task to your daily note: `- [ ] Test the demo project #demo`
3. Run `digest my day` at end of day
4. Check `Projects/Demo/tasks.md` - your task will be filed there

## Structure

```
Projects/Demo/
├── README.md      ← You are here
├── AGENT.md       ← AI instructions for this project
└── tasks.md       ← Task list (populated by digest)
```

## Next Steps

Once you understand the flow:
1. Create your own project: `create project [YourProjectName]`
2. Use your project tag in daily notes
3. Watch tasks file automatically during digest
