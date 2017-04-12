function c {
    cd ~/Clones/$1;
}
# complete with ~/Clones prefix
compctl -/ -W ~/Clones/ c

function man {
    if [ "$( type "$1" )" == "read is a shell builtin" ]
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
