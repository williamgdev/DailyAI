# {{PROJECT_NAME}} - Project Brain

Project-specific AI instructions and conventions. This file guides how Claude and other AI assistants should work with this project.

## Project Context

**Project Name:** {{PROJECT_NAME}}
**Project Tag:** #{{PROJECT_TAG}}
**Created:** {{CREATION_DATE}}
**Current Phase:** Discovery
**Status:** Active

## Project Description

[Add description of what this project is about, its goals, and strategic importance]

## Objectives & Goals

- [ ] Goal 1: [Define first objective]
- [ ] Goal 2: [Define second objective]
- [ ] Goal 3: [Define third objective]

Target completion: [Timeline/deadline]

## Current Focus

**Current Sprint/Milestone:** [Name of current sprint or milestone]

**Key deliverables this period:**
- [Deliverable 1]
- [Deliverable 2]
- [Deliverable 3]

## How to Work with This Project

### Task Conventions

**When adding tasks:**
- Use markdown checkbox format: `- [ ] Task description`
- Add date tags: `@Today` or `@YYYY-MM-DD`
- Add person tags: `@PersonName` for collaboration
- Keep tasks in `tasks.md` (canonical source)

**Task priority markers:**
- 🚨 Critical/Blocked - needs immediate attention
- 🔄 In Progress - currently being worked on
- ⏭️ Up Next - next in line to start
- 🗂️ Backlog - future work

**Example task:**
```markdown
- [ ] Design login screen mockups @2026-02-10 @Sarah #design
```

### Meeting Notes

**When logging meetings:**
- Add to `meetings.md` with date header
- Include: Date, attendees, key points, action items
- Reference related tasks: `- [ ] Follow up on X from [meeting date]`

**Example:**
```markdown
## 2026-02-02 - Design Review

**Attendees:** Sarah, Mike, Jessica
**Duration:** 1 hour

**Discussion:**
- Reviewed mobile app mockups
- Approved authentication flow
- Requested accessibility improvements

**Action Items:**
- [ ] Implement accessibility improvements
- [ ] Get legal sign-off on terms
```

### Team Collaboration

**Team members:** [Add names of active team members]

**Communication:**
- Daily standup: [When/how]
- Weekly sync: [When/how]
- Escalation: [Who to contact for blockers]

**Using team_members.md:**
- Track who's involved and their roles
- Update interaction counts automatically (via digest)
- Note active vs. archived team members

### Research & Learning

**Store discoveries in `notes.md`:**
- Document decisions and reasoning
- Link to relevant articles or resources
- Track blockers and how they were resolved
- Capture lessons learned

**Sections:**
- 📚 Research Notes
- 💡 Decisions (why we chose X over Y)
- ⚠️ Blockers & Risks
- ✨ Lessons Learned

### Code & Implementation Standards

[Add any coding standards, frameworks, languages, or tools specific to this project]

- **Language:** [Python/JavaScript/etc]
- **Framework:** [React/Django/etc]
- **Testing:** [Unit tests required: yes/no, coverage target]
- **Code Review:** [Process and requirements]
- **Documentation:** [Inline comments: required/optional]

### Success Criteria

How will we know this project is successful?

- [ ] [Measurable goal 1]
- [ ] [Measurable goal 2]
- [ ] [Measurable goal 3]

## Important Dates

- **Kickoff:** [Start date]
- **Milestones:** [Key dates]
- **Target Completion:** [End date]
- **Review/Launch:** [When?]

## Stakeholders & Contacts

- **Project Lead:** [Name]
- **Product Owner:** [Name]
- **Tech Lead:** [Name]
- **Other key stakeholders:** [Names]

## Risks & Mitigation

**Current Risks:**
- ⚠️ [Risk 1]: [How we're managing it]
- ⚠️ [Risk 2]: [How we're managing it]

**Blockers:**
- 🔴 [Blocker 1]: [Waiting on what?]
- 🔴 [Blocker 2]: [Waiting on what?]

## Dependencies

**External dependencies:**
- [Service/API/Library]: [Why we need it]

**Internal dependencies:**
- [Project Name]: [What we're waiting for]

## Files & Resources

- **Design files:** [Link to Figma/Sketch/etc]
- **Documentation:** [Link to wiki/confluence/etc]
- **Code repository:** [Link to GitHub/GitLab/etc]
- **CI/CD:** [Link to workflow/pipeline]

## Decision Log

**Major Decisions Made:**

1. **[Decision Title]** - [Date]
   - What: [What was decided]
   - Why: [Reasoning]
   - Alternatives considered: [What else?]

2. **[Decision Title]** - [Date]
   - What: [What was decided]
   - Why: [Reasoning]
   - Alternatives considered: [What else?]

## Questions for AI Assistant

When working with this project, consider:

- What's the #{{PROJECT_TAG}} related to in the daily notes?
- Are there any @PersonName collaborators I should coordinate with?
- What's the current blocker from notes.md?
- What's the next critical task (next @date)?
- What decisions have been made that might affect this work?

## Notes

[Any additional context or notes for future reference]

---

**Last Updated:** {{CREATION_DATE}}
**Updated by:** [Who made the last update]

This AGENT.md file is your project's brain. Keep it updated as the project evolves!
