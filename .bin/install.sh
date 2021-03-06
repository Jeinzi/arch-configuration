# Variables
user=jeinzi

# Go to install directory
cd ~
mkdir -p Downloads
cd Downloads
mkdir -p install

# Installation
sudo pacman -S base base-devel --noconfirm
sudo pacman -S git sshfs --noconfirm
sudo pacman -S i3 xfce4-terminal compton lxappearance rofi feh numlockx --noconfirm
sudo pacman -S arc-gtk-theme alsa-utils network-manager-applet gst-libav --noconfirm
sudo pacman -S firefox thunderbird thunar xarchiver inkscape gimp texlive-most texmaker mplayer --noconfirm

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
yaourt -S i3blocks moka-icon-theme oh-my-zsh-git --noconfirm
yaourt -S thefuck illum-git playerctl shutter tumbler ffmpegthumbnailer --noconfirm
yaourt -S spotify staruml arduino eagle dropbox veracrypt ttf-impallari-dosis --noconfirm

# Configuration
echo numlockx & > ~/.xinitrc
echo exec i3 >> ~/.xinitrc
echo eval $(thefuck --alias) >> ~/.bashrc
echo eval $(thefuck --alias) >> ~/.zshrc
echo alias imv='imv -b checks' >> ~/.bashrc
echo alias imv='imv -b checks' >> ~/.zshrc
chsh -s /bin/zsh ${user}

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

# Install i3 helper scripts
cd /etc
sudo git clone https://github.com/vivien/helpers-for-i3.git

# Battery warning script
sudo echo "*/1 * * * * ~/.config/i3/i3-battery-warning.sh" >> /var/spool/cron/$user

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
