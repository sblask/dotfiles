" close current buffer without closing split
noremap <silent> <Leader>c :new<CR><C-W>W:bd<CR>
" format json file
noremap <silent> <Leader>j :% !format-json<CR>
" write as sudo
noremap <silent> <Leader>w :w !sudo tee % > /dev/null<CR>
