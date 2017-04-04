" Vundle stuff
filetype off
if isdirectory(expand("~/.vim/bundle/vundle/"))
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'AndrewRadev/linediff.vim'
    Bundle 'bkad/CamelCaseMotion'
    Bundle 'breuckelen/vim-resize'
    Bundle 'ctrlpvim/ctrlp.vim'
    Bundle 'davidhalter/jedi-vim'
    Bundle 'editorconfig/editorconfig-vim'
    Bundle 'ervandew/supertab'
    Bundle 'fisadev/vim-isort'
    Bundle 'gmarik/vundle'
    Bundle 'junegunn/vim-easy-align'
    Bundle 'lokaltog/vim-easymotion'
    Bundle 'michaeljsmith/vim-indent-object'
    Bundle 'mileszs/ack.vim'
    Bundle 'mitsuhiko/vim-jinja'
    Bundle 'rickhowe/diffchar.vim'
    Bundle 'sblask/vim-airline-themes'
    Bundle 'scrooloose/syntastic'
    Bundle 'sheerun/vim-polyglot'
    Bundle 'terryma/vim-multiple-cursors'
    Bundle 'tmux-plugins/vim-tmux'
    Bundle 'tmux-plugins/vim-tmux-focus-events'
    Bundle 'tpope/vim-commentary'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-unimpaired'
    Bundle 'vim-airline/vim-airline'
    Bundle 'vim-scripts/AnsiEsc.vim'
endif
filetype plugin indent on

let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev ag Gcd <bar> Ack!

let g:airline_extensions = ['ctrlp', 'syntastic', 'tabline']
let g:airline#extensions#default#layout = [
\    [ 'a', 'c' ],
\    [ 'z' ],
\ ]
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_section_c = airline#section#create_left(['%{getcwd()}', '%n: %f'])
let g:airline_section_z = '%l/%L : %c'
let g:airline_theme = 'luna'

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
let g:jedi#show_call_signatures = 0
let g:jedi#use_tabs_not_buffers = 0

let g:multi_cursor_exit_from_insert_mode=0

" have tree view enabled be default (:Vexplore)
let g:netrw_liststyle=3
" open document to the right of the browser
let g:netrw_browse_split=4

let g:polyglot_disabled = ['jinja', 'tmux']

let g:SuperTabDefaultCompletionType = "context"

let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_echo_current_error = 1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_javascript_checkers = ['eslint', 'jscs']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '✗'
let g:syntastic_warning_symbol = '✗'

let g:vim_resize_disable_auto_mappings = 1
