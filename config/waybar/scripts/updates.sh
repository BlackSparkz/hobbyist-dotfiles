#!/bin/bash

# Updates checker script for waybar (using pacman/yay)

check_updates() {
    # Check for pacman updates
    UPDATES=$(checkupdates 2>/dev/null | wc -l)
    
    # Check for AUR updates if yay is installed
    if command -v yay &> /dev/null; then
        AUR_UPDATES=$(yay -Qua 2>/dev/null | wc -l)
        UPDATES=$((UPDATES + AUR_UPDATES))
    fi
    
    if [ "$UPDATES" -eq 0 ]; then
        echo "{\"text\":\"\",\"class\":\"up-to-date\",\"tooltip\":\"System is up to date\"}"
    else
        echo "{\"text\":\"󰏗 $UPDATES\",\"class\":\"has-updates\",\"tooltip\":\"$UPDATES update(s) available\"}"
    fi
}

check_updates
