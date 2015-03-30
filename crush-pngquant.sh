#!/bin/sh

if [ "$#" -ne 2 ] || [ ! -d "$1" ]; then
    echo "Needs two parameters:"
    echo "A directory to process png images within"
    echo "A color count to quantize every image to (256 or less)"
    exit 1
fi

echo "Note: the script will take a LOT of time for the entire dragon!"

for i in ${1}/*.png; do
    ./pngquant -o ${i}.tmp.png ${2} ${i}
    rm ${i}
    mv ${i}.tmp.png ${i}
    echo "${i} done"
done
