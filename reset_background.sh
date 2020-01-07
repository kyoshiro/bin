#!/bin/bash
source /usr/local/bin/discover_session_bus_address.sh
export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules/
export DISPLAY=:0.0
dbus-send --type=method_call --dest=org.gnome.Shell /org/gnome/Shell org.gnome.Shell.Eval "string:global.reexec_self()"
