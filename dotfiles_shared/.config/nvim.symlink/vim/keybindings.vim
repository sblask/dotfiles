" usable backspace in insert mode
set backspace=indent,eol,start
" confirm completion with enter
inoremap <expr> <CR> pumvisible() ? "<C-Y>" : "<CR>"
inoremap <expr> <TAB> pumvisible() ? "<C-N>" : "<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "<C-P>" : "<TAB>"
" better redo combination
nnoremap U <C-R>
" Disable page up and down
noremap <PageUp>   <nop>
noremap <PageDown> <nop>

" search without immediately jumping to next result
" ? to go to start of the word/selection `: let @/ = @s` to be able to go forward with n
" word under cursor with the exact boundaries, hence the \< and \>
nnoremap <silent> * "syiwl: let @s = '\<' . @s . '\>'<CR>?<C-R>s<CR>: let @/ = @s<CR>
" current selection
vnoremap <silent> * "sy`<l: let @s = '\V' . @s<CR>?<C-R>s<CR>: let @/ = @s<CR>

" spell checking with suggestion box
nnoremap z= a<C-X><C-S>
" add new lines without switching to insert mode
