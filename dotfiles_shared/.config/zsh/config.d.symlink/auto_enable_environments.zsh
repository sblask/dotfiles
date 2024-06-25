function __maybe-install-requirements {
    local REQUIREMENTS_FILES=
    REQUIREMENTS_FILES=( "$@" )
    REQUIREMENTS_FILES=( $(__filter-existing "${REQUIREMENTS_FILES[@]}") )

    local REQUIREMENTS_STRING=$(cat ${REQUIREMENTS_FILES[*]} | sort --unique)
    if diff <(pip freeze --all | sort --unique) <(cat ${REQUIREMENTS_FILES[*]} | sort --unique) | grep \>; then
        pip install --upgrade \
            $(for filename in ${REQUIREMENTS_FILES[@]}; do echo "--requirement $filename"; done) \
            | grep -v "Requirement already satisfied"
    fi
}

function __filter-existing {
    local FILES=("$@")

    for filename in "${FILES[@]}";
    do
        if [[ -f "$filename" ]]
        then
            echo "$filename"
        fi
    done
}

function auto-enable-environment {
    SUPPORTED_REQUIREMENT_FILES=

    local VENV_DIRECTORY=$(print -l (../)#.venv(N:a) | tail -n 1)
    local CURRENT_VIRTUAL_ENV=${VIRTUAL_ENV}

    local CONDA_ENV_DIRECTORY=$(print -l (../)#.conda_env(N:a) | tail -n 1)
    local CURRENT_CONDA_ENV=${CONDA_DEFAULT_ENV}

    local ENV_DIR=
    if [ -d "${VENV_DIRECTORY}" ]; then
        ENV_DIR=${VENV_DIRECTORY}
    elif [ -d "${CONDA_ENV_DIRECTORY}" ]; then
        ENV_DIR=${CONDA_ENV_DIRECTORY}
    fi

    if [ "${ENV_DIR}" != "" ]; then

        if [ "${ENV_DIR}" = "${CURRENT_VIRTUAL_ENV}" ] || [ "${ENV_DIR}" = "${CURRENT_CONDA_ENV}" ]; then
            return
        fi

        if [ "${CURRENT_CONDA_ENV}" != "" ]; then
            conda deactivate
        fi

        if [ "${CURRENT_VIRTUAL_ENV}" != "" ]; then
            deactivate
        fi

        echo "Activate ${ENV_DIR}"
        if [[ "${ENV_DIR}" == */.venv ]]; then
            source ${ENV_DIR}/bin/activate
        else
            conda activate ${ENV_DIR}
        fi

        # make sure not to install into the wrong place if activation failed
        if [ $? -ne 0 ]; then
            return
        fi

        ESSENTIAL_REQUIREMENT_FILES=(
            ${HOME}/Code/personal/dotfiles/requirements-essential.txt
        )
        __maybe-install-requirements ${ESSENTIAL_REQUIREMENT_FILES[@]}

        SUPPORTED_REQUIREMENT_FILES=(
            ${HOME}/Code/personal/dotfiles/requirements-default.txt
            ${PWD}/requirements.txt
            ${PWD}/requirements-dev.txt
        )
        __maybe-install-requirements ${SUPPORTED_REQUIREMENT_FILES[@]}

    elif [[ "${CURRENT_VIRTUAL_ENV}" == */.venv ]]; then
        deactivate

    elif [[ "${CURRENT_CONDA_ENV}" == */.conda_env ]]; then
        conda deactivate

    fi
}

# this should run before prompt setup to be able to show virtualenv immediately
add-zsh-hook precmd auto-enable-environment
