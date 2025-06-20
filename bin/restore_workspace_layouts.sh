#!/usr/bin/env bash

# Check if i3-resurrect is installed
if ! command -v i3-resurrect &> /dev/null
then
    echo "i3-resurrect could not be found. Please install it first."
    exit 1
fi

# restore workspaces 1-10
for workspace in {1..10}
do
    echo "Restoring workspace $workspace..."
    i3-resurrect restore -w $workspace
    if [ $? -ne 0 ]; then
        echo "Failed to restore workspace $workspace."
    else
        echo "Workspace $workspace restored successfully."
    fi
done

notify-send "All workspaces have been processed."
