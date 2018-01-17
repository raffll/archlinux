#!/bin/bash

PREFIX="/home/braindead/.local/share/wineprefixes/AmpliTube 3"

qjackctl &
sleep 2 &
env WINEPREFIX="$PREFIX" vsthost "$PREFIX/drive_c/Program Files/VstPlugIns/AmpliTube 3.dll"
