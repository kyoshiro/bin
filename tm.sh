#!/bin/bash

tmux new-session -s my-desk -d

#split screen in have horizontally
tmux split-window -v
#split the top window in half vertically
tmux split-window -h -t 0
#split the bottom window in half vertically
tmux split-window -h -t 2

tmux attach -t my-desk
