# env-variables
export EDITOR=nvim
export NPC_HOME=$HOME/ysyx-workbench/npc
export NEMU_HOME=$HOME/ysyx-workbench/nemu
export AM_HOME=$HOME/ysyx-workbench/abstract-machine
export NVBOARD_HOME=$HOME/ysyx-workbench/nvboard
export NAVY_HOME=$HOME/ysyx-workbench/navy-apps
export SOC_HOME=$HOME/ysyx-workbench/ysyxSoC

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export JRE_HOME=/usr/lib/jvm/java-17-openjdk/jre

# zoxide history directory
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# latex
export PATH=/usr/local/texlive/2023/bin/x86_64-linux:$PATH
export MANPATH=/usr/local/texlive/2023/texmf-dist/doc/man:$MANPATH
export INFOPATH=/usr/local/texlive/2023/texmf-dist/doc/info:$INFOPATH

export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '

[[ -f ~/dotfiles/zsh/aliases.zsh ]] && source ~/dotfiles/zsh/aliases.zsh
[[ -f ~/dotfiles/zsh/scripts.zsh ]] && source ~/dotfiles/zsh/scripts.zsh
[[ -f ~/dotfiles/zsh/icons.zsh ]] && source ~/dotfiles/zsh/icons.zsh
[[ -f ~/dotfiles/zsh/history.zsh ]] && source ~/dotfiles/zsh/history.zsh

paths=(
    $HOME/.local/bin
    $HOME/.cargo/bin
    $HOME/.local/share/coursier/bin
    /usr/local/bin
    /usr/lib/ccache/bin
    /usr/bin
    /usr/sbin
)
path=$(join_by ":" "${paths[@]}")
export PATH="$path"

# Start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s) >/dev/null 2>&1

    for key_file in ~/.ssh/id_*; do
        if [ -f "$key_file" ] && [[ "$key_file" != *.pub ]]; then
            ssh-add "$key_file" >/dev/null 2>&1
        fi
    done
fi

autoload -U colors && colors
autoload edit-command-line;
autoload run_tmux;
autoload run_yazi;
autoload run_lazygit;

zle -N edit-command-line
bindkey '\ee' edit-command-line

function run_tmux() {
  BUFFER="tmux"
  zle accept-line
}
zle -N run_tmux
bindkey '\et' run_tmux

function run_yazi() {
  zle -I
  y
}
zle -N run_yazi
bindkey '\ey' run_yazi

function run_lazygit() { lazygit }
zle -N run_lazygit
bindkey '\eg' run_lazygit

# Created by Zap installer
ZAP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zap"
[ -f "$ZAP_HOME/zap.zsh" ] && source "$ZAP_HOME/zap.zsh"

plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-completions"
# Fish-like syntax highlighting for Zsh.
# zsh-users/zsh-syntax-highlighting must be sourced after completion
plug "zsh-users/zsh-syntax-highlighting"
# Fish-like history search (up arrow) for Zsh.
# zsh-users/zsh-history-substring-search must be sourced after zsh-users/zsh-syntax-highlighting
plug "zsh-users/zsh-history-substring-search"
plug "wookayin/fzf-fasd"
plug "zdharma-continuum/fast-syntax-highlighting"
plug "Aloxaf/fzf-tab"
# Fish-like autosuggestions for Zsh.
plug "zsh-users/zsh-autosuggestions"
plug "hlissner/zsh-autopair"
# plug "jeffreytse/zsh-vi-mode" --source zsh-vi-mode.plugin.zsh
plug "jeffreytse/zsh-vi-mode"
source $ZAP_HOME/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Load and initialise completion system
autoload -Uz compinit
compinit

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
