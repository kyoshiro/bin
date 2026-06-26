#!/bin/bash
source ~/.bash_profile
tmux new-session -s gentoo -d 'gentoo' -n 'gentoo'\; \
	rename-window 'gentoo'\; \
	split-window -v -t 0\; \
	split-window -h -t 1\; \
	clock-mode\; \
	split-window -v -t 2\; \
	send-keys 'cava' C-m\; \
	select-pane -t 0\; \
	new-window -d 'gentoo'\;
tmux attach -t gentoo
