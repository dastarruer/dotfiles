#!/usr/bin/env bash

if [ "$DUNST_APP_NAME" != "Spotify" ] && [ "$DUNST_APP_NAME" != "flameshot" ]; then
    pw-play $HOME/.config/dunst/alerts/default.wav
fi
