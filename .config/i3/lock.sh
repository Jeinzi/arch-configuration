#!/bin/bash

IFS=$'\n'
icon="$HOME/.config/i3/lock-icon.png"
tmpBg='/tmp/screen.png'
filter=smartblur=5:1

# Allow icon to be set via argument,
(( $# )) && { icon=$1; }

# Get overlay icon size.
iconSize+=($(file $icon | sed -e 's/^.*, \([0-9]*\) x \([0-9]*\).*/\1\n\2/'))
iw=iconSize[0]
ih=iconSize[1]

# Get screen sizes.
screenSizes+=($(bash ~/.config/i3/screenResolutions.sh))
n=${#screenSizes[*]}

# Create filters.
i=0
xSum=0
yMax=0

while [ $i -lt $((n/2)) ]; do
  w=$((screenSizes[2*i]))
  h=$((screenSizes[2*i+1]))
  let x=xSum+$((w/2-iw/2))
  let y=$((h/2-ih/2))
  filter+=,overlay=x=$x:y=$y
  iconRef+="-i ${icon} " 

  if [ $yMax -lt $h ]; then
    let yMax=h
  fi
  let xSum+=w
  let i=i+1
done

# Get maximum screen size (all screens together).
res=${xSum}x${yMax}

# Create image.
eval ffmpeg -f x11grab -video_size $res -y -i $DISPLAY $iconRef -filter_complex "$filter" -vframes 1 $tmpBg

i3lock -i "$tmpBg"
rm $tmpBg
