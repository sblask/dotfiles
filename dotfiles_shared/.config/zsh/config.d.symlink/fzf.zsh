export FZF_COMPLETION_OPTS='--bind tab:down,shift-tab:up --color bg+:0'
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--bind tab:up,shift-tab:down --color bg+:0'

_fzf_compgen_path() {
    fd --hidden --follow --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude .git . "$1"
}
