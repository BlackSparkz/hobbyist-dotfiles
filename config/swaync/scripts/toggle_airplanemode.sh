#!/usr/bin/env bash
set +e # disable immediate exit on error

if [[ $SWAYNC_TOGGLE_STATE == true ]]; then
  {
    nmcli radio wifi off
    bluetooth power off
    rfkill block all
    notify-send -u "critical" -a "swaync" "󰀝 Airplane mode enabled"
  } >/dev/null 2>&1 || :
else
  {
    rfkill unblock all
    nmcli radio wifi on
    bluetooth power on
    notify-send -u "critical" -a "swaync" "󰀞 Airplane mode disabled"
  } >/dev/null 2>&1 || :
fi

exit 0
