#!/bin/bash

# Check if Wi-Fi is enabled
wifi_status=$(nmcli radio wifi)

if [ "$wifi_status" = "enabled" ]; then
    # Get the current connected Wi-Fi name
    wifi_name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d':' -f2)
    
    if [ -n "$wifi_name" ]; then
        echo "󰖩 $wifi_name"
    else
        echo "󰖪 No wifi"
    fi
else
    echo "󰖪 Disconnected"
fi
