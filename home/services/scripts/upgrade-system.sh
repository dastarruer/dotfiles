#!/usr/bin/env bash
set -euo pipefail

# $SUDO_PASSWORD is declared in upgrade-system.nix
SUDO_PASSWORD="$(cat "$SUDO_PASSWORD")"

# This is a necessary wrapper around notify-send in order to send notifications from a systemd service
USER="dastarruer"
USERID=$(id -u "$USER")
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

# Wait until the internet is reachable
# I'd make the service wait for internet, but cant be bothered
until ping -c1 8.8.8.8 &>/dev/null; do
    sleep 10
done

cd /home/dastarruer/.dotfiles

notify "System Upgrade" "It's that time of the day! Upgrading system... Please stand by..."

if ! nix flake update --flake /home/$USER/.dotfiles; then
    notify "Upgrade Failed" "Unable to update flake.lock. Check service status for details."
    exit 1
fi

if ! echo "$SUDO_PASSWORD" | sudo -S nixos-rebuild switch --flake "/home/$USER/.dotfiles" --impure --max-jobs 4 --cores 4; then
    notify "Upgrade Failed" "System rebuild failed. Check service status for details."
    git restore flake.lock
    exit 1
fi

notify "System Upgrade" "System updated successfully!."

git add flake.lock
git commit -m "Update system"
git push

notify "Git status" "Pushed flake.lock successfully"
