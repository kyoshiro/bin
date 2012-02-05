#!/bin/bash
# This script automates the update process
# Don't forget to run revdep-rebuild, modules-rebuild, perl-cleaner
# modules and python-updater
args=$@

echo "Running portage sync and update."
echo ""
echo "Starting sync..."
eix-sync || echo "Sync failed. Canceling further actions."; exit 1

echo "Sync completed. Starting update..."
emerge -DuvN $args --with-bdeps=y @world || echo "Updated failed due to above error."
