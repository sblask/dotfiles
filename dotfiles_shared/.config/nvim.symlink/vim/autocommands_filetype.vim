augroup autocommands_filetype
    autocmd!
    " set filetype or syntax explicitly when creating or opening file
    autocmd BufNewFile,BufRead *.jinja             set filetype=jinja
    autocmd BufNewFile,BufRead *.jsm               set filetype=javascript
    autocmd BufNewFile,BufRead *.sls               set filetype=yaml
    autocmd BufNewFile,BufRead *.template          set filetype=json
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
    " do something on write
    autocmd FileType           hcl                 autocmd BufWrite <buffer> execute 'PackerFmt' | execute 'echo ""'
    autocmd FileType           json                autocmd BufWrite <buffer> execute 'JsonFix' | execute 'echo ""'
    autocmd FileType           terraform           autocmd BufWrite <buffer> execute 'TerraformFmt' | execute 'echo ""'
augroup END
