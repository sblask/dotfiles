# See http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html

# enable vi mode
bindkey -v
#
# Make basic keys/shortcuts work
#
# make backspace work after returning from command mode
bindkey -M viins '^?' backward-delete-char
# make del key work over ssh
bindkey -M viins '^[[3~' delete-char
# make Ctrl+Arrow work
bindkey -M vicmd '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
# make home key work
bindkey -M vicmd '^[[H' beginning-of-line
bindkey -M viins '^[[H' beginning-of-line
# make home key work over ssh
bindkey -M vicmd '^[[1~' beginning-of-line
bindkey -M viins '^[[1~' beginning-of-line
# make end key work
bindkey -M vicmd '^[[F' end-of-line
bindkey -M viins '^[[F' end-of-line
# make end key work over ssh
bindkey -M vicmd '^[[4~' end-of-line
bindkey -M viins '^[[4~' end-of-line
# Fix Shift/Ctrl Enter
bindkey -M vicmd '^[[27;2;13~' accept-line
bindkey -M viins '^[[27;2;13~' accept-line
bindkey -M vicmd '^[[27;5;13~' accept-line
bindkey -M viins '^[[27;5;13~' accept-line
bindkey -M vicmd '^[[27;6;13~' accept-line
bindkey -M viins '^[[27;6;13~' accept-line

#
# menu select options
#
zmodload zsh/complist
# close menu with escape
bindkey -M menuselect '\e' undo
# allow going back in selection menu using Shift-Tab
bindkey -M menuselect '^[[Z' reverse-menu-complete

#
# Misc
#
# edit current line in vim
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M viins '^E' edit-command-line
bindkey -M viins '^E' edit-command-line
# complete in word
bindkey -M viins '^N' expand-or-complete-prefix
bindkey -M viins '^P' expand-or-complete-prefix
# vim type incremental search
bindkey -M vicmd '^R' history-incremental-search-backward
bindkey -M viins '^R' history-incremental-search-backward
# undo/redo with u/U
bindkey -M vicmd 'u' undo
bindkey -M vicmd 'U' redo
# clear prompt, but return after next command
bindkey -M vicmd '^X' push-line
bindkey -M viins '^X' push-line
# kill line with Ctrl-Shift-X
bindkey -M vicmd '^[[27;6;88~' kill-whole-line
bindkey -M viins '^[[27;6;88~' kill-whole-line
# undo last completion/change with Ctrl+Z
bindkey -M vicmd '^Z' undo
bindkey -M viins '^Z' undo
# complete with Tab
zle -N expand-indexes-or-expand-or-complete
bindkey -M viins '^I' expand-indexes-or-expand-or-complete
# back in history or prefix search
autoload up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
# forward in history or prefix search
autoload down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# autosuggestions plugin accept with shift Tab
bindkey '^[[Z' autosuggest-accept
