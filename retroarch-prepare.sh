#!/bin/bash

if [ $# -lt 1 ]; then
    exit
fi

case "$1" in

nointro)

    DIR="$HOME/Pliki/Torrent/No-Intro"

    declare -a ARR=(
            "Atari - 2600"
            "Atari - 5200"
            "Atari - 7800 [Headered]"
            "Atari - Jaguar"
            "Atari - Lynx [Headered]"
            "Bandai - WonderSwan"
            "Bandai - WonderSwan Color"
            "Coleco - ColecoVision"
            "GCE - Vectrex"
            "Magnavox - Odyssey2"
            "Microsoft - MSX"
            "Microsoft - MSX2"
            "NEC - PC Engine - TurboGrafx 16"
            "NEC - PC Engine SuperGrafx"
            "Nintendo - Family Computer Disk System [headered]"
            "Nintendo - Game Boy"
            "Nintendo - Game Boy Advance"
            "Nintendo - Game Boy Color"
            "Nintendo - Nintendo 64"
            "Nintendo - Nintendo Entertainment System [headered]"
            "Nintendo - Pokemon Mini"
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

    if [ -e "Atari - 7800" ]; then
        mv "Atari - 7800" "Atari - 7800 [Headered]"
    fi

    if [ -e "Atari - Lynx" ]; then
        mv "Atari - Lynx" "Atari - Lynx [Headered]"
    fi

    if [ -e "Nintendo - Family Computer Disk System" ]; then
        mv "Nintendo - Family Computer Disk System" "Nintendo - Family Computer Disk System [headered]"
    fi

    if [ -e "Nintendo - Nintendo Entertainment System" ]; then
        mv "Nintendo - Nintendo Entertainment System" "Nintendo - Nintendo Entertainment System [headered]"
    fi

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
        ! -name '*\(Sample*' \
        ! -name '*\(Beta*' \
        ! -name '*\(Demo*' \
        ! -name '*\(Program*' \
        ! -name '*\(SDK*' \
        ! -name '*\(Developer*' \
        ! -name '* in 1 *' \
        ! -name '*-in-1 *' \
        -exec ln -s {} . \;
        
        cd ..
    done

    if [ -e "Atari - 7800 [Headered]" ]; then
        mv "Atari - 7800 [Headered]" "Atari - 7800"
    fi

    if [ -e "Atari - Lynx [Headered]" ]; then
        mv "Atari - Lynx [Headered]" "Atari - Lynx"
    fi

    if [ -e "Nintendo - Family Computer Disk System [headered]" ]; then
        mv "Nintendo - Family Computer Disk System [headered]" "Nintendo - Family Computer Disk System"
    fi

    if [ -e "Nintendo - Nintendo Entertainment System [headered]" ]; then
        mv "Nintendo - Nintendo Entertainment System [headered]" "Nintendo - Nintendo Entertainment System"
    fi
;;

nointro-c64)

    DIR="$HOME/Pliki/Torrent/No-Intro"
    NIB="$HOME/.bin/nibconv.exe"

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

        find -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
        rm *.zip 2> /dev/null
    done

    find "$PWD" -type f -iname "*.nib" -print0 | while IFS= read -r -d $'\0' FILE; do
        wine "$NIB" "$FILE" "${FILE%.nib}.g64"
        rm "$FILE"
    done
;;

nointro-st)

    DIR="$HOME/Pliki/Torrent/No-Intro/Atari - ST"

    SYSTEM="Atari - ST"

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

    find "$DIR" \
        -name '*.zip' \
        ! -name '*\[BIOS\]*' \
        ! -name '*(Sample*'  \
        ! -name '*(Beta*' \
        ! -name '*(Demo*' \
        ! -name '*(Program*' \
        ! -name '*(SDK*' \
        -exec ln -s {} . \;
    find -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
    rm *.zip 2> /dev/null
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
    #find -name '*.zip' -exec sh -c 'unzip -d "${1%.*}" "$1"' _ {} \;
    unzip '*.zip'
    rm *.zip 2> /dev/null
    chmod 644 *
    
    for FILE in *; do
				NAME=${FILE##*/}
				YEAR=$(echo $NAME | awk -F'[()]' '{print $2}')
				MANU=$(echo $NAME | awk -F'[()]' '{print $4}')
				NAME=$(sed "s|($YEAR)||g" <<< $NAME)
				NAME=$(sed "s|($MANU)||g" <<< $NAME)
				NAME=$(sed "s|\[a\]|(Alt 1)|g" <<< $NAME)
				NAME=$(sed "s|\[a2\]|(Alt 2)|g" <<< $NAME)
				NAME=$(sed "s|\[a3\]|(Alt 3)|g" <<< $NAME)
				NAME=$(sed "s|\[!\]||g" <<< $NAME)
				NAME=$(sed "s|\[req 64K\]||g" <<< $NAME)
				NAME=$(sed 's|\[o $FFs in first 4KB\]||g' <<< $NAME)
				NAME=$(sed "s|)(|) (|g" <<< $NAME)
				NAME=$(sed "s|)\[|) \[|g" <<< $NAME)
				NAME=$(sed "s|\]\[|\] \[|g" <<< $NAME)
				NAME=$(sed "s|(proto)|(Proto)|g" <<< $NAME)
				NAME=$(sed "s|(GB)|(Europe)|g" <<< $NAME)
				NAME=$(sed "s|(US)|(USA)|g" <<< $NAME)
				NAME=$(sed "s|(DE)|(Germany)|g" <<< $NAME)
				NAME=$(sed "s|(PL)|(Poland)|g" <<< $NAME)
				NAME=$(sed "s|(FR)|(France)|g" <<< $NAME)
				NAME=$(sed "s|(CA)|(Canada)|g" <<< $NAME)
				mv "$FILE" "$PWD/$NAME"
    done
;;

mame)

    DIR="$HOME/Pliki/Torrent/MAME 0.195 ROMs (merged)"

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

dos-zip)

    DIR="$HOME/Pliki/Torrent/eXoDOS/eXoDOS/Games"

    SYSTEM="DOS"

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

    ln -s $DIR/*.zip .
    rm GamesRPG.zip
    unzip '*.zip'

    find "$PWD" -name '*.conf' -delete
    find "$PWD" -name '*.ba1' -delete
    rm *.zip 2> /dev/null
;;

dos-conf)

    DIR="$HOME/Pliki/Torrent/eXoDOS/eXoDOS/Games"

    SYSTEM="TEMP"

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

    ln -s $DIR/GamesRPG.zip .
    unzip GamesRPG.zip
    rm GamesRPG.zip

    mv !dos/* .
    rm -r !dos

    for GAME in */; do
        cd "$GAME"
        rm "install.bat"
        for FILE in *.bat; do
            NAME="${FILE%.bat}"
            rm "$FILE"
        done
        sed -i 's|.\\games\\|\~\/.config\/retroarch\/roms\/DOS\/|g' "dosbox.conf"
        sed -i 's|\\|\/|g' "dosbox.conf"
        sed -i 's|\/ULTRASND|\\ULTRASND|g' "dosbox.conf"
        sed -i 's|.cue|.bin|g' "dosbox.conf"
        mv "dosbox.conf" "$NAME.conf"
        cd ..
        mv "$GAME/$NAME.conf" .
        rm -r "$GAME"
    done

    mv *.conf "../DOS"
    cd ..
    rm -r "$SYSTEM"
;;

esac
