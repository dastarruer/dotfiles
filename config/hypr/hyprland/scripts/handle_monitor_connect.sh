#!/usr/bin/env bash
# https://wiki.hypr.land/FAQ/#how-do-i-move-my-favorite-workspaces-to-a-new-monitor-when-i-plug-it-in

handle() {
  case $1 in monitoradded*)
    ./move_windows_to_monitor.sh
  esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
