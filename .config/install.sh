# Go to install directory
cd ~
mkdir -p Downloads
cd Downloads
mkdir -p install

# Installation
sudo pacman -S i3 xfce4-terminal git zsh compton lxappearance scrot sshfs firefox rofi thunderbird thunar veracrypt inkscape feh gimp texlive-most texmaker arc-gtk-theme alsa-utils

# Install yaourt
curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
tar -xvzf package-query.tar.gz
cd package-query
makepkg -si
cd ..

curl -O https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xvzf yaourt.tar.gz
cd yaourt
makepkg -si
cd ..

# AUR installations
yaourt i3blocks
yaourt moka-icon-theme
yaourt thefuck
yaourt spotify proprietary
yaourt staruml

# Configuration
sudo echo exec i3 > ~/.xinitrc
sudo echo eval $(thefuck --alias) >> ~/.bashrc
cd ~
git clone https://github.com/Jeinzi/dotfiles.git
# ToDo: Clone directly into home
# ToDo: Configure zsh

# Firefox theme
cd ~/Downloads/install
git clone https://github.com/horst3180/arc-firefox-theme
cd arc-firefox-theme
./autogen.sh --prefix=/usr --disable-light --disable-dark
sudo make install

# Remove install directory
cd ~/Downloads
rm -r install

# Start desktop environment if neccessary
if ! xset q &>/dev/null; then
	startx
fi
feh --bg-scale ~/Bilder/Wallpaper/forest.jpg

# Set time zone
timedatectl set-timezone Europe/Berlin
