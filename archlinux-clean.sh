#!/bin/sh

sudo find -L /usr/share/themes/ -maxdepth 1 -type l -delete  2> /dev/null
sudo find -L /usr/share/icons/ -maxdepth 1 -type l -delete  2> /dev/null
sudo ln -s $HOME/.themes/* /usr/share/themes/  2> /dev/null
sudo ln -s $HOME/.icons/* /usr/share/icons/  2> /dev/null

sudo rm -vr $HOME/.local/share/Trash/files/*  2> /dev/null
sudo rm -vr $HOME/.local/share/Trash/expunged/*  2> /dev/null
sudo rm -vr $HOME/.local/share/Trash/info/*  2> /dev/null
sudo rm -vr /home/.Trash-0  2> /dev/null
sudo rm -vr /"\$RECYCLE.BIN"  2> /dev/null
sudo rm -vr /home/"\$RECYCLE.BIN"  2> /dev/null
sudo rm -vr /var/cache/pacman/pkg/*.xz.part  2> /dev/null

rm -vr $HOME/.local/share/applications/wine-extension*  2> /dev/null
rm -vr $HOME/.local/share/applications/wine  2> /dev/null
rm -vr $HOME/.local/share/desktop-directories/wine*  2> /dev/null
rm -vr $HOME/.config/menus/applications-merged/wine*  2> /dev/null

rm -vr $HOME/.config/xfce4/xfce4-notes.gtkrc*  2> /dev/null
rm -vr $HOME/.config/xfce4/panel/xfce4-notes-plugin*  2> /dev/null
