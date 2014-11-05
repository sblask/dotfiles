#!/bin/bash

DOTFILES_DIRECTORY=$(dirname $0)

VUNDLE_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.vim/bundle/vundle.copy
rm -rf $VUNDLE_CLONE_DIRECTORY
git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE_CLONE_DIRECTORY

SCM_BREEZE_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/scm_breeze.dotfile
rm -rf $SCM_BREEZE_CLONE_DIRECTORY
git clone https://github.com/sblask/scm_breeze.git $SCM_BREEZE_CLONE_DIRECTORY
patch -p0 --directory=$SCM_BREEZE_CLONE_DIRECTORY < scm_breeze_patch

FONTS_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.fonts
mkdir -p $FONTS_CLONE_DIRECTORY
wget https://github.com/Lokaltog/powerline-fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf -O $FONTS_CLONE_DIRECTORY/DejaVu_Sans_Mono_for_Powerline.ttf.symlink

ZSH_DIRECTORY=$DOTFILES_DIRECTORY/zsh.dotfile
rm -rf $ZSH_DIRECTORY
mkdir $ZSH_DIRECTORY

ZSH_PLUGIN_DIRECTORY=$ZSH_DIRECTORY/plugins
mkdir $ZSH_PLUGIN_DIRECTORY
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGIN_DIRECTORY/zsh-syntax-highlighting

ZSH_COMPLETION_DIRECTORY=$ZSH_DIRECTORY/completions.d
mkdir $ZSH_COMPLETION_DIRECTORY
wget https://github.com/github/hub/releases/download/v2.2.0-preview1/hub_2.2.0-preview1_linux_amd64.gz.tar -O $DOTFILES_DIRECTORY/hub.tgz
tar \
  --extract \
  --verbose \
  --show-transformed-names \
  --file hub.tgz \
  --wildcards \
  --strip-component 1 \
  --directory bin.dotfile \
  "*/hub"

tar \
  --extract \
  --verbose \
  --show-transformed-names \
  --file hub.tgz \
  --wildcards \
  --strip-component 2 \
  --directory $ZSH_COMPLETION_DIRECTORY \
  --transform "s/hub.zsh_completion/_hub/" \
  "*/etc/hub.zsh_completion"
