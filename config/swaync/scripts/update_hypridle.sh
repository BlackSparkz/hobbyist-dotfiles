#!/usr/bin/env bash
set -e

# Get current HYPRIDLE_CONFIG from systemd's user environment
CONFIG=$(systemctl --user show-environment | grep '^HYPRIDLE_CONFIG=' | cut -d= -f2)

if [[ "$CONFIG" == "$HOME/.config/hypr/hypridle-coffee.conf" ]]; then
  echo true
else
  echo false
fi
