mkdir ~/.config/lazygit && stow --target=$HOME/.config/lazygit lazygit
mkdir ~/.config/lf && stow --target=$HOME/.config/lf lf
mkdir ~/.config/mpv && stow --target=$HOME/.config/mpv mpv

stow --target=$HOME/.config chromium
stow --target=$HOME/.ssh/ ssh

stow git
stow tmux

ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/.zimrc $HOME/.zimrc
