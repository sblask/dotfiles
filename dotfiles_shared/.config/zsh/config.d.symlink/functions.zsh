function c {
    local query=$(echo "$1" | sed 's|/$||')
    if [[ "$query" == "" ]]
    then
        cd ~/Code
    else
        local directory
        directory=$(find ~/Code -mindepth 2 -maxdepth 2 -type d | grep "$query" | head --lines 1)
        cd ${directory}
    fi
}
# complete with ~/Code prefix
compctl -/ -W ~/Code/ c

function mcd {
    mkdir $1 && cd $1
}

function ts {
    date       --iso-8601=seconds --date @$1 2>/dev/null || date --date $1 +%s 2>/dev/null
}
function ts_utc {
    date --utc --iso-8601=seconds --date @$1 2>/dev/null || date --date $1 +%s 2>/dev/null
}
