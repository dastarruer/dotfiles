#!/bin/bash

# The .config directory
CONFIG="$HOME/.config"

for dir in "$CONFIG"/*/; do 
    echo "Adding $dir"
    cd "$dir" || continue

    git add .
    git commit -m "Automated commit"
    git push

    echo "Changes for $dir pushed"
done