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
