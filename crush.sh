#!/bin/sh

if [ ! -d dragons ]; then
    echo "Copy the dragons directory here!"
    exit 1
fi
echo "Note: the script will take a LOT of time for the entire dragon!"
echo "(define pattern \"dragons/*.png\")"\
     "(define colors 64)"\
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
mkdir dragons_crush
pngcrush -d dragons_crush dragons/*.png
rm -r dragons
mv dragons_crush dragons
