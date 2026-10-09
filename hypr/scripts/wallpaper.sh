#!/bin/bash

# Cache file for holding the current wallpaper
cache_file="$HOME/.cache/current_wallpaper"
blurred="$HOME/.cache/blurred_wallpaper.png"
rasi_file="$HOME/.cache/current_wallpaper.rasi"
blur_file="$HOME/dotfiles/.settings/blur.sh"
wallpaper_dir="$HOME/Beauti/wallpaper"
thumbnail_dir="$HOME/.cache/wallpaper-thumbnails"

blur="50x30"
[ -f "$blur_file" ] && blur=$(cat "$blur_file")

# Create cache file if not exists
if [ ! -f "$cache_file" ]; then
    touch "$cache_file"
    echo "$HOME/Beauti/wallpaper/default.jpg" >"$cache_file"
fi

# Create rasi file if not exists
if [ ! -f "$rasi_file" ]; then
    touch "$rasi_file"
    echo "* { current-image: url(\"$HOME/Beauti/wallpaper/default.jpg\", height); }" >"$rasi_file"
fi

current_wallpaper=$(cat "$cache_file")

case $1 in
    "init")
        sleep 1
        if [ -f "$cache_file" ]; then
            wal -q -i "$current_wallpaper"
        else
            wal -q -i ~/Beauti/wallpaper/
        fi
        ;;
    "select")
        sleep 0.2
        mkdir -p "$thumbnail_dir"
        selected=$(find "$wallpaper_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0 | sort -z -R | while IFS= read -r -d '' wallpaper_path; do
            rfile=${wallpaper_path##*/}
            thumbnail="$thumbnail_dir/$(printf '%s' "$wallpaper_path" | sha256sum | cut -d ' ' -f1).png"

            # Fuzzel's dmenu icon protocol accepts PNG/SVG, so cache JPEGs as PNG thumbnails.
            if [ ! -s "$thumbnail" ] || [ "$wallpaper_path" -nt "$thumbnail" ]; then
                if ! magick "$wallpaper_path" -thumbnail '360x220^' -gravity center -extent 360x220 "$thumbnail" 2>/dev/null; then
                    continue
                fi
            fi

            printf '%s\t%s\0icon\x1f%s\n' \
                "$rfile" \
                "$wallpaper_path" \
                "$thumbnail"
        done | "$HOME/dotfiles/scripts/fuzzel.sh" \
            --dmenu \
            --with-nth 1 \
            --accept-nth 2 \
            --minimal-lines \
            --lines 5 \
            --width 60 \
            --anchor top \
            --y-margin 65 \
            --override main.image-size-ratio=0 \
            --override main.line-height=72 \
            --override main.horizontal-pad=16 \
            --override main.vertical-pad=4 \
            --override main.inner-pad=4 \
            --placeholder "Search wallpapers")
        if [ -z "$selected" ]; then
            echo "No wallpaper selected"
            exit
        fi
        wal -q -i "$selected"
        ;;
    *)
        wal -q -i ~/Beauti/wallpaper/
        ;;
esac

# -----------------------------------------------------
# Load current pywal color scheme
# -----------------------------------------------------
source "$HOME/.cache/wal/colors.sh"
echo ":: Wallpaper: $wallpaper"

# -----------------------------------------------------
# get wallpaper image name
# -----------------------------------------------------
newwall=$(echo "$wallpaper" | sed "s|$HOME/Beauti/wallpaper/||g")

# -----------------------------------------------------
# Reload waybar with new colors
# -----------------------------------------------------
~/dotfiles/waybar/launch.sh

# -----------------------------------------------------
# Set the new wallpaper (Hyprpaper IPC Update)
# -----------------------------------------------------
echo ":: Using hyprpaper"

# 1. Generate the config file for NEXT reboot
wal_tpl=$(cat "$HOME/dotfiles/.settings/hyprpaper.tpl")
# Replace WALLPAPER placeholder with actual path
output=${wal_tpl//WALLPAPER/$wallpaper}
echo "$output" > "$HOME/dotfiles/hypr/hyprpaper.conf"

# 2. Apply immediately using IPC
# Check if hyprpaper is running
if pgrep -x "hyprpaper" > /dev/null; then
    # Preload the new wallpaper
    hyprctl hyprpaper preload "$wallpaper"
    # Set the wallpaper (monitor left empty for all)
    hyprctl hyprpaper wallpaper ",$wallpaper"
    # Optional: Unload the old wallpaper to save memory (except the current one)
    # hyprctl hyprpaper unload all 
else
    # If not running, start it (it will read the config we just wrote)
    hyprpaper &
fi

if [ "$1" == "init" ]; then
    echo ":: Init"
else
    sleep 1
    dunstify "Changing wallpaper ..." "with image $newwall" -h int:value:33 -h string:x-dunst-stack-tag:wallpaper
    sleep 2
fi

# -----------------------------------------------------
# Created blurred wallpaper
# -----------------------------------------------------
if [ "$1" == "init" ]; then
    echo ":: Init"
else
    dunstify "Creating blurred version ..." "with image $newwall" -h int:value:66 -h string:x-dunst-stack-tag:wallpaper
fi

# Use quotes for paths to handle spaces
magick "$wallpaper" -resize 75% "$blurred"
echo ":: Resized to 75%"
if [ "$blur" != "0x0" ]; then
    magick "$blurred" -blur "$blur" "$blurred"
    echo ":: Blurred"
fi

# -----------------------------------------------------
# Write selected wallpaper into .cache files
# -----------------------------------------------------
echo "$wallpaper" >"$cache_file"
echo "* { current-image: url(\"$blurred\", height); }" >"$rasi_file"

# -----------------------------------------------------
# Send notification
# -----------------------------------------------------

if [ "$1" == "init" ]; then
    echo ":: Init"
else
    dunstify "Wallpaper procedure complete!" "with image $newwall" -h int:value:100 -h string:x-dunst-stack-tag:wallpaper
fi

echo "DONE!"
