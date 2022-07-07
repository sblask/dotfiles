scriptencoding utf-8

call plug#begin('~/.config/nvim/plugged')
    Plug 'AndrewRadev/inline_edit.vim'
    Plug 'AndrewRadev/linediff.vim'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'bkad/CamelCaseMotion'
    Plug 'breuckelen/vim-resize'
    Plug 'dense-analysis/ale'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'ervandew/supertab'
    Plug 'inkarkat/vim-GrepCommands'
    Plug 'inkarkat/vim-QuickFixCurrentNumber'
    Plug 'inkarkat/vim-ingo-library'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'lewis6991/spellsitter.nvim'
    Plug 'mg979/vim-visual-multi'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'mileszs/ack.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'nvim-treesitter/playground'
    Plug 'pearofducks/ansible-vim'
    Plug 'powerman/vim-plugin-AnsiEsc'
    Plug 'rickhowe/diffchar.vim'
    Plug 'shumphrey/fugitive-gitlab.vim'
    Plug 'tmux-plugins/vim-tmux'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tyru/open-browser.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:ackprg = 'rg --color never --column'
cnoreabbrev rg Gcd <bar> Ack!


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
let g:ale_linters = {
\    'clojure': ['clj-kondo'],
\    'python': ['pycodestyle', 'pylint'],
\ }
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '✗'


call camelcasemotion#CreateMotionMappings('<leader>')


let g:fzf_nvim_statusline = 0


let g:netrw_banner = 0 " no header, toggle with I
let g:netrw_liststyle = 3 " tree view
let g:netrw_nogx = 1 " disable gx mapping


nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)


let g:no_QuickFixCurrentNumber_maps = 1


lua require('spellsitter').setup()


let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = '<c-n>'

augroup supertab-chaining
    autocmd!
    autocmd FileType *
                \ if &omnifunc != '' |
                \   call SuperTabChain(&omnifunc, '<c-n>') |
                \ endif
augroup END


let g:VM_maps = {}
let g:VM_maps['Align'] = '<leader>a'
let g:VM_maps['Skip Region'] = '<c-s>'
let g:VM_maps['Remove Region'] = '<c-x>'
let g:VM_maps['Duplicate'] = ''

augroup visual_multi_autocommands
    autocmd!
    autocmd User visual_multi_mappings nmap <buffer> p "+<Plug>(VM-p-Paste)
augroup END
