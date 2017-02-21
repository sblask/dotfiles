" enable highlighting of current line
set cursorline
" don't actually highlight the line...
highlight clear CursorLine
" ...only the line number
highlight CursorLineNR              ctermbg=black    ctermfg=yellow
" background of line number column if shown
highlight LineNr                    ctermbg=black
" autocompletion box
highlight Pmenu                     ctermbg=grey     ctermfg=black
" currently selected line in autocompletion box
highlight PmenuSel                  ctermbg=darkGrey ctermfg=lightGrey
" background of column where warnings and errors are shown
highlight SignColumn                ctermbg=black
" colors for listchars
highlight SpecialKey                                 ctermfg=darkRed
" the choices in wildmenu
highlight StatusLine                ctermbg=black    ctermfg=darkGrey
" colours for warnings and errors
highlight SyntasticErrorSign                         ctermfg=red
highlight SyntasticWarningSign                       ctermfg=yellow
highlight SyntasticStyleErrorSign                    ctermfg=yellow
highlight SyntasticStyleWarningSign                  ctermfg=yellow
" wild menu highlighting
highlight WildMenu                                   ctermfg=black
