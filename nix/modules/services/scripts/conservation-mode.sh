#!/usr/bin/env bash

# Enable conservation mode if my mouse is plugged in
# I usually use my mouse at home when I need conservation mode enabled
BATTERY_PATH="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
MOUSE_ID="046d:c077"

if lsusb | grep -iq "$MOUSE_ID"; then
    echo 1 | tee "$BATTERY_PATH"
    echo "toggle conservation mode on"
else
    echo 0 | tee "$BATTERY_PATH"
    echo "toggle conservation mode off"
fi
