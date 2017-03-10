function expand-scm-breeze-index-or-expand-or-complete {
    local MATCH
    MATCH=$(echo ${LBUFFER} | sed --quiet --regexp-extended 's/[^0-9]+ ([0-9]+([ -][0-9]+)*$)/\1/p')
    if [ "${MATCH}" != "" ]; then
        LBUFFER=${LBUFFER%%${MATCH}}
        LBUFFER+=$(scmb_expand_args ${=MATCH} | sed 's/\t/ /g')
    else
        zle expand-or-complete
    fi
}
function gd {
    git diff --color=always $@          | vimpager
}
function gdc {
    git diff --color=always $@ --cached | vimpager
}
function gdh {
    git diff --color=always $@          | head --lines 50
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
