#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
MONITOR=eDP-1 polybar internal-monitor &
MONITOR=HDMI-1 polybar hdmi-monitor &

echo "Polybar launched."