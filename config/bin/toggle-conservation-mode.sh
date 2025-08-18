 #!/usr/bin/env bash
# Enable conservation mode if my mouse is plugged in
    # I usually use my mouse at home when I need conservation mode enabled
BATTERY_PATH="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

# ID for mouse
MOUSE_ID="046d:c077"

while true; do
    # Check if devices are connected
    MOUSE_PRESENT=$(/run/current-system/sw/bin/lsusb | grep -i "$MOUSE_ID")

    if [[ -n "$MOUSE_PRESENT" ]]; then
        echo 1 > "$BATTERY_PATH" 2>/dev/null
        echo "toggle conservation mode on"
    else
        echo 0 > "$BATTERY_PATH" 2>/dev/null
        echo "toggle conservation mode off"
    fi

    sleep 10
done
