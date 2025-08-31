#!/usr/bin/env bash

notify-send "Updating system..."

cd /home/dastarruer/.dotfiles

nix flake update \
  || { notify-send "Unable to update flake.lock." "Check service status for more information."; exit 1; }

sudo nixos-rebuild switch --flake ~/.dotfiles --impure --max-jobs 4 --cores 4 \
  || { notify-send "Upgrade failed." "Check service status for more information."; git restore flake.lock; exit 1; }

notify-send "Updated system." "enjoy."

# Commit flake.lock
git add flake.lock
git commit -m "Update flake.lock"
git push
