#!/bin/bash
# This script automates the update process
# Don't forget to run revdep-rebuild, modules-rebuild, perl-cleaner
# modules and python-updater
args=$@

echo "Running portage sync and update."
echo "Starting sync... skipping on yukimura"

if ! [ `hostname` == "yukimura.iot.intern" ]; then
	eix-sync || (echo "Sync failed. Canceling further actions."; exit 1)
	echo "Sync completed..."
fi
echo "Starting update..."
emerge -DuvN $args --with-bdeps=y @world || echo "Updated failed due to above error."
echo "Cleaning unnecessary distfiles..."
eclean-dist --deep --fetch-restricted
echo "It's safe to run 'emerge --deplean -a' now."
echo ""
echo "Happy Gentoo'ing..."
