" smart 0
noremap <expr> <silent> 0 col('.') == match(getline('.'),'\S')+1 ? '0' : '^'
" do not select line break when using $ in visual mode
vnoremap $ g_
" emacs movements using the above
imap <C-E> <C-O>$
imap <C-A> <C-O>0

" move graphical lines up and down
nnoremap k gk
nnoremap j gj
nnoremap <Up> gk
nnoremap <Down> gj
" use original mappings to move up and down logical lines
nnoremap gk k
nnoremap gj j

" fix arrow keys
inoremap <C-Right> <Left><C-O>e<Right>
inoremap <S-Down> <C-O>j
inoremap <S-Up> <C-O>k

noremap <C-Left> b
noremap <C-Right> e
noremap <S-Down> j
noremap <S-Up> k
