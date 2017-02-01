" indentation
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4

" set default encoding explicitely
set encoding=utf-8
" ignore case when completing filenames
set fileignorecase
" don't fold
set nofoldenable
set foldminlines=99999
" always show statusline
set laststatus=2
" show tabs and trailing whitespace
set list listchars=tab:»»,trail:·
" no backup files
set nobackup
" try to keep column when scrolling
set nostartofline
" no swap files
set noswapfile
" show line numbers
set number
" splits
set splitbelow
set splitright
" switch back to normal mode more quickly
set ttimeoutlen=0
" zsh-like command completion
set wildmenu
set wildmode=longest,full
set wildignore=.git,*.pyc
" wrap long lines
set wrap

" keep cursor vertically centered when diffing
if &diff
    set scrolloff=99
endif
