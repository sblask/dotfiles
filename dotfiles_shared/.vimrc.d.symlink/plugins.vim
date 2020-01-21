scriptencoding utf-8

call plug#begin('~/.vim/plugged')
    Plug 'AndrewRadev/inline_edit.vim'
    Plug 'AndrewRadev/linediff.vim'
    Plug 'bkad/CamelCaseMotion'
    Plug 'breuckelen/vim-resize'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'davidhalter/jedi-vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'ervandew/supertab'
    Plug 'francoiscabrol/ranger.vim'
    Plug 'lokaltog/vim-easymotion'
    Plug 'majutsushi/tagbar'
    Plug 'mg979/vim-visual-multi'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'mileszs/ack.vim'
    Plug 'mitsuhiko/vim-jinja'
    Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'rickhowe/diffchar.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'triglav/vim-visual-increment'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'w0rp/ale'
if has('python') || has('python3')
    Plug 'fisadev/vim-isort'
endif
call plug#end()

let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev ag Gcd <bar> Ack!


let g:airline_powerline_fonts = 0
let g:airline_theme = 'luna'

let g:airline_extensions = [
\ 'ale',
\ 'ctrlp',
\ 'tabline',
\ ]

let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#show_buffers = 1

let g:airline#extensions#default#layout = [
\    [ 'a', 'c' ],
\    [ 'z', 'error', 'warning' ],
\ ]

let g:airline_section_c = airline#section#create_left(['%{getcwd()}', '%n: %f'])
let g:airline_section_z = '%l/%L : %c'


let g:ale_echo_msg_format = '[%linter%] %s (%code%) [%severity%]'
let g:ale_linters = {
\    'ansible': ['yamllint'],
\    'python': ['pycodestyle', 'pylint'],
\ }
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '✗'


call camelcasemotion#CreateMotionMappings('<leader>')


let g:ctrlp_by_filename = 1
let g:ctrlp_extensions = []
let g:ctrlp_use_caching = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files --cached --others --exclude-standard | xargs ls -d 2>/dev/null']

let g:ctrlp_prompt_mappings = {
\    'PrtSelectMove("j")':   ['<s-tab>', '<down>'],
\    'PrtSelectMove("k")':   ['<tab>', '<up>'],
\    'ToggleFocus()':        [],
\    'PrtExpandDir()':       [],
\ }


let g:EasyMotion_keys = 'asdfghjklqwertyuiopzxcvbnm'


let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 0


let g:netrw_banner = 0 " no header, toggle with I
let g:netrw_liststyle = 3 " tree view


let g:polyglot_disabled = ['jinja', 'tmux']

let g:python_highlight_space_errors = 0

let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-n>'

cnoreabbrev tb TagbarToggle

if has('python3')
    let g:vim_isort_python_version = 'python3'
endif

let g:VM_maps = {}
let g:VM_maps['Skip Region'] = '<c-s>'
let g:VM_maps['Remove Region'] = '<c-x>'
let g:VM_maps['Duplicate'] = ''
