#!/usr/bin/env bash

PRIVATE_DOTFILES="$HOME/.dotfiles"

# Get commit message
if [ -z "$1" ]; then
  COMMIT_MESSAGE="stuff"
else
  COMMIT_MESSAGE="$1"
fi

cd "$PRIVATE_DOTFILES"
git add .
git commit -m "$COMMIT_MESSAGE"
git push
