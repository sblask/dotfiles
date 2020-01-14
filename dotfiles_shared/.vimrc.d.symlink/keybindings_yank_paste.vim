" disable implicit yanking in normal mode
nnoremap c  "_c
nnoremap d  "_d
nnoremap x  "_x
nnoremap C  "_C
nnoremap D  "_D
nnoremap X  "_X
" disable implicit yanking in visual mode
vnoremap c  "_c
vnoremap d  "_d
vnoremap x  "_x
vnoremap C  "_C
vnoremap D  "_D
vnoremap X  "_X
" ...especially for pasting
" a little more complicated because it involves backing up the register
vnoremap p :<C-U>let @p = @+<CR>gvp:let @+ = @p<CR>
vnoremap P :<C-U>let @p = @+<CR>gvP:let @+ = @p<CR>
" yank to and paste from system clipboard
set clipboard=unnamedplus
" yank and put the cursor on the last character of selection
vnoremap y y`>
