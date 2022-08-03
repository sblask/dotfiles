#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )
COMMAND=$SCRIPT_DIRECTORY/../dotfiles_shared/.bin/add-index.symlink

# make sure we actually get output from commands instead of being redirected
unset MANPAGER

colordiff --unified "$SCRIPT_DIRECTORY/ag_out"                                       <( "$COMMAND" --input-type ag         --print-indexables                  "$SCRIPT_DIRECTORY/ag_in" )
colordiff --unified "$SCRIPT_DIRECTORY/git_branch_colour_out"                        <( "$COMMAND" --input-type git_branch --print-indexables                  "$SCRIPT_DIRECTORY/git_branch_colour_in" )
colordiff --unified "$SCRIPT_DIRECTORY/git_branch_out"                               <( "$COMMAND" --input-type git_branch --print-indexables                  "$SCRIPT_DIRECTORY/git_branch_in" )
colordiff --unified "$SCRIPT_DIRECTORY/git_branch_remote_out"                        <( "$COMMAND" --input-type git_branch --print-indexables                  "$SCRIPT_DIRECTORY/git_branch_remote_in" )
colordiff --unified "$SCRIPT_DIRECTORY/git_status_colour_rename_plus_indexables_out" <( "$COMMAND" --input-type git_status --print-indexables                  "$SCRIPT_DIRECTORY/git_status_colour_rename_in" )
colordiff --unified "$SCRIPT_DIRECTORY/git_status_out"                               <( "$COMMAND" --input-type git_status                                     "$SCRIPT_DIRECTORY/git_status_in" )
colordiff --unified "$SCRIPT_DIRECTORY/list_out"                                     <( "$COMMAND" --input-type list                                           "$SCRIPT_DIRECTORY/list_in" )
colordiff --unified "$SCRIPT_DIRECTORY/list_out_plus_indexables"                     <( "$COMMAND" --input-type list       --print-indexables                  "$SCRIPT_DIRECTORY/list_in" )
colordiff --unified "$SCRIPT_DIRECTORY/ls_list_colour_plus_indexables_out"           <( "$COMMAND" --input-type ls_list    --print-indexables --relative-paths "$SCRIPT_DIRECTORY/ls_list_colour_in" )
colordiff --unified "$SCRIPT_DIRECTORY/ls_list_out"                                  <( "$COMMAND" --input-type ls_list                                        "$SCRIPT_DIRECTORY/ls_list_in" )
colordiff --unified "$SCRIPT_DIRECTORY/ls_list_plus_indexables_out"                  <( "$COMMAND" --input-type ls_list    --print-indexables --relative-paths "$SCRIPT_DIRECTORY/ls_list_in" )
colordiff --unified "$SCRIPT_DIRECTORY/mixed_out"                                    <( "$COMMAND" --input-type mixed      --print-indexables                  "$SCRIPT_DIRECTORY/mixed_in" )
colordiff --unified "$SCRIPT_DIRECTORY/tree_out"                                     <( "$COMMAND" --input-type tree       --print-indexables                  "$SCRIPT_DIRECTORY/tree_in" )
colordiff --unified <( git branch --help )                       <( git branch --help | "$COMMAND" --input-type git_branch )
