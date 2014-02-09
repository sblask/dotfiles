#!/bin/bash
# handle ssh:// protocol links
xfce4-terminal --tab -e "ssh $(echo $1 | cut -c 7-)"

