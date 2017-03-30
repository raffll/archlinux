#!/bin/bash

COUNTER=1
name=${PWD##*/}
path=${PWD}

for i in *.zip; do
        file="$(zipinfo -1 "$i")"
        echo "${path}/$i#${file}" >> "$name.lpl"
        echo "$i" | sed 's/\.[^.]*$//' | sed 's/.*\///' >> "$name.lpl"
        echo "DETECT" >> "$name.lpl"
        echo "DETECT" >> "$name.lpl"
        echo "$COUNTER|crc" >> "$name.lpl"
        COUNTER=$[$COUNTER +1]
        echo "$name.lpl" >> "$name.lpl"
done
