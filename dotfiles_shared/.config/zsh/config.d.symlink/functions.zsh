function c {
    if [[ "${1}" == "" ]]
    then
        cd ~/Code/
        return
    fi

    match=$(cd ~/Code/ && find */ -type d -mindepth 1 -maxdepth 1 | fzf --query "$1" --select-1 --cycle)

    if [[ "${match}" != "" ]]
    then
        cd ~/Code/${match}
    fi
}
# complete with ~/Code/ prefix
compctl -/ -W ~/Code/ c

function ce {
    if [[ "${1}" == "" ]]
    then
        cd ~/Code/personal/
        return
    fi

    match=$(ls ~/Code/personal | fzf --query "$1" --select-1 --cycle)

    if [[ "${match}" != "" ]]
    then
        cd ~/Code/personal/${match}
    fi
}
# complete with ~/Code/personal/ prefix
compctl -/ -W ~/Code/personal/ ce

function cw {
    if [[ "${1}" == "" ]]
    then
        cd ~/Code/work/
        return
    fi

    match=$(ls ~/Code/work | fzf --query "$1" --select-1 --cycle)

    if [[ "${match}" != "" ]]
    then
        cd ~/Code/work/${match}
    fi
}
# complete with ~/Code/work/ prefix
compctl -/ -W ~/Code/work/ cw

function mcd {
    mkdir $1 && cd $1
}

function ts {
    date       --iso-8601=seconds --date @$1 2>/dev/null || date --date $1 +%s 2>/dev/null
}
function ts_utc {
    date --utc --iso-8601=seconds --date @$1 2>/dev/null || date --date $1 +%s 2>/dev/null
}
