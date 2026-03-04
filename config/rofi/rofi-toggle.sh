#!/bin/bash
if pidof rofi >/dev/null; then
  pkill rofi
else
  rofi -show drun -show-icons
fi
