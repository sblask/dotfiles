scriptencoding utf-8

" indentation
set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" reload file automatically on focus if unchanged here but changed somewhere else
set autoread
set completeopt=menuone,noselect
" hopefully better diffs, see https://vimways.org/2018/the-power-of-diff/
set diffopt=
set diffopt+=algorithm:minimal
set diffopt+=context:9999 " disable folding
set diffopt+=filler
set diffopt+=indent-heuristic
set diffopt+=internal
" enable highlighting of current line
set nocursorline
" ignore case when completing filenames
set fileignorecase
" uninterrupted line between splits
set fillchars=vert:│
" disable folding
set foldmethod=manual
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
" if quickfix list jump wants to go to a file that is already open in a split,
" switch to that split instead of opening the file in the current split
set switchbuf=useopen
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
" configure spell checking
set spell
set spellcapcheck=
set spellfile=~/.config/nvim/spell/en.utf-8.add,~/.config/nvim/spell/local.en.utf-8.add
" enable nvim live substitution
set inccommand=split