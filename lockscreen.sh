#!/bin/bash

LOCKSCREENIMG='/tmp/lockscreen.png'

pgrep i3lock || ffmpeg  -loglevel panic -f x11grab -video_size $(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/') -y -i :0.0+$1,20 -i ~/Pictures/tmnt_small.png -filter_complex "boxblur=9,overlay=(main_w-overlay_w)/3:(main_h-overlay_h)/2" -vframes 1 $LOCKSCREENIMG

i3lock -i $LOCKSCREENIMG
