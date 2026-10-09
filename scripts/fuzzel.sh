#!/bin/bash

set -euo pipefail

args=()
if [ -r "$HOME/.cache/wal/colors.sh" ]; then
    set +u
    # shellcheck disable=SC1091
    source "$HOME/.cache/wal/colors.sh"
    set -u

    trim_hash() {
        printf '%s' "${1#\#}"
    }

    args+=(
        "--background-color=$(trim_hash "${background:-#0c160d}")cc"
        "--text-color=$(trim_hash "${foreground:-#aebdbe}")ff"
        "--prompt-color=$(trim_hash "${foreground:-#aebdbe}")ff"
        "--placeholder-color=$(trim_hash "${foreground:-#aebdbe}")ff"
        "--input-color=$(trim_hash "${foreground:-#aebdbe}")ff"
        "--match-color=$(trim_hash "${color11:-#927747}")ff"
        "--selection-color=$(trim_hash "${color11:-#927747}")ff"
        "--selection-text-color=$(trim_hash "${background:-#0c160d}")ff"
        "--selection-match-color=$(trim_hash "${foreground:-#aebdbe}")ff"
        "--border-color=$(trim_hash "${foreground:-#aebdbe}")ff"
    )
fi

exec fuzzel "${args[@]}" "$@"
