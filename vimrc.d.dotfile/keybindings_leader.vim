" close current buffer without closing split
noremap <silent> <Leader>c :new<CR><C-W>W:bd<CR>
" toggle relativenumber
noremap <silent> <Leader>r :set relativenumber!<CR>
" write as sudo
noremap <silent> <Leader>w :w !sudo tee % > /dev/null<CR>
