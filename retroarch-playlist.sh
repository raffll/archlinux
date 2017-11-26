#!/bin/bash

EMU="$HOME/Backup/Emulatory/"
CUR="$HOME/.config/retroarch/roms/"

DIR_NOINTRO="$EMU/No-Intro"
DIR_REDUMP="$CUR"
DIR_A800="$EMU/Atari 8bit Preserved Software 2017-08-01"
DIR_DOS="$CUR"
DIR_MAME="$EMU/MAME 0.191 ROMs (merged)"

MAME_DAT="$CUR/ARCADE 189.dat"
NIBCONV="$CUR/nibconv.exe"
RETROARCH_PLAYLIST="$HOME/.config/retroarch/playlists"
DIR_ICONS="$HOME/.config/retroarch/assets/xmb/neoactive/png/"

########################################################################

USAGE="Usage: $0 nointro | c64 | redump | a8bit | dos | mame | other"

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

		if [ -e "$SYSTEM" ]; then
			echo "Refreshing $SYSTEM..."
			cd "$SYSTEM"
			rm *.zip 2> /dev/null
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
			echo "$PWD/$ZIPFILE#$FILE" >> "../$SYSTEM.lpl"
			echo "$ZIPFILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "DETECT" >> "../$SYSTEM.lpl"
			echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
		done

		mv "../$SYSTEM.lpl" "$RETROARCH_PLAYLIST"
		cd ..
	done
;;

c64)

	declare -a ARR=("Commodore - 64"
			"Commodore - 64 (PP)"
			"Commodore - 64 (Tapes)")

	if [ -e "Commodore - 64" ]; then
		echo "Refreshing Commodore - 64..."
		cd "Commodore - 64"
	else
		echo "Creating Commodore - 64..."
		mkdir "Commodore - 64"
		cd "Commodore - 64"

		for SYSTEM in "${ARR[@]}"; do

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
		done

		for FILE in *.nib; do
			wine "$NIBCONV" "$FILE" "${FILE%.nib} (Disk).g64"
		done

		for FILE in *.crt; do
			mv "$FILE" "${FILE%.crt} (Cart).crt"
		done

		for FILE in *.tap; do
			mv "$FILE" "${FILE%.tap} (Tape).tap"
		done

		rm *.nib
	fi

	for FILE in *; do
		echo "$PWD/$FILE" >> "../Commodore - 64.lpl"
		echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "../Commodore - 64.lpl"
		echo "DETECT" >> "../Commodore - 64.lpl"
		echo "DETECT" >> "../Commodore - 64.lpl"
		echo "DETECT" >> "../Commodore - 64.lpl"
		echo "Commodore - 64.lpl" >> "../Commodore - 64.lpl"
	done

	mv "../Commodore - 64.lpl" "$RETROARCH_PLAYLIST"
;;

redump)

	declare -a ARR=("Sony - PlayStation"
			"Nintendo - GameCube"
			"Sega - Dreamcast"
			"Sega - Mega-CD - Sega CD"
			"Sega - Saturn"
			"NEC - PC Engine CD - TurboGrafx-CD")

	for SYSTEM in "${ARR[@]}"; do

		echo "Refreshing $SYSTEM..."
		cd "$SYSTEM"
		rm *.lpl 2> /dev/null

		if [ "$SYSTEM" == "Sony - PlayStation" ]; then
			find "$DIR_REDUMP/$SYSTEM" -type f -iname "*.cue" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "$SYSTEM.lpl"
				echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
			done
		fi

		if [ "$SYSTEM" == "Nintendo - GameCube" ]; then
			find "$DIR_REDUMP/$SYSTEM" -type f -iname "*.iso" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "$SYSTEM.lpl"
				echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
			done
		fi

		if [ "$SYSTEM" == "Sega - Dreamcast" ]; then
			find "$DIR_REDUMP/$SYSTEM" -type f -iname "*.gdi" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "$SYSTEM.lpl"
				echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
			done
		fi

		if [ "$SYSTEM" == "Sega - Mega-CD - Sega CD" ]; then
			find "$DIR_REDUMP/$SYSTEM" -type f -iname "*.cue" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "$SYSTEM.lpl"
				echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
			done
		fi

		if [ "$SYSTEM" == "Sega - Saturn" ]; then
			find "$DIR_REDUMP/$SYSTEM" -type f -iname "*.cue" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "$SYSTEM.lpl"
				echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "DETECT" >> "$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
			done
		fi

		if [ "$SYSTEM" == "NEC - PC Engine CD - TurboGrafx-CD" ]; then
			find "$DIR_REDUMP/$SYSTEM" -type f -iname "*.cue" -print0 | while IFS= read -r -d $'\0' FILE; do
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
	done
;;

a8bit)

	declare -a ARR=("Atari - 8bit")

	ln -s "$DIR_ICONS/Commodore - 64.png" "$DIR_ICONS/${ARR[0]}.png" 2> /dev/null
	ln -s "$DIR_ICONS/Commodore - 64-content.png" "$DIR_ICONS/${ARR[0]}-content.png" 2> /dev/null

	for SYSTEM in "${ARR[@]}"; do

		if [ -e "$SYSTEM" ]; then
			echo "Refreshing $SYSTEM..."
			cd "$SYSTEM"
			rm *.lpl 2> /dev/null
		else
			echo "Creating $SYSTEM..."
			mkdir "$SYSTEM"
			cd "$SYSTEM"

			find "$DIR_A800" \
			-name '*.zip' \
			-exec ln -s {} . \;

			unzip '*.zip'
			rm *.zip 2> /dev/null
			chmod 644 *

			for FILE in *.atr; do
				mv "$FILE" "${FILE%.atr}[Disk].atr"
			done

			for FILE in *.atx; do
				mv "$FILE" "${FILE%.atx}[Disk].atx"
			done

			for FILE in *.cas; do
				mv "$FILE" "${FILE%.cas}[Tape].cas"
			done

			for FILE in *.car; do
				mv "$FILE" "${FILE%.car}[Cart].car"
			done
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
	done
;;

dos)

	declare -a ARR=("DOS")

	for SYSTEM in "${ARR[@]}"; do

		echo "Refreshing $SYSTEM..."
		cd "$DIR_DOS/$SYSTEM"
		rm *.lpl 2> /dev/null

		for FILE in *.conf; do
			echo "$PWD/$FILE" >> "$SYSTEM.lpl"
			echo "$FILE" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$SYSTEM.lpl"
			echo "DETECT" >> "$SYSTEM.lpl"
			echo "DETECT" >> "$SYSTEM.lpl"
			echo "DETECT" >> "$SYSTEM.lpl"
			echo "$SYSTEM.lpl" >> "$SYSTEM.lpl"
		done

		mv "$SYSTEM.lpl" "$RETROARCH_PLAYLIST"
	done
;;

mame)

	declare -a ARR=("MAME")

	for SYSTEM in "${ARR[@]}"; do

		if [ -e "$SYSTEM" ]; then
			echo "Refreshing $SYSTEM..."
			cd "$SYSTEM"
			rm *.lpl 2> /dev/null
		else
			echo "Creating $SYSTEM..."
			mkdir "$SYSTEM"
			cd "$SYSTEM"

			find "$DIR_MAME" \
			-name '*.zip' \
			-exec ln -s {} . \;
		fi
	done

	for FILE in *.zip; do
		BASENAME=$(basename "$FILE" .zip)
		NAME=$(grep -A1 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P '(?<=<description>).*(?=</description>)')
		YEAR=$(grep -A2 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P '(?<=<year>).*(?=</year>)')
		MANU=$(grep -A3 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P '(?<=<manufacturer>).*(?=</manufacturer>)')
		if [ "$NAME" != "" ]; then
			echo "$NAME ($YEAR) ($MANU)"
			echo "$PWD/$FILE" >> "MAME.lpl"
			echo "$NAME ($YEAR) ($MANU)" >> "MAME.lpl"
			echo "DETECT" >> "MAME.lpl"
			echo "DETECT" >> "MAME.lpl"
			echo "DETECT" >> "MAME.lpl"
			echo "MAME.lpl" >> "MAME.lpl"
		fi
	done

	mv "MAME.lpl" "$RETROARCH_PLAYLIST"
;;

other)

	declare -a ARR=("Amstrad - CPC")

	for SYSTEM in "${ARR[@]}"; do

		echo "Refreshing $SYSTEM..."
		cd "$SYSTEM"
		rm *.lpl 2> /dev/null

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
;;

*)
	echo "$USAGE"
;;

esac
