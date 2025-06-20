#!/usr/bin/env bash

# Headphones MAC Address
source ~/.headphones_mac

# Turn on Bluetooth or fallback
bluetoothctl power on || {
    notify-send -t 1000 "Failed to turn on Bluetooth, opening Blueman..."
    blueman-manager &
    exit 1
}

# Store the player that was playing
ACTIVE_PLAYER=$(playerctl -l | while read player; do
    if playerctl -p "$player" status 2>/dev/null | grep -q Playing; then
        echo "$player"
        break
    fi
done)

# Pause all players
playerctl pause -a

# If already connected, restart Bluetooth to refresh
if bluetoothctl info "$HEADPHONES_MAC" | grep 'Connected: yes' -q; then
    notify-send -t 4000 "Restarting Bluetooth..."
    bluetoothctl power off
    bluetoothctl power on
fi

# Connect headphones
notify-send -t 4000 "Connecting to headphones..."
bluetoothctl connect "$HEADPHONES_MAC" || {
    notify-send -t 4000 "Failed to connect headphones. Please try again."
    exit 1
}

# Resume only the previously playing player
if [ -n "$ACTIVE_PLAYER" ]; then
    sleep 2
    playerctl -p "$ACTIVE_PLAYER" play
fi
