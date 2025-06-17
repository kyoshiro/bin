#!/bin/bash
timestamp_start=`date "+%Y%m%d_%H%M%S"`
hostname=$(hostnamectl hostname)

backup_source="system"
backup_source_root="/"
backup_source_file=$backup_source_root

backup_dest_root="/media/$USER/RESCUE"

DAY=$(date +%a)
ARCH_FILE=$backup_dest_root/$timestamp_start-$hostname-$backup_source.tar.bz2
SNAR_FILE=$backup_dest_root/$hostname-$backup_source.snar
SAVE_SNAR_FILE=$backup_dest_root/$(date --date '7 days ago' +%Y%m%d_%H%M)-$hostname-$backup_source.snar

if [ $DAY = 'Fri' ]; then
	test -e $SNAR_FILE && mv $SNAR_FILE $SAVE_SNAR_FILE
fi

tar -cSjp -g $SNAR_FILE --numeric-owner --atime-preserve -X exclude_dirs -f - / | split -d -b 2G - $ARCH_FILE


