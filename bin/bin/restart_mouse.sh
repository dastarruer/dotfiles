#!/usr/bin/env bash

# Device ID to reset
DEVICE_ID=11

# Disable the device
echo "Disabling device ID $DEVICE_ID..."
xinput disable $DEVICE_ID

# Wait for a moment
sleep 1

# Enable the device
echo "Enabling device ID $DEVICE_ID..."
xinput enable $DEVICE_ID

echo "Device ID $DEVICE_ID has been reset."
``
