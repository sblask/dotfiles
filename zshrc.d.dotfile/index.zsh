function set-index-variables() {
    local input="$(cat -)"

    local old_ifs=$IFS
    IFS=$'\n'

    local index=1
    echo $input | sed -e '0,/@@indexables@@/d' | while read file
    do
        export e$index="$file"
        let index++
    done

    echo $input | sed -e '/@@indexables@@/,$d' | while read line
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
        if [ "${resolved_index}" != "" ]
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

alias gs='git status --untracked-files=all | add-index --input-type git_status --print-indexables | set-index-variables'
alias la='ls -lha --color=always           | add-index --input-type ls_list    --print-indexables | set-index-variables'
alias ll='ls -lh  --color=always           | add-index --input-type ls_list    --print-indexables | set-index-variables'
