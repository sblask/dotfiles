export ASDF_NODEJS_AUTO_ENABLE_COREPACK=true
export AWS_CLI_AUTO_PROMPT=on-partial
export EDITOR=nvim
export LS_COLORS='di=34:ln=33:or=31:ex=32'
export PAGER='less -K'
export PIP_DOWNLOAD_CACHE=~/.pip_download_cache
export PIP_REQUIRE_VIRTUALENV=true
export POETRY_VIRTUALENVS_IN_PROJECT=true
export RIPGREP_CONFIG_PATH=~/.ripgreprc
export VIRTUAL_ENV_DISABLE_PROMPT=True

if [ "$OS" = linux ]
then
    export MANPAGER="nvim --appimage-extract-and-run +Man!"
else
    export MANPAGER="nvim +Man!"
fi
