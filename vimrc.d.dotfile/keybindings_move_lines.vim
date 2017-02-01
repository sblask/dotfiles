" move lines with alt up/down

inoremap <A-DOWN> <C-O>:m .+1<CR>
inoremap j <C-O>:m .+1<CR>
inoremap k <C-O>:m .-2<CR>
inoremap <A-UP> <C-O>:m .-2<CR>

nnoremap <A-DOWN> :m .+1<CR>
nnoremap j :m .+1<CR>
nnoremap k :m .-2<CR>
nnoremap <A-UP> :m .-2<CR>

vnoremap <A-DOWN> :m '>+1<CR>gv
vnoremap j :m '>+1<CR>gv
vnoremap k :m '<-2<CR>gv
vnoremap <A-UP> :m '<-2<CR>gv
