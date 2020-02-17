#!/bin/bash
source ~/.bash_profile
tmux new-session -s dev -d 'home' -n 'home'\; \
	rename-window 'home'\; \
	send-keys 'cd ~' C-m\; \
	split-window -v -t 0\; \
	send-keys 'cd ~' C-m\; \
	split-window -h -t 1\; \
	send-keys 'cd ~' C-m\; \
	split-window -v -t 2\; \
	select-pane -t 0\; \
	new-window -n 'dev'\; \
	send-keys 'cdd' C-m\; \
	split-window -h -t 0\; \
	send-keys 'cdg' C-m\; \
	split-window -v -t 1\; \
	send-keys 'cdl' C-m\;
	select-pane -t 0\;
tmux attach -t dev
