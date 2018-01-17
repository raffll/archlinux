#!/bin/sh

FILE="$1"

if [[ $FILE == *.nes ]]; then
	retroarch -L ~/.config/retroarch/cores/fceumm_libretro.so "$1"
elif [[ $FILE == *.sfc ]]; then
	retroarch -L ~/.config/retroarch/cores/snes9x_libretro.so "$1"
elif [[ $FILE == *.zip ]]; then
	FILE=$(zipinfo -1 "$1" | head -1)
	if [[ $FILE == *.nes ]]; then
		retroarch -L ~/.config/retroarch/cores/fceumm_libretro.so "$1"
	fi
	if [[ $FILE == *.sfc ]]; then
		retroarch -L ~/.config/retroarch/cores/snes9x_libretro.so "$1"
	fi
elif [[ $FILE == *.atr ]]; then
	retroarch -L ~/.config/retroarch/cores/atari800_libretro.so "$1"
elif [[ $FILE == *.atx ]]; then
	retroarch -L ~/.config/retroarch/cores/atari800_libretro.so "$1"
elif [[ $FILE == *.cas ]]; then
	retroarch -L ~/.config/retroarch/cores/atari800_libretro.so "$1"
elif [[ $FILE == *.car ]]; then
	retroarch -L ~/.config/retroarch/cores/atari800_libretro.so "$1"
elif [[ $FILE == *.g64 ]]; then
	x64 -autostart "$1"
elif [[ $FILE == *.d64 ]]; then
	x64 -autostart "$1"
elif [[ $FILE == *.crt ]]; then
	x64 -autostart "$1"
elif [[ $FILE == *.tap ]]; then
	x64 -autostart "$1"
fi
