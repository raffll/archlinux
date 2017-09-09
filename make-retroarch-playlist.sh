#!/bin/bash

DIR_NOINTRO="$HOME/Torrent/No-Intro"
DIR_ATARI800="$HOME/Torrent/Atari 8bit Preserved Software 2017-08-01"
DIR_MAME="$HOME/Torrent/MAME 0.189 ROMs (merged)"
MAME_DAT="$HOME/Gry/RetroArch/ARCADE 189.dat"
NIBCONV="$HOME/.bin/nibconv.exe"
RETROARCH_PLAYLIST="$HOME/.config/retroarch/playlists"
USAGE="Usage: $0 nointro | c64 | redump | atari800 | dos | mame"

if [ $# -lt 1 ]; then
	echo "$USAGE"
	exit
fi

case "$1" in

nointro)

	declare -a ARR=("Atari - 2600"
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
			"Nintendo - Pokemon Mini"
			"Nintendo - Super Nintendo Entertainment System"
			"Nintendo - Virtual Boy"
			"Philips - Videopac+"
			"Sega - 32X"
			"Sega - Game Gear"
			"Sega - Master System - Mark III"
			"Sega - Mega Drive - Genesis"
			"Sega - PICO"
			"Sega - SG-1000"
			"SNK - Neo Geo Pocket"
			"SNK - Neo Geo Pocket Color")

	for SYSTEM in "${ARR[@]}"; do

		if [ -e "$DIR_NOINTRO/$SYSTEM" ]; then

			if [ -e "$SYSTEM" ]; then
				echo "Refreshing $SYSTEM..."
				cd "$SYSTEM"
				rm *.zip 2> /dev/null
				rm *.lpl 2> /dev/null
			else
				echo "Creating $SYSTEM..."
				mkdir "$SYSTEM"
				cd "$SYSTEM"
			fi
		
			find "$DIR_NOINTRO/$SYSTEM" \
			-name '*.zip' \
			! -name '*\[BIOS\]*' \
			! -name '*(Sample*'  \
			! -name '*(Beta*' \
			! -name '*(Demo*' \
			! -name '*(Program*' \
			! -name '*(SDK*' \
			-exec ln -s {} . \;

			for ZIPFILE in *.zip; do
				FILE=$(zipinfo -1 "$ZIPFILE" | head -1)
				echo "$PWD/$ZIPFILE#$FILE" >> "$SYSTEM.lpl"
				echo "$ZIPFILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
			done

			mv "$SYSTEM.lpl" "$RETROARCH_PLAYLIST"
			cd ..
		else
			echo "$DIR_NOINTRO/$SYSTEM not found!"
		fi
	done
;;

c64)

	declare -a ARR=("Commodore - 64"
			"Commodore - 64 (PP)"
			"Commodore - 64 (Tapes)")

	if [ -e "Commodore - 64 (Disks)" ]; then
		mv "Commodore - 64 (Disks)" "Commodore - 64 (PP)"
	fi

	for SYSTEM in "${ARR[@]}"; do

		if [ -e "$DIR_NOINTRO/$SYSTEM" ]; then
			
			if [ -e "$SYSTEM" ]; then
				echo "Refreshing $SYSTEM..."
				cd "$SYSTEM"
				rm *.crt 2> /dev/null
				rm *.g64 2> /dev/null
				rm *.d64 2> /dev/null
				rm *.tap 2> /dev/null
				rm *.nib 2> /dev/null
				rm *.zip 2> /dev/null
				rm *.lpl 2> /dev/null
			else
				echo "Creating $SYSTEM..."
				mkdir "$SYSTEM"
				cd "$SYSTEM"
			fi

			find "$DIR_NOINTRO/$SYSTEM" \
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

			if [ "$SYSTEM" == "Commodore - 64 (PP)" ]; then
				for FILE in *.nib; do
					NEWFILE="`basename "$FILE" .nib`.g64"
					if [ ! -e "$NEWFILE" ]; then
						wine "$NIBCONV" "$FILE" "$NEWFILE"
					fi
				done
				rm *.nib 2> /dev/null
				SYSTEM="Commodore - 64 (Disks)"
				mv "../${ARR[1]}" "../$SYSTEM"
			fi

			for FILE in *; do
				echo "$PWD/$FILE" >> "$SYSTEM.lpl"
				echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
			done

			mv "$SYSTEM.lpl" "$RETROARCH_PLAYLIST"
			cd ..
		else
			echo "$DIR_NOINTRO/$SYSTEM not found!"
		fi
	done
;;

redump)

	declare -a ARR=("Sony - PlayStation"
			"Nintendo - GameCube")

	for SYSTEM in "${ARR[@]}"; do

		if [ -e "$SYSTEM" ]; then

			echo "Refreshing $SYSTEM..."
			cd "$SYSTEM"
			rm *.lpl 2> /dev/null

			if [ "$SYSTEM" == "Sony - PlayStation" ]; then
				find "$PWD" -type f -iname "*.cue" -print0 | while IFS= read -r -d $'\0' FILE; do
					echo "$FILE" >> "$SYSTEM.lpl"
					echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
					echo "DETECT" >> "$SYSTEM.lpl"
					echo "DETECT" >> "$SYSTEM.lpl"
					echo "DETECT" >> "$SYSTEM.lpl"
					echo "$SYSTEM.lpl" >> "$SYSTEM.lpl" 
				done
			fi

			if [ "$SYSTEM" == "Nintendo - GameCube" ]; then
				find "$PWD" -type f -iname "*.iso" -print0 | while IFS= read -r -d $'\0' FILE; do
					echo "$FILE" >> "$SYSTEM.lpl"
					echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
					echo "DETECT" >> "$SYSTEM.lpl"
					echo "DETECT" >> "$SYSTEM.lpl"
					echo "DETECT" >> "$SYSTEM.lpl"
					echo "$SYSTEM.lpl" >> "$SYSTEM.lpl" 
				done
			fi

			mv "$SYSTEM.lpl" "$RETROARCH_PLAYLIST"
			cd ..
		else
			echo "$SYSTEM not found!"
		fi
	done
;;

atari800)

	declare -a ARR=("Atari - 800"
			"Atari - 800 (Disks)"
			"Atari - 800 (Tapes)")

	if [ -e "$DIR_ATARI800" ]; then
	
		mkdir "TEMP"
		cd "TEMP"

		find "$DIR_ATARI800" \
		-name '*.zip' \
		-exec ln -s {} . \;

		unzip '*.zip'
		rm *.zip 2> /dev/null
		chmod 644 *

		cd ..

		for SYSTEM in "${ARR[@]}"; do

			if [ -e "$SYSTEM" ]; then
				echo "Refreshing $SYSTEM..."
				cd "$SYSTEM"
				rm *.atr 2> /dev/null
				rm *.atx 2> /dev/null
				rm *.car 2> /dev/null
				rm *.cas 2> /dev/null
				rm *.lpl 2> /dev/null
			else
				echo "Creating $SYSTEM..."
				mkdir "$SYSTEM"
				cd "$SYSTEM"
			fi

			if [ "$SYSTEM" == "${ARR[0]}" ]; then
				mv ../TEMP/*.car .
			fi

			if [ "$SYSTEM" == "${ARR[1]}" ]; then
				mv ../TEMP/*.atr .
				mv ../TEMP/*.atx .
			fi

			if [ "$SYSTEM" == "${ARR[2]}" ]; then
				mv ../TEMP/*.cas .
			fi

			for FILE in *; do
				echo "$PWD/$FILE" >> "$SYSTEM.lpl"
				echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
			done

			mv "$SYSTEM.lpl" "$RETROARCH_PLAYLIST"
			cd ..
		done
		rm -r "TEMP"
	else
		echo "$DIR_ATARI800 not found!"
	fi
;;

dos)

	echo "Refreshing DOS..."
	cd "DOS"
	rm *.lpl 2> /dev/null

	for FILE in *.conf; do
		echo "$PWD/$FILE" >> "DOS.lpl"
		echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "DOS.lpl"
		echo "DETECT" >> "DOS.lpl"
		echo "DETECT" >> "DOS.lpl"
		echo "DETECT" >> "DOS.lpl"
		echo "DOS.lpl" >> "DOS.lpl"
	done

	mv "DOS.lpl" "$RETROARCH_PLAYLIST"
;;

mame)

	if [ -e "$DIR_MAME" ]; then

		if [ -e "MAME" ]; then
			echo "Refreshing MAME..."
			cd "MAME"
			rm *.zip 2> /dev/null
			rm *.lpl 2> /dev/null
		else
			echo "Creating MAME..."
			mkdir "MAME"
			cd "MAME"
		fi

		find "$DIR_MAME" \
		-name '*.zip' \
		-exec ln -s {} . \;

		for FILE in *.zip; do
			BASENAME=$(basename "$FILE" .zip)
			NAME=$(grep -A 1 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P '(?<=<description>).*(?=</description>)')
			if [ "$NAME" != "" ]; then
				echo "$NAME"
				echo "$PWD/$FILE" >> "MAME.lpl"
				echo "$NAME" >> "MAME.lpl"
				echo "DETECT" >> "MAME.lpl"
				echo "DETECT" >> "MAME.lpl"
				echo "DETECT" >> "MAME.lpl"
				echo "MAME.lpl" >> "MAME.lpl"
			fi
		done

		mv "MAME.lpl" "$RETROARCH_PLAYLIST"
	else
		echo "$DIR_MAME not found!"
	fi
;;

*)
	echo "$USAGE"
;;

esac
