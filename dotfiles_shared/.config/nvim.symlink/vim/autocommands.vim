augroup autocommands
    autocmd!
    " go to first change - having a check for &diff resulted in weird errors
    " when there was a change on the first line, but as ]c[c doesn't do
    " anything when not in diff mode it's ok without
    autocmd VimEnter     *                 normal ]c[c
    " update diff on save
    autocmd BufWritePost *                 if &diff | diffupdate | endif
    " do not fold in diff mode
    autocmd DiffUpdated  *                 if &diff | set nofoldenable | endif
    " exit insert mode immediately while keeping leader and esc maps intact in
    " other modes
    autocmd InsertEnter  *                 set timeoutlen=0
    autocmd InsertLeave  *                 set timeoutlen=1000
    " write files automatically when focus is lost
    autocmd FocusLost    *                 stopinsert | silent! wall!
    " for breuckelen/vim-resize
    autocmd BufEnter     *                 let g:resize_count = 5
    " make sure no comment highlighting is applied to regular code
    autocmd BufEnter     *                 :syntax sync fromstart
    " highlight yanked text
    autocmd TextYankPost *                 au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=1000 }
    " exit vim-visual-multi on save
    autocmd BufWrite     *                 try | silent call vm#reset() | catch | endtry
augroup END
