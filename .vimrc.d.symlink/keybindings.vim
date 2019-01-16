" usable backspace in insert mode
set backspace=indent,eol,start
" confirm completion with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" better redo combination
nnoremap U <C-R>
" Disable page up and down
noremap <PageUp>   <nop>
noremap <PageDown> <nop>
" text object between slashes
" f/F/f/F/ moves the cursor to within slashes no matter where on line
vnoremap a/ :<C-U>silent! normal! f/F/f/F/vf/<CR>
vnoremap i/ :<C-U>silent! normal! f/F/f/F/lvt/<CR>
omap a/ :normal va/<CR>
omap i/ :normal vi/<CR>
" start search without immediately jumping to next result
nnoremap <silent> * "syiw<Esc>: let @/ = '\<' . @s . '\>'<CR>:set hlsearch<CR>
" allow search for current selection
vnoremap <silent> * "sy<Esc>:let @/ = escape(@s, '/\.*$^~[')<CR>:set hlsearch<CR>
" spell checking with suggestion box
nnoremap z= a<C-X><C-S>
