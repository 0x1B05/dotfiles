mkdir $HOME/.config/lazygit && stow --target=$HOME/.config/lazygit lazygit
mkdir $HOME/.config/yazi && stow --target=$HOME/.config/yazi yazi
mkdir $HOME/.config/mpv && stow --target=$HOME/.config/mpv mpv
mkdir $HOME/.config/mpd && stow --target=$HOME/.config/mpd mpd
mkdir $HOME/.config/zathura && stow --target=$HOME/.config/zathura zathura
mkdir $HOME/.config/surfer && stow --target=$HOME/.config/surfer surfer
mkdir $HOME/.config/swaync && stow --target=$HOME/.config/swaync swaync
mkdir $HOME/.config/cliphist && stow --target=$HOME/.config/cliphist cliphist

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
