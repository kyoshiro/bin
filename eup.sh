#!/bin/bash
# This script automates the update process
#
LOGFILE="/var/log/emerge-update.log"

for user in $(who | awk '{print $1}' | sort -u); do
    uid=$(id -u "$user")
    export DISPLAY=:0
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$uid/dbus-1"

    sudo -u "$user" DISPLAY=$DISPLAY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
    notify-send -a "Emerge" "System Update" "🔄 Systemupdate started..."
done

{
    args=$@
    DATE=$(date '+%Y-%m-%d %H:%M:%S')

    echo " --- $DATE ---"
    echo "ℹ️ Running portage sync and update process..."
    echo "🔄 Starting sync... skipping on yukimura"

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
    uid=$(id -u "$user")
    export DISPLAY=:0
    export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$uid/bus"

    sudo -u "$user" DISPLAY=$DISPLAY DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
    notify-send -a "Emerge" "System Update" "✅ Systemupdate finished, for more info, see log file $LOGFILE."

done

