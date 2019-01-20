#!/bin/bash

entries=(Single-Screen Dual-Screen)
commands=(
~/.screenlayout/single.sh
~/.screenlayout/dual.sh
)

##
#  Generate entries, where first is key.
##
function show_entries()
{
    for e in "${entries[@]}"
    do
        echo $e
    done
}

# Check for command line arguments.
if [[ -z "$@" ]]; then
    # Echo menu entries if nothing was passed.
    show_entries
else
    # Execute xrandr command corresponding to the chosen menu entry.
    i=0
    for e in "${entries[@]}"
    do
        if [[ "$@" == "${entries[$i]}" ]]; then
            break
        fi;
        ((i++))
    done
    $( ${commands[$i]} )
    i3-msg restart
    touch ~/.config/i3/next
fi
