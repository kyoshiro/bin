#!/bin/bash

function progress(){
	echo -n "Looking for wlans, please wait..."
	while true; do
		echo -n "."
		sleep 5
	done
}

function search_wlan(){
	sudo wpa_supplicant -i ath0 -c /etc/wpa_supplicant/wpa_supplicant.conf -d madwifi -B 2>&1>/dev/null
}

function request_ip(){
	sudo dhcpcd ath0 2>&1>/dev/null
}

function test_wlan(){
	ping -c 2 www.gentoo.org
}

search_wlan
progress&
PROGRESS_PID=$!
sleep 4
request_ip
sleep 3
kill $PROGRESS_PID

echo -n "Wlan should be up and running"
echo -n "Testing..."
test_wlan
echo "...done. Have fun!"
