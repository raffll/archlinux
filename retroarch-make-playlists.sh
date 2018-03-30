#!/bin/bash

if [ $# -lt 1 ]; then
	exit
fi

cd "$HOME/.config/retroarch/roms"

case "$1" in

nointro)

	declare -a SYSTEM=(
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
			"Nintendo - Nintendo DS"
			"Nintendo - Nintendo Entertainment System"
			"Nintendo - Pokemon Mini"
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

	declare -a CORE=(
			"$HOME/.config/retroarch/cores/stella_libretro.so"
			"$HOME/.config/retroarch/cores/atari800_libretro.so"
			"$HOME/.config/retroarch/cores/prosystem_libretro.so"
			"$HOME/.config/retroarch/cores/virtualjaguar_libretro.so"
			"$HOME/.config/retroarch/cores/handy_libretro.so"
			"$HOME/.config/retroarch/cores/mednafen_wswan_libretro.so"
			"$HOME/.config/retroarch/cores/mednafen_wswan_libretro.so"
			"$HOME/.config/retroarch/cores/bluemsx_libretro.so"
			"$HOME/.config/retroarch/cores/vecx_libretro.so"
			"$HOME/.config/retroarch/cores/o2em_libretro.so"
			"$HOME/.config/retroarch/cores/bluemsx_libretro.so"
			"$HOME/.config/retroarch/cores/bluemsx_libretro.so"
			"$HOME/.config/retroarch/cores/mednafen_supergrafx_libretro.so"
			"$HOME/.config/retroarch/cores/mednafen_supergrafx_libretro.so"
			"$HOME/.config/retroarch/cores/fceumm_libretro.so"
			"$HOME/.config/retroarch/cores/gambatte_libretro.so"
			"$HOME/.config/retroarch/cores/mgba_libretro.so"
			"$HOME/.config/retroarch/cores/gambatte_libretro.so"
			"$HOME/.config/retroarch/cores/parallel_n64_libretro.so"
			"$HOME/.config/retroarch/cores/desmume_libretro.so"
			"$HOME/.config/retroarch/cores/fceumm_libretro.so"
			"$HOME/.config/retroarch/cores/pokemini_libretro.so"
			"$HOME/.config/retroarch/cores/snes9x_libretro.so"
			"$HOME/.config/retroarch/cores/mednafen_vb_libretro.so"
			"$HOME/.config/retroarch/cores/o2em_libretro.so"
			"$HOME/.config/retroarch/cores/picodrive_libretro.so"
			"$HOME/.config/retroarch/cores/genesis_plus_gx_libretro.so"
			"$HOME/.config/retroarch/cores/genesis_plus_gx_libretro.so"
			"$HOME/.config/retroarch/cores/picodrive_libretro.so"
			"$HOME/.config/retroarch/cores/genesis_plus_gx_libretro.so"
			"$HOME/.config/retroarch/cores/mednafen_ngp_libretro.so"
			"$HOME/.config/retroarch/cores/mednafen_ngp_libretro.so"
			)

	for i in "${!SYSTEM[@]}"; do
		if [ -e "${SYSTEM[i]}" ]; then
			echo "Creating playlist for ${SYSTEM[i]}..."
			cd "${SYSTEM[i]}"
			EXT=$(find -name '*.zip' | head -n 1)
			EXT=$(zipinfo -1 "$EXT")
			EXT="${EXT##*.}"
			for FILE in *.zip; do
				echo "$PWD/$FILE#${FILE%.zip}.$EXT" >> "../${SYSTEM[i]}.lpl"
				echo "${FILE%.zip}" >> "../${SYSTEM[i]}.lpl"
				echo "${CORE[i]}" >> "../${SYSTEM[i]}.lpl"
				echo "DETECT" >> "../${SYSTEM[i]}.lpl"
				echo "DETECT" >> "../${SYSTEM[i]}.lpl"
				echo "${SYSTEM[i]}.lpl" >> "../${SYSTEM[i]}.lpl"
			done
			mv "../${SYSTEM[i]}.lpl" "$HOME/.config/retroarch/playlists"
			cd ..
		fi
	done
;;

redump)

	declare -a SYSTEM=(
            "NEC - PC Engine CD - TurboGrafx-CD"
			"Sony - PlayStation"
			"Sega - Mega-CD - Sega CD"
			"Sega - Saturn"
			"The 3DO Company - 3DO"
			"Sega - Dreamcast"
			"Nintendo - GameCube"
			)

    declare -a CORE=(
            "$HOME/.config/retroarch/cores/mednafen_supergrafx_libretro.so"
            "$HOME/.config/retroarch/cores/pcsx_rearmed_libretro.so"
            "$HOME/.config/retroarch/cores/picodrive_libretro.so"
            "$HOME/.config/retroarch/cores/mednafen_saturn_libretro.so"
            "$HOME/.config/retroarch/cores/4do_libretro.so"
            "$HOME/.config/retroarch/cores/reicast_libretro.so"
            "$HOME/.config/retroarch/cores/dolphin_libretro.so"
            )

    declare -a EXT=(
            "cue"
            "cue"
            "cue"
            "cue"
            "cue"
            "gdi"
            "iso"
            )

	for i in "${!SYSTEM[@]}"; do
		if [ -e "${SYSTEM[i]}" ]; then
			echo "Creating playlist for ${SYSTEM[i]}..."
			cd "${SYSTEM[i]}"
			find "$PWD" -type f -iname "*.${EXT[i]}" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../${SYSTEM[i]}.lpl"
				FILE=${FILE##*/}
				echo "${FILE%.${EXT[i]}}" >> "../${SYSTEM[i]}.lpl"
				echo "${CORE[i]}" >> "../${SYSTEM[i]}.lpl"
				echo "DETECT" >> "../${SYSTEM[i]}.lpl"
				echo "DETECT" >> "../${SYSTEM[i]}.lpl"
				echo "${SYSTEM[i]}.lpl" >> "../${SYSTEM[i]}.lpl"
			done
			mv "../${SYSTEM[i]}.lpl" "$HOME/.config/retroarch/playlists"
			cd ..
		fi
	done
;;

c64)

	SYSTEM="Commodore - 64"

    declare -a ARR=(
            "g64"
            "d64"
            "crt"
            "tap"
            )
	
	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for EXT in "${ARR[@]}"; do
			find "$PWD" -type f -iname "*.$EXT" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				#MANU=$(echo $FILE | awk -F'[()]' '{print $4}')
				#FILE=$(sed "s|($MANU)||g" <<< $FILE)
				#FILE=$(sed "s|)(|) (|g" <<< $FILE)
				#FILE=$(sed "s|)\[|) \[|g" <<< $FILE)
				#FILE=$(sed "s|\]\[|\] \[|g" <<< $FILE)
				echo "${FILE%.$EXT}" >> "../$SYSTEM.lpl"
				echo "$HOME/.config/retroarch/cores/vice_x64_libretro.so" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

st)

	SYSTEM="Atari - ST"

    declare -a ARR=(
            "ipf"
            )

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for EXT in "${ARR[@]}"; do
			find "$PWD" -type f -iname "*.$EXT" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				#MANU=$(echo $FILE | awk -F'[()]' '{print $4}')
				#FILE=$(sed "s|($MANU)||g" <<< $FILE)
				#FILE=$(sed "s|)(|) (|g" <<< $FILE)
				#FILE=$(sed "s|)\[|) \[|g" <<< $FILE)
				#FILE=$(sed "s|\]\[|\] \[|g" <<< $FILE)
				echo "${FILE%.$EXT}" >> "../$SYSTEM.lpl"
				echo "$HOME/.config/retroarch/cores/hatari_libretro.so" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

a8)

	SYSTEM="Atari - XEGS"

	declare -a ARR=(
			"car"
			"atx"
			"atr"
			"cas"
			)

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for EXT in "${ARR[@]}"; do
			find "$PWD" -type f -iname "*.$EXT" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				YEAR=$(echo $FILE | awk -F'[()]' '{print $2}')
				MANU=$(echo $FILE | awk -F'[()]' '{print $4}')
				FILE=$(sed "s|($YEAR)||g" <<< $FILE)
				FILE=$(sed "s|($MANU)||g" <<< $FILE)
				FILE=$(sed "s|\[!\]||g" <<< $FILE)
				FILE=$(sed "s|)(|) (|g" <<< $FILE)
				FILE=$(sed "s|)\[|) \[|g" <<< $FILE)
				FILE=$(sed "s|\]\[|\] \[|g" <<< $FILE)
				FILE=$(sed "s|(proto)|(Proto)|g" <<< $FILE)
				FILE=$(sed "s|(GB)|(Europe)|g" <<< $FILE)
				FILE=$(sed "s|(US)|(USA)|g" <<< $FILE)
				FILE=$(sed "s|(DE)|(Germany)|g" <<< $FILE)
				FILE=$(sed "s|(PL)|(Poland)|g" <<< $FILE)
				FILE=$(sed "s|(FR)|(France)|g" <<< $FILE)
				FILE=$(sed "s|(CA)|(Canada)|g" <<< $FILE)
				echo "${FILE%.$EXT}" >> "../$SYSTEM.lpl"
				echo "$HOME/.config/retroarch/cores/atari800_libretro.so" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

cpc)

	SYSTEM="Amstrad - CPC"

    declare -a ARR=(
			"dsk"
			"cpr"
			"cdt"
			)

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for EXT in "${ARR[@]}"; do
			find "$PWD" -type f -iname "*.$EXT" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				#FILE=$(sed "s|(E)|(Europe)|g" <<< $FILE)
				echo "${FILE%.$EXT}" >> "../$SYSTEM.lpl"
				echo "$HOME/.config/retroarch/cores/cap32_libretro.so" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

zx)

	SYSTEM="Sinclair - ZX Spectrum"

    declare -a ARR=(
			"tzx"
			)

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for EXT in "${ARR[@]}"; do
			find "$PWD" -type f -iname "*.$EXT" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				#MANU=$(echo $FILE | awk -F'[()]' '{print $4}')
				#FILE=$(sed "s|($MANU)||g" <<< $FILE)
				#FILE=$(sed "s|)(|) (|g" <<< $FILE)
				#FILE=$(sed "s|)\[|) \[|g" <<< $FILE)
				#FILE=$(sed "s|\]\[|\] \[|g" <<< $FILE)
				echo "${FILE%.$EXT}" >> "../$SYSTEM.lpl"
				echo "$HOME/.config/retroarch/cores/fuse_libretro.so" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

sharp)

	SYSTEM="Sharp - X68000"

    declare -a ARR=(
			"dim"
			)

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for EXT in "${ARR[@]}"; do
			find "$PWD" -type f -iname "*.$EXT" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				#MANU=$(echo $FILE | awk -F'[()]' '{print $4}')
				#FILE=$(sed "s|($MANU)||g" <<< $FILE)
				#FILE=$(sed "s|)(|) (|g" <<< $FILE)
				#FILE=$(sed "s|)\[|) \[|g" <<< $FILE)
				#FILE=$(sed "s|\]\[|\] \[|g" <<< $FILE)
				echo "${FILE%.$EXT}" >> "../$SYSTEM.lpl"
				echo "$HOME/.config/retroarch/cores/px68k_libretro.so" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

dos)

	SYSTEM="DOS"

    declare -a ARR=(
			"conf"
			)

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for EXT in "${ARR[@]}"; do
			find "$PWD" -type f -iname "*.$EXT" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				#MANU=$(echo $FILE | awk -F'[()]' '{print $4}')
				#FILE=$(sed "s|($MANU)||g" <<< $FILE)
				#FILE=$(sed "s|)(|) (|g" <<< $FILE)
				#FILE=$(sed "s|)\[|) \[|g" <<< $FILE)
				#FILE=$(sed "s|\]\[|\] \[|g" <<< $FILE)
				echo "${FILE%.$EXT}" >> "../$SYSTEM.lpl"
				echo "$HOME/.config/retroarch/cores/dosbox_libretro.so" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
		done
		mv "../$SYSTEM.lpl" "$HOME/.config/retroarch/playlists"
		cd ..
	fi
;;

wii)

	SYSTEM="Nintendo - Wii"

    declare -a ARR=(
			"wad"
			)

	if [ -e "$SYSTEM" ]; then
		echo "Creating playlist for $SYSTEM..."
		cd "$SYSTEM"
		for EXT in "${ARR[@]}"; do
			find "$PWD" -type f -iname "*.$EXT" -print0 | while IFS= read -r -d $'\0' FILE; do
				echo "$FILE" >> "../$SYSTEM.lpl"
				FILE=${FILE##*/}
				#MANU=$(echo $FILE | awk -F'[()]' '{print $4}')
				#FILE=$(sed "s|($MANU)||g" <<< $FILE)
				#FILE=$(sed "s|)(|) (|g" <<< $FILE)
				#FILE=$(sed "s|)\[|) \[|g" <<< $FILE)
				#FILE=$(sed "s|\]\[|\] \[|g" <<< $FILE)
				echo "${FILE%.$EXT}" >> "../$SYSTEM.lpl"
				echo "$HOME/.config/retroarch/cores/dolphin_libretro.so" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "DETECT" >> "../$SYSTEM.lpl"
				echo "$SYSTEM.lpl" >> "../$SYSTEM.lpl"
			done
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
				echo "$HOME/.config/retroarch/cores/mame_libretro.so" >> "../$SYSTEM.lpl"
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
