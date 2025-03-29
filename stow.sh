mkdir ~/.config/lazygit && stow --target=$HOME/.config/lazygit lazygit
mkdir ~/.config/yazi && stow --target=$HOME/.config/yazi yazi
mkdir ~/.config/mpv && stow --target=$HOME/.config/mpv mpv
mkdir ~/.config/mpd && stow --target=$HOME/.config/mpd mpd
mkdir ~/.config/zathura && stow --target=$HOME/.config/zathura zathura

stow --target=$HOME/.config chromium
stow --target=$HOME/.ssh/ ssh

stow git
stow tmux

ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/.zimrc $HOME/.zimrc
ln -s $HOME/dotfiles/gtkwave/.gtkwaverc $HOME/.gtkwaverc

cd local
stow --target=$HOME/.local/bin bin
cd share
stow --target=$HOME/.local/share/applications applications
