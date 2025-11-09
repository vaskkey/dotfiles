#!/bin/bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Developer -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -s "$selected_name" -c $selected -d -n vim
    tmux new-window -t "$selected_name" -c $selected -n servers
    tmux new-window -t "$selected_name" -c $selected -n git
fi

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux a -t "$session_name"
    exit 0
fi

tmux switch-client -t $selected_name

