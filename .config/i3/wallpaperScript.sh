# File that triggers next wallpaper on creation
file=~/.config/i3/next
# Delay between wallpapers in minutes
delay=15
delay=$[delay*60]
# Switch wallpaper once on startup.
touch $file

while true; do
    # Remove file if it exists.
    fileExists=0
    if [ -f "$file" ] || [ $SECONDS -ge delay ]; then
        ~/.config/i3/nextWallpaper.sh
    fi

	SECONDS=0
    inotifywait -qqt $delay -e create "$(dirname $file)"
done
