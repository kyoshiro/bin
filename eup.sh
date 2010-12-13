#!/bin/bash
# This script automates the update process
# Don't forget to run revdep-rebuild, modules-rebuild, perl-cleaner --modules and python-updater
#
echo "Running portage sync and update."
echo ""
sudo emerge --sync && emerge -DuavN world
