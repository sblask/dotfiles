augroup autocommands_filetype
    autocmd!
    " set filetype or syntax explicitly when creating or opening file
    autocmd BufNewFile *.jinja           set filetype=jinja
    autocmd BufRead    *.jinja           set filetype=jinja
    autocmd BufNewFile *.jsm             set filetype=javascript
    autocmd BufRead    *.jsm             set filetype=javascript
    autocmd BufNewFile *.sls             set filetype=yaml
    autocmd BufRead    *.sls             set filetype=yaml
    autocmd BufNewFile *.template        set filetype=json
    autocmd BufRead    *.template        set filetype=json
    autocmd BufRead    .bash*            set filetype=sh
    autocmd BufRead    .pylintrc         set filetype=dosini
    autocmd BufRead    Buildfile         set filetype=make
    autocmd BufRead    bash*.dotfile     set filetype=sh
    autocmd BufRead    gitconfig.dotfile set filetype=gitconfig
    autocmd BufRead    pylintrc.dotfile  set filetype=dosini
    autocmd BufRead    tmux.conf.dotfile set filetype=tmux
    " keyword settings
    autocmd FileType   css               set iskeyword+=-
    autocmd FileType   html              set iskeyword+=-
    autocmd FileType   make              set iskeyword+=-
    autocmd FileType   sh                set iskeyword+=-
    autocmd FileType   yaml              set iskeyword+=-
    autocmd FileType   zsh               set iskeyword+=-
    " misc
    autocmd FileType   groovy            set nospell
    " do something on write
    autocmd FileType   hcl               autocmd BufWrite <buffer> execute ':PackerFmt'
    autocmd FileType   terraform         autocmd BufWrite <buffer> execute ':TerraformFmt'
augroup END
