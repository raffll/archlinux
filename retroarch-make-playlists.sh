#!/bin/bash

if [ $# -lt 1 ]; then
	exit
fi

case "$1" in

nointro)

	declare -a ZIP=(
			"Atari - 2600"
			"Atari - 5200"
			"Atari - 7800"
			"Atari - Jaguar"
			"Atari - Lynx"
			"Bandai - WonderSwan"
			"Bandai - WonderSwan Color"
			"Coleco - ColecoVision"
			"GCE - Vectrex"
			"Magnavox - Odyssey2"
			"Microsoft - MSX"
			"Microsoft - MSX2"
			"NEC - PC Engine - TurboGrafx 16"
			"NEC - PC Engine SuperGrafx"
			"Nintendo - Family Computer Disk System"
			"Nintendo - Game Boy"
			"Nintendo - Game Boy Advance"
			"Nintendo - Game Boy Color"
			"Nintendo - Nintendo 64"
			"Nintendo - Nintendo Entertainment System"
			"Nintendo - Super Nintendo Entertainment System"
			"Nintendo - Virtual Boy"
			"Philips - Videopac+"
			"Sega - 32X"
			"Sega - Game Gear"
			"Sega - Master System - Mark III"
			"Sega - Mega Drive - Genesis"
			"Sega - SG-1000"
			"SNK - Neo Geo Pocket"
			"SNK - Neo Geo Pocket Color"
			)

	for SYSTEM in "${ZIP[@]}"; do
		if [ -e "$SYSTEM" ]; then
			echo "Creating playlist for $SYSTEM..."
			cd "$SYSTEM"
			EXT=$(find -name '*.zip' | head -n 1)
			EXT=$(zipinfo -1 "$EXT")
			EXT="${EXT##*.}"
			for FILE in *.zip; do
				echo "$PWD/$FILE#${FILE%.zip}.$EXT" >> "../$SYSTEM.lpl"
				echo "${FILE%.zip}" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
			mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
			cd ..
		fi
	done
;;

redump)

	declare -a CUE=(
			"Sony - PlayStation"
			"Sega - Mega-CD - Sega CD"
			"Sega - Saturn"
			"NEC - PC Engine CD - TurboGrafx-CD"
			)

	declare -a ISO=(
			"Nintendo - GameCube"
			)

	declare -a GDI=(
			"Sega - Dreamcast"
			)

	for SYSTEM in "${CUE[@]}"; do
		if [ -e "$SYSTEM" ]; then
			echo "Creating playlist for $SYSTEM..."
			cd "$SYSTEM"
			find "$PWD" -type f -iname "*.cue" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				echo "${FILE%.cue}" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
			mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
			cd ..
		fi
	done

	for SYSTEM in "${ISO[@]}"; do
		if [ -e "$SYSTEM" ]; then
			echo "Creating playlist for $SYSTEM..."
			cd "$SYSTEM"
			find "$PWD" -type f -iname "*.iso" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				echo "${FILE%.iso}" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
			mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
			cd ..
		fi
	done

	for SYSTEM in "${GDI[@]}"; do
		if [ -e "$SYSTEM" ]; then
			echo "Creating playlist for $SYSTEM..."
			cd "$SYSTEM"
			find "$PWD" -type f -iname "*.gdi" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				echo "${FILE%.gdi}" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
			mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
			cd ..
		fi
	done
;;

c64)

	SYSTEM="Commodore - 64"

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		find "$PWD" -type f -iname "*.crt" -print0 | while IFS= read -r -d $'\0' FILE; do
			echo "$FILE" >> "../$SYSTEM.lpl"
			FILE=${FILE##*/}
			echo "${FILE%.crt}" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

a8bit)

	SYSTEM="Atari - XEGS"

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		find "$PWD" -type f -iname "*.car" -print0 | while IFS= read -r -d $'\0' FILE; do
			echo "$FILE" >> "../$SYSTEM.lpl"
			FILE=${FILE##*/}
			echo "${FILE%.car}" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
		done
		find "$PWD" -type f -iname "*.atx" -print0 | while IFS= read -r -d $'\0' FILE; do
			echo "$FILE" >> "../$SYSTEM.lpl"
			FILE=${FILE##*/}
			echo "${FILE%.atx}" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
		done
		find "$PWD" -type f -iname "*.atr" -print0 | while IFS= read -r -d $'\0' FILE; do
			echo "$FILE" >> "../$SYSTEM.lpl"
			FILE=${FILE##*/}
			echo "${FILE%.atr}" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
		done
		find "$PWD" -type f -iname "*.cas" -print0 | while IFS= read -r -d $'\0' FILE; do
			echo "$FILE" >> "../$SYSTEM.lpl"
			FILE=${FILE##*/}
			echo "${FILE%.cas}" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

dos)

	SYSTEM="DOS"

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		find "$PWD" -type f -iname "*.conf" -print0 | while IFS= read -r -d $'\0' FILE; do
			echo "$FILE" >> "../$SYSTEM.lpl"
			FILE=${FILE##*/}
			echo "${FILE%.conf}" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

mame)

	SYSTEM="MAME"

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for FILE in *.zip; do
			BASENAME=$(basename "$FILE" .zip)
			NAME=$(grep -A1 "name=\"$BASENAME\"" "$2" | grep -o -P '(?<=<description>).*(?=</description>)')
			IS_M=$(grep -A1 "name=\"$BASENAME\"" "$2" | grep -o -P 'ismechanical="yes"')
			IS_R=$(grep -A1 "name=\"$BASENAME\"" "$2" | grep -o -P 'runnable="no"')
			if [ "$NAME" != "" ] && [ "$IS_M" == "" ] && [ "$IS_R" == "" ]; then
				echo "$NAME"
				echo "$PWD/$FILE" >> "../$SYSTEM.lpl"
				echo "$NAME" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			fi
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

esac
