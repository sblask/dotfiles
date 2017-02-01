if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    " update diff on save
    autocmd BufWritePost *             if &diff | diffupdate | endif
    " reload .vimrc automatically
    autocmd BufWritePost .vimrc        source %
    autocmd BufWritePost vimrc.dotfile source %
endif
