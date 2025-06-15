#!/usr/bin/env bash

# Preferred gap sizes (adjust as needed)
OUTER_GAP=10
INNER_GAP=1

# Get current inner gap size
current_gap=$(i3-msg -t get_tree | jq '.. | objects | select(.focused?) | .window_properties? | .inner_gap // empty')

# Check if Polybar is running
if pgrep -x "polybar" > /dev/null; then
    POLYBAR_RUNNING=true
else
    POLYBAR_RUNNING=false
fi

if [[ "$current_gap" -gt 0 ]]; then
    # Disable gaps and hide Polybar
    i3-msg gaps inner all set 0
    i3-msg gaps outer all set 0
    pkill polybar
else
    # Restore gaps and restart Polybar
    i3-msg gaps inner all set "$INNER_GAP"
    i3-msg gaps outer all set "$OUTER_GAP"
    polybar &
fi
