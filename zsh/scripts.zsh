mcd(){
    mkdir -p "$1"
    cd "$1"
}

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

join_by() {
    local separator="$1"
    shift
    printf '%s' "$1" "${@/#/$separator}"
}
