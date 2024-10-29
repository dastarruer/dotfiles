#!/bin/bash

# The .config directory
CONFIG="~/.config"

for dir in "$CONFIG"/*/; do 
    echo "Adding $dir"
    cd "$dir" || continue

    git add .
    git commit -m ""