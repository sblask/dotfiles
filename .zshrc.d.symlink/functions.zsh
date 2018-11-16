function c {
    local subdirectory
    if [[ "$1" == "" ]]
    then
        subdirectory=""
    else
        subdirectory=$(ls ~/Clones/ | grep "$1" | head --lines 1)
    fi
    cd ~/Clones/${subdirectory}
}
# complete with ~/Clones prefix
compctl -/ -W ~/Clones/ c

function p {
    local subdirectory
    if [[ "$1" == "" ]]
    then
        subdirectory=""
    else
        subdirectory=$(ls ~/Private/ | grep "$1" | head --lines 1)
    fi
    cd ~/Private/${subdirectory}
}
# complete with ~/Clones prefix
compctl -/ -W ~/Private/ p

function fd {
    findi . -iname "*$@*" -type d -not -path "*/.venv/*" -not -path "*/.git/*"
}
function ff {
    findi . -iname "*$@*" -type f -not -path "*/.venv/*" -not -path "*/.git/*"
}
function fn {
    findi . -iname "*$@*"         -not -path "*/.venv/*" -not -path "*/.git/*"
}

function man {
    if [[ "$( type "$1" )" == *builtin ]]
    then
        run-help "$1" | vimpager
    else
        command man "$@"
    fi
}

function mcd {
    mkdir $1 && cd $1
}

function ts {
    date       --iso-8601=seconds --date @$1 2>/dev/null || date --date $1 +%s 2>/dev/null
}
function ts_utc {
    date --utc --iso-8601=seconds --date @$1 2>/dev/null || date --date $1 +%s 2>/dev/null
}
