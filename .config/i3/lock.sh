#!/bin/bash

IFS=$'\n'
icon="$HOME/.config/i3/lock-icon.png"
tmpBg='/tmp/screen.png'

#(( $# )) && { icon=$1; }

# Get screenshot and pixelate.
scrot "$tmpBg"
convert "$tmpBg" -scale 10% -scale 1000% -colorspace gray "$tmpBg"

# Get overlay icon size.
iconSize+=($(file $icon | sed -e 's/^.*, \([0-9]*\) x \([0-9]*\).*/\1\n\2/'))

# Get screen sizes.
screenSizes+=($(bash ~/.config/i3/screenResolutions.sh))
n=${#screenSizes[*]}

# Overlay icon and screenshot for every screen.
i=0
xSum=0
ySum=0
while [ $i -lt $((n/2)) ]; do
  let x=xSum+$((screenSizes[2*i]/2-iconSize[0]/2))
  let y=$((screenSizes[2*i+1]/2-iconSize[1]/2))
  convert "$tmpBg" "$icon" -geometry +$x+$y -composite "$tmpBg"
  let xSum+=$((screenSizes[2*i]))
  let i=i+1
done

i3lock -i "$tmpBg"
