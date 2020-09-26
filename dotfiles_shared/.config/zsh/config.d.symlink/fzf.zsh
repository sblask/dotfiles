export FZF_COMPLETION_OPTS='--bind tab:down,shift-tab:up --color bg+:0'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'
export FZF_DEFAULT_OPTS='--bind tab:up,shift-tab:down --color bg+:0'

_fzf_compgen_path() {
    ag --hidden --ignore .git -g ""
}

_fzf_compgen_dir() {
    find . -type d \
        -not \( -path ./.git -prune \) \
        -not \( -path ./.venv -prune \) \
        -not \( -path ./node_modules -prune \) \
        -not \( -path */__pycache__ -prune \) \

    }
