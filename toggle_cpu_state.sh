#!/bin/sh
# This script toggles the cpu power consuming

mode="powersave"

current_state="$(cpufreq-info -o | awk '{ print $14 }' | grep -m 1 powersave)"

if [ -n "$current_state" ]; then
	if [ "$current_state" == "powersave" ]; then
		mode="ondemand"
	fi
fi

for cpu in 0 1; do
	echo "Toggling state to $mode."
    cpufreq-set -g $mode -c $cpu
done
