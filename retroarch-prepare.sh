#!/bin/bash


DIR_DOS="$HOME/Backup/Emulatory/eXoDOS/eXoDOS/Games/"


USAGE="Usage: $0 nointro | c64 | redump | a8bit | dos | mame | other"

if [ $# -lt 1 ]; then
	echo "$USAGE"
	exit
fi

case "$1" in

nointro)

	DIR="$HOME/Pliki/Torrent/No-Intro"

	declare -a ARR=(
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
			#"Nintendo - Pokemon Mini"
			"Nintendo - Super Nintendo Entertainment System"
			"Nintendo - Virtual Boy"
			"Philips - Videopac+"
			"Sega - 32X"
			"Sega - Game Gear"
			"Sega - Master System - Mark III"
			"Sega - Mega Drive - Genesis"
			#"Sega - PICO"
			"Sega - SG-1000"
			"SNK - Neo Geo Pocket"
			"SNK - Neo Geo Pocket Color"
			)

	for SYSTEM in "${ARR[@]}"; do

		if [ -e "$SYSTEM" ]; then
			echo "Refreshing $SYSTEM..."
			cd "$SYSTEM"
			rm *.zip 2> /dev/null
		else
			echo "Creating $SYSTEM..."
			mkdir "$SYSTEM"
			cd "$SYSTEM"
		fi

		find "$DIR/$SYSTEM" \
		-name '*.zip' \
		! -name '*\[BIOS\]*' \
		! -name '*(Sample*'  \
		! -name '*(Beta*' \
		! -name '*(Demo*' \
		! -name '*(Program*' \
		! -name '*(SDK*' \
		-exec ln -s {} . \;

		cd ..
	done
;;

c64)

	DIR="$HOME/Pliki/Torrent/No-Intro"

	SYSTEM="Commodore - 64"

	declare -a ARR=("Commodore - 64"
			"Commodore - 64 (PP)"
			"Commodore - 64 (Tapes)")

	if [ -e "$SYSTEM" ]; then
		echo "Refreshing $SYSTEM..."
		rm -r "$SYSTEM"
		mkdir "$SYSTEM"
		cd "$SYSTEM"
	else
		echo "Creating $SYSTEM..."
		mkdir "$SYSTEM"
		cd "$SYSTEM"
	fi

	for SYS in "${ARR[@]}"; do

		find "$DIR/$SYS" \
		-name '*.zip' \
		! -name '*\[BIOS\]*' \
		! -name '*(Sample*'  \
		! -name '*(Beta*' \
		! -name '*(Demo*' \
		! -name '*(Program*' \
		! -name '*(SDK*' \
		-exec ln -s {} . \;

		unzip '*.zip'
		rm *.zip 2> /dev/null
	done

	find "$PWD" -type f -iname "*.nib" -print0 | while IFS= read -r -d $'\0' FILE; do
		wine "$PATH/nibconv.exe" "$FILE" "${FILE%.nib}.g64"
		rm "$FILE"
	done
;;

a8bit)

	DIR="$HOME/Pliki/Torrent/Atari 8bit Preserved Software 2017-08-01"

	SYSTEM="Atari - XEGS"

	if [ -e "$SYSTEM" ]; then
		echo "Refreshing $SYSTEM..."
		rm -r "$SYSTEM"
		mkdir "$SYSTEM"
		cd "$SYSTEM"
	else
		echo "Creating $SYSTEM..."
		mkdir "$SYSTEM"
		cd "$SYSTEM"
	fi
		
	find "$DIR" -name '*.zip' -exec ln -s {} . \;
	find -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
	rm *.zip 2> /dev/null
;;

mame)

	DIR="$HOME/Pliki/Torrent/MAME 0.193 ROMs (merged)"

	SYSTEM="MAME"

	if [ -e "$SYSTEM" ]; then
		echo "Refreshing $SYSTEM..."
		cd "$SYSTEM"
		rm *.zip 2> /dev/null
	else
		echo "Creating $SYSTEM..."
		mkdir "$SYSTEM"
		cd "$SYSTEM"
	fi
			
	find "$DIR" -name '*.zip' -exec ln -s {} . \;
;;

*)
	echo "$USAGE"
;;

esac
