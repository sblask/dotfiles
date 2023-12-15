scriptencoding utf-8

call plug#begin('~/.config/nvim/plugged')
    Plug 'AndrewRadev/bufferize.vim'
    Plug 'AndrewRadev/inline_edit.vim'
    Plug 'AndrewRadev/linediff.vim'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'bkad/CamelCaseMotion'
    Plug 'chriskempson/base16-vim'
    Plug 'editorconfig/editorconfig-vim'
    Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
    Plug 'inkarkat/vim-GrepCommands'
    Plug 'inkarkat/vim-QuickFixCurrentNumber'
    Plug 'inkarkat/vim-ingo-library'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'mg979/vim-visual-multi'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'mileszs/ack.vim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'  " for none-ls
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'nvim-treesitter/nvim-treesitter-context'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'nvim-treesitter/playground'
    Plug 'nvimtools/none-ls.nvim'
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
    Plug 'wsdjeg/vim-fetch'
call plug#end()

let g:ackprg = 'rg --color never --column'
cnoreabbrev rg Gcd <bar> Ack!


let g:airline_powerline_fonts = 0
let g:airline_theme = 'luna'

let g:airline_extensions = [
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


let g:ansible_ftdetect_filename_regex = 'ignore-filenames'


let base16colorspace=256

function! s:base16_customize() abort
  "             group,                           guifg,          guibg,          ctermfg,          ctermbg,          attr

  call Base16hi('Cursor',                        '',             g:base16_gui09, '',               g:base16_cterm09)
  call Base16hi('DiffText',                      g:base16_gui09, '',             g:base16_cterm09, '')
  call Base16hi('FoldColumn',                    '',             g:base16_gui00, '',               g:base16_cterm00)
  call Base16hi('LineNr',                        '',             g:base16_gui00, '',               g:base16_cterm00)
  call Base16hi('MatchParen',                    '',             g:base16_gui00, '',               g:base16_cterm00, 'underline')
  call Base16hi('SignColumn',                    '',             g:base16_gui00, '',               g:base16_cterm00)
  call Base16hi('SpellBad',                      '',             g:base16_gui00, '',               g:base16_cterm00, 'undercurl')
  call Base16hi('TreesitterContext',             '',             g:base16_gui01, '',               g:base16_cterm01)
  call Base16hi('TreesitterContextLineNumber',   '',             g:base16_gui01, '',               g:base16_cterm01)
  call Base16hi('VertSplit',                     '',             'NONE',         '',               'NONE')

endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

colorscheme base16-eighties


call camelcasemotion#CreateMotionMappings('<leader>')


let g:fzf_nvim_statusline = 0


lua require("lsp_lines").setup()
command! LspLinesToggle :lua require("lsp_lines").toggle()


let g:netrw_banner = 0 " no header, toggle with I
let g:netrw_liststyle = 3 " tree view
let g:netrw_nogx = 1 " disable gx mapping


nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)


let g:no_QuickFixCurrentNumber_maps = 1


let g:VM_maps = {}
let g:VM_maps['Align'] = '<leader>a'
let g:VM_maps['Duplicate'] = ''
let g:VM_maps['Find Subword Under'] = '' " unset this to make VMVisualBlock work
let g:VM_maps['Remove Region'] = '<c-x>'
let g:VM_maps['Skip Region'] = '<c-s>'

function VMVisualBlock() abort
    if mode() ==# ''
        return "\<Plug>(VM-Visual-Cursors)"
    else
        return "\<Plug>(VM-Find-Subword-Under)"
    endif
endfunction
xmap <expr> <c-n> VMVisualBlock()

augroup visual_multi_autocommands
    autocmd!
    autocmd User visual_multi_mappings nmap <buffer> p "+<Plug>(VM-p-Paste)
augroup END
