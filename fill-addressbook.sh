#!/bin/sh

folder1=~/.maildb/GoogleMail/\[Google\ Mail\].Sent\ Mail/cur
folder2=~/.maildb/GoogleMail/INBOX/cur

parsemail () {
	cat $1 | lbdb-fetchaddr
}

parsemaildir () {
	for mailfile in $( find $1 -type f ) ; do
		echo ${mailfile}
		parsemail ${mailfile}
	done
}

# The IFS variable saves the file name separator 
# which we will temporarily set to \n so that the
# spaces in Gmail folders will work

for folder in "${folder1}" "$folder2"; do
	o=${IFS}
	IFS=$(echo -en "\n\b")
	parsemaildir "${folder}"
	IFS=o
done
