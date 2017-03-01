#!/bin/bash

set -x -o errexit -o nounset -o pipefail

DOTFILES_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE:-$0}" )" && pwd )

VUNDLE_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.vim/bundle/vundle.copy
rm -rf $VUNDLE_CLONE_DIRECTORY
git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE_CLONE_DIRECTORY

BASE16_SHELL_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/base16-shell.dotfile
rm -rf $BASE16_SHELL_CLONE_DIRECTORY
git clone https://github.com/chriskempson/base16-shell $BASE16_SHELL_CLONE_DIRECTORY
# patch generated from base16-shell directory with: git diff --no-prefix > ../patches/base16-shell
patch -p0 --directory=$BASE16_SHELL_CLONE_DIRECTORY < $DOTFILES_DIRECTORY/patches/base16-shell

SCM_BREEZE_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/scm_breeze.dotfile
rm -rf $SCM_BREEZE_CLONE_DIRECTORY
git clone https://github.com/sblask/scm_breeze.git $SCM_BREEZE_CLONE_DIRECTORY
# patch generated from scm breeze directory with: git diff --no-prefix > ../patches/scm_breeze
patch -p0 --directory=$SCM_BREEZE_CLONE_DIRECTORY < $DOTFILES_DIRECTORY/patches/scm_breeze

TPM_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.tmux/plugins/tpm.copy
rm -rf $TPM_CLONE_DIRECTORY
git clone https://github.com/tmux-plugins/tpm $TPM_CLONE_DIRECTORY

FONTS_CLONE_DIRECTORY=$DOTFILES_DIRECTORY/.fonts
mkdir -p $FONTS_CLONE_DIRECTORY
wget https://github.com/Lokaltog/powerline-fonts/raw/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf -O $FONTS_CLONE_DIRECTORY/DejaVu_Sans_Mono_for_Powerline.ttf.symlink

ZSH_DIRECTORY=$DOTFILES_DIRECTORY/zsh.dotfile
rm -rf $ZSH_DIRECTORY
mkdir $ZSH_DIRECTORY

ZSH_PLUGIN_DIRECTORY=$ZSH_DIRECTORY/plugins
mkdir $ZSH_PLUGIN_DIRECTORY
pushd $ZSH_PLUGIN_DIRECTORY
git clone https://github.com/olivierverdier/zsh-git-prompt $ZSH_PLUGIN_DIRECTORY/zsh-git-prompt && mv $ZSH_PLUGIN_DIRECTORY/zsh-git-prompt/zshrc.sh $ZSH_PLUGIN_DIRECTORY/zsh-git-prompt/zsh-git-prompt.plugin.zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_PLUGIN_DIRECTORY/zsh-syntax-highlighting
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/pip/pip.plugin.zsh
popd

ZSH_COMPLETION_DIRECTORY=$ZSH_DIRECTORY/completions.d
mkdir $ZSH_COMPLETION_DIRECTORY
pushd $ZSH_COMPLETION_DIRECTORY
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_ag
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_httpie
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_jq
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_rvm
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_sbt
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_scala
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_setup.py
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_vagrant
wget https://raw.githubusercontent.com/zsh-users/zsh-completions/master/src/_virtualbox
wget https://raw.githubusercontent.com/petervanderdoes/git-flow-completion/develop/git-flow-completion.zsh -O _git-flow && echo "#compdef git-flow" | cat - _git-flow | sponge _git-flow
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/gem/_gem
wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/plugins/pip/_pip
popd

ZSH_BASH_COMPLETION_DIRECTORY=$ZSH_DIRECTORY/bash_completions.d
mkdir $ZSH_BASH_COMPLETION_DIRECTORY

pushd $ZSH_BASH_COMPLETION_DIRECTORY
wget https://raw.githubusercontent.com/otm/limes/master/assets/limes && patch limes $DOTFILES_DIRECTORY/patches/limes
popd

wget https://github.com/github/hub/releases/download/v2.2.0-preview1/hub_2.2.0-preview1_linux_amd64.gz.tar -O $DOTFILES_DIRECTORY/hub.tgz
tar \
  --extract \
  --verbose \
  --show-transformed-names \
  --file hub.tgz \
  --wildcards \
  --strip-component 1 \
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
