# enable completions and load more of them from files
fpath=(${HOME}/.zsh/completions.d $fpath)
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
for file in ${HOME}/.zsh/bash_completions.d/*; do
    source "${file}"
done

# complete in both directions
setopt COMPLETE_IN_WORD

# enable # ~ ^ in globs
setopt EXTENDED_GLOB
setopt GLOBDOTS

# general options
zstyle ':completion:*' insert-tab pending # pasting with tabs doesn't perform completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # complete case insensitive
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
zstyle ':completion:*:rm:*' ignore-line yes

# ignore some files during completion
# see http://www.bash2zsh.com/zsh_refcard/refcard.pdf
zstyle ':completion:*:*:vim:*:*files' ignored-patterns '*.pyc' '.zsh' 'zsh.dotfile' '.zshrc' 'zshrc.dotfile'

# Do not ever propose ORIG_HEAD
zstyle ':completion:*:*:*:*:*' ignored-patterns 'ORIG_HEAD'
