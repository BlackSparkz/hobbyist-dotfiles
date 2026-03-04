#!/bin/bash
if pidof wlogout >/dev/null; then
  pkill wlogout
else
  wlogout
fi
