#!/bin/sh

# Fetch weather from wttr.in (replace with your location)
# Format: condition icon + temperature
WEATHER=$(curl -s "wttr.in/?format=%c+%t" 2>/dev/null)

if [ -n "$WEATHER" ]; then
    echo "$WEATHER"
else
    echo "N/A"
fi
