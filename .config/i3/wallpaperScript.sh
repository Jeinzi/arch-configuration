# File that triggers next wallpaper on creation
file=~/.config/i3/next
# Delay between wallpapers in minutes
delay=15
delay=$[delay*60]
# Switch wallpaper once on startup.
touch $file

while true; do
    echo "Enter loop."
    # Remove file if it exists.
    fileExists=0
    if [ -f "$file" ]; then
        echo "File exists."
        fileExists=1
        rm $file
    fi

    # Switch wallpaper.
    if [ $fileExists -eq 1 ] || [ $SECONDS -ge delay ]; then
       feh --bg-fill --randomize --no-fehbg ~/Bilder/Verschiedenes/Wallpaper/Minimalism
    fi

	SECONDS=0
    echo "inotifywait"
    inotifywait -qqt $delay -e create "$(dirname $file)"
    echo "inotifywait quit"
done
