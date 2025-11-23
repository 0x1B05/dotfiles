#!/bin/bash

DIR="$HOME/Pictures/screenshots/"
NAME="screenshot_$(date +%d%m%Y_%H%M%S).png"

option1="Selected area"
option2="Pin to screen (Selected area)"
option3="Fullscreen"

options="$option1\n$option2\n$option3"

choice=$(echo -e "$options" | rofi -dmenu -replace -config ~/dotfiles/rofi/config-screenshot.rasi -i -no-show-icons -l 3 -width 30 -p "Take Screenshot")

case $choice in
$option1)
    grim -g "$(slurp)" "$DIR$NAME"
    if [ -f "$DIR$NAME" ]; then
        # wl-copy <"$DIR$NAME"
        notify-send "Screenshot created and copied to clipboard" "Mode: Selected area"
        swappy -f "$DIR$NAME"
    fi
    ;;
$option2)
    grim -g "$(slurp)" "$DIR$NAME"
    if [ -f "$DIR$NAME" ]; then
        # wl-copy <"$DIR$NAME"
        notify-send "Screenshot pinned" "Image is pinned to screen"
        cat "$DIR$NAME" | swayimg --class "swayimg_pin" --size=image - &
    fi
    ;;
$option3)
    sleep 0.5
    if grim "$DIR$NAME"; then
        # wl-copy <"$DIR$NAME"
        notify-send "Screenshot created and copied to clipboard" "Mode: Fullscreen"
        swappy -f "$DIR$NAME"
    else
        notify-send -u critical "Screenshot Failed" "Something went wrong"
    fi
    ;;
esac
