#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

# make sure we actually get output from commands instead of being redirected
unset MANPAGER

function verify-output-equals {
    local expected=$1
    colordiff --unified $expected <( set +o xtrace; echo "$actual" )
}

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type list $SCRIPT_DIRECTORY/list_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/list_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type list --print-indexables $SCRIPT_DIRECTORY/list_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/list_out_plus_indexables

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type ls_list $SCRIPT_DIRECTORY/ls_list_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/ls_list_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type ls_list --print-indexables --relative-paths $SCRIPT_DIRECTORY/ls_list_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/ls_list_plus_indexables_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type ls_list --print-indexables --relative-paths $SCRIPT_DIRECTORY/ls_list_colour_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/ls_list_colour_plus_indexables_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type git_status $SCRIPT_DIRECTORY/git_status_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/git_status_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type git_status --print-indexables $SCRIPT_DIRECTORY/git_status_colour_rename_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/git_status_colour_rename_plus_indexables_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type git_branch --print-indexables $SCRIPT_DIRECTORY/git_branch_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/git_branch_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type git_branch --print-indexables $SCRIPT_DIRECTORY/git_branch_remote_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/git_branch_remote_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type git_branch --print-indexables $SCRIPT_DIRECTORY/git_branch_colour_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/git_branch_colour_out

set +o xtrace
actual=$( git branch --help | $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type git_branch )
set -o xtrace
verify-output-equals <( git branch --help )

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type ag --print-indexables $SCRIPT_DIRECTORY/ag_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/ag_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type mixed --print-indexables $SCRIPT_DIRECTORY/mixed_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/mixed_out

set +o xtrace
actual=$( $SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink --input-type tree --print-indexables $SCRIPT_DIRECTORY/tree_in )
set -o xtrace
verify-output-equals $SCRIPT_DIRECTORY/tree_out
