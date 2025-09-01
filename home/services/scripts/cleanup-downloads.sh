#!/usr/bin/env bash

# This is a necessary wrapper around notify-send in order to send notifications from a systemd service
notify() {
    local title=$1
    local message=$2

    if [ -n "${DISPLAY-}" ] || [ -n "${WAYLAND_DISPLAY-}" ]; then
        # GUI session available
         DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USERID/bus" \
            notify-send "$title" "$message"
    else
        # Headless / systemd run → fallback to stderr
        echo "[$title] $message" >&2
    fi
}

notify "Clearing downloads directory..."

# Delete files older than five days in the downloads dir
find $HOME/Downloads -mindepth 1 -mtime +5 -delete

notify "Cleared downloads directory."
