" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Ex: Plug 'junegunn/vim-easy-align'

Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-surround'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'kshenoy/vim-signature'
Plug 'elmcast/elm-vim'
Plug 'ianks/vim-tsx'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install({'tag':1})}}

" Initialize plugin system
call plug#end()

" Escape from insert mode with 'jj'
inoremap jj <ESC>

" Easier tab usage
:nmap :t :tabedit<Space>
nnoremap <C-H> gT
nnoremap <C-L> gt

" Split React component into newlines with CTRL+K
" Note that the '\|' must be escaped twice for some reason
:nmap <C-K> :.s /\(<[a-zA-Z0-9]\+\\|[}']\)\s\([^\/]\)/\1\r  \2/g <CR>

" Replace spaces inside curly brackets with returns
:nmap <C-K>K :s/{[^{]*}/\=substitute(submatch(0), ' ', '\r  ', 'g')/g <CR>

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

set background=dark
colorscheme palenight

" coc.nvim settings__________________________________
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>

let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'
