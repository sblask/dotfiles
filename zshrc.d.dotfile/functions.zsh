function c() {
    cd ~/Clones/$1;
}
# complete with ~/Clones prefix
compctl -/ -W ~/Clones/ c

function set-index-variables() {
    local input="$(cat -)"

    local old_ifs=$IFS
    IFS=$'\n'

    local index=1
    for file in $(echo $input | sed -e '0,/@@file_list@@/d')
    do
        export e$index="$file"
        let index++
    done

    for line in $(echo $input | sed -e '/@@file_list@@/,$d')
    do
        echo $line
    done

    IFS=$old_ifs
}

function __flatten-index-arguments() {
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

function __expand-indexes () {
    for index in $( __flatten-index-arguments $@ )
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
        local REPLACEMENT=$( __expand-indexes ${MATCH} )
        LBUFFER="${LBUFFER/%${MATCH}/${REPLACEMENT}}"
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
