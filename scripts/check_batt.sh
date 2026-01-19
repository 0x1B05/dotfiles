#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT*/capacity | awk '{sum+=$1; n++} END {print int(sum/n)}')
status=$(upower -i $(upower -e | grep 'BAT') | grep state | awk '{print $2}')

CRITICAL_LEVEL=15

if [ "$status" = "discharging" ] && [ "$capacity" -le "$CRITICAL_LEVEL" ]; then
    notify-send -u critical -r 9999 -i battery-low "Battery Warning" "Remaining charge: $capacity%. Please plug in your charger!"
fi
