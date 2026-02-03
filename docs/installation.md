# DailyAI Plugin Installation Guide

Get DailyAI set up and running in minutes.

## System Requirements

- Claude Code installed
- Obsidian vault
- Python 3.8+ (for calendar integration, optional)
- macOS, Linux, or Windows with bash/zsh

## Installation Steps

### Step 1: Set VAULT_PATH Environment Variable

Point Claude Code to your Obsidian vault:

**macOS/Linux:**
```bash
echo 'export VAULT_PATH="/path/to/your/obsidian/vault"' >> ~/.zshrc
source ~/.zshrc
```

**Windows (PowerShell):**
```powershell
$vault = "/path/to/obsidian/vault"
[Environment]::SetEnvironmentVariable("VAULT_PATH", $vault, "User")
```

**Verify it's set:**
```bash
echo $VAULT_PATH
```

### Step 2: Add DailyAI Marketplace (in Claude Code)

```
/plugin marketplace add https://github.com/YOUR_USERNAME/DailyAI
```

### Step 3: Install DailyAI Plugin

```
/plugin install dailyai
```

### Step 4: Run Setup Script

The setup script automatically configures your vault:

```bash
cd ~/.claude/plugins/dailyai
./scripts/install.sh
```

This will:
- ✅ Validate VAULT_PATH
- ✅ Create vault directory structure
- ✅ Copy templates to your vault
- ✅ Install Python dependencies (if Python available)

### Step 5 (Optional): Configure Calendar

Calendar integration is optional but recommended:

**Google Calendar:**
See [Calendar Setup Guide](calendar-setup.md)

**iCal/CalDAV:**
See [Calendar Setup Guide](calendar-setup.md)

## First Run

Test your installation:

```
/start-day
```

You should see:
- ✅ Daily note created at `Daily/YYYY/YYYY-MM-DD.md`
- ✅ Calendar events (if configured)
- ✅ Tasks from projects

## Troubleshooting

### VAULT_PATH not found
- Make sure you ran `source ~/.zshrc` (or ~/.bashrc)
- Verify with: `echo $VAULT_PATH`
- Check path exists: `ls $VAULT_PATH`

### Plugin not installing
- Run: `/plugin validate`
- Check internet connection
- Try: `/plugin install dailyai --verbose`

### Scripts not executable
```bash
chmod +x ~/.claude/plugins/dailyai/scripts/*.sh
chmod +x ~/.claude/plugins/dailyai/calendar/*.py
```

### Python dependencies failed
```bash
pip install -r ~/.claude/plugins/dailyai/calendar/requirements.txt
```

See [Troubleshooting Guide](troubleshooting.md) for more issues.

## Verification Checklist

After installation, verify:

- [ ] `echo $VAULT_PATH` shows your vault path
- [ ] `/start-day` creates a daily note
- [ ] `/digest-day` works (or shows "no daily notes")
- [ ] `/create-project Test` creates a project
- [ ] `/work-on-project Test` loads project context

If all pass, you're ready to use DailyAI!

## Next Steps

1. **Read** [Commands Reference](commands.md)
2. **Try** `/start-day` to create your first daily note
3. **Create** your first project: `/create-project MyProject`
4. **Configure** calendar (optional): [Calendar Setup](calendar-setup.md)

## Getting Help

- Questions? See [Troubleshooting Guide](troubleshooting.md)
- Command reference: [Commands Guide](commands.md)
- Calendar issues? [Calendar Setup](calendar-setup.md)
- Other issues? Check [QUICK_REFERENCE.md](../QUICK_REFERENCE.md)

## Upgrade

To update to a newer version:

```bash
/plugin install dailyai --update
```

## Uninstall

To remove DailyAI:

```bash
/plugin uninstall dailyai
```

This removes the plugin but keeps your vault intact.

---

Enjoy DailyAI! 🚀
