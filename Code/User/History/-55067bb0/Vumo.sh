#!/bin/bash

# The .config directory
CONFIG="$HOME/.config"

for dir in "$CONFIG"/*/; do 
    echo "Adding $dir"
    cd "$dir" || continuegit commit -m "Automated commit"

    git add .
    git commit -m "Automated commit"

    echo "Changes for $dir pushed"
    
    done

git push origin master

