#!/usr/bin/env python3
"""
Calendar event formatter and project tag extractor for DailyAI
Formats events as markdown and extracts project tags
"""
import re
from datetime import datetime

def parse_time(time_str):
    """Parse ISO time to readable format (HH:MM AM/PM)"""
    if not time_str:
        return ""

    try:
        # Handle ISO format with timezone
        if 'T' in time_str:
            dt = datetime.fromisoformat(time_str.replace('Z', '+00:00'))
            return dt.strftime('%I:%M %p').lstrip('0')
        # Handle date-only format (YYYY-MM-DD)
        elif len(time_str) == 10:
            return time_str
        else:
            return time_str
    except:
        return time_str

def format_event_markdown(event):
    """Format a single event as markdown"""
    start = parse_time(event['start'])
    end = parse_time(event['end']) if event.get('end') else None
    summary = event.get('summary', 'Event')

    if end and start != end:
        time_str = f"{start} - {end}"
    elif start:
        time_str = start
    else:
        time_str = ""

    if time_str:
        return f"- {time_str}: {summary}"
    else:
        return f"- {summary}"

def extract_project_tags(event_summary):
    """Extract project tags from event title"""
    if not event_summary:
        return []

    tags = []

    # Match #project-name tags
    hash_tags = re.findall(r'#([a-z0-9-]+)', event_summary.lower())
    tags.extend(hash_tags)

    # Match CamelCase project names (e.g., "MobileApp" -> "mobile-app")
    camel_case = re.findall(r'\b([A-Z][a-z]+(?:[A-Z][a-z]+)+)\b', event_summary)
    for name in camel_case:
        camel_tag = '-'.join(re.findall('[A-Z][a-z]*', name)).lower()
        if camel_tag and camel_tag not in tags:
            tags.append(camel_tag)

    # Match quoted phrases (e.g., "Mobile App" -> "mobile-app")
    quoted = re.findall(r'"([^"]+)"', event_summary)
    for phrase in quoted:
        if len(phrase.split()) > 1:  # Multi-word phrase
            quoted_tag = '-'.join(phrase.lower().split())
            quoted_tag = re.sub(r'[^a-z0-9-]', '', quoted_tag)
            if quoted_tag and quoted_tag not in tags:
                tags.append(quoted_tag)

    return list(set(tags))  # Remove duplicates

def format_calendar_section(events):
    """Format all events for daily note calendar section"""
    if not events:
        return {
            'markdown': 'No calendar events scheduled for today.',
            'project_tags': []
        }

    lines = []
    all_tags = set()

    for event in events:
        try:
            lines.append(format_event_markdown(event))
            tags = extract_project_tags(event.get('summary', ''))
            all_tags.update(tags)
        except Exception as e:
            continue

    markdown = '\n'.join(lines) if lines else 'No calendar events scheduled for today.'

    return {
        'markdown': markdown,
        'project_tags': sorted(list(all_tags))
    }

def main():
    """Test the formatter with sample data"""
    samples = [
        {
            'start': '2026-02-02T09:00:00Z',
            'end': '2026-02-02T10:00:00Z',
            'summary': 'Team Standup #mobile-app'
        },
        {
            'start': '2026-02-02T11:00:00Z',
            'end': '2026-02-02T12:00:00Z',
            'summary': 'Sprint Planning - "Website Redesign"'
        },
        {
            'start': '2026-02-02T14:00:00Z',
            'end': '2026-02-02T15:00:00Z',
            'summary': '1:1 with Manager'
        }
    ]

    for event in samples:
        print(format_event_markdown(event))
        print(f"  Tags: {extract_project_tags(event['summary'])}")
        print()

    result = format_calendar_section(samples)
    print("Formatted Calendar Section:")
    print(result['markdown'])
    print(f"\nExtracted Project Tags: {result['project_tags']}")

if __name__ == '__main__':
    main()
