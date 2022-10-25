#!/bin/bash
set -x
timestamp_start=`date "+%Y%m%d_%H%M%S"`
hostname=$(hostnamectl hostname)

backup_source="system"
backup_source_root="/"
backup_source_file=$backup_source_root

backup_dest_root="/rescue/backup"

DAY=$(date +%a)
ARCH_FILE=$backup_dest_root/$timestamp_start-$hostname-$backup_source.tar.bz2
SNAR_FILE=$backup_dest_root/$hostname-$backup_source.snar
SAVE_SNAR_FILE=$backup_dest_root/$(date --date '7 days ago' +%Y%m%d_%H%M)-$hostname-$backup_source.snar

DAY=$(date +%a)
ARCH_FILE=$backup_dest_root/$(date +%Y%m%d_%H%M)-$hostname-system.tar.bz2
SNAR_FILE=$backup_dest_root/$hostname-system.snar
SAVE_SNAR_FILE=$backup_dest_root/$(date --date '7 days ago' +%Y%m%d_%H%M)-${SNAR}

if [ $DAY = 'Mon' ]; then
	test -e $SNAR_FILE && mv $SNAR_FILE $SAVE_SNAR_FILE
fi
mount /boot/efi

tar -cSjp -g $SNAR_FILE --numeric-owner --atime-preserve -X exclude_dirs -f - / | split -d -b 2G - $ARCH_FILE


