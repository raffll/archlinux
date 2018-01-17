#!/bin/sh

DATE=$(date +"%d-%m-%Y")
DIR="$HOME/Backup"

if [ ! -e "$DIR" ]; then
	mkdir "$DIR"
fi

if [ ! -e "$DIR/$DATE" ]; then
	mkdir "$DIR/$DATE"
fi

tar -cjvf $DIR/$DATE/etc-backup-$DATE.tar.bz2 /etc
tar -cjvf $DIR/$DATE/pacman-database-backup-$DATE.tar.bz2 /var/lib/pacman/local
tar -cjvf $DIR/$DATE/$USER-backup-$DATE.tar.bz2 --exclude='.local/share/Steam' \
												--exclude='.local/share/Trash' \
												--exclude='.local/share/openmw' \
												--exclude='.local/share/unity3d' \
												--exclude='.local/share/baloo' \
												--exclude='.local/share/wineprefixes' \
												--exclude='.config/chromium' \
												--exclude='.config/chromium-back-ovfs' \
												--exclude='.config/opera' \
												--exclude='.config/opera-back-ovfs' \
												--exclude='.wine' \
												--exclude='.cache' \
												--exclude='.cabal' \
												--exclude='.dropbox-dist' \
												--exclude='.kodi' \
												--exclude='.ccache' \
												--exclude='.mozilla' \
												--exclude='.IdeaIC14' \
												--exclude='.log' \
												--exclude='.steam' \
												--exclude='.thumbnails' \
												--exclude='.config/retroarch/cores' \
												--exclude='.config/retroarch/roms' \
												$HOME/.[^.]*

pacman -Qe | awk '{print $1}' | sed ':a;N;$!ba;s/\n/ /g' > $DIR/$DATE/package-list-$DATE.txt
