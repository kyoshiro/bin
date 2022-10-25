#!/bin/sh
# set -x
timestamp_start=`date "+%Y%m%d_%H%M%S"`
hostname=$(hostnamectl hostname)

backup_source="nextcloud"
backup_source_root="/srv/docker/data"
backup_source_file=$backup_source_root"/"$backup_source"/"

backup_excludes="exclude_dirs_nextcloud"

backup_dest_root="/rescue/backup"
PASSWORD=$(cat .nextcloud.secret)
DAY=$(date +%a)
ARCH_FILE=$backup_dest_root/$timestamp_start-$hostname-$backup_source.tar
DB_ARCH_FILE=$backup_dest_root/$timestamp_start-$hostname-$backup_source-sql.bak
SNAR_FILE=$backup_dest_root/$hostname-$backup_source.snar
SAVE_SNAR_FILE=$backup_dest_root/$(date --date '7 days ago' +%Y%m%d_%H%M)-$hostname-$backup_source.snar

# Doing backup
# Set password in secrets file before use
docker exec nextcloud-db /usr/bin/mysqldump --single-transaction -u nextcloud --password=$PASSWORD nextcloud > $DB_ARCH_FILE

if [ $DAY = 'Mon' ]; then
	test -e $SNAR_FILE && mv $SNAR_FILE $SAVE_SNAR_FILE
fi
tar -cSivp -g $SNAR_FILE --numeric-owner -X $backup_excludes -f - $backup_source_file | split -d -b 4G - $ARCH_FILE 
