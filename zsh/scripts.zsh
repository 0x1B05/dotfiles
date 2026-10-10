mcd(){
    mkdir -p "$1"
    cd "$1"
}

join_by() {
    local separator="$1"
    shift
    printf '%s' "$1" "${@/#/$separator}"
}

proxy-on() {
    local url="http://127.0.0.1:7897"
    export HTTP_PROXY="$url" HTTPS_PROXY="$url" ALL_PROXY="$url"
    export http_proxy="$url" https_proxy="$url" all_proxy="$url"
}

proxy-off() {
    unset HTTP_PROXY HTTPS_PROXY ALL_PROXY http_proxy https_proxy all_proxy
}

proxy() (
    proxy-on
    "$@"
)

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

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}
