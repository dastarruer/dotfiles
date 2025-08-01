#!/usr/bin/env bash

# Define directories
USB_DEVICE="/dev/sda1"
MOUNT_POINT="/media/dastarruer/mnt"
USB_SOURCE_DIRS=("$HOME/Documents/sheet-music" "$HOME/Documents/vault" "$HOME/Documents/books" "$HOME/Documents/school" "$HOME/Pictures/trips" "$HOME/.ssh")
GDRIVE_SOURCE_DIRS=("$HOME/Documents/sheet-music" "$HOME/Documents/books" "$HOME/Documents/school" "$HOME/Pictures/trips")

REMOTE="gdrive:Backups"

echo "Backing up to Google Drive now..."

# Backup to gdrive
for DIR in "${GDRIVE_SOURCE_DIRS[@]}"; do
  if [ -d "$DIR" ]; then
    DEST="$REMOTE/$(basename "$DIR")"
    echo "Backing up $DIR to $DEST..."
    rclone sync "$DIR" "$DEST" -P || { echo "Backup failed for $DIR"; exit 1; }
  else
    echo "Warning: $DIR does not exist, skipping."
  fi
done

# Mount the USB drive
echo "Mounting USB drive..."
if sudo mount "$USB_DEVICE" "$MOUNT_POINT"; then
    echo "Drive mounted successfully at $MOUNT_POINT."
else
    echo "Drive mount failed. Either re-insert the USB or check the connection."
    exit 1
fi

# Verify the USB is mounted
if ! mount | grep -q "$MOUNT_POINT"; then
    echo "Error: USB is not mounted at $MOUNT_POINT. Aborting backup."
    exit 1
fi

# Perform backup to USB
for DIR in "${USB_SOURCE_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "Backing up $DIR to $MOUNT_POINT..."
        if sudo rsync -avh --progress --delete "$DIR" "$MOUNT_POINT"; then
            echo "Backup of $DIR completed successfully."
        else
            echo "Backup of $DIR failed."
            exit 1
        fi
    else
        echo "Warning: Source directory $DIR does not exist. Skipping..."
    fi
done

notify-send "Backup complete. Check terminal por favor." -t 3000
echo "Check if files are properly synced at $MOUNT_POINT. Remember to close the tab afterwards, and then press enter to eject:"
read

# Eject USB drive
echo "Ejecting USB drive..."
if sudo eject "$USB_DEVICE"; then
    echo "Drive ejected safely. You can remove it now."
else
    echo "Failed to eject the drive. If you have a tab open currently in the mount directory, close it. Eject manually with: 'sudo eject $USB_DEVICE'"
    exit 1
fi

