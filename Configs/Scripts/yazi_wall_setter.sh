#!/bin/bash
WALL=$(echo $1)
awww img "$WALL" --transition-type random --transition-fps 60 --transition-duration 1
NIRI=/tmp/blurred_wall.jpg 
# magick "$WALL" -blur 0x15 "$NIRI"                                     #for niri overview bg
ffmpeg -y -hwaccel vaapi -i "$WALL" -vf "boxblur=20:5" "$NIRI" #for niri overview bg ( better )
awww img --namespace niri "$NIRI" --transition-type random --transition-fps 60 --transition-duration 1
sleep 1 && notify-send "Wallpaper changed" "$(basename "$WALL")" -i "$WALL"
