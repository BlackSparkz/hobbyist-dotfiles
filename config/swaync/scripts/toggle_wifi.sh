#!/usr/bin/env bash
set +e # disable immediate exit on error

if [[ $SWAYNC_TOGGLE_STATE == true ]]; then
  {
    rfkill unblock wifi
    nmcli radio wifi on
  } >/dev/null 2>&1 || :
else
  { nmcli radio wifi off; } >/dev/null 2>&1 || :

fi

exit 0
