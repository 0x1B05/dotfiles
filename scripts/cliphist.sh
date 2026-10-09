#!/bin/bash
#   ____ _ _       _     _     _    
#  / ___| (_)_ __ | |__ (_)___| |_  
# | |   | | | '_ \| '_ \| / __| __| 
# | |___| | | |_) | | | | \__ \ |_  
#  \____|_|_| .__/|_| |_|_|___/\__| 
#           |_|                     
# -----------------------------------------------------

# Fuzzel uses Wayland text-input-v3, which lets Fcitx5 handle Chinese input.
clipboard_menu() {
    "$HOME/dotfiles/scripts/fuzzel.sh" \
        --dmenu \
        --lines 8 \
        --anchor top-right \
        --x-margin 14 \
        --y-margin 65 \
        --placeholder "Search" \
        "$@"
}

case $1 in
    d) cliphist list | clipboard_menu | cliphist delete
       ;;

    w) if [ "$(printf '%s\n' Clear Cancel | clipboard_menu)" = "Clear" ] ; then
            cliphist wipe
       fi
       ;;

    *) cliphist list | clipboard_menu | cliphist decode | wl-copy
       ;;
esac
