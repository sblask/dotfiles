if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    " update diff on save
    autocmd BufWritePost *                 if &diff | diffupdate | endif
    " reload .vimrc automatically
    autocmd BufWritePost .vimrc.d/*        source %
    autocmd BufWritePost vimrc.d.dotfile/* source %
endif
