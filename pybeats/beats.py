#!/usr/bin/env python3

import datetime

def get_beats():
    # Get current UTC time using the recommended timezone-aware approach
    utc_now = datetime.datetime.now(datetime.UTC)
    
    # Convert to UTC+1 by adding 1 hour
    biel_time = utc_now + datetime.timedelta(hours=1)
    
    # Calculate beats
    # One beat is 86.4 seconds (24 hours = 86400 seconds divided by 1000 beats)
    seconds_since_midnight = (
        biel_time.hour * 3600 +
        biel_time.minute * 60 +
        biel_time.second +
        biel_time.microsecond / 1_000_000
    )
    beats = seconds_since_midnight / 86.4
    
    return f"@{beats:.3f}"

if __name__ == "__main__":
    print(get_beats())
