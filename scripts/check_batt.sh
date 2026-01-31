#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT*/capacity | awk '{sum+=$1; n++} END {print int(sum/n)}')
status=$(cat /sys/class/power_supply/BAT*/status | head -n 1)

CRITICAL_LEVEL=15
LOCK_FILE="/tmp/battery_notified"

if [ "$status" = "Charging" ] || [ "$status" = "Full" ]; then
    [ -f "$LOCK_FILE" ] && rm "$LOCK_FILE"
    exit 0
fi

if [ "$status" = "Discharging" ] && [ "$capacity" -le "$CRITICAL_LEVEL" ]; then
    if [ ! -f "$LOCK_FILE" ]; then
        notify-send -u critical -r 9999 -i battery-low "Battery Warning" "Remaining charge: $capacity%. Please plug in your charger!"
        touch "$LOCK_FILE"
    fi
fi

if [ "$capacity" -gt "$CRITICAL_LEVEL" ]; then
    [ -f "$LOCK_FILE" ] && rm "$LOCK_FILE"
fi
