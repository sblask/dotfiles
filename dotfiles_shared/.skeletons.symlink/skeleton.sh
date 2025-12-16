#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail -o xtrace -o errtrace

SCRIPT_DIRECTORY=$(dirname "${BASH_SOURCE:-$0}" | xargs realpath)
declare -r SCRIPT_DIRECTORY

echo "$SCRIPT_DIRECTORY"

function cleanup() {
    rm -rf stuff_to_cleanup;
}

cleanup
trap cleanup EXIT

trap 'echo "Error on line $LINENO: $BASH_COMMAND"; exit 1' ERR

while [[ $# -gt 0 ]]; do
    case "$1" in
        --argument)
            echo "$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done


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

    produce-something | while read -r something; do
        echo "$something"
    done
}

do-something "something" "and" "something" "else"
