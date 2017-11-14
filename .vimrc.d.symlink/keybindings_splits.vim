" more intuitive splitting
map <C-W>\| :vnew<CR>
map <C-W>_  :new<CR>
" switch between vertical and horizontal splits
map <C-W>h :windo wincmd L<CR>
map <C-W>v :windo wincmd J<CR>
" move windows around
map <C-W>x :call WindowSwap#MarkWindowSwap()<CR>
map <C-W>p :call WindowSwap#DoWindowSwap()<CR>
" move through splits with ctrl tab
nnoremap <C-Tab> <C-W>w
nnoremap <C-S-Tab> <C-W>W
" resize like in tmux
nnoremap <silent> <C-H> :CmdResizeLeft<CR>
nnoremap <silent> <C-J> :CmdResizeDown<CR>
nnoremap <silent> <C-K> :CmdResizeUp<CR>
nnoremap <silent> <C-L> :CmdResizeRight<CR>
