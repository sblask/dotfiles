#!/bin/bash
# handle ssh:// protocol links
cssh $(echo $1 | cut -c 8- | sed 's/,/ /g')

