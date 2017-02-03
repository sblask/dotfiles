" usable backspace in insert mode
set backspace=indent,eol,start
" confirm completion with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" better redo combination
nnoremap U <C-R>
" fix page keys
" http://vimrc-dissection.blogspot.se/2009/02/fixing-pageup-and-pagedown.html
map <silent> <PageUp> 1000<C-U>
map <silent> <PageDown> 1000<C-D>
imap <silent> <PageUp> <C-O>1000<C-U>
imap <silent> <PageDown> <C-O>1000<C-D>
" text objects
"
" between slashes
" f/F/f/F/ moves the cursor to within slashes no matter where on line
vnoremap a/ :<C-U>silent! normal! f/F/f/F/vf/<CR>
vnoremap i/ :<C-U>silent! normal! f/F/f/F/lvt/<CR>
omap a/ :normal va/<CR>
omap i/ :normal vi/<CR>
" start search without immediately jumping to next result
nmap <silent> * "syiw<Esc>: let @/ = '\<' . @s . '\>'<CR>:set hlsearch<CR>
" allow search for current selection
vmap <silent> * "sy<Esc>:let @/ = escape(@s, '/\.*$^~[')<CR>:set hlsearch<CR>
