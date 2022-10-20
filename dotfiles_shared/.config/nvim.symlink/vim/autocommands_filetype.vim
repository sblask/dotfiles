augroup autocommands_filetype
    autocmd!
    " set filetype or syntax explicitly when creating or opening file
    autocmd BufNewFile,BufRead *.jinja             set filetype=jinja
    autocmd BufNewFile,BufRead *.jsm               set filetype=javascript
    autocmd BufNewFile,BufRead *.sls               set filetype=yaml
    autocmd BufNewFile,BufRead *.template          set filetype=json
    autocmd BufNewFile,BufRead */ansible/**        TSDisable highlight | set filetype=yaml.ansible
    autocmd BufRead            .ansible-lint       set filetype=yaml
    autocmd BufRead            .bash*              set filetype=sh
    autocmd BufRead            .common_env.symlink set filetype=sh
    autocmd BufRead            .pylintrc           set filetype=dosini
    autocmd BufRead            .pylintrc.symlink   set filetype=dosini
    autocmd BufRead            Buildfile           set filetype=make
    autocmd BufRead            bash*.dotfile       set filetype=sh
    autocmd BufRead            gitconfig.dotfile   set filetype=gitconfig
    autocmd BufRead            pylintrc.dotfile    set filetype=dosini
    autocmd BufRead            tmux.conf.dotfile   set filetype=tmux
    autocmd BufRead            ~/.aws/config       set filetype=dosini
    " keyword settings
    autocmd FileType           css                 set iskeyword+=-
    autocmd FileType           html                set iskeyword+=-
    autocmd FileType           make                set iskeyword+=-
    autocmd FileType           sh                  set iskeyword+=-
    autocmd FileType           terraform           set commentstring=#\ %s
    autocmd FileType           yaml                set iskeyword+=-
    autocmd FileType           zsh                 set iskeyword+=-
    " misc
    autocmd FileType           groovy              set nospell
augroup END
