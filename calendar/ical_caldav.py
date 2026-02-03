#!/usr/bin/env python3
"""
iCal/CalDAV MCP Server for DailyAI
Fetches calendar events from iCal URL or CalDAV server
"""
import os
import sys
import json
from datetime import datetime, timedelta

# Conditional imports for optional dependencies
try:
    import requests
    REQUESTS_AVAILABLE = True
except ImportError:
    REQUESTS_AVAILABLE = False

try:
    from icalendar import Calendar
    ICAL_AVAILABLE = True
except ImportError:
    ICAL_AVAILABLE = False

def fetch_ical_events(url, date_str=None):
    """Fetch events from iCal URL"""
    if not REQUESTS_AVAILABLE or not ICAL_AVAILABLE:
        return {"error": "iCal dependencies not installed"}

    try:
        # Parse target date
        if date_str:
            try:
                target_date = datetime.strptime(date_str, '%Y-%m-%d').date()
            except ValueError:
                return {"error": f"Invalid date format: {date_str}"}
        else:
            target_date = datetime.now().date()

        # Fetch calendar
        try:
            response = requests.get(url, timeout=10)
            response.raise_for_status()
        except requests.exceptions.RequestException as e:
            return {"error": f"Failed to fetch calendar: {str(e)}"}

        try:
            cal = Calendar.from_ical(response.content)
        except Exception as e:
            return {"error": f"Invalid calendar format: {str(e)}"}

        # Extract events for target date
        formatted_events = []
        for component in cal.walk():
            if component.name == "VEVENT":
                try:
                    dtstart = component.get('dtstart')
                    dtend = component.get('dtend')

                    if dtstart:
                        event_date = dtstart.dt
                        # Handle both datetime and date objects
                        if hasattr(event_date, 'date'):
                            event_date = event_date.date()
                        elif isinstance(event_date, str):
                            try:
                                event_date = datetime.fromisoformat(event_date).date()
                            except:
                                continue

                        if event_date == target_date:
                            start_str = str(dtstart.dt)
                            end_str = str(dtend.dt) if dtend else ''

                            formatted_events.append({
                                'start': start_str,
                                'end': end_str,
                                'summary': str(component.get('summary', 'No title')),
                                'location': str(component.get('location', '')),
                                'description': str(component.get('description', ''))
                            })
                except (KeyError, AttributeError, TypeError):
                    continue

        return {"events": formatted_events}

    except Exception as e:
        return {"error": str(e)}

def main():
    """Main entry point for MCP server"""
    ical_url = os.getenv('ICAL_CALENDAR_URL')
    if not ical_url:
        print(json.dumps({"error": "ICAL_CALENDAR_URL environment variable not set"}))
        sys.exit(1)

    date_arg = sys.argv[1] if len(sys.argv) > 1 else None
    result = fetch_ical_events(ical_url, date_arg)
    print(json.dumps(result))

if __name__ == '__main__':
    main()
