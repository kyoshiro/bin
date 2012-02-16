#!/bin/bash
sudo mount /boot
sudo tar -cvSjp --numeric-owner --atime-preserve -X exclude_dirs -f /media/backup/`date +%Y%m%d_%H%M`-`hostname`-system.tar.bz2 /
