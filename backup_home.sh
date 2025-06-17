#!/bin/bash
#set -x
timestamp_start=`date "+%Y%m%d_%H%M%S"`
hostname=$(hostnamectl hostname)

backup_source="home"
backup_source_root="/"
backup_source_file=$backup_source_root"/"$backup_source"/"

backup_dest_root="/media/$USER/RESCUE"

DAY=$(date +%a)
ARCH_FILE=$backup_dest_root/$timestamp_start-$hostname-$backup_source.tar.bz2
SNAR_FILE=$backup_dest_root/$hostname-$backup_source.snar
SAVE_SNAR_FILE=$backup_dest_root/$(date --date '7 days ago' +%Y%m%d_%H%M)-$hostname-$backup_source.snar

if [ $DAY = 'Mon' ]; then
	test -e $SNAR_FILE && mv $SNAR_FILE $SAVE_SNAR_FILE
fi
tar -cvSjp -g $SNAR_FILE --numeric-owner --atime-preserve -f - $backup_source_file | split -d -b 2G - $ARCH_FILE

