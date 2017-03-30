function c() {
    cd ~/Clones/$1;
}
# complete with ~/Clones prefix
compctl -/ -W ~/Clones/ c

function flatten-index-arguments() {
    for argument in $( echo $@ )
    do
        if [[ "${argument}" =~ ^[0-9]+-[0-9]+$ ]]
        then
            for index in $( eval echo {${argument/-/..}} )
            do
                echo ${index}
            done
        else
            echo ${argument}
        fi
    done
}

function expand-indexes () {
    for index in $( flatten-index-arguments $@ )
    do
        local index_variable="e${index}"
        local resolved_index=$( eval echo "\"\${${index_variable}}\"" )
        if [ "${resolved_index}" != "" -a -e "${resolved_index}" ]
        then
            printf "${resolved_index}" | sed 's/ /\\ /g'
        else
            printf "${index}"
        fi
        printf " "
    done
}

function expand-indexes-or-expand-or-complete {
    local MATCH=$( echo ${LBUFFER} | grep --perl-regexp --only-matching "(?<=^| )([0-9]+([ -][0-9]+)*)$" )
    if [ "${MATCH}" != "" ]; then
        local REPLACEMENT=$( expand-indexes ${MATCH} )
        if [ "${REPLACEMENT}" != "" ]; then
            LBUFFER="${LBUFFER/${MATCH}/${REPLACEMENT}}"
        fi
    else
        zle expand-or-complete
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
