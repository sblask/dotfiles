" background of line number column if shown
highlight LineNr ctermbg=bg
" normal text colour
highlight Normal ctermfg=grey
" autocompletion box
highlight Pmenu ctermfg=black ctermbg=grey
" currently selected line in autocompletion box
highlight PmenuSel ctermfg=lightGrey ctermbg=darkGrey
" wild menu highlighting
highlight StatusLine ctermfg=lightGrey ctermbg=bg
highlight WildMenu ctermfg=black ctermbg=lightGrey
" highlight matches
highlight clear Search
highlight Search ctermbg=yellow ctermfg=brown
" highlight while typing
highlight clear IncSearch
highlight IncSearch ctermbg=blue ctermfg=white
" background of column where warnings and errors are shown
highlight SignColumn ctermbg=bg
" colours for warnings and errors
highlight SyntasticErrorSign ctermbg=bg ctermfg=red
highlight SyntasticWarningSign ctermbg=bg ctermfg=darkyellow
highlight SyntasticStyleErrorSign ctermbg=bg ctermfg=yellow
highlight SyntasticStyleWarningSign ctermbg=bg ctermfg=yellow
" selected text in visual mode
highlight Visual cterm=reverse ctermbg=None ctermfg=None
" matching parentheses
highlight MatchParen cterm=bold ctermfg=yellow
" enable highlighting of current line
set cursorline
" don't actually highlight the line...
highlight clear CursorLine
" ...only the line number
highlight CursorLineNR cterm=bold ctermbg=bg ctermfg=yellow
" colors for listchars
highlight SpecialKey ctermfg=darkRed
