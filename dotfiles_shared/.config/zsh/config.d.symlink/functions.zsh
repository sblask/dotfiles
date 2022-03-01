function c {
    local query=$(echo "$1" | sed 's|/$||')
    local subdirectory
    if [[ "$query" == "" ]]
    then
        subdirectory=""
    else
        subdirectory=$(ls ~/Clones/ | grep "$query" | head --lines 1)
    fi
    cd ~/Clones/${subdirectory}
}
# complete with ~/Clones prefix
compctl -/ -W ~/Clones/ c

function p {
    local query=$(echo "$1" | sed 's|/$||')
    local subdirectory
    if [[ "$query" == "" ]]
    then
        subdirectory=""
    else
        subdirectory=$(ls ~/Private/ | grep "$query" | head --lines 1)
    fi
    cd ~/Private/${subdirectory}
}
# complete with ~/Clones prefix
compctl -/ -W ~/Private/ p

function mcd {
    mkdir $1 && cd $1
}

function ts {
    date       --iso-8601=seconds --date @$1 2>/dev/null || date --date $1 +%s 2>/dev/null
}
function ts_utc {
    date --utc --iso-8601=seconds --date @$1 2>/dev/null || date --date $1 +%s 2>/dev/null
}
