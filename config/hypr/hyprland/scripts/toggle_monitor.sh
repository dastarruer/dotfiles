#!/usr/bin/env bash

# Get the current DPMS state of HDMI-A-1
STATE=$(hyprctl monitors | grep -A20 "HDMI-A-1" | grep "dpmsStatus" | awk '{print $2}')

# Toggle based on the current state
if [ "$STATE" = 1 ]; then
    # If currently on, turn off
    hyprctl dispatch dpms off HDMI-A-1
    echo "HDMI-A-1 turned off"
else
    # If currently off, turn on
    hyprctl dispatch dpms on HDMI-A-1
    echo "HDMI-A-1 turned on"
fi
