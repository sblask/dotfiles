if !exists("filetype_autocommands_loaded")
    let filetype_autocommands_loaded = 1
    " set filetype or syntax explicitely when creating or opening file
    autocmd BufNewFile *.jinja           set filetype=jinja
    autocmd BufRead    *.jinja           set filetype=jinja
    autocmd BufNewFile *.jsm             set filetype=javascript
    autocmd BufRead    *.jsm             set filetype=javascript
    autocmd BufNewFile *.sls             set filetype=yaml
    autocmd BufRead    *.sls             set filetype=yaml
    autocmd BufNewFile *.template        set filetype=json
    autocmd BufRead    *.template        set filetype=json
    autocmd BufRead    .bash*            set filetype=sh
    autocmd BufRead    Buildfile         set filetype=make
    autocmd BufRead    bash*.dotfile     set filetype=sh
    autocmd BufRead    gitconfig.dotfile set filetype=gitconfig
    autocmd BufRead    tmux.conf.dotfile set filetype=tmux
    " keyword settings
    autocmd FileType   sh                set iskeyword+=-
    autocmd FileType   yaml              set iskeyword+=- | set iskeyword+=.
    autocmd FileType   zsh               set iskeyword+=-
endif
