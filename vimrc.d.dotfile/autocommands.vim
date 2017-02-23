if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    " update diff on save
    autocmd BufWritePost *                 if &diff | diffupdate | endif
    " reload .vimrc automatically
    autocmd BufWritePost .vimrc.d/*        source %
    autocmd BufWritePost vimrc.d.dotfile/* source %
    " exit insert mode immediately while keeping leader and esc maps intact in
    " other modes
    autocmd InsertEnter  *                 set timeoutlen=0
    autocmd InsertLeave  *                 set timeoutlen=1000
    " hide fold column
    autocmd WinEnter     *                 set foldcolumn=0
    autocmd WinLeave     *                 set foldcolumn=0
endif
