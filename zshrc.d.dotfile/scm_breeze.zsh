if [ -f ~/.scm_breeze/scm_breeze.sh ]; then
    . ~/.scm_breeze/scm_breeze.sh
fi

# the aliases from scm breeze don't play nicely with zsh completions
# so use functions instead

for builtin in \
    cd \
; do
    eval "function ${builtin} { exec_scmb_expand_args builtin ${builtin} \$@ }"
done

for command in \
    cat \
    cp \
    ln \
    mv \
    rm \
    vim \
    vimdiff \
; do
    eval "function ${command} { exec_scmb_expand_args $(which ${command}) \$@ }"
done
