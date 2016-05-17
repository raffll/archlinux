#!/bin/sh

for FILE in *.mp4; do
    NEWFILE="`basename "$FILE" .mp4`.ogg"
    if [ ! -e "$NEWFILE" ]; then
        ffmpeg -i "$FILE" -vn -codec:a libvorbis -qscale:a 7 "$NEWFILE"
    fi
done