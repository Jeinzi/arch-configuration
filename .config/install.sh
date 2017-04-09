# Variables
user=jeinzi

# Go to install directory
cd ~
mkdir -p Downloads
cd Downloads
mkdir -p install

# Installation
sudo pacman -S base base-devel
sudo pacman -S i3 xfce4-terminal git zsh compton lxappearance sshfs firefox rofi thunderbird thunar inkscape feh gimp texlive-most texmaker arc-gtk-theme alsa-utils network-manager-applet gst-libav mplayer --noconfirm

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
yaourt -S i3blocks moka-icon-theme thefuck spotify staruml illum-git playerctl arduino eagle shutter dropbox tumbler ffmpegthumbnailer 
veracrypt --noconfirm

# Configuration
sudo echo exec i3 > ~/.xinitrc
sudo echo eval $(thefuck --alias) >> ~/.bashrc
sudo chsh -s /bin/zsh ${user}

# Enable service to change screen brightness
sudo systemctl enable illum.service & sudo systemctl start illum.service

# Give arduino IDE permission to use serial port
usermod -a -G uucp ${user}

# Merge git repo into existing file structure
cd ~
git clone https://github.com/Jeinzi/dotfiles.git
shopt -s dotglob nullglob
sudo cp -r dotfiles/* .
shopt -u dotglob nullglob
rm -rf dotfiles

# Firefox theme
cd ~/Downloads/install
git clone https://github.com/horst3180/arc-firefox-theme
cd arc-firefox-theme
./autogen.sh --prefix=/usr --disable-light --disable-dark
sudo make install

# Add custom i3blocks
sudo cp ~/.config/i3/custom-blocks/brightness-custom /usr/lib/i3blocks/brightness
sudo cp ~/.config/i3/custom-blocks/battery-custom /usr/lib/i3blocks/battery
sudo cp ~/.config/i3/custom-blocks/volume-custom /usr/lib/i3blocks/volume

# Install fonts
cd ~/Downloads/install
git clone https://github.com/FortAwesome/Font-Awesome.git
cp Font-Awesome/fonts/fontawesome-webfont.ttf ~/.fonts 

# Remove install directory
cd ~/Downloads
rm -rf install

# Start desktop environment if neccessary
if ! xset q &>/dev/null; then
	startx
fi
feh --bg-scale ~/Bilder/Wallpaper/forest.jpg

# Set time zone
timedatectl set-timezone Europe/Berlin
