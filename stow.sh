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

stow_package "$HOME/.config/lazygit" lazygit
stow_package "$HOME/.config/nvim" nvim
stow_package "$HOME/.config/yazi" yazi
stow_package "$HOME/.config/tmux" tmux
stow_package "$HOME/.config" starship
stow_package "$HOME/.ssh" ssh
stow_package "$HOME" git

link_file "$repo_root/zsh/.zshrc" "$HOME/.zshrc"
link_file "$repo_root/zsh/.zprofile" "$HOME/.zprofile"
link_file "$repo_root/gtkwave/.gtkwaverc" "$HOME/.gtkwaverc"

stow_package "$HOME/.local/bin" bin "$repo_root/local"
