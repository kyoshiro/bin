#!/bin/bash
source ~/.bash_profile
tmux new-session -s irix -d 'irix' -n 'irix'\; \
	rename-window 'irix'\; \
	split-window -v -t 0\; \
	split-window -h -t 1\; \
	clock-mode\; \
	split-window -v -t 2\; \
	send-keys 'cava' C-m\; \
	select-pane -t 0\; \
	new-window -d 'irix'\;
tmux attach -t irix
