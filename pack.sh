#!/bin/bash

set -x -o errexit -o nounset -o pipefail

DOTFILES_DIRECTORY=$(dirname $0)

$DOTFILES_DIRECTORY/clone.sh

EXCLUDED_FILES="\
    *.markdown
    *.md
    *.swp
    *.tgz
    *test*
    .config
    .fonts
    .mozilla
    LICENSE*
    clone.sh
    doc
    hub.symlink
    pack.sh
    xnviewmp.dotfile
"

EXCLUDED_LINKS=$(find . -type l)
EXCLUDES=$(echo -n $EXCLUDED_FILES$EXCLUDED_LINKS | tr "\\n" " " | sed "s/ \+/ /g" | sed "s/ / --exclude /g")
tar -cvzf $DOTFILES_DIRECTORY/dotfiles.tgz \
    --exclude-vcs \
    --exclude $EXCLUDES \
    --transform 's/^./dotfiles/' \
    $DOTFILES_DIRECTORY/

