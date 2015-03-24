#!/bin/sh

if [ ! -d dragons ]; then
    echo "Copy the dragons directory here!"
    exit 1
fi
echo "Note: the script will take a LOT of time for the entire dragon!"
gimp -i -b '(batch-alpha-quantize "dragons/*.png" 64)' -b '(gimp-quit 0)'
mkdir dragons_crush
pngcrush -d dragons_crush dragons/*.png
rm -r dragons
mv dragons_crush dragons
