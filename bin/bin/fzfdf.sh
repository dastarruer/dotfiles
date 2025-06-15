#!/usr/bin/env bash
cd ~/.dotfiles 
file=$(find . -type f | fzf)   
if [ -n "$file" ]; then
    nano "$(realpath "$file")"  # Use the absolute path
else
    echo "No file selected."
fi
