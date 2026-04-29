#!/bin/bash

CHOICES="  Shutdown\n  Reboot\n  Suspend\n  Lock\n  Logout"

CHOICE=$(echo -e "$CHOICES" | rofi -dmenu \
    -theme ~/.config/rofi/powermenu.rasi \
    -p "" \
    -lines 5 \
    -no-custom)

case "$CHOICE" in
  *Shutdown) systemctl poweroff ;;
  *Reboot)   systemctl reboot ;;
  *Suspend)  systemctl suspend ;;
  *Lock)     hyprlock ;;
  *Logout)   hyprctl dispatch exit ;;
esac
