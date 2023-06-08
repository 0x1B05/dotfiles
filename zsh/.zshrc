cd ~
#
# Start ssh-agent
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval $(ssh-agent -s) >/dev/null 2>&1
    ssh-add ~/.ssh/id_rsa >/dev/null 2>&1
fi

# History in cache directory:
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# env-variables
export NEMU_HOME=/home/liuheihei/cs_learning/nju_os/ics/ics2022/nemu
export AM_HOME=/home/liuheihei/cs_learning/nju_os/ics/ics2022/abstract-machine
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export GOBIN=/usr/local/go/bin
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

paths=(
    /usr/local/bin
    /usr/bin
    /usr/sbin
    /usr/local/go/bin
)
join_by() {
    local separator="$1"
    shift
    printf '%s' "$1" "${@/#/$separator}"
}
path=$(join_by ":" "${paths[@]}")
export PATH="$path"
autoload -U colors && colors

# alias
alias vim="nvim"
alias py="python3"
alias la="ls -a"
alias glog="git log --all --oneline --pretty=format:'%C(auto)%h%C(blue) %<|(19)%as%C(auto)%d %s' --graph"
alias ll="ls -lh"
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format
alias c="clear"
alias t="tmux"
alias ta="tmux a"

# Use vim style line editing in zsh
# bindkey -v
bindkey -a '^R' redo
bindkey -a '^V' edit-command-line
bindkey '^H' backward-delete-char
bindkey '^R' history-incremental-search-backward

# function zle-keymap-select {
# 	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
# 		echo -ne '\e[1 q'
# 	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]]; then
# 		echo -ne '\e[5 q'
#   fi
# }
# zle -N zle-keymap-select

# my scripts
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
bindkey -s '^o' 'lfcd\n'

# autopairs
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
# -----------------
# Zsh configuration
# -----------------

# History
# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

# Input/output
# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
# 启用 zsh-autosuggestions 插件
source ${ZIM_HOME}/modules/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZIM_HOME}/init.zsh
source ${ZIM_HOME}/modules/zsh-autopair/autopair.zsh

# autoload -Uz is-at-least
# if is-at-least 5.1; then
#     zle -N autopair
#     bindkey "\e\"" autopair
#     bindkey "\e'" autopair
#     bindkey "\e(" autopair
#     bindkey "\e[" autopair
#     bindkey "\e{" autopair
# fi

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
