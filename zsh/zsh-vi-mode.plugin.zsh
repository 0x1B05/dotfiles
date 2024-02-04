# According to the standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

function zvm_config() {
    ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    ZVM_VI_INSERT_ESCAPE_BINDKEY=jj
}

function zvm_after_lazy_keybindings() {
    bindkey -M vicmd "H" vi-beginning-of-line
    bindkey -M vicmd "L" vi-end-of-line
}

source ${0:h}/zsh-vi-mode.zsh
