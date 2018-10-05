function maybe-install-virtualenv-requirements {
    local VIRTUALENV_REQUIREMENTS_FILE=$1
    if [ -f ${VIRTUALENV_REQUIREMENTS_FILE} ]; then
        if ! python -c "import pkg_resources; pkg_resources.require(open('${VIRTUALENV_REQUIREMENTS_FILE}').read().splitlines())" 2>/dev/null; then
            echo -e "$fg[yellow]Installing requirements from ${VIRTUALENV_REQUIREMENTS_FILE}${reset_color}"
            pip install --upgrade --requirement ${VIRTUALENV_REQUIREMENTS_FILE}
        fi
    fi
}

function auto-enable-virtualenv {
    local VIRTUALENV_DIRECTORY=$(print -l (../)#.venv(N:a))
    if [ "${VIRTUALENV_DIRECTORY}" != "" -a -d ${VIRTUALENV_DIRECTORY} ]; then
        if [ "${VIRTUAL_ENV}" != "" ] && [ "$(pwd)" =~ "^$(dirname ${VIRTUAL_ENV}).*" ]; then
            return
        fi

        source ${VIRTUALENV_DIRECTORY}/bin/activate
        maybe-install-virtualenv-requirements ${HOME}/Clones/dotfiles/default_requirements.txt
        maybe-install-virtualenv-requirements ${PWD}/requirements.txt
    elif [ -f .penv -o -f .venv ]; then
        local CURRENT_DIRECTORY=${PWD##*/}
        if [ "(${CURRENT_DIRECTORY}) " != "$(virtual_env)" ]; then
            workon ${CURRENT_DIRECTORY}
        fi
    fi
}

# this should run before prompt setup to be able to show virtualenv immediately
add-zsh-hook precmd auto-enable-virtualenv
