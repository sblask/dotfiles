#!/bin/bash

set -x -o errexit -o nounset -o pipefail

DOTFILES_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

BASE16_SHELL_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.base16-shell.symlink
rm -rf $BASE16_SHELL_CLONE_DIRECTORY
git clone https://github.com/chriskempson/base16-shell $BASE16_SHELL_CLONE_DIRECTORY
# patch generated from base16-shell directory with: git diff --no-prefix > ../patches/base16-shell
patch -p0 --directory=$BASE16_SHELL_CLONE_DIRECTORY < $DOTFILES_DIRECTORY/patches/base16-shell

FONTS_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.fonts
mkdir -p $FONTS_CLONE_DIRECTORY
wget https://github.com/Lokaltog/powerline-fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf -O $FONTS_CLONE_DIRECTORY/DejaVu_Sans_Mono_for_Powerline.ttf.symlink

wget https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz -O $DOTFILES_DIRECTORY/hub.tgz
tar \
  --extract \
  --verbose \
  --show-transformed-names \
  --file hub.tgz \
  --wildcards \
  --strip-component 2 \
  --directory .bin \
  --transform "s/$/.symlink/" \
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
chmod 775 $DOTFILES_DIRECTORY/.bin/hub.symlink

curl https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_amd64.zip --location | gunzip - > $DOTFILES_DIRECTORY/.bin/pup.symlink
chmod 775 $DOTFILES_DIRECTORY/.bin/pup.symlink
