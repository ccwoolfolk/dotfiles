" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Ex: Plug 'junegunn/vim-easy-align'

" Initialize plugin system
call plug#end()

" Escape from insert mode with 'jj'
inoremap jj <ESC>

" Add file browser pane to left
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END

" Add row numbers
set number

" And cursor position
set ruler

" Set guidelines at 100 and 120 characters
set colorcolumn=100,120

" Highlight current search term matches
set hlsearch

" Change tabs to spaces by default
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
