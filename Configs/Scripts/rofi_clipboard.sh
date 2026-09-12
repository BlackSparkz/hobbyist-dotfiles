#!/usr/bin/env bash

pkill rofi || \
selected=$(cliphist list | \
rofi -dmenu \
    -display-columns 2 \
    -theme ~/.config/rofi/clipboard.rasi \
    -kb-custom-1 "ctrl+q")

exit_code=$?

if [ -z "$selected" ]; then
    exit 0
fi

if [ "$exit_code" -eq 10 ]; then
    # ctrl+q pressed
    cliphist decode <<< "$selected" | qrencode -o /tmp/clip-qr.png -s 10 -m 2 -t PNG
    notify-send "QR Generated" "Scan QR to copy"
    timeout 10 swayimg /tmp/clip-qr.png
else
    cliphist decode <<< "$selected" | wl-copy
    notify-send "Clipboard" "Copied to clipboard"
fi
