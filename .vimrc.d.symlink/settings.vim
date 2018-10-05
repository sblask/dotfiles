scriptencoding utf-8

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
set completeopt=menuone,noselect
" enable highlighting of current line
set nocursorline
" ignore case when completing filenames
set fileignorecase
" uninterrupted line between splits
set fillchars=vert:│
" configure folding
set foldlevelstart=99
set foldmethod=syntax
set foldminlines=5
set foldnestmax=2
set nofoldenable
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
" allow increment/decrement for letters too
set nrformats=alpha,bin,octal,hex
" show line numbers
set number
" do not show mode, that's what airline is for
set noshowmode
" scroll, not jump horizontally
set sidescroll=1
" splits
set splitbelow
set splitright
" no delay for esc
set timeoutlen=0
set ttimeoutlen=0
" zsh-like command completion
set wildmenu
set wildmode=longest,full
set wildignore=.git,*.pyc
" wrap long lines
set wrap
" keep three lines at end of the file
set scrolloff=3
" configure spell checking
set spell
set spellcapcheck=
set spellfile=~/.vim/spell/en.utf-8.add,~/.vim/spell/local.en.utf-8.add
