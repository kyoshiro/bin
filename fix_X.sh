#!/bin/sh
# Script fixing x11-drivers after xserver xorg update
# from gentoo wiki http://de.gentoo-wiki.com/wiki/X.Org/Upgrade

echo "Query and fix installed xf86-modules..."
echo ""
qlist -I -C x11-drivers/ | xargs emerge -1v
