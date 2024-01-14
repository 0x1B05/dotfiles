# History
# Remove older command from the history if a duplicate is to be added.
setopt APPENDHISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
