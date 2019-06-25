" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Ex: Plug 'junegunn/vim-easy-align'

Plug 'drewtempelmeyer/palenight.vim'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic' " For eslint integration
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'kshenoy/vim-signature'

" Initialize plugin system
call plug#end()

" Escape from insert mode with 'jj'
inoremap jj <ESC>

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

" Syntastic / eslint integration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'npm run lintfile --'

function! SyntasticCheckHook(errors)
  if !empty(a:errors)
    let g:syntastic_loc_list_height = min([len(a:errors), 5])
  endif
endfunction

" Show spaces as characters
set list listchars=tab:>-,space:·

" Gitgutter
" Set update time to less than default 4 seconds
set updatetime=200

" 'import {name} from {path}' includes a filepath
set include=from

set background=dark
colorscheme palenight
