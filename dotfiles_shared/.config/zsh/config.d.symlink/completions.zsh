# enable completions and load more of them from files
fpath=(${HOME}/.config/zsh/completions.d $fpath)
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
for file in ${HOME}/.config/zsh/bash_completions.d/*; do
    source "${file}"
done

# complete in both directions
setopt COMPLETE_IN_WORD

# enable # ~ ^ in globs
setopt EXTENDED_GLOB
# if there is no match, the glob is passed to a command without expansion - makes HEAD^ work
unsetopt NOMATCH
# globbing includes dotfiles
setopt GLOBDOTS
# insert fist match of menu immediately
setopt AUTO_MENU

# general options
zstyle ':completion:*' insert-tab pending # pasting with tabs doesn't perform completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'm:{a-zA-Z}={A-Za-z} l:|=.' # complete case insensitive and allow for the initial dot to be omitted
zstyle ':completion:*' menu select # highlight current selection and make suggestions navigable

# highlight prefix that is being completed
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

# completion list for kill based on ps
zstyle ':completion:*:kill:*' command 'ps f -u $USER -o pid,%cpu,%mem,cmd'
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:kill:*' menu yes select
zstyle ':completion:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*:processes' sort false

# make sure we do not get the same suggestion twice
zstyle ':completion:*:diff:*' ignore-line yes
zstyle ':completion:*:kill:*' ignore-line yes
zstyle ':completion:*:rm:*'   ignore-line yes
zstyle ':completion:*:vim:*'  ignore-line yes

# ignore some files during completion
# see http://www.bash2zsh.com/zsh_refcard/refcard.pdf
zstyle ':completion:*:*:vim:*:*files' ignored-patterns \
    '*.pyc' \

# Do not ever propose ORIG_HEAD
zstyle ':completion:*:*:*:*:*' ignored-patterns \
    'HEAD' \
    'FETCH_HEAD' \
    'ORIG_HEAD' \

# customize git completion
# see https://stackoverflow.com/questions/12175277/disable-auto-completion-of-remote-branches-in-zsh

# disable tag completion in git checkout
zstyle ':completion::complete:git-checkout:argument-rest:commit-tag-refs' command ""
# disable "recent" branches in git checkout
zstyle ':completion::complete:git-checkout:argument-rest:valid-ref-names' command ""
# disable remote branch completion in git checkout
zstyle ':completion::complete:git-checkout:argument-rest:headrefs' command "git for-each-ref --format='%(refname:short)' refs/heads 2>/dev/null"
# disable tag completion in git rebase
zstyle ':completion::complete:git-rebase:options-argument-1:commit-tag-refs' command ""
# ignore release branches in git rebase
zstyle ':completion::complete:git-rebase:options-argument-1:headrefs' command "git for-each-ref --format='%(refname:short)' refs/remotes 2>/dev/null | grep --extended-regexp '[0-9]+\.[0-9]+\.[0-9x]+' --invert-match"

# disable HEAD completion in git checkout
__git_recent_commits(){}
