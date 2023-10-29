export AWS_CLI_AUTO_PROMPT=on-partial
export EDITOR=nvim
export LS_COLORS='di=34:ln=33:or=31:ex=32'
export PAGER='less -K'
export PIP_DOWNLOAD_CACHE=~/.pip_download_cache
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export VIRTUAL_ENV_DISABLE_PROMPT=True

if [ "$OS" = linux ]
then
    export MANPAGER="/bin/sh -c \"col -b | nvim --appimage-extract-and-run -c 'set filetype=man tabstop=8 nomodified nomodifiable nolist nospell nonumber' -\""
else
    export MANPAGER="/bin/sh -c \"col -b | nvim -c 'set filetype=man tabstop=8 nomodified nomodifiable nolist nospell nonumber' -\""
fi
