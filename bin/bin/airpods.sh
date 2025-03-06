#!/bin/bash

# Headphones MAC Address 
source ~/.headphones_mac

dunstctl close-all
bluetoothctl power on
if bluetoothctl info "$HEADPHONES_MAC" | grep 'Connected: yes' -q; then
    # Restart bluetooth
    notify-send -t 4000 "Restarting bluetooth..."
    bluetoothctl power off
    bluetoothctl power on

    # Connect headphones
    notify-send -t 4000 "Connecting to headphones..."
    bluetoothctl connect "$HEADPHONES_MAC"
else
    # Connect headphones
    notify-send -t 4000 "Connecting to headphones..."
    bluetoothctl connect "$HEADPHONES_MAC"
fi

# notify-send -t 4000 "Restarting bluetooth..."
# bluetoothctl <<EOF
# power off
# exit
# EOF

# notify-send -t 1000 "Connecting to AirPods..."
# bluetoothctl <<EOF
# power on
# agent on
# default-agent
# trust $HEADPHONES_MAC
# connect $HEADPHONES_MAC
# EOF
# notify-send -t 4000 "Done!"

# # Check if connected
# if bluetoothctl info "$HEADPHONES_MAC" | grep -q "Connected: yes"; then
#     notify-send -t 1000 "✅ Successfully connected to AirPods!"
# else
#     notify-send -t 1000 "❌ Failed to connect. Try again."
# fi
