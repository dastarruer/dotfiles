#!/usr/bin/env bash
set -euo pipefail

# Wait until the internet is reachable
# I'd make the service wait for internet, but cant be bothered, so here's chatgpt's solution
until ping -c1 8.8.8.8 &>/dev/null; do
    notify-send "System Upgrade" "Waiting for internet..."
    sleep 10
done

if ! nix flake update --flake /home/$USER/.dotfiles; then
    notify-send "Flake update failed" "Unable to update flake.lock. Check service status for details."
    exit 1
fi

git add flake.lock
git commit -m "Update system"
git push

notify-send "Git status" "Pushed flake.lock successfully"
