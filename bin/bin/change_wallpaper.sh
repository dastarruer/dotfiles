#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

# File to track the last selected wallpaper
INDEX_FILE="$HOME/.current_wallpaper_index"

# Get the list of wallpapers in sorted order
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f | sort))

# Total number of wallpapers
NUM_WALLPAPERS=${#WALLPAPERS[@]}

# Load or initialize the current index
if [[ -f "$INDEX_FILE" ]]; then
    CURRENT_INDEX=$(<"$INDEX_FILE")
else
    CURRENT_INDEX=0
fi

# Calculate the next index
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_WALLPAPERS ))

# Set the new wallpaper
wal -i "${WALLPAPERS[$NEXT_INDEX]}" --saturate 0.75
betterlockscreen -u "${WALLPAPERS[$NEXT_INDEX]}"
pywalfox update

# Update the index file
echo "$NEXT_INDEX" > "$INDEX_FILE"

# Notify user
notify-send -t 1000 "Wallpaper set to: $(basename "${WALLPAPERS[$NEXT_INDEX]}")"
