function __maybe-install-requirements {
    local REQUIREMENTS_FILES=
    REQUIREMENTS_FILES=( "$@" )
    REQUIREMENTS_FILES=( $(__filter-existing "${REQUIREMENTS_FILES[@]}") )

    local REQUIREMENTS_STRING=$(cat ${REQUIREMENTS_FILES[*]})
    if ! python -c "import pkg_resources; pkg_resources.require(\"\"\"${REQUIREMENTS_STRING}\"\"\")" 2>/dev/null; then
        python -c "import pkg_resources; pkg_resources.require(\"\"\"${REQUIREMENTS_STRING}\"\"\")"
        echo -e "$fg[yellow]Installing requirements from ${REQUIREMENTS_FILES[*]}:\n${REQUIREMENTS_STRING}${reset_color}"
        pip install --upgrade $(for filename in ${REQUIREMENTS_FILES[@]}; do echo "--requirement $filename"; done)
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

        ESSENTIAL_REQUIREMENT_FILES=(
            ${HOME}/Clones/dotfiles/requirements-essential.txt
        )
        __maybe-install-requirements ${ESSENTIAL_REQUIREMENT_FILES[@]}

        SUPPORTED_REQUIREMENT_FILES=(
            ${HOME}/Clones/dotfiles/requirements-default.txt
            ${PWD}/requirements.txt
            ${PWD}/requirements-dev.txt
        )
        __maybe-install-requirements ${SUPPORTED_REQUIREMENT_FILES[@]}

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

        SUPPORTED_REQUIREMENT_FILES=(
            ${HOME}/Clones/dotfiles/default_requirements.txt
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
