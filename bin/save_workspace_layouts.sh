#!/usr/bin/env bash

echo "Shutdown script executed at $(date)" >> /var/log/shutdown.log

# Check if i3-resurrect is installed
if ! command -v i3-resurrect &> /dev/null
then
    echo "i3-resurrect could not be found. Please install it first."
    exit 1
fi

notify-send "Saving layout..." -t 5000
# Save workspaces 1-10
for workspace in {1..10}
do
    echo "Saving workspace $workspace..."
    i3-resurrect save -w $workspace
    if [ $? -ne 0 ]; then
        echo "Failed to save workspace $workspace."
	notify-send "Failed to save workspace $workspace." -t 5000
    else
        echo "Workspace $workspace saved successfully."
    fi
done
notify-send "Saved layout." -t 5000
exit 0
