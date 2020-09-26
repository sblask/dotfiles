function maybe-install-requirements {
    local VIRTUALENV_REQUIREMENTS_FILE=$1
    if [ -f ${VIRTUALENV_REQUIREMENTS_FILE} ]; then
        if ! python -c "import pkg_resources; pkg_resources.require(open('${VIRTUALENV_REQUIREMENTS_FILE}').read().splitlines())" 2>/dev/null; then
            python -c "import pkg_resources; pkg_resources.require(open('${VIRTUALENV_REQUIREMENTS_FILE}').read().splitlines())"
            echo -e "$fg[yellow]Installing requirements from ${VIRTUALENV_REQUIREMENTS_FILE}${reset_color}"
            pip install --upgrade --requirement ${VIRTUALENV_REQUIREMENTS_FILE}
        fi
    fi
}

function auto-enable-environment {
    local VIRTUALENV_DIRECTORY=$(print -l (../)#.venv(N:a) | tail -n 1)
    local CURRENT_VIRTUAL_ENV=${VIRTUAL_ENV}

    local CONDA_ENV_FILE=$(print -l (../)#.conda_env(N:a) | tail -n 1)
    local CURRENT_CONDA_ENV=${CONDA_DEFAULT_ENV}

    if [ -d "${VIRTUALENV_DIRECTORY}" ]; then
        local GIVEN_VIRTUALENV=${VIRTUALENV_DIRECTORY}

        if [ "${GIVEN_VIRTUALENV}" = "${CURRENT_VIRTUAL_ENV}" ]; then
            return
        fi

        if [ "${CURRENT_CONDA_ENV}" != "" ]; then
            conda deactivate
        fi

        if [ "${CURRENT_VIRTUAL_ENV}" != "" ]; then
            deactivate
        fi

        echo "Activate ${GIVEN_VIRTUALENV}"
        source ${GIVEN_VIRTUALENV}/bin/activate
        maybe-install-requirements ${HOME}/Clones/dotfiles/default_requirements.txt
        maybe-install-requirements ${PWD}/requirements.txt

    elif [ -f "${CONDA_ENV_FILE}" ]; then
        local GIVEN_CONDA_ENV=$(cat "${CONDA_ENV_FILE}")

        if [ "${GIVEN_CONDA_ENV}" = "" ]; then
            return
        fi

        if [ "${GIVEN_CONDA_ENV}" = "${CURRENT_CONDA_ENV}" ]; then
            return
        fi

        if [ "${CURRENT_CONDA_ENV}" != "" ]; then
            conda deactivate
        fi

        if [ "${CURRENT_VIRTUAL_ENV}" != "" ]; then
            deactivate
        fi

        echo "Activate ${GIVEN_CONDA_ENV}"
        conda activate ${GIVEN_CONDA_ENV}
        maybe-install-requirements ${HOME}/Clones/dotfiles/default_requirements.txt

    elif [ "${CURRENT_VIRTUAL_ENV}" != "" ]; then
        deactivate

    elif [ "${CURRENT_CONDA_ENV}" != "" ]; then
        conda deactivate
    fi
}

# this should run before prompt setup to be able to show virtualenv immediately
add-zsh-hook precmd auto-enable-environment
