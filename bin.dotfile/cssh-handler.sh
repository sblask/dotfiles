#!/bin/bash

SESSION_NAME="ssh_$(echo $SERVERS | awk '{split($0,a,"-"); printf "%s_%s", a[1], a[2]}')"

if tmux has-session -t $SESSION_NAME; then
    notify-send "Session $SESSION_NAME exists already" --expire-time=3000
else
    # handle cssh:// protocol links
    xterm -e "~/.bin/tmux-cssh $(echo $1 | cut -c 8- | sed 's/,/ /g')"
fi

