#!/bin/bash

PREFIX="$HOME/.local/share/wineprefixes/AmpliTube 3"

env WINEPREFIX="$PREFIX" vsthost "$PREFIX/drive_c/Program Files/VstPlugIns/AmpliTube 3.dll"
