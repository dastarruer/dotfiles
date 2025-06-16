#!/usr/bin/env bash

dotfiles="$HOME/.dotfiles"
nix="$dotfiles/nix/.config/nix"

# Get commit message
if [ -z "$1" ]; then
  COMMIT_MESSAGE="stuff"
else
  COMMIT_MESSAGE="$1"
fi

# Lint all nix files
alejandra $nix

cd "$dotfiles"
git add .
git commit -m "$COMMIT_MESSAGE"
git push & disown
