#!/usr/bin/env bash

if [ "$DUNST_APP_NAME" != "Spotify" ] && \
   [ "$DUNST_APP_NAME" != "flameshot" ] && \
   [[ "$DUNST_SUMMARY" != *"Wallpaper set to:"* ]]; then
    # Only play if no pw-play process is currently running
    if ! pgrep -x pw-play >/dev/null; then
        pw-play "$HOME/.config/dunst/alerts/default.wav" &
    fi
fi
