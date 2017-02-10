if &diff
    " diff does weird stuff at the end of a file otherwise
    set scrolloff=0
    " make sure to go all the way down, so deletions in the end are visible
    nnoremap <PageUp>   M1000<C-U>zz
    nnoremap <PageDown> M1000<C-D>zz
endif
