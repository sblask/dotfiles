#!/bin/bash

DOTFILES_DIRECTORY=$(dirname $0)

VUNDLE_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.vim/bundle/vundle.symlink
rm -rf $VUNDLE_CLONE_DIRECTORY
git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE_CLONE_DIRECTORY

SCM_BREEZE_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/scm_breeze.dotfile
rm -rf $SCM_BREEZE_CLONE_DIRECTORY
git clone https://github.com/sblask/scm_breeze.git $SCM_BREEZE_CLONE_DIRECTORY
patch -p0 --directory=$SCM_BREEZE_CLONE_DIRECTORY < scm_breeze_patch

FONTS_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.fonts
mkdir -p $FONTS_CLONE_DIRECTORY
wget https://github.com/Lokaltog/powerline-fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf -O $FONTS_CLONE_DIRECTORY/DejaVu\ Sans\ Mono\ for\ Powerline.ttf.symlink

