#!/bin/sh
export MOZ_ENABLE_WAYLAND=1

export QT_QPA_PLATFORM=wayland-egl

export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export XDG_RUNTIME_DIR=/var/run/user/`id -u`
export XDG_SESSION_TYPE="wayland"
export XDG_SESSION_DESKTOP="sway:wlroots"
export XDG_CURRENT_DESKTOP="sway:wlroots"
export DESKTOP_SESSION="sway"

platform='unknown'
unamestr=$(uname)
if [[ "$unamestr" == 'Linux' ]]; then
  platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
  platform='freebsd'
fi

if [[ "$platform" == "freebsd" ]]; then
  # Check if we are on FreeBSD
  exec dbus-launch --exit-with-session /usr/local/bin/sway
else
  # Else, we assume we are on Linux
  exec dbus-launch --exit-with-session /usr/bin/sway
fi
