#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run rxvt-unicode
run gvim
run firefox
run evolution %U
run rocketchat-desktop
run gtimelog
run google-play-music-desktop-player
