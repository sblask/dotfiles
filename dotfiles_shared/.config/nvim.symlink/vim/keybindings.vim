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
" start search without immediately jumping to next result
nnoremap <silent> * "syiw<Esc>: let @/ = '\<' . @s . '\>'<CR>:set hlsearch<CR>
" allow search for current selection
vnoremap <silent> * "sy<Esc>:let @/ = escape(@s, '/\.*$^~[')<CR>:set hlsearch<CR>
" spell checking with suggestion box
nnoremap z= a<C-X><C-S>
" add new lines without switching to insert mode
