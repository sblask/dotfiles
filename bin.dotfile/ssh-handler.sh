#!/bin/bash
# handle ssh:// protocol links
xterm -e "ssh $(echo $1 | cut -c 7-)"

