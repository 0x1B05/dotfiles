#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

dry_run=0
adopt=0
force=0
all=0
system_mode=0
list_only=0
packages=()

stow_packages=(
	hypr
	fcitx5
	waybar
	wal
	lazygit
	rofi
	yazi
	mpv
	mpd
	zathura
	surfer
	swaync
	cliphist
	swayimg
	tmux
	uv
	foot
	fontconfig
	gtk-3.0
	gtk-4.0
	xsettingsd
	starship
	ssh
	git
	bin
	applications
)

link_packages=(
	gtkrc
	xresources
	mimeapps
	zsh
	gtkwave
)

system_packages=(
	keyd
)

default_user_packages=(
	hypr
	fcitx5
	waybar
	wal
	lazygit
	rofi
	yazi
	mpv
	mpd
	zathura
	surfer
	swaync
	cliphist
	swayimg
	tmux
	uv
	foot
	fontconfig
	gtk-3.0
	gtk-4.0
	xsettingsd
	starship
	ssh
	git
	bin
	"${link_packages[@]}"
)

user_packages=(
	"${default_user_packages[@]}"
	applications
)

usage() {
	cat <<EOF
usage: ${0##*/} [options] <package...>

Options:
  --all          Restow default user packages.
  --system       Operate on explicit system packages, e.g. keyd.
  --dry-run, -n  Show planned operations without changing files.
  --adopt        Pass --adopt to GNU stow packages.
  --force        Allow single-file links to replace existing files.
  --list         List available packages.
  -h, --help     Show this help.

Examples:
  ${0##*/} uv
  ${0##*/} hypr waybar uv
  ${0##*/} --dry-run uv
  ${0##*/} --adopt uv
  ${0##*/} --all
  ${0##*/} --system keyd
EOF
}

contains() {
	local needle="$1"
	shift
	local item

	for item in "$@"; do
		[[ "$item" == "$needle" ]] && return 0
	done
	return 1
}

package_top_level_linked() {
	local package_root="$1"
	local target="$2"
	local entries=()
	local entry
	local name
	local dest

	while IFS= read -r -d '' entry; do
		entries+=("$entry")
	done < <(find "$package_root" -mindepth 1 -maxdepth 1 -print0)

	[[ "${#entries[@]}" -gt 0 ]] || return 1

	for entry in "${entries[@]}"; do
		name="${entry##*/}"
		dest="$target/$name"

		[[ -e "$dest" || -L "$dest" ]] || return 1
		[[ "$(readlink -f "$dest")" == "$(readlink -f "$entry")" ]] || return 1
	done

	return 0
}

print_list() {
	printf 'Default user packages (--all):\n'
	printf '  %s\n' "${default_user_packages[@]}"
	printf '\nOther user packages:\n'
	printf '  applications\n'
	printf '\nSystem packages:\n'
	printf '  %s\n' "${system_packages[@]}"
}

run_stow() {
	local target="$1"
	local package="$2"
	local base_dir="${3:-$repo_root}"
	local args=(--restow --target="$target" --dir="$base_dir")
	local package_root="$base_dir/$package"
	local resolved_package_root
	local resolved_target

	resolved_package_root="$(readlink -f "$package_root")"

	if [[ -L "$target" ]]; then
		resolved_target="$(readlink -f "$target")"
		if [[ "$resolved_target" == "$resolved_package_root" ]]; then
			if [[ "$dry_run" == 1 ]]; then
				printf 'directory link unchanged: %s -> %s\n' "$target" "$package_root"
			fi
			return
		fi
	fi

	if [[ -d "$target" ]] && package_top_level_linked "$package_root" "$target"; then
		if [[ "$dry_run" == 1 ]]; then
			printf 'package links unchanged: %s -> %s\n' "$target" "$package_root"
		fi
		return
	fi

	if [[ "$dry_run" == 1 && ! -d "$target" ]]; then
		printf 'mkdir -p %s\n' "$target"
		printf 'stow: %s -> %s\n' "$package_root" "$target"
		return
	fi

	if [[ "$dry_run" == 1 ]]; then
		args+=(--simulate --verbose=2)
	else
		mkdir -p "$target"
	fi

	if [[ "$adopt" == 1 ]]; then
		args+=(--adopt)
	fi

	stow "${args[@]}" "$package"
}

link_file() {
	local src="$1"
	local dest="$2"
	local resolved_src
	local resolved_dest

	resolved_src="$(readlink -f "$src")"
	resolved_dest="$(readlink -f "$dest" 2>/dev/null || true)"

	if [[ -e "$dest" || -L "$dest" ]]; then
		if [[ "$resolved_dest" == "$resolved_src" ]]; then
			if [[ "$dry_run" == 1 ]]; then
				printf 'link unchanged: %s -> %s\n' "$dest" "$src"
			fi
			return
		fi

		if [[ "$force" != 1 ]]; then
			printf 'refusing to overwrite existing path: %s\n' "$dest" >&2
			printf 'use --force if replacing it is intentional\n' >&2
			return 1
		fi
	fi

	if [[ "$dry_run" == 1 ]]; then
		printf 'link: %s -> %s\n' "$dest" "$src"
		return
	fi

	mkdir -p "$(dirname "$dest")"
	ln -sfn "$src" "$dest"
}

sudo_link_file() {
	local src="$1"
	local dest="$2"

	if [[ "$dry_run" == 1 ]]; then
		printf 'sudo link: %s -> %s\n' "$dest" "$src"
		return
	fi

	sudo mkdir -p "$(dirname "$dest")"
	sudo ln -sfn "$src" "$dest"
}

stow_user_package() {
	local package="$1"

	case "$package" in
		hypr) run_stow "$HOME/.config/hypr" hypr ;;
		fcitx5) run_stow "$HOME/.config/fcitx5" fcitx5 ;;
		waybar) run_stow "$HOME/.config/waybar" waybar ;;
		wal) run_stow "$HOME/.config/wal" wal ;;
		lazygit) run_stow "$HOME/.config/lazygit" lazygit ;;
		rofi) run_stow "$HOME/.config/rofi" rofi ;;
		yazi) run_stow "$HOME/.config/yazi" yazi ;;
		mpv) run_stow "$HOME/.config/mpv" mpv ;;
		mpd) run_stow "$HOME/.config/mpd" mpd ;;
		zathura) run_stow "$HOME/.config/zathura" zathura ;;
		surfer) run_stow "$HOME/.config/surfer" surfer ;;
		swaync) run_stow "$HOME/.config/swaync" swaync ;;
		cliphist) run_stow "$HOME/.config/cliphist" cliphist ;;
		swayimg) run_stow "$HOME/.config/swayimg" swayimg ;;
		tmux) run_stow "$HOME/.config/tmux" tmux ;;
		uv) run_stow "$HOME/.config/uv" uv ;;
		foot) run_stow "$HOME/.config/foot" foot ;;
		fontconfig) run_stow "$HOME/.config/fontconfig" fontconfig ;;
		gtk-3.0) run_stow "$HOME/.config/gtk-3.0" gtk-3.0 ;;
		gtk-4.0) run_stow "$HOME/.config/gtk-4.0" gtk-4.0 ;;
		xsettingsd) run_stow "$HOME/.config/xsettingsd" xsettingsd ;;
		starship) run_stow "$HOME/.config" starship ;;
		ssh) run_stow "$HOME/.ssh" ssh ;;
		git) run_stow "$HOME" git ;;
		bin) run_stow "$HOME/.local/bin" bin "$repo_root/local" ;;
		applications) run_stow "$HOME/.local/share/applications" applications "$repo_root/local/share" ;;
		gtkrc) link_file "$repo_root/.gtkrc-2.0" "$HOME/.gtkrc-2.0" ;;
		xresources) link_file "$repo_root/.Xresources" "$HOME/.Xresources" ;;
		mimeapps) link_file "$repo_root/mimeapps/mimeapps.list" "$HOME/.config/mimeapps.list" ;;
		zsh)
			link_file "$repo_root/zsh/.zshrc" "$HOME/.zshrc"
			link_file "$repo_root/zsh/.zprofile" "$HOME/.zprofile"
			;;
		gtkwave) link_file "$repo_root/gtkwave/.gtkwaverc" "$HOME/.gtkwaverc" ;;
		*)
			printf 'unknown user package: %s\n' "$package" >&2
			exit 1
			;;
	esac
}

stow_system_package() {
	local package="$1"

	case "$package" in
		keyd) sudo_link_file "$repo_root/keyd/default.conf" /etc/keyd/default.conf ;;
		*)
			printf 'unknown system package: %s\n' "$package" >&2
			exit 1
			;;
	esac
}

while [[ $# -gt 0 ]]; do
	case "$1" in
		--all)
			all=1
			shift
			;;
		--system)
			system_mode=1
			shift
			;;
		--dry-run|-n)
			dry_run=1
			shift
			;;
		--adopt)
			adopt=1
			shift
			;;
		--force)
			force=1
			shift
			;;
		--list)
			list_only=1
			shift
			;;
		-h|--help)
			usage
			exit 0
			;;
		--)
			shift
			break
			;;
		-*)
			printf 'unknown option: %s\n' "$1" >&2
			usage >&2
			exit 1
			;;
		*)
			packages+=("$1")
			shift
			;;
	esac
done

if [[ "$#" -gt 0 ]]; then
	packages+=("$@")
fi

if [[ "$list_only" == 1 ]]; then
	print_list
	exit 0
fi

if [[ "$system_mode" == 1 && "$all" == 1 ]]; then
	printf '%s\n' '--all is only supported for user packages' >&2
	exit 1
fi

if [[ "$all" == 1 ]]; then
	if [[ "${#packages[@]}" -gt 0 ]]; then
		printf 'do not combine --all with explicit packages\n' >&2
		exit 1
	fi
	packages=("${default_user_packages[@]}")
fi

if [[ "${#packages[@]}" -eq 0 ]]; then
	usage >&2
	exit 1
fi

if [[ "$adopt" == 1 && "$system_mode" == 1 ]]; then
	printf '%s\n' '--adopt is not valid for system packages' >&2
	exit 1
fi

if [[ "$adopt" == 1 ]]; then
	for package in "${packages[@]}"; do
		if ! contains "$package" "${stow_packages[@]}"; then
			printf '%s\n' "--adopt is only valid for GNU stow packages, not $package" >&2
			exit 1
		fi
	done
fi

for package in "${packages[@]}"; do
	if [[ "$system_mode" == 1 ]]; then
		stow_system_package "$package"
	else
		stow_user_package "$package"
	fi
done
