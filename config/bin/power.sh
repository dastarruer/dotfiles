#!/usr/bin/env bash

# Define options
OPTIONS=" Lock\n󰗽 Logout\n󰥔 Suspend\n Reboot\n Shutdown"

# Show the menu and get the user's choice
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Menu:")

case "$CHOICE" in
" Lock")
    hyprlock
    ;;
"󰗽 Logout")
    # ~/bin/save_workspace_layouts.sh
    hyprctl dispatch exit
    ;;
"󰥔 Suspend")
    $HOME/bin/pause-all.sh
    systemctl suspend
    ;;
" Reboot")
    # ~/bin/save_workspace_layouts.sh
    systemctl reboot
    ;;
" Shutdown")
    # ~/bin/save_workspace_layouts.sh
    systemctl poweroff
    ;;
*)
    exit 1
    ;;
esac
