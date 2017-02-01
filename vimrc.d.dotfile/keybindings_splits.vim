" more intuitive splitting
map <C-W>\| :vnew<CR>
map <C-W>_  :new<CR>
" move windows around
map <C-W>x :call WindowSwap#MarkWindowSwap()<CR>
map <C-W>p :call WindowSwap#DoWindowSwap()<CR>
" move through splits with tab
nnoremap <Tab> <C-W>w
nnoremap <S-Tab> <C-W>W
" resize with + and - using shift for horizontal resizes
nnoremap - :vertical resize -5<CR>
nnoremap = :vertical resize +5<CR>
nnoremap _ :resize -5<CR>
nnoremap + :resize +5<CR>
