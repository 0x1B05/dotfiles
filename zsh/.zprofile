if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    dbus-run-session Hyprland
fi
