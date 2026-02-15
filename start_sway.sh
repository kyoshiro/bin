#!/bin/sh
export MOZ_ENABLE_WAYLAND=1

export QT_QPA_PLATFORM=wayland-egl

export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

export XDG_RUNTIME_DIR=/run/user/`id -u`
export XDG_SESSION_TYPE="wayland"
export XDG_SESSION_DESKTOP="sway:wlroots"
export XDG_CURRENT_DESKTOP="sway:wlroots"
export DESKTOP_SESSION="sway"

exec dbus-run-session /usr/bin/sway
