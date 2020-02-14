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
	new-window -n 'dev'\; \
	send-keys 'cdg' C-m\; \
	split-window -h -t 0\; \
	send-keys 'cdgl' C-m\; \
	split-window -v -t 1\; \
	send-keys 'cdl' C-m\;
tmux attach -t dev
