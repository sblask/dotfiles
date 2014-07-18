#!/bin/bash

DOTFILES_DIRECTORY=$(dirname $0)

$DOTFILES_DIRECTORY/clone.sh

EXCLUDED_FILES="\
    *.markdown
    *.md
    *.swp
    .config
    .fonts
    .mozilla
    LICENSE*
    clone.sh
    doc
    dotfiles.tgz
    pack.sh
    scm_breeze_patch
    xnviewmp.dotfile
"

EXCLUDED_LINKS=$(find . -type l)
EXCLUDES=$(echo -n "$EXCLUDED_FILES$EXCLUDED_LINKS" | tr "\\n" "|" | sed "s/|$//" | sed "s/|/ --exclude /g")
tar -cvzf $DOTFILES_DIRECTORY/dotfiles.tgz \
    --exclude-vcs \
    --exclude $EXCLUDES \
    --transform 's/^./dotfiles/' \
    $DOTFILES_DIRECTORY/

