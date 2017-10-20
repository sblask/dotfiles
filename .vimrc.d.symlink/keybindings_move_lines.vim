" move lines with alt up/down

inoremap <silent> <A-DOWN> <C-O>:m  .+1<CR>
inoremap <silent> <Esc>j   <C-O>:m  .+1<CR>
inoremap <silent> <Esc>k   <C-O>:m  .-2<CR>
inoremap <silent> <A-UP>   <C-O>:m  .-2<CR>

nnoremap <silent> <A-DOWN>      :m  .+1<CR>
nnoremap <silent> <Esc>j        :m  .+1<CR>
nnoremap <silent> <Esc>k        :m  .-2<CR>
nnoremap <silent> <A-UP>        :m  .-2<CR>

vnoremap <silent> <A-DOWN>      :m '>+1<CR>gv
vnoremap <silent> <Esc>j        :m '>+1<CR>gv
vnoremap <silent> <Esc>k        :m '<-2<CR>gv
vnoremap <silent> <A-UP>        :m '<-2<CR>gv
