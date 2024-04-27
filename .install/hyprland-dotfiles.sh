# ------------------------------------------------------
# Install dotfiles
# ------------------------------------------------------

if [ ! $mode == "dev" ]; then
    if [ -d ~/dotfiles-versions/$version/alacritty ]; then
        _installSymLink alacritty ~/.config/alacritty ~/dotfiles/alacritty/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/vim ]; then
        _installSymLink vim ~/.config/vim ~/dotfiles/vim/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/nvim ]; then
        _installSymLink nvim ~/.config/nvim ~/dotfiles/nvim/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/starship ]; then
        _installSymLink starship ~/.config/starship.toml ~/dotfiles/starship/starship.toml ~/.config/starship.toml
    fi
    if [ -d ~/dotfiles-versions/$version/rofi ]; then
        _installSymLink rofi ~/.config/rofi ~/dotfiles/rofi/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/dunst ]; then
        _installSymLink dunst ~/.config/dunst ~/dotfiles/dunst/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/hypr ]; then
        _installSymLink hypr ~/.config/hypr ~/dotfiles/hypr/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/waybar ]; then
        _installSymLink waybar ~/.config/waybar ~/dotfiles/waybar/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/swaylock ]; then
        _installSymLink swaylock ~/.config/swaylock ~/dotfiles/swaylock/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/wlogout ]; then
        _installSymLink wlogout ~/.config/wlogout ~/dotfiles/wlogout/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/swappy ]; then
        _installSymLink swappy ~/.config/swappy ~/dotfiles/swappy/ ~/.config
    fi
    if [ -d ~/dotfiles-versions/$version/gtk ]; then
        _installSymLink .gtkrc-2.0 ~/.gtkrc-2.0 ~/dotfiles/gtk/.gtkrc-2.0 ~/.gtkrc-2.0
    fi
    if [ -d ~/dotfiles-versions/$version/gtk ]; then
        _installSymLink .Xresources ~/.Xresources ~/dotfiles/gtk/.Xresources ~/.Xresources
    fi
    if [ -d ~/dotfiles-versions/$version/gtk ]; then
        _installSymLink gtk-3.0 ~/.config/gtk-3.0 ~/dotfiles/gtk/gtk-3.0/ ~/.config/
    fi
    if [ -d ~/dotfiles-versions/$version/gtk ]; then
        _installSymLink gtk-4.0 ~/.config/gtk-4.0 ~/dotfiles/gtk/gtk-4.0/ ~/.config/            
    fi
else
    echo "Skipped: DEV MODE!"
fi
echo "Symbolic links created."
echo ""