#!/bin/bash

# The .config directory
CONFIG="~/.config"

for dir in "$CONFIG"/*/; do 
    echo "Adding $dir"
    cd "$dir" || continue

    git add .
    git commit -m ""
    git push

    echo "Changes for $dir pushed"
    fi
done