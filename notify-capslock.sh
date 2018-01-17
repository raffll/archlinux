#!/bin/bash

MESSAGE=$(xset q | grep Caps | awk '{ print $2, $3, $4 }')

notify-send "$MESSAGE"
