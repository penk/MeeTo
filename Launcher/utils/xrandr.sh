#!/bin/bash
# set Virtualbox resolution to 1024x768
# modeline by `cvt 1024 768`

xrandr --newmode "1024x600_60.00"   49.00  1024 1072 1168 1312  600 603 613 624 -hsync +vsync
xrandr --addmode VBOX0 "1024x600_60.00"
xrandr -s 1024x600_60.00
