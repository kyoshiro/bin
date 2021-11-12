#!/bin/bash

sudo tar -cjSvp --numeric-owner --atime-preserve -X exclude_home_dirs -f /media/backup/`date +%Y%m%d_%H%M`-`hostname`-home.tar.bz2 /home
