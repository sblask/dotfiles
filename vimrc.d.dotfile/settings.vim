" indentation
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" change to directory of current file automatically
set autochdir
" reload file automatically on focus if unchanged here but changed somewhere else
set autoread
" enable highlighting of current line
set nocursorline
" set default encoding explicitely
set encoding=utf-8
" ignore case when completing filenames
set fileignorecase
" uninterrupted line between splits
set fillchars=vert:│
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
" do not show mode, that's what airline is for
set noshowmode
" show number relative to current for quick movement
set relativenumber
" splits
set splitbelow
set splitright
" no delay for esc
set ttimeoutlen=0
" zsh-like command completion
set wildmenu
set wildmode=longest,full
set wildignore=.git,*.pyc
" wrap long lines
set wrap
" keep three lines at end of the file
set scrolloff=3
