function git_no_mail_warning {
    git status 1>/dev/null 2>/dev/null
    if [ $? -ne 128 -a $? -ne 127 -a "$(git config user.email)" = "" -a "$EMAIL" = "" ]; then
        echo -n '(user.email not configured) '
    fi
}
function my_ip {
    hostname --all-ip-addresses | awk '{print $1}'
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
