alias vim="nvim"
alias py="python3"
alias la="ls -a"
alias glog="git log --all --oneline --pretty=format:'%C(auto)%h%C(blue) %<|(19)%as%C(auto)%d %s' --graph"
alias ll="ls -lhk"
alias mv="mv -i"
alias mkdir="mkdir -p"
alias cp="cp -r"
alias df="df -h"
alias c="clear"
alias t="tmux"
alias ta="tmux a"
alias lg="lazygit"

# RISC-V
alias rv32gcc='riscv64-linux-gnu-gcc -march=rv32i_zicsr -mabi=ilp32'
alias rv32ld='riscv64-linux-gnu-ld -melf32lriscv'
alias rv64gcc='riscv64-linux-gnu-gcc -march=rv64i_zicsr -mabi=lp64'
alias rv64ld='riscv64-linux-gnu-ld -melf64lriscv'
alias rv32as='riscv64-linux-gnu-as -march=rv32i_zicsr'
alias rv64as='riscv64-linux-gnu-as -march=rv64i_zicsr'
alias rv32objdump='riscv64-linux-gnu-objdump -d -M numeric,no-aliases'
alias rv64objdump='riscv64-linux-gnu-objdump -d -M numeric,no-aliases'
