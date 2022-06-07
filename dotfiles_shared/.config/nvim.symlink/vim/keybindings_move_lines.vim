" move lines with ctrl shift j k

inoremap <silent> <C-J>   <C-O>:m  .+1<CR>
inoremap <silent> <C-K>   <C-O>:m  .-2<CR>

nnoremap <silent> <C-J>        :m  .+1<CR>
nnoremap <silent> <C-K>        :m  .-2<CR>

vnoremap <silent> <C-J>        :m '>+1<CR>gv
vnoremap <silent> <C-K>        :m '<-2<CR>gv
