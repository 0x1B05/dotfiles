#!/bin/bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

stow_package() {
	local target="$1"
	local package="$2"
	local base_dir="${3:-$repo_root}"

	mkdir -p "$target"
	stow --restow --target="$target" --dir="$base_dir" "$package"
}

link_file() {
	local src="$1"
	local dest="$2"

	mkdir -p "$(dirname "$dest")"
	ln -sfn "$src" "$dest"
}

sudo_link_file() {
	local src="$1"
	local dest="$2"

	sudo mkdir -p "$(dirname "$dest")"
	sudo ln -sfn "$src" "$dest"
}

stow_package "$HOME/.config/hypr" hypr
stow_package "$HOME/.config/fcitx5" fcitx5
stow_package "$HOME/.config/waybar" waybar
stow_package "$HOME/.config/wal" wal
stow_package "$HOME/.config/lazygit" lazygit
stow_package "$HOME/.config/rofi" rofi
stow_package "$HOME/.config/yazi" yazi
stow_package "$HOME/.config/mpv" mpv
stow_package "$HOME/.config/mpd" mpd
stow_package "$HOME/.config/zathura" zathura
stow_package "$HOME/.config/surfer" surfer
stow_package "$HOME/.config/swaync" swaync
stow_package "$HOME/.config/cliphist" cliphist
stow_package "$HOME/.config/swayimg" swayimg
stow_package "$HOME/.config/tmux" tmux
stow_package "$HOME/.config/foot" foot
stow_package "$HOME/.config/fontconfig" fontconfig
stow_package "$HOME/.config/gtk-3.0" gtk-3.0
stow_package "$HOME/.config/gtk-4.0" gtk-4.0
stow_package "$HOME/.config/xsettingsd" xsettingsd

stow_package "$HOME/.config" starship
stow_package "$HOME/.ssh" ssh
stow_package "$HOME" git

link_file "$repo_root/.gtkrc-2.0" "$HOME/.gtkrc-2.0"
link_file "$repo_root/.Xresources" "$HOME/.Xresources"
link_file "$repo_root/mimeapps/mimeapps.list" "$HOME/.config/mimeapps.list"
link_file "$repo_root/zsh/.zshrc" "$HOME/.zshrc"
link_file "$repo_root/zsh/.zprofile" "$HOME/.zprofile"
link_file "$repo_root/gtkwave/.gtkwaverc" "$HOME/.gtkwaverc"

sudo_link_file "$repo_root/keyd/default.conf" /etc/keyd/default.conf

stow_package "$HOME/.local/bin" bin "$repo_root/local"
stow_package "$HOME/.local/share/applications" applications "$repo_root/local/share"
