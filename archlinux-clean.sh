#!/bin/sh

sudo find -L /usr/share/themes/ -maxdepth 1 -type l -delete
sudo find -L /usr/share/icons/ -maxdepth 1 -type l -delete
sudo ln -s $HOME/.themes/* /usr/share/themes/
sudo ln -s $HOME/.icons/* /usr/share/icons/

sudo rm -vr $HOME/.local/share/Trash/files/*
sudo rm -vr $HOME/.local/share/Trash/expunged/*
sudo rm -vr $HOME/.local/share/Trash/info/*
sudo rm -vr /home/.Trash-0
sudo rm -vr /"\$RECYCLE.BIN"
sudo rm -vr /home/"\$RECYCLE.BIN"
sudo rm -vr /var/cache/pacman/pkg/*.xz.part

rm -vr $HOME/.local/share/applications/wine-extension*
rm -vr $HOME/.local/share/applications/wine
rm -vr $HOME/.local/share/desktop-directories/
rm -vr $HOME/.local/share/icons
rm -vr $HOME/.config/menus/applications-merged

rm -vr $HOME/.config/xfce4/xfce4-notes.gtkrc*
rm -vr $HOME/.config/xfce4/panel/xfce4-notes-plugin*

#find $(xdg-user-dir MUSIC) -type f -not \( -name '*.mp3' -or -name '*.flac' -or -name '*.MP3' \) #-delete
#find $(xdg-user-dir MUSIC) -depth -empty #-delete
