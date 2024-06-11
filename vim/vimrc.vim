" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Ex: Plug 'junegunn/vim-easy-align'

Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'kshenoy/vim-signature'
Plug 'vimwiki/vimwiki'

" Initialize plugin system
call plug#end()

" Escape from insert mode with 'jj'
inoremap jj <ESC>

" Easier tab usage
:nmap :t :tabedit<Space>
nnoremap <C-H> gT
nnoremap <C-L> gt

" Add row numbers
set number

" And cursor position
set ruler

" Set guidelines at 100 and 120 characters
set colorcolumn=100,120

" Highlight current search term matches
set hlsearch

" Incrementally highlight as you change the search terms
set incsearch

" Toggle smartcase by default
set ignorecase
set smartcase

" Change tabs to spaces by default
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab

" Show spaces as characters
set list listchars=tab:>-,space:·

" Vinegar setting without full plugin
nmap - :Exp <CR>

" Gitgutter
" Set update time to less than default 4 seconds
set updatetime=200

" 'import {name} from {path}' includes a filepath
set include=from

colorscheme palenight

" Change comment color to provide more contrast
hi Comment ctermfg=Yellow

" VimWiki
set nocompatible
" filetype plugin on " Already set
syntax on
