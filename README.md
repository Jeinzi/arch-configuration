# My arch configuration

I keep track of my dotfiles and install scripts using a git repo sitting in my home directory. To install, clone
```
git clone https://github.com/jeinzi/dotfiles
```
while in your home directory, then merge with your existing files. Using bash, this can be done by executing
```m
shopt -s dotglob nullglob
cp -r dotfiles/* .
shopt -u dotglob nullglob
```
With zsh, which is what I use, the command is
```
cp -r dotfiles/*(D) . && rm -rf dotfiles
```
The calls to `shopt` respectively the `(D)` enable the matching of filenames starting with a dot, see this [StackExchange question](http://unix.stackexchange.com/questions/6393/how-do-you-move-all-files-including-hidden-from-one-directory-to-another) for information on other shells. The install script ```.config/install.sh``` does this merging automatically.


# Loads of details
I am dual booting Windows 10 and Arch. Following are all the infos on how I customized the latter.

## Desktop
- [i3-wm](https://i3wm.org/) + [helpers-for-i3](https://github.com/vivien/helpers-for-i3)

##### Bar
- [Polybar](https://github.com/jaagr/polybar)

![Image of my desktop](https://dl.dropboxusercontent.com/s/jvdf8zcsbl1w58y/desktop.png)

##### Battery Warning
https://github.com/agribu/i3-battery-warning
```bash
*/1 * * * * ~/.config/i3/i3-battery-warning.sh
```

##### Wallpaper
i3 config file executes
```bash
exec --no-startup-id ~/.config/i3/wallpaperScript.sh
```
on startup. This script waits for the file ```~/.config/i3/next``` to be created, which happens via shortcut.
It then deletes it immediately and executes ```nextWallpaper.sh```, which contains the path to a wallpaper directory and uses ```feh``` to select a new, random image from it.
Cron also switches the wallpaper every ten minutes:

```bash
*/10 * * * * ~/.config/i3/nextWallpaper.sh
```

##### Custom Shortcuts
Shortcut|Summary|i3-config
---|---|---
Mod+b|Browser|```bindsym $mod+b exec firefox```
Mod+Shift+b|Incognito browser|```bindsym $mod+Shift+b exec firefox --private-window```
Mod+c|Next wallpaper|```bindsym $mod+c exec touch ~/.config/i3/next```
Mod+x|Lock screen|```bindsym $mod+x exec betterlockscreen -l```
Mod+y|Lock and suspend|```bindsym $mod+y exec betterlockscreen -s```
Print|Screenshot|```bindsym Print exec shutter -s```
Mod+t|File Manager|```bindsym $mod+y exec thunar```
Mod+n|New Desktop|```bindsym $mod+n exec i3-new-workspace```

##### Theme & Icons
- Theme: [Materia](https://github.com/nana-4/materia-theme)
- Icons: [Lüv](https://github.com/Nitrux/luv-icon-theme)

![Image of thunar with icon theme](https://dl.dropboxusercontent.com/s/dc7kc26puc2ffpv/thunar.png)

##### Lockscreen
- [better-lockscreen](https://github.com/pavanjadhaw/betterlockscreen)
- Collection of suitable wallpapers in ```~/Pictures/Misc/Wallpaper/lockscreen```
- I'd like to have a cron job change the lockscreen every so often, but this currently fails.

![Image of my lockscreen](https://dl.dropboxusercontent.com/s/lcqj3xjjrrbb7du/lockscreen.png)

##### Disk Space Tracking
I track and visualize the used space on my hard drive with a custom python script cron runs every 30 minutes - I'll upload it eventually.

##### Browser
- firefox

Addon|Description
---|---
[uMatrix](https://addons.mozilla.org/en-US/firefox/addon/umatrix)|Block cookies, scripts, XSS etc. from unknown domains
[Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff)|Cool vim-style shortcuts
[Cookiebro](https://addons.mozilla.org/en-US/firefox/addon/cookiebro)|Delete all but whitelisted cookies regularly
[I don't care about cookies](https://addons.mozilla.org/en-US/firefox/addon/i-dont-care-about-cookies)|Don't show cookie warnings when first visiting websites. Needed for sanity when deleting nearly all cookies with Vanilla.

###### Custom Search Engines
I didn't find a way to add custom search engines to Firefox yet - but I used the following in Chrome:

**Name**|**Keyword**|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|**Name**|**Keyword**
---|---|---|---|---
Github|g||Stack Overflow|so
English Wikipedia|we||German Wikipedia|w
DuckDuckGo|duck||WolframAlpha|wa
Arch User Repository|aur||csd-electronics.de|csd
Google Images|b||Google Maps|m
Google Translator|t||YouTube|y
Ebay|e||Ebay Kleinanzeigen|ek
Minecraft Wiki|mine||Life in the Woods Wiki|litw
Amazon|a||Airbnb|bnb
Facebook|f||Twitter|tw
SoundCloud|s


###### Cookiebro Whitelist
I try to whitelist only the individual cookies that are absolutely necessary to keep me signed into a website. See [here](.doc/cookiebro-whitelist.txt) for the whitelist.


### Backups
I backup my data to an external hard drive, which I occasionally mirror onto a hard drive I store somewhere remote. Those two hard drives also store data I don't need to constantly keep on my main machine.

The backups are done by [rsnapshot](https://wiki.archlinux.org/index.php/Rsnapshot), which is a wonderful utility based on rsync. On each new backup a hardlinked copy of the previous backup is created and only modified files are replaced. That allows for an entire history of backups to exist with only minor overhead.

#### Config
```bash
config_version  1.2
snapshot_root   /media/veracrypt1/Backups/
no_create_root  1

# Some paths.
cmd_cp      /usr/bin/cp
cmd_rm      /usr/bin/rm
cmd_rsync   /usr/bin/rsync
cmd_logger  /usr/bin/logger
cmd_du      /usr/bin/du

# Script saving pacman database, package list and time of backup.
cmd_postexec    /home/jeinzi/.bin/backup.post.sh
# Save four backups in history.
retain  laptop  4

verbose     2
loglevel    3
lockfile    /home/jeinzi/rsnapshot.pid
du_args     -csh


# Home
backup  /home/jeinzi/.TIPP10/./         TIPP10
backup  /home/jeinzi/Downloads/./       Downloads
backup  /home/jeinzi/Software/./        Software

# Minecraft
backup  /home/jeinzi/.litwrl/./             litwrl
backup  /home/jeinzi/.minecraft/saves/./    minecraft/saves

# EMail
backup  /home/jeinzi/.thunderbird/y098igl3.default/ImapMail/imap.gmx-1.net/./       mail/address@gmx.de

# Backup important config files.
backup  /etc/   Config  include=/etc/rsnapshot.conf,exclude=/etc/*
```

#### Mirror to offsite backup
It is important to preserve the hardlinks set by rsnapshot:

```bash
rsync --info=progress2 --delete -avH veracrypt1/ veracrypt2/
```