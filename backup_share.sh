#!/bin/sh
# set -x
timestamp_start=`date "+%Y%m%d_%H%M%S"`

backup_source="share"
backup_source_root="/raid"
backup_source_file=$backup_source_root"/"$backup_source"/"
backup_dest_root="/rescue"
backup_dest_file=$backup_dest_root"/"$backup_source"-"$timestamp_start
backup_dest_dbfile=$backup_dest_root"/"$backup_source"-sql-"$timestamp_start".bak"
backup_dest_link=$backup_dest_root"/"$backup_source"-current"
backup_logfile=$backup_dest_file".log"

#Check mount point /rescue , mount if needed
if [ ! -z "$(cat /proc/mounts | grep -qs $backup_dest_root)" ]; then
	if [ ! $(mount $backup_dest_root) ] ; then
		# If mount $backup_dest_root failes exit here
		echo "Backup  failed! $backup_dest_root not mounted" | mail -s "Backup $backup_source on $timestamp_start failed" root
		exit 1
	fi
fi
if [ ! -e $backup_source_file ]; then
	# if $backup_source_file does not exist exit here
	echo "Backup $backup_source failed! $backup_source_file does not exist!" | mail -s "Backup of $backup_source on $timestamp_start failed" root
	exit 1
fi
echo "Backup of $backup_source started" | mail -s "Backup of $backup_source on $timestamp_start started" root
if [ ! -L $backup_dest_link ]; then
	echo "Backup $backup_source failed! $backup_dest_link does not exist!" | mail -s "Backup of $backup_source on $timestamp_start failed" root
	exit 1
fi
# Doing backup
rsync -Aax --log-file=$backup_logfile --link-dest=$backup_dest_link $backup_source_file $backup_dest_file
if [ "$?" -ne "0" ]; then
	echo "Backup $backup_source failed! Rsync terminated with error!" | mail -s "Backup of $backup_source on $timestamp_start failed" root
	exit 1
fi
rm -f $backup_dest_link
ln -s $backup_dest_file $backup_dest_link
sync
umount $backup_dest_root
timestamp_finish=`date "+%Y%m%d_%H%M%S"`
echo "Backup $backup_source finished" | mail -s "Backup $backup_source on $timestamp_finish finished." root
