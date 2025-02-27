#!/bin/bash

# Check the input argument
if [ "$1" = "off" ]; then
    # Notify and turn off Wi-Fi
    notify-send -t 1000 "Turning off Wi-Fi..."
    nmcli radio wifi off
elif [ "$1" = "on" ]; then
    # Notify and turn on Wi-Fi
    notify-send -t 1000 "Turning on Wi-Fi..."
    nmcli radio wifi on
else
    # Default: toggle Wi-Fi based on current state
    wifi_status=$(nmcli radio wifi)
    if [ "$wifi_status" = "enabled" ]; then
        notify-send -t 1000 "Turning off Wi-Fi..."
        nmcli radio wifi off
    else
        notify-send -t 1000 "Turning on Wi-Fi..."
        nmcli radio wifi on
    fi
fi
