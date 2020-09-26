# see https://github.com/chriskempson/base16
BASE16_SHELL=$HOME/.base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
