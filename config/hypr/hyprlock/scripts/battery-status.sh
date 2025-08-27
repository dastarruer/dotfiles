#!/usr/bin/env bash

status="$(cat /sys/class/power_supply/BAT0/status)"
level="$(cat /sys/class/power_supply/BAT0/capacity)"

if [[ "$status" == "Discharging" || "$status" == "Full" ]]; then
  if [[ "$level" -eq 0 ]]; then
    echo "$level% "
  elif [[ "$level" -ge 1 && "$level" -le 25 ]]; then
    echo "$level% "
  elif [[ "$level" -ge 26 && "$level" -le 50 ]]; then
    echo "$level% "
  elif [[ "$level" -ge 51 && "$level" -le 75 ]]; then
    echo "$level% "
  elif [[ "$level" -ge 76 && "$level" -le 100 ]]; then
    echo "$level% "
  fi
elif [[ "$status" == "Charging" ]]; then
  echo "$level% "
fi
