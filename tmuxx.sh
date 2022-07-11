#!/bin/bash

current_dir=$(pwd)
session_name=$(basename "$current_dir" | tr . _)

tmux new-session -s "$session_name" -c "$current_dir" -d -n vim
tmux new-window -t "$session_name" -n servers
tmux new-window -t "$session_name" -n git
tmux a -t "$session_name"
