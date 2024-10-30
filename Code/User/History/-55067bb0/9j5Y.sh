#!/bin/bash

# If the user forgets to provide a commit message
if [ $# -eq 0 ]; then
  echo "Error: No commit message provided."
  echo "Usage: $0 <commit-message>"
  exit 1
fi

# The .config directory
CONFIG="$HOME/.config"

COMMIT_MESSAGE="$1"

for dir in "$CONFIG"/*/; do 
    echo "Adding $dir"
    cd "$dir" || continue

    git add .
    git commit -m "$COMMIT_MESSAGE"

    echo "Changes for $dir pushed"
    
    done

git push origin master

