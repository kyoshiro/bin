#!/bin/sh

arg=$1

if [ $arg==0 ]; then
	mode=ondemand
else
	mode=powersave
fi

for cpu in 0 1; do
    cpufreq-set -g $mode -c $cpu
done
