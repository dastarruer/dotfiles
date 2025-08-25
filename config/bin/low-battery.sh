#!/usr/bin/env bash

while true; do
    capacity=$(cat /sys/class/power_supply/BAT0/capacity)
    status=$(cat /sys/class/power_supply/BAT0/status)
    if [ "$capacity" -le 30 ] && [ "$status" = "Discharging" ]; then
    notify-send -u critical 'Battery low' "Battery at ${capacity}%"
    sleep 300  # wait 5 min before notifying again
    else
    sleep 60   # check every minute
    fi
done
