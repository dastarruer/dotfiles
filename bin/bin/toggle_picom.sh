#!/bin/bash

if pgrep -x "picom" > /dev/null
then
    notify-send -t 1000 "Picom is running. Stopping Picom..."
    pkill picom
else
    notify-send -t 1000 "Picom is not running. Starting Picom..."
    picom --config ~/.config/picom/picom.conf &
fi
