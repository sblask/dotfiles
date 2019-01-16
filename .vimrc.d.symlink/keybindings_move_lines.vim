" move lines with ctrl shift j k

inoremap <silent> <C-S-J>   <C-O>:m  .+1<CR>
inoremap <silent> <C-S-K>   <C-O>:m  .-2<CR>

nnoremap <silent> <C-S-J>        :m  .+1<CR>
nnoremap <silent> <C-S-K>        :m  .-2<CR>

vnoremap <silent> <C-S-J>        :m '>+1<CR>gv
vnoremap <silent> <C-S-K>        :m '<-2<CR>gv
