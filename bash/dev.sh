#!/bin/bash

DEV_DIR=/Users/valerycherneykin/dev

if command -v fd &>/dev/null; then
    SELECTED=$(fd -t d -d 2 --min-depth 2 . "$DEV_DIR" | sed 's|/$||' | sed "s|$DEV_DIR|~/dev|" | fzf --height 40% --layout reverse --border)
else
    SELECTED=$(find "$DEV_DIR" -mindepth 2 -maxdepth 2 -type d -not -path '*/\.*' | sed "s|$DEV_DIR|~/dev|" | fzf --height 40% --layout reverse --border)
fi

if [[ -z "$SELECTED" ]]; then
    exit 0
fi

SELECTED_FULL="${SELECTED/#\~\/dev/$DEV_DIR}"
SELECTED_NAME="${SELECTED_FULL##*/}"
SELECTED_NAME="${SELECTED_NAME//./_}"

TMUX_RUNNING=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $TMUX_RUNNING ]]; then
    tmux new-session -s "$SELECTED_NAME" -c "$SELECTED_FULL"
    tmux send-keys -t "$SELECTED_NAME" 've' C-m
    exit 0
fi

if ! tmux has-session -t "$SELECTED_NAME" 2>/dev/null; then
    tmux new-session -s "$SELECTED_NAME" -c "$SELECTED_FULL" -d
    tmux send-keys -t "$SELECTED_NAME" 've' C-m
fi

if [[ -z $TMUX ]]; then
    tmux attach-session -t "$SELECTED_NAME"
else
    tmux switch-client -t "$SELECTED_NAME"
fi
