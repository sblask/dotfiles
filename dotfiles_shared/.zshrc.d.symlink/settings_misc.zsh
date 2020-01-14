# enable color names instead of codes
autoload -Uz colors && colors
# enable programmable file renaming
autoload -Uz zmv
# wait 10 ms only for additional characters in key sequence
export KEYTIMEOUT=1
# enable using comments in command line
setopt INTERACTIVE_COMMENTS
# propose action if command was not found
source /etc/zsh_command_not_found
# automatically push directories to the stack, show stack with dirs -v, change to one using ~index
setopt AUTO_PUSHD
# disable Ctrl-S and Ctrl-Q
setopt NO_FLOW_CONTROL
