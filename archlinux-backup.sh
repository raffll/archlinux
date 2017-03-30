#!/bin/sh

DATE=$(date +"%d-%m-%Y")
DIR=.

mkdir $DIR/$DATE

tar -cjvf $DIR/$DATE/etc-backup-$DATE.tar.bz2 /etc
tar -cjvf $DIR/$DATE/pacman-database-backup-$DATE.tar.bz2 /var/lib/pacman/local
tar -cjvf $DIR/$DATE/$USER-backup-$DATE.tar.bz2 -X exclude.txt $HOME/.[^.]*

pacman -Qe | awk '{print $1}' | sed ':a;N;$!ba;s/\n/ /g' > $DIR/$DATE/package-list-$DATE.txt
