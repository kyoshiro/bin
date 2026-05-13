#!/bin/bash
# This script automates the update process
#
LOGFILE="/var/log/emerge-update.log"

for user in $(who | awk '{print $1}' | sort -u); do
    uid=$(id -u "$user")
    export DISPLAY=:0
    export XDG_RUNTIME_DIR="/var/run/user/$uid"
    # Find a process of the user that has the DBUS env
    pid=$(pgrep -u "$user" -n dbus-daemon)
    # Extract DBUS_SESSION_BUS_ADDRESS
    DBUS_SESSION_BUS_ADDRESS="$(tr '\0' '\n' < /proc/$pid/environ | \
        grep '^DBUS_SESSION_BUS_ADDRESS=' | cut -d= -f2-)"

    export DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS"
    sudo -u "$user" XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR DISPLAY=$DISPLAY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
    notify-send -a "Emerge" "System Update" "🔄 Systemupdate started..."
done

{
    args=$@
    DATE=$(date '+%Y-%m-%d %H:%M:%S')
    echo " --- $DATE ---"
    echo "ℹ️ Running portage sync and update process..."
    echo "🔄 Starting sync... skipping on yukimura"
    echo "🐛 notifying user $user, $uid"
    echo "🐛 found PID=$pid"
    echo "🐛 using env DISPLAY=$DISPLAY"
    echo "🐛 using env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
    echo "🐛 using env DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS"
    if ! [ `hostname` == "yukimura.iot.intern" ]; then
    	eix-sync || (echo "⚠️ Sync failed. Canceling further actions."; exit 1)
    	echo "✅ Sync completed..."
    fi
    echo "🔄 Checking known vulnerabilities..."
    glsa-check --list
    echo "🔄 Starting update..."
    emerge -DuvN $args --with-bdeps=y @world || echo "❌ Updated failed due to above error."
    echo "📦 Running emerge @preserved-rebuild..."
    emerge @preserved-rebuild
    echo "🧹 Cleaning unnecessary distfiles..."
    eclean-dist --deep --fetch-restricted
    echo "✅ Updates and cleanups completed."
    echo ""
    echo "💡 It's safe to run 'emerge --depclean -a' now."
    echo ""
    echo "🍻 Happy 🐧 Gentoo'ing..."
    DATE=$(date '+%Y-%m-%d %H:%M:%S')
    echo " --- $DATE ---"
} >> "$LOGFILE" 2>&1

for user in $(who | awk '{print $1}' | sort -u); do
    sudo -u "$user" XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR DISPLAY=$DISPLAY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
    notify-send -a "Emerge" "System Update" "✅ Systemupdate finished, for more info, see log file $LOGFILE."
done
