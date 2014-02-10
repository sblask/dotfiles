#!/bin/bash

DOTFILES_DIRECTORY=$(dirname $0)
SCM_BREEZE_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/scm_breeze.dotfile

rm -rf $SCM_BREEZE_CLONE_DIRECTORY
git clone git@github.com:sblask/scm_breeze.git $SCM_BREEZE_CLONE_DIRECTORY

patch -p0 --directory=$SCM_BREEZE_CLONE_DIRECTORY < scm_breeze_patch

tar cvzf $DOTFILES_DIRECTORY/dotfiles.tgz $DOTFILES_DIRECTORY/* --exclude-vcs

