function __aws_session {
    if [ "$AWS_SESSION_EXPIRATION" = "" ]; then
        echo ""
    elif [ "$AWS_ROLE_ARN" = "" ]; then
        echo ""
    else
        echo "($(echo $AWS_ROLE_ARN | awk -F/ '{printf("%s/%s\n", $2, $3)}') until $(date --date $AWS_SESSION_EXPIRATION +%H:%M)) "
    fi
}

function __conda_env {
    if [ "$CONDA_DEFAULT_ENV" = "" ]; then
        echo ""
    else
        echo "(conda: $(print -rD $CONDA_DEFAULT_ENV)) "
    fi
}

function __git_no_mail_warning {
    git status 1>/dev/null 2>/dev/null
    if [ $? -ne 128 -a $? -ne 127 -a "$(git config user.email)" = "" -a "$EMAIL" = "" ]; then
        echo -n '(user.email not configured) '
    fi
}

function __my_ip {
    if [ "$OS" = mac ]; then
        ipconfig getifaddr en0
    else
        hostname --all-ip-addresses | awk '{print $1}'
    fi
}

function __terraform_workspace {
    if [ ! -d ".terraform" ]; then
        echo ""
        return
    fi

    local TERRAFORM_WORKSPACE=$(terraform workspace show 2> /dev/null)
    if [ "$TERRAFORM_WORKSPACE" = "" ] || [ "$TERRAFORM_WORKSPACE" = "default" ]; then
        echo ""
        return
    fi

    echo "(terraform: $TERRAFORM_WORKSPACE) "
}

function __virtual_env {
    if [ "$VIRTUAL_ENV" = "" ]; then
        echo ""
    else
        echo "(venv: $(print -rD $VIRTUAL_ENV)) "
    fi
}

prompt_aws_region=""
prompt_aws_profile=""

prompt_second_line=""

function precmd {
    local exit_code=$?

    if [ "$AWS_DEFAULT_REGION" = "" ]; then
        prompt_aws_region=""
    else
        prompt_aws_region="$AWS_DEFAULT_REGION "
    fi

    if [ "$AWS_PROFILE" = "" ]; then
        prompt_aws_profile=""
    else
        prompt_aws_profile="(AWS_PROFILE: $AWS_PROFILE) "
    fi

    if [[ $exit_code -eq 0 ]]; then
        prompt_second_line="%~ $ "
    # consider all signal-based exits as success
    elif [[ $exit_code -gt 128 ]]; then
        prompt_second_line="%~ $ "
    else
        prompt_second_line="%~ %F{red}[Last command ^ failed with exit code $exit_code] $ %f"
    fi
}

PROMPT=$'\n'
PROMPT+='[%D{%a, %e %b %Y, %H:%M:%S}] '
PROMPT+='${${_per_directory_history_is_global:#true}:+[L] }'
PROMPT+='${${_per_directory_history_is_global:#false}:+[G] }'
PROMPT+='%F{yellow}${prompt_aws_region}%f'
PROMPT+='%F{yellow}${prompt_aws_profile}%f'
# PROMPT+='%F{yellow}$(__aws_session)%f'
# PROMPT+='%F{yellow}$(__terraform_workspace)%f'
PROMPT+='%F{blue}$(__virtual_env)%f'
# PROMPT+='%F{blue}$(__conda_env)%f'
# PROMPT+='%n ' # username
# PROMPT+='%F{blue}%m%f ' # hostname
# PROMPT+='$(__my_ip) '
PROMPT+='$(git_super_status) '
PROMPT+='%F{red}$(__git_no_mail_warning)%f'

PROMPT+=$'\n'
PROMPT+='${prompt_second_line}'
