#!/bin/sh
# This script toggles the cpu power consuming

mode="powersave"

current_state="$(cpupower frequency-info -o | awk '{ print $14 }' | grep -m 1 powersave)"

if [ -n "$current_state" ]; then
	if [ "$current_state"=="powersave" ]; then
		mode="performance"
    fi
fi

for cpu in 0 1 2 3 4 5 6 7; do
	echo "Toggling state to $mode."
    cpupower frequency-set -g $mode
done
