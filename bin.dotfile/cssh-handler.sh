#!/bin/bash
# handle ssh:// protocol links
xterm -e "~/.bin/tmux-cssh $(echo $1 | cut -c 8- | sed 's/,/ /g')"

