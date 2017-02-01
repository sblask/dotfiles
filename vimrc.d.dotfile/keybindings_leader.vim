" close current buffer without closing split
noremap <silent> <Leader>c :bp<bar>sp<bar>bn<bar>bd<CR>
" format json file
noremap <silent> <Leader>j :% !format-json<CR>
" insert new empty lines without entering insert mode
noremap <silent> <Leader>o :set formatoptions-=o<CR>m`o<Esc>k``:set formatoptions+=o<CR>
noremap <silent> <Leader>O :set formatoptions-=o<CR>m`O<Esc>j``:set formatoptions+=o<CR>
" write as sudo
noremap <silent> <Leader>w :w !sudo tee % > /dev/null<CR>
