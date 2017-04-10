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

function __print-path-argument {
    local path_arguments=()
    for argument in $@; do
        if [ -d "${argument}" ]
        then
            path_arguments+=("${argument}")
        fi
    done
    # ls prints paths if several are given, but not if it's only one
    if [ "${#path_arguments[@]}" == "1" ]
    then
        echo "${path_arguments[1]}:"
    fi
}

function gb {
    git branch                                         $@   | add-index --input-type git_branch --print-indexables | set-index-variables
}

function gs {
    git status --untracked-files=all                   $@   | add-index --input-type git_status --print-indexables | set-index-variables
}

function la {
    { __print-path-argument $@; ls -lha --color=always $@ } | add-index --input-type ls_list    --print-indexables | set-index-variables
}

function ll {
    { __print-path-argument $@; ls -lh  --color=always $@ } | add-index --input-type ls_list    --print-indexables | set-index-variables
}
