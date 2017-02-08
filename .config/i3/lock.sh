#!/usr/bin/env bash

icon="$HOME/.config/i3/lock-icon.png"
tmpBg='/tmp/screen.png'

#(( $# )) && { icon=$1;  }

scrot "$tmpBg"
convert "$tmpBg" -scale 10% -scale 1000% -colorspace gray "$tmpBg"
convert "$tmpBg" "$icon" -gravity center -composite -matte "$tmpBg"
i3lock -i "$tmpBg"
