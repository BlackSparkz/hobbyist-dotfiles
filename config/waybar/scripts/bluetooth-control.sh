#!/bin/bash

# Bluetooth device picker and manager using bluetoothctl and fuzzel

# Check if bluetooth is on
POWER_STATE=$(bluetoothctl show | grep "Powered: yes")

if [ -z "$POWER_STATE" ]; then
    # Bluetooth is off, ask to turn on
    CHOICE=$(echo -e "Yes\nNo" | fuzzel --dmenu --prompt="Bluetooth is OFF. Turn ON? " --lines 2 --width 30)
    if [ "$CHOICE" == "Yes" ]; then
        bluetoothctl power on
        sleep 1 # Wait for power up
    else
        exit 0
    fi
fi

# Get list of devices (MAC <space> Name)
# We format it to show Name first for better UI, or just keep default standard
# bluetoothctl devices output: "Device <MAC> <Name>"
# We'll clean it up to display: "<Name>  <MAC>"
DEVICES=$(bluetoothctl devices | awk '{$1=""; print $0}' | sed 's/^ //')

# If no devices found
if [ -z "$DEVICES" ]; then
    notify-send "Bluetooth" "No devices found."
    exit 0
fi

# Show devices in fuzzel
# We display the raw output for simplicity in parsing back the MAC
# Actually, let's just show the output from bluetoothctl devices but stripped of the "Device" prefix for cleaner look
# But we need the MAC for the next command.
# Method: List "MAC Name" (easy to parse) or "Name MAC" (harder if name has spaces)
# Let's stick to "MAC Name" but maybe use column formatting if possible.
# Fuzzel just displays text.
# Let's use the raw list but remove the word "Device " from the start.
DEVICE_LIST=$(bluetoothctl devices | sed 's/^Device //')

# Add an option to Scan
OPT_SCAN="󰂰 Scan for new devices"
FULL_LIST="$OPT_SCAN\n$DEVICE_LIST"

SELECTED=$(echo -e "$FULL_LIST" | fuzzel --dmenu --prompt="Bluetooth Devices: " --width 50)

if [ -z "$SELECTED" ]; then
    exit 0
fi

if [ "$SELECTED" == "$OPT_SCAN" ]; then
    # Start scanning in a terminal or background?
    # Scanning implies we need to wait and see new devices.
    # Simple one-shot scan:
    notify-send "Bluetooth" "Scanning for 10 seconds..."
    timeout 10s bluetoothctl scan on
    # Re-run self to show new devices
    exec "$0"
    exit 0
fi

# Extract MAC address (first word)
MAC=$(echo "$SELECTED" | awk '{print $1}')
DEV_NAME=$(echo "$SELECTED" | cut -d ' ' -f 2-)

# Actions menu
ACTIONS="Connect\nPair\nDisconnect\nTrust\nUntrust\nRemove"
ACTION=$(echo -e "$ACTIONS" | fuzzel --dmenu --prompt="$DEV_NAME Action: " --lines 6 --width 30)

if [ -z "$ACTION" ]; then
    exit 0
fi

case "$ACTION" in
    "Connect")
        notify-send "Bluetooth" "Connecting to $DEV_NAME..."
        if bluetoothctl connect "$MAC"; then
            notify-send "Bluetooth" "Connected to $DEV_NAME"
        else
            notify-send "Bluetooth" "Failed to connect to $DEV_NAME"
        fi
        ;;
    "Pair")
        notify-send "Bluetooth" "Pairing with $DEV_NAME..."
        if bluetoothctl pair "$MAC"; then
            notify-send "Bluetooth" "Paired with $DEV_NAME"
        else
            notify-send "Bluetooth" "Failed to pair with $DEV_NAME"
        fi
        ;;
    "Disconnect")
        bluetoothctl disconnect "$MAC"
        notify-send "Bluetooth" "Disconnected $DEV_NAME"
        ;;
    "Trust")
        bluetoothctl trust "$MAC"
        notify-send "Bluetooth" "Trusted $DEV_NAME"
        ;;
    "Untrust")
        bluetoothctl untrust "$MAC"
        notify-send "Bluetooth" "Untrusted $DEV_NAME"
        ;;
    "Remove")
        bluetoothctl remove "$MAC"
        notify-send "Bluetooth" "Removed $DEV_NAME"
        ;;
esac
