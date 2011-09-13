#!/bin/bash
# This script automates the update process
# Don't forget to run revdep-rebuild, modules-rebuild, perl-cleaner --modules and python-updater

echo "Running portage sync and update."

echo "Sync started"
emerge --sync || (echo "Failed to sync portage tree."; exit 1)

echo "Sync completed. Starting update"
emerge -DuavN --with-bdeps=y @world || echo "Updated failed due to above error"

echo "Running portage sync and update."
echo ""
sudo emerge --sync && emerge -DuavN world
