#!/usr/bin/env bash

# Get the current DPMS state of eDP-1
STATE=$(hyprctl monitors | grep -A20 "eDP-1" | grep "dpmsStatus" | awk '{print $2}')

# Toggle based on the current state
if [ "$STATE" = 1 ]; then
    # If currently on, turn off
    hyprctl dispatch dpms off eDP-1
    echo "eDP-1 turned off"
else
    # If currently off, turn on
    hyprctl dispatch dpms on eDP-1
    echo "eDP-1 turned on"
fi
