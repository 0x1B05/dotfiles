SSH_AGENT_SOCKET="${SSH_AGENT_SOCKET:-$HOME/.ssh/agent/ssh-agent.sock}"
export SSH_AUTH_SOCK="$SSH_AGENT_SOCKET"

mkdir -p "$(dirname "$SSH_AUTH_SOCK")"

ssh-add -l >/dev/null 2>&1
agent_status=$?

if [ "$agent_status" -eq 2 ]; then
    eval "$(ssh-agent -a "$SSH_AUTH_SOCK")" >/dev/null 2>&1
fi
