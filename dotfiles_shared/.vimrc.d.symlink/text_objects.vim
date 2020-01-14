" f/F/ covers the cursor being before and in between, but f/F/ is necessary if
" the cursor is behind /
vnoremap a/ :<C-U>silent! normal! f/F/f/F/vf/<CR>
vnoremap i/ :<C-U>silent! normal! f/F/f/F/lvt/<CR>
omap a/ :normal va/<CR>
omap i/ :normal vi/<CR>

"
" override default quote text objects as they don't behave like the ( for
" example
"
vnoremap a' :<C-U>silent! normal! f'F'f'F'vf'<CR>
vnoremap i' :<C-U>silent! normal! f'F'f'F'lvt'<CR>
omap a' :normal va'<CR>
omap i' :normal vi'<CR>

vnoremap a" :<C-U>silent! normal! f"F"f"F"vf"<CR>
vnoremap i" :<C-U>silent! normal! f"F"f"F"lvt"<CR>
omap a" :normal va"<CR>
omap i" :normal vi"<CR>

vnoremap a` :<C-U>silent! normal! f`F`f`F`vf`<CR>
vnoremap i` :<C-U>silent! normal! f`F`f`F`lvt`<CR>
omap a` :normal va`<CR>
omap i` :normal vi`<CR>

"
" override default text objects for brackets and parentheses to work on
" character level and not line level
"
vnoremap <silent> a( <Esc>:let @b = @/<CR><BS>/)<CR>v?(<CR>:<C-U>nohlsearch<CR>:let @/ = @b<CR>gv
vnoremap <silent> i( <Esc>:let @b = @/<CR><BS>/)<CR>v?(<CR> o<BS>:<C-U>nohlsearch<CR>:let @/ = @b<CR>gv
omap a( :normal va(<CR>
omap i( :normal vi(<CR>

vnoremap <silent> a[ <Esc>:let @b = @/<CR><BS>/]<CR>v?[<CR>:<C-U>nohlsearch<CR>:let @/ = @b<CR>gv
vnoremap <silent> i[ <Esc>:let @b = @/<CR><BS>/]<CR>v?[<CR> o<BS>:<C-U>nohlsearch<CR>:let @/ = @b<CR>gv
omap a[ :normal va[<CR>
omap i[ :normal vi[<CR>

vnoremap <silent> a{ <Esc>:let @b = @/<CR><BS>/}<CR>v?{<CR>:<C-U>nohlsearch<CR>:let @/ = @b<CR>gv
vnoremap <silent> i{ <Esc>:let @b = @/<CR><BS>/}<CR>v?{<CR> o<BS>:<C-U>nohlsearch<CR>:let @/ = @b<CR>gv
omap a{ :normal va{<CR>
omap i{ :normal vi{<CR>
