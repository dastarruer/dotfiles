#!/usr/bin/env bash

waybar &
swww-daemon &
nm-applet &
hypridle &

# Start apps
todoist-electron &
anki &
spotify &
firefox &
flatpak run md.obsidian.Obsidian &

# Start clipboard manager
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
