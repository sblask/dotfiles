colorscheme base16-eighties-modified

" load plugins first as other configs require parts of them
source ~/.config/nvim/vim/plugins.vim

set wildignore+=plugins.vim
for g:fpath in split(glob('~/.config/nvim/vim/*.vim'), '\n')
    exe 'source' g:fpath
endfor
set wildignore-=plugins.vim

" auto-update spell files
for g:add_file in glob('~/.config/nvim/spell/*.add', 1, 1)
    if filereadable(g:add_file) && (!filereadable(g:add_file . '.spl') || getftime(g:add_file) > getftime(g:add_file . '.spl'))
        exec 'mkspell! ' . fnameescape(g:add_file)
    endif
endfor
