#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

set +o xtrace
actual=$( add-index $SCRIPT_DIRECTORY/ls_list_in )
set -o xtrace
colordiff --unified <( set +o xtrace; echo "$actual" ) $SCRIPT_DIRECTORY/ls_list_out

set +o xtrace
actual=$( add-index --print-files $SCRIPT_DIRECTORY/ls_list_plus_files_in )
set -o xtrace
colordiff --unified <( set +o xtrace; echo "$actual" ) $SCRIPT_DIRECTORY/ls_list_plus_files_out
