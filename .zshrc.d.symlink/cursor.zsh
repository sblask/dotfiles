function zle-line-init zle-keymap-select {
    # for cursor shapes, see http://stackoverflow.com/questions/4416909/anyway-change-the-cursor-vertical-line-instead-of-a-box
    if [ "$XTERM_VERSION" != "" ]; then
        if [ "${KEYMAP}" = "vicmd" ]; then
            echo -e -n "\x1b[\x31 q" # changes to blinking block
        else
            echo -e -n "\x1b[\x35 q" # changes to blinking bar
        fi
    fi
}
zle -N zle-line-init
zle -N zle-keymap-select
