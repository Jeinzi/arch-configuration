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

##### Custom Shortcuts
Shortcut|Summary|i3-config
---|---|---
Mod+b|Browser|```bindsym $mod+b exec google-chrome-stable```
Mod+Shift+b|Incognito browser|```bindsym $mod+Shift+b exec google-chrome-stable --incognito```
Mod+c|Next wallpaper|```bindsym $mod+c exec touch ~/.config/i3/next```
Mod+x|Lock screen|```bindsym $mod+x exec betterlockscreen -l```
Mod+y|Lock and suspend|```bindsym $mod+y exec betterlockscreen -s```
Print|Screenshot|```bindsym Print exec shutter -s```
Mod+t|File Manager|```bindsym $mod+y exec thunar```

##### Lockscreen
- [better-lockscreen](https://github.com/pavanjadhaw/betterlockscreen)
- Collection of suitable wallpapers in ```~/Pictures/Misc/Wallpaper/lockscreen```
- Cron changes lockscreen wallpaper every 14 minutes. That's because there are already other tasks schedules for every 15th minute.

```bash
*/14 * * * * cd /home/jeinzi/Pictures/Misc/Wallpaper/lockscreen && betterlockscreen -u .
```

![Image of my lockscreen](https://dl.dropboxusercontent.com/s/dc7kc26puc2ffpv/thunar.png)

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

##### Bar
- [Polybar](https://github.com/jaagr/polybar)

![Image of my desktop](https://dl.dropboxusercontent.com/s/jvdf8zcsbl1w58y/desktop.png)

##### Battery Warning
https://github.com/agribu/i3-battery-warning
```bash
*/1 * * * * ~/.config/i3/i3-battery-warning.sh
```

##### Theme & Icons
- Theme: [Materia](https://github.com/nana-4/materia-theme)
- Icons: [Lüv](https://github.com/Nitrux/luv-icon-theme)

![Image of thunar with icon theme](https://dl.dropboxusercontent.com/s/dc7kc26puc2ffpv/thunar.png)


##### Disk Space Tracking



##### Browser
- google-chrome-stable

Addon|Description
---|---
uMatrix|Block cookies, scripts, XSS etc. from unknown domains
Vimium|Cool vim-style shortcuts
Vanilla Cookie Manager|Delete all but whitelisted cookies on startup
I don't care about cookies|Don't show cookie warnings when first visiting websites. Needed for sanity when deleting nearly all cookies with Vanilla.  
Real-Time Tab Sync|Sync currently open tabs between OSs and machines. Uses chromes sync feature and its encryption.
Don't add custom search engines|Prevent websites from adding custom search shortcuts.

###### Custom Search Engines
Name|Keyword
---|---
Airbnb|bnb
Amazon|a
Arch User Repository|aur
csd-electronics.de|csd
DuckDuckGo|duck
Ebay|e
Ebay Kleinanzeigen|ek
English Wikipedia|we
Facebook|f
Github|g
Google Images|b
Google Maps|m
Life in the Woods Wiki|litw
Minecraft Wiki|mine
SoundCloud|s
Stack Overflow|so
Google Translator|t
Twitter|tw
Wikipedia|w
WolframAlpha|wa
YouTube|y

###### Vanilla Whitelist
- *.amazon.de
- amzn.to
- app.n26.com
- dropbox.com
- *.ebay.com
- *.ebay.de
- *.github.com
- *.google.com
- *.google.de
- *.mathworks.com
- *.soundcloud.com
- *.stackoverflow.com
- *.thingiverse.com
- *.todoist.com
- *.twitch.tv
- web.threema.ch
- web.whatsapp.com
- wikipedia.org
- www.coursera.org
- www.ebay-kleinanzeigen.de
- www.facebook.com
- www.mathworks.com
- *.youtube.com


### Backups
###### Config File Example
- First column: source
- Second column: destination relative to backup directory

```bash
"/home/jeinzi/TIPP10" "TIPP10"
"/mnt/windows/Users/Jeinzi/AppData/Roaming/.minecraft/saves" "minecraft/saves"
"/mnt/windows/Users/Jeinzi/Documents" "Dokumente-Windows"
```

###### Command
```bash
volume=veracrypt2
cat /home/jeinzi/.config/backupList | sed -En "s/^\"([^\"]*)\"[[:blank:]]\"([^\"]*)\"/sudo rsync -ah --progress --delete '\1' '\/media\/${volume}\/Backups\/Laptop\/\2'/p" | bash -
cd "/media/${volume}/Backups/Laptop";
rm Last\ modified*
rm pacman_database_*
pacman -Qqe > packagelist
tar -cjf "/media/${volume}/Backups/Laptop/pacman_database_$(date +'%Y-%m-%d %H:%M').tar.bz2" /var/lib/pacman/local
touch "$(date +"Last modified %Y-%m-%d %H:%M")"
```
