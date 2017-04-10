#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../.bin/add-index.symlink --input-type ls_list $SCRIPT_DIRECTORY/ls_list_in )
set -o xtrace
colordiff --unified <( set +o xtrace; echo "$actual" ) $SCRIPT_DIRECTORY/ls_list_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../.bin/add-index.symlink --input-type ls_list --print-indexables $SCRIPT_DIRECTORY/ls_list_in )
set -o xtrace
colordiff --unified <( set +o xtrace; echo "$actual" ) $SCRIPT_DIRECTORY/ls_list_plus_files_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../.bin/add-index.symlink --input-type ls_list --print-indexables $SCRIPT_DIRECTORY/ls_list_colour_in )
set -o xtrace
colordiff --unified <( set +o xtrace; echo "$actual" ) $SCRIPT_DIRECTORY/ls_list_colour_plus_files_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../.bin/add-index.symlink --input-type git_status $SCRIPT_DIRECTORY/git_status_in )
set -o xtrace
colordiff --unified <( set +o xtrace; echo "$actual" ) $SCRIPT_DIRECTORY/git_status_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../.bin/add-index.symlink --input-type git_status --print-indexables $SCRIPT_DIRECTORY/git_status_colour_rename_in )
set -o xtrace
colordiff --unified <( set +o xtrace; echo "$actual" ) $SCRIPT_DIRECTORY/git_status_colour_rename_files_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../.bin/add-index.symlink --input-type git_branch --print-indexables $SCRIPT_DIRECTORY/git_branch_in )
set -o xtrace
colordiff --unified <( set +o xtrace; echo "$actual" ) $SCRIPT_DIRECTORY/git_branch_out
