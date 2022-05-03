scriptencoding utf-8

call plug#begin('~/.vim/plugged')
    Plug 'AndrewRadev/inline_edit.vim'
    Plug 'AndrewRadev/linediff.vim'
    Plug 'bkad/CamelCaseMotion'
    Plug 'breuckelen/vim-resize'
    Plug 'dense-analysis/ale'
    Plug 'nathanmsmith/nvim-ale-diagnostic'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'ervandew/supertab'
    Plug 'guns/vim-sexp'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'junegunn/rainbow_parentheses.vim'
    Plug 'majutsushi/tagbar'
    Plug 'mg979/vim-visual-multi'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'mileszs/ack.vim'
    Plug 'mitsuhiko/vim-jinja'
    Plug 'neovim/nvim-lspconfig'
    Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'rickhowe/diffchar.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'shumphrey/fugitive-gitlab.vim'
    Plug 'stefandtw/quickfix-reflector.vim'
    Plug 'suy/vim-context-commentstring'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fireplace'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-sexp-mappings-for-regular-people'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'triglav/vim-visual-increment'
    Plug 'tyru/open-browser.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:ackprg = 'ag --nogroup --nocolor --column'
cnoreabbrev ag Gcd <bar> Ack!


let g:airline_powerline_fonts = 0
let g:airline_theme = 'luna'

let g:airline_extensions = [
\ 'ale',
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


let g:ale_disable_lsp = 1
let g:ale_echo_msg_format = '[%linter%] %s (%code%) [%severity%]'
let g:ale_fixers = {
\    'json': ['fixjson'],
\ }
let g:ale_linters = {
\    'clojure': ['clj-kondo'],
\    'python': ['pycodestyle', 'pylint'],
\ }
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '✗'


call camelcasemotion#CreateMotionMappings('<leader>')

let g:clojure_fuzzy_indent_patterns = [
\    '^def',
\    '^div',
\    '^let',
\    '^with',
\ ]

let g:fzf_nvim_statusline = 0

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

let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_fenced_languages = [
\    'bash=sh',
\    'clojure',
\    'python',
\    'sh',
\ ]


let g:netrw_banner = 0 " no header, toggle with I
let g:netrw_liststyle = 3 " tree view
let g:netrw_nogx = 1 " disable gx mapping

nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

let g:python_highlight_space_errors = 0

let g:rainbow#max_level = 32

let g:sexp_enable_insert_mode_mappings = 0


let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-n>'

augroup supertab-chaining
    autocmd!
    autocmd FileType *
                \ if &omnifunc != '' |
                \   call SuperTabChain(&omnifunc, '<c-n>') |
                \ endif
augroup END

cnoreabbrev tb TagbarToggle

let g:VM_maps = {}
let g:VM_maps['Align'] = '<leader>a'
let g:VM_maps['Skip Region'] = '<c-s>'
let g:VM_maps['Remove Region'] = '<c-x>'
let g:VM_maps['Duplicate'] = ''

augroup visual_multi_autocommands
    autocmd!
    autocmd User visual_multi_mappings nmap <buffer> p "+<Plug>(VM-p-Paste)
augroup END
