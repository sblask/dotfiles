function aws_region {
    if [ "$AWS_DEFAULT_REGION" = "" ]; then
        echo ""
    else
        echo "$AWS_DEFAULT_REGION "
    fi
}
function git_no_mail_warning {
    git status 1>/dev/null 2>/dev/null
    if [ $? -ne 128 -a $? -ne 127 -a "$(git config user.email)" = "" -a "$EMAIL" = "" ]; then
        echo -n '(user.email not configured) '
    fi
}
function my_ip {
    if [ $OS = mac ]; then
        ipconfig getifaddr en0
    else
        hostname --all-ip-addresses | awk '{print $1}'
    fi
}
function imsa_profile {
    if [ "$IMSA_PROFILE" = "" ]; then
        echo ""
    else
        echo "($IMSA_PROFILE until $(date --date $IMSA_PROFILE_EXPIRATION +%H:%M)) "
    fi
}
function virtual_env {
    if [ "$VIRTUAL_ENV" = "" ]; then
        echo ""
    else
        echo "($(print -rD $VIRTUAL_ENV)) "
    fi
}


function print-first-line {
    print
    lines=(
        "$(date +'[%a, %e %b %Y, %H:%M:%S]') "
        "$fg[yellow]$(aws_region)$reset_color"
        "$fg[yellow]$(imsa_profile)$reset_color"
        "$fg[blue]$(virtual_env)$reset_color"
        "%n " # username
        "$fg[blue]%m$reset_color " # hostname
        "$(my_ip) "
        "$(git_super_status) "
        "$fg[red]$(git_no_mail_warning)$reset_color"
    )
    print -rP $(IFS=; echo "${lines[*]}")
}

PS1="%~ $ "
add-zsh-hook precmd print-first-line
