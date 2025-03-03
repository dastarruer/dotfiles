#!/bin/bash

# AirPods MAC Address 
source ~/.airpods_mac

notify-send -t 4000 "Restarting bluetooth..."
bluetoothctl <<EOF
power off
exit
EOF
sleep 5  # Give Bluetooth time to restart

notify-send -t 1000 "Connecting to AirPods..."
bluetoothctl <<EOF
power on
agent on
default-agent
trust $AIRPODS_MAC
connect $AIRPODS_MAC
EOF

# Check if connected
if bluetoothctl info "$AIRPODS_MAC" | grep -q "Connected: yes"; then
    notify-send -t 1000 "✅ Successfully connected to AirPods!"
else
    notify-send -t 1000 "❌ Failed to connect. Try again."
fi
