#!/bin/bash

if [ "$#" -ne 2 ] || [ ! -d "$1" ]; then
    echo "Needs two parameters:"
    echo "A directory to process png images within"
    echo "A color count to quantize every image to (256 or less)"
    exit 1
fi

echo "Note: the script will take an ETERNITY for the entire dragon!"

for i in ${1}/*.png; do
    convert ${i} -alpha opaque -print "%w %h;" ${i}.rgb >${i}.tmp
    read -d ";" -s wd hg <${i}.tmp
    rm ${i}.tmp
    ./spatial_color_quant ${i}.rgb ${wd} ${hg} ${2} ${i}.rgb.tmp
    rm ${i}.rgb
    mv ${i}.rgb.tmp ${i}.rgb
    convert -colors ${2} -depth 8 -size ${wd}x${hg} rgb:${i}.rgb ${i}.t.png
    rm ${i}.rgb
    convert ${i}.t.png ${i} -compose copy-opacity -composite ${i}.t.png
    pngcrush ${i}.t.png ${i}
    rm ${i}.t.png
done
