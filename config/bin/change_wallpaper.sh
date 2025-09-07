#!/usr/bin/env bash
HYPRLOCK_CONFIG="$HOME/.cache/hypr/hyprlock-background.conf"

# File to track the last selected wallpaper
INDEX_FILE="$HOME/.cache/.current_wallpaper_index"

CURRENT_INDEX=$(cat $INDEX_FILE)

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

# Get the list of wallpapers in sorted order
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f | sort))

# Total number of wallpapers
NUM_WALLPAPERS=${#WALLPAPERS[@]}

# Calculate the next index
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_WALLPAPERS ))

# Set the new wallpaper
swww img "${WALLPAPERS[$NEXT_INDEX]}" -t wipe --transition-angle 30 --transition-duration 1

# Add the wallpaper to hyprlock
echo "\$background = ${WALLPAPERS[$NEXT_INDEX]}" > $HYPRLOCK_CONFIG

# & disown will make the command run in the background so i can run the script multiple times back to back
# betterlockscreen -u "${WALLPAPERS[$NEXT_INDEX]}" & disown

# Update the index file
echo "$NEXT_INDEX" > "$INDEX_FILE"

# Notify user
notify-send -t 1000 "Wallpaper set to: $(basename "${WALLPAPERS[$NEXT_INDEX]}")"
