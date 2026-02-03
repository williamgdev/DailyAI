#!/usr/bin/env python3
"""
Google Calendar MCP Server for DailyAI
Fetches today's calendar events via Google Calendar API
"""
import os
import sys
import json
from datetime import datetime, timedelta

# Conditional imports for optional dependencies
try:
    from google.oauth2.credentials import Credentials
    from google.auth.transport.requests import Request
    from google_auth_oauthlib.flow import InstalledAppFlow
    from googleapiclient.discovery import build
    GOOGLE_API_AVAILABLE = True
except ImportError:
    GOOGLE_API_AVAILABLE = False

SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']

def get_credentials():
    """Get Google Calendar API credentials with OAuth flow"""
    if not GOOGLE_API_AVAILABLE:
        return None

    creds = None
    creds_path = os.getenv('GOOGLE_CALENDAR_CREDENTIALS')
    token_path = os.path.expanduser('~/.config/dailyai/google_calendar_token.json')

    if not creds_path:
        return None

    # Load existing token if available
    if os.path.exists(token_path):
        try:
            creds = Credentials.from_authorized_user_file(token_path, SCOPES)
        except:
            pass

    # Refresh or get new token
    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            try:
                creds.refresh(Request())
            except:
                creds = None

        if not creds:
            try:
                flow = InstalledAppFlow.from_client_secrets_file(creds_path, SCOPES)
                creds = flow.run_local_server(port=0)
            except Exception as e:
                return None

        # Save token for future use
        try:
            os.makedirs(os.path.dirname(token_path), exist_ok=True)
            with open(token_path, 'w') as token:
                token.write(creds.to_json())
        except:
            pass

    return creds

def fetch_events(date_str=None):
    """Fetch calendar events for specified date (default: today)"""
    if not GOOGLE_API_AVAILABLE:
        return {"error": "Google Calendar dependencies not installed"}

    try:
        creds = get_credentials()
        if not creds:
            return {"error": "Calendar credentials not configured"}

        service = build('calendar', 'v3', credentials=creds)

        # Parse date
        if date_str:
            try:
                target_date = datetime.strptime(date_str, '%Y-%m-%d')
            except ValueError:
                return {"error": f"Invalid date format: {date_str}"}
        else:
            target_date = datetime.now()

        # Get events for the day
        time_min = target_date.replace(hour=0, minute=0, second=0, microsecond=0).isoformat() + 'Z'
        time_max = (target_date + timedelta(days=1)).replace(hour=0, minute=0, second=0, microsecond=0).isoformat() + 'Z'

        events_result = service.events().list(
            calendarId='primary',
            timeMin=time_min,
            timeMax=time_max,
            singleEvents=True,
            orderBy='startTime'
        ).execute()

        events = events_result.get('items', [])

        # Format events
        formatted_events = []
        for event in events:
            try:
                start = event['start'].get('dateTime', event['start'].get('date'))
                end = event['end'].get('dateTime', event['end'].get('date'))
                summary = event.get('summary', 'No title')

                formatted_events.append({
                    'start': start,
                    'end': end,
                    'summary': summary,
                    'location': event.get('location', ''),
                    'description': event.get('description', '')
                })
            except KeyError:
                continue

        return {"events": formatted_events}

    except Exception as e:
        return {"error": str(e)}

def main():
    """Main entry point for MCP server"""
    date_arg = sys.argv[1] if len(sys.argv) > 1 else None
    result = fetch_events(date_arg)
    print(json.dumps(result))

if __name__ == '__main__':
    main()
