export PROXYCHAINS_CONF="${PROXYCHAINS_CONF:-$HOME/.proxychains/proxychains.conf}"

pc() {
    if [[ ! -f "$PROXYCHAINS_CONF" ]]; then
        printf 'missing proxychains config: %s\n' "$PROXYCHAINS_CONF" >&2
        return 1
    fi
    proxychains4 -f "$PROXYCHAINS_CONF" "$@"
}

alias pcgit='pc git'
alias pccurl='pc curl'
alias pcwget='pc wget'
alias pcnvim='pc nvim'
