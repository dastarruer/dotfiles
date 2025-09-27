#!/usr/bin/env bash

if [ "$DUNST_APP_NAME" != "Spotify" ] && \
   [ "$DUNST_APP_NAME" != "flameshot" ] && \
   [[ "$DUNST_SUMMARY" != *"Wallpaper set to:"* ]]; then
    pw-play "$HOME/.config/dunst/alerts/default.wav"
fi
