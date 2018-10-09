" usable backspace in insert mode
set backspace=indent,eol,start
" confirm completion with enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" better redo combination
nnoremap U <C-R>
" fix cursor position when using page keys
" http://vimrc-dissection.blogspot.se/2009/02/fixing-pageup-and-pagedown.html
nnoremap <PageUp>        1000<C-U>
nnoremap <PageDown>      1000<C-D>
inoremap <PageUp>   <C-O>1000<C-U>
inoremap <PageDown> <C-O>1000<C-D>
nmap        <Space>     <PageDown>
nmap      <S-Space>     <PageUp>
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
" keep cursor where it is when leaving insert mode
inoremap <silent> <Esc> <Esc>`^
