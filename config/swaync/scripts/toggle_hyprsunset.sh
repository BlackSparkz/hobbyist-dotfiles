#!/usr/bin/env bash
set +e # disable immediate exit on error

if [[ $SWAYNC_TOGGLE_STATE == true ]]; then
  { systemctl --user start hyprsunset.service; } >/dev/null 2>&1 || :
else
  { systemctl --user stop hyprsunset.service; } >/dev/null 2>&1 || :
fi

exit 0
