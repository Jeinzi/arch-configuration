#!/bin/bash
# Set field separator to newline.
#IFS=$'\n'

# Get xrandr output and delete all lines, that don't have "connected" in them.
SCREENS="$(xrandr --screen 0 | sed -n '/^.*connected/p')"

# Primary display.
RESOLUTION+=($(echo "${SCREENS}" | sed -n 's/^.*connected primary \([0-9]*\)x\([0-9]*\).*/\1\n\2/p'))

# All other screens.
# Remove primary screen from list.
SCREENS="$(echo "${SCREENS}" | sed -e '/^.*connected primary.*$/d')"

# Iterate over all other screens.
IFS=$'\n'
for line in $SCREENS; do
  RESOLUTION+=($(echo "${SCREENS}" | sed -n 's/^.*connected \([0-9]*\)x\([0-9]*\).*/\1\n\2/p'))
done

# Output screens and resolutions.
i=0
n=${#RESOLUTION[*]}
while [ $i -lt $n  ]; do
  echo ${RESOLUTION[$i]}
  let i=i+1
done
