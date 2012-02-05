#!/bin/sh

echo "Fixing xf86-modules..."
echo ""
emerge -1v xf86-video-intel xf86-input-keyboard xf86-input-evdev xf86-input-synaptics xf86-input-mouse
