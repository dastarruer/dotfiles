#!/usr/bin/env bash

waybar &
swww-daemon &
nm-applet &

# Start apps
./apps.sh

# Start script to move all windows to second workspace on connect
./handle_monitor_connect.sh

# Start clipboard manager
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
