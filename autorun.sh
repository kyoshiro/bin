#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run nm-applet
run autolock
run rxvt-unicode
run gvim
run firefox
run evolution
if [ $USER == "rasendorf" ]; then
	run rocketchat-desktop
	run gtimelog
fi
if [ $USER != "rasendorf" ]; then
	run google-play-music-desktop-player
fi
