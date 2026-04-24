SSH_AGENT_SOCKET="${SSH_AGENT_SOCKET:-$HOME/.ssh/agent/ssh-agent.sock}"
export SSH_AUTH_SOCK="$SSH_AGENT_SOCKET"

mkdir -p "$(dirname "$SSH_AUTH_SOCK")"

socket_has_listener() {
    command -v ss >/dev/null 2>&1 || return 1
    ss -xlH 2>/dev/null | grep -F -- "$SSH_AUTH_SOCK" >/dev/null 2>&1
}

ssh-add -l >/dev/null 2>&1
agent_status=$?

if [ "$agent_status" -eq 2 ]; then
    if [ -e "$SSH_AUTH_SOCK" ] && ! socket_has_listener; then
        rm -f "$SSH_AUTH_SOCK"
    fi

    if agent_env="$(ssh-agent -a "$SSH_AUTH_SOCK" 2>/dev/null)"; then
        eval "$agent_env" >/dev/null 2>&1
    else
        printf 'failed to start ssh-agent at %s\n' "$SSH_AUTH_SOCK" >&2
    fi
fi
