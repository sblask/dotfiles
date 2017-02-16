function maybe-install-virtualenv-requirements {
    VIRTUALENV_REQUIREMENTS=${HOME}/.virtualenvs/requirements.txt
    if ! python -c "import pkg_resources; pkg_resources.require(open('${VIRTUALENV_REQUIREMENTS}').read().splitlines())" 2>/dev/null; then
        echo -e "$fg[yellow]Installing requirements from ${VIRTUALENV_REQUIREMENTS}${reset_color}"
        pip install --upgrade --requirement ${VIRTUALENV_REQUIREMENTS}
    fi
}

function auto-enable-virtualenv {
    VIRTUALENV_DIRECTORY=$(print -l (../)#.venv(N:a))
    if [ "${VIRTUALENV_DIRECTORY}" != "" -a -d ${VIRTUALENV_DIRECTORY} ]; then
        source ${VIRTUALENV_DIRECTORY}/bin/activate
        maybe-install-virtualenv-requirements
    elif [ -f .penv -o -f .venv ]; then
        CURRENT_DIRECTORY=${PWD##*/}
        if [ "(${CURRENT_DIRECTORY}) " != "$(virtual_env)" ]; then
            workon ${CURRENT_DIRECTORY}
        fi
    fi
}

# this should run before prompt setup to be able to show virtualenv immediately
add-zsh-hook precmd auto-enable-virtualenv
