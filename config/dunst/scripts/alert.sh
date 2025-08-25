#!/usr/bin/env bash

if [ "$DUNST_BODY" != "^Volume" ] && [ "$DUNST_BODY" != "^Brightness" ] && [ "$DUNST_APP_NAME" != "Spotify" ]; then
    pw-play $HOME/.config/dunst/alerts/default.wav
fi
