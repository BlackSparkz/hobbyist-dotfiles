#!/bin/bash

time=$(date +"%d-%m-%Y_%H-%M-%S")
dir="$HOME/Pictures/Screenshots"
file="Screenshot_${time}.png"

# Take a screenshot of the whole screen using Grim
cd ${dir} && grim -l 0 -g "$(slurp)" - | tee $file | wl-copy

# Wait for the file to exist before proceeding
while ! [ -f "${file}" ]; do sleep 2; done

# Send the screenshot to the phone via KDE Connect
kdeconnect-cli -d $(kdeconnect-cli -a --id-only) --share "${file}"
