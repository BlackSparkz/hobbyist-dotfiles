#!/usr/bin/env bash
set +e # disable immediate exit on error

if [[ $SWAYNC_TOGGLE_STATE == true ]]; then
  {
    rfkill unblock bluetooth
    bluetoothctl power on
  } >/dev/null 2>&1 || :
else
  { bluetoothctl power off; } >/dev/null 2>&1 || :

fi

exit 0
