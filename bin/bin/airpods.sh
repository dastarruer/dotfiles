#!/bin/bash

# Headphones MAC Address 
source ~/.headphones_mac

dunstctl close-all
bluetoothctl power on
if bluetoothctl info "$HEADPHONES_MAC" | grep 'Connected: yes' -q; then
    playerctl pause -a
    # Restart bluetooth
    notify-send -t 4000 "Restarting bluetooth..."
    bluetoothctl power off
    bluetoothctl power on

    # Connect headphones
    notify-send -t 4000 "Connecting to headphones..."
    bluetoothctl connect "$HEADPHONES_MAC"
    playerctl play -a
else
    # Connect headphones
    notify-send -t 4000 "Connecting to headphones..."
    bluetoothctl connect "$HEADPHONES_MAC"
fi

