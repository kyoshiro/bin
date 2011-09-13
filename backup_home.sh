#!/bin/bash

sudo tar -cjSvp --numeric-owner --atime-preserve -f /media/backup/`date +%Y%m%d_%H%M`-`hostname`-home.tar.bz2 /home
