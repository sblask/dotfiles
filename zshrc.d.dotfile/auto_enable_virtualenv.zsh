function maybe-install-virtualenv-requirements {
    VIRTUALENV_REQUIREMENTS=$HOME/.virtualenvs/requirements.txt
    if ! python -c "import pkg_resources; pkg_resources.require(open('$VIRTUALENV_REQUIREMENTS').read().splitlines())" 2>/dev/null; then
        echo -e "$fg[yellow]Installing requirements from ${VIRTUALENV_REQUIREMENTS}${reset_color}"
        pip install --upgrade --requirement $VIRTUALENV_REQUIREMENTS
    fi
}

function auto-enable-virtualenv {
    if [ -d .venv ]; then
        if [ "$VIRTUAL_ENV" = "" ]; then
            source .venv/bin/activate
            maybe-install-virtualenv-requirements
        fi
    elif [ -f .penv -o -f .venv ]; then
        CURRENT_DIRECTORY=${PWD##*/}
        if [ "($CURRENT_DIRECTORY) " != "$(virtual_env)" ]; then
            workon $CURRENT_DIRECTORY
        fi
    fi
}

# this should run before prompt setup to be able to show virtualenv immediately
add-zsh-hook precmd auto-enable-virtualenv
