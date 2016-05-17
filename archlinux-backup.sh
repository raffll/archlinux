#!/bin/sh

DATE=$(date +"%m-%d-%Y")
DIR=/home/backup

tar -cjvf $DIR/etc-backup-$DATE.tar.bz2 /etc
tar -cjvf $DIR/pacman-database-backup-$DATE.tar.bz2 /var/lib/pacman/local
tar -cjvf $DIR/$USER-backup-$DATE.tar.bz2 \
			--exclude='.wine' \
			--exclude='.cache' \
			--exclude='.cabal' \
			--exclude='Steam' \
			--exclude='Trash' \
			--exclude='openmw' \
			--exclude='chromium' \
			--exclude='.kodi' \
			--exclude='.ccache' \
			--exclude='.mozilla' \
			--exclude='.IdeaIC14' \
			--exclude='.log' \
			--exclude='.thumbnails' \
			--exclude='unity3d' \
			$HOME/.[^.]*