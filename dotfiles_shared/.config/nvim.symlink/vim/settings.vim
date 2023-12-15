scriptencoding utf-8

set diffopt= " hopefully better diffs, see https://vimways.org/2018/the-power-of-diff/

set autoindent
set autoread " reload file automatically on focus if unchanged here but changed somewhere else
set completeopt=menuone,noselect
set diffopt+=algorithm:minimal
set diffopt+=context:9999 " disable folding
set diffopt+=filler
set diffopt+=indent-heuristic
set diffopt+=internal
set expandtab
set fileignorecase " ignore case when completing filenames
set foldmethod=manual
set inccommand=split " enable nvim live substitution
set laststatus=3 " only show one statusline
set list listchars=tab:»»,trail:· " show tabs and trailing whitespace
set nobackup " no backup files
set nocursorline " disable highlighting of current line
set nofoldenable " disable folding
set nostartofline " try to keep column when scrolling
set noswapfile
set nrformats=alpha,bin,octal,hex " allow increment/decrement for letters too
set number " show line numbers
set scrolloff=3 " keep three lines at end of the file
set shiftwidth=4
set softtabstop=4
set spell
set spellcapcheck=
set spellfile=~/.config/nvim/spell/en.utf-8.add,~/.config/nvim/spell/local.en.utf-8.add
set splitbelow " horizontal splits are opened below
set splitright " vertical splits are opened to the right
set switchbuf=useopen " if quickfix list jump wants to go to a file that is already open in a split, switch to that split instead of opening the file in the current split
set tabstop=4
set ttimeoutlen=0 " no delay for esc
set wildignore=.git,*.pyc
set wildmenu " enable zsh-like command completion
set wildmode=longest,full
set wrap " wrap long lines
