" close current buffer without closing split
noremap <silent> <Leader>c :bp<bar>sp<bar>bn<bar>bd<CR>
" format json file
noremap <silent> <Leader>j :% !format-json<CR>
" write as sudo
noremap <silent> <Leader>w :w !sudo tee % > /dev/null<CR>
