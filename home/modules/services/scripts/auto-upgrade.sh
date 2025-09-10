#!/usr/bin/env bash
set -euo pipefail

# Wait until the internet is reachable
# I'd make the service wait for internet, but cant be bothered, so here's chatgpt's solution
until ping -c1 8.8.8.8 &>/dev/null; do
    notify-send "System Upgrade" "Waiting for internet..."
    sleep 10
done

cd /home/dastarruer/.dotfiles

notify-send "System Upgrade" "It's that time of the day! Upgrading system... Please stand by..."

# First do a system rebuild
# if ! echo "$SUDO_PASSWORD" | sudo -S nixos-rebuild switch --flake "/home/$USER/.dotfiles" --max-jobs 4 --cores 4; then
#     notify-send "Upgrade Failed" "System rebuild failed. Check service status for details."
#     git restore flake.lock
#     exit 1
# fi

# notify-send "System Upgrade" "System updated successfully! now for home-manager"

# Then a hm rebuild
if ! home-manager switch --flake "/home/$USER/.dotfiles" -b backup --max-jobs 4 --cores 4 --impure; then
    notify-send "Upgrade Failed" "home-manager rebuild failed. Check service status for details."
    git restore flake.lock
    exit 1
fi

notify-send "System Upgrade" "all done! home-manager updated successfully."
