# DailyAI - AI Agent Skill

[![Agent Skills](https://img.shields.io/badge/Agent-Skills-blue)](https://github.com/agentskills/agentskills)

DailyAI is an AI-driven Obsidian workflow system for daily notes, task management, and project organization. Built using the [Agent Skills](https://github.com/agentskills/agentskills) format - a standardized way to define AI assistant capabilities.

## Overview

This is an **Agent Skill** - a standardized format for AI assistant capabilities. The entire workflow is defined in `SKILL.md` using markdown instructions that AI assistants (like Claude) can read and execute directly. No scripts required!

**What it provides:**
- 🌅 **Start My Day**: Creates daily notes with task rollover and project scanning
- 🌙 **Digest My Day**: Files tagged content to projects automatically
- 📁 **Project Management**: Structured project creation and organization
- 💼 **Work on Project**: Load full project context and status for focused work
- 🤖 **AI Context**: AGENT.md files guide AI assistants on how to work with your vault

## Features

### 🌅 Start My Day
- Creates daily note from template
- Rolls over incomplete tasks from yesterday
- Scans all projects for:
  - Critical tasks (due today)
  - Upcoming tasks (future dates)
  - Undated tasks (reminders)
- Populates daily note with categorized tasks

### 🌙 Digest My Day
- Finds latest daily note
- Extracts and files tagged tasks to projects
- Copies meeting notes to project folders
- Creates comprehensive digest log
- Shows summary of actions taken

**Important**: Daily notes are never modified - they remain as permanent records.

### 📁 Project Management
- Creates structured project folders
- Registers projects in catalog
- Sets up AGENT.md for AI context
- Organizes by Discovery/Execution phases

### 💼 Work on Project
- Loads project-specific AGENT.md context
- Displays comprehensive project status
- Shows critical and in-progress tasks
- Lists recent meetings and team updates
- Highlights blockers and risks
- Activates project-specific AI workflows

### 🤖 AGENT.md Files
Project-specific AI instructions that guide how AI assistants work with each project:
- `System/AGENT.md` - System-wide workflows
- `Projects/[Name]/AGENT.md` - Project-specific rules

## Quick Start

### Installation

1. Clone this repository:
```bash
git clone https://github.com/YOUR_USERNAME/dailyai.git
cd dailyai
```

2. Set up your Obsidian vault structure:
```bash
# Set your vault path
export VAULT_PATH="/path/to/your/obsidian/vault"
```

3. Copy templates to your vault:
```bash
cp -r templates/* "$VAULT_PATH/"
```

### Usage with Claude

**Method 1: Natural Language** (if skill is loaded)

Simply describe what you want to do:
```
"start my day"
"digest my day"
"create project Mobile App"
"work on Mobile App"
"show me today's tasks"
```

**Method 2: Load the Skill**

Share the `SKILL.md` file with your AI assistant:
1. Upload `SKILL.md` to your conversation, or
2. Copy/paste the contents into chat
3. The AI will understand all the workflows and execute them

**That's it!** No scripts to run - the AI reads the markdown instructions and uses its tools (Read, Write, Edit, Bash, etc.) to execute the workflows.

## Agent Skills Format

This skill follows the [Agent Skills](https://github.com/agentskills/agentskills) specification - a standardized format for defining AI assistant capabilities.

**Key Components:**

1. **SKILL.md** - The core skill definition with:
   - YAML frontmatter (name, description, allowed-tools, metadata)
   - Markdown instructions for workflows
   - Usage examples and troubleshooting

2. **Pure Agent-Style Execution** - No separate scripts needed:
   - AI reads the markdown instructions
   - Uses its built-in tools (Read, Write, Edit, Bash, Grep, Glob)
   - Executes workflows directly

3. **Templates** - Reference files for users to copy to their vault

**Why Agent Skills?**
- ✅ Standardized format across different AI assistants
- ✅ Human-readable documentation doubles as executable instructions
- ✅ No external dependencies or scripts to maintain
- ✅ Portable and easy to share
- ✅ Works with Claude, and potentially other AI assistants

## Structure

```
dailyai/
├── README.md                   # This file
├── SKILL.md                    # Main skill definition for AI assistants
├── QUICK_REFERENCE.md          # Quick reference guide
├── CONTRIBUTING.md             # Contribution guidelines
├── LICENSE                     # MIT License
└── templates/
    ├── AGENT_TEMPLATE.md       # System AGENT.md reference
    ├── DAILY_NOTE_TEMPLATE.md  # Daily note template
    └── PROJECT_CATALOG.md      # Project catalog example
```

### Your Obsidian Vault Structure

```
YourVault/
├── System/
│   ├── AGENT.md                 # System brain (copy from templates)
│   └── catalog-project.md       # Project registry
├── Projects/
│   ├── ThingsToDo/             # Default inbox
│   ├── ThingsToLearn/          # Learning items
│   └── [YourProjects]/         # Your project folders
└── Daily/
    └── YYYY/
        ├── YYYY-MM-DD.md       # Daily notes
        └── YYYY-MM-DD.digested.md  # Digest logs
```

## Key Concepts

### Tag System

- **Project Tags**: `#project-name` - Routes content to projects
- **Date Tags**: `@YYYY-MM-DD` or `@Today` - Schedules tasks
- **Person Tags**: `@PersonName` - Tracks collaborations

### Task Examples

```markdown
# Critical task for today
- [ ] Submit report @Today #release-validation

# Scheduled task
- [ ] Meeting prep @2026-01-27 #pr-reviews

# Task with person
- [ ] Follow up with @Sarah #mobile-app

# Learning item
- [ ] Study React Hooks #things-to-learn
```

## Configuration

### Environment Variables

```bash
# Set your Obsidian vault path
export VAULT_PATH="/path/to/your/obsidian/vault"
```

Add to your `~/.bashrc` or `~/.zshrc` to make it permanent.

### Vault Setup

1. Create the basic structure:
```bash
mkdir -p "$VAULT_PATH/System"
mkdir -p "$VAULT_PATH/Projects/ThingsToDo"
mkdir -p "$VAULT_PATH/Projects/ThingsToLearn"
mkdir -p "$VAULT_PATH/Daily/$(date +%Y)"
```

2. Copy the AGENT.md template:
```bash
cp templates/AGENT_TEMPLATE.md "$VAULT_PATH/System/AGENT.md"
```

3. Create your project catalog:
```bash
cp templates/PROJECT_CATALOG.md "$VAULT_PATH/System/catalog-project.md"
```

## Usage Examples

### Example 1: Morning Routine

```
User: "start my day"

AI: 🌅 Starting your day...
    ✅ Daily note created

    🎯 Projects Found: 3
    🚨 Critical Tasks: 2
    📌 Undated Tasks: 8

    Your daily note is ready at: Daily/2026/2026-02-02.md
```

### Example 2: Evening Routine

```
User: "digest my day"

AI: 🌙 Digesting your day...
    ✅ Day Digested Successfully!

    📊 Summary:
    - 3 tasks filed to Mobile App
    - 2 tasks filed to Website Redesign
    - 1 meeting note copied to Mobile App

    📂 Files Updated:
    ✅ Projects/Mobile-App/tasks.md
    ✅ Projects/Website-Redesign/tasks.md

    Digest log created: 2026-02-02.digested.md
```

### Example 3: Project Creation

```
User: "create project iOS Performance Optimization"

AI: ✅ Project Created!

    📁 Location: Projects/iOS-Performance-Optimization/
    🏷️ Tag: #ios-performance-optimization
    📋 Status: Active

    Files created:
    - AGENT.md (AI instructions)
    - project.md (Overview)
    - tasks.md (Task list)
    - meetings.md (Meeting log)
    - team_members.md (Team tracking)
    - notes.md (Research)
```

### Example 4: Working on a Project

```
User: "work on Mobile App"

AI: 💼 Working on: Mobile App Redesign
    📁 Location: Projects/Mobile-App-Redesign/
    🏷️ Tag: #mobile-app-redesign
    📋 Status: Active (Execution Phase)

    🎯 Project Overview:
    - Redesigning mobile app UI/UX for better user experience
    - Target: Q2 2026 launch
    - Current Sprint: Authentication & Onboarding

    🚨 Critical Tasks (3):
    - [ ] Complete login screen mockups @Today
    - [ ] Review authentication flow @2026-02-03
    - [ ] User testing session prep @2026-02-05

    📝 In Progress (2):
    - [ ] Design system documentation
    - [ ] Accessibility audit

    📅 Recent Meetings:
    - 2026-01-30: Design Review with UX Team
    - 2026-01-28: Sprint Planning

    👥 Team: 5 active members
    ⚠️ Blockers: Waiting on API specs from backend team

    ✅ Project context loaded. AGENT.md rules active.
```

## Best Practices

1. **Daily Routine**
   - Run "start my day" every morning
   - Run "digest my day" every evening
   - Review digest logs weekly

2. **Task Management**
   - Use project tags consistently
   - Add date tags for important tasks
   - Keep inbox clean by filing regularly

3. **Project Organization**
   - Create projects for epics/initiatives
   - Update AGENT.md with project-specific rules
   - Maintain catalog with accurate statuses

## Troubleshooting

### Daily note not created
- Check template path exists in your vault
- Verify `VAULT_PATH` is set correctly
- Ensure Daily/YYYY/ folder exists

### Tasks not filing correctly
- Verify project tag in `catalog-project.md`
- Check project folder exists
- Ensure `tasks.md` file exists in project

### Digest shows "Already digested"
- This is normal - prevents duplicate processing
- Look for `.digested.md` file for previous digest summary

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### How to Contribute

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Inspired by the Obsidian community's innovative note-taking workflows
- Built for use with Claude and other AI coding assistants
- Designed to work with the AGENT.md/AGENTS.md convention for AI context

## Support

For issues or questions:
- Open an issue on GitHub
- Check the [QUICK_REFERENCE.md](QUICK_REFERENCE.md) for common commands
- Review [SKILL.md](SKILL.md) for detailed workflow instructions

## Version

- **Version**: 1.0.0
- **Status**: Active ✅
- **Compatibility**: Claude, and other AI assistants supporting file context

---

Made with ❤️ for the Obsidian and AI assistant community
