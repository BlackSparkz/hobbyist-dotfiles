#!/bin/bash

RECORD_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$RECORD_DIR"

if pgrep -f "gpu-screen-recorder" > /dev/null; then
    # Stop Recording
    pkill -f gpu-screen-recorder
    sleep 0.5
    notify-send "✅  Recording Stopped" "Saved in \~/Pictures/Screenshots/" -t 3000
else
    # Start Recording
    FILENAME="Screen_recording-$(date +%Y-%m-%d_%H-%M-%S).mkv"
    notify-send "🔴  Recording Started" "Press SUPER+SHIFT+R again to stop" -t 2000
    
    gpu-screen-recorder \
        -w screen \
        -f 60 \
        -q ultra \
        -a default_output \
        -o "$RECORD_DIR/$FILENAME" &
fi
