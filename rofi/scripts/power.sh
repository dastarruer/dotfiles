#!/usr/bin/env bash

# Define options
OPTIONS=" Lock\n󰗽 Logout\n󰥔 Suspend\n Reboot\n Shutdown"

# Show the menu and get the user's choice
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -p "Power Menu:")

case "$CHOICE" in
" Lock")
    # Lock the screen
    # betterlockscreen --lock
    hyprlock
    ;;
"󰗽 Logout")
    # ~/bin/save_workspace_layouts.sh
    # i3-msg exit
    l
    # Logout from the current session
    hyprctl dispatch exit
    ;;
"󰥔 Suspend")
    playerctl -a pause
    hyprlock & disown

    # Suspend the system
    systemctl suspend
    ;;
" Reboot")
    # ~/bin/save_workspace_layouts.sh
    # Reboot the system
    systemctl reboot
    ;;
" Shutdown")
    # ~/bin/save_workspace_layouts.sh
    # Shutdown the system
    systemctl poweroff
    ;;
*)
    # Do nothing on an invalid choice
    exit 1
    ;;
esac
