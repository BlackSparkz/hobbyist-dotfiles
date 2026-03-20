#!/usr/bin/env bash
set +e # disable immediate exit on error

if [[ $SWAYNC_TOGGLE_STATE == true ]]; then
  {
    systemctl --user set-environment HYPRIDLE_CONFIG="$HOME/.config/hypr/hypridle-coffee.conf"
    notify-send -u "critical" -a "swaync" "󰅶 Coffee mode enabled" "The device won't suspend"
  } >/dev/null 2>&1 || :
else
  {
    systemctl --user set-environment HYPRIDLE_CONFIG="$HOME/.config/hypr/hypridle.conf"
    notify-send -u "critical" -a "swaync" "󰾪 Coffee mode disabled" "The device will suspend"
  } >/dev/null 2>&1 || :
fi

{ systemctl --user restart hypridle-runner.service; } >/dev/null 2>&1 || :

exit 0
