#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 path/to/icon.svg"
    exit 1
fi
FNAME=$1
if [ ! -f "$FNAME" ]; then
    echo "Error: file $FNAME doesn't exist"
    exit 1
fi

DESTDIR="$(dirname "$FNAME")"
convert -density 1200 -background none -resize  32x32  "$FNAME" "$DESTDIR/favicon.ico"
convert -density 1200 -background none -resize  32x32  "$FNAME" "$DESTDIR/favicon.png"
convert -density 1200 -background none -resize 180x180 "$FNAME" "$DESTDIR/apple-touch-icon.png"
convert -density 1200 -background none -resize 192x192 "$FNAME" "$DESTDIR/android-chrome-192x192.png"
convert -density 1200 -background none -resize 512x512 "$FNAME" "$DESTDIR/android-chrome-512x512.png"
