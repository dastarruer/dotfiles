#!/usr/bin/env bash
set -euo pipefail

# This is a necessary wrapper around notify-send in order to send notifications from a systemd service
USER="dastarruer"
USERID=$(id -u "$USER")
notify() {
    local title=$1
    local message=$2

    if [ -n "${DISPLAY-}" ] || [ -n "${WAYLAND_DISPLAY-}" ]; then
        # GUI session available
        sudo -u "$USER" DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USERID/bus" \
            notify-send "$title" "$message"

    else
        # Headless / systemd run → fallback to stderr
        echo "[$title] $message" >&2
    fi
}

# Wait until the internet is reachable
# I'd make the service wait for internet, but cant be bothered, so here's chatgpt's solution
until ping -c1 8.8.8.8 &>/dev/null; do
    notify "System Upgrade" "Waiting for internet..."
    sleep 10
done

notify "System Upgrade" "It's that time of the day! Upgrading system... Please stand by..."

# First do a system rebuild
# if ! echo "$SUDO_PASSWORD" | sudo -S nixos-rebuild switch --flake "/home/$USER/.dotfiles" --max-jobs 4 --cores 4; then
#     notify "Upgrade Failed" "System rebuild failed. Check service status for details."
#     git restore flake.lock
#     exit 1
# fi

<<<<<<<< Updated upstream:home/modules/services/scripts/auto-upgrade.sh
# notify "System Upgrade" "System updated successfully! now for home-manager"

# Then a hm rebuild
if ! home-manager switch --flake "/home/$USER/.dotfiles" -b backup --max-jobs 4 --cores 4 --impure; then
    notify "Upgrade Failed" "home-manager rebuild failed. Check service status for details."
========
if ! nixos-rebuild switch --flake "/home/$USER/.dotfiles" --impure --max-jobs 4 --cores 4; then
    notify "Upgrade Failed" "System rebuild failed. Check service status for details."
>>>>>>>> Stashed changes:nix/modules/services/scripts/upgrade-system.sh
    git restore flake.lock
    exit 1
fi

<<<<<<<< Updated upstream:home/modules/services/scripts/auto-upgrade.sh
notify "System Upgrade" "all done! home-manager updated successfully."
========
notify "System Upgrade" "System updated successfully!."


>>>>>>>> Stashed changes:nix/modules/services/scripts/upgrade-system.sh
