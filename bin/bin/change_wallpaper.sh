#!/usr/bin/env bash

# File to store the previous theme
THEME_FILE="$HOME/.previous_theme"

# Current theme
CURRENT=$(cat ~/.current_theme)

# Check if the previous theme is different from the current one
if [[ -f "$THEME_FILE" ]]; then
    PREVIOUS=$(<"$THEME_FILE")
else
    PREVIOUS=""
fi

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers/$CURRENT"

# File to track the last selected wallpaper
INDEX_FILE="$HOME/.current_wallpaper_index"

# Get the list of wallpapers in sorted order
WALLPAPERS=($(find "$WALLPAPER_DIR" -type f | sort))

# Total number of wallpapers
NUM_WALLPAPERS=${#WALLPAPERS[@]}

# If the theme has changed, reset the index
if [[ "$CURRENT" != "$PREVIOUS" ]]; then
    echo "Theme changed from $PREVIOUS to $CURRENT. Resetting wallpaper index."
    CURRENT_INDEX=0
else
    # Load or initialize the current index
    if [[ -f "$INDEX_FILE" ]]; then
        CURRENT_INDEX=$(<"$INDEX_FILE")
    else
        CURRENT_INDEX=0
    fi
fi

# Calculate the next index
NEXT_INDEX=$(( (CURRENT_INDEX + 1) % NUM_WALLPAPERS ))

# Set the new wallpaper
if [[ "$CURRENT" == "other" ]]; then
    wal -i "${WALLPAPERS[$NEXT_INDEX]}" --saturate 0.75
    pywalfox update
else 
    swww img "${WALLPAPERS[$NEXT_INDEX]}" -t wipe --transition-angle 30 --transition-duration 1
fi

# & disown will make the command run in the background so i can run the script multiple times back to back
betterlockscreen -u "${WALLPAPERS[$NEXT_INDEX]}" & disown

# Update the index file
echo "$NEXT_INDEX" > "$INDEX_FILE"

# Store the current theme as the previous theme
echo "$CURRENT" > "$THEME_FILE"

# Notify user
notify-send -t 1000 "Wallpaper set to: $(basename "${WALLPAPERS[$NEXT_INDEX]}")"
