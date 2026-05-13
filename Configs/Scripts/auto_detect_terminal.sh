#!/usr/bin/env bash

TERMINALS=(
    ghostty
    alacritty
    foot
    wezterm
    konsole
    gnome-terminal
    xfce4-terminal
    lxterminal
    mate-terminal
    tilix
    urxvt
    rxvt
    st
    xterm
)

for term in "${TERMINALS[@]}"; do
    if command -v "$term" &>/dev/null; then
        "$term" &
        exit 0
    fi
done

echo "No terminal found." >&2
exit 1
