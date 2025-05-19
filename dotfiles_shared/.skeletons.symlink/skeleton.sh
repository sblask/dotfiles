#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$(dirname "${BASH_SOURCE:-$0}" | xargs realpath)
declare -r SCRIPT_DIRECTORY

echo "$SCRIPT_DIRECTORY"

function cleanup() {
    rm -rf stuff_to_cleanup;
}

cleanup
trap cleanup EXIT

function do-something {
    if [ "$1" = "something" ]; then
        echo "if"
    elif [ "$1" = "something else" ]; then
        echo "elif"
    else
        echo "else"
    fi

    for argument in "$@"; do
        echo "for $argument"
    done
}

do-something "something" "and" "something" "else"
