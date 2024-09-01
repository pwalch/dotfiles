#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Print date and time to keyboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📅

# Exit Raycast menu (will trigger Accessibility permission for Raycast)

set -euo pipefail

sleep 0.2
if ! echo "tell application \"System Events\" to key code 53" | osascript; then
    echo "ERROR: Could not type ESCAPE key" >&2
    exit 1
fi

# Sleep to ensure key used to trigger the shortcut has been released
sleep 0.5

# Store current date in YYYYMMDD-HHMM-UTC format
current_date="$(gdate -u +%Y%m%d-%H%M-%Z)"

if ! echo "tell application \"System Events\" to keystroke \"${current_date}\"" | osascript; then
    echo "ERROR: Could not type date" >&2
    exit 1
fi

echo "Printed date to keyboard"
