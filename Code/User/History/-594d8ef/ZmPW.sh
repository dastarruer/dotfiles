#!/bin/bash

# The .config directory
CONFIG="$HOME/.config"

for dir in "$CONFIG"/*/; do 
    echo "Adding $dir"
    cd "$dir" || continue

    git add .

    echo "Changes for $dir pushed"
git commit -m "Automated commit"
git push 
done
