#!/bin/bash

DOTFILES_DIRECTORY=$(dirname $0)

$DOTFILES_DIRECTORY/clone.sh

EXCLUDED_LINKS=$(find . -type l | tr "\\n" "|" | sed "s/|$//" | sed "s/|/ --exclude /g")
tar cvzf $DOTFILES_DIRECTORY/dotfiles.tgz $DOTFILES_DIRECTORY/ --exclude-vcs --exclude dotfiles.tgz --exclude pack.sh --exclude scm_breeze_patch --exclude .fonts --exclude $EXCLUDED_LINKS --transform 's/^./dotfiles/'

