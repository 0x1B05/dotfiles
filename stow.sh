mkdir $HOME/.config/hypr && stow --target=$HOME/.config/hypr hypr
mkdir $HOME/.config/waybar && stow --target=$HOME/.config/waybar waybar
mkdir $HOME/.config/wal && stow --target=$HOME/.config/wal wal
mkdir $HOME/.config/lazygit && stow --target=$HOME/.config/lazygit lazygit
mkdir $HOME/.config/rofi && stow --target=$HOME/.config/rofi rofi
mkdir $HOME/.config/yazi && stow --target=$HOME/.config/yazi yazi
mkdir $HOME/.config/mpv && stow --target=$HOME/.config/mpv mpv
mkdir $HOME/.config/mpd && stow --target=$HOME/.config/mpd mpd
mkdir $HOME/.config/zathura && stow --target=$HOME/.config/zathura zathura
mkdir $HOME/.config/surfer && stow --target=$HOME/.config/surfer surfer
mkdir $HOME/.config/swaync && stow --target=$HOME/.config/swaync swaync
mkdir $HOME/.config/cliphist && stow --target=$HOME/.config/cliphist cliphist
mkdir $HOME/.config/swayimg && stow --target=$HOME/.config/swayimg swayimg
mkdir $HOME/.config/tmux && stow --target=$HOME/.config/tmux tmux
mkdir $HOME/.config/foot && stow --target=$HOME/.config/foot foot

mkdir $HOME/.config/gtk-3.0 && stow --target=$HOME/.config/gtk-3.0 gtk-3.0
mkdir $HOME/.config/gtk-4.0 && stow --target=$HOME/.config/gtk-4.0 gtk-4.0
mkdir $HOME/.config/xsettingsd && stow --target=$HOME/.config/xsettingsd xsettingsd

stow --target=$HOME/.config starship
stow --target=$HOME/.ssh ssh

stow git

ln -s $HOME/dotfiles/.gtkrc-2.0 $HOME/.gtkrc-2.0
ln -s $HOME/dotfiles/.Xresources $HOME/.Xresources
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $HOME/dotfiles/zsh/.zprofile $HOME/.zprofile
ln -s $HOME/dotfiles/gtkwave/.gtkwaverc $HOME/.gtkwaverc

cd local
stow --target=$HOME/.local/bin bin
cd share
stow --target=$HOME/.local/share/applications applications
