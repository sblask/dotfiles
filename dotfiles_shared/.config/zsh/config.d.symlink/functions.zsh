function c {
    local query=$(echo "$1" | sed 's|/$||')
    if [[ "${query}" == "" ]]
    then
        cd ~/Code
    else
        local directory
        directory=$(find ~/Code -mindepth 2 -maxdepth 2 -type d | grep "${query}" | head --lines 1)

        if [[ "${directory}" == "" ]]
        then
            RED='\033[0;31m'
            NC='\033[0m'
            printf "${RED}No match found for '${query}'${NC}\n"
            return 1
        else
            cd ${directory}
        fi
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
