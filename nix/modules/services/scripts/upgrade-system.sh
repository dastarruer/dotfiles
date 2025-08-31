#!/usr/bin/env bash

notify-send "Updating system..."

cd $HOME/.dotfiles

nix flake update
sudo nixos-rebuild switch --flake ~/.dotfiles --impure || notify-send "System update failed." "Check service status for more information."

notify-send "Updated system." "enjoy."

# Commit and push flake.lock
git add flake.lock
git commit -m "Update flake.lock"
git push
