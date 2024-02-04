mcd(){
    mkdir -p "$1"
    cd "$1"
}

join_by() {
    local separator="$1"
    shift
    printf '%s' "$1" "${@/#/$separator}"
}

undelfile() {
    mv -i ~/.trash/"$@" ./
}

trash() {
    read -p "Are you sure you want to move $@ to trash? [y/n]" confirm
    if [[ $confirm == 'y' || $confirm == 'Y' ]]; then
        mv -i "$@" ~/.trash/
    fi
}

cleartrash() {
    read -p "Are you sure you want to clear the trash? [n]" confirm
    if [[ $confirm == 'y' || $confirm == 'Y' ]]; then
        /bin/rm -rf ~/.trash/*
    fi
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
