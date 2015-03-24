
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


The following additional packages are required to run this script:

- Gimp, tested with version 2.8.
- PNGCrush, tested with version 1.7.9.
- The images/units/dragons directory (with contents) of the Library of
  Kratemaqht campaign (or whatever image source you need to crush).




Running it
------------------------------------------------------------------------------


You need to perform the following steps to get a trimmed down set of your
images:

- Make sure you have Gimp and PNGCrush installed.

- Copy batch-alpha-quantize.scm in Gimp's scripts directory, usually found at
  ~/.gimp-<version>/scripts, where <version> is your particular version of
  Gimp (for example, "2.8").

- Copy the images/units/dragons directory as dragons next to crush.sh.

- Run crush.sh, wait (a long time) and pray.

- After it finishes, the dragons directory should contain the trimmed down set
  of images, ready to be moved back into the campaign.

Currently the script reduces the image to 64 colors, which feels all right,
and is barely over 20 megs for the entire dragons directory (less than half
the original size). You can adjust the count of colors by editing crush.sh,
changing the desired number of colors on the line calling Gimp.
