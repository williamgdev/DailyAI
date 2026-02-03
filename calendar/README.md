# DailyAI Calendar Integration

Optional calendar integration for fetching events and populating your daily notes.

## Supported Calendars

- **Google Calendar** - OAuth 2.0 integration
- **iCal/CalDAV** - Any calendar supporting iCal format (Apple Calendar, Nextcloud, etc.)

## Installation

### Prerequisites

Python 3.8+ with required dependencies:

```bash
pip install -r requirements.txt
```

Or install during DailyAI setup:

```bash
./scripts/install.sh
```

## Google Calendar Setup

### Step 1: Create OAuth Credentials

1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a new project or select existing
3. Enable the Google Calendar API
4. Create an OAuth 2.0 Desktop Application credential
5. Download the credential JSON file

### Step 2: Set Environment Variable

```bash
export GOOGLE_CALENDAR_CREDENTIALS="/path/to/credentials.json"
```

Add to `~/.bashrc` or `~/.zshrc` for permanent setup:

```bash
echo 'export GOOGLE_CALENDAR_CREDENTIALS="/path/to/credentials.json"' >> ~/.zshrc
source ~/.zshrc
```

### Step 3: First Use

First time you use `/start-day`, you'll be prompted to authorize:

1. A browser window opens for Google authentication
2. Click "Allow" to grant calendar access
3. Token is saved locally at `~/.config/dailyai/google_calendar_token.json`
4. Future runs use the stored token automatically

### Step 4: Test

```bash
/start-day
```

Calendar events should appear in your daily note.

## iCal/CalDAV Setup

### Step 1: Get Your Calendar URL

**Apple Calendar (iCloud):**
1. Open Calendar app
2. Right-click your calendar
3. Copy iCal URL (may need to enable in iCloud settings)

**Google Calendar (as iCal):**
1. Go to [Google Calendar settings](https://calendar.google.com/calendar/u/0/r/settings)
2. Find your calendar
3. Scroll to "Integration" section
4. Copy the "Public address in iCalendar format" URL
5. For private calendar, use Settings → Export → Download

**Nextcloud:**
1. Open Nextcloud Calendar app
2. Right-click your calendar
3. Copy the .ics URL

**Other Services:**
Look for "Export as iCal", "iCal Feed", or "WebCAL" option.

### Step 2: Set Environment Variable

```bash
export ICAL_CALENDAR_URL="https://example.com/calendar/private.ics"
```

Add to `~/.bashrc` or `~/.zshrc` for permanent setup:

```bash
echo 'export ICAL_CALENDAR_URL="https://example.com/calendar/private.ics"' >> ~/.zshrc
source ~/.zshrc
```

### Step 3: Test

```bash
/start-day
```

Calendar events should appear in your daily note.

## How It Works

### In Start My Day Workflow

1. Checks for calendar configuration (Google or iCal)
2. Fetches events for today
3. Extracts event times and titles
4. Identifies project tags in event titles (e.g., `#mobile-app`)
5. Populates `## 📅 Calendar` section with formatted events
6. Populates `## 🚀 Targeted Projects` with identified projects

### Project Tag Extraction

Calendar events are scanned for project references:

**Examples:**

```
Event Title: "Team Standup #mobile-app"
→ Tag: #mobile-app

Event Title: "Sprint Planning - Website Redesign"
→ Tag: #website-redesign

Event Title: "Mobile App Design Review"
→ Tag: #mobile-app
```

## Troubleshooting

### Google Calendar

**"Credentials not configured"**
- Set `GOOGLE_CALENDAR_CREDENTIALS` environment variable
- Verify the path to credentials.json file exists

**"OAuth flow failed"**
- Check internet connection
- Verify credentials.json is valid
- Try removing `~/.config/dailyai/google_calendar_token.json` and re-authenticating

**"No events found"**
- Verify calendar is visible in Google Calendar app
- Check if events are in the correct date range
- Ensure events aren't marked as "private"

### iCal/CalDAV

**"Failed to fetch calendar"**
- Verify the iCal URL is correct and accessible
- Check internet connection
- Some URLs may require authentication

**"Invalid calendar format"**
- Verify the URL points to an iCal (.ics) file
- Some calendar services require WebCAL→HTTPS conversion
- Try downloading the calendar manually to verify format

**"No events found"**
- Verify events exist on the calendar
- Check date filters in the calendar service
- Some services may require sharing before external access

### Both Calendar Types

**"Calendar not working after setup"**
- Try running `/start-day` again (might need retry)
- Check console output for specific error messages
- Calendar unavailability doesn't block daily note creation

**"Can't find environment variable"**
- Verify you ran `source ~/.zshrc` (or ~/.bashrc)
- Check with `echo $GOOGLE_CALENDAR_CREDENTIALS`
- Make sure quotes are correct in export statement

## Optional: No Calendar

If you don't want to use calendar integration:

- Don't set environment variables
- Daily notes still work perfectly
- Manually add events to your daily note if desired
- All other DailyAI features work without calendar

## Graceful Degradation

DailyAI handles calendar unavailability gracefully:

- If calendar not configured → Calendar section skipped
- If calendar unavailable → Calendar section skipped, continue with tasks
- If calendar permission denied → Calendar section skipped
- All other workflows continue normally

Your daily notes are never blocked by calendar issues.

## Security & Privacy

**Local Storage:**
- Google Calendar tokens stored in `~/.config/dailyai/google_calendar_token.json`
- Only you have access to this file
- Remove file to revoke access

**Credentials:**
- Never store credentials in vault or git
- Never share credentials.json file
- OAuth tokens are time-limited and refreshable

**iCal URLs:**
- If using private calendar URL, protect it like a password
- Don't commit to git or share publicly
- Some services allow per-application tokens

## Advanced: Custom Calendar Scripts

Want to integrate a different calendar system?

Create a script with this interface:

```python
def fetch_events(date_str=None):
    """
    Fetch calendar events

    Args:
        date_str: Optional YYYY-MM-DD format date

    Returns:
        {
            "events": [
                {
                    "start": "ISO datetime string",
                    "end": "ISO datetime string",
                    "summary": "Event title",
                    "location": "Location (optional)",
                    "description": "Description (optional)"
                }
            ]
        }
        OR
        {"error": "Error message"}
    """
```

Update `.mcp.json` to reference your script.

## Feedback

Calendar integration feedback?

- Report issues on GitHub
- Request calendar service support
- Share your setup guide for others

Enjoy seamless calendar integration with DailyAI! 📅
