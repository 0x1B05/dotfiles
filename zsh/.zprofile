if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    dbus-run-session start-hyprland
fi
