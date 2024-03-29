if &diff
    " diff does weird stuff at the end of a file otherwise
    set scrolloff=0
    " make sure to go all the way down, so deletions in the end are visible
    nnoremap <PageUp>   M1000<C-U>zz
    nnoremap <PageDown> M1000<C-D>zz
    " put changes into the middle of the screen if possible
    nnoremap [c [czz
    nnoremap ]c ]czz
    " have all folds open when diffing
    augroup difffold
        autocmd VimEnter * windo normal zR
    augroup END
endif
