#!/bin/bash

RECORD_DIR="$HOME/Pictures/Screenshots"
DEVICE_NAME=""
TEMP_FILE="/tmp/screen_recorder_last.txt"
mkdir -p "$RECORD_DIR"

if pgrep -f "gpu-screen-recorder" > /dev/null; then
    # Stop recording
    pkill -f gpu-screen-recorder
    sleep 0.5
    notify-send "✅  Recording Stopped" "Saved in $HOME/Pictures/Screenshots/" -t 3000

    # Share via KDE Connect
    FILENAME=$(cat "$TEMP_FILE" 2>/dev/null)
    if [ -z "$FILENAME" ]; then
        notify-send "Send failed" "Filename not found"
        exit 1
    fi

    if ! pgrep -x kdeconnectd >/dev/null; then
        kdeconnectd &
        sleep 2
    fi

    if [ -n "$DEVICE_NAME" ]; then
        DEVICE_ID=$(kdeconnect-cli -a | grep "$DEVICE_NAME" | cut -d':' -f1)
    else
        DEVICE_ID=$(kdeconnect-cli -a --id-only | head -n 1)
    fi

    if [ -n "$DEVICE_ID" ]; then
        if kdeconnect-cli -d "$DEVICE_ID" --share "$RECORD_DIR/$FILENAME"; then
            notify-send "Sent to phone" "$(basename "$FILENAME")"
        else
            notify-send "Send failed" "Saved locally"
        fi
    else
        notify-send "No device found" "Saved locally"
    fi

    rm -f "$TEMP_FILE"
else
    # Start recording
    FILENAME="Screen_recording_$(date +"%d%m%Y_%H%M%S").mkv"
    echo "$FILENAME" > "$TEMP_FILE"
    notify-send "🔴  Recording Started" "Press SUPER+SHIFT+R again to stop" -t 2000

    gpu-screen-recorder \
        -w screen \
        -f 60 \
        -q ultra \
        -a default_output \
        -o "$RECORD_DIR/$FILENAME" &
fi
