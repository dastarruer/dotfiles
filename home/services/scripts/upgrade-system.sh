#!/usr/bin/env bash
set -euo pipefail

USER="dastarruer"
USERID=$(id -u "$USER")

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

notify "System Upgrade" "It's that time of the day! Upgrading system... Please stand by..."

if ! nix flake update --flake /home/$USER/.dotfiles; then
    notify "Upgrade Failed" "Unable to update flake.lock. Check service status for details."
    exit 1
fi

if ! nixos-rebuild switch --flake "/home/$USER/.dotfiles" --impure --max-jobs 4 --cores 4; then
    notify "Upgrade Failed" "System rebuild failed. Check service status for details."
    git restore flake.lock
    exit 1
fi

notify "System Upgrade" "System updated successfully!. pls push it manually later"

