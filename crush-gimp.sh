#!/bin/sh

if [ "$#" -ne 2 ] || [ ! -d "$1" ]; then
    echo "Needs two parameters:"
    echo "A directory to process png images within"
    echo "A color count to quantize every image to (256 or less)"
    exit 1
fi

echo "Note: the script will take a LOT of time for the entire dragon!"

echo "(define pattern \"$1/*.png\")"\
     "(define colors $2)"\
     "(let* ((filelist (cadr (file-glob pattern 1))))"\
     "    (while (not (null? filelist))"\
     "        (let* ((filename (car filelist))"\
     "               (image (car (gimp-file-load RUN-NONINTERACTIVE filename filename)))"\
     "               (drawable (car (gimp-image-get-active-layer image))))"\
     "            (gimp-layer-add-mask drawable (car (gimp-layer-create-mask drawable ADD-ALPHA-TRANSFER-MASK)))"\
     "            (gimp-image-convert-indexed image NO-DITHER MAKE-PALETTE colors FALSE FALSE \"\")"\
     "            (gimp-image-convert-rgb image)"\
     "            (gimp-layer-remove-mask drawable MASK-APPLY)"\
     "            (gimp-file-save RUN-NONINTERACTIVE image drawable filename filename)"\
     "            (gimp-image-delete image))"\
     "        (set! filelist (cdr filelist))))"\
     "(gimp-quit 0)"\
     | gimp -i -b -
mkdir ${1}_crush
pngcrush -d ${1}_crush ${1}/*.png
rm -r ${1}
mv ${1}_crush ${1}
