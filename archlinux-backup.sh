#!/bin/sh

DATE=$(date +"%d-%m-%Y")
DIR="$HOME/Backup"

mkdir $DIR/$DATE

if [ ! -e "$DIR" ]; then
	mkdir "$DIR"
fi

tar -cjvf $DIR/$DATE/etc-backup-$DATE.tar.bz2 /etc
tar -cjvf $DIR/$DATE/pacman-database-backup-$DATE.tar.bz2 /var/lib/pacman/local
tar -cjvf $DIR/$DATE/$USER-backup-$DATE.tar.bz2 --exclude='.wine' \
												--exclude='.cache' \
												--exclude='.cabal' \
												--exclude='Steam' \
												--exclude='Trash' \
												--exclude='openmw' \
												--exclude='chromium' \
												--exclude='chromium-back-ovfs' \
												--exclude='opera' \
												--exclude='opera-back-ovfs' \
												--exclude='.kodi' \
												--exclude='.ccache' \
												--exclude='.mozilla' \
												--exclude='.IdeaIC14' \
												--exclude='.log' \
												--exclude='.thumbnails' \
												--exclude='unity3d' \
												--exclude='retroarch' \
												$HOME/.[^.]*

pacman -Qe | awk '{print $1}' | sed ':a;N;$!ba;s/\n/ /g' > $DIR/$DATE/package-list-$DATE.txt
