#!/usr/bin/env bash
# Get current workspace ID
workspace_id=$(hyprctl activeworkspace -j | jq ".id")

# Get the address of a Firefox window on the current workspace, if any
current_ff_address=$(hyprctl clients -j | jq -r ".[] | select(.initialClass == \"firefox-nightly\" and .workspace.id == $workspace_id) | .address")

# Get the URL from the first argument
url="$1"

# Check if a URL was provided
if [ -z "$url" ]; then
    echo "No URL provided" >&2
    exit 1
fi

if [ -n "$current_ff_address" ]; then
    # Focus the existing Firefox window
    hyprctl dispatch focuswindow address:"$current_ff_address"
    # Open the URL in a new tab
    firefox-nightly --new-tab "$url" &
else
    # No Firefox window on this workspace, open a new window
    firefox-nightly --new-window "$url" &
fi
