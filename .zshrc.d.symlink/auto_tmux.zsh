# support tmux installed in home directory
TMUX_COMMAND=~/.opt/tmux/bin/tmux
if [ ! -f ${TMUX_COMMAND} ]; then
    TMUX_COMMAND=tmux
fi

# autostart tmux
if [ "$TMUX" = "" ]; then
    if [ "$(hostname)" = "arraia" -o "$(hostname)" = "rabo-de-arraia" ]; then
        if ${TMUX_COMMAND} has-session 2>/dev/null; then
            exec ${TMUX_COMMAND} attach
        else
            exec ${TMUX_COMMAND} new
        fi
    fi
fi
