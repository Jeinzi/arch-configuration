#!/bin/bash
cd "/media/veracrypt1/Backups/laptop.0"
rm "Created "*
rm pacman_database_*
rm packagelist

pacman -Qqe > packagelist
tar -cjf "./pacman_database_$(date +'%Y-%m-%d %H:%M').tar.bz2" /var/lib/pacman/local
touch "$(date +"Created %Y-%m-%d %H:%M")"