#!/usr/bin/env bash

function run {
  if ! pgrep -f $1$ ;
  then
    $@&
  fi
}

run ibus-daemon
run autolock
run nm-applet
run blueman-applet
run rxvt-unicode
run firefox
run thunderbird

if [ $USER == "rasendorf" ]; then
	run gtimelog
fi
if [ $USER != "rasendorf" ]; then
	run google-play-music-desktop-player
fi
