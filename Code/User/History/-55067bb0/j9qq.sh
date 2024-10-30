#!/bin/bash

# The .config directory
CONFIG="$HOME/.config"

for dir in "$CONFIG"/*/; do 
    echo "Adding $dir"
    cd "$dir" || continue

    git add .
    

    echo "Changes for $dir pushed"
    
    done

git push origin master

