#!/bin/sh

for FILE in *.webm; do
    NEWFILE="`basename "$FILE" .webm`.ogg"
    if [ ! -e "$NEWFILE" ]; then
        ffmpeg -i "$FILE" -vn -codec:a libvorbis -qscale:a 7 "$NEWFILE"
    fi
done