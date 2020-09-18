function __aws_region {
    if [ "$AWS_DEFAULT_REGION" = "" ]; then
        echo ""
    else
        echo "$AWS_DEFAULT_REGION "
    fi
}

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

function __history {
    if [ $_per_directory_history_is_global == true ]; then
        echo "G"
    else
        echo "L"
    fi
}

function __my_ip {
    if [ $OS = mac ]; then
        ipconfig getifaddr en0
    else
        hostname --all-ip-addresses | awk '{print $1}'
    fi
}

function __imsa_profile {
    if [ "$IMSA_PROFILE" = "" ]; then
        echo ""
    else
        echo "($IMSA_PROFILE until $(date --date $IMSA_PROFILE_EXPIRATION +%H:%M)) "
    fi
}

function __terraform_workspace {
    if [ ! -d ".terraform" ]; then
        echo ""
        return
    fi

    local TERRAFORM_WORKSPACE=$(terraform workspace show 2> /dev/null)
    if [ "$TERRAFORM_WORKSPACE" = "default" ]; then
        echo ""
        return
    fi

    echo "(terraform: $TERRAFORM_WORKSPACE) "
}

function __vault_profile {
    if [ "$AWS_VAULT" = "" ]; then
        echo ""
    else
        echo "($AWS_VAULT until $(date --date $AWS_SESSION_EXPIRATION +%H:%M)) "
    fi
}

function __virtual_env {
    if [ "$VIRTUAL_ENV" = "" ]; then
        echo ""
    else
        echo "(venv: $(print -rD $VIRTUAL_ENV)) "
    fi
}


function __print_first_line {
    print
    lines=(
        "$(date +'[%a, %e %b %Y, %H:%M:%S]') "
        "[$(__history)] "
        "$fg[yellow]$(__aws_region)$reset_color"
        "$fg[yellow]$(__imsa_profile)$reset_color"
        "$fg[yellow]$(__vault_profile)$reset_color"
        "$fg[yellow]$(__terraform_workspace)$reset_color"
        "$fg[yellow]$(__aws_session)$reset_color"
        "$fg[blue]$(__virtual_env)$(__conda_env)$reset_color"
        "%n " # username
        "$fg[blue]%m$reset_color " # hostname
        "$(__my_ip) "
        "$(git_super_status) "
        "$fg[red]$(__git_no_mail_warning)$reset_color"
    )
    print -rP $(IFS=; echo "${lines[*]}")
}

PS1="%~ $ "
add-zsh-hook precmd __print_first_line
