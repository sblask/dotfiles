#!/bin/bash
# handle ssh:// protocol links
xfce4-terminal --tab -e "cssh $(echo $1 | cut -c 8- | sed 's/,/ /g')"

