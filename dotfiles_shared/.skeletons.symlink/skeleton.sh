#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

declare -r SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

if [ "$1" = "something" ]; then
    echo "if"
elif [ "$1" = "something else" ]; then
    echo "elif"
else
    echo "else"
fi

for argument in $( echo $@ )
do
     echo "for"
done
