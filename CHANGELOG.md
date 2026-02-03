# Changelog

All notable changes to DailyAI are documented in this file.

## [2.0.0] - 2026-02-02

### ✨ Major Release: Claude Code Plugin

DailyAI is now a fully packaged Claude Code plugin with calendar integration and personal marketplace distribution!

### Added

- ✅ **Claude Code Plugin Structure**
  - Plugin manifest (`.claude-plugin/plugin.json`)
  - Marketplace definition (`.claude-plugin/marketplace.json`)
  - Proper plugin directory organization

- ✅ **Slash Commands** (replaces natural language)
  - `/start-day` - Create daily note with calendar integration
  - `/digest-day` - File tasks to projects
  - `/create-project [Name]` - Create project structure
  - `/work-on-project [Name]` - Load project context

- ✅ **Google Calendar Integration**
  - OAuth 2.0 authentication
  - Automatic event fetching for daily notes
  - Project tag extraction from event titles
  - Graceful degradation when unavailable

- ✅ **iCal/CalDAV Support**
  - Support for Apple Calendar, Nextcloud, and any iCal service
  - URL-based calendar access
  - No OAuth required

- ✅ **MCP Server Architecture**
  - Native Claude Code integration
  - Calendar providers as MCP servers
  - Environment variable mapping
  - Error handling and fallbacks

- ✅ **Installation Scripts**
  - Automated vault setup (`scripts/install.sh`)
  - Python dependency management
  - Template copying and validation

- ✅ **New Templates**
  - PROJECT_AGENT_TEMPLATE.md - Project-specific AI instructions
  - PROJECT_TASKS_TEMPLATE.md - Task list structure
  - DIGEST_LOG_TEMPLATE.md - Digest summary format

- ✅ **Comprehensive Documentation**
  - Installation guide
  - Calendar setup guide
  - Commands reference
  - Troubleshooting guide

- ✅ **Marketplace Distribution**
  - GitHub-based personal marketplace
  - Easy plugin installation
  - Version management

### Changed

- 🔄 **Workflow Access**
  - From: Share SKILL.md with AI assistant
  - To: Use slash commands (`/start-day`, `/digest-day`, etc.)
  - More discoverable and consistent with Claude Code conventions

- 🔄 **Setup Process**
  - From: Manual configuration
  - To: Automated setup script
  - Faster and less error-prone

- 🔄 **Distribution**
  - From: Copy repo locally
  - To: Plugin marketplace
  - Easier updates and version management

### Maintained

- ✅ **Backward Compatibility**
  - Legacy SKILL.md format still works
  - Existing vault structures unchanged
  - No breaking changes for current users
  - Gradual migration path

- ✅ **All Original Features**
  - Daily note creation
  - Task rollover
  - Project scanning
  - Digest filing
  - Team tracking
  - Meeting notes
  - AGENT.md context

### Under the Hood

- Python-based calendar scripts for maximum compatibility
- Graceful dependency handling (works even without calendar libraries)
- Improved error messages and validation
- Better environment variable handling
- Plugin configuration via JSON

## [1.0.0] - 2026-01-26

### Initial Release

- ✅ Agent Skills format skill definition (SKILL.md)
- ✅ Start My Day workflow with task rollover and project scanning
- ✅ Digest My Day workflow with task filing
- ✅ Project creation and management
- ✅ Work on Project with context loading
- ✅ AGENT.md convention for AI instructions
- ✅ Template system for vault setup
- ✅ Tag system (#project-tag, @date, @person)
- ✅ Non-destructive operations (never modifies daily notes)
- ✅ Documentation and quick reference

## Migration Guide: v1.0 to v2.0

### For Existing Users

No action needed! Your existing setup continues to work:
- Current SKILL.md usage still works (marked as legacy)
- Vault structure unchanged
- All templates compatible
- Can gradually migrate to plugin

### To Upgrade to Plugin

1. Set VAULT_PATH environment variable
2. Install plugin: `/plugin install dailyai`
3. Run setup: `./scripts/install.sh`
4. Start using slash commands: `/start-day`

### What Changes

| v1.0 | v2.0 |
|------|------|
| Share SKILL.md | Use `/start-day` command |
| Manual setup | Run `install.sh` |
| No calendar | Optional calendar integration |
| Single command | 4 specialized commands |

### What Stays the Same

- Daily note structure
- Task filing logic
- Project organization
- AGENT.md convention
- Tag system
- All features

---

## Versioning

DailyAI uses [Semantic Versioning](https://semver.org/):
- **MAJOR** (2.0): Plugin architecture, significant features
- **MINOR** (2.1, 2.2): New features, backward compatible
- **PATCH** (2.0.1): Bug fixes, no feature changes

## Future Roadmap

Planned enhancements:
- [ ] Web interface for vault management
- [ ] Mobile app integration
- [ ] Team collaboration features
- [ ] Advanced analytics and reporting
- [ ] Custom workflow templates
- [ ] Multi-vault support
- [ ] Export/import functionality

---

## Support

For issues, feature requests, or questions:
- 📧 Email: [contact info]
- 🐛 Report bugs: GitHub Issues
- 💡 Request features: GitHub Discussions
- 📖 Documentation: See /docs/ folder

---

**Current Version:** 2.0.0
**Status:** Active & Maintained
**License:** MIT
**Last Updated:** 2026-02-02
