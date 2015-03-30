
Kratemaqht on a Treadmill
==============================================================================

.. image:: dragon.png
   :align: center
   :width: 100%

:Author:    Sandor Zsuga (Jubatian; CannonFodder)
:Copyright: 2015, GNU General Public License, Version 2, see COPYING.txt




Introduction
------------------------------------------------------------------------------


This is a small utility hastily whacked together to slim down the venerable
Kratemaqht dragon used in the Library of Kratemaqht and some other user-made
campaigns of Battle for Wesnoth. It may be used to trim down the size of
other image resources, too.

In short summary it relies on that png files compress better if there are less
distinct colors in them, however this far, there was no solution to perform
such operation in bulk, preserving the alpha channel of the image. This script
provides this solution.




Dependencies
------------------------------------------------------------------------------


The following additional packages are required to run these scripts:

- PNGCrush, tested with version 1.7.9.
- ImageMagick, tested with version 6.7.7-10.
- Gimp, tested with version 2.8. (Optional)
- PNGQuant, tested with version 2.3.5. (Highly recommended!)
- The images/units/dragons directory (with contents) of the Library of
  Kratemaqht campaign (or whatever image source you need to crush).

For the PNGQuant version, no extra depencies are needed apart from PNGQuant
itself, which may be obtained from here:

http://pngquant.org

If you are interested in the scolorq version, the source of scolorq can be
obtained here:

http://www.cs.berkeley.edu/~dcoetzee/downloads/scolorq

Note that scolorq itself apparently has some problems described further below
which likely prevents its practical use.




Running the scripts
------------------------------------------------------------------------------


You need to perform the following steps to get a trimmed down set of your
images:

- Make sure you have ImageMagick, PNGCrush, and optionally Gimp installed. OR
  if you want to use the PNGQuant version, you only need to get PNGQuant.

- Run crush-gimp.sh, crush-magick.sh or crush-pngquant.sh with the directory
  containing the images and the desired color count (64 is good for
  Kratemaqht), wait (a long time) and pray.

- Note that the images are overwritten with the trimmed down variants: you may
  want to run the script on a copy of the image directory.

Reducing Kratemaqht in the Wesnoth campaign to 64 colors gives at around 13
megabytes of images at a decent quality, fine for the purposes of the game.

The exact parameter signature of the script is as follows: ::

    ./crush-gimp image_directory color_count
    ./crush-magick image_directory color_count
    ./crush-pngquant image_directory color_count

The roles of the parameters are as follows:

- image_directory: The path where the images reside. The script will process
  every .png image within this directory (but won't enter sub-directories).

- color_count: The desired count of colors for the RGB portion of the image.
  The alpha channel is not affected, and is not included in this color count.

Gimp and ImageMagick's quantizer seems to offer quite similar performance in
terms of quality and compressibility. PNGQuant produces much better results,
and it is even faster and slightly smaller for the same color counts.




Notes on PNGQuant
------------------------------------------------------------------------------


PNGQuant does the job the best at this task, likely for two reasons.

- Even I could write a quantizer in a day which notably outperforms Gimp's or
  ImageMagick's quantizer in terms of quality for a given color count. So
  certainly there is room for improvements on this field! PNGQuant seems to
  perform very well (I could only come near it in terms of quality with my
  experiment; and did not see anything performing that good until I found it.
  Not to mention PNGQuant is blazing fast at doing it's job).

- PNGQuant saves ARGB Indexed images. The other scripts can only produce
  Indexed + Alpha PNG's (An RGB Indexed image layer plus a seperate alpha
  layer) which are worse in terms of compressibility. I don't know any other
  solution which would generate an ARGB Indexed image otherwise.




The scolorq version
------------------------------------------------------------------------------


The scolorq version (crush-scolorq and scolorq-single for single images) uses
scolorq for quantizing the images. The crush-scolorq script can be used the
same way like the crush-gimp script, while scolorq-single is provided to
replace the script coming with scolorq itself, automatically querying the
sizes of the image.

There are, however, two major problems with scolorq itself:

- Quality. While if used properly with manual tuning, it can be made producing
  better results than Gimp's quantizer, it doesn't work well in the practice
  for batch processing. The primary problem is that for some reason it
  produces a lot of identical (or almost identical) colors, so to actually get
  good results, you would have to set a higher quantization target, manually
  fixing the result afterwards. The set of actually different colors are
  usually a lot better than what Gimp gives for the same target, however
  without this it just doesn't work.

- Speed. It is crawling. It would take probably a day to quantize the entire
  dragons directory of Library of Kratemaqht with it at a reasonable quality.

These scripts however might be useful as templates for building and trying out
other, experimental quantizers without the need to actually implement handling
a known image format.




Some notes on other alternatives
------------------------------------------------------------------------------


The following other alternatives might exist:

- The pngnq package. The results from this, however, were very unsatisfactory:
  on every configuration I tried (including 256 colors), it removes the
  shining gem on the forehead of the dragon and the eyes. Even Gimp's
  quantizer is a lot better in this regard.
