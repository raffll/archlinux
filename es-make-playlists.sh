#!/bin/bash

if [ $# -lt 1 ]; then
	exit
fi

case "$1" in

thumbnails)

	DIR_IMAGES="/home/braindead/.config/retroarch/thumbnails"
	IMAGE_TYPE="Named_Boxarts"

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
			"NEC - PC Engine CD - TurboGrafx-CD"
			"Nintendo - GameCube"
			"Sega - Dreamcast"
			"Sega - Mega-CD - Sega CD"
			"Sega - Saturn"
			"Sony - PlayStation"
			"Commodore - 64"
			)

	for SYSTEM in "${ARR[@]}"; do

		if [ -e "$SYSTEM" ]; then
			cd "$SYSTEM"
			rm -r "images" 2> /dev/null
			unzip "$DIR_IMAGES/$SYSTEM.zip" -d . 1> /dev/null
			if [ -e "$SYSTEM/$IMAGE_TYPE" ]; then
				echo "Copying thumbnails to $SYSTEM..."
				mv "$SYSTEM/$IMAGE_TYPE" "images"
				cd "images"
				for FILE in *" _ "*; do
					mv "$FILE" "${FILE// _ / & }" 2> /dev/null
				done
				cd ..
				rm -r "$SYSTEM"
			fi
			cd ..
		fi
	done
;;

nointro)

	DIR_NOINTRO="/home/braindead/Backup/Emulatory/No-Intro"

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

		rm "gamelist.xml" 2> /dev/null
		echo "<?xml version=1.0?>" >> gamelist.xml
		echo "<gameList>" >> gamelist.xml
		for FILE in *.zip; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.zip}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.zip}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
		for FILE in *.nes; do
			if [ -e "$FILE" ]; then
				echo "	<game>" >> gamelist.xml
				echo "		<path>./$FILE</path>" >> gamelist.xml
				echo "		<name>${FILE%.nes}</name>" >> gamelist.xml
				echo "		<image>./images/${FILE% [*}.png</image>" >> gamelist.xml
				echo "	</game>" >> gamelist.xml
			fi
		done
		echo "</gameList>" >> gamelist.xml
		cd ..
	done
;;

redump)

	declare -a ARR=(
			"NEC - PC Engine CD - TurboGrafx-CD"
			"Sega - Mega-CD - Sega CD"
			"Sega - Saturn"
			"Sony - PlayStation"
			)

	for SYSTEM in "${ARR[@]}"; do
		echo "Refreshing $SYSTEM..."
		cd "$SYSTEM"
		rm "gamelist.xml" 2> /dev/null
		echo "<?xml version=1.0?>" >> gamelist.xml
		echo "<gameList>" >> gamelist.xml
		for FILE in *.cue; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.cue}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.cue}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
		echo "</gameList>" >> gamelist.xml
		cd ..
	done

	declare -a ARR=(
			"Nintendo - GameCube"
			)

	for SYSTEM in "${ARR[@]}"; do
		echo "Refreshing $SYSTEM..."
		cd "$SYSTEM"
		rm "gamelist.xml" 2> /dev/null
		echo "<?xml version=1.0?>" >> gamelist.xml
		echo "<gameList>" >> gamelist.xml
		for FILE in *.iso; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.iso}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.iso}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
		echo "</gameList>" >> gamelist.xml
		cd ..
	done

	declare -a ARR=(
			"Sega - Dreamcast"
			)

	for SYSTEM in "${ARR[@]}"; do
		echo "Refreshing $SYSTEM..."
		cd "$SYSTEM"
		rm "gamelist.xml" 2> /dev/null
		echo "<?xml version=1.0?>" >> gamelist.xml
		echo "<gameList>" >> gamelist.xml
		for FILE in *.gdi; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.gdi}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.gdi}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
		echo "</gameList>" >> gamelist.xml
		cd ..
	done
;;

mame)

	DIR_MAME="$HOME/Backup/Emulatory/MAME 0.193 ROMs (merged)"
	MAME_DAT="ARCADE 192.dat"

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
			
	find "$DIR_MAME" \
	-name '*.zip' \
	-exec ln -s {} . \;

	rm "gamelist.xml" 2> /dev/null
	echo "<?xml version=1.0?>" >> gamelist.xml
	echo "<gameList>" >> gamelist.xml
	for FILE in *.zip; do
		BASENAME=$(basename "$FILE" .zip)
		NAME=$(grep -A1 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P '(?<=<description>).*(?=</description>)')
		IS_M=$(grep -A1 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P 'ismechanical="yes"')
		IS_R=$(grep -A1 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P 'runnable="no"')
		YEAR=$(grep -A2 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P '(?<=<year>).*(?=</year>)')
		MANU=$(grep -A3 "name=\"$BASENAME\"" "$MAME_DAT" | grep -o -P '(?<=<manufacturer>).*(?=</manufacturer>)')
		if [ "$NAME" != "" ] && [ "$IS_M" == "" ] && [ "$IS_R" == "" ] && [ "$MANU" != "" ]; then
			echo "$NAME ($YEAR) ($MANU)"
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>$NAME ($YEAR) ($MANU)</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.zip}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		fi
	done
	echo "</gameList>" >> gamelist.xml
;;

c64)

	SYSTEM="Commodore - 64"

		if [ -e "$SYSTEM" ]; then
			echo "Refreshing $SYSTEM..."
			cd "$SYSTEM"
		else
			echo "Creating $SYSTEM..."
			mkdir "$SYSTEM"
			cd "$SYSTEM"
		fi

		rm "gamelist.xml" 2> /dev/null
		echo "<?xml version=1.0?>" >> gamelist.xml
		echo "<gameList>" >> gamelist.xml
		for FILE in *.g64; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.g64}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.g64}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
 		for FILE in *.d64; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.d64}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.d64}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
 		for FILE in *.crt; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.crt}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.crt}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
 		for FILE in *.tap; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.tap}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.tap}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
		echo "</gameList>" >> gamelist.xml

;;

a8bit)

	SYSTEM="Atari - XEGS"

		if [ -e "$SYSTEM" ]; then
			echo "Refreshing $SYSTEM..."
			cd "$SYSTEM"
		else
			echo "Creating $SYSTEM..."
			mkdir "$SYSTEM"
			cd "$SYSTEM"
		fi

		rm "gamelist.xml" 2> /dev/null
		echo "<?xml version=1.0?>" >> gamelist.xml
		echo "<gameList>" >> gamelist.xml
		for FILE in *.atx; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.atx}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.atx}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
 		for FILE in *.atr; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.atr}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.atr}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
 		for FILE in *.car; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.car}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.car}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
 		for FILE in *.cas; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.cas}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.cas}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
		echo "</gameList>" >> gamelist.xml

;;

amstrad)

	SYSTEM="Amstrad - CPC"

		if [ -e "$SYSTEM" ]; then
			echo "Refreshing $SYSTEM..."
			cd "$SYSTEM"
		else
			echo "Creating $SYSTEM..."
			mkdir "$SYSTEM"
			cd "$SYSTEM"
		fi

		rm "gamelist.xml" 2> /dev/null
		echo "<?xml version=1.0?>" >> gamelist.xml
		echo "<gameList>" >> gamelist.xml
		for FILE in *.dsk; do
			echo "	<game>" >> gamelist.xml
			echo "		<path>./$FILE</path>" >> gamelist.xml
			echo "		<name>${FILE%.dsk}</name>" >> gamelist.xml
			echo "		<image>./images/${FILE%.dsk}.png</image>" >> gamelist.xml
			echo "	</game>" >> gamelist.xml
		done
		echo "</gameList>" >> gamelist.xml

;;

esac

